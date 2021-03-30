Content-Type: multipart/mixed; boundary="===============0260010233825642716=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [pm:bleeding-edge] BUILD REGRESSION
 a70fdf61936ab0200d31bebea4b44bb67454ce07
Date: Tue, 30 Mar 2021 16:20:55 +0800
Message-ID: <6062df67.xFGyi2yKtRohuAOm%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0260010233825642716==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-p=
m.git bleeding-edge
branch HEAD: a70fdf61936ab0200d31bebea4b44bb67454ce07  Merge branch 'acpi-p=
rocessor-fixes' into bleeding-edge

Error/Warning reports:

https://lore.kernel.org/linux-acpi/202103300514.cNhP3ar5-lkp(a)intel.com
https://lore.kernel.org/linux-acpi/202103300806.BOpYVHTe-lkp(a)intel.com

Error/Warning in current branch:

drivers/acpi/processor_idle.c:548:7: error: implicit declaration of functio=
n 'wakeup_cpu0' [-Werror,-Wimplicit-function-declaration]
drivers/acpi/processor_idle.c:548:7: error: implicit declaration of functio=
n 'wakeup_cpu0' [-Werror=3Dimplicit-function-declaration]
drivers/acpi/processor_idle.c:549:4: error: implicit declaration of functio=
n 'start_cpu0' [-Werror,-Wimplicit-function-declaration]
drivers/acpi/processor_idle.c:549:4: error: implicit declaration of functio=
n 'start_cpu0'; did you mean 'task_cpu'? [-Werror=3Dimplicit-function-decla=
ration]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- i386-randconfig-a014-20210329
    |-- drivers-acpi-processor_idle.c:error:implicit-declaration-of-functio=
n-start_cpu0
    `-- drivers-acpi-processor_idle.c:error:implicit-declaration-of-functio=
n-wakeup_cpu0

clang_recent_errors
`-- x86_64-randconfig-a013-20210329
    |-- drivers-acpi-processor_idle.c:error:implicit-declaration-of-functio=
n-start_cpu0-Werror-Wimplicit-function-declaration
    `-- drivers-acpi-processor_idle.c:error:implicit-declaration-of-functio=
n-wakeup_cpu0-Werror-Wimplicit-function-declaration

elapsed time: 878m

configs tested: 102
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
xtensa                         virt_defconfig
m68k                       m5249evb_defconfig
arm                   milbeaut_m10v_defconfig
arm                        magician_defconfig
powerpc                     tqm8540_defconfig
mips                      maltaaprp_defconfig
arm                            zeus_defconfig
mips                          rm200_defconfig
powerpc                     pseries_defconfig
arm                         hackkit_defconfig
m68k                             alldefconfig
parisc                generic-64bit_defconfig
xtensa                  cadence_csp_defconfig
arm                          pxa3xx_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                 mpc8272_ads_defconfig
sh                          kfr2r09_defconfig
mips                           rs90_defconfig
arm                        neponset_defconfig
alpha                            alldefconfig
powerpc                    mvme5100_defconfig
powerpc                      acadia_defconfig
sh                           se7343_defconfig
arm                           tegra_defconfig
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
sparc                               defconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210329
i386                 randconfig-a004-20210329
i386                 randconfig-a001-20210329
i386                 randconfig-a002-20210329
i386                 randconfig-a006-20210329
i386                 randconfig-a005-20210329
i386                 randconfig-a014-20210329
i386                 randconfig-a011-20210329
i386                 randconfig-a015-20210329
i386                 randconfig-a016-20210329
i386                 randconfig-a013-20210329
i386                 randconfig-a012-20210329
x86_64               randconfig-a002-20210329
x86_64               randconfig-a003-20210329
x86_64               randconfig-a006-20210329
x86_64               randconfig-a001-20210329
x86_64               randconfig-a005-20210329
x86_64               randconfig-a004-20210329
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210329
x86_64               randconfig-a012-20210329
x86_64               randconfig-a013-20210329
x86_64               randconfig-a014-20210329
x86_64               randconfig-a011-20210329
x86_64               randconfig-a016-20210329

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org
--===============0260010233825642716==--

