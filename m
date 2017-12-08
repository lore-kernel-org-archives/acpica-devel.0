Content-Type: multipart/mixed; boundary="===============9196170187047264485=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: Fix indentation
Date: Fri, 08 Dec 2017 21:13:15 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B74FA783@ORSMSX110.amr.corp.intel.com>
In-Reply-To: CAJZ5v0hgt8MLkxSHeN1A49p4g6VCr-r8x7RGun9eVmtx0PZKgg@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============9196170187047264485==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This type of thing more often than not is caused by running the code throug=
h indent (lindent).


Original ACPICA code:

    ACPI_FUNCTION_NAME (ExDumpOperand)

    /* Check if debug output enabled */

    if (!ACPI_IS_DEBUG_ENABLED (ACPI_LV_EXEC, _COMPONENT))
    {
        return;
    }


Raw "linuxized" code:

	ACPI_FUNCTION_NAME (ex_dump_operand)

	/* Check if debug output enabled */

	if (!ACPI_IS_DEBUG_ENABLED (ACPI_LV_EXEC, _COMPONENT)) {
		return;
	}


> -----Original Message-----
> From: rjwysocki(a)gmail.com [mailto:rjwysocki(a)gmail.com] On Behalf Of
> Rafael J. Wysocki
> Sent: Friday, December 8, 2017 9:06 AM
> To: Vasyl Gomonovych <gomonovych(a)gmail.com>
> Cc: Moore, Robert <robert.moore(a)intel.com>; Zheng, Lv
> <lv.zheng(a)intel.com>; Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>;
> Len Brown <lenb(a)kernel.org>; ACPI Devel Maling List <linux-
> acpi(a)vger.kernel.org>; devel(a)acpica.org; Linux Kernel Mailing List
> <linux-kernel(a)vger.kernel.org>; Schmauss, Erik <erik.schmauss(a)intel.c=
om>
> Subject: Re: [PATCH] ACPICA: Fix indentation
> =

> On Fri, Dec 8, 2017 at 5:29 PM, Vasyl Gomonovych <gomonovych(a)gmail.com>
> wrote:
> > This patch avoids that smatch reports the following:
> > drivers/acpi/acpica/exdump.c:623 acpi_ex_dump_operand() warn:
> > inconsistent indenting
> >
> > Signed-off-by: Vasyl Gomonovych <gomonovych(a)gmail.com>
> =

> This is ACPICA code, so changes like this should go in via the upstream.
> =

> Erik may want to pick this up, however.
> =

> > ---
> >  drivers/acpi/acpica/exdump.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/acpi/acpica/exdump.c
> > b/drivers/acpi/acpica/exdump.c index 83398dc..f43d3d7 100644
> > --- a/drivers/acpi/acpica/exdump.c
> > +++ b/drivers/acpi/acpica/exdump.c
> > @@ -619,8 +619,8 @@ void acpi_ex_dump_operand(union
> > acpi_operand_object *obj_desc, u32 depth)
> >
> >         ACPI_FUNCTION_NAME(ex_dump_operand)
> >
> > -           /* Check if debug output enabled */
> > -           if (!ACPI_IS_DEBUG_ENABLED(ACPI_LV_EXEC, _COMPONENT)) {
> > +       /* Check if debug output enabled */
> > +       if (!ACPI_IS_DEBUG_ENABLED(ACPI_LV_EXEC, _COMPONENT)) {
> >                 return;
> >         }
> >
> > --

--===============9196170187047264485==--

