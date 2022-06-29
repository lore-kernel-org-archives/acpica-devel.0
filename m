Content-Type: multipart/mixed; boundary="===============9028653098008885175=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [rafael-pm:bleeding-edge] BUILD REGRESSION
 4035647418c1b31bcc12e6cfafc01f61f0c649ea
Date: Wed, 29 Jun 2022 12:04:06 +0800
Message-ID: <62bbcf36.pFBdqnxFoqglQFOC%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============9028653098008885175==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-p=
m.git bleeding-edge
branch HEAD: 4035647418c1b31bcc12e6cfafc01f61f0c649ea  Merge branch 'acpi-b=
us' into linux-next

Error/Warning reports:

https://lore.kernel.org/linux-acpi/202206281146.iWj1cpqY-lkp(a)intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/bus/hisi_lpc.c:488:41: error: 'struct acpi_device' has no member na=
med 'children'
drivers/bus/hisi_lpc.c:488:53: error: 'struct acpi_device' has no member na=
med 'node'; did you mean 'fwnode'?

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-allyesconfig
|   |-- drivers-bus-hisi_lpc.c:error:struct-acpi_device-has-no-member-named=
-children
|   `-- drivers-bus-hisi_lpc.c:error:struct-acpi_device-has-no-member-named=
-node
`-- ia64-allmodconfig
    |-- drivers-bus-hisi_lpc.c:error:struct-acpi_device-has-no-member-named=
-children
    `-- drivers-bus-hisi_lpc.c:error:struct-acpi_device-has-no-member-named=
-node

elapsed time: 722m

configs tested: 70
configs skipped: 2

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-c001-20220627
powerpc                      ppc40x_defconfig
arm                        realview_defconfig
arm                            pleb_defconfig
parisc64                            defconfig
arm                          pxa910_defconfig
ia64                         bigsur_defconfig
arm                       aspeed_g5_defconfig
sh                   sh7770_generic_defconfig
arc                            hsdk_defconfig
arm                         cm_x300_defconfig
riscv                            allyesconfig
ia64                             allmodconfig
x86_64               randconfig-k001-20220627
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
x86_64               randconfig-a012-20220627
x86_64               randconfig-a016-20220627
x86_64               randconfig-a011-20220627
x86_64               randconfig-a013-20220627
x86_64               randconfig-a014-20220627
x86_64               randconfig-a015-20220627
i386                 randconfig-a014-20220627
i386                 randconfig-a011-20220627
i386                 randconfig-a012-20220627
i386                 randconfig-a015-20220627
i386                 randconfig-a016-20220627
i386                 randconfig-a013-20220627
arc                  randconfig-r043-20220627
s390                 randconfig-r044-20220627
riscv                randconfig-r042-20220627
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func

clang tested configs:
arm                      pxa255-idp_defconfig
arm                            dove_defconfig
x86_64               randconfig-a004-20220627
x86_64               randconfig-a006-20220627
x86_64               randconfig-a001-20220627
x86_64               randconfig-a005-20220627
x86_64               randconfig-a002-20220627
x86_64               randconfig-a003-20220627
i386                 randconfig-a002-20220627
i386                 randconfig-a004-20220627
i386                 randconfig-a003-20220627
i386                 randconfig-a001-20220627
i386                 randconfig-a005-20220627
i386                 randconfig-a006-20220627
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220627
hexagon              randconfig-r045-20220627

-- =

0-DAY CI Kernel Test Service
https://01.org/lkp
--===============9028653098008885175==--

