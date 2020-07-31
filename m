Content-Type: multipart/mixed; boundary="===============5610209737303531677=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 97987ea7f86a35284fd54efc7412db246f178666
Date: Fri, 31 Jul 2020 15:31:54 +0800
Message-ID: <5f23c8ea.PWJ3lFt9FGpnoBxp%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5610209737303531677==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-p=
m.git  bleeding-edge
branch HEAD: 97987ea7f86a35284fd54efc7412db246f178666  Merge branch 'pm-dev=
freq' into linux-next

Warning in current branch:

drivers/acpi/processor_idle.c:666:4: warning: 'return' with no value, in fu=
nction returning non-void [-Wreturn-type]

Warning ids grouped by kconfigs:

recent_errors
|-- i386-allyesconfig
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-funct=
ion-returning-non-void
|-- i386-defconfig
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-funct=
ion-returning-non-void
|-- i386-randconfig-a011-20200731
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-funct=
ion-returning-non-void
|-- i386-randconfig-a012-20200731
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-funct=
ion-returning-non-void
|-- i386-randconfig-a013-20200731
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-funct=
ion-returning-non-void
|-- i386-randconfig-a014-20200731
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-funct=
ion-returning-non-void
|-- i386-randconfig-a015-20200731
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-funct=
ion-returning-non-void
|-- i386-randconfig-a016-20200731
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-funct=
ion-returning-non-void
|-- i386-randconfig-c001-20200730
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-funct=
ion-returning-non-void
|-- i386-randconfig-r003-20200730
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-funct=
ion-returning-non-void
|-- ia64-allmodconfig
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-funct=
ion-returning-non-void
|-- ia64-allyesconfig
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-funct=
ion-returning-non-void
|-- ia64-defconfig
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-funct=
ion-returning-non-void
|-- ia64-randconfig-r025-20200730
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-funct=
ion-returning-non-void
|-- x86_64-allmodconfig
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-funct=
ion-returning-non-void
|-- x86_64-allyesconfig
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-funct=
ion-returning-non-void
|-- x86_64-defconfig
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-funct=
ion-returning-non-void
|-- x86_64-kexec
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-funct=
ion-returning-non-void
|-- x86_64-rhel
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-funct=
ion-returning-non-void
|-- x86_64-rhel-7.6-kselftests
|   `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-funct=
ion-returning-non-void
`-- x86_64-rhel-8.3
    `-- drivers-acpi-processor_idle.c:warning:return-with-no-value-in-funct=
ion-returning-non-void

elapsed time: 840m

configs tested: 66
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
i386                 randconfig-a005-20200731
i386                 randconfig-a004-20200731
i386                 randconfig-a006-20200731
i386                 randconfig-a002-20200731
i386                 randconfig-a001-20200731
i386                 randconfig-a003-20200731
x86_64               randconfig-a015-20200731
x86_64               randconfig-a014-20200731
x86_64               randconfig-a016-20200731
x86_64               randconfig-a012-20200731
x86_64               randconfig-a013-20200731
x86_64               randconfig-a011-20200731
i386                 randconfig-a016-20200731
i386                 randconfig-a012-20200731
i386                 randconfig-a014-20200731
i386                 randconfig-a015-20200731
i386                 randconfig-a011-20200731
i386                 randconfig-a013-20200731
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
--===============5610209737303531677==--

