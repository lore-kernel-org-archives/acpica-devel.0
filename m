Content-Type: multipart/mixed; boundary="===============5249592862701436468=="
MIME-Version: 1.0
From: Schmauss, Erik <erik.schmauss at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: make acpi_load_table() return table index
Date: Thu, 26 Sep 2019 16:51:00 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C6481F2@ORSMSX122.amr.corp.intel.com>
In-Reply-To: 20190926163528.GH32742@smile.fi.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5249592862701436468==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: linux-acpi-owner(a)vger.kernel.org <linux-acpi-owner(a)vger.kernel.=
org>
> On Behalf Of Shevchenko, Andriy
> Sent: Thursday, September 26, 2019 9:35 AM
> To: Schmauss, Erik <erik.schmauss(a)intel.com>
> Cc: Nikolaus Voss <nikolaus.voss(a)loewensteinmedical.de>; Rafael J. Wyso=
cki
> <rjw(a)rjwysocki.net>; Moore, Robert <robert.moore(a)intel.com>; Len Brown
> <lenb(a)kernel.org>; Jacek Anaszewski <jacek.anaszewski(a)gmail.com>; Pav=
el
> Machek <pavel(a)ucw.cz>; Dan Murphy <dmurphy(a)ti.com>; linux-
> acpi(a)vger.kernel.org; devel(a)acpica.org; linux-kernel(a)vger.kernel.or=
g;
> nv(a)vosn.de
> Subject: Re: [PATCH] ACPICA: make acpi_load_table() return table index
> =

> On Thu, Sep 26, 2019 at 07:09:05PM +0300, Schmauss, Erik wrote:
> > > -----Original Message-----
> > > From: Nikolaus Voss <nikolaus.voss(a)loewensteinmedical.de>
> > > Sent: Thursday, September 12, 2019 1:08 AM
> > > To: Shevchenko, Andriy <andriy.shevchenko(a)intel.com>; Schmauss, Erik
> > > <erik.schmauss(a)intel.com>; Rafael J. Wysocki <rjw(a)rjwysocki.net>;
> > > Moore, Robert <robert.moore(a)intel.com>
> > > Cc: Len Brown <lenb(a)kernel.org>; Jacek Anaszewski
> > > <jacek.anaszewski(a)gmail.com>; Pavel Machek <pavel(a)ucw.cz>; Dan
> > > Murphy <dmurphy(a)ti.com>; linux-acpi(a)vger.kernel.org;
> > > devel(a)acpica.org; linux- kernel(a)vger.kernel.org; nv(a)vosn.de;
> > > Nikolaus Voss <nikolaus.voss(a)loewensteinmedical.de>
> > > Subject: [PATCH] ACPICA: make acpi_load_table() return table index
> > >
> > Hi Nikolaus,
> >
> > > For unloading an ACPI table, it is necessary to provide the index of =
the table.
> > > The method intended for dynamically loading or hotplug addition of
> > > tables, acpi_load_table(), should provide this information via an
> > > optional pointer to the loaded table index.
> >
> > We'll take this patch for ACPICA upstream
> =

> Erik,
> =

Hi Andy,

> how about to have also counterpart to acpi_load_table() which will do wha=
t it's
> done now in acpi_configfs.c via acpi_tb_*() API?

I should have given more details. We decided to add this extra parameter in=
 AcpiLoadTable and
we're going to create an AcpiUnloadTable function that will take table inde=
x to unload the table (basically the acpi_tb_unload..).
Once we do this, you can use table indices with AcpiUnloadTable and AcpiLoa=
dTable.

Erik
> =

> Because it's kinda strange to call acpi_load_table*() and acpi_tb_*() in =
the
> same module.
> =

> --
> With Best Regards,
> Andy Shevchenko
> =



--===============5249592862701436468==--

