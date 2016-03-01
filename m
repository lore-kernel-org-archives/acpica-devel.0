Content-Type: multipart/mixed; boundary="===============5186228228186816449=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH v2 1/3] ACPI/NFIT: Update Control Region Structure
 to comply ACPI 6.1
Date: Tue, 01 Mar 2016 17:37:01 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E44D782@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 1456853819.15454.45.camel@hpe.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5186228228186816449==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Toshi Kani [mailto:toshi.kani(a)hpe.com]
> Sent: Tuesday, March 01, 2016 9:37 AM
> To: Moore, Robert; rjw(a)rjwysocki.net; Williams, Dan J
> Cc: Zheng, Lv; elliott(a)hpe.com; linux-nvdimm(a)lists.01.org; linux-
> acpi(a)vger.kernel.org; linux-kernel(a)vger.kernel.org; devel(a)acpica.org
> Subject: Re: [PATCH v2 1/3] ACPI/NFIT: Update Control Region Structure to
> comply ACPI 6.1
> =

> On Tue, 2016-03-01 at 16:03 +0000, Moore, Robert wrote:
> > We have a bunch of macros in include/acmacros.h -- like this:
> >
> > ACPI_MOVE_16_TO_16(d, s)
> =

> There is a problem in using the ACPICA byte-swap macros. =C2=A0ACPI is li=
ttle-
> endian arch, so the macros are set to perform byte-swappings when the CPU
> arch is big-endian. =C2=A0This case, however, is the other way around. =
=C2=A0The
> fields in question are defined & stored as arrays of bytes.

That's not what I see in the ACPI spec. The fields are defined like any oth=
er ACPI table.

Vendor ID 2 6 =

Identifier indicating the vendor of the NVDIMM.
This field shall be set to the value of the NVDIMM SPD Module
Manufacturer ID Code field a with byte 0 set to DDR4 SPD byte
320 and byte 1 set to DDR4 SPD byte 321.

Device ID 2 8
Identifier for the NVDIMM, assigned by the module vendor.
This field shall be set to the value of the NVDIMM SPD Module
Product Identifier field b with byte 0 set to SPD byte 192 and
byte 1 set to SPD byte 193.

Revision ID 2 10 =

Revision of the NVDIMM, assigned by the module vendor.
Byte 1 of this field is reserved.
Byte 0 of this field shall be set to the value of the NVDIMM SPD
Module Revision Code field a (i.e., SPD byte 349).


Etc.


If you treat
> them as multi-bytes numeric values, then you need to byte-swap them when
> the CPU arch is little-endian because arrays of bytes have the same
> addressing as big-endian.
> =

> Another issue is that it is not clear who needs to perform the byte-
> swapping among ACPICA and drivers. =C2=A0If ACPICA, drivers must agree th=
at
> these fields are always treated as multi-bytes numeric values despite of
> the spec. =C2=A0If drivers, we need to make sure that only a single driver
> performs this byte-swapping one time as ACPI tables are global structures.
> =

> I think it is much clearer to define the structure according to the ACPI
> spec.
> =

> Thanks,
> -Toshi
> =

> > > -----Original Message-----
> > > From: Toshi Kani [mailto:toshi.kani(a)hpe.com]
> > > Sent: Tuesday, March 01, 2016 8:38 AM
> > > To: Moore, Robert; rjw(a)rjwysocki.net; Williams, Dan J
> > > Cc: Zheng, Lv; elliott(a)hpe.com; linux-nvdimm(a)lists.01.org; linux-
> > > acpi(a)vger.kernel.org; linux-kernel(a)vger.kernel.org; devel(a)acpic=
a.org
> > > Subject: Re: [PATCH v2 1/3] ACPI/NFIT: Update Control Region
> > > Structure to comply ACPI 6.1
> > >
> > > On Tue, 2016-03-01 at 15:13 +0000, Moore, Robert wrote:
> > > >
> > > > > -----Original Message-----
> > > > > From: Toshi Kani [mailto:toshi.kani(a)hpe.com]
> > > > > Sent: Monday, February 22, 2016 1:55 PM
> > > > > To: rjw(a)rjwysocki.net; Williams, Dan J
> > > > > Cc: Moore, Robert; Zheng, Lv; elliott(a)hpe.com;
> > > > > linux-nvdimm(a)lists.01.or g; linux-acpi(a)vger.kernel.org;
> > > > > linux-kernel(a)vger.kernel.org; devel(a)acpica.org; Toshi Kani
> > > > > Subject: [PATCH v2 1/3] ACPI/NFIT: Update Control Region
> > > > > Structure to comply ACPI 6.1
> > > > >
> > > > > ACPI 6.1, Table 5-133, updates NVDIMM Control Region Structure
> > > > > as follows.
> > > > > =C2=A0- Valid Fields, Manufacturing Location, and Manufacturing D=
ate
> > > > > =C2=A0=C2=A0=C2=A0are added from reserved range.=C2=A0=C2=A0No ch=
ange in the structure
> size.
> > > > > =C2=A0- IDs defined as SPD values are arrays of bytes.=C2=A0=C2=
=A0The spec
> > > > > =C2=A0=C2=A0=C2=A0clarified that they need to be represented as a=
rrays of bytes
> > > > > =C2=A0=C2=A0=C2=A0as well.
> > > > >
> > > > > This patch makes the following changes to support this update.
> > > > > =C2=A0- Change 'struct acpi_nfit_control_region' to reflect the u=
pdate.
> > > > > =C2=A0=C2=A0=C2=A0SPD IDs are defined as arrays of bytes, so that=
 they can be
> > > > > =C2=A0=C2=A0=C2=A0treated in the same way regardless of CPU endia=
nness and are
> > > > > =C2=A0=C2=A0=C2=A0not miss-treated as little-endian numeric value=
s.
> > > >
> > > >
> > > > I don't think we are going to start changing the ACPI tables
> > > > defined in the ACPICA headers because of this. We do in fact have
> > > > macros for this purpose.
> > >
> > > Can you elaborate what macros you suggest to use for this purpose?
> > >
> > > Thanks,
> > > -Toshi
> > N     r  y   b X  =C7=A7v ^ )=DE=BA{.n +    { i b {ay =1D=CA=87=DA=99 ,=
j   f   h   z =1E w
> >
> =

>    j:+v   w j m         zZ+     =DD=A2j"  ! i

--===============5186228228186816449==--

