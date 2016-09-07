Content-Type: multipart/mixed; boundary="===============3819234891640230342=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] acpisrc: trivial fix to misaligned code
 indentation
Date: Wed, 07 Sep 2016 15:30:27 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E4F2A97@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 20160906100507.2718-1-colin.king@canonical.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3819234891640230342==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Got it, thanks.
Bob


> -----Original Message-----
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Colin King
> Sent: Tuesday, September 6, 2016 3:05 AM
> To: devel(a)acpica.org
> Subject: [Devel] [PATCH] acpisrc: trivial fix to misaligned code
> indentation
> =

> From: Colin Ian King <colin.king(a)canonical.com>
> =

> Insert missing space to correct indentation
> =

> Signed-off-by: Colin Ian King <colin.king(a)canonical.com>
> ---
>  source/tools/acpisrc/asfile.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/source/tools/acpisrc/asfile.c
> b/source/tools/acpisrc/asfile.c index 51d1c69..07830c0 100644
> --- a/source/tools/acpisrc/asfile.c
> +++ b/source/tools/acpisrc/asfile.c
> @@ -393,7 +393,7 @@ AsConvertFile (
>          ConditionalTable    =3D ConversionTable->SourceConditionalTable;
>          StructTable         =3D ConversionTable->SourceStructTable;
>          SpecialMacroTable   =3D ConversionTable->SourceSpecialMacroTable;
> -       break;
> +        break;
> =

>      case FILE_TYPE_HEADER:
> =

> --
> 2.9.3
> =

> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============3819234891640230342==--

