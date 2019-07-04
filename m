Content-Type: multipart/mixed; boundary="===============1958348332834476520=="
MIME-Version: 1.0
From: kbuild test robot <lkp at intel.com>
Subject: [Devel] [pm:linux-next 91/102] include/linux/pm_qos.h:197:9: error:
 expected '(' before 'type'
Date: Thu, 04 Jul 2019 09:04:00 +0800
Message-ID: <201907040956.ywZASIcA%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1958348332834476520==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/rafael/lin=
ux-pm.git linux-next
head:   267eacd79cadd5e2d6307320497d66119907c411
commit: 57fa6137402b98327d1247c5aaf3d4f0595a73fe [91/102] PM / QOS: Pass re=
quest type to dev_pm_qos_read_value()
config: riscv-allnoconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 57fa6137402b98327d1247c5aaf3d4f0595a73fe
        # save the attached .config to linux build tree
        GCC_VERSION=3D7.4.0 make.cross ARCH=3Driscv =


If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp(a)intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from kernel//power/qos.c:33:0:
   include/linux/pm_qos.h: In function 'dev_pm_qos_read_value':
>> include/linux/pm_qos.h:197:9: error: expected '(' before 'type'
     switch type {
            ^~~~
   include/linux/pm_qos.h:197:9: warning: statement with no effect [-Wunuse=
d-value]
>> include/linux/pm_qos.h:204:1: warning: no return statement in function r=
eturning non-void [-Wreturn-type]
    }
    ^
   include/linux/pm_qos.h: At top level:
   include/linux/pm_qos.h:219:4: error: expected identifier or '(' before '=
{' token
       { return 0; }
       ^
   include/linux/pm_qos.h:216:19: warning: 'dev_pm_qos_add_notifier' declar=
ed 'static' but never defined [-Wunused-function]
    static inline int dev_pm_qos_add_notifier(struct device *dev,
                      ^~~~~~~~~~~~~~~~~~~~~~~

vim +197 include/linux/pm_qos.h

   178	=

   179	static inline s32 dev_pm_qos_raw_resume_latency(struct device *dev)
   180	{
   181		return IS_ERR_OR_NULL(dev->power.qos) ?
   182			PM_QOS_RESUME_LATENCY_NO_CONSTRAINT :
   183			pm_qos_read_value(&dev->power.qos->resume_latency);
   184	}
   185	#else
   186	static inline enum pm_qos_flags_status __dev_pm_qos_flags(struct dev=
ice *dev,
   187								  s32 mask)
   188				{ return PM_QOS_FLAGS_UNDEFINED; }
   189	static inline enum pm_qos_flags_status dev_pm_qos_flags(struct devic=
e *dev,
   190								s32 mask)
   191				{ return PM_QOS_FLAGS_UNDEFINED; }
   192	static inline s32 __dev_pm_qos_resume_latency(struct device *dev)
   193				{ return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT; }
   194	static inline s32 dev_pm_qos_read_value(struct device *dev,
   195						enum dev_pm_qos_req_type type)
   196	{
 > 197		switch type {
   198		case DEV_PM_QOS_RESUME_LATENCY:
   199			return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
   200		default:
   201			WARN_ON(1);
   202			return 0;
   203		}
 > 204	}
   205	=


---
0-DAY kernel test infrastructure                Open Source Technology Cent=
er
https://lists.01.org/pipermail/kbuild-all                   Intel Corporati=
on

--===============1958348332834476520==
Content-Type: application/gzip
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config.gz"

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
--===============1958348332834476520==--

