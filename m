Content-Type: multipart/mixed; boundary="===============8656697511374392905=="
MIME-Version: 1.0
From: Sudeep Holla <sudeep.holla at arm.com>
Subject: Re: [Devel] [RFC 2/3] arm_pmu: acpi: spe: Add initial MADT/SPE probing
Date: Mon, 11 Feb 2019 15:34:42 +0000
Message-ID: <20190211153442.GA4792@e107155-lin>
In-Reply-To: 20190209004718.3292087-3-jeremy.linton@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8656697511374392905==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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

[Nit] Does it make sense to add _OFFSET in the name ? Otherwise it may
sound like the actual interrupt number than the offset.

Other than that, this looks good to me:

Reviewed-by: Sudeep Holla <sudeep.holla(a)arm.com>

Regards,
Sudeep

--===============8656697511374392905==--

