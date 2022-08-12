Content-Type: multipart/mixed; boundary="===============2704388536447532909=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] Re: [PATCH 2/2] EDAC/ghes: Modularize ghes_edac driver to
 remove the dependency on ghes
Date: Fri, 12 Aug 2022 18:58:06 +0800
Message-ID: <202208121802.AQBiO8LK-lkp@intel.com>
In-Reply-To: 20220811091713.10427-3-justin.he@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2704388536447532909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jia,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on ras/edac-for-next efi/next linus/master v5.19 n=
ext-20220812]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jia-He/Modularize-gh=
es_edac-driver/20220811-171953
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
 linux-next
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/202=
20812/202208121802.AQBiO8LK-lkp(a)intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/9cf68330d4fa626e09c=
8cbc3be9910751e94508c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jia-He/Modularize-ghes_edac-driver=
/20220811-171953
        git checkout 9cf68330d4fa626e09c8cbc3be9910751e94508c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=3D1 C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=3D=
build_dir ARCH=3Dx86_64 SHELL=3D/bin/bash drivers/acpi/apei/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp(a)intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/acpi/apei/ghes.c:97:1: sparse: sparse: symbol 'ghes_report_chain=
' was not declared. Should it be static?
   drivers/acpi/apei/ghes.c:733:25: sparse: sparse: incompatible types in c=
omparison expression (different address spaces):
   drivers/acpi/apei/ghes.c:733:25: sparse:    struct ghes_estatus_cache [n=
oderef] __rcu *
   drivers/acpi/apei/ghes.c:733:25: sparse:    struct ghes_estatus_cache *
   drivers/acpi/apei/ghes.c:813:25: sparse: sparse: incompatible types in c=
omparison expression (different address spaces):
   drivers/acpi/apei/ghes.c:813:25: sparse:    struct ghes_estatus_cache [n=
oderef] __rcu *
   drivers/acpi/apei/ghes.c:813:25: sparse:    struct ghes_estatus_cache *

-- =

0-DAY CI Kernel Test Service
https://01.org/lkp
--===============2704388536447532909==--

