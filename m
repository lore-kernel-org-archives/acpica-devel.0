Content-Type: multipart/mixed; boundary="===============2536631327864673876=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [rafael-pm:bleeding-edge] BUILD SUCCESS
 ac62facbd440da5ba31f5b4b137c234815b6c2d2
Date: Tue, 01 Mar 2022 17:43:34 +0800
Message-ID: <621deac6.naqZhUKaeXm2KwZO%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2536631327864673876==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-p=
m.git bleeding-edge
branch HEAD: ac62facbd440da5ba31f5b4b137c234815b6c2d2  Merge branch 'acpi-f=
an' into linux-next

elapsed time: 739m

configs tested: 157
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
arc                        vdk_hs38_defconfig
powerpc                      pasemi_defconfig
m68k                       m5249evb_defconfig
parisc                              defconfig
arc                 nsimosci_hs_smp_defconfig
mips                             allyesconfig
h8300                       h8s-sim_defconfig
nios2                         10m50_defconfig
mips                           jazz_defconfig
sh                ecovec24-romimage_defconfig
m68k                            mac_defconfig
mips                         db1xxx_defconfig
sh                     sh7710voipgw_defconfig
powerpc                      bamboo_defconfig
arc                        nsim_700_defconfig
arm                        keystone_defconfig
mips                            gpr_defconfig
arm                       omap2plus_defconfig
arm                        cerfcube_defconfig
powerpc                     tqm8555_defconfig
mips                         mpc30x_defconfig
mips                       bmips_be_defconfig
sh                          landisk_defconfig
sh                          r7785rp_defconfig
arc                            hsdk_defconfig
sh                               alldefconfig
powerpc                   motionpro_defconfig
powerpc                      ppc6xx_defconfig
arc                          axs103_defconfig
arm                        realview_defconfig
arm                          iop32x_defconfig
powerpc                         ps3_defconfig
arm                  randconfig-c002-20220228
arm                  randconfig-c002-20220227
arm                  randconfig-c002-20220301
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
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
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64               randconfig-a011-20220228
x86_64               randconfig-a015-20220228
x86_64               randconfig-a014-20220228
x86_64               randconfig-a013-20220228
x86_64               randconfig-a016-20220228
x86_64               randconfig-a012-20220228
i386                 randconfig-a016-20220228
i386                 randconfig-a012-20220228
i386                 randconfig-a015-20220228
i386                 randconfig-a011-20220228
i386                 randconfig-a013-20220228
i386                 randconfig-a014-20220228
arc                  randconfig-r043-20220228
riscv                randconfig-r042-20220228
s390                 randconfig-r044-20220228
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
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                 randconfig-c004-20220301
powerpc              randconfig-c003-20220301
arm                  randconfig-c002-20220301
s390                 randconfig-c005-20220301
riscv                randconfig-c006-20220301
arm                  colibri_pxa300_defconfig
powerpc                     powernv_defconfig
mips                           rs90_defconfig
arm                         orion5x_defconfig
mips                           mtx1_defconfig
powerpc                     pseries_defconfig
powerpc                     tqm8560_defconfig
mips                           ip28_defconfig
arm                        mvebu_v5_defconfig
arm                          imote2_defconfig
powerpc                   lite5200b_defconfig
mips                           ip22_defconfig
arm                       versatile_defconfig
arm                        vexpress_defconfig
mips                          malta_defconfig
arm                         hackkit_defconfig
x86_64               randconfig-a001-20220228
x86_64               randconfig-a004-20220228
x86_64               randconfig-a003-20220228
x86_64               randconfig-a005-20220228
x86_64               randconfig-a002-20220228
x86_64               randconfig-a006-20220228
i386                 randconfig-a002-20220228
i386                 randconfig-a001-20220228
i386                 randconfig-a005-20220228
i386                 randconfig-a003-20220228
i386                 randconfig-a006-20220228
i386                 randconfig-a004-20220228
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220301
hexagon              randconfig-r041-20220301
riscv                randconfig-r042-20220301
hexagon              randconfig-r041-20220228
hexagon              randconfig-r045-20220228
hexagon              randconfig-r045-20220227
hexagon              randconfig-r041-20220227
riscv                randconfig-r042-20220227

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org
--===============2536631327864673876==--

