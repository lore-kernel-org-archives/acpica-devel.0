Content-Type: multipart/mixed; boundary="===============1162746954230620749=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [pm:bleeding-edge] BUILD REGRESSION
 2a58871c00f77abfc45935812e7e62a9d8a59a40
Date: Tue, 20 Oct 2020 12:37:02 +0800
Message-ID: <5f8e696e.7otAekyi64MWacHT%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1162746954230620749==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-p=
m.git  bleeding-edge
branch HEAD: 2a58871c00f77abfc45935812e7e62a9d8a59a40  Merge branch 'powerc=
ap' into bleeding-edge

Error/Warning reports:

https://lore.kernel.org/linux-acpi/202010200230.0MxnAfAW-lkp(a)intel.com

Error/Warning in current branch:

drivers/base/power/domain.c:419:8: error: implicit declaration of function =
'__raw_notifier_call_chain'; did you mean 'raw_notifier_call_chain'? [-Werr=
or=3Dimplicit-function-declaration]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-allmodconfig
|   `-- drivers-base-power-domain.c:error:implicit-declaration-of-function-=
__raw_notifier_call_chain
|-- arm-allyesconfig
|   `-- drivers-base-power-domain.c:error:implicit-declaration-of-function-=
__raw_notifier_call_chain
|-- arm-defconfig
|   `-- drivers-base-power-domain.c:error:implicit-declaration-of-function-=
__raw_notifier_call_chain
|-- arm64-allyesconfig
|   `-- drivers-base-power-domain.c:error:implicit-declaration-of-function-=
__raw_notifier_call_chain
|-- arm64-defconfig
|   `-- drivers-base-power-domain.c:error:implicit-declaration-of-function-=
__raw_notifier_call_chain
|-- i386-allyesconfig
|   `-- drivers-base-power-domain.c:error:implicit-declaration-of-function-=
__raw_notifier_call_chain
|-- i386-randconfig-s001-20201019
|   `-- drivers-base-power-domain.c:error:implicit-declaration-of-function-=
__raw_notifier_call_chain
|-- ia64-allmodconfig
|   `-- drivers-base-power-domain.c:error:implicit-declaration-of-function-=
__raw_notifier_call_chain
|-- ia64-allyesconfig
|   `-- drivers-base-power-domain.c:error:implicit-declaration-of-function-=
__raw_notifier_call_chain
|-- mips-allmodconfig
|   `-- drivers-base-power-domain.c:error:implicit-declaration-of-function-=
__raw_notifier_call_chain
|-- mips-allyesconfig
|   `-- drivers-base-power-domain.c:error:implicit-declaration-of-function-=
__raw_notifier_call_chain
|-- nds32-allyesconfig
|   `-- drivers-base-power-domain.c:error:implicit-declaration-of-function-=
__raw_notifier_call_chain
|-- powerpc-allmodconfig
|   `-- drivers-base-power-domain.c:error:implicit-declaration-of-function-=
__raw_notifier_call_chain
|-- powerpc-allyesconfig
|   `-- drivers-base-power-domain.c:error:implicit-declaration-of-function-=
__raw_notifier_call_chain
|-- riscv-allmodconfig
|   `-- drivers-base-power-domain.c:error:implicit-declaration-of-function-=
__raw_notifier_call_chain
|-- riscv-allyesconfig
|   `-- drivers-base-power-domain.c:error:implicit-declaration-of-function-=
__raw_notifier_call_chain
|-- sh-allmodconfig
|   `-- drivers-base-power-domain.c:error:implicit-declaration-of-function-=
__raw_notifier_call_chain
|-- sparc-allyesconfig
|   `-- drivers-base-power-domain.c:error:implicit-declaration-of-function-=
__raw_notifier_call_chain
|-- x86_64-allyesconfig
|   `-- drivers-base-power-domain.c:error:implicit-declaration-of-function-=
__raw_notifier_call_chain
|-- x86_64-randconfig-a003-20201019
|   `-- drivers-base-power-domain.c:error:implicit-declaration-of-function-=
__raw_notifier_call_chain
`-- xtensa-allyesconfig
    `-- drivers-base-power-domain.c:error:implicit-declaration-of-function-=
__raw_notifier_call_chain

elapsed time: 720m

configs tested: 94
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                     haps_hs_smp_defconfig
mips                      malta_kvm_defconfig
powerpc                  storcenter_defconfig
sh                     sh7710voipgw_defconfig
arm                            zeus_defconfig
arm                        spear6xx_defconfig
xtensa                  audio_kc705_defconfig
arm                          tango4_defconfig
mips                        nlm_xlr_defconfig
powerpc                      makalu_defconfig
arm                    vt8500_v6_v7_defconfig
mips                        workpad_defconfig
mips                     loongson1b_defconfig
sh                            migor_defconfig
mips                         tb0219_defconfig
sh                          urquell_defconfig
nios2                         10m50_defconfig
sparc64                             defconfig
arm                           omap1_defconfig
mips                    maltaup_xpa_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201019
i386                 randconfig-a005-20201019
i386                 randconfig-a001-20201019
i386                 randconfig-a003-20201019
i386                 randconfig-a004-20201019
i386                 randconfig-a002-20201019
i386                 randconfig-a015-20201019
i386                 randconfig-a013-20201019
i386                 randconfig-a016-20201019
i386                 randconfig-a012-20201019
i386                 randconfig-a011-20201019
i386                 randconfig-a014-20201019
x86_64               randconfig-a004-20201019
x86_64               randconfig-a002-20201019
x86_64               randconfig-a006-20201019
x86_64               randconfig-a003-20201019
x86_64               randconfig-a005-20201019
x86_64               randconfig-a001-20201019
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a016-20201019
x86_64               randconfig-a015-20201019
x86_64               randconfig-a012-20201019
x86_64               randconfig-a013-20201019
x86_64               randconfig-a011-20201019
x86_64               randconfig-a014-20201019

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org
--===============1162746954230620749==--

