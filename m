Content-Type: multipart/mixed; boundary="===============2785234238812930639=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] Re: [PATCH v2 7/8] spi: pxa2xx: Refactor _UID handling to use
 acpi_dev_uid_to_integer()
Date: Tue, 13 Sep 2022 09:00:06 +0800
Message-ID: <202209130810.dgrshDMB-lkp@intel.com>
In-Reply-To: 20220908132910.62122-8-andriy.shevchenko@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2785234238812930639==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andy,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on wsa/i2c/for-next broonie-spi/for-next efi/next =
linus/master v6.0-rc5 next-20220912]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/ACPI=
-unify-_UID-handling-as-integer/20220908-213543
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
 linux-next
config: x86_64-buildonly-randconfig-r006-20220912 (https://download.01.org/=
0day-ci/archive/20220913/202209130810.dgrshDMB-lkp(a)intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=3D1 build):
        # https://github.com/intel-lab-lkp/linux/commit/ea7999676bc9f75bb41=
65358cda640b340fe34d0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/ACPI-unify-_UID-ha=
ndling-as-integer/20220908-213543
        git checkout ea7999676bc9f75bb4165358cda640b340fe34d0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=3D1 O=3Dbuild_dir ARCH=3Dx86_64 SHELL=3D/bin/bash drivers/sp=
i/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp(a)intel.com>

All warnings (new ones prefixed by >>):

   drivers/spi/spi-pxa2xx.c: In function 'pxa2xx_spi_init_pdata':
>> drivers/spi/spi-pxa2xx.c:1457:24: warning: unused variable 'dev' [-Wunus=
ed-variable]
    1457 |         struct device *dev =3D &pdev->dev;
         |                        ^~~


vim +/dev +1457 drivers/spi/spi-pxa2xx.c

  1452	=

  1453	static struct pxa2xx_spi_controller *
  1454	pxa2xx_spi_init_pdata(struct platform_device *pdev)
  1455	{
  1456		struct pxa2xx_spi_controller *pdata;
> 1457		struct device *dev =3D &pdev->dev;
  1458		struct ssp_device *ssp;
  1459		struct resource *res;
  1460		struct device *parent =3D pdev->dev.parent;
  1461		struct pci_dev *pcidev =3D dev_is_pci(parent) ? to_pci_dev(parent) =
: NULL;
  1462		const struct pci_device_id *pcidev_id =3D NULL;
  1463		enum pxa_ssp_type type;
  1464		const void *match;
  1465		int status;
  1466		u64 uid;
  1467	=

  1468		if (pcidev)
  1469			pcidev_id =3D pci_match_id(pxa2xx_spi_pci_compound_match, pcidev);
  1470	=

  1471		match =3D device_get_match_data(&pdev->dev);
  1472		if (match)
  1473			type =3D (enum pxa_ssp_type)match;
  1474		else if (pcidev_id)
  1475			type =3D (enum pxa_ssp_type)pcidev_id->driver_data;
  1476		else
  1477			return ERR_PTR(-EINVAL);
  1478	=

  1479		pdata =3D devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
  1480		if (!pdata)
  1481			return ERR_PTR(-ENOMEM);
  1482	=

  1483		ssp =3D &pdata->ssp;
  1484	=

  1485		res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
  1486		ssp->mmio_base =3D devm_ioremap_resource(&pdev->dev, res);
  1487		if (IS_ERR(ssp->mmio_base))
  1488			return ERR_CAST(ssp->mmio_base);
  1489	=

  1490		ssp->phys_base =3D res->start;
  1491	=


-- =

0-DAY CI Kernel Test Service
https://01.org/lkp
--===============2785234238812930639==--

