Content-Type: multipart/mixed; boundary="===============6332430577134268760=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 693e119601907f923bcf08aca03793a0d1cf4416
Date: Thu, 21 Jan 2021 14:25:38 +0800
Message-ID: <60091e62.ARJpxQVSwHfZKZ/b%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6332430577134268760==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-p=
m.git bleeding-edge
branch HEAD: 693e119601907f923bcf08aca03793a0d1cf4416  Merge branch 'acpi-p=
latform' into bleeding-edge

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- i386-randconfig-s002-20210119
    `-- include-linux-spinlock.h:sparse:sparse:context-imbalance-in-pm_clk_=
list_lock-wrong-count-at-exit

elapsed time: 722m

configs tested: 96
configs skipped: 2

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                        workpad_defconfig
sh                                  defconfig
arm                          gemini_defconfig
mips                           jazz_defconfig
arm                           spitz_defconfig
mips                  cavium_octeon_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                     redwood_defconfig
mips                          rm200_defconfig
ia64                          tiger_defconfig
m68k                       bvme6000_defconfig
powerpc                    klondike_defconfig
sh                            titan_defconfig
powerpc                     rainier_defconfig
powerpc                  storcenter_defconfig
arm                         axm55xx_defconfig
arm                           h3600_defconfig
c6x                                 defconfig
xtensa                       common_defconfig
m68k                          multi_defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210120
i386                 randconfig-a002-20210120
i386                 randconfig-a004-20210120
i386                 randconfig-a006-20210120
i386                 randconfig-a005-20210120
i386                 randconfig-a003-20210120
i386                 randconfig-a013-20210120
i386                 randconfig-a011-20210120
i386                 randconfig-a012-20210120
i386                 randconfig-a014-20210120
i386                 randconfig-a015-20210120
i386                 randconfig-a016-20210120
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210120
x86_64               randconfig-a003-20210120
x86_64               randconfig-a001-20210120
x86_64               randconfig-a005-20210120
x86_64               randconfig-a006-20210120
x86_64               randconfig-a004-20210120
x86_64               randconfig-a015-20210119
x86_64               randconfig-a013-20210119
x86_64               randconfig-a012-20210119
x86_64               randconfig-a016-20210119
x86_64               randconfig-a011-20210119
x86_64               randconfig-a014-20210119

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org
--===============6332430577134268760==--

