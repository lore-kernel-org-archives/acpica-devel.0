Content-Type: multipart/mixed; boundary="===============1956141450001791886=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] [rafael-pm:bleeding-edge 12/27]
 drivers/acpi/acpi_amba.c:100:17: error: 'struct acpi_device' has no member
 named 'parent'
Date: Wed, 24 Aug 2022 22:41:55 +0800
Message-ID: <202208242233.FPqG2d3S-lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1956141450001791886==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
 bleeding-edge
head:   19c67c2579a54d65fea2ce802328ac3d0547b95c
commit: c097c05812636fef5d73b8a68444e4d885559929 [12/27] ACPI: Drop parent =
field from struct acpi_device
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/2022082=
4/202208242233.FPqG2d3S-lkp(a)intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it/commit/?id=3Dc097c05812636fef5d73b8a68444e4d885559929
        git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kerne=
l/git/rafael/linux-pm.git
        git fetch --no-tags rafael-pm bleeding-edge
        git checkout c097c05812636fef5d73b8a68444e4d885559929
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cross=
 W=3D1 O=3Dbuild_dir ARCH=3Darm64 SHELL=3D/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp(a)intel.com>

All errors (new ones prefixed by >>):

   drivers/acpi/acpi_amba.c: In function 'amba_handler_attach':
>> drivers/acpi/acpi_amba.c:100:17: error: 'struct acpi_device' has no memb=
er named 'parent'
     100 |         if (adev->parent)
         |                 ^~
   drivers/acpi/acpi_amba.c:101:68: error: 'struct acpi_device' has no memb=
er named 'parent'
     101 |                 dev->dev.parent =3D acpi_get_first_physical_node=
(adev->parent);
         |                                                                 =
   ^~
--
   drivers/perf/arm_dsu_pmu.c: In function 'dsu_pmu_acpi_get_cpus':
>> drivers/perf/arm_dsu_pmu.c:657:33: error: 'struct acpi_device' has no me=
mber named 'parent'
     657 |                         acpi_dev->parent =3D=3D ACPI_COMPANION(d=
ev)->parent)
         |                                 ^~
   drivers/perf/arm_dsu_pmu.c:657:64: error: 'struct acpi_device' has no me=
mber named 'parent'
     657 |                         acpi_dev->parent =3D=3D ACPI_COMPANION(d=
ev)->parent)
         |                                                                ^~
--
   drivers/perf/qcom_l3_pmu.c: In function 'qcom_l3_cache_pmu_probe':
>> drivers/perf/qcom_l3_pmu.c:745:31: error: 'struct acpi_device' has no me=
mber named 'parent'
     745 |                       acpi_dev->parent->pnp.unique_id, acpi_dev-=
>pnp.unique_id);
         |                               ^~


vim +100 drivers/acpi/acpi_amba.c

6ce2e188a6ae33 Graeme Gregory 2016-01-20   47  =

6ce2e188a6ae33 Graeme Gregory 2016-01-20   48  static int amba_handler_atta=
ch(struct acpi_device *adev,
6ce2e188a6ae33 Graeme Gregory 2016-01-20   49  				const struct acpi_device=
_id *id)
6ce2e188a6ae33 Graeme Gregory 2016-01-20   50  {
6ce2e188a6ae33 Graeme Gregory 2016-01-20   51  	struct amba_device *dev;
6ce2e188a6ae33 Graeme Gregory 2016-01-20   52  	struct resource_entry *rent=
ry;
6ce2e188a6ae33 Graeme Gregory 2016-01-20   53  	struct list_head resource_l=
ist;
6ce2e188a6ae33 Graeme Gregory 2016-01-20   54  	bool address_found =3D fals=
e;
6ce2e188a6ae33 Graeme Gregory 2016-01-20   55  	int irq_no =3D 0;
6ce2e188a6ae33 Graeme Gregory 2016-01-20   56  	int ret;
6ce2e188a6ae33 Graeme Gregory 2016-01-20   57  =

6ce2e188a6ae33 Graeme Gregory 2016-01-20   58  	/* If the ACPI node already=
 has a physical device attached, skip it. */
6ce2e188a6ae33 Graeme Gregory 2016-01-20   59  	if (adev->physical_node_cou=
nt)
6ce2e188a6ae33 Graeme Gregory 2016-01-20   60  		return 0;
6ce2e188a6ae33 Graeme Gregory 2016-01-20   61  =

6ce2e188a6ae33 Graeme Gregory 2016-01-20   62  	dev =3D amba_device_alloc(d=
ev_name(&adev->dev), 0, 0);
6ce2e188a6ae33 Graeme Gregory 2016-01-20   63  	if (!dev) {
6ce2e188a6ae33 Graeme Gregory 2016-01-20   64  		dev_err(&adev->dev, "%s():=
 amba_device_alloc() failed\n",
6ce2e188a6ae33 Graeme Gregory 2016-01-20   65  			__func__);
6ce2e188a6ae33 Graeme Gregory 2016-01-20   66  		return -ENOMEM;
6ce2e188a6ae33 Graeme Gregory 2016-01-20   67  	}
6ce2e188a6ae33 Graeme Gregory 2016-01-20   68  =

6ce2e188a6ae33 Graeme Gregory 2016-01-20   69  	INIT_LIST_HEAD(&resource_li=
st);
6ce2e188a6ae33 Graeme Gregory 2016-01-20   70  	ret =3D acpi_dev_get_resour=
ces(adev, &resource_list, NULL, NULL);
6ce2e188a6ae33 Graeme Gregory 2016-01-20   71  	if (ret < 0)
6ce2e188a6ae33 Graeme Gregory 2016-01-20   72  		goto err_free;
6ce2e188a6ae33 Graeme Gregory 2016-01-20   73  =

6ce2e188a6ae33 Graeme Gregory 2016-01-20   74  	list_for_each_entry(rentry,=
 &resource_list, node) {
6ce2e188a6ae33 Graeme Gregory 2016-01-20   75  		switch (resource_type(rent=
ry->res)) {
6ce2e188a6ae33 Graeme Gregory 2016-01-20   76  		case IORESOURCE_MEM:
6ce2e188a6ae33 Graeme Gregory 2016-01-20   77  			if (!address_found) {
6ce2e188a6ae33 Graeme Gregory 2016-01-20   78  				dev->res =3D *rentry->re=
s;
7718629432676b Liguang Zhang  2021-06-29   79  				dev->res.name =3D dev_na=
me(&dev->dev);
6ce2e188a6ae33 Graeme Gregory 2016-01-20   80  				address_found =3D true;
6ce2e188a6ae33 Graeme Gregory 2016-01-20   81  			}
6ce2e188a6ae33 Graeme Gregory 2016-01-20   82  			break;
6ce2e188a6ae33 Graeme Gregory 2016-01-20   83  		case IORESOURCE_IRQ:
6ce2e188a6ae33 Graeme Gregory 2016-01-20   84  			if (irq_no < AMBA_NR_IRQS)
6ce2e188a6ae33 Graeme Gregory 2016-01-20   85  				dev->irq[irq_no++] =3D r=
entry->res->start;
6ce2e188a6ae33 Graeme Gregory 2016-01-20   86  			break;
6ce2e188a6ae33 Graeme Gregory 2016-01-20   87  		default:
6ce2e188a6ae33 Graeme Gregory 2016-01-20   88  			dev_warn(&adev->dev, "Inv=
alid resource\n");
6ce2e188a6ae33 Graeme Gregory 2016-01-20   89  			break;
6ce2e188a6ae33 Graeme Gregory 2016-01-20   90  		}
6ce2e188a6ae33 Graeme Gregory 2016-01-20   91  	}
6ce2e188a6ae33 Graeme Gregory 2016-01-20   92  =

6ce2e188a6ae33 Graeme Gregory 2016-01-20   93  	acpi_dev_free_resource_list=
(&resource_list);
6ce2e188a6ae33 Graeme Gregory 2016-01-20   94  =

6ce2e188a6ae33 Graeme Gregory 2016-01-20   95  	/*
6ce2e188a6ae33 Graeme Gregory 2016-01-20   96  	 * If the ACPI node has a p=
arent and that parent has a physical device
6ce2e188a6ae33 Graeme Gregory 2016-01-20   97  	 * attached to it, that phy=
sical device should be the parent of
6ce2e188a6ae33 Graeme Gregory 2016-01-20   98  	 * the amba device we are a=
bout to create.
6ce2e188a6ae33 Graeme Gregory 2016-01-20   99  	 */
6ce2e188a6ae33 Graeme Gregory 2016-01-20 @100  	if (adev->parent)
6ce2e188a6ae33 Graeme Gregory 2016-01-20  101  		dev->dev.parent =3D acpi_g=
et_first_physical_node(adev->parent);
6ce2e188a6ae33 Graeme Gregory 2016-01-20  102  =

6ce2e188a6ae33 Graeme Gregory 2016-01-20  103  	ACPI_COMPANION_SET(&dev->de=
v, adev);
6ce2e188a6ae33 Graeme Gregory 2016-01-20  104  =

6ce2e188a6ae33 Graeme Gregory 2016-01-20  105  	ret =3D amba_device_add(dev=
, &iomem_resource);
6ce2e188a6ae33 Graeme Gregory 2016-01-20  106  	if (ret) {
6ce2e188a6ae33 Graeme Gregory 2016-01-20  107  		dev_err(&adev->dev, "%s():=
 amba_device_add() failed (%d)\n",
6ce2e188a6ae33 Graeme Gregory 2016-01-20  108  		       __func__, ret);
6ce2e188a6ae33 Graeme Gregory 2016-01-20  109  		goto err_free;
6ce2e188a6ae33 Graeme Gregory 2016-01-20  110  	}
6ce2e188a6ae33 Graeme Gregory 2016-01-20  111  =

6ce2e188a6ae33 Graeme Gregory 2016-01-20  112  	return 1;
6ce2e188a6ae33 Graeme Gregory 2016-01-20  113  =

6ce2e188a6ae33 Graeme Gregory 2016-01-20  114  err_free:
6ce2e188a6ae33 Graeme Gregory 2016-01-20  115  	amba_device_put(dev);
6ce2e188a6ae33 Graeme Gregory 2016-01-20  116  	return ret;
6ce2e188a6ae33 Graeme Gregory 2016-01-20  117  }
6ce2e188a6ae33 Graeme Gregory 2016-01-20  118  =


:::::: The code at line 100 was first introduced by commit
:::::: 6ce2e188a6ae339340d9bbf5bb0b81db20454353 ACPI / scan: AMBA bus probi=
ng support

:::::: TO: Graeme Gregory <graeme.gregory(a)linaro.org>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki(a)intel.com>

-- =

0-DAY CI Kernel Test Service
https://01.org/lkp
--===============1956141450001791886==--

