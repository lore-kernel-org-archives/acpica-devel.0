Content-Type: multipart/mixed; boundary="===============6931059161868738697=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH 1/1] x86, pmem,
 acpi: Remove excessive ACPI Large Reference Count warnings
Date: Wed, 01 Aug 2018 21:24:19 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B94DEDFF@ORSMSX108.amr.corp.intel.com>
In-Reply-To: 20180801203827.ozkvldizkpsatmg5@hpe.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6931059161868738697==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Russ Anderson [mailto:rja(a)hpe.com]
> Sent: Wednesday, August 1, 2018 1:38 PM
> To: Moore, Robert <robert.moore(a)intel.com>
> Cc: Mike Travis <mike.travis(a)hpe.com>; Schmauss, Erik
> <erik.schmauss(a)intel.com>; Wysocki, Rafael J
> <rafael.j.wysocki(a)intel.com>; Len Brown <lenb(a)kernel.org>; Russ Ander=
son
> <russ.anderson(a)hpe.com>; Dimitri Sivanich <dimitri.sivanich(a)hpe.com>;
> Ross Zwisler <ross.zwisler(a)linux.intel.com>; Williams, Dan J
> <dan.j.williams(a)intel.com>; Verma, Vishal L <vishal.l.verma(a)intel.com=
>;
> Jiang, Dave <dave.jiang(a)intel.com>; linux-acpi(a)vger.kernel.org;
> devel(a)acpica.org; linux-nvdimm(a)lists.01.org; linux-
> kernel(a)vger.kernel.org
> Subject: Re: [PATCH 1/1] x86, pmem, acpi: Remove excessive ACPI Large
> Reference Count warnings
> =

> On Wed, Aug 01, 2018 at 07:49:14PM +0000, Moore, Robert wrote:
> > Are there any actual memory leaks, or this a consequence of the number
> of sockets?
> =

> It is a consequence of the number of sockets.
> It is not an actual memory leak.
> =

> Thanks.
> =

[Moore, Robert] =


It does bother me a bit that there are over 4096 references to a single obj=
ect, however. Could you send us the ACPI dump for the machine?

This issue sounds vaguely familiar though. Perhaps Dan remembers, it was so=
mething about large reference counts and the NFIT/NVDIMM stuff. If so, this=
 has been fixed for some time now.

Bob


> > > -----Original Message-----
> > > From: Mike Travis [mailto:mike.travis(a)hpe.com]
> > > Sent: Monday, July 30, 2018 12:56 PM
> > > To: Moore, Robert <robert.moore(a)intel.com>; Schmauss, Erik
> > > <erik.schmauss(a)intel.com>; Wysocki, Rafael J
> > > <rafael.j.wysocki(a)intel.com>; Len Brown <lenb(a)kernel.org>
> > > Cc: Russ Anderson <russ.anderson(a)hpe.com>; Dimitri Sivanich
> > > <dimitri.sivanich(a)hpe.com>; Ross Zwisler
> > > <ross.zwisler(a)linux.intel.com>; Williams, Dan J
> > > <dan.j.williams(a)intel.com>; Verma, Vishal L
> > > <vishal.l.verma(a)intel.com>; Jiang, Dave <dave.jiang(a)intel.com>;
> > > linux- acpi(a)vger.kernel.org; devel(a)acpica.org;
> > > linux-nvdimm(a)lists.01.org; linux-kernel(a)vger.kernel.org
> > > Subject: [PATCH 1/1] x86, pmem, acpi: Remove excessive ACPI Large
> > > Reference Count warnings
> > >
> > > With the Intel BIOS support for 8 processor sockets with a full
> > > complement of NVDIMMS potentially installable, and there are empty
> > > sockets without NVDIMMS, there is an extremely large amount of the
> > > following warnings:
> > >
> > > ACPI Warning: Large Reference Count (0x1001) in object
> ffff99453fc71750,
> > > 	Type=3D0x0A
> > >
> > > On a 4 socket system with 4 NVDIMMs there were over 6000 of these
> > > warning messages and it has been seem on systems from 4 to 32
> sockets.
> > >
> > > Through some guidance from the BIOS developers and testing, it
> > > appears that simply bumping up the threshold for warnings from
> > > 0x1000 to 0x2000 eliminates these messages.  Changing them to be
> > > ACPI DEBUG messages, or even removing them are other options, but it
> > > would then defeat the purpose of the warnings as the problem would
> effectively be hidden.
> > >
> > > Reviewed-by: Dimitri Sivanich <dimitri.sivanich(a)hpe.com>
> > > Tested-by: Russ Anderson <russ.anderson(a)hpe.com>
> > > Signed-off-by: Mike Travis <mike.travis(a)hpe.com>
> > > ---
> > >  include/acpi/acconfig.h |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > --- linux-4.12.orig/include/acpi/acconfig.h
> > > +++ linux-4.12/include/acpi/acconfig.h
> > > @@ -123,7 +123,7 @@
> > >
> > >  /* Maximum object reference count (detects object deletion issues)
> > > */
> > >
> > > -#define ACPI_MAX_REFERENCE_COUNT        0x1000
> > > +#define ACPI_MAX_REFERENCE_COUNT        0x2000
> > >
> > >  /* Default page size for use in mapping memory for operation
> > > regions */
> > >
> > >
> > > --
> >
> =

> --
> Russ Anderson,  SuperDome Flex Linux Kernel Group Manager HPE - Hewlett
> Packard Enterprise (formerly SGI)  rja(a)hpe.com

--===============6931059161868738697==--

