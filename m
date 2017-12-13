Content-Type: multipart/mixed; boundary="===============8505101965212468912=="
MIME-Version: 1.0
From: Schmauss, Erik <erik.schmauss at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: Fix indentation
Date: Wed, 13 Dec 2017 21:53:35 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED539668D71@ORSMSX110.amr.corp.intel.com>
In-Reply-To: CAJZ5v0hgt8MLkxSHeN1A49p4g6VCr-r8x7RGun9eVmtx0PZKgg@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8505101965212468912==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


> -----Original Message-----
> From: rjwysocki(a)gmail.com [mailto:rjwysocki(a)gmail.com] On Behalf Of R=
afael
> J. Wysocki
> Sent: Friday, December 8, 2017 9:06 AM
> To: Vasyl Gomonovych <gomonovych(a)gmail.com>
> Cc: Moore, Robert <robert.moore(a)intel.com>; Zheng, Lv
> <lv.zheng(a)intel.com>; Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>;=
 Len
> Brown <lenb(a)kernel.org>; ACPI Devel Maling List <linux-acpi(a)vger.kern=
el.org>;
> devel(a)acpica.org; Linux Kernel Mailing List <linux-kernel(a)vger.kernel=
.org>;
> Schmauss, Erik <erik.schmauss(a)intel.com>
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


Hi,
> Erik may want to pick this up, however.
> =


Thanks for pointing this out. I found  solution to fix the indentation issu=
e. It will be in the next release.
Erik
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

--===============8505101965212468912==--

