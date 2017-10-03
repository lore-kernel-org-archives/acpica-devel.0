Content-Type: multipart/mixed; boundary="===============2368622058835792765=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [pm:bleeding-edge 12/41] utstrsuppt.c:undefined reference
 to `__udivdi3'
Date: Tue, 03 Oct 2017 19:41:23 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E6130BD@ORSMSX110.amr.corp.intel.com>
In-Reply-To: CAJZ5v0inoxc0KXF87CZXoD_nzNwgcTMf=BLbQfM+fGT5ks0v4Q@mail.gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2368622058835792765==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: rjwysocki(a)gmail.com [mailto:rjwysocki(a)gmail.com] On Behalf Of
> Rafael J. Wysocki
> Sent: Tuesday, October 3, 2017 11:21 AM
> To: Moore, Robert <robert.moore(a)intel.com>
> Cc: Rafael J. Wysocki <rjw(a)rjwysocki.net>; Zheng, Lv
> <lv.zheng(a)intel.com>; Wu, Fengguang <fengguang.wu(a)intel.com>; kbuild-
> all(a)01.org; linux-acpi(a)vger.kernel.org; devel(a)acpica.org; linux-
> pm(a)vger.kernel.org
> Subject: Re: [pm:bleeding-edge 12/41] utstrsuppt.c:undefined reference
> to `__udivdi3'
> =

> On Tue, Oct 3, 2017 at 6:43 PM, Moore, Robert <robert.moore(a)intel.com>
> wrote:
> >
> >
> >> -----Original Message-----
> >> From: Rafael J. Wysocki [mailto:rjw(a)rjwysocki.net]
> >> Sent: Tuesday, October 3, 2017 4:32 AM
> >> To: Moore, Robert <robert.moore(a)intel.com>; Zheng, Lv
> >> <lv.zheng(a)intel.com>
> >> Cc: Wu, Fengguang <fengguang.wu(a)intel.com>; kbuild-all(a)01.org; lin=
ux-
> >> acpi(a)vger.kernel.org; devel(a)acpica.org; linux-pm(a)vger.kernel.org
> >> Subject: Re: [pm:bleeding-edge 12/41] utstrsuppt.c:undefined
> >> reference to `__udivdi3'
> >>
> >> On Tuesday, October 3, 2017 4:25:52 AM CEST kbuild test robot wrote:
> >> > tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-
> >> pm.git bleeding-edge
> >> > head:   09b089a247ea7272df93a2116368bf24b656cd65
> >> > commit: 05545b3fb6eab35290413211617793bc274e136b [12/41] ACPICA:
> >> Restructure/cleanup all string-to-integer conversion functions
> >> > config: i386-defconfig (attached as .config)
> >> > compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> >> > reproduce:
> >> >         git checkout 05545b3fb6eab35290413211617793bc274e136b
> >> >         # save the attached .config to linux build tree
> >> >         make ARCH=3Di386
> >> >
> >> > All errors (new ones prefixed by >>):
> >> >
> >> >    drivers/acpi/acpica/utstrsuppt.o: In function
> >> `acpi_ut_insert_digit':
> >> > >> utstrsuppt.c:(.text+0x33): undefined reference to `__udivdi3'
> >>
> >> __udivdi3() doesn't work on 32-bit x86 AFAICS.
> >>
> >> Can we avoid using it or at least put it under #ifdef somehow?
> > [Moore, Robert]
> >
> >
> > I take it that __udivdi3 is a 64-bit divide?
> =

> Practically, yes (AFAICS).
> =

> > We do have a local divide implementation(s) for things like this.
> >
> > However, I don't see a divide in ut_insert_digit; There is a 64-bit
> divide in ut_strtoul_add_64, however.
[Moore, Robert] =


Oops, sorry. The divided is in strtoul_multiply_64. We are checking for an =
overflow condition up front.

> >
> > So, there are no issues with 64-bit add, subtract, and multiply?
> =

> The only problematic one I know of is __udivdi3().

--===============2368622058835792765==--

