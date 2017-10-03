Content-Type: multipart/mixed; boundary="===============6623738160595487883=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [pm:bleeding-edge 12/41] utstrsuppt.c:undefined reference
 to `__udivdi3'
Date: Tue, 03 Oct 2017 16:43:42 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E613050@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 2859755.8uSvH3hIdc@aspire.rjw.lan
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6623738160595487883==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw(a)rjwysocki.net]
> Sent: Tuesday, October 3, 2017 4:32 AM
> To: Moore, Robert <robert.moore(a)intel.com>; Zheng, Lv
> <lv.zheng(a)intel.com>
> Cc: Wu, Fengguang <fengguang.wu(a)intel.com>; kbuild-all(a)01.org; linux-
> acpi(a)vger.kernel.org; devel(a)acpica.org; linux-pm(a)vger.kernel.org
> Subject: Re: [pm:bleeding-edge 12/41] utstrsuppt.c:undefined reference
> to `__udivdi3'
> =

> On Tuesday, October 3, 2017 4:25:52 AM CEST kbuild test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-
> pm.git bleeding-edge
> > head:   09b089a247ea7272df93a2116368bf24b656cd65
> > commit: 05545b3fb6eab35290413211617793bc274e136b [12/41] ACPICA:
> Restructure/cleanup all string-to-integer conversion functions
> > config: i386-defconfig (attached as .config)
> > compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> > reproduce:
> >         git checkout 05545b3fb6eab35290413211617793bc274e136b
> >         # save the attached .config to linux build tree
> >         make ARCH=3Di386
> >
> > All errors (new ones prefixed by >>):
> >
> >    drivers/acpi/acpica/utstrsuppt.o: In function
> `acpi_ut_insert_digit':
> > >> utstrsuppt.c:(.text+0x33): undefined reference to `__udivdi3'
> =

> __udivdi3() doesn't work on 32-bit x86 AFAICS.
> =

> Can we avoid using it or at least put it under #ifdef somehow?
[Moore, Robert] =



I take it that __udivdi3 is a 64-bit divide?
We do have a local divide implementation(s) for things like this.

However, I don't see a divide in ut_insert_digit; There is a 64-bit divide =
in ut_strtoul_add_64, however.

So, there are no issues with 64-bit add, subtract, and multiply?



> =

> Thanks,
> Rafael


--===============6623738160595487883==--

