Content-Type: multipart/mixed; boundary="===============4208459196386358711=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [rafael-pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 f099fd60c342d8d8265202ce01b4375358913072
Date: Fri, 07 Jan 2022 18:50:19 +0800
Message-ID: <61d81aeb.IipLiV6Q1X7uzVAE%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4208459196386358711==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-p=
m.git bleeding-edge
branch HEAD: f099fd60c342d8d8265202ce01b4375358913072  Merge branch 'acpi-p=
frut' into linux-next

Warning reports:

https://lore.kernel.org/llvm/202112280907.gTYYYuB4-lkp(a)intel.com

Warning in current branch:

drivers/acpi/acpica/exregion.c:519:17: warning: performing pointer subtract=
ion with a null pointer has undefined behavior [-Wnull-pointer-subtraction]

Warning ids grouped by kconfigs:

clang_recent_errors
|-- i386-randconfig-a011-20220107
|   `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtracti=
on-with-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a012-20220107
|   `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtracti=
on-with-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a013-20220107
|   `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtracti=
on-with-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a014-20220107
|   `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtracti=
on-with-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-r014-20220107
|   `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtracti=
on-with-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a011-20220107
|   `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtracti=
on-with-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a012-20220107
|   `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtracti=
on-with-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a013-20220107
|   `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtracti=
on-with-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a014-20220107
|   `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtracti=
on-with-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a015-20220107
|   `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtracti=
on-with-a-null-pointer-has-undefined-behavior
`-- x86_64-randconfig-a016-20220107
    `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtracti=
on-with-a-null-pointer-has-undefined-behavior

elapsed time: 733m

configs tested: 145
configs skipped: 4

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220107
parisc                           alldefconfig
arm                           stm32_defconfig
mips                        bcm47xx_defconfig
powerpc                      ppc40x_defconfig
arm                       omap2plus_defconfig
arm                            lart_defconfig
sh                        sh7763rdp_defconfig
sh                           se7343_defconfig
sh                           se7721_defconfig
sh                     sh7710voipgw_defconfig
m68k                        mvme147_defconfig
sh                          lboxre2_defconfig
powerpc                      chrp32_defconfig
powerpc                      mgcoge_defconfig
mips                           jazz_defconfig
arm                           viper_defconfig
m68k                       m5275evb_defconfig
xtensa                  cadence_csp_defconfig
arc                        nsimosci_defconfig
xtensa                    smp_lx200_defconfig
sparc64                          alldefconfig
arm                           h5000_defconfig
arm                          badge4_defconfig
sh                        dreamcast_defconfig
m68k                       m5208evb_defconfig
m68k                          sun3x_defconfig
sh                            migor_defconfig
mips                         cobalt_defconfig
sh                          polaris_defconfig
m68k                       m5475evb_defconfig
openrisc                            defconfig
arm                        realview_defconfig
powerpc                       ppc64_defconfig
arm                        trizeps4_defconfig
arm                  randconfig-c002-20220107
arm                  randconfig-c002-20220106
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20220107
x86_64               randconfig-a001-20220107
x86_64               randconfig-a004-20220107
x86_64               randconfig-a006-20220107
x86_64               randconfig-a002-20220107
x86_64               randconfig-a003-20220107
i386                 randconfig-a003-20220107
i386                 randconfig-a005-20220107
i386                 randconfig-a004-20220107
i386                 randconfig-a006-20220107
i386                 randconfig-a002-20220107
i386                 randconfig-a001-20220107
arc                  randconfig-r043-20220107
s390                 randconfig-r044-20220106
arc                  randconfig-r043-20220106
riscv                randconfig-r042-20220106
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
mips                 randconfig-c004-20220107
arm                  randconfig-c002-20220107
i386                 randconfig-c001-20220107
riscv                randconfig-c006-20220107
powerpc              randconfig-c003-20220107
x86_64               randconfig-c007-20220107
arm                          moxart_defconfig
arm                      tct_hammer_defconfig
arm                        spear3xx_defconfig
mips                      malta_kvm_defconfig
arm                      pxa255-idp_defconfig
mips                       lemote2f_defconfig
mips                        qi_lb60_defconfig
arm                          collie_defconfig
powerpc                          allyesconfig
arm                         s5pv210_defconfig
arm                         palmz72_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                         tb0219_defconfig
s390                             alldefconfig
i386                 randconfig-a003-20220106
i386                 randconfig-a005-20220106
i386                 randconfig-a006-20220106
i386                 randconfig-a002-20220106
i386                 randconfig-a001-20220106
x86_64               randconfig-a012-20220107
x86_64               randconfig-a015-20220107
x86_64               randconfig-a014-20220107
x86_64               randconfig-a013-20220107
x86_64               randconfig-a011-20220107
x86_64               randconfig-a016-20220107
i386                 randconfig-a012-20220107
i386                 randconfig-a016-20220107
i386                 randconfig-a014-20220107
i386                 randconfig-a015-20220107
i386                 randconfig-a011-20220107
i386                 randconfig-a013-20220107
hexagon              randconfig-r041-20220107
hexagon              randconfig-r045-20220107
riscv                randconfig-r042-20220107
s390                 randconfig-r044-20220107

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org
--===============4208459196386358711==--

