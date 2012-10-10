Content-Type: multipart/mixed; boundary="===============4190927962173159002=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCHES] Various fixes for Fedora
Date: Wed, 10 Oct 2012 20:16:36 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E346B86339@ORSMSX101.amr.corp.intel.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E346B85199@ORSMSX101.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4190927962173159002==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

>Add -fno-strict-aliasing flag since the code does a lot of unsafe type
punning and it's too difficult to fix all that.

diff -ur acpica-unix-20100528.old/compiler/Makefile acpica-unix-20100528/co=
mpiler/Makefile
--- acpica-unix-20100528.old/compiler/Makefile	2012-10-10 14:26:24.91078818=
5 +0200
+++ acpica-unix-20100528/compiler/Makefile	2012-10-10 14:33:10.570794691 +0=
200
@@ -125,7 +125,7 @@
 	../osunixxf.c
 =

 NOMAN=3D	YES
-CFLAGS+=3D -Wall -O2 -Wstrict-prototypes -D_LINUX -DACPI_ASL_COMPILER -I..=
/include -I../compiler
+CFLAGS+=3D -Wall -fno-strict-aliasing -O2 -Wstrict-prototypes -D_LINUX -DA=
CPI_ASL_COMPILER -I../include -I../compiler
 =

 #YACC=3D	yacc
 YACC=3D	bison


I think we've been using this to accomplish the same thing in the makefiles=
 under acpica/generate/unix:


    -Wstrict-aliasing=3D0 \





> -----Original Message-----
> From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On B=
ehalf
> Of Moore, Robert
> Sent: Wednesday, October 10, 2012 8:51 AM
> To: Richard W.M. Jones; trenn(a)suse.de; Matthew Garrett; devel(a)acpica.=
org
> Cc: Zheng, Lv; Guan, Chao
> Subject: Re: [Devel] [PATCHES] Various fixes for Fedora
> =

> Thanks, we will take a look at integrating these.
> Bob
> =

> =

> > -----Original Message-----
> > From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On
> > Behalf Of Richard W.M. Jones
> > Sent: Wednesday, October 10, 2012 8:43 AM
> > To: trenn(a)suse.de; Matthew Garrett; devel(a)acpica.org
> > Subject: [Devel] [PATCHES] Various fixes for Fedora
> >
> >
> > Here is a laundry-list of patches that fix various compiler warnings
> > in the ACPICA code.
> >
> > 'iasl-pointer-casts.patch' fixes a segfault on ppc64:
> >
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D856856
> >
> > There is also an endianness assumption in the code on ppc64 which I'm
> > still tracking down.
> >
> > Rich.
> >
> > --
> > Richard Jones, Virtualization Group, Red Hat
> > http://people.redhat.com/~rjones Read my programming blog:
> > http://rwmj.wordpress.com Fedora now supports 80 OCaml packages (the
> > OPEN alternative to F#)
> > http://cocan.org/getting_started_with_ocaml_on_red_hat_and_fedora
> _______________________________________________
> Devel mailing list
> Devel(a)acpica.org
> http://lists.acpica.org/listinfo/devel

--===============4190927962173159002==--

