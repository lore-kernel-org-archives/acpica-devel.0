Content-Type: multipart/mixed; boundary="===============1810146496756044855=="
MIME-Version: 1.0
From: Richard W.M. Jones <rjones at redhat.com>
Subject: Re: [Devel] [PATCHES] Various fixes for Fedora
Date: Wed, 10 Oct 2012 21:20:50 +0100
Message-ID: <20121010202050.GX24071@rhmail.home.annexia.org>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E346B86339@ORSMSX101.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1810146496756044855==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 10, 2012 at 08:16:36PM +0000, Moore, Robert wrote:
> >Add -fno-strict-aliasing flag since the code does a lot of unsafe type
> punning and it's too difficult to fix all that.
> =

> diff -ur acpica-unix-20100528.old/compiler/Makefile acpica-unix-20100528/=
compiler/Makefile
> --- acpica-unix-20100528.old/compiler/Makefile	2012-10-10 14:26:24.910788=
185 +0200
> +++ acpica-unix-20100528/compiler/Makefile	2012-10-10 14:33:10.570794691 =
+0200
> @@ -125,7 +125,7 @@
>  	../osunixxf.c
>  =

>  NOMAN=3D	YES
> -CFLAGS+=3D -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I=
../include -I../compiler
> +CFLAGS+=3D -Wall -fno-strict-aliasing -O2 -Wstrict-prototypes -D_LINUX -=
DACPI_ASL_COMPILER -I../include -I../compiler
>  =

>  #YACC=3D	yacc
>  YACC=3D	bison
> =

> =

> I think we've been using this to accomplish the same thing in the makefil=
es under acpica/generate/unix:
> =

> =

>     -Wstrict-aliasing=3D0 \

This disables the warning.  My patch (-fno-strict-aliasing) turns off
the optimization itself.

Rich.

-- =

Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjon=
es
New in Fedora 11: Fedora Windows cross-compiler. Compile Windows
programs, test, and build Windows installers. Over 70 libraries supprt'd
http://fedoraproject.org/wiki/MinGW http://www.annexia.org/fedora_mingw

--===============1810146496756044855==--

