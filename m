Content-Type: multipart/mixed; boundary="===============1856041520063363900=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] Re: [PATCH 17/18] gpio: gpiolib-acpi: Export acpi_get_gpiod()
Date: Tue, 01 Dec 2020 01:02:44 +0800
Message-ID: <202012010027.JNVAUExJ-lkp@intel.com>
In-Reply-To: 20201130133129.1024662-18-djrscally@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1856041520063363900==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linuxtv-media/master]
[also build test ERROR on driver-core/driver-core-testing pm/linux-next v5.=
10-rc6 next-20201130]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Daniel-Scally/Add-function=
ality-to-ipu3-cio2-driver-allowing-software_node-connections-to-sensors-on-=
platforms-designed-for-Windows/20201130-214014
base:   git://linuxtv.org/media_tree.git master
config: s390-randconfig-p001-20201130 (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/eb1854ac694a8e59c0ea703e4=
6fe2ee7e3118b42
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Daniel-Scally/Add-functionality-to=
-ipu3-cio2-driver-allowing-software_node-connections-to-sensors-on-platform=
s-designed-for-Windows/20201130-214014
        git checkout eb1854ac694a8e59c0ea703e46fe2ee7e3118b42
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-9.3.0 make.cross =
ARCH=3Ds390 =


If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp(a)intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: kernel/sysctl.o: in function `acpi_get_gpiod':
>> sysctl.c:(.text+0x2bb8): multiple definition of `acpi_get_gpiod'; init/m=
ain.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: kernel/irq/irqdomain.o: in function `acpi_get_gpiod':
   irqdomain.c:(.text+0x378): multiple definition of `acpi_get_gpiod'; init=
/main.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: kernel/dma/mapping.o: in function `acpi_get_gpiod':
   mapping.c:(.text+0xb0): multiple definition of `acpi_get_gpiod'; init/ma=
in.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/gpio/gpiolib.o: in function `acpi_get_gpiod':
   gpiolib.c:(.text+0x1c00): multiple definition of `acpi_get_gpiod'; init/=
main.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/gpio/gpio-pca953x.o: in function `acpi_get_gpiod':
   gpio-pca953x.c:(.text+0x29e0): multiple definition of `acpi_get_gpiod'; =
init/main.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/gpio/gpio-pca9570.o: in function `acpi_get_gpiod':
   gpio-pca9570.c:(.text+0x338): multiple definition of `acpi_get_gpiod'; i=
nit/main.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/gpio/gpio-pcf857x.o: in function `acpi_get_gpiod':
   gpio-pcf857x.c:(.text+0xcb0): multiple definition of `acpi_get_gpiod'; i=
nit/main.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/gpio/gpio-tpic2810.o: in function `acpi_get_gpiod=
':
   gpio-tpic2810.c:(.text+0x418): multiple definition of `acpi_get_gpiod'; =
init/main.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/pwm/core.o: in function `acpi_get_gpiod':
   core.c:(.text+0x660): multiple definition of `acpi_get_gpiod'; init/main=
.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/pwm/pwm-pca9685.o: in function `acpi_get_gpiod':
   pwm-pca9685.c:(.text+0x10d8): multiple definition of `acpi_get_gpiod'; i=
nit/main.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/dma/dmaengine.o: in function `acpi_get_gpiod':
   dmaengine.c:(.text+0x1f30): multiple definition of `acpi_get_gpiod'; ini=
t/main.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/dma/dw/platform.o: in function `acpi_get_gpiod':
   platform.c:(.text+0x420): multiple definition of `acpi_get_gpiod'; init/=
main.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/dma/qcom/hidma.o: in function `acpi_get_gpiod':
   hidma.c:(.text+0x28e8): multiple definition of `acpi_get_gpiod'; init/ma=
in.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/regulator/88pg86x.o: in function `acpi_get_gpiod':
   88pg86x.c:(.text+0x198): multiple definition of `acpi_get_gpiod'; init/m=
ain.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/regulator/ad5398.o: in function `acpi_get_gpiod':
   ad5398.c:(.text+0x780): multiple definition of `acpi_get_gpiod'; init/ma=
in.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/regulator/da9210-regulator.o: in function `acpi_g=
et_gpiod':
   da9210-regulator.c:(.text+0x628): multiple definition of `acpi_get_gpiod=
'; init/main.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/regulator/isl6271a-regulator.o: in function `acpi=
_get_gpiod':
   isl6271a-regulator.c:(.text+0x3b8): multiple definition of `acpi_get_gpi=
od'; init/main.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/regulator/isl9305.o: in function `acpi_get_gpiod':
   isl9305.c:(.text+0x1a0): multiple definition of `acpi_get_gpiod'; init/m=
ain.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/regulator/lp872x.o: in function `acpi_get_gpiod':
   lp872x.c:(.text+0x11c0): multiple definition of `acpi_get_gpiod'; init/m=
ain.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/regulator/lp8755.o: in function `acpi_get_gpiod':
   lp8755.c:(.text+0x1148): multiple definition of `acpi_get_gpiod'; init/m=
ain.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/regulator/ltc3589.o: in function `acpi_get_gpiod':
   ltc3589.c:(.text+0x8c8): multiple definition of `acpi_get_gpiod'; init/m=
ain.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/regulator/max8649.o: in function `acpi_get_gpiod':
   max8649.c:(.text+0x7a0): multiple definition of `acpi_get_gpiod'; init/m=
ain.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/regulator/max8660.o: in function `acpi_get_gpiod':
   max8660.c:(.text+0xe28): multiple definition of `acpi_get_gpiod'; init/m=
ain.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/regulator/max77826-regulator.o: in function `acpi=
_get_gpiod':
   max77826-regulator.c:(.text+0x230): multiple definition of `acpi_get_gpi=
od'; init/main.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/regulator/mp8859.o: in function `acpi_get_gpiod':
   mp8859.c:(.text+0x2e0): multiple definition of `acpi_get_gpiod'; init/ma=
in.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/regulator/mt6311-regulator.o: in function `acpi_g=
et_gpiod':
   mt6311-regulator.c:(.text+0x248): multiple definition of `acpi_get_gpiod=
'; init/main.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/regulator/pca9450-regulator.o: in function `acpi_=
get_gpiod':
   pca9450-regulator.c:(.text+0x790): multiple definition of `acpi_get_gpio=
d'; init/main.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/regulator/pfuze100-regulator.o: in function `acpi=
_get_gpiod':
   pfuze100-regulator.c:(.text+0xaa8): multiple definition of `acpi_get_gpi=
od'; init/main.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/regulator/pv88060-regulator.o: in function `acpi_=
get_gpiod':
   pv88060-regulator.c:(.text+0x870): multiple definition of `acpi_get_gpio=
d'; init/main.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/regulator/pv88080-regulator.o: in function `acpi_=
get_gpiod':
   pv88080-regulator.c:(.text+0xb38): multiple definition of `acpi_get_gpio=
d'; init/main.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/regulator/pv88090-regulator.o: in function `acpi_=
get_gpiod':
   pv88090-regulator.c:(.text+0x960): multiple definition of `acpi_get_gpio=
d'; init/main.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/regulator/rt4801-regulator.o: in function `acpi_g=
et_gpiod':
   rt4801-regulator.c:(.text+0x6a0): multiple definition of `acpi_get_gpiod=
'; init/main.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/regulator/rtmv20-regulator.o: in function `acpi_g=
et_gpiod':
   rtmv20-regulator.c:(.text+0xb20): multiple definition of `acpi_get_gpiod=
'; init/main.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/regulator/slg51000-regulator.o: in function `acpi=
_get_gpiod':
   slg51000-regulator.c:(.text+0xb28): multiple definition of `acpi_get_gpi=
od'; init/main.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/regulator/tps62360-regulator.o: in function `acpi=
_get_gpiod':
   tps62360-regulator.c:(.text+0xe68): multiple definition of `acpi_get_gpi=
od'; init/main.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/regulator/tps65132-regulator.o: in function `acpi=
_get_gpiod':
   tps65132-regulator.c:(.text+0x728): multiple definition of `acpi_get_gpi=
od'; init/main.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/base/core.o: in function `acpi_get_gpiod':
   core.c:(.text+0x27f8): multiple definition of `acpi_get_gpiod'; init/mai=
n.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/base/platform.o: in function `acpi_get_gpiod':
   platform.c:(.text+0x798): multiple definition of `acpi_get_gpiod'; init/=
main.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/base/cpu.o: in function `acpi_get_gpiod':
   cpu.c:(.text+0x8c8): multiple definition of `acpi_get_gpiod'; init/main.=
o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/base/property.o: in function `acpi_get_gpiod':
   property.c:(.text+0x2f8): multiple definition of `acpi_get_gpiod'; init/=
main.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/base/cacheinfo.o: in function `acpi_get_gpiod':
   cacheinfo.c:(.text+0xca8): multiple definition of `acpi_get_gpiod'; init=
/main.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/base/regmap/regmap-i2c.o: in function `acpi_get_g=
piod':
   regmap-i2c.c:(.text+0xcb0): multiple definition of `acpi_get_gpiod'; ini=
t/main.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/misc/ad525x_dpot-i2c.o: in function `acpi_get_gpi=
od':
   ad525x_dpot-i2c.c:(.text+0x278): multiple definition of `acpi_get_gpiod'=
; init/main.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/misc/bh1770glc.o: in function `acpi_get_gpiod':
   bh1770glc.c:(.text+0x28a8): multiple definition of `acpi_get_gpiod'; ini=
t/main.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/misc/apds990x.o: in function `acpi_get_gpiod':
   apds990x.c:(.text+0x23a8): multiple definition of `acpi_get_gpiod'; init=
/main.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/misc/isl29003.o: in function `acpi_get_gpiod':
   isl29003.c:(.text+0xad8): multiple definition of `acpi_get_gpiod'; init/=
main.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/misc/isl29020.o: in function `acpi_get_gpiod':
   isl29020.c:(.text+0x5e8): multiple definition of `acpi_get_gpiod'; init/=
main.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/misc/tsl2550.o: in function `acpi_get_gpiod':
   tsl2550.c:(.text+0x9d8): multiple definition of `acpi_get_gpiod'; init/m=
ain.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/misc/ds1682.o: in function `acpi_get_gpiod':
   ds1682.c:(.text+0x578): multiple definition of `acpi_get_gpiod'; init/ma=
in.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/misc/hmc6352.o: in function `acpi_get_gpiod':
   hmc6352.c:(.text+0x568): multiple definition of `acpi_get_gpiod'; init/m=
ain.o:main.c:(.text+0x0): first defined here
   s390-linux-ld: drivers/misc/eeprom/eeprom.o: in function `acpi_get_gpiod=
':
   eeprom.c:(.text+0x7a0): multiple definition of `acpi_get_gpiod'; init/ma=
in.o:main.c:(.text+0x0): first defined here

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org

--===============1856041520063363900==
Content-Type: application/gzip
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config.gz"

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
--===============1856041520063363900==--

