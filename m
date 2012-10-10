Content-Type: multipart/mixed; boundary="===============8053578107436293504=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCHES] Various fixes for Fedora
Date: Wed, 10 Oct 2012 20:28:36 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E346B86394@ORSMSX101.amr.corp.intel.com>
In-Reply-To: 20121010154258.GT24071@rhmail.home.annexia.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8053578107436293504==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ACPI_CAST_PTR casts via an integral type (ACPI_UINTPTR_T) which can be
a different size from the ACPI_PHYSICAL_ADDRESS.  gcc doesn't like
this.  The number is really just an int, so just print it using "%d".

diff -ur acpica-unix-20100528.old/namespace/nsdump.c acpica-unix-20100528/n=
amespace/nsdump.c
--- acpica-unix-20100528.old/namespace/nsdump.c	2010-05-28 19:14:40.0000000=
00 +0200
+++ acpica-unix-20100528/namespace/nsdump.c	2012-10-10 14:38:18.760798740 +=
0200
@@ -353,9 +353,9 @@
         {
         case ACPI_TYPE_PROCESSOR:
 =

-            AcpiOsPrintf ("ID %X Len %.4X Addr %p\n",
+            AcpiOsPrintf ("ID %X Len %.4X Addr %d\n",
                 ObjDesc->Processor.ProcId, ObjDesc->Processor.Length,
-                ACPI_CAST_PTR (void, ObjDesc->Processor.Address));
+		ObjDesc->Processor.Address);
             break;


The reason we end up doing things like this is because "int" is 32 bits und=
er most models (LP64, LLP64, and ILP64.) The only model where int becomes a=
 64-bit value is under ILP64. So really, we have found that the only way to=
 output something that can change from 32-bit to 64-bit automatically (and =
portably) is to pretend it is a pointer.

What version of gcc are you using? We don't see this issue here with everyt=
hing up to gcc version 4.7.1

Bob


> -----Original Message-----
> From: devel-bounces(a)acpica.org [mailto:devel-bounces(a)acpica.org] On B=
ehalf
> Of Richard W.M. Jones
> Sent: Wednesday, October 10, 2012 8:43 AM
> To: trenn(a)suse.de; Matthew Garrett; devel(a)acpica.org
> Subject: [Devel] [PATCHES] Various fixes for Fedora
> =

> =

> Here is a laundry-list of patches that fix various compiler warnings in
> the ACPICA code.
> =

> 'iasl-pointer-casts.patch' fixes a segfault on ppc64:
> =

> https://bugzilla.redhat.com/show_bug.cgi?id=3D856856
> =

> There is also an endianness assumption in the code on ppc64 which I'm
> still tracking down.
> =

> Rich.
> =

> --
> Richard Jones, Virtualization Group, Red Hat
> http://people.redhat.com/~rjones Read my programming blog:
> http://rwmj.wordpress.com Fedora now supports 80 OCaml packages (the OPEN
> alternative to F#)
> http://cocan.org/getting_started_with_ocaml_on_red_hat_and_fedora

--===============8053578107436293504==--

