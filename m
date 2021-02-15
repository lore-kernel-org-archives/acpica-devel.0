Content-Type: multipart/mixed; boundary="===============8882135814056150612=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH 0/2] ACPICA: Fix a race in GenericSerialBus (I2C)
 and GPIO handling
Date: Mon, 15 Feb 2021 19:25:41 +0100
Message-ID: <CAJZ5v0g2mhrw56aAjafYAsRnOWjZTATyHyfi57ekuQyGs6O-MA@mail.gmail.com>
In-Reply-To: ced43570-1e76-6f96-f9ab-83473b4adfb7@redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8882135814056150612==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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
> > The second line is coming from the Linux I2C ACPI OpRegion handling and
> > after a bunch of debugging I've found out that there is a rather obvious
> > (once you see it) and nasty race condition in the handling of I2C and G=
PIO
> > opregions in acpi_ev_address_space_dispatch(). See the first patch in t=
his
> > series (the second patch is a follow-up cleanup patch removing some code
> > duplication).
> >
> > TBH I'm surprised that this issue has gone unnoticed as long as it has,
> > but I guess that it mostly leads to unreproducable sporadic problems
> > making it hard to debug and I got lucky that I had a machine where the
> > race seems to trigger about once every 20 seconds.
> >
> > I know that ACPICA patches are normally merged through the ACPICA upstr=
eam
> > but given that this is a serious bug, I believe that in this case it mi=
ght
> > be best to add the fix directly to Linux and then port it to ACPICA from
> > there.
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
> I submitted a pull-req for this, as requested and after that there has
> been zero progress.
>
> The pull-req even has a 26 day old "this looks good to me" comment from E=
rik,
> followed by silence... ?
>
> Rafael, can you please consider just directly picking these 2 fixes into
> your acpi branch, so that we can get this nasty race condition fixed ?

I will do that later this week, thanks!
--===============8882135814056150612==--

