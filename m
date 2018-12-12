Content-Type: multipart/mixed; boundary="===============5260538942990267175=="
MIME-Version: 1.0
From: Schmauss, Erik <erik.schmauss at intel.com>
Subject: Re: [Devel] [PATCH v6 5/5] ACPICA: Remove PCI bits from ACPICA when
 CONFIG_PCI is unset
Date: Wed, 12 Dec 2018 21:16:40 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C556C0D@ORSMSX122.amr.corp.intel.com>
In-Reply-To: CAJZ5v0iN+OkN0+wy=jGA33Uz+wQT7=zxF-TX3e-TrHDnr4=YRA@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5260538942990267175==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rafael(a)kernel.org]
> Sent: Wednesday, December 12, 2018 1:07 PM
> To: okaya(a)kernel.org; Schmauss, Erik <erik.schmauss(a)intel.com>
> Cc: ACPI Devel Maling List <linux-acpi(a)vger.kernel.org>; Moore, Robert
> <robert.moore(a)intel.com>; Wysocki, Rafael J <rafael.j.wysocki(a)intel.c=
om>;
> Len Brown <lenb(a)kernel.org>; devel(a)acpica.org; Linux Kernel Mailing L=
ist
> <linux-kernel(a)vger.kernel.org>
> Subject: Re: [PATCH v6 5/5] ACPICA: Remove PCI bits from ACPICA when
> CONFIG_PCI is unset
> =

> On Wed, Dec 12, 2018 at 8:34 PM Sinan Kaya <okaya(a)kernel.org> wrote:
> >
> > On 12/12/2018 2:02 PM, Schmauss, Erik wrote:
> > >> ++ b/drivers/acpi/acpica/achware.h
> > >> @@ -109,8 +109,17 @@ acpi_hw_enable_runtime_gpe_block(struct
> > >> acpi_gpe_xrupt_info *gpe_xrupt_info,
> > > CONFIG_PCI is a Linux-ism. We should stay with the OS-independent
> > > nature of ACPICA. Please use ACPI_PCI_CONFIGURED and put it above
> the comment like so:
> > >
> > > #ifdef ACPI_PCI_CONFIGURED
> >
> > Thanks for the feedback. My search for ACPI_PCI_CONFIGURED returned
> nothing.
> >
> > git grep ACPI_PCI_CONFIGURED
> >
> > @Rafael,
> >
> > How do you want to handle this?
> =

> I think what Eric suggested is effectively to introduce a new ACPICA symb=
ol.
> Erik?

Yes, that's correct and you can add something like

#ifdef CONFIG_PCI
#define ACPI_PCI_CONFIGURED
#endif

in include/linux/platform/aclinux.h to enable it.=20

--===============5260538942990267175==--

