Content-Type: multipart/mixed; boundary="===============1999971503549790812=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [pm:bleeding-edge] BUILD REGRESSION
 2691096b51bae3563007c4b0188c3eec9878224b
Date: Sat, 09 Jan 2021 04:57:50 +0800
Message-ID: <5ff8c74e.h+cmkUVKPZMMcUNw%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1999971503549790812==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-p=
m.git  bleeding-edge
branch HEAD: 2691096b51bae3563007c4b0188c3eec9878224b  Merge branch 'linux-=
next' into bleeding-edge

Error/Warning reports:

https://lore.kernel.org/linux-acpi/202101081623.CGkLO3Kx-lkp(a)intel.com

Error/Warning in current branch:

drivers/acpi/platform_profile.c:67:33: error: passing 'const struct platfor=
m_profile_handler *' to parameter of type 'struct platform_profile_handler =
*' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-quali=
fiers]

Error/Warning ids grouped by kconfigs:

clang_recent_errors
`-- x86_64-randconfig-r011-20210108
    `-- drivers-acpi-platform_profile.c:error:passing-const-struct-platform=
_profile_handler-to-parameter-of-type-struct-platform_profile_handler-disca=
rds-qualifiers-Werror-Wincompatible-pointer-types-discards

elapsed time: 1156m

configs tested: 91
configs skipped: 2

gcc tested configs:
arm64                               defconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                         3c120_defconfig
sparc                            allyesconfig
powerpc                      katmai_defconfig
arm                         palmz72_defconfig
sh                              ul2_defconfig
mips                       capcella_defconfig
mips                        bcm47xx_defconfig
ia64                         bigsur_defconfig
arm                         orion5x_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                         nhk8815_defconfig
mips                         tb0287_defconfig
powerpc                 mpc834x_itx_defconfig
sh                         ap325rxa_defconfig
c6x                         dsk6455_defconfig
riscv                    nommu_virt_defconfig
powerpc                        icon_defconfig
openrisc                  or1klitex_defconfig
powerpc                 linkstation_defconfig
powerpc                      walnut_defconfig
mips                         bigsur_defconfig
mips                          rb532_defconfig
sh                            hp6xx_defconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210108
i386                 randconfig-a002-20210108
i386                 randconfig-a001-20210108
i386                 randconfig-a003-20210108
i386                 randconfig-a006-20210108
i386                 randconfig-a004-20210108
i386                 randconfig-a016-20210108
i386                 randconfig-a011-20210108
i386                 randconfig-a014-20210108
i386                 randconfig-a015-20210108
i386                 randconfig-a013-20210108
i386                 randconfig-a012-20210108
x86_64               randconfig-a004-20210108
x86_64               randconfig-a006-20210108
x86_64               randconfig-a001-20210108
x86_64               randconfig-a002-20210108
x86_64               randconfig-a003-20210108
x86_64               randconfig-a005-20210108
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
--===============1999971503549790812==--

