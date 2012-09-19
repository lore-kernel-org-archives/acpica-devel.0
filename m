Content-Type: multipart/mixed; boundary="===============8444386127554037233=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [patch 7/6] Fix Itanium build - v2
Date: Wed, 19 Sep 2012 17:14:32 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E346B6474B@ORSMSX101.amr.corp.intel.com>
In-Reply-To: 201209191758.07700.trenn@suse.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8444386127554037233==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Can you just add the new case to the rules in Makefile.common?

#
# Main rule will only generate versions that are appropriate for the running
# OS, either 64-bit or 32-bit.
#
all:	${PROGS}
${PROGS}: FORCE
	@cd $(BUILD_DIRECTORY_PATH)/$@; \
	if [ $(BITS) -eq 32 ]; then \
		echo "Forced 32-bit generation of $@"; \
		mkdir -p obj32; \
		make BITS=3D32; \
		echo "32-bit version of $@:"; \
		ls -al ../bin32/$@; \
	elif [ $(findstring 64,$(HARDWARE_NAME)) ]; then \
		mkdir -p obj64; \
		make BITS=3D64; \
		echo "64-bit version of $@:"; \
		ls -al ../bin64/$@; \
	else \
		mkdir -p obj32; \
		make BITS=3D32; \
		echo "32-bit version of $@:"; \
		ls -al ../bin32/$@; \
	fi;




> -----Original Message-----
> From: Thomas Renninger [mailto:trenn(a)suse.de]
> Sent: Wednesday, September 19, 2012 8:58 AM
> To: Moore, Robert
> Cc: devel(a)acpica.org
> Subject: Re: [Devel] [patch 7/6] Fix Itanium build - v2
> =

> On Wednesday, September 19, 2012 05:32:46 PM Moore, Robert wrote:
> > Makefile.common already contains this line, you may be able to use
> > $(HARDWARE_NAME)
> >
> > HARDWARE_NAME :=3D $(shell uname -m)
> I tried that, but it did not work out.
> It's because the order of the including in the main makefile:
> =

> include Makefile.config
> include Makefile.common
> =

> Below patch works:
> =

> acpica: IA64 does not know about -m64
> =

> Otherwise you get on Itanium:
> gcc: error: unrecognized command line option '-m64'
> =

> Signed-off-by: Thomas Renninger <trenn(a)suse.de>
> =

> ---
>  generate/unix/Makefile.common |    1 -
>  generate/unix/Makefile.config |    6 +++++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> =

> Index: acpica-unix-20120913/generate/unix/Makefile.config
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- acpica-unix-20120913.orig/generate/unix/Makefile.config
> +++ acpica-unix-20120913/generate/unix/Makefile.config
> @@ -35,9 +35,13 @@ CC =3D    gcc
>  #
>  # Common defines
>  #
> +HARDWARE_NAME :=3D $(shell uname -m)
> +
>  OBJDIR =3D     obj$(BITS)
>  BINDIR =3D     bin$(BITS)
> -BITSFLAG =3D   -m$(BITS)
> +ifneq (${HARDWARE_NAME},ia64)
> +	BITSFLAG =3D   -m$(BITS)
> +endif
>  COMPILEOBJ =3D $(CC) -c $(CFLAGS) -o$@ $<
>  LINKPROG =3D   $(CC) $(OBJECTS) -o $(PROG) $(LDFLAGS)
>  INSTALLDIR =3D /usr/bin
> Index: acpica-unix-20120913/generate/unix/Makefile.common
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- acpica-unix-20120913.orig/generate/unix/Makefile.common
> +++ acpica-unix-20120913/generate/unix/Makefile.common
> @@ -6,7 +6,6 @@
>  # Get the OS machine architecture. Anything with a "64" in the returned =
 #
> string will be treated as a 64-bit OS. Otherwise, the default is 32-bit.
>  #
> -HARDWARE_NAME :=3D $(shell uname -m)
>  BITS=3D0
> =

>  #

--===============8444386127554037233==--

