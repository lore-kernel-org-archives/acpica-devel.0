Content-Type: multipart/mixed; boundary="===============7153606570753617688=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] AcpiExec: Add in missing TableEvents INSTALL and
 UNINSTALL
Date: Mon, 29 Aug 2016 00:42:47 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886A15F84A@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 20160826215409.9843-1-colin.king@canonical.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7153606570753617688==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Colin

Thanks for the good catch!

> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Colin King
> Subject: [Devel] [PATCH] AcpiExec: Add in missing TableEvents INSTALL and=
 UNINSTALL
> =

> From: Colin Ian King <colin.king(a)canonical.com>
> =

> commit ed6a5fbc694f3a27d93014391aa9a6f6fe490461 ("Tables: Add
> new table events indicating table installation/uninstallation") added
> new table events but the TableEvents array was not updated with
> these two new events.  Update TableEvents with the new INSTALL
> and UNINSTALL event types.
> =

> Signed-off-by: Colin Ian King <colin.king(a)canonical.com>
Acked-by: Lv Zheng <lv.zheng(a)intel.com>

Best regards
Lv

> ---
>  source/tools/acpiexec/aehandlers.c | 2 ++
>  1 file changed, 2 insertions(+)
> =

> diff --git a/source/tools/acpiexec/aehandlers.c b/source/tools/acpiexec/a=
ehandlers.c
> index f08ffbe..b52e4d8 100644
> --- a/source/tools/acpiexec/aehandlers.c
> +++ b/source/tools/acpiexec/aehandlers.c
> @@ -187,6 +187,8 @@ static char                *TableEvents[] =3D
>  {
>      "LOAD",
>      "UNLOAD",
> +    "INSTALL",
> +    "UNINSTALL",
>      "UNKNOWN"
>  };
>  #endif /* !ACPI_REDUCED_HARDWARE */
> --
> 2.9.3
> =

> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============7153606570753617688==--

