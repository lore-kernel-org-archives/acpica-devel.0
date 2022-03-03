Content-Type: multipart/mixed; boundary="===============8440494983102162799=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [rafael-pm:bleeding-edge 113/118]
 arch/x86/kernel/acpi/boot.c:1394 (null)() error: buffer overflow
 '(acpi_dmi_table[6])->matches' 4 <= 4
Date: Thu, 03 Mar 2022 13:02:58 +0100
Message-ID: <CAJZ5v0jUyneipaAU+xhJnO-Dce8RC6O9Un_Ly0vLiNyrj6eYXg@mail.gmail.com>
In-Reply-To: 202203021037.WWnG44C5-lkp@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8440494983102162799==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 3, 2022 at 12:52 PM Dan Carpenter <dan.carpenter(a)oracle.com> =
wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it bleeding-edge
> head:   f7307721a01f4f14d21c699b270a870370cf34b9
> commit: ed00b2b8d737f87a2437d7bd7c7f90124b50da05 [113/118] x86 / ACPI: Wo=
rk around broken XSDT on SEGA AALE board

Yes, this commit has been dropped already.

> config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/2=
0220302/202203021037.WWnG44C5-lkp(a)intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

Thanks!
--===============8440494983102162799==--

