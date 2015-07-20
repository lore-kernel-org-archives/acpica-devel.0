Content-Type: multipart/mixed; boundary="===============4262424051754176641=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] ACPI: Fix indent for variable declaration
Date: Mon, 20 Jul 2015 00:29:09 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E8802738299@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 12c0c6.1a666.14e9582064a.Coremail.yizhouzhou@ict.ac.cn
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4262424051754176641==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

There is a process to release ACPICA code to the Linux kernel.

ACPICA code -> Linuxized Linux code
We call the differences between the linuxized Linux code and current Linux =
ACPICA code as divergences.

Such indent issues actually doesn't affect this process much and we only ge=
nerate indent fixing patches that can reduce the divergences.
So we do this in another way:
1. During ACPICA release process, if conflicts are found that will cause ne=
w patches to be maintained with human intervention, a pre-requisite indent =
fixing patch will be included by the release.
2. After all ACPICA divergences are reduced, we will run indent to generate=
 a big patch to reduce all indent issues.
3. We will continue to improve the release tools to generate more purified =
"Linuxized linux code", this is not easy as "indent" is not controlled by t=
his project.
Otherwise the indentation issues there are not fixed in order not to genera=
te such small fixes to mess up real stable materials.

Thanks and best regards
-Lv

> -----Original Message-----
> From: Zhouyi Zhou [mailto:yizhouzhou(a)ict.ac.cn]
> Sent: Thursday, July 16, 2015 2:17 PM
> To: Moore, Robert; Zheng, Lv
> Cc: devel(a)acpica.org; Wysocki, Rafael J
> Subject: Fw: [PATCH] ACPI: Fix indent for variable declaration
> =

> -----Original Messages-----
> From: "Zhouyi Zhou" <yizhouzhou(a)ict.ac.cn>
> Sent Time: Wednesday, July 15, 2015
> To: lenb(a)kernel.org, linux-acpi(a)vger.kernel.org, linux-kernel(a)vger.=
kernel.org
> Cc:
> Subject: [PATCH] ACPI: Fix indent for variable declaration
> =

> In function acpi_ns_one_complete_parse, the variable declaration
> aml_length is not correctly indented.
> =

> Signed-off-by: Zhouyi Zhou <yizhouzhou(a)ict.ac.cn>
> ---
>  drivers/acpi/acpica/nsparse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/drivers/acpi/acpica/nsparse.c b/drivers/acpi/acpica/nsparse.c
> index 57a4cfe..802afdc 100644
> --- a/drivers/acpi/acpica/nsparse.c
> +++ b/drivers/acpi/acpica/nsparse.c
> @@ -70,7 +70,7 @@ acpi_ns_one_complete_parse(u32 pass_number,
>  {
>         union acpi_parse_object *parse_root;
>         acpi_status status;
> -       u32 aml_length;
> +       u32 aml_length;
>         u8 *aml_start;
>         struct acpi_walk_state *walk_state;
>         struct acpi_table_header *table;
> --
> 2.4.5
> =

> =

> =

> =

> =

> =

> =

> =



--===============4262424051754176641==--

