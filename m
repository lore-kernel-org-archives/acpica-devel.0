Content-Type: multipart/mixed; boundary="===============7864824320757694431=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rjw at rjwysocki.net>
Subject: Re: [Devel] [pm:bleeding-edge 12/41] utstrsuppt.c:undefined reference
 to `__udivdi3'
Date: Tue, 03 Oct 2017 23:07:26 +0200
Message-ID: <7672294.bGB5UuPiJL@aspire.rjw.lan>
In-Reply-To: 1939602.aFdyoUdUJn@aspire.rjw.lan
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7864824320757694431==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tuesday, October 3, 2017 10:50:11 PM CEST Rafael J. Wysocki wrote:
> On Tuesday, October 3, 2017 9:41:23 PM CEST Moore, Robert wrote:
> > =

> > > -----Original Message-----
> > > From: rjwysocki(a)gmail.com [mailto:rjwysocki(a)gmail.com] On Behalf =
Of
> > > Rafael J. Wysocki
> > > Sent: Tuesday, October 3, 2017 11:21 AM
> > > To: Moore, Robert <robert.moore(a)intel.com>
> > > Cc: Rafael J. Wysocki <rjw(a)rjwysocki.net>; Zheng, Lv
> > > <lv.zheng(a)intel.com>; Wu, Fengguang <fengguang.wu(a)intel.com>; kbu=
ild-
> > > all(a)01.org; linux-acpi(a)vger.kernel.org; devel(a)acpica.org; linux-
> > > pm(a)vger.kernel.org
> > > Subject: Re: [pm:bleeding-edge 12/41] utstrsuppt.c:undefined reference
> > > to `__udivdi3'
> > > =

> > > On Tue, Oct 3, 2017 at 6:43 PM, Moore, Robert <robert.moore(a)intel.c=
om>
> > > wrote:
> > > >
> > > >
> > > >> -----Original Message-----
> > > >> From: Rafael J. Wysocki [mailto:rjw(a)rjwysocki.net]
> > > >> Sent: Tuesday, October 3, 2017 4:32 AM
> > > >> To: Moore, Robert <robert.moore(a)intel.com>; Zheng, Lv
> > > >> <lv.zheng(a)intel.com>
> > > >> Cc: Wu, Fengguang <fengguang.wu(a)intel.com>; kbuild-all(a)01.org;=
 linux-
> > > >> acpi(a)vger.kernel.org; devel(a)acpica.org; linux-pm(a)vger.kernel=
.org
> > > >> Subject: Re: [pm:bleeding-edge 12/41] utstrsuppt.c:undefined
> > > >> reference to `__udivdi3'
> > > >>
> > > >> On Tuesday, October 3, 2017 4:25:52 AM CEST kbuild test robot wrot=
e:
> > > >> > tree:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-
> > > >> pm.git bleeding-edge
> > > >> > head:   09b089a247ea7272df93a2116368bf24b656cd65
> > > >> > commit: 05545b3fb6eab35290413211617793bc274e136b [12/41] ACPICA:
> > > >> Restructure/cleanup all string-to-integer conversion functions
> > > >> > config: i386-defconfig (attached as .config)
> > > >> > compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> > > >> > reproduce:
> > > >> >         git checkout 05545b3fb6eab35290413211617793bc274e136b
> > > >> >         # save the attached .config to linux build tree
> > > >> >         make ARCH=3Di386
> > > >> >
> > > >> > All errors (new ones prefixed by >>):
> > > >> >
> > > >> >    drivers/acpi/acpica/utstrsuppt.o: In function
> > > >> `acpi_ut_insert_digit':
> > > >> > >> utstrsuppt.c:(.text+0x33): undefined reference to `__udivdi3'
> > > >>
> > > >> __udivdi3() doesn't work on 32-bit x86 AFAICS.
> > > >>
> > > >> Can we avoid using it or at least put it under #ifdef somehow?
> > > > [Moore, Robert]
> > > >
> > > >
> > > > I take it that __udivdi3 is a 64-bit divide?
> > > =

> > > Practically, yes (AFAICS).
> > > =

> > > > We do have a local divide implementation(s) for things like this.
> > > >
> > > > However, I don't see a divide in ut_insert_digit; There is a 64-bit
> > > divide in ut_strtoul_add_64, however.
> > [Moore, Robert] =

> > =

> > Oops, sorry. The divided is in strtoul_multiply_64. We are checking for=
 an
> > overflow condition up front.
> =

> But this is a plain division, so it looks like a build system or compiler=
 issue
> to me.

Well, OK.  Plain u64 / u64 divisions need to be avoided for stuff to build =
on
32-bit x86.

Thanks,
Rafael


--===============7864824320757694431==--

