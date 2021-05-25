Content-Type: multipart/mixed; boundary="===============3280732313009993271=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [pm:bleeding-edge] BUILD SUCCESS
 04e5775c09a2edfe8b310fd22099d46d98e0a5d2
Date: Tue, 25 May 2021 10:56:22 +0800
Message-ID: <60ac6756.Ry0ZjKs6/VsAolJM%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3280732313009993271==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-p=
m.git bleeding-edge
branch HEAD: 04e5775c09a2edfe8b310fd22099d46d98e0a5d2  Merge branch 'acpi-m=
isc' into bleeding-edge

i386-tinyconfig vmlinux size:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 TOTAL  TEXT                                                           =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
     0     0  04e5775c09a2 Merge branch 'acpi-misc' into bleeding-edge =

  -172  -174  c4681547bcce..04e5775c09a2 (ALL COMMITS)                 =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

elapsed time: 722m

configs tested: 98
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         shannon_defconfig
powerpc                      ppc64e_defconfig
arm                         assabet_defconfig
powerpc                       eiger_defconfig
microblaze                      mmu_defconfig
powerpc                     skiroot_defconfig
powerpc                      tqm8xx_defconfig
sh                                  defconfig
arm                          gemini_defconfig
powerpc                 linkstation_defconfig
mips                         tb0226_defconfig
powerpc                       maple_defconfig
arm                            qcom_defconfig
sh                   sh7724_generic_defconfig
arm                      integrator_defconfig
arm                        oxnas_v6_defconfig
sh                         microdev_defconfig
parisc                generic-32bit_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210524
i386                 randconfig-a002-20210524
i386                 randconfig-a005-20210524
i386                 randconfig-a006-20210524
i386                 randconfig-a004-20210524
i386                 randconfig-a003-20210524
i386                 randconfig-a011-20210524
i386                 randconfig-a016-20210524
i386                 randconfig-a015-20210524
i386                 randconfig-a012-20210524
i386                 randconfig-a014-20210524
i386                 randconfig-a013-20210524
x86_64               randconfig-a005-20210524
x86_64               randconfig-a001-20210524
x86_64               randconfig-a006-20210524
x86_64               randconfig-a003-20210524
x86_64               randconfig-a004-20210524
x86_64               randconfig-a002-20210524
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210524
x86_64               randconfig-a013-20210524
x86_64               randconfig-a012-20210524
x86_64               randconfig-a014-20210524
x86_64               randconfig-a016-20210524
x86_64               randconfig-a015-20210524
x86_64               randconfig-a011-20210524

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org
--===============3280732313009993271==--

