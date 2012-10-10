Content-Type: multipart/mixed; boundary="===============4759133373950577292=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCHES] Various fixes for Fedora
Date: Wed, 10 Oct 2012 20:41:05 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E346B863C1@ORSMSX101.amr.corp.intel.com>
In-Reply-To: 20121010203545.GY24071@rhmail.home.annexia.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4759133373950577292==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Richard W.M. Jones [mailto:rjones(a)redhat.com]
> Sent: Wednesday, October 10, 2012 1:36 PM
> To: Moore, Robert
> Cc: trenn(a)suse.de; Matthew Garrett; devel(a)acpica.org
> Subject: Re: [Devel] [PATCHES] Various fixes for Fedora
> =

> On Wed, Oct 10, 2012 at 08:28:36PM +0000, Moore, Robert wrote:
> > ACPI_CAST_PTR casts via an integral type (ACPI_UINTPTR_T) which can be
> > a different size from the ACPI_PHYSICAL_ADDRESS.  gcc doesn't like
> > this.  The number is really just an int, so just print it using "%d".
> >
> > diff -ur acpica-unix-20100528.old/namespace/nsdump.c acpica-unix-
> 20100528/namespace/nsdump.c
> > --- acpica-unix-20100528.old/namespace/nsdump.c	2010-05-28
> 19:14:40.000000000 +0200
> > +++ acpica-unix-20100528/namespace/nsdump.c	2012-10-10
> 14:38:18.760798740 +0200
> > @@ -353,9 +353,9 @@
> >          {
> >          case ACPI_TYPE_PROCESSOR:
> >
> > -            AcpiOsPrintf ("ID %X Len %.4X Addr %p\n",
> > +            AcpiOsPrintf ("ID %X Len %.4X Addr %d\n",
> >                  ObjDesc->Processor.ProcId, ObjDesc->Processor.Length,
> > -                ACPI_CAST_PTR (void, ObjDesc->Processor.Address));
> > +		ObjDesc->Processor.Address);
> >              break;
> >
> >
> > The reason we end up doing things like this is because "int" is 32
> > bits under most models (LP64, LLP64, and ILP64.) The only model where
> > int becomes a 64-bit value is under ILP64. So really, we have found
> > that the only way to output something that can change from 32-bit to
> > 64-bit automatically (and portably) is to pretend it is a pointer.
> =

> How about using the standardized <inttypes.h>, something like:
> =

>   #include <inttypes.h>
> =

>   #if ACPI_MACHINE_WIDTH =3D=3D 64
>   #define PR_ADDRESS PRIi64
>   #else
>   #define PR_ADDRESS PRIi32
>   #endif
> =

>   //...
> =

>   AcpiOsPrintf ("ID %X Len %.4X Addr %" PR_ADDRESS "\n", ...)
> =


Unfortunately, I don't think that this would be portable enough for ACPICA.=
 We would need to implement our own version(s).







> > What version of gcc are you using? We don't see this issue here with
> > everything up to gcc version 4.7.1
> =

> gcc 4.7.1, but note that the problem was seen on ppc64 (LP64).
> I was a bit surprised too by the warning, since it seemed to be casting
> through the same sized integer (64 bits).
> =

> Rich.
> =

> --
> Richard Jones, Virtualization Group, Red Hat
> http://people.redhat.com/~rjones virt-p2v converts physical machines to
> virtual machines.  Boot with a live CD or over the network (PXE) and turn
> machines into Xen guests.
> http://et.redhat.com/~rjones/virt-p2v

--===============4759133373950577292==--

