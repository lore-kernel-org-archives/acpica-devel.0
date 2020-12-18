Content-Type: multipart/mixed; boundary="===============7289254107023738552=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 bbebe3f6011e98d847e4a0841254a9fdae1de703
Date: Fri, 18 Dec 2020 15:32:44 +0800
Message-ID: <5fdc5b1c.+6qiDM/1s9UX+SNS%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7289254107023738552==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-p=
m.git  bleeding-edge
branch HEAD: bbebe3f6011e98d847e4a0841254a9fdae1de703  Merge branch 'acpi-s=
leep' into bleeding-edge

Warning reports:

https://lore.kernel.org/linux-acpi/202012180806.uUcdy2LC-lkp(a)intel.com

Warning in current branch:

drivers/acpi/x86/s2idle.c:108:30: warning: variable 'info' set but not used=
 [-Wunused-but-set-variable]
drivers/acpi/x86/s2idle.c:138:25: warning: variable 'obj_new' set but not u=
sed [-Wunused-but-set-variable]

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- i386-allyesconfig
    |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
    `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used

elapsed time: 720m

configs tested: 96
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
powerpc                    adder875_defconfig
powerpc                 mpc8272_ads_defconfig
sh                        edosk7760_defconfig
arm                        vexpress_defconfig
powerpc                        cell_defconfig
sh                         ap325rxa_defconfig
parisc                generic-64bit_defconfig
arm                        mvebu_v5_defconfig
powerpc                     taishan_defconfig
arm                         assabet_defconfig
c6x                              alldefconfig
sh                          r7780mp_defconfig
mips                         db1xxx_defconfig
sh                          sdk7786_defconfig
mips                        maltaup_defconfig
mips                         tb0226_defconfig
powerpc                     tqm8541_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                      ppc6xx_defconfig
xtensa                           alldefconfig
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
x86_64               randconfig-a003-20201217
x86_64               randconfig-a006-20201217
x86_64               randconfig-a002-20201217
x86_64               randconfig-a005-20201217
x86_64               randconfig-a004-20201217
x86_64               randconfig-a001-20201217
i386                 randconfig-a001-20201217
i386                 randconfig-a004-20201217
i386                 randconfig-a003-20201217
i386                 randconfig-a002-20201217
i386                 randconfig-a006-20201217
i386                 randconfig-a005-20201217
i386                 randconfig-a014-20201217
i386                 randconfig-a013-20201217
i386                 randconfig-a012-20201217
i386                 randconfig-a011-20201217
i386                 randconfig-a015-20201217
i386                 randconfig-a016-20201217
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
x86_64               randconfig-a016-20201217
x86_64               randconfig-a012-20201217
x86_64               randconfig-a013-20201217
x86_64               randconfig-a015-20201217
x86_64               randconfig-a014-20201217
x86_64               randconfig-a011-20201217

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org
--===============7289254107023738552==--

