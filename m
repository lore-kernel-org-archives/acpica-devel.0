Content-Type: multipart/mixed; boundary="===============5176055527202469218=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [rafael-pm:bleeding-edge] BUILD REGRESSION
 ecfa396ef37aea5cf4b20db57585af16b110ac6b
Date: Sun, 25 Sep 2022 15:37:02 +0800
Message-ID: <6330051e.S6XR1bK2uaiN/0Gq%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5176055527202469218==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-p=
m.git bleeding-edge
branch HEAD: ecfa396ef37aea5cf4b20db57585af16b110ac6b  Merge branch 'powerc=
ap' into bleeding-edge

Error/Warning reports:

https://lore.kernel.org/linux-acpi/202209250438.1vajrE1K-lkp(a)intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/acpi/sleep.c:1096:28: error: use of undeclared identifier 'SYS_OFF_=
MODE_RESTART_PREPARE'
drivers/acpi/sleep.c:1096:42: error: 'SYS_OFF_MODE_RESTART_PREPARE' undecla=
red (first use in this function); did you mean 'SYS_OFF_MODE_RESTART'?

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-allyesconfig
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-=
(first-use-in-this-function)
|-- i386-defconfig
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-=
(first-use-in-this-function)
|-- i386-randconfig-a001
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-=
(first-use-in-this-function)
|-- i386-randconfig-a003
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-=
(first-use-in-this-function)
|-- i386-randconfig-a005
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-=
(first-use-in-this-function)
|-- i386-randconfig-a012
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-=
(first-use-in-this-function)
|-- i386-randconfig-a014
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-=
(first-use-in-this-function)
|-- i386-randconfig-a016
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-=
(first-use-in-this-function)
|-- ia64-allmodconfig
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-=
(first-use-in-this-function)
|-- ia64-randconfig-r014-20220925
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-=
(first-use-in-this-function)
|-- loongarch-allyesconfig
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-=
(first-use-in-this-function)
|-- x86_64-allmodconfig
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-=
(first-use-in-this-function)
|-- x86_64-allyesconfig
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-=
(first-use-in-this-function)
|-- x86_64-defconfig
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-=
(first-use-in-this-function)
|-- x86_64-randconfig-a002
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-=
(first-use-in-this-function)
|-- x86_64-randconfig-a004
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-=
(first-use-in-this-function)
|-- x86_64-randconfig-a006
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-=
(first-use-in-this-function)
|-- x86_64-randconfig-a011
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-=
(first-use-in-this-function)
|-- x86_64-randconfig-a013
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-=
(first-use-in-this-function)
|-- x86_64-randconfig-a015
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-=
(first-use-in-this-function)
|-- x86_64-rhel-8.3
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-=
(first-use-in-this-function)
|-- x86_64-rhel-8.3-kunit
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-=
(first-use-in-this-function)
|-- x86_64-rhel-8.3-kvm
|   `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-=
(first-use-in-this-function)
`-- x86_64-rhel-8.3-syz
    `-- drivers-acpi-sleep.c:error:SYS_OFF_MODE_RESTART_PREPARE-undeclared-=
(first-use-in-this-function)
clang_recent_errors
|-- i386-randconfig-a002
|   `-- drivers-acpi-sleep.c:error:use-of-undeclared-identifier-SYS_OFF_MOD=
E_RESTART_PREPARE
|-- i386-randconfig-a004
|   `-- drivers-acpi-sleep.c:error:use-of-undeclared-identifier-SYS_OFF_MOD=
E_RESTART_PREPARE
|-- i386-randconfig-a006
|   `-- drivers-acpi-sleep.c:error:use-of-undeclared-identifier-SYS_OFF_MOD=
E_RESTART_PREPARE
|-- i386-randconfig-a011
|   `-- drivers-acpi-sleep.c:error:use-of-undeclared-identifier-SYS_OFF_MOD=
E_RESTART_PREPARE
|-- i386-randconfig-a013
|   `-- drivers-acpi-sleep.c:error:use-of-undeclared-identifier-SYS_OFF_MOD=
E_RESTART_PREPARE
|-- i386-randconfig-a015
|   `-- drivers-acpi-sleep.c:error:use-of-undeclared-identifier-SYS_OFF_MOD=
E_RESTART_PREPARE
|-- x86_64-randconfig-a001
|   `-- drivers-acpi-sleep.c:error:use-of-undeclared-identifier-SYS_OFF_MOD=
E_RESTART_PREPARE
|-- x86_64-randconfig-a003
|   `-- drivers-acpi-sleep.c:error:use-of-undeclared-identifier-SYS_OFF_MOD=
E_RESTART_PREPARE
|-- x86_64-randconfig-a005
|   `-- drivers-acpi-sleep.c:error:use-of-undeclared-identifier-SYS_OFF_MOD=
E_RESTART_PREPARE
|-- x86_64-randconfig-a012
|   `-- drivers-acpi-sleep.c:error:use-of-undeclared-identifier-SYS_OFF_MOD=
E_RESTART_PREPARE
|-- x86_64-randconfig-a014
|   `-- drivers-acpi-sleep.c:error:use-of-undeclared-identifier-SYS_OFF_MOD=
E_RESTART_PREPARE
`-- x86_64-randconfig-a016
    `-- drivers-acpi-sleep.c:error:use-of-undeclared-identifier-SYS_OFF_MOD=
E_RESTART_PREPARE

elapsed time: 725m

configs tested: 58
configs skipped: 2

gcc tested configs:
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arm                                 defconfig
arm64                            allyesconfig
arc                  randconfig-r043-20220925
arm                              allyesconfig
riscv                randconfig-r042-20220925
s390                 randconfig-r044-20220925
i386                                defconfig
i386                             allyesconfig
arc                                 defconfig
s390                             allmodconfig
um                             i386_defconfig
alpha                               defconfig
um                           x86_64_defconfig
s390                                defconfig
powerpc                          allmodconfig
mips                             allyesconfig
s390                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                              defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a006
x86_64                           rhel-8.3-kvm
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                               rhel-8.3
x86_64                        randconfig-a013
i386                          randconfig-a005
x86_64                        randconfig-a011
i386                          randconfig-a014
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                           allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r045-20220925
hexagon              randconfig-r041-20220925
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a013
i386                          randconfig-a006
x86_64                        randconfig-a012
i386                          randconfig-a011
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a015

-- =

0-DAY CI Kernel Test Service
https://01.org/lkp
--===============5176055527202469218==--

