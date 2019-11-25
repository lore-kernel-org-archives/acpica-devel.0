Content-Type: multipart/mixed; boundary="===============5320689891041773563=="
MIME-Version: 1.0
From: Schmauss, Erik <erik.schmauss at intel.com>
Subject: [Devel] Re: [PATCH] ACPICA: Use ARRAY_SIZE for 'fadt_info_table',
 'fadt_pm_info_table'
Date: Mon, 25 Nov 2019 18:10:48 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C688958@ORSMSX122.amr.corp.intel.com>
In-Reply-To: e2c60e61-4c2c-ced2-3eda-26d7b3fb8f4b@canonical.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5320689891041773563==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: linux-acpi-owner(a)vger.kernel.org <linux-acpi-owner(a)vger.kernel.=
org>
> On Behalf Of Colin Ian King
> Sent: Friday, November 22, 2019 2:36 PM
> To: Moore, Robert <robert.moore(a)intel.com>; zhengbin
> <zhengbin13(a)huawei.com>; Schmauss, Erik <erik.schmauss(a)intel.com>;
> Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>; lenb(a)kernel.org; linu=
x-
> acpi(a)vger.kernel.org; devel(a)acpica.org
> Subject: Re: [Devel] Re: [PATCH] ACPICA: Use ARRAY_SIZE for
> 'fadt_info_table','fadt_pm_info_table'
> =

> On 22/11/2019 21:49, Moore, Robert wrote:
> > Where does "ARRAY_SIZE" come from? It's not a part of ACPICA.
> > Bob
> =

> It's definitely not part of ACPICA, it's defined in linux/kernel.h

ACPICA codebase must work across multiple operating systems. Since ARRAY_SI=
ZE macro is specific to linux, we cannot take this change as it stands..

Erik
> =

> >
> >
> > -----Original Message-----
> > From: zhengbin <zhengbin13(a)huawei.com>
> > Sent: Friday, November 22, 2019 1:33 AM
> > To: Moore, Robert <robert.moore(a)intel.com>; Schmauss, Erik
> > <erik.schmauss(a)intel.com>; Wysocki, Rafael J
> > <rafael.j.wysocki(a)intel.com>; lenb(a)kernel.org;
> > linux-acpi(a)vger.kernel.org; devel(a)acpica.org
> > Cc: zhengbin13(a)huawei.com
> > Subject: [PATCH] ACPICA: Use ARRAY_SIZE for
> 'fadt_info_table','fadt_pm_info_table'
> >
> > Fixes coccicheck warning:
> >
> > drivers/acpi/acpica/tbfadt.c:107:27-28: WARNING: Use ARRAY_SIZE
> > drivers/acpi/acpica/tbfadt.c:137:30-31: WARNING: Use ARRAY_SIZE
> >
> > Reported-by: Hulk Robot <hulkci(a)huawei.com>
> > Signed-off-by: zhengbin <zhengbin13(a)huawei.com>
> > ---
> >  drivers/acpi/acpica/tbfadt.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/acpi/acpica/tbfadt.c
> > b/drivers/acpi/acpica/tbfadt.c index 0041bfb..324a804 100644
> > --- a/drivers/acpi/acpica/tbfadt.c
> > +++ b/drivers/acpi/acpica/tbfadt.c
> > @@ -103,8 +103,7 @@ static struct acpi_fadt_info fadt_info_table[] =3D {
> >  	 ACPI_FADT_SEPARATE_LENGTH | ACPI_FADT_GPE_REGISTER}  };
> >
> > -#define ACPI_FADT_INFO_ENTRIES \
> > -			(sizeof (fadt_info_table) / sizeof (struct
> acpi_fadt_info))
> > +#define ACPI_FADT_INFO_ENTRIES (ARRAY_SIZE(fadt_info_table))
> >
> >  /* Table used to split Event Blocks into separate status/enable
> > registers */
> >
> > @@ -133,8 +132,7 @@ static struct acpi_fadt_pm_info fadt_pm_info_table[]
> =3D {
> >  	 1}
> >  };
> >
> > -#define ACPI_FADT_PM_INFO_ENTRIES \
> > -			(sizeof (fadt_pm_info_table) / sizeof (struct
> acpi_fadt_pm_info))
> > +#define ACPI_FADT_PM_INFO_ENTRIES (ARRAY_SIZE(fadt_pm_info_table))
> >
> >
> /******************************************************************
> *************
> >   *
> > --
> > 2.7.4
> > _______________________________________________
> > Devel mailing list -- devel(a)acpica.org To unsubscribe send an email to
> > devel-leave(a)acpica.org
> > %(web_page_url)slistinfo%(cgiext)s/%(_internal_name)s
> >


--===============5320689891041773563==--

