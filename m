Content-Type: multipart/mixed; boundary="===============6611961000033580179=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rjw at rjwysocki.net>
Subject: Re: [Devel] [pm:bleeding-edge 12/41] utstrsuppt.c:undefined reference
 to `__udivdi3'
Date: Tue, 03 Oct 2017 13:31:47 +0200
Message-ID: <2859755.8uSvH3hIdc@aspire.rjw.lan>
In-Reply-To: 201710031050.2Iy92vzG%fengguang.wu@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6611961000033580179==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tuesday, October 3, 2017 4:25:52 AM CEST kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it bleeding-edge
> head:   09b089a247ea7272df93a2116368bf24b656cd65
> commit: 05545b3fb6eab35290413211617793bc274e136b [12/41] ACPICA: Restruct=
ure/cleanup all string-to-integer conversion functions
> config: i386-defconfig (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         git checkout 05545b3fb6eab35290413211617793bc274e136b
>         # save the attached .config to linux build tree
>         make ARCH=3Di386 =

> =

> All errors (new ones prefixed by >>):
> =

>    drivers/acpi/acpica/utstrsuppt.o: In function `acpi_ut_insert_digit':
> >> utstrsuppt.c:(.text+0x33): undefined reference to `__udivdi3'

__udivdi3() doesn't work on 32-bit x86 AFAICS.

Can we avoid using it or at least put it under #ifdef somehow?

Thanks,
Rafael


--===============6611961000033580179==--

