Content-Type: multipart/mixed; boundary="===============6971359312111580748=="
MIME-Version: 1.0
From: kbuild test robot <lkp at intel.com>
Subject: [Devel] [pm:pm-sleep-core 2/3] drivers/base/power/main.c:588:31:
 warning: initialization makes pointer from integer without a cast
Date: Sun, 05 Apr 2020 19:24:58 +0800
Message-ID: <202004051951.LR72d0pW%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6971359312111580748==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
 pm-sleep-core
head:   3aa654e1e731ad8f8aff1a937e09fae14380b6e5
commit: f31f24f5fef92e6b50dffdd2c53d2d4c4c8c2fc9 [2/3] PM: sleep: core: Fol=
d functions into their callers
config: x86_64-defconfig (attached as .config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce:
        git checkout f31f24f5fef92e6b50dffdd2c53d2d4c4c8c2fc9
        # save the attached .config to linux build tree
        make ARCH=3Dx86_64 =


If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp(a)intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/compiler_types.h:68:0,
                    from <command-line>:0:
   drivers/base/power/main.c: In function 'device_resume_noirq':
>> drivers/base/power/main.c:588:31: warning: initialization makes pointer =
from integer without a cast [-Wint-conversion]
     const char uninitialized_var(*info);
                                  ^
   include/linux/compiler-gcc.h:65:34: note: in definition of macro 'uninit=
ialized_var'
    #define uninitialized_var(x) x =3D x
                                     ^
   drivers/base/power/main.c: In function 'device_resume_early':
   drivers/base/power/main.c:779:31: warning: initialization makes pointer =
from integer without a cast [-Wint-conversion]
     const char uninitialized_var(*info);
                                  ^
   include/linux/compiler-gcc.h:65:34: note: in definition of macro 'uninit=
ialized_var'
    #define uninitialized_var(x) x =3D x
                                     ^
   drivers/base/power/main.c: In function '__device_suspend_noirq':
   drivers/base/power/main.c:1196:31: warning: initialization makes pointer=
 from integer without a cast [-Wint-conversion]
     const char uninitialized_var(*info);
                                  ^
   include/linux/compiler-gcc.h:65:34: note: in definition of macro 'uninit=
ialized_var'
    #define uninitialized_var(x) x =3D x
                                     ^
   drivers/base/power/main.c: In function '__device_suspend_late':
   drivers/base/power/main.c:1381:31: warning: initialization makes pointer=
 from integer without a cast [-Wint-conversion]
     const char uninitialized_var(*info);
                                  ^
   include/linux/compiler-gcc.h:65:34: note: in definition of macro 'uninit=
ialized_var'
    #define uninitialized_var(x) x =3D x
                                     ^
   drivers/base/power/main.c: In function 'device_resume_early':
   drivers/base/power/main.c:779:31: warning: 'info' is used uninitialized =
in this function [-Wuninitialized]
     const char uninitialized_var(*info);
                                  ^
   drivers/base/power/main.c: In function 'device_resume_noirq':
   drivers/base/power/main.c:588:31: warning: 'info' is used uninitialized =
in this function [-Wuninitialized]
     const char uninitialized_var(*info);
                                  ^
   drivers/base/power/main.c: In function '__device_suspend_noirq':
   drivers/base/power/main.c:1196:31: warning: 'info' is used uninitialized=
 in this function [-Wuninitialized]
     const char uninitialized_var(*info);
                                  ^
   drivers/base/power/main.c: In function '__device_suspend_late':
   drivers/base/power/main.c:1381:31: warning: 'info' is used uninitialized=
 in this function [-Wuninitialized]
     const char uninitialized_var(*info);
                                  ^

vim +588 drivers/base/power/main.c

   575	=

   576	/**
   577	 * device_resume_noirq - Execute a "noirq resume" callback for given=
 device.
   578	 * @dev: Device to handle.
   579	 * @state: PM transition of the system being carried out.
   580	 * @async: If true, the device is being resumed asynchronously.
   581	 *
   582	 * The driver of @dev will not receive interrupts while this functio=
n is being
   583	 * executed.
   584	 */
   585	static int device_resume_noirq(struct device *dev, pm_message_t stat=
e, bool async)
   586	{
   587		pm_callback_t callback =3D NULL;
 > 588		const char uninitialized_var(*info);
   589		bool skip_resume;
   590		int error =3D 0;
   591	=

   592		TRACE_DEVICE(dev);
   593		TRACE_RESUME(0);
   594	=

   595		if (dev->power.syscore || dev->power.direct_complete)
   596			goto Out;
   597	=

   598		if (!dev->power.is_noirq_suspended)
   599			goto Out;
   600	=

   601		if (!dpm_wait_for_superior(dev, async))
   602			goto Out;
   603	=

   604		if (dev->pm_domain) {
   605			info =3D "noirq power domain ";
   606			callback =3D pm_noirq_op(&dev->pm_domain->ops, state);
   607		} else if (dev->type && dev->type->pm) {
   608			info =3D "noirq type ";
   609			callback =3D pm_noirq_op(dev->type->pm, state);
   610		} else if (dev->class && dev->class->pm) {
   611			info =3D "noirq class ";
   612			callback =3D pm_noirq_op(dev->class->pm, state);
   613		} else if (dev->bus && dev->bus->pm) {
   614			info =3D "noirq bus ";
   615			callback =3D pm_noirq_op(dev->bus->pm, state);
   616		}
   617		if (callback) {
   618			skip_resume =3D false;
   619			goto Run;
   620		}
   621	=

   622		skip_resume =3D dev_pm_may_skip_resume(dev);
   623		if (skip_resume)
   624			goto Skip;
   625	=

   626		/*
   627		 * If "freeze" driver callbacks have been skipped during hibernatio=
n,
   628		 * because the device was runtime-suspended in __device_suspend_lat=
e(),
   629		 * the corresponding "thaw" callbacks must be skipped too, because
   630		 * running them for a runtime-suspended device may not be valid.
   631		 */
   632		if (dev_pm_smart_suspend_and_suspended(dev) &&
   633		    state.event =3D=3D PM_EVENT_THAW) {
   634			skip_resume =3D true;
   635			goto Skip;
   636		}
   637	=

   638		if (dev->driver && dev->driver->pm) {
   639			info =3D "noirq driver ";
   640			callback =3D pm_noirq_op(dev->driver->pm, state);
   641		}
   642	=

   643		/*
   644		 * The device is going to be resumed, so set its PM-runtime status =
to
   645		 * "active" (that can be done for all devices regardless of whether=
 or
   646		 * not PM-runtime is enabled for them).
   647		 */
   648		pm_runtime_set_active(dev);
   649	=

   650	Run:
   651		error =3D dpm_run_callback(callback, dev, state, info);
   652	=

   653	Skip:
   654		dev->power.is_noirq_suspended =3D false;
   655	=

   656		if (skip_resume) {
   657			/* Make the next phases of resume skip the device. */
   658			dev->power.is_late_suspended =3D false;
   659			dev->power.is_suspended =3D false;
   660			/*
   661			 * The device is going to be left in suspend, but it might not
   662			 * have been in runtime suspend before the system suspended, so
   663			 * its runtime PM status needs to be updated to avoid confusing
   664			 * the runtime PM framework when runtime PM is enabled for the
   665			 * device again.
   666			 */
   667			pm_runtime_set_suspended(dev);
   668		}
   669	=

   670	Out:
   671		complete_all(&dev->power.completion);
   672		TRACE_RESUME(error);
   673		return error;
   674	}
   675	=


---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all(a)lists.01.org

--===============6971359312111580748==
Content-Type: application/gzip
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config.gz"

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
--===============6971359312111580748==--

