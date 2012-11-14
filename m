Content-Type: multipart/mixed; boundary="===============4701689313801319056=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [RESEND] [PATCH 1/2] acpica Makefile: Make it possible
 to	pass additional CFLAGS when invoking make
Date: Wed, 14 Nov 2012 15:43:04 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E346BD9D7F@ORSMSX101.amr.corp.intel.com>
In-Reply-To: 201211141552.29440.trenn@suse.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4701689313801319056==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We have to think about _FORTIFY_SOURCE a bit more because we have had probl=
ems on some hosts with the -O2 flag.

Bob


> -----Original Message-----
> From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On B=
ehalf
> Of Thomas Renninger
> Sent: Wednesday, November 14, 2012 6:52 AM
> To: devel(a)acpica.org
> Subject: [Devel] [RESEND] [PATCH 1/2] acpica Makefile: Make it possible to
> pass additional CFLAGS when invoking make
> =

> acpcia: Make it possible to pass additional CFLAGS when invoking make
> =

> -D_FORTIFY_SOURCE=3D2 without -O2 can cause:
> --
>   /usr/include/features.h:314:4: error: #warning _FORTIFY_SOURCE requires
>   compiling with optimization (-O) [-Werror=3Dcpp]
> --
> Such compiler flags must be able to get passed when invoking make.
> OpenSUSE packages require to build binaries with CLFAGS=3D"$RPM_OPT_FLAGS=
",
> to make sure debuginfo can be obtained, security/optimization/test flags
> of the compiler for the distribution built against are passed, etc.
> =

> This patch differs between:
>   1) Optional CFLAGS (OPT_CFLAGS) which have a sane default:
>      -D_FORTIFY_SOURCE=3D2 -O2 and warning flags
>      These will get replaced if OPT_CFLAGS=3D are passed via
>      make OPT_CFLAGS=3D".." invokation
>   2) Elementary CFLAGS (-I includes, -Dxy, ...) which are
>      mandatory for a successful compile run
> =

> Signed-off-by: Thomas Renninger <trenn(a)suse.de>
> CC: arjan(a)linux.intel.com
> ---
>  generate/unix/Makefile.config |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> =

> Index: acpica-unix2-20120913/generate/unix/Makefile.config
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- acpica-unix2-20120913.orig/generate/unix/Makefile.config
> +++ acpica-unix2-20120913/generate/unix/Makefile.config
> @@ -38,7 +38,7 @@ CC =3D    gcc
>  OBJDIR =3D     obj$(BITS)
>  BINDIR =3D     bin$(BITS)
>  BITSFLAG =3D   -m$(BITS)
> -COMPILEOBJ =3D $(CC) -c $(CFLAGS) $(CWARNINGFLAGS) -o$@ $<
> +COMPILEOBJ =3D $(CC) -c $(CFLAGS) -o$@ $<
>  LINKPROG =3D   $(CC) $(OBJECTS) -o $(PROG) $(LDFLAGS)
>  INSTALLDIR =3D /usr/bin
>  INSTALLPROG =3D install -D ../$(BINDIR)/$(PROG)
> $(DESTDIR)$(INSTALLDIR)/$(PROG) @@ -103,11 +103,15 @@ ACPICA_HEADERS =3D \
> # Common compiler flags. The warning flags in addition to -Wall are not  #
> automatically included in -Wall.
>  #
> +OPT_CFLAGS ?=3D \
> +    -D_FORTIFY_SOURCE=3D2 -O2 \
> +    $(CWARNINGFLAGS)
> +
>  CFLAGS +=3D \
> +    $(OPT_CFLAGS) \
>      $(BITSFLAG) \
>      -D$(HOST) \
>      -D_GNU_SOURCE \
> -    -D_FORTIFY_SOURCE=3D2 \
>      -I$(ACPICA_INCLUDE)
> =

>  LDFLAGS +=3D $(BITSFLAG)

--===============4701689313801319056==--

