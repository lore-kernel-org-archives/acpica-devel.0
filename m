Content-Type: multipart/mixed; boundary="===============1195038994380565344=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA / Interpreter: Remove redundant newline
Date: Wed, 14 Sep 2016 03:11:29 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886A1849EF@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37E4F34E9@ORSMSX110.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1195038994380565344==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> From: linux-acpi-owner(a)vger.kernel.org [mailto:linux-acpi-owner(a)vger.=
kernel.org] On Behalf Of Moore,
> Robert
> David E <david.e.box(a)intel.com>
> Subject: RE: [PATCH] ACPICA / Interpreter: Remove redundant newline
> =

> Well, I never thought I would write a couple lines of code like this, but=
 here is a solution that
> should make everyone happy.
> =

> diff --git a/source/components/tables/tbxfload.c b/source/components/tabl=
es/tbxfload.c
> index 6a937b1..73ee1a2 100644
> --- a/source/components/tables/tbxfload.c
> +++ b/source/components/tables/tbxfload.c
> @@ -334,7 +334,7 @@ AcpiTbLoadNamespace (
>      if (!TablesFailed)
>      {
>          ACPI_INFO ((
> -            "%u ACPI AML tables successfully acquired and loaded\n",
> +            "%u ACPI AML tables successfully acquired and loaded",
>              TablesLoaded));
>      }
>      else
> @@ -348,6 +348,11 @@ AcpiTbLoadNamespace (
>          Status =3D AE_CTRL_TERMINATE;
>      }
> =

> +#ifdef ACPI_APPLICATION
> +    ACPI_DEBUG_PRINT_RAW ((ACPI_DB_INIT, "\n"));
> +#endif
> +
> +

IMO, these lines should be in ACPICA upstream, in a file under tools/acpiex=
ec.

Thanks
Lv

>  UnlockAndExit:
>      (void) AcpiUtReleaseMutex (ACPI_MTX_TABLES);
>      return_ACPI_STATUS (Status);
> =

> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo(a)vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--===============1195038994380565344==--

