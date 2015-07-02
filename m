Content-Type: multipart/mixed; boundary="===============6385332886253066783=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] AcpiXtract: fix warning on int printed with
 %u	specifier
Date: Thu, 02 Jul 2015 13:23:49 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37D309678@ORSMSX112.amr.corp.intel.com>
In-Reply-To: 1435734101-5185-1-git-send-email-colin.king@canonical.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6385332886253066783==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Got it, thanks.


> -----Original Message-----
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Colin King
> Sent: Wednesday, July 01, 2015 12:02 AM
> To: devel(a)acpica.org
> Subject: [Devel] [PATCH] AcpiXtract: fix warning on int printed with %u
> specifier
> =

> From: Colin Ian King <colin.king(a)canonical.com>
> =

> A signed integer is being printed using %u.  Since the integer is never
> going to be negative, make it unsigned and this also cleans up the warning
> found by static analysis:
> =

> [source/tools/acpixtract/acpixtract.c:819]: (warning) %u in
>   format string (no. 1) requires 'unsigned int' but the argument
>   type is 'int'.
> =

> Signed-off-by: Colin Ian King <colin.king(a)canonical.com>
> ---
>  source/tools/acpixtract/acpixtract.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/source/tools/acpixtract/acpixtract.c
> b/source/tools/acpixtract/acpixtract.c
> index fa2cb5a..7e961ff 100644
> --- a/source/tools/acpixtract/acpixtract.c
> +++ b/source/tools/acpixtract/acpixtract.c
> @@ -738,7 +738,7 @@ AxListTables (
>      FILE                    *InputFile;
>      size_t                  HeaderSize;
>      unsigned char           Header[48];
> -    int                     TableCount =3D 0;
> +    unsigned int            TableCount =3D 0;
>      ACPI_TABLE_HEADER       *TableHeader =3D (ACPI_TABLE_HEADER *) (void=
 *)
> Header;
> =

> =

> --
> 2.1.4
> =

> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============6385332886253066783==--

