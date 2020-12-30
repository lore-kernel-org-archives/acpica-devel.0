Content-Type: multipart/mixed; boundary="===============5298432511728593041=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [pm:bleeding-edge] BUILD REGRESSION
 0c7a6fd3a0e835b0158a1f52176f5d3858fac110
Date: Wed, 30 Dec 2020 13:17:58 +0800
Message-ID: <5fec0d86.i0RjnNeExICZGSu7%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5298432511728593041==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-p=
m.git  bleeding-edge
branch HEAD: 0c7a6fd3a0e835b0158a1f52176f5d3858fac110  Merge branch 'pm-cpu=
idle-next' into bleeding-edge

Error/Warning reports:

https://lore.kernel.org/linux-acpi/202012180806.uUcdy2LC-lkp(a)intel.com
https://lore.kernel.org/linux-acpi/202012271352.JvNDF17O-lkp(a)intel.com
https://lore.kernel.org/linux-acpi/202012280239.stlWMtr3-lkp(a)intel.com
https://lore.kernel.org/linux-acpi/202012280249.nrNm8Jn3-lkp(a)intel.com

Error/Warning in current branch:

drivers/acpi/platform_profile.c:147:24: warning: address of array 'pprof->c=
hoices' will always evaluate to 'true' [-Wpointer-bool-conversion]
drivers/acpi/x86/s2idle.c:108:30: warning: variable 'info' set but not used=
 [-Wunused-but-set-variable]
drivers/acpi/x86/s2idle.c:138:25: warning: variable 'obj_new' set but not u=
sed [-Wunused-but-set-variable]
dtpm.c:(.text+0x24c): undefined reference to `__udivdi3'
dtpm.c:(.text+0x2a4): undefined reference to `__udivdi3'
dtpm.c:(.text+0x3bc): undefined reference to `__udivdi3'
dtpm.c:(.text+0x514): undefined reference to `__aeabi_uldivmod'
dtpm.c:(.text+0x52d): undefined reference to `__udivdi3'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-allmodconfig
|   `-- dtpm.c:(.text):undefined-reference-to-__aeabi_uldivmod
|-- arm-allyesconfig
|   `-- dtpm.c:(.text):undefined-reference-to-__aeabi_uldivmod
|-- h8300-allmodconfig
|   `-- dtpm.c:(.text):undefined-reference-to-__udivdi3
|-- h8300-allyesconfig
|   `-- dtpm.c:(.text):undefined-reference-to-__udivdi3
|-- i386-allyesconfig
|   `-- dtpm.c:(.text):undefined-reference-to-__udivdi3
|-- i386-randconfig-a006-20201229
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- i386-randconfig-r002-20201229
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- i386-randconfig-s001-20201229
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- m68k-allmodconfig
|   `-- dtpm.c:(.text):undefined-reference-to-__udivdi3
|-- m68k-allyesconfig
|   `-- dtpm.c:(.text):undefined-reference-to-__udivdi3
|-- sh-allmodconfig
|   `-- dtpm.c:(.text):undefined-reference-to-__udivdi3
|-- x86_64-randconfig-a002-20201229
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- x86_64-randconfig-a004-20201229
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
`-- x86_64-randconfig-s021-20201229
    |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
    `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used

clang_recent_errors
|-- x86_64-randconfig-a011-20201229
|   `-- drivers-acpi-platform_profile.c:warning:address-of-array-pprof-choi=
ces-will-always-evaluate-to-true
|-- x86_64-randconfig-a012-20201229
|   `-- drivers-acpi-platform_profile.c:warning:address-of-array-pprof-choi=
ces-will-always-evaluate-to-true
|-- x86_64-randconfig-a013-20201229
|   `-- drivers-acpi-platform_profile.c:warning:address-of-array-pprof-choi=
ces-will-always-evaluate-to-true
|-- x86_64-randconfig-a014-20201229
|   `-- drivers-acpi-platform_profile.c:warning:address-of-array-pprof-choi=
ces-will-always-evaluate-to-true
|-- x86_64-randconfig-a015-20201229
|   `-- drivers-acpi-platform_profile.c:warning:address-of-array-pprof-choi=
ces-will-always-evaluate-to-true
`-- x86_64-randconfig-a016-20201229
    `-- drivers-acpi-platform_profile.c:warning:address-of-array-pprof-choi=
ces-will-always-evaluate-to-true

elapsed time: 724m

configs tested: 95
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7619_defconfig
sh                        sh7785lcr_defconfig
arm                        trizeps4_defconfig
mips                        workpad_defconfig
um                           x86_64_defconfig
mips                     cu1000-neo_defconfig
m68k                          sun3x_defconfig
mips                        bcm47xx_defconfig
arm                            mps2_defconfig
mips                         tb0287_defconfig
s390                          debug_defconfig
arm                           sama5_defconfig
arm                         s3c2410_defconfig
arm                         lpc18xx_defconfig
sh                         microdev_defconfig
arm                         s5pv210_defconfig
mips                         tb0226_defconfig
arm                          pxa910_defconfig
c6x                        evmc6474_defconfig
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
x86_64               randconfig-a001-20201229
x86_64               randconfig-a006-20201229
x86_64               randconfig-a002-20201229
x86_64               randconfig-a004-20201229
x86_64               randconfig-a003-20201229
x86_64               randconfig-a005-20201229
i386                 randconfig-a002-20201229
i386                 randconfig-a005-20201229
i386                 randconfig-a004-20201229
i386                 randconfig-a006-20201229
i386                 randconfig-a003-20201229
i386                 randconfig-a001-20201229
i386                 randconfig-a014-20201229
i386                 randconfig-a012-20201229
i386                 randconfig-a011-20201229
i386                 randconfig-a016-20201229
i386                 randconfig-a015-20201229
i386                 randconfig-a013-20201229
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
x86_64               randconfig-a014-20201229
x86_64               randconfig-a015-20201229
x86_64               randconfig-a016-20201229
x86_64               randconfig-a012-20201229
x86_64               randconfig-a011-20201229
x86_64               randconfig-a013-20201229

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org
--===============5298432511728593041==--

