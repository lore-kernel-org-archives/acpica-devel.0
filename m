Content-Type: multipart/mixed; boundary="===============4499060629477095477=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] eliminate use after free in
 AcpiOsGetNextFilename()
Date: Tue, 19 Nov 2013 16:54:19 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37C7A349E@ORSMSX103.amr.corp.intel.com>
In-Reply-To: 20131119164152.4957.33932.email-sent-by-dnelson@teal
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4499060629477095477==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Could you open a bugzilla on this? Thanks.

https://bugs.acpica.org/


> -----Original Message-----
> From: Devel [mailto:devel-bounces(a)acpica.org] On Behalf Of Dean Nelson
> Sent: Tuesday, November 19, 2013 8:41 AM
> To: devel(a)acpica.org
> Subject: [Devel] [PATCH] eliminate use after free in
> AcpiOsGetNextFilename()
> =

> AcpiOsGetNextFilename() references temp_str in an unlikely error path,
> after having freed the memory allocated for it.
> =

> Signed-off-by: Dean Nelson <dnelson(a)redhat.com>
> ---
>  source/os_specific/service_layers/osunixdir.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> =

> diff --git a/source/os_specific/service_layers/osunixdir.c
> b/source/os_specific/service_layers/osunixdir.c
> index 02b347d..ef2a924 100644
> --- a/source/os_specific/service_layers/osunixdir.c
> +++ b/source/os_specific/service_layers/osunixdir.c
> @@ -239,14 +239,15 @@ AcpiOsGetNextFilename (
>              strcat (temp_str, dir_entry->d_name);
> =

>              err =3D stat (temp_str, &temp_stat);
> -            free (temp_str);
>              if (err =3D=3D -1)
>              {
>                  fprintf (stderr,
>                      "Cannot stat file (should not happen) - %s\n",
>                      temp_str);
> +                free (temp_str);
>                  return (NULL);
>              }
> +            free (temp_str);
> =

>              if ((S_ISDIR (temp_stat.st_mode)
>                  && (ExternalInfo->RequestedFileType =3D=3D REQUEST_DIR_O=
NLY))
> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> https://lists.acpica.org/mailman/listinfo/devel

--===============4499060629477095477==--

