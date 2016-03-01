Content-Type: multipart/mixed; boundary="===============4206418752909690457=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH v2 1/3] ACPI/NFIT: Update Control Region Structure
 to comply ACPI 6.1
Date: Tue, 01 Mar 2016 16:03:07 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E44D6E1@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 1456850284.15454.23.camel@hpe.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4206418752909690457==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We have a bunch of macros in include/acmacros.h -- like this:

ACPI_MOVE_16_TO_16(d, s)


> -----Original Message-----
> From: Toshi Kani [mailto:toshi.kani(a)hpe.com]
> Sent: Tuesday, March 01, 2016 8:38 AM
> To: Moore, Robert; rjw(a)rjwysocki.net; Williams, Dan J
> Cc: Zheng, Lv; elliott(a)hpe.com; linux-nvdimm(a)lists.01.org; linux-
> acpi(a)vger.kernel.org; linux-kernel(a)vger.kernel.org; devel(a)acpica.org
> Subject: Re: [PATCH v2 1/3] ACPI/NFIT: Update Control Region Structure to
> comply ACPI 6.1
> =

> On Tue, 2016-03-01 at 15:13 +0000, Moore, Robert wrote:
> >
> > > -----Original Message-----
> > > From: Toshi Kani [mailto:toshi.kani(a)hpe.com]
> > > Sent: Monday, February 22, 2016 1:55 PM
> > > To: rjw(a)rjwysocki.net; Williams, Dan J
> > > Cc: Moore, Robert; Zheng, Lv; elliott(a)hpe.com;
> > > linux-nvdimm(a)lists.01.or g; linux-acpi(a)vger.kernel.org;
> > > linux-kernel(a)vger.kernel.org; devel(a)acpica.org; Toshi Kani
> > > Subject: [PATCH v2 1/3] ACPI/NFIT: Update Control Region Structure
> > > to comply ACPI 6.1
> > >
> > > ACPI 6.1, Table 5-133, updates NVDIMM Control Region Structure as
> > > follows.
> > > =C2=A0- Valid Fields, Manufacturing Location, and Manufacturing Date
> > > =C2=A0=C2=A0=C2=A0are added from reserved range.=C2=A0=C2=A0No change=
 in the structure size.
> > > =C2=A0- IDs defined as SPD values are arrays of bytes.=C2=A0=C2=A0The=
 spec
> > > =C2=A0=C2=A0=C2=A0clarified that they need to be represented as array=
s of bytes
> > > =C2=A0=C2=A0=C2=A0as well.
> > >
> > > This patch makes the following changes to support this update.
> > > =C2=A0- Change 'struct acpi_nfit_control_region' to reflect the updat=
e.
> > > =C2=A0=C2=A0=C2=A0SPD IDs are defined as arrays of bytes, so that the=
y can be
> > > =C2=A0=C2=A0=C2=A0treated in the same way regardless of CPU endiannes=
s and are
> > > =C2=A0=C2=A0=C2=A0not miss-treated as little-endian numeric values.
> >
> >
> > I don't think we are going to start changing the ACPI tables defined
> > in the ACPICA headers because of this. We do in fact have macros for
> > this purpose.
> =

> Can you elaborate what macros you suggest to use for this purpose?
> =

> Thanks,
> -Toshi

--===============4206418752909690457==--

