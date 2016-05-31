Content-Type: multipart/mixed; boundary="===============8171605444377363128=="
MIME-Version: 1.0
From: Hanjun Guo <hanjun.guo at linaro.org>
Subject: Re: [Devel] [PATCH v7 13/15] ACPI / processor: Add
 acpi_map_madt_entry().
Date: Tue, 31 May 2016 13:05:37 +0000
Message-ID: <574D8C09.3030608@linaro.org>
In-Reply-To: 1464129345-18985-14-git-send-email-ddaney.cavm@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8171605444377363128==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 2016/5/25 6:35, David Daney wrote:
> From: David Daney <david.daney(a)cavium.com>
>
> Follow-on arm64 ACPI/NUMA patches need to map MADT entries very early
> (before kmalloc is usable).
>
> Add acpi_map_madt_entry() which, indirectly, uses
> early_memremap()/early_memunmap() to access the table and parse out
> the mpidr.  The existing implementation of map_madt_entry() is
> modified to take a pointer to the MADT as a parameter and the callers
> adjusted.
>
> Signed-off-by: David Daney <david.daney(a)cavium.com>
> ---
>   drivers/acpi/processor_core.c | 26 ++++++++++++++++++++++----
>   include/acpi/processor.h      |  1 +
>   2 files changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
> index 33a38d6..9125d7d 100644
> --- a/drivers/acpi/processor_core.c
> +++ b/drivers/acpi/processor_core.c
> @@ -108,13 +108,12 @@ static int map_gicc_mpidr(struct acpi_subtable_head=
er *entry,
>   	return -EINVAL;
>   }
>
> -static phys_cpuid_t map_madt_entry(int type, u32 acpi_id)
> +static phys_cpuid_t map_madt_entry(struct acpi_table_madt *madt,
> +				   int type, u32 acpi_id)
>   {
>   	unsigned long madt_end, entry;
>   	phys_cpuid_t phys_id =3D PHYS_CPUID_INVALID;	/* CPU hardware ID */
> -	struct acpi_table_madt *madt;
>
> -	madt =3D get_madt_table();
>   	if (!madt)
>   		return phys_id;
>
> @@ -145,6 +144,25 @@ static phys_cpuid_t map_madt_entry(int type, u32 acp=
i_id)
>   	return phys_id;
>   }
>
> +phys_cpuid_t __init acpi_map_madt_entry(u32 acpi_id)
> +{
> +	struct acpi_table_madt *madt =3D NULL;
> +	acpi_size tbl_size;
> +	phys_cpuid_t rv;
> +
> +	acpi_get_table_with_size(ACPI_SIG_MADT, 0,
> +				 (struct acpi_table_header **)&madt,
> +				 &tbl_size);
> +	if (!madt)
> +		return PHYS_CPUID_INVALID;
> +
> +	rv =3D map_madt_entry(madt, 1, acpi_id);

Just nit-pick, pass 1 here means we need to define an acpi processor
device object in DSDT (see function map_gicc_mpidr(),
device_declaration), it would be fine for x2apic and gic mode,
but not for lapic mode, since the function name is acpi_map_madt_entry
which is general for all architecture, it will confuse people I think.

How about rename acpi_map_madt_entry() to acpi_map_madt_gicc_entry()?
It's only used for AMR64 to get mpidrs from GICC entries using acpi_id,
other than that, it's good to me.

Thanks
Hanjun

--===============8171605444377363128==--

