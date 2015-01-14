Content-Type: multipart/mixed; boundary="===============6351737979108994984=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: tbinstal: Remove unused function
Date: Wed, 14 Jan 2015 08:49:51 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88026B7443@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 1421174925-5796-1-git-send-email-rickard_strandqvist@spectrumdigital.se
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6351737979108994984==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Rickard

This function contains logic that is only correct to iasl.
It seems we can move it to a separate file that can only be linked by iasl =
to avoid releasing this function to the kernel.
Let me do this in the ACPICA upstream.

Thanks
-Lv

> From: Rickard Strandqvist [mailto:rickard_strandqvist(a)spectrumdigital.s=
e]
> Sent: Wednesday, January 14, 2015 2:49 AM
> To: Moore, Robert; Zheng, Lv
> Cc: Rickard Strandqvist; Wysocki, Rafael J; Len Brown; linux-acpi(a)vger.=
kernel.org; devel(a)acpica.org; linux-kernel(a)vger.kernel.org
> Subject: [PATCH] ACPICA: tbinstal: Remove unused function
> =

> Remove the function acpi_tb_store_table() that is not used anywhere.
> =

> This was partially found by using a static code analysis program called c=
ppcheck.
> =

> Signed-off-by: Rickard Strandqvist <rickard_strandqvist(a)spectrumdigital=
.se>
> ---
>  drivers/acpi/acpica/actables.h |    5 -----
>  drivers/acpi/acpica/tbinstal.c |   37 ----------------------------------=
---
>  2 files changed, 42 deletions(-)
> =

> diff --git a/drivers/acpi/acpica/actables.h b/drivers/acpi/acpica/actable=
s.h
> index 1afe46e..7d65cac 100644
> --- a/drivers/acpi/acpica/actables.h
> +++ b/drivers/acpi/acpica/actables.h
> @@ -119,11 +119,6 @@ acpi_tb_install_standard_table(acpi_physical_address=
 address,
>  			       u8 flags,
>  			       u8 reload, u8 override, u32 *table_index);
> =

> -acpi_status
> -acpi_tb_store_table(acpi_physical_address address,
> -		    struct acpi_table_header *table,
> -		    u32 length, u8 flags, u32 *table_index);
> -
>  void acpi_tb_uninstall_table(struct acpi_table_desc *table_desc);
> =

>  void acpi_tb_terminate(void);
> diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinsta=
l.c
> index 755b90c..a998e8c 100644
> --- a/drivers/acpi/acpica/tbinstal.c
> +++ b/drivers/acpi/acpica/tbinstal.c
> @@ -455,43 +455,6 @@ finish_override:
> =

>  /***********************************************************************=
********
>   *
> - * FUNCTION:    acpi_tb_store_table
> - *
> - * PARAMETERS:  address             - Table address
> - *              table               - Table header
> - *              length              - Table length
> - *              flags               - Install flags
> - *              table_index         - Where the table index is returned
> - *
> - * RETURN:      Status and table index.
> - *
> - * DESCRIPTION: Add an ACPI table to the global table list
> - *
> - ***********************************************************************=
*******/
> -
> -acpi_status
> -acpi_tb_store_table(acpi_physical_address address,
> -		    struct acpi_table_header * table,
> -		    u32 length, u8 flags, u32 *table_index)
> -{
> -	acpi_status status;
> -	struct acpi_table_desc *table_desc;
> -
> -	status =3D acpi_tb_get_next_root_index(table_index);
> -	if (ACPI_FAILURE(status)) {
> -		return (status);
> -	}
> -
> -	/* Initialize added table */
> -
> -	table_desc =3D &acpi_gbl_root_table_list.tables[*table_index];
> -	acpi_tb_init_table_descriptor(table_desc, address, flags, table);
> -	table_desc->pointer =3D table;
> -	return (AE_OK);
> -}
> -
> -/***********************************************************************=
********
> - *
>   * FUNCTION:    acpi_tb_uninstall_table
>   *
>   * PARAMETERS:  table_desc          - Table descriptor
> --
> 1.7.10.4


--===============6351737979108994984==--

