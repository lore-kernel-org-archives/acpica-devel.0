Content-Type: multipart/mixed; boundary="===============1735959592064943946=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Re: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in
 acpi_gbl_default_address_spaces only when ACPI_PCI_CONFIGURED is defined
Date: Thu, 04 Mar 2021 17:36:58 +0000
Message-ID: <BYAPR11MB3256FD804E3F3CE584B6D3B387979@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: CADFYyO73g8LkgwZv4m5N2bXq0XcZru4m9+K0uudCLmcp7yewpQ@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1735959592064943946==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



-----Original Message-----
From: Weidong Cui <weidongcui(a)gmail.com> =

Sent: Thursday, March 04, 2021 9:06 AM
To: Moore, Robert <robert.moore(a)intel.com>
Cc: Kaneda, Erik <erik.kaneda(a)intel.com>; Wysocki, Rafael J <rafael.j.wys=
ocki(a)intel.com>; Xinyang Ge <aegiryy(a)gmail.com>; linux-acpi(a)vger.kern=
el.org; devel(a)acpica.org; linux-kernel(a)vger.kernel.org; Len Brown <lenb=
(a)kernel.org>
Subject: Re: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in acpi_gbl_default_a=
ddress_spaces only when ACPI_PCI_CONFIGURED is defined

> Well, I don't like the fact that PCI_CONFIGURED would have to be defined =
by each current host:
>
> > +#ifdef ACPI_PCI_CONFIGURED
>
> I would rather the logic be reversed:
>
> > +#ifdef ACPI_PCI_NOT_CONFIGURED

Thank you for the comments, Erik and Bob!

ACPI_PCI_CONFIGURED is defined in aclinux.h (see below) and used in several=
 places in evhandler.c and exregion.c.
I'm not sure why we want to introduce ACPI_PCI_NOT_CONFIGURED.  Bob, I don'=
t understand your concerns about "have to be defined by each current host".=
  Can you please shed some light on it?

It is required in aclinux.h, and thus it is required in every host-dependen=
t configuration file (acfreebsd.h, acmacosx.h, acnetbsd.h, achaiku.h, etc.)=
 I would rather not force these host-specific header files to change.
Bob


#ifdef CONFIG_PCI
#define ACPI_PCI_CONFIGURED
#endif

> -----Original Message-----
> From: Kaneda, Erik <erik.kaneda(a)intel.com>
> Sent: Wednesday, March 03, 2021 10:29 AM
> To: Weidong Cui <weidongcui(a)gmail.com>; Moore, Robert =

> <robert.moore(a)intel.com>; Wysocki, Rafael J =

> <rafael.j.wysocki(a)intel.com>
> Cc: Xinyang Ge <aegiryy(a)gmail.com>; linux-acpi(a)vger.kernel.org; =

> devel(a)acpica.org; linux-kernel(a)vger.kernel.org; Len Brown =

> <lenb(a)kernel.org>
> Subject: RE: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in =

> acpi_gbl_default_address_spaces only when ACPI_PCI_CONFIGURED is =

> defined
>
> This looks good to me. Bob, do you have any comments?
>
> Erik
>
> > -----Original Message-----
> > From: Weidong Cui <weidongcui(a)gmail.com>
> > Sent: Monday, February 8, 2021 7:18 PM
> > To: Moore, Robert <robert.moore(a)intel.com>; Kaneda, Erik =

> > <erik.kaneda(a)intel.com>; Wysocki, Rafael J =

> > <rafael.j.wysocki(a)intel.com>; Len Brown <lenb(a)kernel.org>
> > Cc: Weidong Cui <weidongcui(a)gmail.com>; Xinyang Ge =

> > <aegiryy(a)gmail.com>; linux-acpi(a)vger.kernel.org; devel(a)acpica.org;
> > linux- kernel(a)vger.kernel.org
> > Subject: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in =

> > acpi_gbl_default_address_spaces only when ACPI_PCI_CONFIGURED is =

> > defined
> >
> > Signed-off-by: Weidong Cui <weidongcui(a)gmail.com>
> > Signed-off-by: Xinyang Ge <aegiryy(a)gmail.com>
> > ---
> >  drivers/acpi/acpica/evhandler.c | 2 ++
> >  include/acpi/acconfig.h         | 4 ++++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/drivers/acpi/acpica/evhandler.c =

> > b/drivers/acpi/acpica/evhandler.c index 5884eba04..4c25ad433 100644
> > --- a/drivers/acpi/acpica/evhandler.c
> > +++ b/drivers/acpi/acpica/evhandler.c
> > @@ -26,7 +26,9 @@ acpi_ev_install_handler(acpi_handle obj_handle,
> >  u8 acpi_gbl_default_address_spaces[ACPI_NUM_DEFAULT_SPACES] =3D {
> >       ACPI_ADR_SPACE_SYSTEM_MEMORY,
> >       ACPI_ADR_SPACE_SYSTEM_IO,
> > +#ifdef ACPI_PCI_CONFIGURED
> >       ACPI_ADR_SPACE_PCI_CONFIG,
> > +#endif
> >       ACPI_ADR_SPACE_DATA_TABLE
> >  };
> >
> > diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h index
> > a225eff49..790999028 100644
> > --- a/include/acpi/acconfig.h
> > +++ b/include/acpi/acconfig.h
> > @@ -162,7 +162,11 @@
> >  /* Maximum space_ids for Operation Regions */
> >
> >  #define ACPI_MAX_ADDRESS_SPACE          255
> > +#ifdef ACPI_PCI_CONFIGURED
> >  #define ACPI_NUM_DEFAULT_SPACES         4
> > +#else
> > +#define ACPI_NUM_DEFAULT_SPACES         3
> > +#endif
> >
> >  /* Array sizes.  Used for range checking also */
> >
> > --
> > 2.24.3 (Apple Git-128)
>

--===============1735959592064943946==--

