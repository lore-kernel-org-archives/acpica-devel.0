Content-Type: multipart/mixed; boundary="===============1702748262038905114=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [patch 7/6] Fix Itanium build - v2
Date: Wed, 19 Sep 2012 15:32:46 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E346B644AF@ORSMSX101.amr.corp.intel.com>
In-Reply-To: 201209191727.59232.trenn@suse.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1702748262038905114==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Makefile.common already contains this line, you may be able to use $(HARDWA=
RE_NAME)

HARDWARE_NAME :=3D $(shell uname -m)



> -----Original Message-----
> From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On
> Behalf Of Thomas Renninger
> Sent: Wednesday, September 19, 2012 8:28 AM
> To: devel(a)acpica.org
> Subject: Re: [Devel] [patch 7/6] Fix Itanium build - v2
> =

> acpica: IA64 does not know about -m64
> =

> Otherwise you get on Itanium:
> gcc: error: unrecognized command line option '-m64'
> =

> Signed-off-by: Thomas Renninger <trenn(a)suse.de>
> =

> ---
>  generate/unix/Makefile.config |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> =

> Index: acpica-unix-20120913/generate/unix/Makefile.config
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- acpica-unix-20120913.orig/generate/unix/Makefile.config
> +++ acpica-unix-20120913/generate/unix/Makefile.config
> @@ -37,7 +37,9 @@ CC =3D    gcc
>  #
>  OBJDIR =3D     obj$(BITS)
>  BINDIR =3D     bin$(BITS)
> -BITSFLAG =3D   -m$(BITS)
> +ifneq ($(shell uname -m),ia64)
> +	BITSFLAG =3D   -m$(BITS)
> +endif
>  COMPILEOBJ =3D $(CC) -c $(CFLAGS) -o$@ $<
>  LINKPROG =3D   $(CC) $(OBJECTS) -o $(PROG) $(LDFLAGS)
>  INSTALLDIR =3D /usr/bin
> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> http://lists.acpica.org/listinfo/devel

--===============1702748262038905114==--

