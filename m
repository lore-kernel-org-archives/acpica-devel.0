Content-Type: multipart/mixed; boundary="===============7494291062994169609=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] acpi: broken suspend to RAM with v4.7-rc1
Date: Mon, 27 Jun 2016 01:17:22 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BBFA365@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 20160624213235.GA8304@nest
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7494291062994169609==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> From: Andrey Skvortsov [mailto:andrej.skvortzov(a)gmail.com]
> Subject: Re: acpi: broken suspend to RAM with v4.7-rc1
> =

> On 24 Jun, Zheng, Lv wrote:
> > Hi,
> >
> > > From: Andrey Skvortsov [mailto:andrej.skvortzov(a)gmail.com]
> > > Subject: Re: acpi: broken suspend to RAM with v4.7-rc1
> > >
> > > Hi Lv,
> > >
> > > On 13 Jun, Zheng, Lv wrote:
> > > > > From: linux-acpi-owner(a)vger.kernel.org [mailto:linux-acpi-
> > > > > owner(a)vger.kernel.org] On Behalf Of Rafael J. Wysocki
> > > > > Subject: Re: acpi: broken suspend to RAM with v4.7-rc1
> > > > >
> > > > > On Saturday, June 11, 2016 01:49:22 PM Andrey Skvortsov wrote:
> > > > > > On 10 Jun, Rafael J. Wysocki wrote:
> > > > > > > On Friday, June 10, 2016 11:32:10 PM Andrey Skvortsov wrote:
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > On my laptop (DELL Vostro 1500) in v4.7-rc1 is broken
> suspend
> > > to RAM.
> > > > > > > > Laptop doesn't finish suspend to RAM process (disks are off,
> but
> > > > > > > > WiFi and Power LEDs are still on). The only way to get it o=
ut of
> > > > > > > > this state, is to turn the power off.
> > > > > > > >
> > > > > > > > I've bisected the issue to commit 66b1ed5aa8dd25
> > > > > > > > [ACPICA: ACPI 2.0, Hardware: Add access_width/bit_offset
> > > support
> > > > > > > > for acpi_hw_write()].
> > > > > > > >
> > > > > > > > If I revert this commit in v4.7-rc1 (or v4.7-rc2), suspend =
to
> RAM
> > > > > > > > is working again.
> > > > > > > >
> > > > > > > > The cause of this problem is that after this commit write to
> > > PM1A
> > > > > > > > Control Block (16-bit register) is done using two 8-bit wri=
tes.
> > > > > > > > If I force this write to be 16-bit, then all is working as =
before.
> > > > > > > >
> > > > > > > > To get it working 'access_width' for PM1A Control Block
> needs to
> > > > > > > > be 2 (16-bit), but it's 1 (8-bit).
> > > > [Lv Zheng]
> > > > Could you send me the acpidump of the machine?
> > > Here it is
> > >
> https://dl.dropboxusercontent.com/u/24023626/dell_vostro_1500.acpid
> > > ump.bin
> > [Lv Zheng]
> > I've been trying to download it these days but all failed.
> > Could you send an off-list email to me with this attached?
> Strange. I've check now. The link above is working, but I see that
> part of the link above is moved to the next line.
[Lv Zheng] =

Maybe this is just because of ISP firewall.

> Anyway I resend you all files off-list.
[Lv Zheng] =

Great!

> =

> =

> > > > > > > > The root of the problem seems to be not the commit
> > > > > 66b1ed5aa8dd25
> > > > > > > > itself, but the ACPI tables in BIOS where wrong access_width
> > > > > > > > comes from. I fixed problem in FACP  table, put it in initr=
d to
> > > > > > > > override FACP table from BIOS. This fixed the issue, suspend
> to
> > > > > > > > RAM is working now again.
> > > > > > > >
> > > > > > > > But I'm not sure whether is this proper fix for this proble=
m.
> > > > > > > > Is there any place in the kernel, where such ACPI quirks are
> placed?
> > > > [Lv Zheng]
> > > > My question would be:
> > > > Does Windows behave correctly for this table?
> > > Yes, suspend to RAM is working under Windows Vista.
> > > IIRC it worked under Windows XP too.
> > >
> > > > However there is a real case showing that there are real tables need
> us to
> > > correctly support BitWidth/BitOffset.
> > > > Here is the information for you to refer:
> > > >
> http://permalink.gmane.org/gmane.linux.kernel.commits.head/313870
> > > >
> > > > > > >
> > > > > > > Well, if the commit in question caused a problem to happen for
> > > you,
> > > > > > > it also might cause similar problems to happen elsewhere.
> > > > > > >
> > > > > > > It looks like we'll need to revert that commit.
> > > > > > Hi,
> > > > > >
> > > > > > or maybe to reset access_width AnyAcc from FACP table only for
> > > PM1A
> > > > > > control register or even for all registers? This will fix the i=
ssue too.
> > > > >
> > > > > That's a good idea actually.
> > > > >
> > > > > > diff --git a/drivers/acpi/acpica/tbfadt.c
> > > > > > b/drivers/acpi/acpica/tbfadt.c index 6208069..a476e94 100644
> > > > > > --- a/drivers/acpi/acpica/tbfadt.c
> > > > > > +++ b/drivers/acpi/acpica/tbfadt.c
> > > > > > @@ -714,7 +714,14 @@ static void
> > > acpi_tb_setup_fadt_registers(void)
> > > > > >                         }
> > > > > >                 }
> > > > > >         }
> > > > > >
> > > > > > +       /*
> > > > > > +        * Reset access_width in the GAS for PM1A control regis=
ter
> to
> > > > > > +        * undefined value. Because in some cases this field co=
ntains
> > > > > > +        * wrong value.
> > > > > > +        */
> > > > > > +       acpi_gbl_FADT.xpm1a_control_block.access_width =3D 0;
> > > > >
> > > > > OK, let's see what Bob and Lv think about that.
> > > > [Lv Zheng]
> > > > There is a commit in 4.7-rc2:
> > > >
> > >
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?i=
d=3D
> > > 7f9bef9d
> > > > Have you tried if the problem still exists in 4.7-rc2?
> > > I've just tried v4.7-rc3. It contains commit 7f9bef9d and the problem
> > > exists there too.
> > [Lv Zheng]
> > IMO, for the time being, you can use quirks.
> > Booting your kernel with the following parameters:
> >
> > acpi=3Drsdt
> > Or
> > acpi_force_32bit_fadt_addr
> > Or
> > Both
> =

> Rafael reverted commit, so I'm ok now.
> =

> Actually acpi_force_32bit_fadt_addr will not help here, because it's take
> effect only if address64 !=3D address32. But here these addresses are
> the same, therefore access_width is taken from extended address.
> =

> http://lxr.free-electrons.com/source/drivers/acpi/acpica/tbfadt.c#L576
[Lv Zheng] =

In addition to the address check, we may add access width check here.
I need to check this with the decision makers.

> =

> =

> acpi=3Drsdt helps. Thanks for the information about this option. I
> missed it, when I read documentation.
[Lv Zheng] =

Great to know that at least 1 quirk works.
Back to this bug, it seems we should use fixed access_width for some pre-de=
fined PM registers.

Thanks and best regards
-Lv

--===============7494291062994169609==--

