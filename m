Content-Type: multipart/mixed; boundary="===============7591486273595576875=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] kernel boot fail with efi earlyprintk (bisected)
Date: Fri, 22 Aug 2014 05:55:42 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E880265F008@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 20140821205224.GJ29733@console-pimps.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7591486273595576875==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I checked the arch/x86/platform/efi/early_printk.c.
In early_efi_scroll_up(), 2 mapping entries will be used for the src/dst sc=
reen buffer.
In drivers/acpi/acpica/tbutils.c, we've improved the early table loading co=
de in acpi_tb_parse_root_table().
We now need 2 mapping entries:
1. One mapping entry is used for RSDT table mapping. Each RSDT entry contai=
ns an address for another ACPI table.
2. For each entry in RSDP, we need another mapping entry to map the table t=
o perform necessary check/override before installing it.

When acpi_tb_parse_root_table() prints something through EFI earlyprintk co=
nsole, we'll have 4 mapping entries used.
The current 4 slots setting of early_ioremap() seems to be too small for su=
ch a use case.

I'm not 100% sure if this is the cause.
If it's the cause and we think both of the mappings are reasonable, we can =
simply increase the FIX_BITMAPS_SLOTS defined in arch/x86/include/asm/fixma=
p.h.

What do you think of this?

Thanks and best regards
-Lv

> From: Zheng, Lv
> Sent: Friday, August 22, 2014 9:43 AM
> =

> Hi,
> =

> There is only limited entries in the x86 early mapping which is implement=
ed by the FIXMAP.
> So this means for all __init call invoked for x86, if there was a early m=
apping in it, it should be unmapped before exiting the __init call.
> =

> Using this rule, all __init call implementers can make sure that before e=
ntering the __init call, the limited number of FIXMAP entries is
> enough.
> =

> The following bisected commit just increase early mapping times from 1 to=
 2 in ACPICA early table handling code.
> The number of 2 is less than the number of available FIXMAP entries.
> And ACPICA code has ensured that all mappings are correctly unmapped afte=
r the table initialization.
> So we didn't break the rule.
> =

> We can offer a workaround in ACPICA to reduce mapping count from 2 to 1 u=
sing a global option.
> But since this report sounds like that the root cause is earlyprintk=3Def=
i has broken the above rule and the existing issue is triggered by
> this cleanup.
> So could someone check the earlyprintk=3Defi code first?
> I think earlyprintk=3Defi should either unmap the increased mapping or in=
crease the number of FIXMAP entries in case earlyprintk=3Defi
> need additional early mappings.
> Otherwise it will always be chances for earlyprintk=3Defi to break future=
 code.
> =

> Thanks and best regards
> -Lv
> =

> > From: Matt Fleming [mailto:matt(a)console-pimps.org]
> > Sent: Friday, August 22, 2014 4:52 AM
> >
> > On Tue, 19 Aug, at 04:16:58PM, Dave Young wrote:
> > > Hi,
> > >
> > > 3.16 kernel boot fail with earlyprintk=3Defi on my laptop.
> > > It keeps scrolling at the bottom line of screen.
> > >
> > > Bisected, the first bad commit is below:
> > > commit 86dfc6f339886559d80ee0d4bd20fe5ee90450f0
> > > Author: Lv Zheng <lv.zheng(a)intel.com>
> > > Date:   Fri Apr 4 12:38:57 2014 +0800
> > >
> > >     ACPICA: Tables: Fix table checksums verification before installat=
ion.
> > >
> > >
> > > I did some debugging by enabling both serial and efi earlyprintk, bel=
ow is
> > > some debug dmesg, seems early_ioremap fails in scroll up function due=
 to
> > > no free slot, but I'm still not sure if the debug info is right or no=
t.
> >
> > Thanks Dave, your callstack seems to make sense.
> >
> > Can you also enable early_ioremap_debug so that we can figure out where
> > all the FIXMAP slots are going?
> >
> > --
> > Matt Fleming, Intel Open Source Technology Center

--===============7591486273595576875==--

