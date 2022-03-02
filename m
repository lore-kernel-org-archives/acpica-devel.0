Content-Type: multipart/mixed; boundary="===============0288691294897589500=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [rafael-pm:bleeding-edge 113/118]
 include/linux/mod_devicetable.h:587:25: warning: excess elements in array
 initializer
Date: Wed, 02 Mar 2022 10:51:10 +0800
Message-ID: <202203020750.Uq6hGay2-lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0288691294897589500==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
 bleeding-edge
head:   f7307721a01f4f14d21c699b270a870370cf34b9
commit: ed00b2b8d737f87a2437d7bd7c7f90124b50da05 [113/118] x86 / ACPI: Work=
 around broken XSDT on SEGA AALE board
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220=
302/202203020750.Uq6hGay2-lkp(a)intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=3D1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it/commit/?id=3Ded00b2b8d737f87a2437d7bd7c7f90124b50da05
        git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kerne=
l/git/rafael/linux-pm.git
        git fetch --no-tags rafael-pm bleeding-edge
        git checkout ed00b2b8d737f87a2437d7bd7c7f90124b50da05
        # save the config file to linux build tree
        mkdir build_dir
        make W=3D1 O=3Dbuild_dir ARCH=3Di386 SHELL=3D/bin/bash arch/x86/ker=
nel/acpi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp(a)intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/of.h:18,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from arch/x86/kernel/acpi/boot.c:11:
>> include/linux/mod_devicetable.h:587:25: warning: excess elements in arra=
y initializer
     587 | #define DMI_MATCH(a, b) { .slot =3D a, .substr =3D b }
         |                         ^
   arch/x86/kernel/acpi/boot.c:1476:8: note: in expansion of macro 'DMI_MAT=
CH'
    1476 |        DMI_MATCH(DMI_BIOS_DATE, "02/01/2011"),
         |        ^~~~~~~~~
   include/linux/mod_devicetable.h:587:25: note: (near initialization for '=
acpi_dmi_table[6].matches')
     587 | #define DMI_MATCH(a, b) { .slot =3D a, .substr =3D b }
         |                         ^
   arch/x86/kernel/acpi/boot.c:1476:8: note: in expansion of macro 'DMI_MAT=
CH'
    1476 |        DMI_MATCH(DMI_BIOS_DATE, "02/01/2011"),
         |        ^~~~~~~~~


vim +587 include/linux/mod_devicetable.h

d945b697d0eea5 David Woodhouse 2008-09-16  586  =

5017b2851373ee Jani Nikula     2013-07-03 @587  #define DMI_MATCH(a, b)	{ .=
slot =3D a, .substr =3D b }
5017b2851373ee Jani Nikula     2013-07-03  588  #define DMI_EXACT_MATCH(a, =
b)	{ .slot =3D a, .substr =3D b, .exact_match =3D 1 }
d2653e92732bd3 Jean Delvare    2008-04-29  589  =


:::::: The code at line 587 was first introduced by commit
:::::: 5017b2851373ee15c7035151853bb1448800cae2 dmi: add support for exact =
DMI matches in addition to substring matching

:::::: TO: Jani Nikula <jani.nikula(a)intel.com>
:::::: CC: Linus Torvalds <torvalds(a)linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org
--===============0288691294897589500==--

