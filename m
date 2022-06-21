Content-Type: multipart/mixed; boundary="===============4758157135052517275=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [rafael-pm:bleeding-edge 20/24] drivers/acpi/scan.c:2449:5:
 warning: no previous prototype for function 'acpi_bus_trim_one'
Date: Tue, 21 Jun 2022 16:18:43 +0800
Message-ID: <202206211629.ncqadywd-lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4758157135052517275==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
 bleeding-edge
head:   ef9088c776e0c49411bfb413ad43d110a9de1519
commit: e511ff6b4174fa81ca7ee16f8c17f7362c08fadf [20/24] ACPI: scan: Walk A=
CPI device's children using driver core
config: x86_64-randconfig-a013-20220620 (https://download.01.org/0day-ci/ar=
chive/20220621/202206211629.ncqadywd-lkp(a)intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project af6d2a=
0b6825e71965f3e2701a63c239fa0ad70f)
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it/commit/?id=3De511ff6b4174fa81ca7ee16f8c17f7362c08fadf
        git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kerne=
l/git/rafael/linux-pm.git
        git fetch --no-tags rafael-pm bleeding-edge
        git checkout e511ff6b4174fa81ca7ee16f8c17f7362c08fadf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=3D=
1 O=3Dbuild_dir ARCH=3Dx86_64 SHELL=3D/bin/bash drivers/acpi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp(a)intel.com>

All warnings (new ones prefixed by >>):

>> drivers/acpi/scan.c:2449:5: warning: no previous prototype for function =
'acpi_bus_trim_one' [-Wmissing-prototypes]
   int acpi_bus_trim_one(struct acpi_device *adev, void *not_used)
       ^
   drivers/acpi/scan.c:2449:1: note: declare 'static' if the function is no=
t intended to be used outside of this translation unit
   int acpi_bus_trim_one(struct acpi_device *adev, void *not_used)
   ^
   static =

   1 warning generated.


vim +/acpi_bus_trim_one +2449 drivers/acpi/scan.c

  2448	=

> 2449	int acpi_bus_trim_one(struct acpi_device *adev, void *not_used)
  2450	{
  2451		struct acpi_scan_handler *handler =3D adev->handler;
  2452	=

  2453		acpi_dev_for_each_child_reverse(adev, acpi_bus_trim_one, NULL);
  2454	=

  2455		adev->flags.match_driver =3D false;
  2456		if (handler) {
  2457			if (handler->detach)
  2458				handler->detach(adev);
  2459	=

  2460			adev->handler =3D NULL;
  2461		} else {
  2462			device_release_driver(&adev->dev);
  2463		}
  2464		/*
  2465		 * Most likely, the device is going away, so put it into D3cold bef=
ore
  2466		 * that.
  2467		 */
  2468		acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
  2469		adev->flags.initialized =3D false;
  2470		acpi_device_clear_enumerated(adev);
  2471	=

  2472		return 0;
  2473	}
  2474	=


-- =

0-DAY CI Kernel Test Service
https://01.org/lkp
--===============4758157135052517275==--

