Content-Type: multipart/mixed; boundary="===============6177520746777852742=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: Re: [Devel] [patch 4/6] --- source/include/platform/aclinux.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
Date: Wed, 19 Sep 2012 14:55:59 +0200
Message-ID: <201209191455.59978.trenn@suse.de>
In-Reply-To: 20120919111905.500896570@ett.arch.suse.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6177520746777852742==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wednesday, September 19, 2012 01:14:45 PM trenn(a)suse.de wrote:
> Index: acpica-unix2-20120518/source/include/platform/aclinux.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- acpica-unix2-20120518.orig/source/include/platform/aclinux.h
> +++ acpica-unix2-20120518/source/include/platform/aclinux.h
> @@ -98,7 +98,7 @@
>  #define COMPILER_DEPENDENT_INT64    long long
>  #define COMPILER_DEPENDENT_UINT64   unsigned long long
>  #define ACPI_USE_NATIVE_DIVIDE
> -#define ACPI_CAST_PTHREAD_T(pthread) ((ACPI_THREAD_ID) (UINT32) (void *)=
 (pthread))
> +#define ACPI_CAST_PTHREAD_T(pthread) ((ACPI_THREAD_ID) (UINT32) (pthread=
))
Robert already stated that it's difficult to make everyone
happy and that the (void *) has explicitly added to make another
user (compiler?) happy.

Please ignore.

The others:
   1/6, 5/6, 6/6
would be nice if they can get applied.

Thanks,

   Thomas

--===============6177520746777852742==--

