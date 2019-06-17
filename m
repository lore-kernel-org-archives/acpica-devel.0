Content-Type: multipart/mixed; boundary="===============3079975943609431328=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH v2 1/3] ACPI: Resolve objects on host-directed
 table loads
Date: Mon, 17 Jun 2019 21:18:53 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B95F9EC6@ORSMSX110.amr.corp.intel.com>
In-Reply-To: alpine.DEB.2.20.1906170746150.12344@fox.voss.local
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3079975943609431328==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Nikolaus Voss [mailto:nv(a)vosn.de]
> Sent: Sunday, June 16, 2019 11:24 PM
> To: Moore, Robert <robert.moore(a)intel.com>
> Cc: Rafael J. Wysocki <rafael(a)kernel.org>; Rafael J. Wysocki
> <rjw(a)rjwysocki.net>; Len Brown <lenb(a)kernel.org>; Schmauss, Erik
> <erik.schmauss(a)intel.com>; Jacek Anaszewski
> <jacek.anaszewski(a)gmail.com>; Pavel Machek <pavel(a)ucw.cz>; Dan Murphy
> <dmurphy(a)ti.com>; Thierry Reding <thierry.reding(a)gmail.com>; ACPI Dev=
el
> Maling List <linux-acpi(a)vger.kernel.org>; open list:ACPI COMPONENT
> ARCHITECTURE (ACPICA) <devel(a)acpica.org>; linux-leds(a)vger.kernel.org;
> Linux PWM List <linux-pwm(a)vger.kernel.org>; Linux Kernel Mailing List
> <linux-kernel(a)vger.kernel.org>; nikolaus.voss(a)loewensteinmedical.de
> Subject: RE: [PATCH v2 1/3] ACPI: Resolve objects on host-directed table
> loads
> =

> Bob,
> =

> On Fri, 14 Jun 2019, Moore, Robert wrote:
> >
> >
> > -----Original Message-----
> > From: Nikolaus Voss [mailto:nv(a)vosn.de]
> > Sent: Friday, June 14, 2019 2:26 AM
> > To: Rafael J. Wysocki <rafael(a)kernel.org>
> > Cc: Rafael J. Wysocki <rjw(a)rjwysocki.net>; Len Brown
> > <lenb(a)kernel.org>; Moore, Robert <robert.moore(a)intel.com>; Schmauss,
> > Erik <erik.schmauss(a)intel.com>; Jacek Anaszewski
> > <jacek.anaszewski(a)gmail.com>; Pavel Machek <pavel(a)ucw.cz>; Dan Murp=
hy
> > <dmurphy(a)ti.com>; Thierry Reding <thierry.reding(a)gmail.com>; ACPI
> > Devel Maling List <linux-acpi(a)vger.kernel.org>; open list:ACPI
> > COMPONENT ARCHITECTURE (ACPICA) <devel(a)acpica.org>;
> > linux-leds(a)vger.kernel.org; Linux PWM List
> > <linux-pwm(a)vger.kernel.org>; Linux Kernel Mailing List
> > <linux-kernel(a)vger.kernel.org>
> > Subject: Re: [PATCH v2 1/3] ACPI: Resolve objects on host-directed
> > table loads
> >
> > Hi Rafael,
> >
> > On Fri, 14 Jun 2019, Rafael J. Wysocki wrote:
> >> On Wed, Jun 12, 2019 at 10:36 AM Nikolaus Voss
> >> <nikolaus.voss(a)loewensteinmedical.de> wrote:
> >>>
> >>> If an ACPI SSDT overlay is loaded after built-in tables have been
> >>> loaded e.g. via configfs or efivar_ssdt_load() it is necessary to
> >>> rewalk the namespace to resolve references. Without this, relative
> >>> and absolute paths like ^PCI0.SBUS or \_SB.PCI0.SBUS are not
> >>> resolved correctly.
> >>>
> >>> Make configfs load use the same method as efivar_ssdt_load().
> >>>
> >>> Signed-off-by: Nikolaus Voss <nikolaus.voss(a)loewensteinmedical.de>
> >>
> >> This is fine by me, so
> >>
> >> Acked-by: Rafael J. Wysocki <rafael.j.wysocki(a)intel.com>
> >>
> >> Or if you want me to take this patch (without the other two in the
> >> series), please let me know.
> >
> > thanks. I think it would be the best if you take up this patch as it
> > is an independent topic. In retrospect it wasn't a good idea to put it
> > into this series.
> >
> > Kind regards,
> > Niko
> >
> > I would have to ask, why is additional code needed for package
> > initialization/resolution? It already happens elsewhere in acpica. Bob
> =

> for built-in tables loaded via acpi_ex_load_table_op() everything is
> fine, because after acpi_tb_load_table() acpi_ns_walk_namespace() is
> called to resolve references.
> =

> My fix only affects tables loaded dynamically via either acpi_configfs
> driver (for debugging purposes) or efivar_ssdt_load() (to specify a
> table on the kernel's command line). They use acpi_load_table() to load
> the table from a caller-owned buffer. To resolve the references, it is
> again necessary to rewalk the namespace, which was simply missing in
> acpi_load_table().
> =

[Moore, Robert] =


Perhaps you should call AcpiInitializeObjects after the call to AcpiLoadTab=
le, but I will check.

> Niko

--===============3079975943609431328==--

