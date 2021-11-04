Content-Type: multipart/mixed; boundary="===============2091517294046336715=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] ACPI: Add AEST in ACPI Table Definitions
Date: Thu, 04 Nov 2021 12:31:22 +0100
Message-ID: <CAJZ5v0j4ZvbkdF2Az_5MLFY=Vt7835LA-U2N2qKbZVk9KDx7QA@mail.gmail.com>
In-Reply-To: TYCPR01MB6160403C510AE93C1EC2635DE98D9@TYCPR01MB6160.jpnprd01.prod.outlook.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2091517294046336715==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 4, 2021 at 8:14 AM ishii.shuuichir(a)fujitsu.com
<ishii.shuuichir(a)fujitsu.com> wrote:
>
> ping?
>
> P.S.
> We should have added the maintainer of ACPI FOR ARM64 (ACPI/arm64) first,
> but since AEST is an arm-spec ACPI table, added the concerned persons
> as new e-mail addresses.

Please resend the patch, then, with all of the requisite addresses
present in the CC list.

> > -----Original Message-----
> > From: Shuuichirou Ishii <ishii.shuuichir(a)fujitsu.com>
> > Sent: Tuesday, October 26, 2021 4:53 PM
> > To: rjw(a)rjwysocki.net; lenb(a)kernel.org; linux-acpi(a)vger.kernel.or=
g;
> > linux-kernel(a)vger.kernel.org; robert.moore(a)intel.com; erik.kaneda(a=
)intel.com;
> > rafael.j.wysocki(a)intel.com; devel(a)acpica.org
> > Cc: Ishii, Shuuichirou/=E7=9F=B3=E4=BA=95 =E5=91=A8=E4=B8=80=E9=83=8E <=
ishii.shuuichir(a)fujitsu.com>
> > Subject: [PATCH] ACPI: Add AEST in ACPI Table Definitions
> >
> > When We added AEST using the Upgrading ACPI tables via initrd function,=
 the
> > kernel could not recognize the AEST, so We added AEST the ACPI table de=
finition.
> >
> > Signed-off-by: Shuuichirou Ishii <ishii.shuuichir(a)fujitsu.com>
> > ---
> >  drivers/acpi/tables.c | 2 +-
> >  include/acpi/actbl2.h | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c index
> > f9383736fa0f..ab0fb4c33e07 100644
> > --- a/drivers/acpi/tables.c
> > +++ b/drivers/acpi/tables.c
> > @@ -499,7 +499,7 @@ static const char table_sigs[][ACPI_NAMESEG_SIZE]
> > __initconst =3D {
> >       ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
> >       ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
> >       ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
> > -     ACPI_SIG_NHLT };
> > +     ACPI_SIG_NHLT, ACPI_SIG_AEST };
> >
> >  #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
> >
> > diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h index
> > a47b32a5cbde..b586e40d4b86 100644
> > --- a/include/acpi/actbl2.h
> > +++ b/include/acpi/actbl2.h
> > @@ -48,6 +48,7 @@
> >  #define ACPI_SIG_SDEV           "SDEV"       /* Secure Devices table */
> >  #define ACPI_SIG_NHLT           "NHLT"       /* Non-HDAudio Link Table
> > */
> >  #define ACPI_SIG_SVKL           "SVKL"       /* Storage Volume Key
> > Location Table */
> > +#define ACPI_SIG_AEST           "AEST" /* Arm Error Source Table */
> >
> >  /*
> >   * All tables must be byte-packed to match the ACPI specification, sin=
ce
> > --
> > 2.27.0
>
--===============2091517294046336715==--

