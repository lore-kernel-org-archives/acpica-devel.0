Content-Type: multipart/mixed; boundary="===============3223054791799821168=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [rafael-pm:bleeding-edge 59/73]
 arch/x86/include/asm/pci_x86.h:133:19: error: expected ';
 ' after top level declarator
Date: Fri, 25 Feb 2022 07:24:49 +0800
Message-ID: <202202250758.oDiHyXAy-lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3223054791799821168==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
 bleeding-edge
head:   8276cbee5a52543c614a1e1bc2624188d5970848
commit: 62fabd56faafe033eb0be3ba24000b8db13d4c17 [59/73] x86/PCI: Disable e=
xclusion of E820 reserved addresses in some cases
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/202=
20225/202202250758.oDiHyXAy-lkp(a)intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc=
04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it/commit/?id=3D62fabd56faafe033eb0be3ba24000b8db13d4c17
        git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kerne=
l/git/rafael/linux-pm.git
        git fetch --no-tags rafael-pm bleeding-edge
        git checkout 62fabd56faafe033eb0be3ba24000b8db13d4c17
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=3D=
1 O=3Dbuild_dir ARCH=3Dx86_64 SHELL=3D/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp(a)intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/resource.c:4:
   arch/x86/include/asm/pci_x86.h:97:8: error: unknown type name 'raw_spinl=
ock_t'
   extern raw_spinlock_t pci_config_lock;
          ^
>> arch/x86/include/asm/pci_x86.h:133:19: error: expected ';' after top lev=
el declarator
   extern void __init dmi_check_pciprobe(void);
                     ^
                     ;
   arch/x86/include/asm/pci_x86.h:134:19: error: expected ';' after top lev=
el declarator
   extern void __init dmi_check_skip_isa_align(void);
                     ^
                     ;
>> arch/x86/include/asm/pci_x86.h:138:12: error: redeclaration of '__init' =
with a different type: 'int' vs 'void'
   extern int __init pci_acpi_init(void);
              ^
   arch/x86/include/asm/pci_x86.h:134:13: note: previous declaration is here
   extern void __init dmi_check_skip_isa_align(void);
               ^
   arch/x86/include/asm/pci_x86.h:138:18: error: expected ';' after top lev=
el declarator
   extern int __init pci_acpi_init(void);
                    ^
                    ;
   arch/x86/include/asm/pci_x86.h:145:19: error: expected ';' after top lev=
el declarator
   extern void __init pcibios_irq_init(void);
                     ^
                     ;
   arch/x86/include/asm/pci_x86.h:146:12: error: redeclaration of '__init' =
with a different type: 'int' vs 'void'
   extern int __init pcibios_init(void);
              ^
   arch/x86/include/asm/pci_x86.h:145:13: note: previous declaration is here
   extern void __init pcibios_irq_init(void);
               ^
   arch/x86/include/asm/pci_x86.h:146:18: error: expected ';' after top lev=
el declarator
   extern int __init pcibios_init(void);
                    ^
                    ;
   arch/x86/include/asm/pci_x86.h:166:12: error: redeclaration of '__init' =
with a different type: 'int' vs 'void'
   extern int __init pci_mmcfg_arch_init(void);
              ^
   arch/x86/include/asm/pci_x86.h:145:13: note: previous declaration is here
   extern void __init pcibios_irq_init(void);
               ^
   arch/x86/include/asm/pci_x86.h:166:18: error: expected ';' after top lev=
el declarator
   extern int __init pci_mmcfg_arch_init(void);
                    ^
                    ;
   arch/x86/include/asm/pci_x86.h:167:19: error: expected ';' after top lev=
el declarator
   extern void __init pci_mmcfg_arch_free(void);
                     ^
                     ;
>> arch/x86/include/asm/pci_x86.h:174:33: error: redeclaration of '__init' =
with a different type: 'struct pci_mmcfg_region *' vs 'void'
   extern struct pci_mmcfg_region *__init pci_mmconfig_add(int segment, int=
 start,
                                   ^
   arch/x86/include/asm/pci_x86.h:167:13: note: previous declaration is here
   extern void __init pci_mmcfg_arch_free(void);
               ^
   arch/x86/include/asm/pci_x86.h:174:39: error: expected ';' after top lev=
el declarator
   extern struct pci_mmcfg_region *__init pci_mmconfig_add(int segment, int=
 start,
                                         ^
                                         ;
   13 errors generated.


vim +133 arch/x86/include/asm/pci_x86.h

^1da177e4c3f41 arch/i386/pci/pci.h            Linus Torvalds     2005-04-16=
   96  =

d19f61f098ae93 arch/x86/include/asm/pci_x86.h Thomas Gleixner    2010-02-17=
  @97  extern raw_spinlock_t pci_config_lock;
^1da177e4c3f41 arch/i386/pci/pci.h            Linus Torvalds     2005-04-16=
   98  =

^1da177e4c3f41 arch/i386/pci/pci.h            Linus Torvalds     2005-04-16=
   99  extern int (*pcibios_enable_irq)(struct pci_dev *dev);
87bec66b969152 arch/i386/pci/pci.h            David Shaohua Li   2005-07-27=
  100  extern void (*pcibios_disable_irq)(struct pci_dev *dev);
928cf8c6276334 arch/i386/pci/pci.h            Andi Kleen         2005-12-12=
  101  =

6c777e8799a93e arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2016-02-17=
  102  extern bool mp_should_keep_irq(struct device *dev);
6c777e8799a93e arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2016-02-17=
  103  =

b6ce068a1285a2 arch/x86/pci/pci.h             Matthew Wilcox     2008-02-10=
  104  struct pci_raw_ops {
b6ce068a1285a2 arch/x86/pci/pci.h             Matthew Wilcox     2008-02-10=
  105  	int (*read)(unsigned int domain, unsigned int bus, unsigned int dev=
fn,
b6ce068a1285a2 arch/x86/pci/pci.h             Matthew Wilcox     2008-02-10=
  106  						int reg, int len, u32 *val);
b6ce068a1285a2 arch/x86/pci/pci.h             Matthew Wilcox     2008-02-10=
  107  	int (*write)(unsigned int domain, unsigned int bus, unsigned int de=
vfn,
b6ce068a1285a2 arch/x86/pci/pci.h             Matthew Wilcox     2008-02-10=
  108  						int reg, int len, u32 val);
b6ce068a1285a2 arch/x86/pci/pci.h             Matthew Wilcox     2008-02-10=
  109  };
b6ce068a1285a2 arch/x86/pci/pci.h             Matthew Wilcox     2008-02-10=
  110  =

72da0b07b1b497 arch/x86/include/asm/pci_x86.h Jan Beulich        2011-09-15=
  111  extern const struct pci_raw_ops *raw_pci_ops;
72da0b07b1b497 arch/x86/include/asm/pci_x86.h Jan Beulich        2011-09-15=
  112  extern const struct pci_raw_ops *raw_pci_ext_ops;
b6ce068a1285a2 arch/x86/pci/pci.h             Matthew Wilcox     2008-02-10=
  113  =

c0fa40784cce9c arch/x86/include/asm/pci_x86.h Jiang Liu          2012-06-22=
  114  extern const struct pci_raw_ops pci_mmcfg;
72da0b07b1b497 arch/x86/include/asm/pci_x86.h Jan Beulich        2011-09-15=
  115  extern const struct pci_raw_ops pci_direct_conf1;
14d7ca5c575853 arch/x86/pci/pci.h             H. Peter Anvin     2008-11-11=
  116  extern bool port_cf9_safe;
928cf8c6276334 arch/i386/pci/pci.h            Andi Kleen         2005-12-12=
  117  =

8dd779b19ce597 arch/x86/pci/pci.h             Robert Richter     2008-07-02=
  118  /* arch_initcall level */
445d3595ab290b arch/x86/include/asm/pci_x86.h Thomas Gleixner    2020-08-26=
  119  #ifdef CONFIG_PCI_DIRECT
5e544d618f0fb2 arch/i386/pci/pci.h            Andi Kleen         2006-09-26=
  120  extern int pci_direct_probe(void);
5e544d618f0fb2 arch/i386/pci/pci.h            Andi Kleen         2006-09-26=
  121  extern void pci_direct_init(int type);
445d3595ab290b arch/x86/include/asm/pci_x86.h Thomas Gleixner    2020-08-26=
  122  #else
445d3595ab290b arch/x86/include/asm/pci_x86.h Thomas Gleixner    2020-08-26=
  123  static inline int pci_direct_probe(void) { return -1; }
445d3595ab290b arch/x86/include/asm/pci_x86.h Thomas Gleixner    2020-08-26=
  124  static inline  void pci_direct_init(int type) { }
445d3595ab290b arch/x86/include/asm/pci_x86.h Thomas Gleixner    2020-08-26=
  125  #endif
445d3595ab290b arch/x86/include/asm/pci_x86.h Thomas Gleixner    2020-08-26=
  126  =

445d3595ab290b arch/x86/include/asm/pci_x86.h Thomas Gleixner    2020-08-26=
  127  #ifdef CONFIG_PCI_BIOS
92c05fc1a32e5c arch/i386/pci/pci.h            Andi Kleen         2006-03-23=
  128  extern void pci_pcbios_init(void);
445d3595ab290b arch/x86/include/asm/pci_x86.h Thomas Gleixner    2020-08-26=
  129  #else
445d3595ab290b arch/x86/include/asm/pci_x86.h Thomas Gleixner    2020-08-26=
  130  static inline void pci_pcbios_init(void) { }
445d3595ab290b arch/x86/include/asm/pci_x86.h Thomas Gleixner    2020-08-26=
  131  #endif
445d3595ab290b arch/x86/include/asm/pci_x86.h Thomas Gleixner    2020-08-26=
  132  =

8dd779b19ce597 arch/x86/pci/pci.h             Robert Richter     2008-07-02=
 @133  extern void __init dmi_check_pciprobe(void);
8dd779b19ce597 arch/x86/pci/pci.h             Robert Richter     2008-07-02=
  134  extern void __init dmi_check_skip_isa_align(void);
8dd779b19ce597 arch/x86/pci/pci.h             Robert Richter     2008-07-02=
  135  =

8dd779b19ce597 arch/x86/pci/pci.h             Robert Richter     2008-07-02=
  136  /* some common used subsys_initcalls */
5d32a66541c468 arch/x86/include/asm/pci_x86.h Sinan Kaya         2018-12-19=
  137  #ifdef CONFIG_PCI
8dd779b19ce597 arch/x86/pci/pci.h             Robert Richter     2008-07-02=
 @138  extern int __init pci_acpi_init(void);
5d32a66541c468 arch/x86/include/asm/pci_x86.h Sinan Kaya         2018-12-19=
  139  #else
5d32a66541c468 arch/x86/include/asm/pci_x86.h Sinan Kaya         2018-12-19=
  140  static inline int  __init pci_acpi_init(void)
5d32a66541c468 arch/x86/include/asm/pci_x86.h Sinan Kaya         2018-12-19=
  141  {
5d32a66541c468 arch/x86/include/asm/pci_x86.h Sinan Kaya         2018-12-19=
  142  	return -EINVAL;
5d32a66541c468 arch/x86/include/asm/pci_x86.h Sinan Kaya         2018-12-19=
  143  }
5d32a66541c468 arch/x86/include/asm/pci_x86.h Sinan Kaya         2018-12-19=
  144  #endif
ab3b37937e8f4f arch/x86/include/asm/pci_x86.h Thomas Gleixner    2009-08-29=
  145  extern void __init pcibios_irq_init(void);
8dd779b19ce597 arch/x86/pci/pci.h             Robert Richter     2008-07-02=
  146  extern int __init pcibios_init(void);
b72d0db9dd41da arch/x86/include/asm/pci_x86.h Thomas Gleixner    2009-08-29=
  147  extern int pci_legacy_init(void);
9325a28ce2fa7c arch/x86/include/asm/pci_x86.h Thomas Gleixner    2009-08-29=
  148  extern void pcibios_fixup_irqs(void);
5e544d618f0fb2 arch/i386/pci/pci.h            Andi Kleen         2006-09-26=
  149  =

b78673944b22b6 arch/i386/pci/pci.h            Olivier Galibert   2007-02-13=
  150  /* pci-mmconfig.c */
b78673944b22b6 arch/i386/pci/pci.h            Olivier Galibert   2007-02-13=
  151  =

56ddf4d3cf04e8 arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2009-11-13=
  152  /* "PCI MMCONFIG %04x [bus %02x-%02x]" */
56ddf4d3cf04e8 arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2009-11-13=
  153  #define PCI_MMCFG_RESOURCE_NAME_LEN (22 + 4 + 2 + 2)
56ddf4d3cf04e8 arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2009-11-13=
  154  =

d215a9c8b46e55 arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2009-11-13=
  155  struct pci_mmcfg_region {
ff097ddd4aeac7 arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2009-11-13=
  156  	struct list_head list;
56ddf4d3cf04e8 arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2009-11-13=
  157  	struct resource res;
d215a9c8b46e55 arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2009-11-13=
  158  	u64 address;
3f0f5503926f74 arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2009-11-13=
  159  	char __iomem *virt;
d7e6b66fe87c9f arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2009-11-13=
  160  	u16 segment;
d7e6b66fe87c9f arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2009-11-13=
  161  	u8 start_bus;
d7e6b66fe87c9f arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2009-11-13=
  162  	u8 end_bus;
56ddf4d3cf04e8 arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2009-11-13=
  163  	char name[PCI_MMCFG_RESOURCE_NAME_LEN];
d215a9c8b46e55 arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2009-11-13=
  164  };
d215a9c8b46e55 arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2009-11-13=
  165  =

429d512e532ec9 arch/i386/pci/pci.h            OGAWA Hirofumi     2007-02-13=
 @166  extern int __init pci_mmcfg_arch_init(void);
0b64ad7123eb01 arch/x86/pci/pci.h             Yinghai Lu         2008-02-15=
  167  extern void __init pci_mmcfg_arch_free(void);
a18e3690a52790 arch/x86/include/asm/pci_x86.h Greg Kroah-Hartman 2012-12-21=
  168  extern int pci_mmcfg_arch_map(struct pci_mmcfg_region *cfg);
9cf0105da5a315 arch/x86/include/asm/pci_x86.h Jiang Liu          2012-06-22=
  169  extern void pci_mmcfg_arch_unmap(struct pci_mmcfg_region *cfg);
a18e3690a52790 arch/x86/include/asm/pci_x86.h Greg Kroah-Hartman 2012-12-21=
  170  extern int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start=
, u8 end,
a18e3690a52790 arch/x86/include/asm/pci_x86.h Greg Kroah-Hartman 2012-12-21=
  171  			       phys_addr_t addr);
9c95111b330d2d arch/x86/include/asm/pci_x86.h Jiang Liu          2012-06-22=
  172  extern int pci_mmconfig_delete(u16 seg, u8 start, u8 end);
f6e1d8cc38b377 arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2009-11-13=
  173  extern struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int=
 bus);
6fa4a94e150be2 arch/x86/include/asm/pci_x86.h Otavio Pontes      2018-03-07=
 @174  extern struct pci_mmcfg_region *__init pci_mmconfig_add(int segment,=
 int start,
6fa4a94e150be2 arch/x86/include/asm/pci_x86.h Otavio Pontes      2018-03-07=
  175  							int end, u64 addr);
3320ad994afb2c arch/i386/pci/pci.h            dean gaudet        2007-08-10=
  176  =


:::::: The code at line 133 was first introduced by commit
:::::: 8dd779b19ce5972072ad2372a86c8acbae4da768 x86/pci: removing subsys_in=
itcall ordering dependencies

:::::: TO: Robert Richter <robert.richter(a)amd.com>
:::::: CC: Ingo Molnar <mingo(a)elte.hu>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org
--===============3223054791799821168==--

