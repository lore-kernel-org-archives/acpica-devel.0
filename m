Content-Type: multipart/mixed; boundary="===============1324943062966044119=="
MIME-Version: 1.0
From: Zheng, Lv <lv.zheng at intel.com>
Subject: Re: [Devel] kernel boot fail with efi earlyprintk (bisected)
Date: Mon, 25 Aug 2014 06:34:08 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E880265F57B@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: 20140825060713.GA4011@darkstar.nay.redhat.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1324943062966044119==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> From: Dave Young [mailto:dyoung(a)redhat.com]
> Sent: Monday, August 25, 2014 2:07 PM
> To: Matt Fleming
> Cc: Zheng, Lv; Fleming, Matt; linux-efi(a)vger.kernel.org; linux-acpi(a)v=
ger.kernel.org; linux-kernel(a)vger.kernel.org; devel(a)acpica.org;
> lenb(a)kernel.org; Wysocki, Rafael J; Moore, Robert
> Subject: Re: kernel boot fail with efi earlyprintk (bisected)
> =

> On 08/22/14 at 06:02pm, Dave Young wrote:
> > On 08/21/14 at 09:52pm, Matt Fleming wrote:
> > > On Tue, 19 Aug, at 04:16:58PM, Dave Young wrote:
> > > > Hi,
> > > >
> > > > 3.16 kernel boot fail with earlyprintk=3Defi on my laptop.
> > > > It keeps scrolling at the bottom line of screen.
> > > >
> > > > Bisected, the first bad commit is below:
> > > > commit 86dfc6f339886559d80ee0d4bd20fe5ee90450f0
> > > > Author: Lv Zheng <lv.zheng(a)intel.com>
> > > > Date:   Fri Apr 4 12:38:57 2014 +0800
> > > >
> > > >     ACPICA: Tables: Fix table checksums verification before install=
ation.
> > > >
> > > >
> > > > I did some debugging by enabling both serial and efi earlyprintk, b=
elow is
> > > > some debug dmesg, seems early_ioremap fails in scroll up function d=
ue to
> > > > no free slot, but I'm still not sure if the debug info is right or =
not.
> > >
> > > Thanks Dave, your callstack seems to make sense.
> > >
> > > Can you also enable early_ioremap_debug so that we can figure out whe=
re
> > > all the FIXMAP slots are going?
> >
> > With early_ioremap_debug enabled, there will be a lot of "dropped print=
k", so
> > I can not get any useful information.
> >
> > Will try to do more debug.
> =

> early_ioremap_debug does not work because we are debugging early_printk b=
ut
> early_ioremap_debug itself will print warning message at the same time.
> =

> Tried what Lv mentioned, increasing the early ioremap slots does help.

Could you send a tested patch to linux-acpi(a)vger.kermel.org for this?
I think the number of early mapping slots need to be increased by 1 because=
 of this case.

Thanks and best regards
-Lv

--===============1324943062966044119==--

