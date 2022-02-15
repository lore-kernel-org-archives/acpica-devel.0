Content-Type: multipart/mixed; boundary="===============4872998448574219281=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [rafael-pm:bleeding-edge 41/47] ld.lld: error: undefined
 symbol: ghes_disable
Date: Tue, 15 Feb 2022 15:47:19 +0800
Message-ID: <202202151504.jWpZGPaH-lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4872998448574219281==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
 bleeding-edge
head:   9db71e8e3027d2026be1ea9b6cfce8fd7216fb01
commit: f521a6e687d139e5d33a3d92f5ba4cd0a825cc66 [41/47] ACPI: APEI: explic=
it init HEST and GHES in apci_init()
config: arm64-randconfig-r004-20220214 (https://download.01.org/0day-ci/arc=
hive/20220215/202202151504.jWpZGPaH-lkp(a)intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 37f422=
f4ac31c8b8041c6b62065263314282dab6)
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it/commit/?id=3Df521a6e687d139e5d33a3d92f5ba4cd0a825cc66
        git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kerne=
l/git/rafael/linux-pm.git
        git fetch --no-tags rafael-pm bleeding-edge
        git checkout f521a6e687d139e5d33a3d92f5ba4cd0a825cc66
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=3D=
1 O=3Dbuild_dir ARCH=3Darm64 SHELL=3D/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp(a)intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: ghes_notify_sea
   >>> referenced by acpi.c
   >>> kernel/acpi.o:(apei_claim_sea) in archive arch/arm64/built-in.a
--
>> ld.lld: error: undefined symbol: ghes_disable
   >>> referenced by bus.c
   >>> acpi/bus.o:(acpi_bus_init) in archive drivers/built-in.a
   >>> referenced by bus.c
   >>> acpi/bus.o:(acpi_bus_init) in archive drivers/built-in.a

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for ACPI_APEI_GHES
   Depends on ACPI && ACPI_APEI
   Selected by
   - ARM_SDE_INTERFACE && ARM64

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org
--===============4872998448574219281==--

