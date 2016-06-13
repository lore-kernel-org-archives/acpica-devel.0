Content-Type: multipart/mixed; boundary="===============9091186752632158707=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] acpi: broken suspend to RAM with v4.7-rc1
Date: Mon, 13 Jun 2016 08:50:55 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BBCF836@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 744357E9AAD1214791ACBA4B0B9092633AA54819@SHSMSX101.ccr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============9091186752632158707==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Andrey

> From: linux-acpi-owner(a)vger.kernel.org [mailto:linux-acpi-
> owner(a)vger.kernel.org] On Behalf Of Rafael J. Wysocki
> Subject: Re: acpi: broken suspend to RAM with v4.7-rc1
> =

> On Saturday, June 11, 2016 01:49:22 PM Andrey Skvortsov wrote:
> > On 10 Jun, Rafael J. Wysocki wrote:
> > > On Friday, June 10, 2016 11:32:10 PM Andrey Skvortsov wrote:
> > > > Hi,
> > > >
> > > > On my laptop (DELL Vostro 1500) in v4.7-rc1 is broken suspend to RA=
M.
> > > > Laptop doesn't finish suspend to RAM process (disks are off, but
> > > > WiFi and Power LEDs are still on). The only way to get it out of
> > > > this state, is to turn the power off.
> > > >
> > > > I've bisected the issue to commit 66b1ed5aa8dd25
> > > > [ACPICA: ACPI 2.0, Hardware: Add access_width/bit_offset support
> > > > for acpi_hw_write()].
> > > >
> > > > If I revert this commit in v4.7-rc1 (or v4.7-rc2), suspend to RAM
> > > > is working again.
> > > >
> > > > The cause of this problem is that after this commit write to PM1A
> > > > Control Block (16-bit register) is done using two 8-bit writes.
> > > > If I force this write to be 16-bit, then all is working as before.
> > > >
> > > > To get it working 'access_width' for PM1A Control Block needs to
> > > > be 2 (16-bit), but it's 1 (8-bit).
[Lv Zheng] =

Could you send me the acpidump of the machine?

> > > >
> > > > The root of the problem seems to be not the commit
> 66b1ed5aa8dd25
> > > > itself, but the ACPI tables in BIOS where wrong access_width
> > > > comes from. I fixed problem in FACP  table, put it in initrd to
> > > > override FACP table from BIOS. This fixed the issue, suspend to
> > > > RAM is working now again.
> > > >
> > > > But I'm not sure whether is this proper fix for this problem.
> > > > Is there any place in the kernel, where such ACPI quirks are placed?
[Lv Zheng] =

My question would be:
Does Windows behave correctly for this table?
However there is a real case showing that there are real tables need us to =
correctly support BitWidth/BitOffset.
Here is the information for you to refer:
http://permalink.gmane.org/gmane.linux.kernel.commits.head/313870

> > >
> > > Well, if the commit in question caused a problem to happen for you,
> > > it also might cause similar problems to happen elsewhere.
> > >
> > > It looks like we'll need to revert that commit.
> > Hi,
> >
> > or maybe to reset access_width AnyAcc from FACP table only for PM1A
> > control register or even for all registers? This will fix the issue too.
> =

> That's a good idea actually.
> =

> > diff --git a/drivers/acpi/acpica/tbfadt.c
> > b/drivers/acpi/acpica/tbfadt.c index 6208069..a476e94 100644
> > --- a/drivers/acpi/acpica/tbfadt.c
> > +++ b/drivers/acpi/acpica/tbfadt.c
> > @@ -714,7 +714,14 @@ static void acpi_tb_setup_fadt_registers(void)
> >                         }
> >                 }
> >         }
> >
> > +       /*
> > +        * Reset access_width in the GAS for PM1A control register to
> > +        * undefined value. Because in some cases this field contains
> > +        * wrong value.
> > +        */
> > +       acpi_gbl_FADT.xpm1a_control_block.access_width =3D 0;
> =

> OK, let's see what Bob and Lv think about that.
[Lv Zheng] =

There is a commit in 4.7-rc2:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=
=3D7f9bef9d
Have you tried if the problem still exists in 4.7-rc2?

Thanks and best regards
-Lv


--===============9091186752632158707==--

