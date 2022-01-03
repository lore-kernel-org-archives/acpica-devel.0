Content-Type: multipart/mixed; boundary="===============1466796329737977717=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Re: [rafael-pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 8d681a5245f0a5cfb20326b4f6578af1adb8676b
Date: Mon, 03 Jan 2022 15:57:42 +0000
Message-ID: <BYAPR11MB32566B65A82D815C214720E487499@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: 61cc007a.mWwpG8hntz2tC9i6%lkp@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1466796329737977717==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Are these new warnings, or legacy warnings?


-----Original Message-----
From: kernel test robot <lkp(a)intel.com> =

Sent: Tuesday, December 28, 2021 10:30 PM
To: Rafael J. Wysocki <rjw(a)rjwysocki.net>
Cc: linux-pm(a)vger.kernel.org; devel(a)acpica.org; linux-acpi(a)vger.kerne=
l.org
Subject: [Devel] [rafael-pm:bleeding-edge] BUILD SUCCESS WITH WARNING 8d681=
a5245f0a5cfb20326b4f6578af1adb8676b

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-p=
m.git bleeding-edge branch HEAD: 8d681a5245f0a5cfb20326b4f6578af1adb8676b  =
Merge branch 'acpi-sysfs' into bleeding-edge

Warning reports:

https://lore.kernel.org/llvm/202112280907.gTYYYuB4-lkp(a)intel.com

Warning in current branch:

drivers/acpi/acpica/exregion.c:519:17: warning: performing pointer subtract=
ion with a null pointer has undefined behavior [-Wnull-pointer-subtraction]

Warning ids grouped by kconfigs:

clang_recent_errors
|-- i386-randconfig-a001-20211229
|   `-- =

|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a002-20211229
|   `-- =

|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a003-20211229
|   `-- =

|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a004-20211229
|   `-- =

|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a005-20211229
|   `-- =

|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a006-20211229
|   `-- =

|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a011-20211228
|   `-- =

|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a012-20211228
|   `-- =

|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a013-20211228
|   `-- =

|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a014-20211228
|   `-- =

|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a015-20211228
|   `-- =

|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- i386-randconfig-a016-20211228
|   `-- =

|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a001-20211229
|   `-- =

|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a002-20211229
|   `-- =

|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a003-20211229
|   `-- =

|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a004-20211229
|   `-- =

|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a005-20211229
|   `-- =

|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a006-20211229
|   `-- =

|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a011-20211228
|   `-- =

|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a012-20211228
|   `-- =

|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a013-20211228
|   `-- =

|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a014-20211228
|   `-- =

|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a015-20211228
|   `-- =

|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-a016-20211228
|   `-- =

|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
|-- x86_64-randconfig-r012-20211228
|   `-- =

|drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
|ith-a-null-pointer-has-undefined-behavior
`-- x86_64-randconfig-r024-20211228
    `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtracti=
on-with-a-null-pointer-has-undefined-behavior

elapsed time: 725m

configs tested: 104
configs skipped: 3

gcc tested configs:
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
i386                 randconfig-c001-20211228
arm                           sama7_defconfig
arc                        nsim_700_defconfig
arm                            qcom_defconfig
arm                          pxa3xx_defconfig
powerpc                   bluestone_defconfig
mips                      bmips_stb_defconfig
arm                             ezx_defconfig
sh                           se7343_defconfig
powerpc                     skiroot_defconfig
arm                         lpc18xx_defconfig
arm                       imx_v6_v7_defconfig
arm                          pxa910_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                     pq2fads_defconfig
arm                           sama5_defconfig
arm                        shmobile_defconfig
arc                    vdk_hs38_smp_defconfig
csky                             alldefconfig
riscv             nommu_k210_sdcard_defconfig
arm                  randconfig-c002-20211229
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
arc                  randconfig-r043-20211228
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64               randconfig-a001-20211229
x86_64               randconfig-a003-20211229
x86_64               randconfig-a004-20211229
x86_64               randconfig-a002-20211229
x86_64               randconfig-a005-20211229
x86_64               randconfig-a006-20211229
i386                 randconfig-a002-20211229
i386                 randconfig-a003-20211229
i386                 randconfig-a001-20211229
i386                 randconfig-a005-20211229
i386                 randconfig-a006-20211229
i386                 randconfig-a004-20211229
x86_64               randconfig-a013-20211228
x86_64               randconfig-a012-20211228
x86_64               randconfig-a011-20211228
x86_64               randconfig-a016-20211228
x86_64               randconfig-a015-20211228
x86_64               randconfig-a014-20211228
i386                 randconfig-a012-20211228
i386                 randconfig-a011-20211228
i386                 randconfig-a013-20211228
i386                 randconfig-a016-20211228
i386                 randconfig-a014-20211228
i386                 randconfig-a015-20211228
hexagon              randconfig-r041-20211228
riscv                randconfig-r042-20211228
s390                 randconfig-r044-20211228
hexagon              randconfig-r045-20211228

---
0-DAY CI Kernel Test Service, Intel Corporation https://lists.01.org/hyperk=
itty/list/kbuild-all(a)lists.01.org
_______________________________________________
Devel mailing list -- devel(a)acpica.org
To unsubscribe send an email to devel-leave(a)acpica.org %(web_page_url)sli=
stinfo%(cgiext)s/%(_internal_name)s
--===============1466796329737977717==--

