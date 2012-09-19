Content-Type: multipart/mixed; boundary="===============5180398406721646884=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [patch 5/6] acpica: Fix unused result warning
Date: Wed, 19 Sep 2012 15:10:59 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E346B6442E@ORSMSX101.amr.corp.intel.com>
In-Reply-To: 20120919111905.721940677@ett.arch.suse.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5180398406721646884==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thomas,

Someone also reported something similar against the acpibin utility.

However, I don't see these issue on my system running gcc 4.7.1 -- do you h=
ave any idea why I don't?

Thanks,
Bob


> -----Original Message-----
> From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On
> Behalf Of trenn(a)suse.de
> Sent: Wednesday, September 19, 2012 4:15 AM
> To: devel(a)acpica.org
> Subject: [Devel] [patch 5/6] acpica: Fix unused result warning
> =

> As this is the only place where this warning
> happens:
> 'write', declared with attribute warn_unused_result [-Werror=3Dunused-
> result] it might be worth fixing instead of ignoring.
> =

> Signed-off-by: Thomas Renninger <trenn(a)suse.de>
> ---
>  source/tools/acpisrc/asfile.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> =

> Index: acpica-unix2-20120913/source/tools/acpisrc/asfile.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- acpica-unix2-20120913.orig/source/tools/acpisrc/asfile.c
> +++ acpica-unix2-20120913/source/tools/acpisrc/asfile.c
> @@ -805,7 +805,11 @@ AsPutFile (
>      /* Write the buffer to the file */
> =

>      FileSize =3D strlen (FileBuffer);
> -    write (DestHandle, FileBuffer, FileSize);
> +    if (write (DestHandle, FileBuffer, FileSize) < 0) {
> +        perror ("Could not write to destination file");
> +        close (DestHandle);
> +        return -1;
> +    }
> =

>      close (DestHandle);
> =

> =

> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> http://lists.acpica.org/listinfo/devel

--===============5180398406721646884==--

