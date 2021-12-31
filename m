Content-Type: multipart/mixed; boundary="===============7834941539946678475=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [rafael-pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 642439a4441150c7ab54db8d54fac1c7fee57b5a
Date: Fri, 31 Dec 2021 17:49:27 +0800
Message-ID: <61ced227.bwGu6xI7ZBErSpCQ%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7834941539946678475==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-p=
m.git bleeding-edge
branch HEAD: 642439a4441150c7ab54db8d54fac1c7fee57b5a  Merge branch 'acpi-p=
rocessor' into bleeding-edge

Warning reports:

https://lore.kernel.org/llvm/202112280907.gTYYYuB4-lkp(a)intel.com

Warning in current branch:

drivers/acpi/acpica/exregion.c:519:17: warning: performing pointer subtract=
ion with a null pointer has undefined behavior [-Wnull-pointer-subtraction]

possible Warning in current branch (please contact us if interested):

sound/soc/sh/rz-ssi.c:1023:9: warning: ignoring return value of 'pm_runtime=
_resume_and_get' declared with attribute 'warn_unused_result' [-Wunused-res=
ult]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allmodconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- alpha-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- arc-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- arc-randconfig-r043-20211230
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- arm-allmodconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- arm-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- arm-randconfig-c002-20211230
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- arm64-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- arm64-defconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- h8300-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- ia64-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- ia64-buildonly-randconfig-r004-20211231
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- m68k-allmodconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- m68k-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- mips-allmodconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- mips-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- nios2-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- parisc-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- powerpc-allmodconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- powerpc-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- riscv-allmodconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- riscv-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- s390-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- sh-allmodconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- sparc-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- sparc64-randconfig-r005-20211230
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
`-- xtensa-allyesconfig
    `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result

clang_recent_errors
|-- i386-randconfig-a001-20211230
|   `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtracti=
on-with-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a002-20211230
|   `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtracti=
on-with-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a003-20211230
|   `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtracti=
on-with-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a004-20211230
|   `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtracti=
on-with-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a005-20211230
|   `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtracti=
on-with-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a006-20211230
|   `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtracti=
on-with-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a011-20211231
|   `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtracti=
on-with-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a012-20211231
|   `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtracti=
on-with-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a013-20211231
|   `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtracti=
on-with-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a014-20211231
|   `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtracti=
on-with-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a015-20211231
|   `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtracti=
on-with-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a016-20211231
|   `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtracti=
on-with-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-r033-20211230
|   `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtracti=
on-with-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a001-20211230
|   `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtracti=
on-with-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a002-20211230
|   `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtracti=
on-with-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a003-20211230
|   `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtracti=
on-with-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a004-20211230
|   `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtracti=
on-with-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a005-20211230
|   `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtracti=
on-with-a-null-pointer-has-undefined-behavior
`-- x86_64-randconfig-a006-20211230
    `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtracti=
on-with-a-null-pointer-has-undefined-behavior

elapsed time: 724m

configs tested: 106
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
i386                 randconfig-c001-20211230
sh                         apsh4a3a_defconfig
arm                       multi_v4t_defconfig
sh                   rts7751r2dplus_defconfig
sh                           se7721_defconfig
powerpc                 mpc8313_rdb_defconfig
h8300                       h8s-sim_defconfig
arm                           spitz_defconfig
arm                          pxa168_defconfig
powerpc                          g5_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                    ge_imp3a_defconfig
mips                           mtx1_defconfig
sh                ecovec24-romimage_defconfig
arm                        mini2440_defconfig
xtensa                           alldefconfig
sh                            migor_defconfig
arm                            zeus_defconfig
arm                         at91_dt_defconfig
m68k                       m5249evb_defconfig
mips                          ath79_defconfig
s390                          debug_defconfig
arm                  randconfig-c002-20211230
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a013-20211230
x86_64               randconfig-a015-20211230
x86_64               randconfig-a012-20211230
x86_64               randconfig-a011-20211230
x86_64               randconfig-a016-20211230
x86_64               randconfig-a014-20211230
arc                  randconfig-r043-20211230
riscv                randconfig-r042-20211230
s390                 randconfig-r044-20211230
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
x86_64               randconfig-a002-20211230
x86_64               randconfig-a001-20211230
x86_64               randconfig-a003-20211230
x86_64               randconfig-a006-20211230
x86_64               randconfig-a004-20211230
x86_64               randconfig-a005-20211230
i386                 randconfig-a001-20211230
i386                 randconfig-a004-20211230
i386                 randconfig-a002-20211230
i386                 randconfig-a006-20211230
i386                 randconfig-a003-20211230
i386                 randconfig-a005-20211230
i386                 randconfig-a011-20211231
i386                 randconfig-a012-20211231
i386                 randconfig-a013-20211231
i386                 randconfig-a014-20211231
i386                 randconfig-a015-20211231
i386                 randconfig-a016-20211231
hexagon              randconfig-r041-20211230
hexagon              randconfig-r045-20211230

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org
--===============7834941539946678475==--

