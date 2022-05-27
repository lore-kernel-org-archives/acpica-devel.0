Content-Type: multipart/mixed; boundary="===============7408125054300979684=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [rafael-pm:bleeding-edge] BUILD SUCCESS
 4eec359c469be110cdaa32c4a511930e9459fd8b
Date: Fri, 27 May 2022 15:30:01 +0800
Message-ID: <62907df9.MhV6PMu3R7X9bBr/%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7408125054300979684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-p=
m.git bleeding-edge
branch HEAD: 4eec359c469be110cdaa32c4a511930e9459fd8b  Merge branch 'pm-doc=
s' into linux-next

Unverified Warning (likely false positive, please contact us if interested):

kernel/reboot.c:554:43: warning: Parameter 'power_off' can be declared with=
 const [constParameter]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- m68k-randconfig-p001-20220524
|   `-- kernel-reboot.c:warning:Parameter-power_off-can-be-declared-with-co=
nst-constParameter
`-- microblaze-randconfig-p002-20220524
    `-- kernel-reboot.c:warning:Parameter-power_off-can-be-declared-with-co=
nst-constParameter

elapsed time: 723m

configs tested: 142
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
arm64                               defconfig
i386                          randconfig-c001
powerpc                          allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
powerpc                          allyesconfig
s390                             allmodconfig
s390                             allyesconfig
arm                            mps2_defconfig
arm                         assabet_defconfig
sh                          polaris_defconfig
powerpc                      pcm030_defconfig
mips                         db1xxx_defconfig
arm                           imxrt_defconfig
parisc                           alldefconfig
arm                         vf610m4_defconfig
parisc64                            defconfig
sh                            titan_defconfig
sh                           sh2007_defconfig
openrisc                         alldefconfig
sh                           se7712_defconfig
arm                          pxa3xx_defconfig
sh                ecovec24-romimage_defconfig
mips                         bigsur_defconfig
powerpc                      ep88xc_defconfig
arc                           tb10x_defconfig
powerpc                         ps3_defconfig
sh                          sdk7786_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                   motionpro_defconfig
nios2                         10m50_defconfig
arm                            zeus_defconfig
um                               alldefconfig
sh                           se7619_defconfig
powerpc                     asp8347_defconfig
sparc                       sparc32_defconfig
arm                            pleb_defconfig
arm                     eseries_pxa_defconfig
sparc                       sparc64_defconfig
sh                        apsh4ad0a_defconfig
sh                           se7343_defconfig
s390                       zfcpdump_defconfig
arm                        trizeps4_defconfig
sh                            hp6xx_defconfig
mips                 decstation_r4k_defconfig
riscv                    nommu_k210_defconfig
m68k                        m5407c3_defconfig
powerpc                     ep8248e_defconfig
arc                            hsdk_defconfig
arm                  randconfig-c002-20220526
arm                  randconfig-c002-20220524
x86_64                        randconfig-c001
ia64                                defconfig
ia64                             allyesconfig
ia64                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
parisc                              defconfig
parisc                           allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220524
s390                 randconfig-r044-20220524
riscv                randconfig-r042-20220524
arc                  randconfig-r043-20220526
riscv                randconfig-r042-20220526
s390                 randconfig-r044-20220526
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz

clang tested configs:
powerpc                  mpc885_ads_defconfig
mips                        workpad_defconfig
mips                       rbtx49xx_defconfig
powerpc                      walnut_defconfig
mips                         tb0287_defconfig
powerpc                      obs600_defconfig
arm                        mvebu_v5_defconfig
mips                      pic32mzda_defconfig
arm                     am200epdkit_defconfig
mips                           ip28_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220524
hexagon              randconfig-r045-20220526
hexagon              randconfig-r041-20220526
hexagon              randconfig-r041-20220524

-- =

0-DAY CI Kernel Test Service
https://01.org/lkp
--===============7408125054300979684==--

