Content-Type: multipart/mixed; boundary="===============6251778444120830977=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA / Interpreter: Remove redundant newline
Date: Wed, 14 Sep 2016 03:09:25 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886A1849D8@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 20160909161253.30952-1-bp@alien8.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6251778444120830977==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The newline is intentional for acpiexec.
So you should fix this issue in acpiexec, aka, in ACPICA upstream.

Thanks
Lv

> From: linux-acpi-owner(a)vger.kernel.org [mailto:linux-acpi-owner(a)vger.=
kernel.org] On Behalf Of Borislav
> Petkov
> Subject: [PATCH] ACPICA / Interpreter: Remove redundant newline
> =

> From: Borislav Petkov <bp(a)suse.de>
> =

> acpi_info() already issues a '\n' so remove it in the call.
> =

> Signed-off-by: Borislav Petkov <bp(a)suse.de>
> Cc: Robert Moore <robert.moore(a)intel.com>
> Cc: Lv Zheng <lv.zheng(a)intel.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki(a)intel.com>
> Cc: Len Brown <lenb(a)kernel.org>
> Cc: linux-acpi(a)vger.kernel.org
> Cc: devel(a)acpica.org
> ---
>  drivers/acpi/acpica/tbxfload.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfloa=
d.c
> index ac71abcd32bb..e7119b7ccd79 100644
> --- a/drivers/acpi/acpica/tbxfload.c
> +++ b/drivers/acpi/acpica/tbxfload.c
> @@ -240,7 +240,7 @@ acpi_status acpi_tb_load_namespace(void)
>  	}
> =

>  	if (!tables_failed) {
> -		ACPI_INFO(("%u ACPI AML tables successfully acquired and loaded\n", ta=
bles_loaded));
> +		ACPI_INFO(("%u ACPI AML tables successfully acquired and loaded", tabl=
es_loaded));
>  	} else {
>  		ACPI_ERROR((AE_INFO,
>  			    "%u table load failures, %u successful",
> --
> 2.10.0
> =

> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo(a)vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--===============6251778444120830977==--

