Content-Type: multipart/mixed; boundary="===============2358753973181740510=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [rafael-pm:bleeding-edge] BUILD SUCCESS
 119d56b735c4f42a805657c0b9b5982e58f41929
Date: Fri, 04 Feb 2022 17:25:56 +0800
Message-ID: <61fcf124.z6Ri5a/JbVZn2kR4%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2358753973181740510==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-p=
m.git bleeding-edge
branch HEAD: 119d56b735c4f42a805657c0b9b5982e58f41929  Merge branch 'therma=
l-hfi' into bleeding-edge

possible Warning in current branch (please contact us if interested):

drivers/thermal/qcom/../thermal_netlink.h:113:71: warning: 'struct cpu_capa=
bility' declared inside parameter list will not be visible outside of this =
definition or declaration
drivers/thermal/qcom/../thermal_netlink.h:113:71: warning: declaration of '=
struct cpu_capability' will not be visible outside of this function [-Wvisi=
bility]
drivers/thermal/samsung/../thermal_netlink.h:113:71: warning: 'struct cpu_c=
apability' declared inside parameter list will not be visible outside of th=
is definition or declaration
drivers/thermal/samsung/../thermal_netlink.h:113:71: warning: declaration o=
f 'struct cpu_capability' will not be visible outside of this function [-Wv=
isibility]
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
|-- arc-randconfig-r043-20220130
|   `-- drivers-thermal-samsung-..-thermal_netlink.h:warning:struct-cpu_cap=
ability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-=
definition-or-declaration
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
|-- mips-buildonly-randconfig-r005-20220130
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capab=
ility-declared-inside-parameter-list-will-not-be-visible-outside-of-this-de=
finition-or-declaration
|-- openrisc-randconfig-r012-20220131
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capab=
ility-declared-inside-parameter-list-will-not-be-visible-outside-of-this-de=
finition-or-declaration
|-- openrisc-randconfig-r013-20220130
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capab=
ility-declared-inside-parameter-list-will-not-be-visible-outside-of-this-de=
finition-or-declaration
|-- openrisc-randconfig-r026-20220131
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capab=
ility-declared-inside-parameter-list-will-not-be-visible-outside-of-this-de=
finition-or-declaration
|-- openrisc-randconfig-r035-20220130
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capab=
ility-declared-inside-parameter-list-will-not-be-visible-outside-of-this-de=
finition-or-declaration
|-- powerpc-buildonly-randconfig-r006-20220130
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capab=
ility-declared-inside-parameter-list-will-not-be-visible-outside-of-this-de=
finition-or-declaration
`-- xtensa-randconfig-m031-20220131
    `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capab=
ility-declared-inside-parameter-list-will-not-be-visible-outside-of-this-de=
finition-or-declaration

clang_recent_errors
|-- hexagon-buildonly-randconfig-r001-20220131
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu=
_capability-will-not-be-visible-outside-of-this-function
|-- hexagon-randconfig-r045-20220131
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:declaration-of-s=
truct-cpu_capability-will-not-be-visible-outside-of-this-function
|-- riscv-buildonly-randconfig-r005-20220131
|   `-- drivers-thermal-qcom-..-thermal_netlink.h:warning:declaration-of-st=
ruct-cpu_capability-will-not-be-visible-outside-of-this-function
`-- riscv-randconfig-r001-20220130
    |-- drivers-thermal-samsung-..-thermal_netlink.h:warning:declaration-of=
-struct-cpu_capability-will-not-be-visible-outside-of-this-function
    `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:declaration-of-s=
truct-cpu_capability-will-not-be-visible-outside-of-this-function

elapsed time: 728m

configs tested: 110
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
arm                         assabet_defconfig
mips                 decstation_r4k_defconfig
m68k                          multi_defconfig
powerpc                     mpc83xx_defconfig
powerpc                     stx_gp3_defconfig
openrisc                  or1klitex_defconfig
xtensa                    smp_lx200_defconfig
sh                            shmin_defconfig
sh                           se7343_defconfig
powerpc                     rainier_defconfig
mips                    maltaup_xpa_defconfig
openrisc                 simple_smp_defconfig
arm                  randconfig-c002-20220130
arm                  randconfig-c002-20220131
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
m68k                                defconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
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
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
mips                             allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64               randconfig-a004-20220131
x86_64               randconfig-a003-20220131
x86_64               randconfig-a001-20220131
x86_64               randconfig-a006-20220131
x86_64               randconfig-a005-20220131
x86_64               randconfig-a002-20220131
riscv                randconfig-r042-20220130
arc                  randconfig-r043-20220130
arc                  randconfig-r043-20220131
s390                 randconfig-r044-20220130
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func

clang tested configs:
arm                    vt8500_v6_v7_defconfig
mips                          rm200_defconfig
powerpc                   lite5200b_defconfig
arm                             mxs_defconfig
mips                          ath79_defconfig
powerpc                     ppa8548_defconfig
mips                        bcm63xx_defconfig
riscv                             allnoconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a013-20220131
x86_64               randconfig-a015-20220131
x86_64               randconfig-a014-20220131
x86_64               randconfig-a016-20220131
x86_64               randconfig-a011-20220131
x86_64               randconfig-a012-20220131
i386                 randconfig-a013-20220131
i386                 randconfig-a014-20220131
i386                 randconfig-a012-20220131
i386                 randconfig-a015-20220131
i386                 randconfig-a016-20220131
i386                 randconfig-a011-20220131
s390                 randconfig-r044-20220131
hexagon              randconfig-r045-20220130
hexagon              randconfig-r045-20220131
hexagon              randconfig-r041-20220130
hexagon              randconfig-r041-20220131
riscv                randconfig-r042-20220131

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org
--===============2358753973181740510==--

