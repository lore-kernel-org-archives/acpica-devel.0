Content-Type: multipart/mixed; boundary="===============1753137333507200870=="
MIME-Version: 1.0
From: kbuild test robot <lkp at intel.com>
Subject: [Devel] [pm:bleeding-edge] BUILD INCOMPLETE
 5fe5946b2ebcf750cfd4847550fa96eb1f03c870
Date: Sun, 26 Jan 2020 23:30:04 +0800
Message-ID: <5e2db07c.aJhkabFbzNwKacLE%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1753137333507200870==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-p=
m.git  bleeding-edge
branch HEAD: 5fe5946b2ebcf750cfd4847550fa96eb1f03c870  Merge branch 'pm-cor=
e-next' into bleeding-edge

TIMEOUT after 2896m


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

configs timed out: 19

alpha                               defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
nds32                               defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig

configs tested: 97
configs skipped: 1

arm                              allmodconfig
arm                         at91_dt_defconfig
arm64                               defconfig
arm                        multi_v5_defconfig
arm                              allyesconfig
arm64                            allyesconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                            allmodconfig
arm                          exynos_defconfig
arm                        shmobile_defconfig
arm                        multi_v7_defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
h8300                    h8300h-sim_defconfig
h8300                     edosk2674_defconfig
m68k                           sun3_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
ia64                             alldefconfig
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
i386                              allnoconfig
i386                                defconfig
i386                             allyesconfig
i386                             alldefconfig
sh                               allmodconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sh                            titan_defconfig
x86_64               randconfig-c003-20200126
i386                 randconfig-c003-20200126
x86_64               randconfig-c002-20200126
x86_64               randconfig-c001-20200126
i386                 randconfig-c001-20200126
i386                 randconfig-c002-20200126
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
parisc                            allnoconfig
sparc64                          allmodconfig
sparc                            allyesconfig
sparc64                          allyesconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm64                randconfig-a001-20200125
ia64                 randconfig-a001-20200125
arm                  randconfig-a001-20200125
arc                  randconfig-a001-20200125
sparc                randconfig-a001-20200125
x86_64               randconfig-f003-20200126
x86_64               randconfig-f001-20200126
x86_64               randconfig-f002-20200126
i386                 randconfig-f002-20200126
i386                 randconfig-f003-20200126
i386                 randconfig-f001-20200126
arc                              allyesconfig
microblaze                    nommu_defconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
arc                                 defconfig
csky                                defconfig
nds32                             allnoconfig
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                              fedora-25
x86_64                                  kexec
x86_64                         rhel-7.2-clear
h8300                randconfig-a001-20200125
nios2                randconfig-a001-20200125
c6x                  randconfig-a001-20200125
sparc64              randconfig-a001-20200125
microblaze           randconfig-a001-20200125

---
0-DAY kernel test infrastructure                 Open Source Technology Cen=
ter
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org Intel Corpor=
ation
--===============1753137333507200870==--

