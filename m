Content-Type: multipart/mixed; boundary="===============0886201201963704623=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 33b4fa8533186db3c463120ced43b1c12ecba18d
Date: Fri, 22 Jan 2021 15:30:36 +0800
Message-ID: <600a7f1c.IUhAMURl7o4IVqMl%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0886201201963704623==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-p=
m.git bleeding-edge
branch HEAD: 33b4fa8533186db3c463120ced43b1c12ecba18d  Merge branch 'acpi-p=
latform' into bleeding-edge

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-randconfig-s022-20210122
    `-- include-linux-spinlock.h:sparse:sparse:context-imbalance-in-pm_clk_=
list_lock-wrong-count-at-exit

elapsed time: 722m

configs tested: 89
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                   motionpro_defconfig
c6x                        evmc6457_defconfig
mips                         tb0226_defconfig
mips                           ip22_defconfig
powerpc                        icon_defconfig
mips                        nlm_xlp_defconfig
xtensa                generic_kc705_defconfig
powerpc                    socrates_defconfig
m68k                          atari_defconfig
arm                             mxs_defconfig
powerpc                   currituck_defconfig
arm                        trizeps4_defconfig
powerpc                 mpc834x_itx_defconfig
arm                        shmobile_defconfig
um                           x86_64_defconfig
arc                        nsimosci_defconfig
m68k                       m5208evb_defconfig
arm                         lpc32xx_defconfig
sh                           se7780_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
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
i386                 randconfig-a001-20210121
i386                 randconfig-a002-20210121
i386                 randconfig-a004-20210121
i386                 randconfig-a006-20210121
i386                 randconfig-a005-20210121
i386                 randconfig-a003-20210121
i386                 randconfig-a013-20210121
i386                 randconfig-a011-20210121
i386                 randconfig-a012-20210121
i386                 randconfig-a014-20210121
i386                 randconfig-a015-20210121
i386                 randconfig-a016-20210121
x86_64               randconfig-a002-20210121
x86_64               randconfig-a003-20210121
x86_64               randconfig-a001-20210121
x86_64               randconfig-a005-20210121
x86_64               randconfig-a006-20210121
x86_64               randconfig-a004-20210121
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org
--===============0886201201963704623==--

