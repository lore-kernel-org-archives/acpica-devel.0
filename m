Content-Type: multipart/mixed; boundary="===============0007720675732313101=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [rafael-pm:bleeding-edge] BUILD SUCCESS
 2517a0ba026a90d717f7bd9ee51098c10e93904d
Date: Tue, 31 May 2022 12:51:58 +0800
Message-ID: <62959eee.s3Cftj/5JE61nbEP%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0007720675732313101==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-p=
m.git bleeding-edge
branch HEAD: 2517a0ba026a90d717f7bd9ee51098c10e93904d  Merge branch 'acpi-o=
sl' into linux-next

Unverified Warning (likely false positive, please contact us if interested):

kernel/reboot.c:554:43: warning: Parameter 'power_off' can be declared with=
 const [constParameter]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-randconfig-p002-20220530
|   `-- kernel-reboot.c:warning:Parameter-power_off-can-be-declared-with-co=
nst-constParameter
`-- x86_64-randconfig-p001-20220530
    `-- kernel-reboot.c:warning:Parameter-power_off-can-be-declared-with-co=
nst-constParameter

elapsed time: 722m

configs tested: 128
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
mips                             allyesconfig
riscv                            allmodconfig
um                             i386_defconfig
mips                             allmodconfig
riscv                            allyesconfig
um                           x86_64_defconfig
i386                 randconfig-c001-20220530
m68k                       m5249evb_defconfig
arm                       omap2plus_defconfig
mips                       capcella_defconfig
sh                   sh7770_generic_defconfig
m68k                          hp300_defconfig
h8300                            alldefconfig
powerpc                      mgcoge_defconfig
arm                         nhk8815_defconfig
sh                        sh7763rdp_defconfig
mips                     loongson1b_defconfig
arm                            lart_defconfig
s390                       zfcpdump_defconfig
powerpc64                           defconfig
x86_64                        randconfig-c001
i386                          randconfig-c001
arm                  randconfig-c002-20220531
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
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
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64               randconfig-a003-20220530
x86_64               randconfig-a006-20220530
x86_64               randconfig-a004-20220530
x86_64               randconfig-a001-20220530
x86_64               randconfig-a002-20220530
x86_64               randconfig-a005-20220530
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                 randconfig-a002-20220530
i386                 randconfig-a003-20220530
i386                 randconfig-a004-20220530
i386                 randconfig-a005-20220530
i386                 randconfig-a001-20220530
i386                 randconfig-a006-20220530
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220530
arc                  randconfig-r043-20220531
s390                 randconfig-r044-20220531
riscv                randconfig-r042-20220531
riscv                             allnoconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                     pseries_defconfig
mips                       lemote2f_defconfig
powerpc                      pmac32_defconfig
powerpc                      walnut_defconfig
mips                         tb0219_defconfig
powerpc                     kmeter1_defconfig
mips                malta_qemu_32r6_defconfig
arm                       imx_v4_v5_defconfig
arm                    vt8500_v6_v7_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a011-20220530
x86_64               randconfig-a013-20220530
x86_64               randconfig-a012-20220530
x86_64               randconfig-a014-20220530
x86_64               randconfig-a015-20220530
x86_64               randconfig-a016-20220530
i386                 randconfig-a012-20220530
i386                 randconfig-a011-20220530
i386                 randconfig-a014-20220530
i386                 randconfig-a016-20220530
i386                 randconfig-a013-20220530
i386                 randconfig-a015-20220530
hexagon              randconfig-r045-20220530
s390                 randconfig-r044-20220530
hexagon              randconfig-r041-20220530
riscv                randconfig-r042-20220530

-- =

0-DAY CI Kernel Test Service
https://01.org/lkp
--===============0007720675732313101==--

