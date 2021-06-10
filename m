Content-Type: multipart/mixed; boundary="===============8048784233304004376=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [pm:bleeding-edge] BUILD REGRESSION
 7604cba9f860bcae8fd95c907ffee8ebeab73bef
Date: Thu, 10 Jun 2021 13:49:03 +0800
Message-ID: <60c1a7cf.RxXdz+WqdMAIwLNd%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8048784233304004376==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-p=
m.git bleeding-edge
branch HEAD: 7604cba9f860bcae8fd95c907ffee8ebeab73bef  Merge branch 'pm-cpu=
idle' into bleeding-edge

Error/Warning in current branch:

drivers/acpi/prmt.c:109:60: error: 'struct acpi_prmt_module_info' has no me=
mber named 'handler_count'; did you mean 'handler_info_count'?
drivers/acpi/prmt.c:112:45: error: 'struct acpi_prmt_module_info' has no me=
mber named 'guid'
drivers/acpi/prmt.c:141:46: error: 'struct acpi_prmt_handler_info' has no m=
ember named 'guid'
drivers/acpi/prmt.c:142:51: error: 'struct acpi_prmt_handler_info' has no m=
ember named 'address'
drivers/acpi/prmt.c:92:84: error: 'struct acpi_prmt_module_info' has no mem=
ber named 'handler_offset'; did you mean 'handler_info_offset'?
drivers/gpu/drm/xen/xen_drm_front.c:710:42: warning: shift count >=3D width=
 of type [-Wshift-count-overflow]
include/linux/acpi.h:135:33: error: field has incomplete type 'struct acpi_=
prmt_module_header'

possible Error/Warning in current branch:

drivers/acpi/prmt.c:109:60: error: no member named 'handler_count' in 'stru=
ct acpi_prmt_module_info'
drivers/acpi/prmt.c:112:47: error: no member named 'guid' in 'struct acpi_p=
rmt_module_info'
drivers/acpi/prmt.c:137:17: error: no member named 'handler_offset' in 'str=
uct acpi_prmt_module_info'
drivers/acpi/prmt.c:141:48: error: no member named 'guid' in 'struct acpi_p=
rmt_handler_info'
drivers/acpi/prmt.c:142:53: error: no member named 'address' in 'struct acp=
i_prmt_handler_info'
drivers/ata/sata_nv.c:1127:40: warning: shift count >=3D width of type [-Ws=
hift-count-overflow]
drivers/block/mtip32xx/mtip32xx.c:4027:45: warning: shift count >=3D width =
of type [-Wshift-count-overflow]
drivers/gpu/drm/i915/display/intel_fb.c:652:2: error: shift count >=3D widt=
h of type [-Werror,-Wshift-count-overflow]
drivers/gpu/drm/i915/gem/i915_gem_internal.c:172:6: error: shift count >=3D=
 width of type [-Werror,-Wshift-count-overflow]
drivers/gpu/drm/i915/i915_query.c:451:7: error: shift count >=3D width of t=
ype [-Werror,-Wshift-count-overflow]
drivers/gpu/drm/i915/selftests/i915_gem_gtt.c:116:6: error: shift count >=
=3D width of type [-Werror,-Wshift-count-overflow]
drivers/gpu/drm/i915/selftests/mock_gem_device.c:127:43: error: shift count=
 >=3D width of type [-Werror,-Wshift-count-overflow]
drivers/gpu/drm/vmwgfx/vmwgfx_drv.c:606:44: warning: shift count >=3D width=
 of type [-Wshift-count-overflow]
drivers/i2c/busses/i2c-amd-mp2-pci.c:310:33: warning: shift count >=3D widt=
h of type [-Wshift-count-overflow]
drivers/i2c/busses/i2c-ismt.c:921:30: warning: shift count >=3D width of ty=
pe [-Wshift-count-overflow]
drivers/net/ethernet/sfc/falcon/falcon.c:332:2: warning: shift count >=3D w=
idth of type [-Wshift-count-overflow]
drivers/net/ethernet/sfc/falcon/falcon.c:332:2: warning: shift count is neg=
ative [-Wshift-count-negative]
drivers/net/ethernet/sfc/falcon/farch.c:184:3: warning: shift count >=3D wi=
dth of type [-Wshift-count-overflow]
drivers/net/ethernet/sfc/falcon/farch.c:184:3: warning: shift count is nega=
tive [-Wshift-count-negative]
drivers/ntb/hw/amd/ntb_hw_amd.c:1179:30: warning: shift count >=3D width of=
 type [-Wshift-count-overflow]
drivers/video/fbdev/hyperv_fb.c:982:36: warning: shift count >=3D width of =
type [-Wshift-count-overflow]
include/linux/acpi.h:135:33: error: field 'prmt' has incomplete type

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-allyesconfig
|   `-- include-linux-acpi.h:error:field-prmt-has-incomplete-type
|-- arm64-defconfig
|   `-- include-linux-acpi.h:error:field-prmt-has-incomplete-type
|-- i386-allyesconfig
|   `-- include-linux-acpi.h:error:field-prmt-has-incomplete-type
|-- i386-defconfig
|   `-- include-linux-acpi.h:error:field-prmt-has-incomplete-type
|-- i386-randconfig-a001-20210608
|   `-- include-linux-acpi.h:error:field-prmt-has-incomplete-type
|-- i386-randconfig-a002-20210608
|   `-- include-linux-acpi.h:error:field-prmt-has-incomplete-type
|-- i386-randconfig-a005-20210608
|   `-- include-linux-acpi.h:error:field-prmt-has-incomplete-type
|-- i386-randconfig-a014-20210608
|   `-- include-linux-acpi.h:error:field-prmt-has-incomplete-type
|-- i386-randconfig-c001-20210608
|   `-- include-linux-acpi.h:error:field-prmt-has-incomplete-type
|-- i386-randconfig-s001-20210608
|   `-- include-linux-acpi.h:error:field-prmt-has-incomplete-type
|-- i386-randconfig-s031-20210608
|   `-- include-linux-acpi.h:error:field-prmt-has-incomplete-type
|-- ia64-allmodconfig
|   `-- include-linux-acpi.h:error:field-prmt-has-incomplete-type
|-- ia64-allyesconfig
|   `-- include-linux-acpi.h:error:field-prmt-has-incomplete-type
|-- x86_64-allmodconfig
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_handler_info-has-no-memb=
er-named-address
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_handler_info-has-no-memb=
er-named-guid
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_module_info-has-no-membe=
r-named-guid
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_module_info-has-no-membe=
r-named-handler_count
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_module_info-has-no-membe=
r-named-handler_offset
|   `-- include-linux-acpi.h:error:field-prmt-has-incomplete-type
|-- x86_64-allyesconfig
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_handler_info-has-no-memb=
er-named-address
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_handler_info-has-no-memb=
er-named-guid
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_module_info-has-no-membe=
r-named-guid
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_module_info-has-no-membe=
r-named-handler_count
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_module_info-has-no-membe=
r-named-handler_offset
|   `-- include-linux-acpi.h:error:field-prmt-has-incomplete-type
|-- x86_64-defconfig
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_handler_info-has-no-memb=
er-named-address
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_handler_info-has-no-memb=
er-named-guid
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_module_info-has-no-membe=
r-named-guid
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_module_info-has-no-membe=
r-named-handler_count
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_module_info-has-no-membe=
r-named-handler_offset
|   `-- include-linux-acpi.h:error:field-prmt-has-incomplete-type
|-- x86_64-kexec
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_handler_info-has-no-memb=
er-named-address
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_handler_info-has-no-memb=
er-named-guid
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_module_info-has-no-membe=
r-named-guid
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_module_info-has-no-membe=
r-named-handler_count
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_module_info-has-no-membe=
r-named-handler_offset
|   `-- include-linux-acpi.h:error:field-prmt-has-incomplete-type
|-- x86_64-randconfig-a001-20210608
|   `-- include-linux-acpi.h:error:field-prmt-has-incomplete-type
|-- x86_64-randconfig-a003-20210608
|   `-- include-linux-acpi.h:error:field-prmt-has-incomplete-type
|-- x86_64-randconfig-a005-20210608
|   `-- include-linux-acpi.h:error:field-prmt-has-incomplete-type
|-- x86_64-randconfig-a006-20210608
|   `-- include-linux-acpi.h:error:field-prmt-has-incomplete-type
|-- x86_64-randconfig-c002-20210608
|   `-- include-linux-acpi.h:error:field-prmt-has-incomplete-type
|-- x86_64-randconfig-r004-20210608
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_handler_info-has-no-memb=
er-named-address
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_handler_info-has-no-memb=
er-named-guid
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_module_info-has-no-membe=
r-named-guid
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_module_info-has-no-membe=
r-named-handler_count
|   `-- drivers-acpi-prmt.c:error:struct-acpi_prmt_module_info-has-no-membe=
r-named-handler_offset
|-- x86_64-rhel-8.3
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_handler_info-has-no-memb=
er-named-address
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_handler_info-has-no-memb=
er-named-guid
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_module_info-has-no-membe=
r-named-guid
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_module_info-has-no-membe=
r-named-handler_count
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_module_info-has-no-membe=
r-named-handler_offset
|   `-- include-linux-acpi.h:error:field-prmt-has-incomplete-type
|-- x86_64-rhel-8.3-kbuiltin
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_handler_info-has-no-memb=
er-named-address
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_handler_info-has-no-memb=
er-named-guid
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_module_info-has-no-membe=
r-named-guid
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_module_info-has-no-membe=
r-named-handler_count
|   |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_module_info-has-no-membe=
r-named-handler_offset
|   `-- include-linux-acpi.h:error:field-prmt-has-incomplete-type
`-- x86_64-rhel-8.3-kselftests
    |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_handler_info-has-no-memb=
er-named-address
    |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_handler_info-has-no-memb=
er-named-guid
    |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_module_info-has-no-membe=
r-named-guid
    |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_module_info-has-no-membe=
r-named-handler_count
    |-- drivers-acpi-prmt.c:error:struct-acpi_prmt_module_info-has-no-membe=
r-named-handler_offset
    `-- include-linux-acpi.h:error:field-prmt-has-incomplete-type

clang_recent_errors
|-- x86_64-randconfig-a011-20210608
|   |-- drivers-ata-sata_nv.c:warning:shift-count-width-of-type
|   |-- drivers-block-mtip32xx-mtip32xx.c:warning:shift-count-width-of-type
|   |-- drivers-gpu-drm-i915-display-intel_fb.c:error:shift-count-width-of-=
type-Werror-Wshift-count-overflow
|   |-- drivers-gpu-drm-i915-gem-i915_gem_internal.c:error:shift-count-widt=
h-of-type-Werror-Wshift-count-overflow
|   |-- drivers-gpu-drm-i915-i915_query.c:error:shift-count-width-of-type-W=
error-Wshift-count-overflow
|   |-- drivers-gpu-drm-i915-selftests-i915_gem_gtt.c:error:shift-count-wid=
th-of-type-Werror-Wshift-count-overflow
|   |-- drivers-gpu-drm-i915-selftests-mock_gem_device.c:error:shift-count-=
width-of-type-Werror-Wshift-count-overflow
|   |-- drivers-gpu-drm-vmwgfx-vmwgfx_drv.c:warning:shift-count-width-of-ty=
pe
|   |-- drivers-net-ethernet-sfc-falcon-falcon.c:warning:shift-count-is-neg=
ative
|   |-- drivers-net-ethernet-sfc-falcon-falcon.c:warning:shift-count-width-=
of-type
|   |-- drivers-net-ethernet-sfc-falcon-farch.c:warning:shift-count-is-nega=
tive
|   |-- drivers-net-ethernet-sfc-falcon-farch.c:warning:shift-count-width-o=
f-type
|   `-- drivers-ntb-hw-amd-ntb_hw_amd.c:warning:shift-count-width-of-type
|-- x86_64-randconfig-a015-20210608
|   `-- drivers-gpu-drm-xen-xen_drm_front.c:warning:shift-count-width-of-ty=
pe
|-- x86_64-randconfig-a016-20210608
|   |-- drivers-acpi-prmt.c:error:no-member-named-address-in-struct-acpi_pr=
mt_handler_info
|   |-- drivers-acpi-prmt.c:error:no-member-named-guid-in-struct-acpi_prmt_=
handler_info
|   |-- drivers-acpi-prmt.c:error:no-member-named-guid-in-struct-acpi_prmt_=
module_info
|   |-- drivers-acpi-prmt.c:error:no-member-named-handler_count-in-struct-a=
cpi_prmt_module_info
|   |-- drivers-acpi-prmt.c:error:no-member-named-handler_offset-in-struct-=
acpi_prmt_module_info
|   |-- drivers-i2c-busses-i2c-amd-mp2-pci.c:warning:shift-count-width-of-t=
ype
|   |-- drivers-i2c-busses-i2c-ismt.c:warning:shift-count-width-of-type
|   `-- drivers-video-fbdev-hyperv_fb.c:warning:shift-count-width-of-type
`-- x86_64-randconfig-b001-20210608
    `-- include-linux-acpi.h:error:field-has-incomplete-type-struct-acpi_pr=
mt_module_header

elapsed time: 722m

configs tested: 98
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                   sh7724_generic_defconfig
sh                          kfr2r09_defconfig
sparc                            alldefconfig
arm                             rpc_defconfig
arm                             ezx_defconfig
mips                         tb0287_defconfig
powerpc                    mvme5100_defconfig
powerpc                 mpc8560_ads_defconfig
arm                       cns3420vb_defconfig
sh                           se7721_defconfig
powerpc                     mpc5200_defconfig
parisc                           alldefconfig
arm                         assabet_defconfig
mips                           ip32_defconfig
sh                   rts7751r2dplus_defconfig
mips                           ci20_defconfig
arm                       aspeed_g4_defconfig
m68k                             alldefconfig
sh                           se7343_defconfig
powerpc                     mpc83xx_defconfig
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
x86_64               randconfig-a004-20210608
x86_64               randconfig-a002-20210608
x86_64               randconfig-a003-20210608
x86_64               randconfig-a006-20210608
x86_64               randconfig-a005-20210608
x86_64               randconfig-a001-20210608
i386                 randconfig-a003-20210608
i386                 randconfig-a006-20210608
i386                 randconfig-a004-20210608
i386                 randconfig-a001-20210608
i386                 randconfig-a005-20210608
i386                 randconfig-a002-20210608
i386                 randconfig-a015-20210608
i386                 randconfig-a013-20210608
i386                 randconfig-a016-20210608
i386                 randconfig-a011-20210608
i386                 randconfig-a012-20210608
i386                 randconfig-a014-20210608
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210608
x86_64               randconfig-a012-20210608
x86_64               randconfig-a014-20210608
x86_64               randconfig-a011-20210608
x86_64               randconfig-a016-20210608
x86_64               randconfig-a013-20210608

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org
--===============8048784233304004376==--

