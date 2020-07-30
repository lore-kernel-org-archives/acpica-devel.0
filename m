Content-Type: multipart/mixed; boundary="===============3301988780710012237=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 5bff8c754ebfc08b9cead967f38ebc0152d2076f
Date: Thu, 30 Jul 2020 13:40:49 +0800
Message-ID: <5f225d61.YfXWCartLr/vi0w8%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3301988780710012237==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-p=
m.git  bleeding-edge
branch HEAD: 5bff8c754ebfc08b9cead967f38ebc0152d2076f  Merge branch 'pm-cpu=
freq' into bleeding-edge

Warning in current branch:

drivers/acpi/processor_idle.c:667:4: warning: 'return' with no value, in fu=
nction returning non-void [-Wreturn-type]

Warning ids grouped by kconfigs:

recent_errors
`-- ia64-randconfig-r024-20200729
    `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-funct=
ion-returning-non-void

elapsed time: 722m

configs tested: 48
configs skipped: 1

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org
--===============3301988780710012237==--

