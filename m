Content-Type: multipart/mixed; boundary="===============0768822813573841553=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] acpi: broken suspend to RAM with v4.7-rc1
Date: Tue, 28 Jun 2016 05:10:33 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BBFC7D3@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 20160627084911.GN13845@localhost.localdomain
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0768822813573841553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> From: Andrey Skvortsov [mailto:andrej.skvortzov(a)gmail.com]
> Subject: Re: acpi: broken suspend to RAM with v4.7-rc1
> =

> On 27 Jun, Zheng, Lv wrote:
> > Hi,
> >
> > > From: Andrey Skvortsov [mailto:andrej.skvortzov(a)gmail.com]
> > > Subject: Re: acpi: broken suspend to RAM with v4.7-rc1
> > >
> > > On 24 Jun, Zheng, Lv wrote:
> > > > Hi,
> > > >
> > > > > From: Andrey Skvortsov [mailto:andrej.skvortzov(a)gmail.com]
> > > > > Subject: Re: acpi: broken suspend to RAM with v4.7-rc1
> > > > >
> > > > > Hi Lv,
> > > > >
> > > > > On 13 Jun, Zheng, Lv wrote:
> > > > > > > From: linux-acpi-owner(a)vger.kernel.org [mailto:linux-acpi-
> > > > > > > owner(a)vger.kernel.org] On Behalf Of Rafael J. Wysocki
> > > > > > > Subject: Re: acpi: broken suspend to RAM with v4.7-rc1
> > > > > > >
> > > > > > > On Saturday, June 11, 2016 01:49:22 PM Andrey Skvortsov
> wrote:
> > > > > > > > On 10 Jun, Rafael J. Wysocki wrote:
> > > > > > > > > On Friday, June 10, 2016 11:32:10 PM Andrey Skvortsov
> wrote:
> > > > > > > > > > Hi,
> > > > > > > > > >
> > > > > > > > > > On my laptop (DELL Vostro 1500) in v4.7-rc1 is broken
> > > suspend
> > > > > to RAM.
> > > > > > > > > > Laptop doesn't finish suspend to RAM process (disks are
> off,
> > > but
> > > > > > > > > > WiFi and Power LEDs are still on). The only way to get =
it
> out of
> > > > > > > > > > this state, is to turn the power off.
> > > > > > > > > >
> > > > > > > > > > I've bisected the issue to commit 66b1ed5aa8dd25
> > > > > > > > > > [ACPICA: ACPI 2.0, Hardware: Add
> access_width/bit_offset
> > > > > support
> > > > > > > > > > for acpi_hw_write()].
> > > > > > > > > >
> > > > > > > > > > If I revert this commit in v4.7-rc1 (or v4.7-rc2), susp=
end to
> > > RAM
> > > > > > > > > > is working again.
> > > > > > > > > >
> > > > > > > > > > The cause of this problem is that after this commit wri=
te
> to
> > > > > PM1A
> > > > > > > > > > Control Block (16-bit register) is done using two 8-bit
> writes.
> > > > > > > > > > If I force this write to be 16-bit, then all is working=
 as
> before.
> > > > > > > > > >
> > > > > > > > > > To get it working 'access_width' for PM1A Control Block
> > > needs to
> > > > > > > > > > be 2 (16-bit), but it's 1 (8-bit).
> > > > > > [Lv Zheng]
> > > > > > Could you send me the acpidump of the machine?
> > > > > Here it is
> > > > >
> > >
> https://dl.dropboxusercontent.com/u/24023626/dell_vostro_1500.acpid
> > > > > ump.bin
> > > > [Lv Zheng]
> > > > I've been trying to download it these days but all failed.
> > > > Could you send an off-list email to me with this attached?
> > > Strange. I've check now. The link above is working, but I see that
> > > part of the link above is moved to the next line.
> > [Lv Zheng]
> > Maybe this is just because of ISP firewall.
> >
> > > Anyway I resend you all files off-list.
> > [Lv Zheng]
> > Great!
> >
> > >
> > >
> > > > > > > > > > The root of the problem seems to be not the commit
> > > > > > > 66b1ed5aa8dd25
> > > > > > > > > > itself, but the ACPI tables in BIOS where wrong
> access_width
> > > > > > > > > > comes from. I fixed problem in FACP  table, put it in i=
nitrd
> to
> > > > > > > > > > override FACP table from BIOS. This fixed the issue,
> suspend
> > > to
> > > > > > > > > > RAM is working now again.
> > > > > > > > > >
> > > > > > > > > > But I'm not sure whether is this proper fix for this
> problem.
> > > > > > > > > > Is there any place in the kernel, where such ACPI quirks
> are
> > > placed?
> > > > > > [Lv Zheng]
> > > > > > My question would be:
> > > > > > Does Windows behave correctly for this table?
> > > > > Yes, suspend to RAM is working under Windows Vista.
> > > > > IIRC it worked under Windows XP too.
> > > > >
> > > > > > However there is a real case showing that there are real tables
> need
> > > us to
> > > > > correctly support BitWidth/BitOffset.
> > > > > > Here is the information for you to refer:
> > > > > >
> > >
> http://permalink.gmane.org/gmane.linux.kernel.commits.head/313870
> > > > > >
> > > > > > > > >
> > > > > > > > > Well, if the commit in question caused a problem to happen
> for
> > > > > you,
> > > > > > > > > it also might cause similar problems to happen elsewhere.
> > > > > > > > >
> > > > > > > > > It looks like we'll need to revert that commit.
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > or maybe to reset access_width AnyAcc from FACP table only
> for
> > > > > PM1A
> > > > > > > > control register or even for all registers? This will fix t=
he issue
> too.
> > > > > > >
> > > > > > > That's a good idea actually.
> > > > > > >
> > > > > > > > diff --git a/drivers/acpi/acpica/tbfadt.c
> > > > > > > > b/drivers/acpi/acpica/tbfadt.c index 6208069..a476e94
> 100644
> > > > > > > > --- a/drivers/acpi/acpica/tbfadt.c
> > > > > > > > +++ b/drivers/acpi/acpica/tbfadt.c
> > > > > > > > @@ -714,7 +714,14 @@ static void
> > > > > acpi_tb_setup_fadt_registers(void)
> > > > > > > >                         }
> > > > > > > >                 }
> > > > > > > >         }
> > > > > > > >
> > > > > > > > +       /*
> > > > > > > > +        * Reset access_width in the GAS for PM1A control
> register
> > > to
> > > > > > > > +        * undefined value. Because in some cases this field
> contains
> > > > > > > > +        * wrong value.
> > > > > > > > +        */
> > > > > > > > +       acpi_gbl_FADT.xpm1a_control_block.access_width =3D =
0;
> > > > > > >
> > > > > > > OK, let's see what Bob and Lv think about that.
> > > > > > [Lv Zheng]
> > > > > > There is a commit in 4.7-rc2:
> > > > > >
> > > > >
> > >
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?i=
d=3D
> > > > > 7f9bef9d
> > > > > > Have you tried if the problem still exists in 4.7-rc2?
> > > > > I've just tried v4.7-rc3. It contains commit 7f9bef9d and the
> problem
> > > > > exists there too.
> > > > [Lv Zheng]
> > > > IMO, for the time being, you can use quirks.
> > > > Booting your kernel with the following parameters:
> > > >
> > > > acpi=3Drsdt
> > > > Or
> > > > acpi_force_32bit_fadt_addr
> > > > Or
> > > > Both
> > >
> > > Rafael reverted commit, so I'm ok now.
> > >
> > > Actually acpi_force_32bit_fadt_addr will not help here, because it's
> take
> > > effect only if address64 !=3D address32. But here these addresses are
> > > the same, therefore access_width is taken from extended address.
> > >
> > > http://lxr.free-
> electrons.com/source/drivers/acpi/acpica/tbfadt.c#L576
> > [Lv Zheng]
> > In addition to the address check, we may add access width check here.
> > I need to check this with the decision makers.
> Make sense. But then it's necessary to set default access width for
> registers from
> FADT for this check. Because in the old 32-bit part of FADT only address
> and
> length are defined, but not access width.
> =

> =

> > > acpi=3Drsdt helps. Thanks for the information about this option. I
> > > missed it, when I read documentation.
> > [Lv Zheng]
> > Great to know that at least 1 quirk works.
> > Back to this bug, it seems we should use fixed access_width for some
> pre-defined PM registers.
> This is what I meant by suggesting to reset xpm1a's
> access_width to zero (or maybe another registers from FADT too) in
> acpi_tb_setup_fadt_registers (see quoted diff above from my previous
> answer).
> If access_width is zero, then code works as before and access_width is
> calculated by acpi_hw_get_access_bit_width (will return reg->bit_width or
> max_bit_width(32) in our case).
> =

> Setting access_width to some pre-defined value is an option.
> But it's not as flexible, because ACPI specification doesn't define
> access width and some pre-defined PM registers have variable length
> and only the minimal register length is defined (PM1A Control Reg, PM1B
> Control
> Reg, PM1A event block, PM1B event block).
> =

> Previously you pointed to commit that requires usage of access
> width field.
> http://permalink.gmane.org/gmane.linux.kernel.commits.head/313870
> I see it's related to APEI, therefore setting access_width for
> registers in FADT will not affect it.

[Lv Zheng] =

Yes, I can see your point and it looks reasonable.
For now, I'm going to probe Windows behavior using qemu.

It looks I can achieve this by modifying:
hw/i386/acpi-build.c: http://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/i38=
6/acpi-build.c
hw/acpi/ich9.c: http://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/acpi/ich9=
.c

The result may help us to make more accurate decision.

Thanks and best regards
-Lv

--===============0768822813573841553==--

