Content-Type: multipart/mixed; boundary="===============5106969927579481120=="
MIME-Version: 1.0
From: kbuild test robot <lkp at intel.com>
Subject: [Devel] [pm:bleeding-edge] BUILD INCOMPLETE
 9b06ed497be3dc27f0d78dab0643f4cdb059577b
Date: Sun, 19 Jan 2020 22:18:44 +0800
Message-ID: <5e246544.SWpo1wlxetD90lo8%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5106969927579481120==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-p=
m.git  bleeding-edge
branch HEAD: 9b06ed497be3dc27f0d78dab0643f4cdb059577b  Merge branch 'pm-cpu=
idle-next' into bleeding-edge

TIMEOUT after 2880m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is =
busy
doing bisects for _other_ trees. The branch will get more complete coverage=
 and
possible error reports when our build infrastructure is restored or catches=
 up.
There will be no more build success notification for this branch head, but =
you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 28

arm                              allmodconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                            allyesconfig
i386                             alldefconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig

configs tested: 89
configs skipped: 1

sh                               allmodconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sh                            titan_defconfig
sparc                randconfig-a001-20200118
arm                  randconfig-a001-20200118
arm64                randconfig-a001-20200118
ia64                 randconfig-a001-20200118
arc                  randconfig-a001-20200118
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
h8300                    h8300h-sim_defconfig
h8300                     edosk2674_defconfig
m68k                           sun3_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
s390                 randconfig-a001-20200118
sh                   randconfig-a001-20200118
csky                 randconfig-a001-20200118
xtensa               randconfig-a001-20200118
openrisc             randconfig-a001-20200118
parisc               randconfig-a001-20200118
riscv                randconfig-a001-20200118
alpha                randconfig-a001-20200118
m68k                 randconfig-a001-20200118
nds32                randconfig-a001-20200118
xtensa                       common_defconfig
openrisc                    or1ksim_defconfig
nios2                         3c120_defconfig
xtensa                          iss_defconfig
c6x                        evmc6678_defconfig
c6x                              allyesconfig
nios2                         10m50_defconfig
openrisc                 simple_smp_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
arm                         at91_dt_defconfig
arm64                               defconfig
arm                        multi_v5_defconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm                          exynos_defconfig
arm                        shmobile_defconfig
arm                        multi_v7_defconfig
i386                 randconfig-d002-20200118
x86_64               randconfig-d002-20200118
x86_64               randconfig-d003-20200118
i386                 randconfig-d003-20200118
i386                 randconfig-d001-20200118
x86_64               randconfig-d001-20200118
s390                              allnoconfig
s390                             alldefconfig
s390                          debug_defconfig
s390                             allmodconfig
s390                                defconfig
s390                       zfcpdump_defconfig
s390                             allyesconfig
nds32                               defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
sparc64              randconfig-a001-20200118
microblaze           randconfig-a001-20200118
nios2                randconfig-a001-20200118
h8300                randconfig-a001-20200118
c6x                  randconfig-a001-20200118
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                              fedora-25
x86_64                                  kexec
mips                           32r2_defconfig
mips                              allnoconfig
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
parisc                            allnoconfig
arc                              allyesconfig
powerpc                             defconfig
microblaze                    nommu_defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
arc                                 defconfig
powerpc                           allnoconfig

---
0-DAY kernel test infrastructure                 Open Source Technology Cen=
ter
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org Intel Corpor=
ation
--===============5106969927579481120==--

