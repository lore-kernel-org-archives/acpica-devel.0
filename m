Content-Type: multipart/mixed; boundary="===============8172987219470638635=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] ACPI: SPCR: Add new 16550-compatible Serial Port
 Subtype
Date: Fri, 25 Jun 2021 19:20:23 +0200
Message-ID: <CAJZ5v0j9eTL476N7FJ+-m0VpbCdtOQZkZBtgvQ__3U1Jvs_cPg@mail.gmail.com>
In-Reply-To: CAPv3WKf=ufj-RbqOKm3cjOQcG1PDAEAkVLdLQUkRK94=_vtj9w@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8172987219470638635==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 25, 2021 at 7:18 PM Marcin Wojtas <mw(a)semihalf.com> wrote:
>
> Hi,
>
> pon., 21 cze 2021 o 22:06 Marcin Wojtas <mw(a)semihalf.com> napisa=C5=82(=
a):
> >
> > Apologies for the patch prefix, of course it's a first version and
> > unrelated to the networking subsystem.
> >
> > Best regards,
> > Marcin
> >
> >
> > pon., 21 cze 2021 o 22:05 Marcin Wojtas <mw(a)semihalf.com> napisa=C5=
=82(a):
> > >
> > > The Microsoft Debug Port Table 2 (DBG2) specification revision
> > > May 31, 2017 adds support for 16550-compatible Serial Port
> > > Subtype with parameters defined in Generic Address Structure (GAS) [1]
> > >
> > > Add its support in SPCR parsing routine.
> > >
> > > [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/bringup=
/acpi-debug-port-table
> > >
> > > Signed-off-by: Marcin Wojtas <mw(a)semihalf.com>
> > > ---
> > >  include/acpi/actbl1.h | 1 +
> > >  drivers/acpi/spcr.c   | 1 +
> > >  2 files changed, 2 insertions(+)
> > >
> > > diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> > > index ce59903c2695..f746012eba8d 100644
> > > --- a/include/acpi/actbl1.h
> > > +++ b/include/acpi/actbl1.h
> > > @@ -498,6 +498,7 @@ struct acpi_dbg2_device {
> > >  #define ACPI_DBG2_ARM_SBSA_GENERIC  0x000E
> > >  #define ACPI_DBG2_ARM_DCC           0x000F
> > >  #define ACPI_DBG2_BCM2835           0x0010
> > > +#define ACPI_DBG2_16550_WITH_GAS    0x0012
> > >
> > >  #define ACPI_DBG2_1394_STANDARD     0x0000
> > >
> > > diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> > > index 88460bacd5ae..25c2d0be953e 100644
> > > --- a/drivers/acpi/spcr.c
> > > +++ b/drivers/acpi/spcr.c
> > > @@ -136,6 +136,7 @@ int __init acpi_parse_spcr(bool enable_earlycon, =
bool enable_console)
> > >                 break;
> > >         case ACPI_DBG2_16550_COMPATIBLE:
> > >         case ACPI_DBG2_16550_SUBSET:
> > > +       case ACPI_DBG2_16550_WITH_GAS:
> > >                 uart =3D "uart";
> > >                 break;
> > >         default:
> > > --
>
> Do you have any comments / remarks to the patch?

Yes, I do, but I will get back to you next week.

Thanks!
--===============8172987219470638635==--

