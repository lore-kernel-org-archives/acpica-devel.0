Content-Type: multipart/mixed; boundary="===============7246732195028337503=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [RESEND] [PATCH 2/2] acpica Makefile: Fixes some minor
 Tab	vs whitespace issues in Makefiles
Date: Wed, 14 Nov 2012 15:33:54 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E346BD9D5F@ORSMSX101.amr.corp.intel.com>
In-Reply-To: 201211141552.37590.trenn@suse.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7246732195028337503==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thomas,

Thanks, we'll integrate these.
Bob


> -----Original Message-----
> From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On B=
ehalf
> Of Thomas Renninger
> Sent: Wednesday, November 14, 2012 6:53 AM
> To: devel(a)acpica.org
> Subject: [Devel] [RESEND] [PATCH 2/2] acpica Makefile: Fixes some minor
> Tab vs whitespace issues in Makefiles
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
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
>=20

--===============7246732195028337503==--

