Content-Type: multipart/mixed; boundary="===============0369105344825153716=="
MIME-Version: 1.0
From: Lorenzo Pieralisi <lorenzo.pieralisi at arm.com>
Subject: Re: [Devel] [PATCH 2/2] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
 erratum 161010801
Date: Tue, 13 Jun 2017 14:13:17 +0100
Message-ID: <20170613131317.GB2868@red-moon>
In-Reply-To: 20170613114829.188036-3-shameerali.kolothum.thodi@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0369105344825153716==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2017 at 12:48:29PM +0100, shameer wrote:
> The HiSilicon erratum 161010801 describes the limitation of HiSilicon
> platforms Hip06/Hip07 to support the SMMU mappings for MSI transactions.
> =

> On these platforms GICv3 ITS translator is presented with the deviceID
> by extending the MSI payload data to 64 bits to include the deviceID.
> Hence, the PCIe controller on this platforms has to differentiate the
> MSI payload against other DMA payload and has to modify the MSI payload.
> This basically makes it difficult for this platforms to have a SMMU
> translation for MSI.
> =

> This patch implements a ACPI table based quirk to reserve the hw msi
> regions in the smmu-v3 driver which means these address regions will
> not be translated and will be excluded from iova allocations.
> =

> Signed-off-by: shameer <shameerali.kolothum.thodi(a)huawei.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> =

> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index abe4b88..2636c85 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -597,6 +597,7 @@ struct arm_smmu_device {
>  	u32				features;
>  =

>  #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
> +#define ARM_SMMU_OPT_RESV_HW_MSI	(1 << 1)
>  	u32				options;
>  =

>  	struct arm_smmu_cmdq		cmdq;
> @@ -1904,14 +1905,29 @@ static void arm_smmu_get_resv_regions(struct devi=
ce *dev,
>  				      struct list_head *head)
>  {
>  	struct iommu_resv_region *region;
> +	struct arm_smmu_device *smmu;
> +	struct iommu_fwspec *fwspec =3D dev->iommu_fwspec;
>  	int prot =3D IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
>  =

> -	region =3D iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
> -					 prot, IOMMU_RESV_SW_MSI);
> -	if (!region)
> -		return;
> +	smmu =3D arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
>  =

> -	list_add_tail(&region->list, head);
> +	if (smmu && (smmu->options & ARM_SMMU_OPT_RESV_HW_MSI) &&
> +		      dev_is_pci(dev)) {
> +		int ret;
> +
> +		ret =3D iort_iommu_its_get_resv_regions(dev, head);

This should be made fwnode dependent, it makes precious little
sense to call IORT to reserve regions on a DT based platforms
(I know the ARM_SMMU_OPT_RESV_HW_MSI option is only selected
in ACPI (?) but comment applies regardless - have you prototyped
a DT version too ?).

Lorenzo

> +		if (ret) {
> +			dev_warn(dev, "HW MSI region reserve failed\n");
> +			return;
> +		}
> +	} else {
> +		region =3D iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
> +						 prot, IOMMU_RESV_SW_MSI);
> +		if (!region)
> +			return;
> +
> +		list_add_tail(&region->list, head);
> +	}
>  =

>  	iommu_dma_get_resv_regions(dev, head);
>  }
> @@ -2611,6 +2627,7 @@ static void parse_driver_acpi_options(struct acpi_i=
ort_smmu_v3 *iort_smmu,
>  	switch (iort_smmu->model) {
>  	case ACPI_IORT_SMMU_HISILICON_HI161X:
>  		smmu->options |=3D ARM_SMMU_OPT_SKIP_PREFETCH;
> +		smmu->options |=3D ARM_SMMU_OPT_RESV_HW_MSI;
>  		break;
>  	default:
>  		break;
> -- =

> 1.9.1
> =

> =

> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo(a)vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--===============0369105344825153716==--

