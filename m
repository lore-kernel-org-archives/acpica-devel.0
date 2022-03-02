Content-Type: multipart/mixed; boundary="===============1168943545942120138=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [rafael-pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 f7307721a01f4f14d21c699b270a870370cf34b9
Date: Wed, 02 Mar 2022 16:24:05 +0800
Message-ID: <621f29a5.tUuJmET0YwP81mTF%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1168943545942120138==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-p=
m.git bleeding-edge
branch HEAD: f7307721a01f4f14d21c699b270a870370cf34b9  Merge branch 'acpi-s=
oc' into bleeding-edge

Warning reports:

https://lore.kernel.org/linux-acpi/202203020750.Uq6hGay2-lkp(a)intel.com
https://lore.kernel.org/llvm/202203020737.wa9uc4gW-lkp(a)intel.com

Warning:

arch/x86/kernel/acpi/boot.c:1476:8: warning: excess elements in array initi=
alizer [-Wexcess-initializers]
include/linux/mod_devicetable.h:587:25: warning: excess elements in array i=
nitializer

Unverified Warning (likely false positive, please contact us if interested):

arch/x86/kernel/acpi/boot.c:1394 (null)() error: buffer overflow '(acpi_dmi=
_table[6])->matches' 4 <=3D 4
arch/x86/kernel/acpi/boot.c:1476:22: sparse: sparse: excessive elements in =
array initializer

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-randconfig-a003
|   `-- include-linux-mod_devicetable.h:warning:excess-elements-in-array-in=
itializer
|-- i386-randconfig-c001
|   `-- include-linux-mod_devicetable.h:warning:excess-elements-in-array-in=
itializer
|-- i386-randconfig-s001
|   `-- include-linux-mod_devicetable.h:warning:excess-elements-in-array-in=
itializer
|-- i386-randconfig-s002
|   |-- arch-x86-kernel-acpi-boot.c:sparse:sparse:excessive-elements-in-arr=
ay-initializer
|   `-- include-linux-mod_devicetable.h:warning:excess-elements-in-array-in=
itializer
|-- x86_64-allyesconfig
|   `-- include-linux-mod_devicetable.h:warning:excess-elements-in-array-in=
itializer
|-- x86_64-kexec
|   `-- include-linux-mod_devicetable.h:warning:excess-elements-in-array-in=
itializer
|-- x86_64-randconfig-a015
|   `-- include-linux-mod_devicetable.h:warning:excess-elements-in-array-in=
itializer
|-- x86_64-randconfig-c002
|   `-- include-linux-mod_devicetable.h:warning:excess-elements-in-array-in=
itializer
|-- x86_64-randconfig-m001
|   `-- arch-x86-kernel-acpi-boot.c-(null)()-error:buffer-overflow-(acpi_dm=
i_table-)-matches
|-- x86_64-rhel-8.3
|   `-- include-linux-mod_devicetable.h:warning:excess-elements-in-array-in=
itializer
|-- x86_64-rhel-8.3-func
|   `-- include-linux-mod_devicetable.h:warning:excess-elements-in-array-in=
itializer
|-- x86_64-rhel-8.3-kselftests
|   `-- include-linux-mod_devicetable.h:warning:excess-elements-in-array-in=
itializer
`-- x86_64-rhel-8.3-kunit
    `-- include-linux-mod_devicetable.h:warning:excess-elements-in-array-in=
itializer

clang_recent_errors
|-- i386-randconfig-a002
|   `-- arch-x86-kernel-acpi-boot.c:warning:excess-elements-in-array-initia=
lizer
|-- i386-randconfig-a011
|   `-- arch-x86-kernel-acpi-boot.c:warning:excess-elements-in-array-initia=
lizer
`-- x86_64-randconfig-a016
    `-- arch-x86-kernel-acpi-boot.c:warning:excess-elements-in-array-initia=
lizer

elapsed time: 724m

configs tested: 106
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allmodconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-c001
arm                            lart_defconfig
arm                            hisi_defconfig
h8300                            alldefconfig
sh                            titan_defconfig
arm                          iop32x_defconfig
m68k                          amiga_defconfig
arm                            pleb_defconfig
sh                        apsh4ad0a_defconfig
ia64                            zx1_defconfig
mips                      maltasmvp_defconfig
arm                         at91_dt_defconfig
sh                               alldefconfig
openrisc                            defconfig
arm                  randconfig-c002-20220301
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
h8300                            allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
sparc                               defconfig
i386                                defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                        randconfig-a002
x86_64                        randconfig-a004
arc                  randconfig-r043-20220301
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
arm                          imote2_defconfig
powerpc                      ppc64e_defconfig
arm                        mvebu_v5_defconfig
arm                         lpc32xx_defconfig
mips                     cu1830-neo_defconfig
arm                        spear3xx_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r045-20220301
hexagon              randconfig-r041-20220301
s390                 randconfig-r044-20220301
riscv                randconfig-r042-20220301

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org
--===============1168943545942120138==--

