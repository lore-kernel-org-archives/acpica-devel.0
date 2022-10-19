Content-Type: multipart/mixed; boundary="===============2380663879511063773=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [rafael-pm:bleeding-edge] BUILD SUCCESS
 ba1b46e36fd7cae85e58325de9814fd9a594b4fe
Date: Wed, 19 Oct 2022 09:51:04 +0800
Message-ID: <634f5808.tjazel2jfYuEqNTa%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2380663879511063773==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-p=
m.git bleeding-edge
branch HEAD: ba1b46e36fd7cae85e58325de9814fd9a594b4fe  Merge branch 'pm-cpu=
freq' into linux-next

elapsed time: 722m

configs tested: 145
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
arc                               allnoconfig
arc                                 defconfig
alpha                             allnoconfig
riscv                             allnoconfig
csky                              allnoconfig
alpha                               defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                             allyesconfig
i386                                defconfig
s390                                defconfig
s390                             allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
s390                             allyesconfig
powerpc                         wii_defconfig
arm                            lart_defconfig
sh                   sh7770_generic_defconfig
arc                    vdk_hs38_smp_defconfig
arc                     nsimosci_hs_defconfig
m68k                             allmodconfig
arc                              allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
alpha                            allyesconfig
m68k                             allyesconfig
i386                          randconfig-a001
arc                  randconfig-r043-20221018
i386                          randconfig-a003
riscv                randconfig-r042-20221018
s390                 randconfig-r044-20221018
powerpc                           allnoconfig
mips                             allyesconfig
i386                          randconfig-a005
powerpc                          allmodconfig
sh                               allmodconfig
sh                           se7751_defconfig
m68k                       m5275evb_defconfig
powerpc                     pq2fads_defconfig
sh                   sh7724_generic_defconfig
ia64                          tiger_defconfig
microblaze                      mmu_defconfig
powerpc                      ppc6xx_defconfig
xtensa                  audio_kc705_defconfig
arc                           tb10x_defconfig
openrisc                 simple_smp_defconfig
i386                          randconfig-c001
sparc                             allnoconfig
powerpc                     tqm8541_defconfig
mips                  maltasmvp_eva_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
powerpc                     stx_gp3_defconfig
powerpc                   currituck_defconfig
powerpc                 mpc834x_mds_defconfig
arm                        trizeps4_defconfig
powerpc                 linkstation_defconfig
m68k                        mvme16x_defconfig
ia64                                defconfig
arm                        mvebu_v7_defconfig
nios2                               defconfig
m68k                          amiga_defconfig
openrisc                         alldefconfig
arm                      jornada720_defconfig
ia64                             allmodconfig
arm                        cerfcube_defconfig
sh                  sh7785lcr_32bit_defconfig
arc                  randconfig-r043-20221017
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
arm                        spear6xx_defconfig
arm                         assabet_defconfig
mips                 decstation_r4k_defconfig
powerpc                      ep88xc_defconfig
arm                         lpc18xx_defconfig
arm                            mps2_defconfig
sh                          r7780mp_defconfig
arm                         axm55xx_defconfig
ia64                        generic_defconfig
arm                           tegra_defconfig
powerpc                      chrp32_defconfig
mips                         db1xxx_defconfig
powerpc                  storcenter_defconfig
powerpc                 canyonlands_defconfig
sh                          urquell_defconfig
m68k                                defconfig
sh                 kfr2r09-romimage_defconfig
s390                       zfcpdump_defconfig
openrisc                            defconfig
powerpc                     tqm8548_defconfig
openrisc                  or1klitex_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20221018

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-c007
mips                 randconfig-c004-20221018
i386                          randconfig-c001
s390                 randconfig-c005-20221018
arm                  randconfig-c002-20221018
riscv                randconfig-c006-20221018
powerpc              randconfig-c003-20221018
x86_64                        randconfig-a014
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a016
hexagon              randconfig-r041-20221018
hexagon              randconfig-r045-20221018
i386                 randconfig-a013-20221017
i386                 randconfig-a015-20221017
i386                 randconfig-a016-20221017
i386                 randconfig-a011-20221017
i386                 randconfig-a014-20221017
i386                 randconfig-a012-20221017
x86_64                        randconfig-k001
arm                      tct_hammer_defconfig
riscv                             allnoconfig
arm                      pxa255-idp_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                      ppc44x_defconfig
mips                        maltaup_defconfig
arm                                 defconfig
mips                           rs90_defconfig

-- =

0-DAY CI Kernel Test Service
https://01.org/lkp
--===============2380663879511063773==--

