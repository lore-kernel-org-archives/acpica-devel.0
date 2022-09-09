Content-Type: multipart/mixed; boundary="===============8248671224827552495=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] Re: [PATCH v2 6/8] perf: qcom_l2_pmu: Refactor _UID handling
 to use acpi_dev_uid_to_integer()
Date: Fri, 09 Sep 2022 12:40:36 +0800
Message-ID: <202209091254.rIFedxQL-lkp@intel.com>
In-Reply-To: 20220908132910.62122-7-andriy.shevchenko@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8248671224827552495==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andy,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on wsa/i2c/for-next broonie-spi/for-next efi/next =
linus/master v6.0-rc4 next-20220908]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/ACPI=
-unify-_UID-handling-as-integer/20220908-213543
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
 linux-next
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/2022090=
9/202209091254.rIFedxQL-lkp(a)intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9441434beecbf7fcd74=
ca58adbb06cc53c874179
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/ACPI-unify-_UID-ha=
ndling-as-integer/20220908-213543
        git checkout 9441434beecbf7fcd74ca58adbb06cc53c874179
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cross=
 W=3D1 O=3Dbuild_dir ARCH=3Darm64 SHELL=3D/bin/bash drivers/perf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp(a)intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/acpi.h:15,
                    from drivers/perf/qcom_l2_pmu.c:4:
   drivers/perf/qcom_l2_pmu.c: In function 'l2_cache_pmu_probe_cluster':
>> drivers/perf/qcom_l2_pmu.c:882:17: warning: format '%ld' expects argumen=
t of type 'long int', but argument 3 has type 'u64' {aka 'long long unsigne=
d int'} [-Wformat=3D]
     882 |                 "Registered L2 cache PMU cluster %ld\n", fw_clus=
ter_id);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_pri=
ntk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);               =
        \
         |                              ^~~
   include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
     150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt=
(fmt), ##__VA_ARGS__)
         |                                                          ^~~~~~~
   drivers/perf/qcom_l2_pmu.c:881:9: note: in expansion of macro 'dev_info'
     881 |         dev_info(&pdev->dev,
         |         ^~~~~~~~
   drivers/perf/qcom_l2_pmu.c:882:52: note: format string is defined here
     882 |                 "Registered L2 cache PMU cluster %ld\n", fw_clus=
ter_id);
         |                                                  ~~^
         |                                                    |
         |                                                    long int
         |                                                  %lld


vim +882 drivers/perf/qcom_l2_pmu.c

21bdbb7102edea Neil Leeder     2017-02-07  838  =

21bdbb7102edea Neil Leeder     2017-02-07  839  static int l2_cache_pmu_pro=
be_cluster(struct device *dev, void *data)
21bdbb7102edea Neil Leeder     2017-02-07  840  {
21bdbb7102edea Neil Leeder     2017-02-07  841  	struct platform_device *pd=
ev =3D to_platform_device(dev->parent);
21bdbb7102edea Neil Leeder     2017-02-07  842  	struct platform_device *sd=
ev =3D to_platform_device(dev);
21bdbb7102edea Neil Leeder     2017-02-07  843  	struct l2cache_pmu *l2cach=
e_pmu =3D data;
21bdbb7102edea Neil Leeder     2017-02-07  844  	struct cluster_pmu *cluste=
r;
9441434beecbf7 Andy Shevchenko 2022-09-08  845  	u64 fw_cluster_id;
21bdbb7102edea Neil Leeder     2017-02-07  846  	int err;
21bdbb7102edea Neil Leeder     2017-02-07  847  	int irq;
21bdbb7102edea Neil Leeder     2017-02-07  848  =

9441434beecbf7 Andy Shevchenko 2022-09-08  849  	err =3D acpi_dev_uid_to_in=
teger(ACPI_COMPANION(dev), &fw_cluster_id);
9441434beecbf7 Andy Shevchenko 2022-09-08  850  	if (err) {
21bdbb7102edea Neil Leeder     2017-02-07  851  		dev_err(&pdev->dev, "unab=
le to read ACPI uid\n");
9441434beecbf7 Andy Shevchenko 2022-09-08  852  		return err;
21bdbb7102edea Neil Leeder     2017-02-07  853  	}
21bdbb7102edea Neil Leeder     2017-02-07  854  =

21bdbb7102edea Neil Leeder     2017-02-07  855  	cluster =3D devm_kzalloc(&=
pdev->dev, sizeof(*cluster), GFP_KERNEL);
21bdbb7102edea Neil Leeder     2017-02-07  856  	if (!cluster)
21bdbb7102edea Neil Leeder     2017-02-07  857  		return -ENOMEM;
21bdbb7102edea Neil Leeder     2017-02-07  858  =

21bdbb7102edea Neil Leeder     2017-02-07  859  	INIT_LIST_HEAD(&cluster->n=
ext);
21bdbb7102edea Neil Leeder     2017-02-07  860  	list_add(&cluster->next, &=
l2cache_pmu->clusters);
21bdbb7102edea Neil Leeder     2017-02-07  861  	cluster->cluster_id =3D fw=
_cluster_id;
21bdbb7102edea Neil Leeder     2017-02-07  862  =

21bdbb7102edea Neil Leeder     2017-02-07  863  	irq =3D platform_get_irq(s=
dev, 0);
228f855fb57ae2 Stephen Boyd    2019-07-30  864  	if (irq < 0)
21bdbb7102edea Neil Leeder     2017-02-07  865  		return irq;
21bdbb7102edea Neil Leeder     2017-02-07  866  	cluster->irq =3D irq;
21bdbb7102edea Neil Leeder     2017-02-07  867  =

21bdbb7102edea Neil Leeder     2017-02-07  868  	cluster->l2cache_pmu =3D l=
2cache_pmu;
21bdbb7102edea Neil Leeder     2017-02-07  869  	cluster->on_cpu =3D -1;
21bdbb7102edea Neil Leeder     2017-02-07  870  =

21bdbb7102edea Neil Leeder     2017-02-07  871  	err =3D devm_request_irq(&=
pdev->dev, irq, l2_cache_handle_irq,
0d0f144a8f5f98 Tian Tao        2021-06-02  872  			       IRQF_NOBALANCING =
| IRQF_NO_THREAD |
0d0f144a8f5f98 Tian Tao        2021-06-02  873  			       IRQF_NO_AUTOEN,
21bdbb7102edea Neil Leeder     2017-02-07  874  			       "l2-cache-pmu", c=
luster);
21bdbb7102edea Neil Leeder     2017-02-07  875  	if (err) {
21bdbb7102edea Neil Leeder     2017-02-07  876  		dev_err(&pdev->dev,
21bdbb7102edea Neil Leeder     2017-02-07  877  			"Unable to request IRQ%d=
 for L2 PMU counters\n", irq);
21bdbb7102edea Neil Leeder     2017-02-07  878  		return err;
21bdbb7102edea Neil Leeder     2017-02-07  879  	}
21bdbb7102edea Neil Leeder     2017-02-07  880  =

21bdbb7102edea Neil Leeder     2017-02-07  881  	dev_info(&pdev->dev,
21bdbb7102edea Neil Leeder     2017-02-07 @882  		"Registered L2 cache PMU =
cluster %ld\n", fw_cluster_id);
21bdbb7102edea Neil Leeder     2017-02-07  883  =

21bdbb7102edea Neil Leeder     2017-02-07  884  	spin_lock_init(&cluster->p=
mu_lock);
21bdbb7102edea Neil Leeder     2017-02-07  885  =

21bdbb7102edea Neil Leeder     2017-02-07  886  	l2cache_pmu->num_pmus++;
21bdbb7102edea Neil Leeder     2017-02-07  887  =

21bdbb7102edea Neil Leeder     2017-02-07  888  	return 0;
21bdbb7102edea Neil Leeder     2017-02-07  889  }
21bdbb7102edea Neil Leeder     2017-02-07  890  =


-- =

0-DAY CI Kernel Test Service
https://01.org/lkp
--===============8248671224827552495==--

