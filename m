Content-Type: multipart/mixed; boundary="===============5611893305391638490=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH v2 1/3] ACPI: Resolve objects on host-directed
 table loads
Date: Tue, 18 Jun 2019 20:31:52 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B95FB0BA@ORSMSX110.amr.corp.intel.com>
In-Reply-To: alpine.DEB.2.20.1906181030240.24846@fox.voss.local
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5611893305391638490==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Moore, Robert
> Sent: Tuesday, June 18, 2019 1:25 PM
> To: 'Nikolaus Voss' <nv(a)vosn.de>
> Cc: 'Rafael J. Wysocki' <rafael(a)kernel.org>; 'Rafael J. Wysocki'
> <rjw(a)rjwysocki.net>; 'Len Brown' <lenb(a)kernel.org>; Schmauss, Erik
> <erik.schmauss(a)intel.com>; 'Jacek Anaszewski'
> <jacek.anaszewski(a)gmail.com>; 'Pavel Machek' <pavel(a)ucw.cz>; 'Dan
> Murphy' <dmurphy(a)ti.com>; 'Thierry Reding' <thierry.reding(a)gmail.com>;
> 'ACPI Devel Maling List' <linux-acpi(a)vger.kernel.org>; 'open list:ACPI
> COMPONENT ARCHITECTURE (ACPICA)' <devel(a)acpica.org>; 'linux-
> leds(a)vger.kernel.org' <linux-leds(a)vger.kernel.org>; 'Linux PWM List'
> <linux-pwm(a)vger.kernel.org>; 'Linux Kernel Mailing List' <linux-
> kernel(a)vger.kernel.org>
> Subject: RE: [PATCH v2 1/3] ACPI: Resolve objects on host-directed table
> loads
> =

> If it is in fact the AcpiLoadTable interface that is incorrect, that of
> course is different. I'll check that out next.
> =

[Moore, Robert] =


Yes, this is the issue, not specifically the Load() operator, but the AcpiL=
oadTable interface only.

> =

> > -----Original Message-----
> > From: Moore, Robert
> > Sent: Tuesday, June 18, 2019 1:23 PM
> > To: 'Nikolaus Voss' <nv(a)vosn.de>
> > Cc: 'Rafael J. Wysocki' <rafael(a)kernel.org>; 'Rafael J. Wysocki'
> > <rjw(a)rjwysocki.net>; 'Len Brown' <lenb(a)kernel.org>; Schmauss, Erik
> > <erik.schmauss(a)intel.com>; 'Jacek Anaszewski'
> > <jacek.anaszewski(a)gmail.com>; 'Pavel Machek' <pavel(a)ucw.cz>; 'Dan
> > Murphy' <dmurphy(a)ti.com>; 'Thierry Reding' <thierry.reding(a)gmail.co=
m>;
> > 'ACPI Devel Maling List' <linux-acpi(a)vger.kernel.org>; 'open list:ACPI
> > COMPONENT ARCHITECTURE (ACPICA)' <devel(a)acpica.org>; 'linux-
> > leds(a)vger.kernel.org' <linux-leds(a)vger.kernel.org>; 'Linux PWM List'
> > <linux-pwm(a)vger.kernel.org>; 'Linux Kernel Mailing List' <linux-
> > kernel(a)vger.kernel.org>
> > Subject: RE: [PATCH v2 1/3] ACPI: Resolve objects on host-directed
> > table loads
> >
> > It looks to me that the package objects are being initialized properly
> > already, unless I'm missing something. Please check the examples below
> > and in the attached files.
> >
> > Attached is a small test case that dynamically loads an SSDT which
> > contains a package object which in turn contains references to other
> > objects.
> >
> >
> > Main DSDT:
> >     Method (LD1)
> >     {
> >         Load (BUF1, HNDL)      // SSDT is in BUF1
> >         Store (HNDL, Debug)
> >         Return
> >     }
> >
> > Loaded table:
> >     External (DEV1, DeviceObj)
> >     Name (PKG1, Package() {
> >         1,2, DEV2, DEV1, 4})
> >     Device (DEV2) {}
> >
> >
> > AcpiExec Output:
> > - ev ld1
> > Evaluating \LD1
> > ACPI: Dynamic OEM Table Load:
> > ACPI: SSDT 0x00000000006DEEB8 000051 (v02 Intel  Load     00000001
> INTL
> > 20190509)
> > ACPI Exec: Table Event INSTALL, [SSDT] 006DEEB8
> > Table [SSDT: Load    ] (id 06) -    5 Objects with   1 Devices,   0
> > Regions,    1 Methods
> > ACPI Exec: Table Event LOAD, [SSDT] 006DEEB8 ACPI Debug:  Reference
> > [DdbHandle] Table Index 0x3
> > 0x7 Outstanding allocations after evaluation of \LD1 Evaluation of
> > \LD1 returned object 006D2FE8, external buffer length 18
> >   [Integer] =3D 0000000000000000
> >
> > - ev pkg1
> > Evaluating \PKG1
> > Evaluation of \PKG1 returned object 006D2FE8, external buffer length
> 90
> >   [Package] Contains 5 Elements:
> >     [Integer] =3D 0000000000000001
> >     [Integer] =3D 0000000000000002
> >     [Object Reference] =3D 006DDF88 <Node>            Name DEV2 Device
> >     [Object Reference] =3D 006DD608 <Node>            Name DEV1 Device
> >     [Integer] =3D 0000000000000004


--===============5611893305391638490==--

