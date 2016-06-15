Content-Type: multipart/mixed; boundary="===============6649229681105191693=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] acpi: broken suspend to RAM with v4.7-rc1
Date: Wed, 15 Jun 2016 06:05:00 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BBE2163@SHSMSX103.ccr.corp.intel.com>
In-Reply-To: CAJZ5v0jw=hvcYSOokPkHK+KgsLee9nc9Aj_33H37-3t7uNxX8w@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6649229681105191693==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, Rafael

> From: rjwysocki(a)gmail.com [mailto:rjwysocki(a)gmail.com] On Behalf Of
> Rafael J. Wysocki
> Subject: Re: acpi: broken suspend to RAM with v4.7-rc1
> =

> On Mon, Jun 13, 2016 at 12:07 PM, Andrey Skvortsov
> <andrej.skvortzov(a)gmail.com> wrote:
> > Hi Lv,
> >
> > On 13 Jun, Zheng, Lv wrote:
> >> > From: linux-acpi-owner(a)vger.kernel.org [mailto:linux-acpi-
> >> > owner(a)vger.kernel.org] On Behalf Of Rafael J. Wysocki
> >> > Subject: Re: acpi: broken suspend to RAM with v4.7-rc1
> >> >
> >> > On Saturday, June 11, 2016 01:49:22 PM Andrey Skvortsov wrote:
> >> > > On 10 Jun, Rafael J. Wysocki wrote:
> >> > > > On Friday, June 10, 2016 11:32:10 PM Andrey Skvortsov wrote:
> >> > > > > Hi,
> >> > > > >
> >> > > > > On my laptop (DELL Vostro 1500) in v4.7-rc1 is broken suspend
> to RAM.
> >> > > > > Laptop doesn't finish suspend to RAM process (disks are off, b=
ut
> >> > > > > WiFi and Power LEDs are still on). The only way to get it out =
of
> >> > > > > this state, is to turn the power off.
> >> > > > >
> >> > > > > I've bisected the issue to commit 66b1ed5aa8dd25
> >> > > > > [ACPICA: ACPI 2.0, Hardware: Add access_width/bit_offset
> support
> >> > > > > for acpi_hw_write()].
> >> > > > >
> >> > > > > If I revert this commit in v4.7-rc1 (or v4.7-rc2), suspend to =
RAM
> >> > > > > is working again.
> >> > > > >
> >> > > > > The cause of this problem is that after this commit write to
> PM1A
> >> > > > > Control Block (16-bit register) is done using two 8-bit writes.
> >> > > > > If I force this write to be 16-bit, then all is working as bef=
ore.
> >> > > > >
> >> > > > > To get it working 'access_width' for PM1A Control Block needs
> to
> >> > > > > be 2 (16-bit), but it's 1 (8-bit).
> >> [Lv Zheng]
> >> Could you send me the acpidump of the machine?
> > Here it is
> >
> https://dl.dropboxusercontent.com/u/24023626/dell_vostro_1500.acpid
> ump.bin
> >
> >> > > > >
> >> > > > > The root of the problem seems to be not the commit
> >> > 66b1ed5aa8dd25
> >> > > > > itself, but the ACPI tables in BIOS where wrong access_width
> >> > > > > comes from. I fixed problem in FACP  table, put it in initrd to
> >> > > > > override FACP table from BIOS. This fixed the issue, suspend to
> >> > > > > RAM is working now again.
> >> > > > >
> >> > > > > But I'm not sure whether is this proper fix for this problem.
> >> > > > > Is there any place in the kernel, where such ACPI quirks are
> placed?
> >> [Lv Zheng]
> >> My question would be:
> >> Does Windows behave correctly for this table?
> > Yes, suspend to RAM is working under Windows Vista.
> > IIRC it worked under Windows XP too.
> >
> >> However there is a real case showing that there are real tables need us
> to correctly support BitWidth/BitOffset.
> >> Here is the information for you to refer:
> >> http://permalink.gmane.org/gmane.linux.kernel.commits.head/313870
> >>
> >> > > >
> >> > > > Well, if the commit in question caused a problem to happen for
> you,
> >> > > > it also might cause similar problems to happen elsewhere.
> >> > > >
> >> > > > It looks like we'll need to revert that commit.
> >> > > Hi,
> >> > >
> >> > > or maybe to reset access_width AnyAcc from FACP table only for
> PM1A
> >> > > control register or even for all registers? This will fix the issu=
e too.
> >> >
> >> > That's a good idea actually.
> >> >
> >> > > diff --git a/drivers/acpi/acpica/tbfadt.c
> >> > > b/drivers/acpi/acpica/tbfadt.c index 6208069..a476e94 100644
> >> > > --- a/drivers/acpi/acpica/tbfadt.c
> >> > > +++ b/drivers/acpi/acpica/tbfadt.c
> >> > > @@ -714,7 +714,14 @@ static void
> acpi_tb_setup_fadt_registers(void)
> >> > >                         }
> >> > >                 }
> >> > >         }
> >> > >
> >> > > +       /*
> >> > > +        * Reset access_width in the GAS for PM1A control register=
 to
> >> > > +        * undefined value. Because in some cases this field conta=
ins
> >> > > +        * wrong value.
> >> > > +        */
> >> > > +       acpi_gbl_FADT.xpm1a_control_block.access_width =3D 0;
> >> >
> >> > OK, let's see what Bob and Lv think about that.
> >> [Lv Zheng]
> >> There is a commit in 4.7-rc2:
> >>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?i=
d=3D
> 7f9bef9d
> >> Have you tried if the problem still exists in 4.7-rc2?
> > I've just tried v4.7-rc3. It contains commit 7f9bef9d and the problem
> > exists there too.
> =

> I have decided to revert commit 66b1ed5aa8dd25 as in principle other
> registers may be similarly affected on other systems.
[Lv Zheng] =

Yes.
I didn't prepare fallback mechanism for this support.
It seems we have to do the reversion.
Please revert it.
Next time I'll prepare a quirk mechanism when this is upstreamed.

For Andrey:
Could you provide me the DMIdecode output of the machine?

Thanks
-Lv

> =

> Thanks,
> Rafael

--===============6649229681105191693==--

