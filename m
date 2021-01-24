Content-Type: multipart/mixed; boundary="===============8736532767336934355=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 a44d3fbdfbd1dde8c1726ba55638767fa359103d
Date: Mon, 25 Jan 2021 03:12:01 +0800
Message-ID: <600dc681.3mAl9WQXnragfNZk%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8736532767336934355==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-p=
m.git bleeding-edge
branch HEAD: a44d3fbdfbd1dde8c1726ba55638767fa359103d  Merge branch 'pm-dom=
ains' into bleeding-edge

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-randconfig-s002-20210124
|   `-- drivers-base-power-clock_ops.c:sparse:sparse:context-imbalance-in-p=
m_clk_list_unlock-wrong-count-at-exit
|-- x86_64-randconfig-s021-20210124
|   `-- drivers-base-power-clock_ops.c:sparse:sparse:context-imbalance-in-p=
m_clk_list_unlock-wrong-count-at-exit
`-- x86_64-randconfig-s022-20210124
    `-- drivers-base-power-clock_ops.c:sparse:sparse:context-imbalance-in-p=
m_clk_list_unlock-wrong-count-at-exit

elapsed time: 737m

configs tested: 95
configs skipped: 2

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
mips                malta_kvm_guest_defconfig
mips                malta_qemu_32r6_defconfig
arm                          pcm027_defconfig
sparc64                             defconfig
arm                       netwinder_defconfig
powerpc                    sam440ep_defconfig
sh                           se7206_defconfig
mips                         bigsur_defconfig
mips                         mpc30x_defconfig
mips                          ath79_defconfig
xtensa                    smp_lx200_defconfig
mips                      loongson3_defconfig
powerpc                     mpc512x_defconfig
sh                          rsk7269_defconfig
mips                           mtx1_defconfig
powerpc                     asp8347_defconfig
powerpc                         wii_defconfig
powerpc                 canyonlands_defconfig
sh                           sh2007_defconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
i386                 randconfig-a001-20210124
i386                 randconfig-a002-20210124
i386                 randconfig-a004-20210124
i386                 randconfig-a006-20210124
i386                 randconfig-a005-20210124
i386                 randconfig-a003-20210124
x86_64               randconfig-a012-20210124
x86_64               randconfig-a016-20210124
x86_64               randconfig-a015-20210124
x86_64               randconfig-a011-20210124
x86_64               randconfig-a013-20210124
x86_64               randconfig-a014-20210124
i386                 randconfig-a013-20210124
i386                 randconfig-a011-20210124
i386                 randconfig-a012-20210124
i386                 randconfig-a015-20210124
i386                 randconfig-a014-20210124
i386                 randconfig-a016-20210124
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
x86_64               randconfig-a003-20210124
x86_64               randconfig-a002-20210124
x86_64               randconfig-a001-20210124
x86_64               randconfig-a005-20210124
x86_64               randconfig-a006-20210124
x86_64               randconfig-a004-20210124

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org
--===============8736532767336934355==--

