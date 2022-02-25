Content-Type: multipart/mixed; boundary="===============5605555361279033096=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [rafael-pm:bleeding-edge] BUILD REGRESSION
 8276cbee5a52543c614a1e1bc2624188d5970848
Date: Fri, 25 Feb 2022 17:03:00 +0800
Message-ID: <62189b44.QBrVbFGRLXJ9SScw%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5605555361279033096==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-p=
m.git bleeding-edge
branch HEAD: 8276cbee5a52543c614a1e1bc2624188d5970848  Merge branch 'therma=
l-int340x-fixes' into bleeding-edge

Error/Warning reports:

https://lore.kernel.org/llvm/202202250758.oDiHyXAy-lkp(a)intel.com

Error/Warning in current branch:

arch/x86/include/asm/pci_x86.h:133:19: error: expected ';' after top level =
declarator
arch/x86/include/asm/pci_x86.h:138:12: error: redeclaration of '__init' wit=
h a different type: 'int' vs 'void'
arch/x86/include/asm/pci_x86.h:174:33: error: redeclaration of '__init' wit=
h a different type: 'struct pci_mmcfg_region *' vs 'void'

possible Error/Warning in current branch (please contact us if interested):

arch/x86/include/asm/pci_x86.h:133:20: error: expected '=3D', ',', ';', 'as=
m' or '__attribute__' before 'dmi_check_pciprobe'
arch/x86/include/asm/pci_x86.h:134:20: error: expected '=3D', ',', ';', 'as=
m' or '__attribute__' before 'dmi_check_skip_isa_align'
arch/x86/include/asm/pci_x86.h:138:19: error: expected '=3D', ',', ';', 'as=
m' or '__attribute__' before 'pci_acpi_init'
arch/x86/include/asm/pci_x86.h:145:20: error: expected '=3D', ',', ';', 'as=
m' or '__attribute__' before 'pcibios_irq_init'
arch/x86/include/asm/pci_x86.h:146:19: error: expected '=3D', ',', ';', 'as=
m' or '__attribute__' before 'pcibios_init'
arch/x86/include/asm/pci_x86.h:166:19: error: expected '=3D', ',', ';', 'as=
m' or '__attribute__' before 'pci_mmcfg_arch_init'
arch/x86/include/asm/pci_x86.h:167:20: error: expected '=3D', ',', ';', 'as=
m' or '__attribute__' before 'pci_mmcfg_arch_free'
arch/x86/include/asm/pci_x86.h:174:40: error: expected '=3D', ',', ';', 'as=
m' or '__attribute__' before 'pci_mmconfig_add'
arch/x86/include/asm/pci_x86.h:97:8: error: unknown type name 'raw_spinlock=
_t'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-randconfig-a003
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-dmi_check_pciprobe
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-dmi_check_skip_isa_align
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pci_acpi_init
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pci_mmcfg_arch_free
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pci_mmcfg_arch_init
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pci_mmconfig_add
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pcibios_init
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pcibios_irq_init
|   `-- arch-x86-include-asm-pci_x86.h:error:unknown-type-name-raw_spinlock=
_t
|-- i386-randconfig-c001
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-dmi_check_pciprobe
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-dmi_check_skip_isa_align
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pci_acpi_init
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pci_mmcfg_arch_free
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pci_mmcfg_arch_init
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pci_mmconfig_add
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pcibios_init
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pcibios_irq_init
|   `-- arch-x86-include-asm-pci_x86.h:error:unknown-type-name-raw_spinlock=
_t
|-- i386-randconfig-s001
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-dmi_check_pciprobe
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-dmi_check_skip_isa_align
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pci_acpi_init
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pci_mmcfg_arch_free
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pci_mmcfg_arch_init
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pci_mmconfig_add
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pcibios_init
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pcibios_irq_init
|   `-- arch-x86-include-asm-pci_x86.h:error:unknown-type-name-raw_spinlock=
_t
|-- i386-randconfig-s002
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-dmi_check_pciprobe
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-dmi_check_skip_isa_align
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pci_acpi_init
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pci_mmcfg_arch_free
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pci_mmcfg_arch_init
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pci_mmconfig_add
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pcibios_init
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pcibios_irq_init
|   `-- arch-x86-include-asm-pci_x86.h:error:unknown-type-name-raw_spinlock=
_t
|-- x86_64-alldefconfig
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-dmi_check_pciprobe
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-dmi_check_skip_isa_align
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pci_acpi_init
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pci_mmcfg_arch_free
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pci_mmcfg_arch_init
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pci_mmconfig_add
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pcibios_init
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pcibios_irq_init
|   `-- arch-x86-include-asm-pci_x86.h:error:unknown-type-name-raw_spinlock=
_t
|-- x86_64-randconfig-c002
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-dmi_check_pciprobe
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-dmi_check_skip_isa_align
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pci_acpi_init
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pci_mmcfg_arch_free
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pci_mmcfg_arch_init
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pci_mmconfig_add
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pcibios_init
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pcibios_irq_init
|   `-- arch-x86-include-asm-pci_x86.h:error:unknown-type-name-raw_spinlock=
_t
|-- x86_64-randconfig-s021
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-dmi_check_pciprobe
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-dmi_check_skip_isa_align
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pci_acpi_init
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pci_mmcfg_arch_free
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pci_mmcfg_arch_init
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pci_mmconfig_add
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pcibios_init
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pcibios_irq_init
|   `-- arch-x86-include-asm-pci_x86.h:error:unknown-type-name-raw_spinlock=
_t
`-- x86_64-randconfig-s022
    |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-dmi_check_pciprobe
    |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-dmi_check_skip_isa_align
    |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pci_acpi_init
    |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pci_mmcfg_arch_free
    |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pci_mmcfg_arch_init
    |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pci_mmconfig_add
    |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pcibios_init
    |-- arch-x86-include-asm-pci_x86.h:error:expected-asm-or-__attribute__-=
before-pcibios_irq_init
    `-- arch-x86-include-asm-pci_x86.h:error:unknown-type-name-raw_spinlock=
_t

clang_recent_errors
|-- i386-randconfig-a002
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-after-top-level-decla=
rator
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a=
-different-type:int-vs-void
|   `-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a=
-different-type:struct-pci_mmcfg_region-vs-void
|-- i386-randconfig-a004
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-after-top-level-decla=
rator
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a=
-different-type:int-vs-void
|   `-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a=
-different-type:struct-pci_mmcfg_region-vs-void
|-- i386-randconfig-a006
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-after-top-level-decla=
rator
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a=
-different-type:int-vs-void
|   `-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a=
-different-type:struct-pci_mmcfg_region-vs-void
|-- i386-randconfig-a011
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-after-top-level-decla=
rator
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a=
-different-type:int-vs-void
|   `-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a=
-different-type:struct-pci_mmcfg_region-vs-void
|-- i386-randconfig-a013
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-after-top-level-decla=
rator
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a=
-different-type:int-vs-void
|   `-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a=
-different-type:struct-pci_mmcfg_region-vs-void
|-- i386-randconfig-a015
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-after-top-level-decla=
rator
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a=
-different-type:int-vs-void
|   `-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a=
-different-type:struct-pci_mmcfg_region-vs-void
|-- x86_64-randconfig-a001
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-after-top-level-decla=
rator
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a=
-different-type:int-vs-void
|   `-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a=
-different-type:struct-pci_mmcfg_region-vs-void
|-- x86_64-randconfig-a005
|   |-- arch-x86-include-asm-pci_x86.h:error:expected-after-top-level-decla=
rator
|   |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a=
-different-type:int-vs-void
|   `-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a=
-different-type:struct-pci_mmcfg_region-vs-void
`-- x86_64-randconfig-a012
    |-- arch-x86-include-asm-pci_x86.h:error:expected-after-top-level-decla=
rator
    |-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a=
-different-type:int-vs-void
    `-- arch-x86-include-asm-pci_x86.h:error:redeclaration-of-__init-with-a=
-different-type:struct-pci_mmcfg_region-vs-void

elapsed time: 731m

configs tested: 110
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                          randconfig-c001
microblaze                      mmu_defconfig
powerpc                     sequoia_defconfig
arm                        spear6xx_defconfig
powerpc                  iss476-smp_defconfig
x86_64                           alldefconfig
arc                      axs103_smp_defconfig
m68k                          atari_defconfig
arm                          iop32x_defconfig
powerpc                       eiger_defconfig
sh                   sh7724_generic_defconfig
mips                       bmips_be_defconfig
xtensa                       common_defconfig
sh                          sdk7780_defconfig
arm                  randconfig-c002-20220224
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
h8300                            allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
s390                                defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
mips                             allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
arc                  randconfig-r043-20220223
s390                 randconfig-r044-20220224
arc                  randconfig-r043-20220224
riscv                randconfig-r042-20220224
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests

clang tested configs:
powerpc              randconfig-c003-20220225
mips                 randconfig-c004-20220225
arm                  randconfig-c002-20220225
s390                 randconfig-c005-20220225
riscv                randconfig-c006-20220225
mips                        omega2p_defconfig
mips                   sb1250_swarm_defconfig
mips                           ip28_defconfig
arm                          ixp4xx_defconfig
powerpc                          g5_defconfig
mips                          rm200_defconfig
mips                          malta_defconfig
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r045-20220223
hexagon              randconfig-r045-20220224
s390                 randconfig-r044-20220223
riscv                randconfig-r042-20220223
hexagon              randconfig-r041-20220224
hexagon              randconfig-r041-20220223

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org
--===============5605555361279033096==--

