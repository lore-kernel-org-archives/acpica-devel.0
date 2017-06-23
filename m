Content-Type: multipart/mixed; boundary="===============5341145490068734573=="
MIME-Version: 1.0
From: Lorenzo Pieralisi <lorenzo.pieralisi at arm.com>
Subject: Re: [Devel] [PATCH v9 3/3] iommu/arm-smmu-v3: Add workaround for
 Cavium ThunderX2 erratum #126
Date: Fri, 23 Jun 2017 12:39:30 +0100
Message-ID: <20170623113930.GC28331@red-moon>
In-Reply-To: 1498197485-32008-1-git-send-email-gakula@caviumnetworks.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5341145490068734573==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 23, 2017 at 11:28:05AM +0530, Geetha sowjanya wrote:

[...]

> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -828,6 +828,18 @@ static int __init arm_smmu_v3_count_resources(struct=
 acpi_iort_node *node)
>  	return num_res;
>  }
>  =

> +static bool arm_smmu_v3_is_combined_irq(struct acpi_iort_smmu_v3 *smmu)
> +{
> +	/*
> +	 * Cavium ThunderX2 implementation doesn't not support unique
> +	 * irq line. Use single irq line for all the SMMUv3 interrupts.
> +	 */
> +	if (smmu->model =3D=3D ACPI_IORT_SMMU_V3_CAVIUM_CN99XX)
> +		return true;
> +
> +	return false;
> +}
> +
>  static unsigned long arm_smmu_v3_resource_size(struct acpi_iort_smmu_v3 =
*smmu)
>  {
>  	/*
> @@ -855,26 +867,32 @@ static void __init arm_smmu_v3_init_resources(struc=
t resource *res,
>  	res[num_res].flags =3D IORESOURCE_MEM;
>  =

>  	num_res++;
> -
> -	if (smmu->event_gsiv)
> -		acpi_iort_register_irq(smmu->event_gsiv, "eventq",
> -				       ACPI_EDGE_SENSITIVE,
> -				       &res[num_res++]);
> -
> -	if (smmu->pri_gsiv)
> -		acpi_iort_register_irq(smmu->pri_gsiv, "priq",
> -				       ACPI_EDGE_SENSITIVE,
> -				       &res[num_res++]);
> -
> -	if (smmu->gerr_gsiv)
> -		acpi_iort_register_irq(smmu->gerr_gsiv, "gerror",
> -				       ACPI_EDGE_SENSITIVE,
> -				       &res[num_res++]);
> -
> -	if (smmu->sync_gsiv)
> -		acpi_iort_register_irq(smmu->sync_gsiv, "cmdq-sync",
> +	if (arm_smmu_v3_is_combined_irq(smmu))
> +		acpi_iort_register_irq(smmu->event_gsiv, "combined",
>  				       ACPI_EDGE_SENSITIVE,
>  				       &res[num_res++]);

I think you should add a check to make sure ALL gsiv are the same
in the IORT table, if they are not the combined IRQ must not be
registered.

Ideally we should add a patch that adds a return value to the
iommu_init_resource callback (ie so that we can prevent allocating
the platform device on error return value) but we are late -rc6
and I won't be able to read mailing lists next week so it is a bit
tight, adding the check above should be quick to do.

Lorenzo

> +	else {
> +
> +		if (smmu->event_gsiv)
> +			acpi_iort_register_irq(smmu->event_gsiv, "eventq",
> +					       ACPI_EDGE_SENSITIVE,
> +					       &res[num_res++]);
> +
> +		if (smmu->pri_gsiv)
> +			acpi_iort_register_irq(smmu->pri_gsiv, "priq",
> +					       ACPI_EDGE_SENSITIVE,
> +					       &res[num_res++]);
> +
> +		if (smmu->gerr_gsiv)
> +			acpi_iort_register_irq(smmu->gerr_gsiv, "gerror",
> +					       ACPI_EDGE_SENSITIVE,
> +					       &res[num_res++]);
> +
> +		if (smmu->sync_gsiv)
> +			acpi_iort_register_irq(smmu->sync_gsiv, "cmdq-sync",
> +					       ACPI_EDGE_SENSITIVE,
> +					       &res[num_res++]);
> +	}
>  }
>  =

>  static bool __init arm_smmu_v3_is_coherent(struct acpi_iort_node *node)
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 2dea4a9..fd5a48c 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -605,6 +605,7 @@ struct arm_smmu_device {
>  	struct arm_smmu_priq		priq;
>  =

>  	int				gerr_irq;
> +	int				combined_irq;
>  =

>  	unsigned long			ias; /* IPA */
>  	unsigned long			oas; /* PA */
> @@ -1314,6 +1315,24 @@ static irqreturn_t arm_smmu_gerror_handler(int irq=
, void *dev)
>  	return IRQ_HANDLED;
>  }
>  =

> +static irqreturn_t arm_smmu_combined_irq_thread(int irq, void *dev)
> +{
> +	struct arm_smmu_device *smmu =3D dev;
> +
> +	arm_smmu_evtq_thread(irq, dev);
> +	if (smmu->features & ARM_SMMU_FEAT_PRI)
> +		arm_smmu_priq_thread(irq, dev);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t arm_smmu_combined_irq_handler(int irq, void *dev)
> +{
> +	arm_smmu_gerror_handler(irq, dev);
> +	arm_smmu_cmdq_sync_handler(irq, dev);
> +	return IRQ_WAKE_THREAD;
> +}
> +
>  /* IO_PGTABLE API */
>  static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
>  {
> @@ -2230,18 +2249,9 @@ static void arm_smmu_setup_msis(struct arm_smmu_de=
vice *smmu)
>  	devm_add_action(dev, arm_smmu_free_msis, dev);
>  }
>  =

> -static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
> +static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
>  {
> -	int ret, irq;
> -	u32 irqen_flags =3D IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
> -
> -	/* Disable IRQs first */
> -	ret =3D arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
> -				      ARM_SMMU_IRQ_CTRLACK);
> -	if (ret) {
> -		dev_err(smmu->dev, "failed to disable irqs\n");
> -		return ret;
> -	}
> +	int irq, ret;
>  =

>  	arm_smmu_setup_msis(smmu);
>  =

> @@ -2284,10 +2294,41 @@ static int arm_smmu_setup_irqs(struct arm_smmu_de=
vice *smmu)
>  			if (ret < 0)
>  				dev_warn(smmu->dev,
>  					 "failed to enable priq irq\n");
> -			else
> -				irqen_flags |=3D IRQ_CTRL_PRIQ_IRQEN;
>  		}
>  	}
> +}
> +
> +static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
> +{
> +	int ret, irq;
> +	u32 irqen_flags =3D IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
> +
> +	/* Disable IRQs first */
> +	ret =3D arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
> +				      ARM_SMMU_IRQ_CTRLACK);
> +	if (ret) {
> +		dev_err(smmu->dev, "failed to disable irqs\n");
> +		return ret;
> +	}
> +
> +	irq =3D smmu->combined_irq;
> +	if (irq) {
> +		/*
> +		 * Cavium ThunderX2 implementation doesn't not support unique
> +		 * irq lines. Use single irq line for all the SMMUv3 interrupts.
> +		 */
> +		ret =3D devm_request_threaded_irq(smmu->dev, irq,
> +					arm_smmu_combined_irq_handler,
> +					arm_smmu_combined_irq_thread,
> +					IRQF_ONESHOT,
> +					"arm-smmu-v3-combined-irq", smmu);
> +		if (ret < 0)
> +			dev_warn(smmu->dev, "failed to enable combined irq\n");
> +	} else
> +		arm_smmu_setup_unique_irqs(smmu);
> +
> +	if (smmu->features & ARM_SMMU_FEAT_PRI)
> +		irqen_flags |=3D IRQ_CTRL_PRIQ_IRQEN;
>  =

>  	/* Enable interrupt generation on the SMMU */
>  	ret =3D arm_smmu_write_reg_sync(smmu, irqen_flags,
> @@ -2724,22 +2765,27 @@ static int arm_smmu_device_probe(struct platform_=
device *pdev)
>  		return PTR_ERR(smmu->base);
>  =

>  	/* Interrupt lines */
> -	irq =3D platform_get_irq_byname(pdev, "eventq");
> -	if (irq > 0)
> -		smmu->evtq.q.irq =3D irq;
>  =

> -	irq =3D platform_get_irq_byname(pdev, "priq");
> +	irq =3D platform_get_irq_byname(pdev, "combined");
>  	if (irq > 0)
> -		smmu->priq.q.irq =3D irq;
> +		smmu->combined_irq =3D irq;
> +	else {
> +		irq =3D platform_get_irq_byname(pdev, "eventq");
> +		if (irq > 0)
> +			smmu->evtq.q.irq =3D irq;
>  =

> -	irq =3D platform_get_irq_byname(pdev, "cmdq-sync");
> -	if (irq > 0)
> -		smmu->cmdq.q.irq =3D irq;
> +		irq =3D platform_get_irq_byname(pdev, "priq");
> +		if (irq > 0)
> +			smmu->priq.q.irq =3D irq;
>  =

> -	irq =3D platform_get_irq_byname(pdev, "gerror");
> -	if (irq > 0)
> -		smmu->gerr_irq =3D irq;
> +		irq =3D platform_get_irq_byname(pdev, "cmdq-sync");
> +		if (irq > 0)
> +			smmu->cmdq.q.irq =3D irq;
>  =

> +		irq =3D platform_get_irq_byname(pdev, "gerror");
> +		if (irq > 0)
> +			smmu->gerr_irq =3D irq;
> +	}
>  	/* Probe the h/w */
>  	ret =3D arm_smmu_device_hw_probe(smmu);
>  	if (ret)
> -- =

> 1.7.1
>=20

--===============5341145490068734573==--

