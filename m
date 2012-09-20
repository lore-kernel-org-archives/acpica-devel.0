Content-Type: multipart/mixed; boundary="===============4717907124017039947=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: Re: [Devel] [patch 7/6] Fix Itanium build - v2
Date: Thu, 20 Sep 2012 04:34:26 +0200
Message-ID: <201209200434.27090.trenn@suse.de>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E346B6474B@ORSMSX101.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4717907124017039947==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wednesday 19 September 2012 19:14:32 Moore, Robert wrote:
> Can you just add the new case to the rules in Makefile.common?
No, at least I can't see a nice way to do so.
 =

> #
> # Main rule will only generate versions that are appropriate for the runn=
ing
> # OS, either 64-bit or 32-bit.
> #
> all:	${PROGS}
> ${PROGS}: FORCE
> 	@cd $(BUILD_DIRECTORY_PATH)/$@; \
> 	if [ $(BITS) -eq 32 ]; then \
> 		echo "Forced 32-bit generation of $@"; \
> 		mkdir -p obj32; \
> 		make BITS=3D32; \
> 		echo "32-bit version of $@:"; \
> 		ls -al ../bin32/$@; \
> 	elif [ $(findstring 64,$(HARDWARE_NAME)) ]; then \
The ia64 case should match this condition already.
But the variable:
BITSFLAG =3D   -m$(BITS)
is not touched here.
Whatever you do here one would always get a:
-mX
option added to the compiler flags by:
BITSFLAG =3D   -m$(BITS)
in the other Makefile (.config)

-m32 and -m64 does exist for PPC/Sparc/x86 gcc versions, but it does not
exist for Itanium or ARM or other architectures.

I can't see a much cleaner way than my previous patch (see at
the end of the mail).

I wonder why the extra complexity to be able to compile 32- and
64- bit together was made. The code could be shorter/nicer if this
is not needed.
It should be possible to provide something like:
make OPT_CFLAGS=3D-m32 OPT_LDFLAGS=3D-m32
if it's really necessary (what for?) to be able to compile a 32
bit version on a 64 bit system.

I guess I do not want to try this out without knowing
the background.

       Thomas



> 		mkdir -p obj64; \
> 		make BITS=3D64; \
> 		echo "64-bit version of $@:"; \
> 		ls -al ../bin64/$@; \
> 	else \
> 		mkdir -p obj32; \
> 		make BITS=3D32; \
> 		echo "32-bit version of $@:"; \
> 		ls -al ../bin32/$@; \
> 	fi;
> =

> =

> =

> =

> > -----Original Message-----
> > From: Thomas Renninger [mailto:trenn(a)suse.de]
> > Sent: Wednesday, September 19, 2012 8:58 AM
> > To: Moore, Robert
> > Cc: devel(a)acpica.org
> > Subject: Re: [Devel] [patch 7/6] Fix Itanium build - v2
> > =

> > On Wednesday, September 19, 2012 05:32:46 PM Moore, Robert wrote:
> > > Makefile.common already contains this line, you may be able to use
> > > $(HARDWARE_NAME)
> > >
> > > HARDWARE_NAME :=3D $(shell uname -m)
> > I tried that, but it did not work out.
> > It's because the order of the including in the main makefile:
> > =

> > include Makefile.config
> > include Makefile.common
> > =

> > Below patch works:
> > =

> > acpica: IA64 does not know about -m64
> > =

> > Otherwise you get on Itanium:
> > gcc: error: unrecognized command line option '-m64'
> > =

> > Signed-off-by: Thomas Renninger <trenn(a)suse.de>
> > =

> > ---
> >  generate/unix/Makefile.common |    1 -
> >  generate/unix/Makefile.config |    6 +++++-
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> > =

> > Index: acpica-unix-20120913/generate/unix/Makefile.config
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- acpica-unix-20120913.orig/generate/unix/Makefile.config
> > +++ acpica-unix-20120913/generate/unix/Makefile.config
> > @@ -35,9 +35,13 @@ CC =3D    gcc
> >  #
> >  # Common defines
> >  #
> > +HARDWARE_NAME :=3D $(shell uname -m)
> > +
> >  OBJDIR =3D     obj$(BITS)
> >  BINDIR =3D     bin$(BITS)
> > -BITSFLAG =3D   -m$(BITS)
> > +ifneq (${HARDWARE_NAME},ia64)
> > +	BITSFLAG =3D   -m$(BITS)
> > +endif
> >  COMPILEOBJ =3D $(CC) -c $(CFLAGS) -o$@ $<
> >  LINKPROG =3D   $(CC) $(OBJECTS) -o $(PROG) $(LDFLAGS)
> >  INSTALLDIR =3D /usr/bin
> > Index: acpica-unix-20120913/generate/unix/Makefile.common
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- acpica-unix-20120913.orig/generate/unix/Makefile.common
> > +++ acpica-unix-20120913/generate/unix/Makefile.common
> > @@ -6,7 +6,6 @@
> >  # Get the OS machine architecture. Anything with a "64" in the returne=
d  #
> > string will be treated as a 64-bit OS. Otherwise, the default is 32-bit.
> >  #
> > -HARDWARE_NAME :=3D $(shell uname -m)
> >  BITS=3D0
> > =

> >  #
> =



--===============4717907124017039947==--

