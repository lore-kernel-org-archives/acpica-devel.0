Content-Type: multipart/mixed; boundary="===============5991848684269563815=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [rafael-pm:bleeding-edge] BUILD SUCCESS
 3d72f8341423038eaf304155884dda9989a2fc58
Date: Tue, 04 Jan 2022 22:41:20 +0800
Message-ID: <61d45c90.hMXKGWYzXg8ixuFr%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5991848684269563815==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-p=
m.git bleeding-edge
branch HEAD: 3d72f8341423038eaf304155884dda9989a2fc58  Merge branches 'ther=
mal' and 'thermal-int340x' into linux-next

possible Warning in current branch (please contact us if interested):

sound/soc/sh/rz-ssi.c:1023:9: warning: ignoring return value of 'pm_runtime=
_resume_and_get' declared with attribute 'warn_unused_result' [-Wunused-res=
ult]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- arm-allmodconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- arm-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- arm64-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- arm64-defconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- ia64-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- m68k-allmodconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- m68k-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- mips-allmodconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- mips-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- parisc-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- powerpc-allmodconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- powerpc-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
|-- s390-allyesconfig
|   `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result
`-- sparc-allyesconfig
    `-- sound-soc-sh-rz-ssi.c:warning:ignoring-return-value-of-pm_runtime_r=
esume_and_get-declared-with-attribute-warn_unused_result

elapsed time: 1467m

configs tested: 54
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org
--===============5991848684269563815==--

