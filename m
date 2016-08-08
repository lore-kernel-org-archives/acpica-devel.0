Content-Type: multipart/mixed; boundary="===============6774762368342483674=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: Remove unnecessary '\n' in the end of
 ACPI_INFO output
Date: Mon, 08 Aug 2016 00:55:54 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BC0AEDE@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 20160806172749.6315-1-kuleshovmail@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6774762368342483674==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> From: Alexander Kuleshov [mailto:kuleshovmail(a)gmail.com]
> Subject: [PATCH] ACPICA: Remove unnecessary '\n' in the end of
> ACPI_INFO output
> =

> as the ACPI_INFO already prints `\n` in the end itself.
[Lv Zheng] =

Looks good.
Acked-by: Lv Zheng <lv.zheng(a)intel.com>
However this patch should go through ACPICA upstream.

Thanks
-Lv

> =

> Signed-off-by: Alexander Kuleshov <kuleshovmail(a)gmail.com>
> ---
>  drivers/acpi/acpica/tbxfload.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfloa=
d.c
> index ac71abc..e7119b7 100644
> --- a/drivers/acpi/acpica/tbxfload.c
> +++ b/drivers/acpi/acpica/tbxfload.c
> @@ -240,7 +240,7 @@ acpi_status acpi_tb_load_namespace(void)
>  	}
> =

>  	if (!tables_failed) {
> -		ACPI_INFO(("%u ACPI AML tables successfully acquired and
> loaded\n", tables_loaded));
> +		ACPI_INFO(("%u ACPI AML tables successfully acquired and
> loaded", tables_loaded));
>  	} else {
>  		ACPI_ERROR((AE_INFO,
>  			    "%u table load failures, %u successful",
> --
> 2.8.0.rc3.1353.gea9bdc0


--===============6774762368342483674==--

