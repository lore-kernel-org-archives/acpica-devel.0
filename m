Content-Type: multipart/mixed; boundary="===============8954401586750061456=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [rafael-pm:bleeding-edge] BUILD SUCCESS
 32ee4d3735ab552d457eeae837ef1ce10360585e
Date: Sat, 05 Feb 2022 16:49:10 +0800
Message-ID: <61fe3a06.GThAYLvk1hSuoU/Q%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8954401586750061456==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-p=
m.git bleeding-edge
branch HEAD: 32ee4d3735ab552d457eeae837ef1ce10360585e  Merge branch 'devpro=
p' into bleeding-edge

possible Warning in current branch (please contact us if interested):

drivers/thermal/qcom/../thermal_netlink.h:113:71: warning: 'struct cpu_capa=
bility' declared inside parameter list will not be visible outside of this =
definition or declaration
drivers/thermal/samsung/../thermal_netlink.h:113:71: warning: 'struct cpu_c=
apability' declared inside parameter list will not be visible outside of th=
is definition or declaration
drivers/thermal/st/../thermal_netlink.h:113:71: warning: 'struct cpu_capabi=
lity' declared inside parameter list will not be visible outside of this de=
finition or declaration
drivers/thermal/tegra/../thermal_netlink.h:113:71: warning: 'struct cpu_cap=
ability' declared inside parameter list will not be visible outside of this=
 definition or declaration
drivers/thermal/tegra/../thermal_netlink.h:113:71: warning: declaration of =
'struct cpu_capability' will not be visible outside of this function [-Wvis=
ibility]
drivers/thermal/thermal_netlink.h:113:71: warning: declaration of 'struct c=
pu_capability' will not be visible outside of this function [-Wvisibility]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-buildonly-randconfig-r004-20220201
|   |-- drivers-thermal-qcom-..-thermal_netlink.h:warning:struct-cpu_capabi=
lity-declared-inside-parameter-list-will-not-be-visible-outside-of-this-def=
inition-or-declaration
|   |-- drivers-thermal-samsung-..-thermal_netlink.h:warning:struct-cpu_cap=
ability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-=
definition-or-declaration
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capab=
ility-declared-inside-parameter-list-will-not-be-visible-outside-of-this-de=
finition-or-declaration
|-- arc-randconfig-r043-20220130
|   |-- drivers-thermal-samsung-..-thermal_netlink.h:warning:struct-cpu_cap=
ability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-=
definition-or-declaration
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capab=
ility-declared-inside-parameter-list-will-not-be-visible-outside-of-this-de=
finition-or-declaration
|-- arm-defconfig
|   |-- drivers-thermal-samsung-..-thermal_netlink.h:warning:struct-cpu_cap=
ability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-=
definition-or-declaration
|   |-- drivers-thermal-st-..-thermal_netlink.h:warning:struct-cpu_capabili=
ty-declared-inside-parameter-list-will-not-be-visible-outside-of-this-defin=
ition-or-declaration
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capab=
ility-declared-inside-parameter-list-will-not-be-visible-outside-of-this-de=
finition-or-declaration
|-- arm-randconfig-r023-20220131
|   `-- drivers-thermal-samsung-..-thermal_netlink.h:warning:struct-cpu_cap=
ability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-=
definition-or-declaration
|-- arm-randconfig-r034-20220130
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capab=
ility-declared-inside-parameter-list-will-not-be-visible-outside-of-this-de=
finition-or-declaration
|-- arm64-defconfig
|   |-- drivers-thermal-qcom-..-thermal_netlink.h:warning:struct-cpu_capabi=
lity-declared-inside-parameter-list-will-not-be-visible-outside-of-this-def=
inition-or-declaration
|   |-- drivers-thermal-samsung-..-thermal_netlink.h:warning:struct-cpu_cap=
ability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-=
definition-or-declaration
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capab=
ility-declared-inside-parameter-list-will-not-be-visible-outside-of-this-de=
finition-or-declaration
|-- ia64-randconfig-r035-20220130
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capab=
ility-declared-inside-parameter-list-will-not-be-visible-outside-of-this-de=
finition-or-declaration
|-- ia64-randconfig-s032-20220130
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capab=
ility-declared-inside-parameter-list-will-not-be-visible-outside-of-this-de=
finition-or-declaration
|-- m68k-randconfig-r031-20220130
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capab=
ility-declared-inside-parameter-list-will-not-be-visible-outside-of-this-de=
finition-or-declaration
|-- microblaze-randconfig-r036-20220130
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capab=
ility-declared-inside-parameter-list-will-not-be-visible-outside-of-this-de=
finition-or-declaration
|-- nds32-randconfig-c024-20220131
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capab=
ility-declared-inside-parameter-list-will-not-be-visible-outside-of-this-de=
finition-or-declaration
|-- openrisc-randconfig-r011-20220130
|   |-- drivers-thermal-samsung-..-thermal_netlink.h:warning:struct-cpu_cap=
ability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-=
definition-or-declaration
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capab=
ility-declared-inside-parameter-list-will-not-be-visible-outside-of-this-de=
finition-or-declaration
|-- powerpc-randconfig-r024-20220130
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capab=
ility-declared-inside-parameter-list-will-not-be-visible-outside-of-this-de=
finition-or-declaration
|-- riscv-randconfig-r042-20220130
|   |-- drivers-thermal-qcom-..-thermal_netlink.h:warning:struct-cpu_capabi=
lity-declared-inside-parameter-list-will-not-be-visible-outside-of-this-def=
inition-or-declaration
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capab=
ility-declared-inside-parameter-list-will-not-be-visible-outside-of-this-de=
finition-or-declaration
|-- s390-randconfig-r023-20220130
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capab=
ility-declared-inside-parameter-list-will-not-be-visible-outside-of-this-de=
finition-or-declaration
`-- s390-randconfig-r044-20220130
    `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capab=
ility-declared-inside-parameter-list-will-not-be-visible-outside-of-this-de=
finition-or-declaration

clang_recent_errors
|-- arm-randconfig-r016-20220130
|   |-- drivers-thermal-tegra-..-thermal_netlink.h:warning:declaration-of-s=
truct-cpu_capability-will-not-be-visible-outside-of-this-function
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu=
_capability-will-not-be-visible-outside-of-this-function
|-- arm64-randconfig-r026-20220131
|   |-- drivers-thermal-tegra-..-thermal_netlink.h:warning:declaration-of-s=
truct-cpu_capability-will-not-be-visible-outside-of-this-function
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu=
_capability-will-not-be-visible-outside-of-this-function
|-- hexagon-randconfig-r006-20220130
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu=
_capability-will-not-be-visible-outside-of-this-function
|-- hexagon-randconfig-r041-20220131
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu=
_capability-will-not-be-visible-outside-of-this-function
|-- hexagon-randconfig-r045-20220130
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu=
_capability-will-not-be-visible-outside-of-this-function
|-- hexagon-randconfig-r045-20220131
|   |-- drivers-thermal-tegra-..-thermal_netlink.h:warning:declaration-of-s=
truct-cpu_capability-will-not-be-visible-outside-of-this-function
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu=
_capability-will-not-be-visible-outside-of-this-function
|-- hexagon-randconfig-r045-20220203
|   |-- drivers-thermal-tegra-..-thermal_netlink.h:warning:declaration-of-s=
truct-cpu_capability-will-not-be-visible-outside-of-this-function
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu=
_capability-will-not-be-visible-outside-of-this-function
|-- i386-randconfig-a011
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu=
_capability-will-not-be-visible-outside-of-this-function
|-- i386-randconfig-a013
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu=
_capability-will-not-be-visible-outside-of-this-function
|-- i386-randconfig-c001
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu=
_capability-will-not-be-visible-outside-of-this-function
|-- riscv-randconfig-c006-20220130
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu=
_capability-will-not-be-visible-outside-of-this-function
|-- x86_64-randconfig-a011-20220131
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu=
_capability-will-not-be-visible-outside-of-this-function
|-- x86_64-randconfig-a012-20220131
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu=
_capability-will-not-be-visible-outside-of-this-function
|-- x86_64-randconfig-a013-20220131
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu=
_capability-will-not-be-visible-outside-of-this-function
|-- x86_64-randconfig-a014-20220131
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu=
_capability-will-not-be-visible-outside-of-this-function
|-- x86_64-randconfig-a015-20220131
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu=
_capability-will-not-be-visible-outside-of-this-function
|-- x86_64-randconfig-a016-20220131
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu=
_capability-will-not-be-visible-outside-of-this-function
`-- x86_64-randconfig-c007
    `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu=
_capability-will-not-be-visible-outside-of-this-function

elapsed time: 721m

configs tested: 119
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
i386                 randconfig-c001-20220131
arm                         vf610m4_defconfig
powerpc64                        alldefconfig
sh                        sh7757lcr_defconfig
mips                      fuloong2e_defconfig
mips                  maltasmvp_eva_defconfig
mips                         db1xxx_defconfig
arm                       aspeed_g5_defconfig
sh                         ap325rxa_defconfig
arm                        clps711x_defconfig
sh                          landisk_defconfig
mips                     loongson1b_defconfig
arm                           corgi_defconfig
xtensa                    xip_kc705_defconfig
arc                     nsimosci_hs_defconfig
arm                  randconfig-c002-20220130
arm                  randconfig-c002-20220131
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
nios2                            allyesconfig
alpha                            allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                 randconfig-a003-20220131
i386                 randconfig-a002-20220131
i386                 randconfig-a001-20220131
i386                 randconfig-a004-20220131
i386                 randconfig-a006-20220131
i386                 randconfig-a005-20220131
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220203
riscv                randconfig-r042-20220130
arc                  randconfig-r043-20220130
arc                  randconfig-r043-20220131
riscv                randconfig-r042-20220203
s390                 randconfig-r044-20220130
s390                 randconfig-r044-20220203
x86_64               randconfig-a003-20220131
x86_64               randconfig-a001-20220131
x86_64               randconfig-a006-20220131
x86_64               randconfig-a005-20220131
x86_64               randconfig-a002-20220131
x86_64               randconfig-a004-20220131
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64                        randconfig-c007
arm                  randconfig-c002-20220130
powerpc              randconfig-c003-20220130
mips                 randconfig-c004-20220130
s390                 randconfig-c005-20220130
i386                          randconfig-c001
riscv                randconfig-c006-20220130
powerpc                      ppc44x_defconfig
mips                         tb0287_defconfig
powerpc                      obs600_defconfig
x86_64               randconfig-a013-20220131
x86_64               randconfig-a014-20220131
x86_64               randconfig-a016-20220131
x86_64               randconfig-a011-20220131
x86_64               randconfig-a012-20220131
x86_64               randconfig-a015-20220131
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
riscv                randconfig-r042-20220131
hexagon              randconfig-r045-20220203
hexagon              randconfig-r041-20220203
s390                 randconfig-r044-20220131
hexagon              randconfig-r045-20220130
hexagon              randconfig-r045-20220131
hexagon              randconfig-r041-20220130
hexagon              randconfig-r041-20220131

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org
--===============8954401586750061456==--

