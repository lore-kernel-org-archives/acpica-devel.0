Content-Type: multipart/mixed; boundary="===============0376412192533759749=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Re: [PATCH 0/2] ACPICA: Fix a race in GenericSerialBus (I2C)
 and GPIO handling
Date: Wed, 17 Feb 2021 01:29:04 +0000
Message-ID: <BYAPR11MB32561639443993C98C31236587879@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: CAJZ5v0g2mhrw56aAjafYAsRnOWjZTATyHyfi57ekuQyGs6O-MA@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0376412192533759749==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We've been busy implementing ACPI 6.4 support in ACPICA. Sorry for the dela=
y.
Bob


-----Original Message-----
From: Rafael J. Wysocki <rafael(a)kernel.org> =

Sent: Monday, February 15, 2021 10:26 AM
To: Hans de Goede <hdegoede(a)redhat.com>
Cc: Rafael J . Wysocki <rjw(a)rjwysocki.net>; Len Brown <lenb(a)kernel.org>=
; Moore, Robert <robert.moore(a)intel.com>; Kaneda, Erik <erik.kaneda(a)int=
el.com>; ACPI Devel Maling List <linux-acpi(a)vger.kernel.org>; open list:A=
CPI COMPONENT ARCHITECTURE (ACPICA) <devel(a)acpica.org>
Subject: Re: [PATCH 0/2] ACPICA: Fix a race in GenericSerialBus (I2C) and G=
PIO handling

On Mon, Feb 15, 2021 at 6:52 PM Hans de Goede <hdegoede(a)redhat.com> wrote:
>
> Hi,
>
> On 12/26/20 3:28 PM, Hans de Goede wrote:
> > Hi All,
> >
> > On one of my machines I noticed the following errors being logged:
> >
> > [   52.892807] i2c i2c-0: adapter quirk: no zero length (addr 0x0078, s=
ize 0, read)
> > [   52.893037] i2c i2c-0: i2c read 0 bytes from client(a)0x78 starting =
at reg 0x0 failed, error: -95
> >
> > The second line is coming from the Linux I2C ACPI OpRegion handling =

> > and after a bunch of debugging I've found out that there is a rather =

> > obvious (once you see it) and nasty race condition in the handling =

> > of I2C and GPIO opregions in acpi_ev_address_space_dispatch(). See =

> > the first patch in this series (the second patch is a follow-up =

> > cleanup patch removing some code duplication).
> >
> > TBH I'm surprised that this issue has gone unnoticed as long as it =

> > has, but I guess that it mostly leads to unreproducable sporadic =

> > problems making it hard to debug and I got lucky that I had a =

> > machine where the race seems to trigger about once every 20 seconds.
> >
> > I know that ACPICA patches are normally merged through the ACPICA =

> > upstream but given that this is a serious bug, I believe that in =

> > this case it might be best to add the fix directly to Linux and then =

> > port it to ACPICA from there.
>
> ping ?
>
> This was submitted 2 full months ago; and despite this:
>
> 1. Fixing a serious bug in ACPICA
> 2. The fix being pretty simple (and AFAICT obviously correct)
>
> This is still awaiting review upstream:
> https://github.com/acpica/acpica/pull/658
>
> I must say that it feels to me that the upstream ACPICA process is broken=
 here.
>
> I submitted a pull-req for this, as requested and after that there has =

> been zero progress.
>
> The pull-req even has a 26 day old "this looks good to me" comment =

> from Erik, followed by silence... ?
>
> Rafael, can you please consider just directly picking these 2 fixes =

> into your acpi branch, so that we can get this nasty race condition fixed=
 ?

I will do that later this week, thanks!

--===============0376412192533759749==--

