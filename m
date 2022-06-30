Content-Type: multipart/mixed; boundary="===============0352363264986292136=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [rafael-pm:bleeding-edge] BUILD REGRESSION
 7451d4b13852834afd17b629fb7d4410cefba74c
Date: Thu, 30 Jun 2022 15:13:45 +0800
Message-ID: <62bd4d29.JCwObo7lyXJuQtt0%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0352363264986292136==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-p=
m.git bleeding-edge
branch HEAD: 7451d4b13852834afd17b629fb7d4410cefba74c  Merge branch 'acpi-a=
pei' into bleeding-edge

Error/Warning reports:

https://lore.kernel.org/linux-acpi/202206281146.iWj1cpqY-lkp(a)intel.com
https://lore.kernel.org/linux-acpi/202206301543.JpCxX65V-lkp(a)intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/bus/hisi_lpc.c:511:41: error: 'struct acpi_device' has no member na=
med 'children'
drivers/bus/hisi_lpc.c:511:53: error: 'struct acpi_device' has no member na=
med 'node'; did you mean 'fwnode'?
include/linux/compiler_types.h:293:27: error: expression in static assertio=
n is not an integer

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-allyesconfig
|   |-- drivers-bus-hisi_lpc.c:error:struct-acpi_device-has-no-member-named=
-children
|   `-- drivers-bus-hisi_lpc.c:error:struct-acpi_device-has-no-member-named=
-node
|-- ia64-allmodconfig
|   |-- drivers-bus-hisi_lpc.c:error:struct-acpi_device-has-no-member-named=
-children
|   |-- drivers-bus-hisi_lpc.c:error:struct-acpi_device-has-no-member-named=
-node
|   `-- include-linux-compiler_types.h:error:expression-in-static-assertion=
-is-not-an-integer
`-- ia64-allyesconfig
    |-- drivers-bus-hisi_lpc.c:error:struct-acpi_device-has-no-member-named=
-children
    `-- drivers-bus-hisi_lpc.c:error:struct-acpi_device-has-no-member-named=
-node

elapsed time: 722m

configs tested: 52
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
ia64                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a004
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220629
s390                 randconfig-r044-20220629
riscv                randconfig-r042-20220629
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r045-20220629
hexagon              randconfig-r041-20220629

-- =

0-DAY CI Kernel Test Service
https://01.org/lkp
--===============0352363264986292136==--

