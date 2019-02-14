Content-Type: multipart/mixed; boundary="===============2785717365948389734=="
MIME-Version: 1.0
From: Will Deacon <will.deacon at arm.com>
Subject: Re: [Devel] [RFC 2/3] arm_pmu: acpi: spe: Add initial MADT/SPE probing
Date: Thu, 14 Feb 2019 17:11:25 +0000
Message-ID: <20190214171125.GG2475@fuggles.cambridge.arm.com>
In-Reply-To: 20190209004718.3292087-3-jeremy.linton@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2785717365948389734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeremy,

On Fri, Feb 08, 2019 at 06:47:17PM -0600, Jeremy Linton wrote:
> ACPI 6.3 adds additional fields to the MADT GICC
> structure to describe SPE PPI's. We pick these out
> of the cached reference to the madt_gicc structure
> similarly to the core PMU code. We then create a platform
> device referring to the IRQ and let the user/module loader
> decide whether to load the SPE driver.
> =

> Signed-off-by: Jeremy Linton <jeremy.linton(a)arm.com>
> ---
>  arch/arm64/include/asm/acpi.h |  3 ++
>  drivers/perf/arm_pmu_acpi.c   | 67 +++++++++++++++++++++++++++++++++++
>  2 files changed, 70 insertions(+)
> =

> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index 2def77ec14be..f9f9f2eb5d54 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -40,6 +40,9 @@
>  	(!(entry) || (entry)->header.length < ACPI_MADT_GICC_MIN_LENGTH || \
>  	(unsigned long)(entry) + (entry)->header.length > (end))
>  =

> +#define ACPI_MADT_GICC_SPE  (ACPI_OFFSET(struct acpi_madt_generic_interr=
upt, \
> +	spe_overflow_interrupt) + sizeof(u16))
> +
>  /* Basic configuration for ACPI */
>  #ifdef	CONFIG_ACPI
>  pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
> index 0f197516d708..725d413b47dc 100644
> --- a/drivers/perf/arm_pmu_acpi.c
> +++ b/drivers/perf/arm_pmu_acpi.c
> @@ -74,6 +74,71 @@ static void arm_pmu_acpi_unregister_irq(int cpu)
>  	acpi_unregister_gsi(gsi);
>  }
>  =

> +static struct resource spe_resources[] =3D {
> +	{
> +		/* irq */
> +		.flags          =3D IORESOURCE_IRQ,
> +	}
> +};
> +
> +static struct platform_device spe_dev =3D {
> +	.name =3D "arm,spe-v1",
> +	.id =3D -1,
> +	.resource =3D spe_resources,
> +	.num_resources =3D ARRAY_SIZE(spe_resources)
> +};
> +
> +/*
> + * For lack of a better place, hook the normal PMU MADT walk
> + * and create a SPE device if we detect a recent MADT with
> + * a homogeneous PPI mapping.
> + */
> +static int arm_spe_acpi_parse_irqs(void)
> +{
> +	int cpu, ret, irq;
> +	u16 gsi =3D 0;
> +	bool first =3D true;
> +
> +	struct acpi_madt_generic_interrupt *gicc;
> +
> +	/*
> +	 * sanity check all the GICC tables for the same interrupt number
> +	 * for now we only support homogeneous ACPI/SPE machines.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		gicc =3D acpi_cpu_get_madt_gicc(cpu);
> +
> +		if (gicc->header.length < ACPI_MADT_GICC_SPE)
> +			return -ENODEV;
> +
> +		if (first) {
> +			gsi =3D gicc->spe_overflow_interrupt;
> +			if (!gsi)
> +				return -ENODEV;
> +			first =3D false;
> +		} else if (gsi !=3D gicc->spe_overflow_interrupt) {
> +			pr_warn("ACPI: SPE must have homogeneous interrupts\n");
> +			return -EINVAL;
> +		}

Unfortunately, I don't think this is sufficient to detect a homogeneous
system: we'll have to check the MIDRs instead, which is nasty. I would
personally be in favour of enforcing homogeneity for ACPI systems when we
bring up secondary CPUs, but I suspect others would disagree.

Will

--===============2785717365948389734==--

