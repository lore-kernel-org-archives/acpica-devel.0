Content-Type: multipart/mixed; boundary="===============1002955503992647771=="
MIME-Version: 1.0
From: kbuild test robot <lkp at intel.com>
Subject: [Devel] [pm:pm-sleep-core 3/7] drivers/base/power/main.c:646:3:
 error: label 'skip' used but not defined
Date: Thu, 09 Apr 2020 03:42:09 +0800
Message-ID: <202004090306.RzFIVdGL%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1002955503992647771==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
 pm-sleep-core
head:   a10300155e14f5644294172cfda77106ee71e236
commit: c56010827abbc0b471d4af29f2e7d45c661ae1b3 [3/7] PM: sleep: core: Do =
not skip callbacks in the resume phase
config: nds32-defconfig (attached as .config)
compiler: nds32le-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout c56010827abbc0b471d4af29f2e7d45c661ae1b3
        # save the attached .config to linux build tree
        GCC_VERSION=3D9.3.0 make.cross ARCH=3Dnds32 =


If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp(a)intel.com>

All errors (new ones prefixed by >>):

   drivers/base/power/main.c: In function 'device_resume_noirq':
   drivers/base/power/main.c:656:1: warning: label 'Skip' defined but not u=
sed [-Wunused-label]
     656 | Skip:
         | ^~~~
>> drivers/base/power/main.c:646:3: error: label 'skip' used but not defined
     646 |   goto skip;
         |   ^~~~

vim +/skip +646 drivers/base/power/main.c

   584	=

   585	/**
   586	 * device_resume_noirq - Execute a "noirq resume" callback for given=
 device.
   587	 * @dev: Device to handle.
   588	 * @state: PM transition of the system being carried out.
   589	 * @async: If true, the device is being resumed asynchronously.
   590	 *
   591	 * The driver of @dev will not receive interrupts while this functio=
n is being
   592	 * executed.
   593	 */
   594	static int device_resume_noirq(struct device *dev, pm_message_t stat=
e, bool async)
   595	{
   596		pm_callback_t callback =3D NULL;
   597		const char *info =3D NULL;
   598		bool skip_resume;
   599		int error =3D 0;
   600	=

   601		TRACE_DEVICE(dev);
   602		TRACE_RESUME(0);
   603	=

   604		if (dev->power.syscore || dev->power.direct_complete)
   605			goto Out;
   606	=

   607		if (!dev->power.is_noirq_suspended)
   608			goto Out;
   609	=

   610		if (!dpm_wait_for_superior(dev, async))
   611			goto Out;
   612	=

   613		skip_resume =3D dev_pm_may_skip_resume(dev);
   614		/*
   615		 * If the driver callback is skipped below or by the middle layer
   616		 * callback and device_resume_early() also skips the driver callbac=
k for
   617		 * this device later, it needs to appear as "suspended" to PM-runti=
me,
   618		 * so change its status accordingly.
   619		 *
   620		 * Otherwise, the device is going to be resumed, so set its PM-runt=
ime
   621		 * status to "active", but do that only if DPM_FLAG_SMART_SUSPEND i=
s set
   622		 * to avoid confusing drivers that don't use it.
   623		 */
   624		if (skip_resume)
   625			pm_runtime_set_suspended(dev);
   626		else if (dev_pm_smart_suspend_and_suspended(dev))
   627			pm_runtime_set_active(dev);
   628	=

   629		if (dev->pm_domain) {
   630			info =3D "noirq power domain ";
   631			callback =3D pm_noirq_op(&dev->pm_domain->ops, state);
   632		} else if (dev->type && dev->type->pm) {
   633			info =3D "noirq type ";
   634			callback =3D pm_noirq_op(dev->type->pm, state);
   635		} else if (dev->class && dev->class->pm) {
   636			info =3D "noirq class ";
   637			callback =3D pm_noirq_op(dev->class->pm, state);
   638		} else if (dev->bus && dev->bus->pm) {
   639			info =3D "noirq bus ";
   640			callback =3D pm_noirq_op(dev->bus->pm, state);
   641		}
   642		if (callback)
   643			goto Run;
   644	=

   645		if (skip_resume)
 > 646			goto skip;
   647	=

   648		if (dev->driver && dev->driver->pm) {
   649			info =3D "noirq driver ";
   650			callback =3D pm_noirq_op(dev->driver->pm, state);
   651		}
   652	=

   653	Run:
   654		error =3D dpm_run_callback(callback, dev, state, info);
   655	=

   656	Skip:
   657		dev->power.is_noirq_suspended =3D false;
   658	=

   659	Out:
   660		complete_all(&dev->power.completion);
   661		TRACE_RESUME(error);
   662		return error;
   663	}
   664	=


---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org

--===============1002955503992647771==
Content-Type: application/gzip
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config.gz"

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
--===============1002955503992647771==--

