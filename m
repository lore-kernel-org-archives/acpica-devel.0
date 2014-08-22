Content-Type: multipart/mixed; boundary="===============4699031789527464556=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] kernel boot fail with efi earlyprintk (bisected)
Date: Fri, 22 Aug 2014 01:43:37 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E880265EF49@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 20140821205224.GJ29733@console-pimps.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4699031789527464556==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

There is only limited entries in the x86 early mapping which is implemented=
 by the FIXMAP.
So this means for all __init call invoked for x86, if there was a early map=
ping in it, it should be unmapped before exiting the __init call.

Using this rule, all __init call implementers can make sure that before ent=
ering the __init call, the limited number of FIXMAP entries is enough.

The following bisected commit just increase early mapping times from 1 to 2=
 in ACPICA early table handling code.
The number of 2 is less than the number of available FIXMAP entries.
And ACPICA code has ensured that all mappings are correctly unmapped after =
the table initialization.
So we didn't break the rule.

We can offer a workaround in ACPICA to reduce mapping count from 2 to 1 usi=
ng a global option.
But since this report sounds like that the root cause is earlyprintk=3Defi =
has broken the above rule and the existing issue is triggered by this clean=
up.
So could someone check the earlyprintk=3Defi code first?
I think earlyprintk=3Defi should either unmap the increased mapping or incr=
ease the number of FIXMAP entries in case earlyprintk=3Defi need additional=
 early mappings.
Otherwise it will always be chances for earlyprintk=3Defi to break future c=
ode.

Thanks and best regards
-Lv

> From: Matt Fleming [mailto:matt(a)console-pimps.org]
> Sent: Friday, August 22, 2014 4:52 AM
> =

> On Tue, 19 Aug, at 04:16:58PM, Dave Young wrote:
> > Hi,
> >
> > 3.16 kernel boot fail with earlyprintk=3Defi on my laptop.
> > It keeps scrolling at the bottom line of screen.
> >
> > Bisected, the first bad commit is below:
> > commit 86dfc6f339886559d80ee0d4bd20fe5ee90450f0
> > Author: Lv Zheng <lv.zheng(a)intel.com>
> > Date:   Fri Apr 4 12:38:57 2014 +0800
> >
> >     ACPICA: Tables: Fix table checksums verification before installatio=
n.
> >
> >
> > I did some debugging by enabling both serial and efi earlyprintk, below=
 is
> > some debug dmesg, seems early_ioremap fails in scroll up function due to
> > no free slot, but I'm still not sure if the debug info is right or not.
> =

> Thanks Dave, your callstack seems to make sense.
> =

> Can you also enable early_ioremap_debug so that we can figure out where
> all the FIXMAP slots are going?
> =

> --
> Matt Fleming, Intel Open Source Technology Center

--===============4699031789527464556==--

