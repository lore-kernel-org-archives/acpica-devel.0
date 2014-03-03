Content-Type: multipart/mixed; boundary="===============0021659341008381433=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH 2/4] ACPICA: Introduce new
 acpi_os_physical_table_add OS callback
Date: Mon, 03 Mar 2014 01:20:08 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88024BB021@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 1393608241-31037-3-git-send-email-trenn@suse.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0021659341008381433==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Thomas

I have a patch series that can cleanup the ACPICA table manager, and change=
 the acpi_load_table into the following style:

acpi_status acpi_install_table(acpi_physical_address address, char *signatu=
re, u8 flags, bool override);

For the flags parameter, it will be:
ACPI_TABLE_ORIGIN_EXTERNAL_PHYSICAL (renamed from ACPI_TABLE_ORIGIN_UNKNOWN)
ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL (renamed from ACPI_TABLE_ORIGIN_OVERRIDE)
ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL (renamed from ACPI_TABLE_ORIGIN_MAPPED)
ACPI_TABLE_ORIGIN_INTERNAL_LOGICAL (renamed from ACPI_TABLE_ORIGIN_ALLOCATE=
D)

So that we can have the following advantages:

1. the table signature can be validate in one single function.
2. the table checksum can always be validated before installing it to acpi_=
gbl_root_table_list.
3. acpi_os_table_override() and acpi_os_phsycal_table_override() can be mer=
ged
4. for acpi_load_table (renamed to acpi_install_table()) invocations, if it=
 is invoked by OSPM, override can be avoided.
5. part of the acpi_tb_parse_root_table() code can be merged with the acpi_=
load_table() by invoking same installing API with flags specified.

And with this API, you don't have to introduce code into ACPICA to achieve =
acpi_os_physical_table_add().
You only need to invoke an OSPM only initialization step after acpi_initial=
ize_tables(), inside of which, you can invoke acpi_install_table() to insta=
ll new arbitrary tables serving for the purposes of OSPM.
For your cases, I think you can implement the code in this way:

Int __init acpi_table_init(void)
{
	Status =3D acpi_initialize_tables()....
	/* add all tables, if they haven't been overridden, they will be newly ins=
talled */
	for (no =3D 0; no < no_of_overridden_tables; no++) {
		acpi_install_table(the_phsycail_address, NULL, ACPI_TABLE_ORIGIN_EXTERNAL=
_PHYSICAL, false);
	}
}

This function also has been carefully redesigned to ensure:
1. override can avoided for the newly added table.
2. checksum can be verified before adding it to the acpi_gbl_root_table_lis=
t, and it will only be verified once per table.
3. No need to save the table no that has already been physically overridden=
, it will be taken care by the new interfaces.

I can send out the cleanup series for you to confirm.

Thanks and best regards
-Lv


> -----Original Message-----
> From: Thomas Renninger [mailto:trenn(a)suse.de]
> Sent: Saturday, March 01, 2014 1:24 AM
> To: Moore, Robert; Zheng, Lv; Box, David E; Wysocki, Rafael J
> Cc: Thomas Renninger; hpa(a)zytor.com; tglx(a)linutronix.de; ck(a)conrad-=
kostecki.de; linux-kernel(a)vger.kernel.org; x86(a)kernel.org;
> mingo(a)redhat.com; rjw(a)rjwysocki.net; devel(a)acpica.org
> Subject: [PATCH 2/4] ACPICA: Introduce new acpi_os_physical_table_add OS =
callback
> =

> This one allows OS to add arbitrary ACPI tables.
> =

> ToDo: It should get checked whether a table with the same signature alrea=
dy
> exists and if this is the case, adding should not happen.
> =

> Signed-off-by: Thomas Renninger <trenn(a)suse.de>
> CC: hpa(a)zytor.com
> CC: tglx(a)linutronix.de
> CC: ck(a)conrad-kostecki.de
> CC: linux-kernel(a)vger.kernel.org
> CC: x86(a)kernel.org
> CC: mingo(a)redhat.com
> CC: rjw(a)rjwysocki.net
> CC: devel(a)acpica.org
> ---
>  drivers/acpi/acpica/tbutils.c |   36 ++++++++++++++++++++++++++++++++++++
>  include/acpi/acpiosxf.h       |    6 ++++++
>  2 files changed, 42 insertions(+), 0 deletions(-)
> =

> diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
> index 6412d3c..a819d198 100644
> --- a/drivers/acpi/acpica/tbutils.c
> +++ b/drivers/acpi/acpica/tbutils.c
> @@ -453,6 +453,8 @@ static acpi_status acpi_tb_validate_xsdt(acpi_physica=
l_address xsdt_address)
>   *
>   ***********************************************************************=
*******/
> =

> +#define ACPI_MAX_TABLE_ADD 64
> +
>  acpi_status __init acpi_tb_parse_root_table(acpi_physical_address rsdp_a=
ddress)
>  {
>  	struct acpi_table_rsdp *rsdp;
> @@ -623,5 +625,39 @@ acpi_status __init acpi_tb_parse_root_table(acpi_phy=
sical_address rsdp_address)
>  		}
>  	}
> =

> +	/*
> +	 * ACPI Table Add:
> +	 * Allow the OS to add additional tables to the global root table list
> +	 */
> +	for (i =3D 0; i < ACPI_MAX_TABLE_ADD; i++) {
> +		int tmp, k;
> +		table_entry_size =3D 0;
> +		address =3D 0;
> +		status =3D acpi_os_physical_table_add(&address,
> +						    &table_entry_size);
> +		if (status =3D=3D AE_OK && table_entry_size && address) {
> +			table =3D acpi_os_map_memory(address, table_entry_size);
> +			for (k =3D 2; k < acpi_gbl_root_table_list.current_table_count; k++) {
> +				/*
> +				  Always add SSDTs. Only allow adding of other
> +				  tables if none of such a signature already
> +				  exists. Use the override interface instead
> +				  in such a case.
> +				*/
> +				if (ACPI_COMPARE_NAME("SSDT", table->signature) &&
> +				    !ACPI_COMPARE_NAME(&acpi_gbl_root_table_list.tables[i].signature=
, table->signature)) {
> +	ACPI_INFO((AE_INFO, "OS table not added, signature already exists:"));
> +	acpi_tb_print_table_header(address, table);
> +	acpi_os_unmap_memory(table, table_entry_size);
> +				} else {
> +	ACPI_INFO((AE_INFO, "Add OS provided table:"));
> +	acpi_tb_print_table_header(address, table);
> +	status =3D acpi_tb_store_table(address, table, table_entry_size,
> +				     ACPI_TABLE_ORIGIN_MAPPED, &tmp);
> +				}
> +			}
> +		} else
> +			break;
> +	}
>  	return_ACPI_STATUS(AE_OK);
>  }
> diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
> index 01e6c6d..70c00ed 100644
> --- a/include/acpi/acpiosxf.h
> +++ b/include/acpi/acpiosxf.h
> @@ -111,6 +111,12 @@ acpi_os_physical_table_override(struct acpi_table_he=
ader *existing_table,
>  				u32 *new_table_length);
>  #endif
> =

> +#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_physical_table_add
> +acpi_status
> +acpi_os_physical_table_add(acpi_physical_address * new_address,
> +			   u32 *new_table_length);
> +#endif
> +
>  /*
>   * Spinlock primitives
>   */
> --
> 1.7.6.1


--===============0021659341008381433==--

