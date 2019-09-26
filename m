Content-Type: multipart/mixed; boundary="===============6474394406072178418=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: Re: [Devel] [PATCH] ACPICA: make acpi_load_table() return table index
Date: Thu, 26 Sep 2019 21:26:18 +0200
Message-ID: <CAJZ5v0g=onKCidHMLNWuYFCuhcQGmtDDp5QSGiHu1jhoDRuhWQ@mail.gmail.com>
In-Reply-To: alpine.DEB.2.20.1909262043380.13592@fox.voss.local
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6474394406072178418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2019 at 8:44 PM Nikolaus Voss <nv(a)vosn.de> wrote:
>
> On Thu, 26 Sep 2019, Schmauss, Erik wrote:
> >> -----Original Message-----
> >> From: linux-acpi-owner(a)vger.kernel.org <linux-acpi-owner(a)vger.kern=
el.org>
> >> On Behalf Of Shevchenko, Andriy
> >> Sent: Thursday, September 26, 2019 9:35 AM
> >> To: Schmauss, Erik <erik.schmauss(a)intel.com>
> >> Cc: Nikolaus Voss <nikolaus.voss(a)loewensteinmedical.de>; Rafael J. W=
ysocki
> >> <rjw(a)rjwysocki.net>; Moore, Robert <robert.moore(a)intel.com>; Len B=
rown
> >> <lenb(a)kernel.org>; Jacek Anaszewski <jacek.anaszewski(a)gmail.com>; =
Pavel
> >> Machek <pavel(a)ucw.cz>; Dan Murphy <dmurphy(a)ti.com>; linux-
> >> acpi(a)vger.kernel.org; devel(a)acpica.org; linux-kernel(a)vger.kernel=
.org;
> >> nv(a)vosn.de
> >> Subject: Re: [PATCH] ACPICA: make acpi_load_table() return table index
> >>
> >> On Thu, Sep 26, 2019 at 07:09:05PM +0300, Schmauss, Erik wrote:
> >>>> -----Original Message-----
> >>>> From: Nikolaus Voss <nikolaus.voss(a)loewensteinmedical.de>
> >>>> Sent: Thursday, September 12, 2019 1:08 AM
> >>>> To: Shevchenko, Andriy <andriy.shevchenko(a)intel.com>; Schmauss, Er=
ik
> >>>> <erik.schmauss(a)intel.com>; Rafael J. Wysocki <rjw(a)rjwysocki.net>;
> >>>> Moore, Robert <robert.moore(a)intel.com>
> >>>> Cc: Len Brown <lenb(a)kernel.org>; Jacek Anaszewski
> >>>> <jacek.anaszewski(a)gmail.com>; Pavel Machek <pavel(a)ucw.cz>; Dan
> >>>> Murphy <dmurphy(a)ti.com>; linux-acpi(a)vger.kernel.org;
> >>>> devel(a)acpica.org; linux- kernel(a)vger.kernel.org; nv(a)vosn.de;
> >>>> Nikolaus Voss <nikolaus.voss(a)loewensteinmedical.de>
> >>>> Subject: [PATCH] ACPICA: make acpi_load_table() return table index
> >>>>
> >>> Hi Nikolaus,
> >>>
> >>>> For unloading an ACPI table, it is necessary to provide the index of=
 the table.
> >>>> The method intended for dynamically loading or hotplug addition of
> >>>> tables, acpi_load_table(), should provide this information via an
> >>>> optional pointer to the loaded table index.
> >>>
> >>> We'll take this patch for ACPICA upstream
> >>
> >> Erik,
> >>
> > Hi Andy,
> >
> >> how about to have also counterpart to acpi_load_table() which will do =
what it's
> >> done now in acpi_configfs.c via acpi_tb_*() API?
> >
> > I should have given more details. We decided to add this extra parameter
> > in AcpiLoadTable and we're going to create an AcpiUnloadTable function
> > that will take table index to unload the table (basically the
> > acpi_tb_unload..). Once we do this, you can use table indices with
> > AcpiUnloadTable and AcpiLoadTable.
>
> that's even better news.
>
> Rafael, shall I prepare anything?

I don't think so.  I'm expecting to get a proper fix from the upstream
through the normal process.

Thanks,
Rafael

--===============6474394406072178418==--

