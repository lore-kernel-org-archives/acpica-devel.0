Content-Type: multipart/mixed; boundary="===============2169714604114888986=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [rafael-pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 f23bedef4354b1e8a69a25d8c9c1201e6d8e8762
Date: Tue, 26 Apr 2022 02:08:07 +0800
Message-ID: <6266e387.bctpuhyghUvd25GS%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2169714604114888986==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-p=
m.git bleeding-edge
branch HEAD: f23bedef4354b1e8a69a25d8c9c1201e6d8e8762  Merge branch 'acpi-p=
ci' into bleeding-edge

Warning reports:

https://lore.kernel.org/linux-pm/202204240259.PyW8hsJz-lkp(a)intel.com
https://lore.kernel.org/linux-pm/202204241452.pAvKt2JP-lkp(a)intel.com

Warning: (recently discovered and may have been fixed)

WARNING: modpost: vmlinux.o(.exit.text+0xe120): Section mismatch in referen=
ce from the function hsr_netlink_exit() to the variable .init.text:.L0
WARNING: modpost: vmlinux.o(.text+0x15ff5e0): Section mismatch in reference=
 from the function dm_stats_init() to the variable .init.text:.L0
WARNING: modpost: vmlinux.o(.text+0x1697378): Section mismatch in reference=
 from the function btintel_send_intel_reset() to the variable .exit.text:.L0
WARNING: modpost: vmlinux.o(.text+0x1bf6234): Section mismatch in reference=
 from the function sctp_sched_ops_register() to the variable .init.text:.L0
WARNING: modpost: vmlinux.o(.text+0x1bf624c): Section mismatch in reference=
 from the function sctp_sched_ops_init() to the variable .init.text:.L0
WARNING: modpost: vmlinux.o(.text+0x1bf627c): Section mismatch in reference=
 from the function sctp_sched_set_sched() to the variable .init.text:.L0
WARNING: modpost: vmlinux.o(.text+0x1bf640c): Section mismatch in reference=
 from the function sctp_sched_get_sched() to the variable .init.text:.L0
WARNING: modpost: vmlinux.o(.text+0xfdc8e4): Section mismatch in reference =
from the function component_compare_dev_name() to the variable .exit.text:.=
LFB4478
WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in referen=
ce from the variable .L0 to the variable .rodata:_entry.30

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- riscv-buildonly-randconfig-r002-20220421
    |-- Section-mismatch-in-reference-from-the-function-btintel_send_intel_=
reset()-to-the-variable-.exit.text:.L0
    |-- Section-mismatch-in-reference-from-the-function-component_compare_d=
ev_name()-to-the-variable-.exit.text:.LFB4478
    |-- Section-mismatch-in-reference-from-the-function-dm_stats_init()-to-=
the-variable-.init.text:.L0
    |-- Section-mismatch-in-reference-from-the-function-hsr_netlink_exit()-=
to-the-variable-.init.text:.L0
    |-- Section-mismatch-in-reference-from-the-function-sctp_sched_get_sche=
d()-to-the-variable-.init.text:.L0
    |-- Section-mismatch-in-reference-from-the-function-sctp_sched_ops_init=
()-to-the-variable-.init.text:.L0
    |-- Section-mismatch-in-reference-from-the-function-sctp_sched_ops_regi=
ster()-to-the-variable-.init.text:.L0
    |-- Section-mismatch-in-reference-from-the-function-sctp_sched_set_sche=
d()-to-the-variable-.init.text:.L0
    `-- Section-mismatch-in-reference-from-the-variable-.L0-to-the-variable=
-.rodata:_entry.

elapsed time: 4386m

configs tested: 109
configs skipped: 4

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
arm                          simpad_defconfig
m68k                        m5407c3_defconfig
um                                  defconfig
powerpc                   currituck_defconfig
sh                        edosk7760_defconfig
powerpc                      ppc40x_defconfig
arc                          axs103_defconfig
sparc                               defconfig
m68k                             allyesconfig
nios2                            alldefconfig
powerpc                      tqm8xx_defconfig
arm                          badge4_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                   motionpro_defconfig
powerpc                      pcm030_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                  randconfig-c002-20220422
x86_64                        randconfig-c001
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
alpha                               defconfig
csky                                defconfig
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a004
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220422
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
mips                 randconfig-c004-20220424
arm                  randconfig-c002-20220424
powerpc              randconfig-c003-20220424
x86_64                        randconfig-c007
i386                          randconfig-c001
s390                 randconfig-c005-20220424
riscv                randconfig-c006-20220424
mips                       rbtx49xx_defconfig
riscv                    nommu_virt_defconfig
powerpc                      walnut_defconfig
mips                         tb0219_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
hexagon              randconfig-r041-20220422
riscv                randconfig-r042-20220422
hexagon              randconfig-r045-20220422
s390                 randconfig-r044-20220422

-- =

0-DAY CI Kernel Test Service
https://01.org/lkp
--===============2169714604114888986==--

