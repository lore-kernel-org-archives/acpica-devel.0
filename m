Content-Type: multipart/mixed; boundary="===============0513303282550912448=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH 06/11] drivers: acpi: Add appropriate ifdef
 conditions in exdump.c
Date: Wed, 18 Dec 2013 06:31:22 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E8802498846@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 150a5858e78dc6eabfa11b5d52ce97998b807225.1387271324.git.rashika.kheria@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0513303282550912448==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I think this patch is useless.
It is possible to include dump code into Linux kernel for debugging purpose=
s.
Thus we should do cleanup in different way for them.

Thanks
-Lv

> From: Rashika Kheria [mailto:rashika.kheria(a)gmail.com]
> Sent: Tuesday, December 17, 2013 5:24 PM
> =

> Enclose functions acpi_ex_dump_namespace_node() and
> acpi_ex_dump_object_descriptor() in appropriate ifdef condition of
> ACPI_FUTURE_USAGE in file acpica/exdump.c.
> =

> This eliminates the following warnings in exdump.c:
> drivers/acpi/acpica/exdump.c:809:6: warning: no previous prototype for =
=E2=80=98acpi_ex_dump_namespace_node=E2=80=99 [-Wmissing-prototypes]
> drivers/acpi/acpica/exdump.c:995:1: warning: no previous prototype for =
=E2=80=98acpi_ex_dump_object_descriptor=E2=80=99 [-Wmissing-prototypes]
> =

> Signed-off-by: Rashika Kheria <rashika.kheria(a)gmail.com>
> Reviewed-by: Josh Triplett <josh(a)joshtriplett.org>
> ---
>  drivers/acpi/acpica/exdump.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> =

> diff --git a/drivers/acpi/acpica/exdump.c b/drivers/acpi/acpica/exdump.c
> index 4d046fa..3cd2817 100644
> --- a/drivers/acpi/acpica/exdump.c
> +++ b/drivers/acpi/acpica/exdump.c
> @@ -54,6 +54,7 @@ ACPI_MODULE_NAME("exdump")
>   * The following routines are used for debug output only
>   */
>  #if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DEBUGGER)
> +#ifdef  ACPI_FUTURE_USAGE
>  /* Local prototypes */
>  static void acpi_ex_out_string(char *title, char *value);
> =

> @@ -68,6 +69,7 @@ static void acpi_ex_dump_reference_obj(union acpi_opera=
nd_object *obj_desc);
>  static void
>  acpi_ex_dump_package_obj(union acpi_operand_object *obj_desc,
>  			 u32 level, u32 index);
> +#endif
> =

>  /***********************************************************************=
********
>   *
> @@ -210,6 +212,7 @@ static struct acpi_exdump_info acpi_ex_dump_bank_fiel=
d[5] =3D {
>  	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(bank_field.bank_obj), "Bank Object"}
>  };
> =

> +#ifdef  ACPI_FUTURE_USAGE
>  static struct acpi_exdump_info acpi_ex_dump_index_field[5] =3D {
>  	{ACPI_EXD_INIT, ACPI_EXD_TABLE_SIZE(acpi_ex_dump_bank_field), NULL},
>  	{ACPI_EXD_FIELD, 0, NULL},
> @@ -218,6 +221,7 @@ static struct acpi_exdump_info acpi_ex_dump_index_fie=
ld[5] =3D {
>  	 "Index Object"},
>  	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(index_field.data_obj), "Data Object"}
>  };
> +#endif
> =

>  static struct acpi_exdump_info acpi_ex_dump_reference[8] =3D {
>  	{ACPI_EXD_INIT, ACPI_EXD_TABLE_SIZE(acpi_ex_dump_reference), NULL},
> @@ -287,6 +291,7 @@ static struct acpi_exdump_info acpi_ex_dump_node[5] =
=3D {
> =

>  /* Dispatch table, indexed by object type */
> =

> +#ifdef  ACPI_FUTURE_USAGE
>  static struct acpi_exdump_info *acpi_ex_dump_info[] =3D {
>  	NULL,
>  	acpi_ex_dump_integer,
> @@ -444,6 +449,7 @@ acpi_ex_dump_object(union acpi_operand_object *obj_de=
sc,
>  		count--;
>  	}
>  }
> +#endif
> =

>  /***********************************************************************=
********
>   *
> @@ -785,6 +791,7 @@ acpi_ex_dump_operands(union acpi_operand_object **ope=
rands,
>   *
>   ***********************************************************************=
*******/
> =

> +#ifdef  ACPI_FUTURE_USAGE
>  static void acpi_ex_out_string(char *title, char *value)
>  {
>  	acpi_os_printf("%20s : %s\n", title, value);
> @@ -1042,5 +1049,6 @@ acpi_ex_dump_object_descriptor(union acpi_operand_o=
bject *obj_desc, u32 flags)
>  	acpi_ex_dump_object(obj_desc, acpi_ex_dump_info[obj_desc->common.type]);
>  	return_VOID;
>  }
> +#endif
> =

>  #endif
> --
> 1.7.9.5


--===============0513303282550912448==--

