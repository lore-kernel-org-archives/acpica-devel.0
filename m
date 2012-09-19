Content-Type: multipart/mixed; boundary="===============3255713968362038217=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [patch 6/6] acpcia: Fixes some minor Tab vs
 whitespace	issues in Makefiles.
Date: Wed, 19 Sep 2012 15:09:23 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E346B64400@ORSMSX101.amr.corp.intel.com>
In-Reply-To: 20120919111905.944436733@ett.arch.suse.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3255713968362038217==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

OK, thanks.
Bob


> -----Original Message-----
> From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On
> Behalf Of trenn(a)suse.de
> Sent: Wednesday, September 19, 2012 4:15 AM
> To: devel(a)acpica.org
> Subject: [Devel] [patch 6/6] acpcia: Fixes some minor Tab vs whitespace
> issues in Makefiles.
> =

> Signed-off-by: Thomas Renninger <trenn(a)suse.de>
> ---
>  generate/unix/acpibin/Makefile |    2 +-
>  generate/unix/iasl/Makefile    |    6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> =

> Index: acpica-unix2-20120913/generate/unix/acpibin/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- acpica-unix2-20120913.orig/generate/unix/acpibin/Makefile
> +++ acpica-unix2-20120913/generate/unix/acpibin/Makefile
> @@ -27,7 +27,7 @@ HEADERS =3D \
>      $(wildcard $(ACPIBIN)/*.h)
> =

>  OBJECTS =3D \
> -   	$(OBJDIR)/abcompare.o \
> +	$(OBJDIR)/abcompare.o \
>  	$(OBJDIR)/abmain.o \
>  	$(OBJDIR)/utalloc.o \
>  	$(OBJDIR)/utcache.o \
> Index: acpica-unix2-20120913/generate/unix/iasl/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- acpica-unix2-20120913.orig/generate/unix/iasl/Makefile
> +++ acpica-unix2-20120913/generate/unix/iasl/Makefile
> @@ -192,13 +192,13 @@ INTERMEDIATES =3D \
>  	$(OBJDIR)/prparserparse.c
> =

>  MISC =3D \
> -   	$(OBJDIR)/aslcompilerparse.h \
> +	$(OBJDIR)/aslcompilerparse.h \
>  	$(OBJDIR)/aslcompiler.y.h \
>  	$(OBJDIR)/aslcompilerparse.output \
> -   	$(OBJDIR)/dtparserparse.h \
> +	$(OBJDIR)/dtparserparse.h \
>  	$(OBJDIR)/dtparser.y.h \
>  	$(OBJDIR)/dtparserparse.output \
> -   	$(OBJDIR)/prparserparse.h \
> +	$(OBJDIR)/prparserparse.h \
>  	$(OBJDIR)/prparser.y.h \
>  	$(OBJDIR)/prparserparse.output
> =

> =

> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> http://lists.acpica.org/listinfo/devel

--===============3255713968362038217==--

