Content-Type: multipart/mixed; boundary="===============6516515958859341518=="
MIME-Version: 1.0
From: kbuild test robot <lkp at intel.com>
Subject: [Devel] [pm:bleeding-edge 5/6] include/acpi/acoutput.h:153: warning:
 "ACPI_DEBUG_DEFAULT" redefined
Date: Wed, 20 Mar 2019 01:21:43 +0800
Message-ID: <201903200140.hxI0iNJ9%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6516515958859341518==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
 bleeding-edge
head:   5a044158d4606fdf905c4dfd3038db62d0b08537
commit: 3b06fd9bb2cf42d58eab47b3bd73af6cc6291545 [5/6] ACPI: bus: Use diffe=
rent default debug value than ACPICA
config: riscv-tinyconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 3b06fd9bb2cf42d58eab47b3bd73af6cc6291545
        # save the attached .config to linux build tree
        GCC_VERSION=3D8.1.0 make.cross ARCH=3Driscv =


All warnings (new ones prefixed by >>):

   In file included from include/acpi/acpi.h:29,
                    from include/linux/acpi.h:34,
                    from drivers/base/core.c:11:
>> include/acpi/acoutput.h:153: warning: "ACPI_DEBUG_DEFAULT" redefined
    #define ACPI_DEBUG_DEFAULT          (ACPI_LV_INIT | ACPI_LV_DEBUG_OBJEC=
T | ACPI_LV_EVALUATION | ACPI_LV_REPAIR)
    =

   In file included from include/acpi/platform/acenv.h:152,
                    from include/acpi/acpi.h:22,
                    from include/linux/acpi.h:34,
                    from drivers/base/core.c:11:
   include/acpi/platform/aclinux.h:88: note: this is the location of the pr=
evious definition
    #define ACPI_DEBUG_DEFAULT          (ACPI_LV_INFO | ACPI_LV_REPAIR)
    =


vim +/ACPI_DEBUG_DEFAULT +153 include/acpi/acoutput.h

^1da177e Linus Torvalds 2005-04-16  152  =

4c1379d7 Bob Moore      2018-12-13 @153  #define ACPI_DEBUG_DEFAULT        =
  (ACPI_LV_INIT | ACPI_LV_DEBUG_OBJECT | ACPI_LV_EVALUATION | ACPI_LV_REPAI=
R)
3a58176e Bob Moore      2009-12-11  154  #define ACPI_NORMAL_DEFAULT       =
  (ACPI_LV_INIT | ACPI_LV_DEBUG_OBJECT | ACPI_LV_REPAIR)
^1da177e Linus Torvalds 2005-04-16  155  #define ACPI_DEBUG_ALL            =
  (ACPI_LV_AML_DISASSEMBLE | ACPI_LV_ALL_EXCEPTIONS | ACPI_LV_ALL)
^1da177e Linus Torvalds 2005-04-16  156  =


:::::: The code at line 153 was first introduced by commit
:::::: 4c1379d7bb42fa664e0784539208ed74108c53f1 ACPICA: Debug output: Add o=
ption to display method/object evaluation

:::::: TO: Bob Moore <robert.moore(a)intel.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki(a)intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Cent=
er
https://lists.01.org/pipermail/kbuild-all                   Intel Corporati=
on

--===============6516515958859341518==
Content-Type: application/gzip
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config.gz"

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
OB9ABHEIyT6vx7xFnU//P1/xOAnNOwAA
--===============6516515958859341518==--

