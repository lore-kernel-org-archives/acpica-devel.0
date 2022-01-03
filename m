Content-Type: multipart/mixed; boundary="===============2890168319481939310=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [rafael-pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 8d681a5245f0a5cfb20326b4f6578af1adb8676b
Date: Mon, 03 Jan 2022 17:49:06 +0100
Message-ID: <CAJZ5v0gx70huuZ7tj_iMZR3ViFfzX9F2Zt4BxqcHk_9OdioP1Q@mail.gmail.com>
In-Reply-To: BYAPR11MB32566B65A82D815C214720E487499@BYAPR11MB3256.namprd11.prod.outlook.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2890168319481939310==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 3, 2022 at 4:57 PM Moore, Robert <robert.moore(a)intel.com> wro=
te:
>
> Are these new warnings, or legacy warnings?

They are new, but AFAICS they appear because an old macro,
ACPI_PTR_DIFF(), has been used for defining a new one,
ACPI_PTR_TO_PHYSADDR(), which is now triggering the old warning in a
new way.

I guess this could be addressed by applying the Arnd's patch at
https://patchwork.kernel.org/project/linux-acpi/patch/20210927121338.938994=
-1-arnd(a)kernel.org/
, but that's problematic for the upstream.

However, I'm wondering if we can do something like the attached patch inste=
ad.



> -----Original Message-----
> From: kernel test robot <lkp(a)intel.com>
> Sent: Tuesday, December 28, 2021 10:30 PM
> To: Rafael J. Wysocki <rjw(a)rjwysocki.net>
> Cc: linux-pm(a)vger.kernel.org; devel(a)acpica.org; linux-acpi(a)vger.ker=
nel.org
> Subject: [Devel] [rafael-pm:bleeding-edge] BUILD SUCCESS WITH WARNING 8d6=
81a5245f0a5cfb20326b4f6578af1adb8676b
>
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux=
-pm.git bleeding-edge branch HEAD: 8d681a5245f0a5cfb20326b4f6578af1adb8676b=
  Merge branch 'acpi-sysfs' into bleeding-edge
>
> Warning reports:
>
> https://lore.kernel.org/llvm/202112280907.gTYYYuB4-lkp(a)intel.com
>
> Warning in current branch:
>
> drivers/acpi/acpica/exregion.c:519:17: warning: performing pointer subtra=
ction with a null pointer has undefined behavior [-Wnull-pointer-subtractio=
n]
>
> Warning ids grouped by kconfigs:
>
> clang_recent_errors
> |-- i386-randconfig-a001-20211229
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- i386-randconfig-a002-20211229
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- i386-randconfig-a003-20211229
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- i386-randconfig-a004-20211229
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- i386-randconfig-a005-20211229
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- i386-randconfig-a006-20211229
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- i386-randconfig-a011-20211228
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- i386-randconfig-a012-20211228
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- i386-randconfig-a013-20211228
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- i386-randconfig-a014-20211228
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- i386-randconfig-a015-20211228
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- i386-randconfig-a016-20211228
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- x86_64-randconfig-a001-20211229
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- x86_64-randconfig-a002-20211229
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- x86_64-randconfig-a003-20211229
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- x86_64-randconfig-a004-20211229
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- x86_64-randconfig-a005-20211229
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- x86_64-randconfig-a006-20211229
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- x86_64-randconfig-a011-20211228
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- x86_64-randconfig-a012-20211228
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- x86_64-randconfig-a013-20211228
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- x86_64-randconfig-a014-20211228
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- x86_64-randconfig-a015-20211228
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- x86_64-randconfig-a016-20211228
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> |-- x86_64-randconfig-r012-20211228
> |   `--
> |drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-w
> |ith-a-null-pointer-has-undefined-behavior
> `-- x86_64-randconfig-r024-20211228
>     `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtrac=
tion-with-a-null-pointer-has-undefined-behavior
>
> elapsed time: 725m
>
> configs tested: 104
> configs skipped: 3
>
> gcc tested configs:
> arm                              allyesconfig
> arm                              allmodconfig
> arm                                 defconfig
> arm64                               defconfig
> arm64                            allyesconfig
> i386                 randconfig-c001-20211228
> arm                           sama7_defconfig
> arc                        nsim_700_defconfig
> arm                            qcom_defconfig
> arm                          pxa3xx_defconfig
> powerpc                   bluestone_defconfig
> mips                      bmips_stb_defconfig
> arm                             ezx_defconfig
> sh                           se7343_defconfig
> powerpc                     skiroot_defconfig
> arm                         lpc18xx_defconfig
> arm                       imx_v6_v7_defconfig
> arm                          pxa910_defconfig
> powerpc                  mpc885_ads_defconfig
> powerpc                     pq2fads_defconfig
> arm                           sama5_defconfig
> arm                        shmobile_defconfig
> arc                    vdk_hs38_smp_defconfig
> csky                             alldefconfig
> riscv             nommu_k210_sdcard_defconfig
> arm                  randconfig-c002-20211229
> ia64                                defconfig
> ia64                             allmodconfig
> ia64                             allyesconfig
> m68k                             allmodconfig
> m68k                                defconfig
> m68k                             allyesconfig
> nds32                             allnoconfig
> nios2                               defconfig
> arc                              allyesconfig
> csky                                defconfig
> alpha                               defconfig
> nds32                               defconfig
> alpha                            allyesconfig
> nios2                            allyesconfig
> arc                                 defconfig
> sh                               allmodconfig
> h8300                            allyesconfig
> xtensa                           allyesconfig
> parisc                              defconfig
> s390                             allmodconfig
> parisc                           allyesconfig
> s390                                defconfig
> s390                             allyesconfig
> i386                             allyesconfig
> sparc                               defconfig
> i386                                defconfig
> i386                   debian-10.3-kselftests
> i386                              debian-10.3
> sparc                            allyesconfig
> mips                             allyesconfig
> mips                             allmodconfig
> powerpc                           allnoconfig
> powerpc                          allmodconfig
> powerpc                          allyesconfig
> arc                  randconfig-r043-20211228
> riscv                    nommu_k210_defconfig
> riscv                            allyesconfig
> riscv                    nommu_virt_defconfig
> riscv                             allnoconfig
> riscv                               defconfig
> riscv                          rv32_defconfig
> riscv                            allmodconfig
> um                           x86_64_defconfig
> um                             i386_defconfig
> x86_64                           allyesconfig
> x86_64                              defconfig
> x86_64                               rhel-8.3
> x86_64                          rhel-8.3-func
> x86_64                                  kexec
> x86_64                    rhel-8.3-kselftests
>
> clang tested configs:
> x86_64               randconfig-a001-20211229
> x86_64               randconfig-a003-20211229
> x86_64               randconfig-a004-20211229
> x86_64               randconfig-a002-20211229
> x86_64               randconfig-a005-20211229
> x86_64               randconfig-a006-20211229
> i386                 randconfig-a002-20211229
> i386                 randconfig-a003-20211229
> i386                 randconfig-a001-20211229
> i386                 randconfig-a005-20211229
> i386                 randconfig-a006-20211229
> i386                 randconfig-a004-20211229
> x86_64               randconfig-a013-20211228
> x86_64               randconfig-a012-20211228
> x86_64               randconfig-a011-20211228
> x86_64               randconfig-a016-20211228
> x86_64               randconfig-a015-20211228
> x86_64               randconfig-a014-20211228
> i386                 randconfig-a012-20211228
> i386                 randconfig-a011-20211228
> i386                 randconfig-a013-20211228
> i386                 randconfig-a016-20211228
> i386                 randconfig-a014-20211228
> i386                 randconfig-a015-20211228
> hexagon              randconfig-r041-20211228
> riscv                randconfig-r042-20211228
> s390                 randconfig-r044-20211228
> hexagon              randconfig-r045-20211228
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation https://lists.01.org/hype=
rkitty/list/kbuild-all(a)lists.01.org
> _______________________________________________
> Devel mailing list -- devel(a)acpica.org
> To unsubscribe send an email to devel-leave(a)acpica.org %(web_page_url)s=
listinfo%(cgiext)s/%(_internal_name)s

--===============2890168319481939310==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="acpica-build.patch"

LS0tCiBpbmNsdWRlL2FjcGkvYWN0eXBlcy5oICAgICAgICAgIHwgICAgNCArKysrCiBpbmNsdWRl
L2FjcGkvcGxhdGZvcm0vYWNsaW51eC5oIHwgICAgNSArKysrKwogMiBmaWxlcyBjaGFuZ2VkLCA5
IGluc2VydGlvbnMoKykKCkluZGV4OiBsaW51eC1wbS9pbmNsdWRlL2FjcGkvcGxhdGZvcm0vYWNs
aW51eC5oCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LXBtLm9yaWcvaW5jbHVkZS9hY3BpL3BsYXRmb3Jt
L2FjbGludXguaAorKysgbGludXgtcG0vaW5jbHVkZS9hY3BpL3BsYXRmb3JtL2FjbGludXguaApA
QCAtMjEzLDQgKzIxMyw5IEBACiAKICNlbmRpZgkJCQkvKiBfX0tFUk5FTF9fICovCiAKKyNkZWZp
bmUgYWNwaV91aW50cHRyX3QJCXVpbnRwdHJfdAorCisjZGVmaW5lIEFDUElfVE9fSU5URUdFUihw
KQkoKHVpbnRwdHJfdCkocCkpCisjZGVmaW5lIEFDUElfT0ZGU0VUKGQsIGYpCW9mZnNldG9mKGQs
IGYpCisKICNlbmRpZgkJCQkvKiBfX0FDTElOVVhfSF9fICovCkluZGV4OiBsaW51eC1wbS9pbmNs
dWRlL2FjcGkvYWN0eXBlcy5oCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LXBtLm9yaWcvaW5jbHVkZS9h
Y3BpL2FjdHlwZXMuaAorKysgbGludXgtcG0vaW5jbHVkZS9hY3BpL2FjdHlwZXMuaApAQCAtNTA3
LDggKzUwNywxMiBAQCB0eXBlZGVmIHU2NCBhY3BpX2ludGVnZXI7CiAvKiBQb2ludGVyL0ludGVn
ZXIgdHlwZSBjb252ZXJzaW9ucyAqLwogCiAjZGVmaW5lIEFDUElfVE9fUE9JTlRFUihpKSAgICAg
ICAgICAgICAgQUNQSV9DQVNUX1BUUiAodm9pZCwgKGFjcGlfc2l6ZSkgKGkpKQorI2lmbmRlZiBB
Q1BJX1RPX0lOVEVHRVIKICNkZWZpbmUgQUNQSV9UT19JTlRFR0VSKHApICAgICAgICAgICAgICBB
Q1BJX1BUUl9ESUZGIChwLCAodm9pZCAqKSAwKQorI2VuZGlmCisjaWZuZGVmIEFDUElfT0ZGU0VU
CiAjZGVmaW5lIEFDUElfT0ZGU0VUKGQsIGYpICAgICAgICAgICAgICAgQUNQSV9QVFJfRElGRiAo
JigoKGQgKikgMCktPmYpLCAodm9pZCAqKSAwKQorI2VuZGlmCiAjZGVmaW5lIEFDUElfUFRSX1RP
X1BIWVNBRERSKGkpICAgICAgICAgQUNQSV9UT19JTlRFR0VSKGkpCiAKIC8qIE9wdGltaXphdGlv
bnMgZm9yIDQtY2hhcmFjdGVyICgzMi1iaXQpIGFjcGlfbmFtZSBtYW5pcHVsYXRpb24gKi8K

--===============2890168319481939310==--

