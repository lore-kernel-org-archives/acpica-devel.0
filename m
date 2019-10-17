Content-Type: multipart/mixed; boundary="===============1435583378950774609=="
MIME-Version: 1.0
From: kbuild test robot <lkp at intel.com>
Subject: [Devel] [pm:bleeding-edge 50/51] include/linux/pm_qos.h:194:7: error:
 'DEV_PM_QOS_MIN_FREQUENCY' undeclared;
 did you mean 'DEV_PM_QOS_RESUME_LATENCY'?
Date: Fri, 18 Oct 2019 05:13:12 +0800
Message-ID: <201910180506.T0DNAlCi%lkp@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1435583378950774609==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
 bleeding-edge
head:   c1c487f8d64d46058ee2f4ca696eb1155a58b6f1
commit: ec4620f4aaa978842baf8ca0787fc9dc8de9c30a [50/51] PM: QoS: Drop freq=
uency QoS types from device PM QoS
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.4.0-14) 7.4.0
reproduce:
        git checkout ec4620f4aaa978842baf8ca0787fc9dc8de9c30a
        # save the attached .config to linux build tree
        make ARCH=3Di386 =


If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp(a)intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/cpufreq.h:16:0,
                    from arch/x86/kernel/tsc.c:11:
   include/linux/pm_qos.h: In function 'dev_pm_qos_read_value':
>> include/linux/pm_qos.h:194:7: error: 'DEV_PM_QOS_MIN_FREQUENCY' undeclar=
ed (first use in this function); did you mean 'DEV_PM_QOS_RESUME_LATENCY'?
     case DEV_PM_QOS_MIN_FREQUENCY:
          ^~~~~~~~~~~~~~~~~~~~~~~~
          DEV_PM_QOS_RESUME_LATENCY
   include/linux/pm_qos.h:194:7: note: each undeclared identifier is report=
ed only once for each function it appears in
>> include/linux/pm_qos.h:195:10: error: 'PM_QOS_MIN_FREQUENCY_DEFAULT_VALU=
E' undeclared (first use in this function); did you mean 'PM_QOS_RESUME_LAT=
ENCY_DEFAULT_VALUE'?
      return PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE;
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
             PM_QOS_RESUME_LATENCY_DEFAULT_VALUE
>> include/linux/pm_qos.h:196:7: error: 'DEV_PM_QOS_MAX_FREQUENCY' undeclar=
ed (first use in this function); did you mean 'DEV_PM_QOS_MIN_FREQUENCY'?
     case DEV_PM_QOS_MAX_FREQUENCY:
          ^~~~~~~~~~~~~~~~~~~~~~~~
          DEV_PM_QOS_MIN_FREQUENCY
>> include/linux/pm_qos.h:197:10: error: 'PM_QOS_MAX_FREQUENCY_DEFAULT_VALU=
E' undeclared (first use in this function); did you mean 'PM_QOS_MIN_FREQUE=
NCY_DEFAULT_VALUE'?
      return PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
             PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE

vim +194 include/linux/pm_qos.h

6dbf5cea05a709 Rafael J. Wysocki 2017-02-24  172  =

8262331eaaf751 Viresh Kumar      2019-07-04  173  static inline s32 dev_pm_=
qos_raw_resume_latency(struct device *dev)
6dbf5cea05a709 Rafael J. Wysocki 2017-02-24  174  {
6dbf5cea05a709 Rafael J. Wysocki 2017-02-24  175  	return IS_ERR_OR_NULL(de=
v->power.qos) ?
0759e80b84e34a Rafael J. Wysocki 2017-11-07  176  		PM_QOS_RESUME_LATENCY_N=
O_CONSTRAINT :
0759e80b84e34a Rafael J. Wysocki 2017-11-07  177  		pm_qos_read_value(&dev-=
>power.qos->resume_latency);
6dbf5cea05a709 Rafael J. Wysocki 2017-02-24  178  }
e8db0be1245de1 Jean Pihet        2011-08-25  179  #else
ae0fb4b72c8db7 Rafael J. Wysocki 2012-10-23  180  static inline enum pm_qos=
_flags_status __dev_pm_qos_flags(struct device *dev,
ae0fb4b72c8db7 Rafael J. Wysocki 2012-10-23  181  							  s32 mask)
ae0fb4b72c8db7 Rafael J. Wysocki 2012-10-23  182  			{ return PM_QOS_FLAGS_=
UNDEFINED; }
ae0fb4b72c8db7 Rafael J. Wysocki 2012-10-23  183  static inline enum pm_qos=
_flags_status dev_pm_qos_flags(struct device *dev,
ae0fb4b72c8db7 Rafael J. Wysocki 2012-10-23  184  							s32 mask)
ae0fb4b72c8db7 Rafael J. Wysocki 2012-10-23  185  			{ return PM_QOS_FLAGS_=
UNDEFINED; }
8262331eaaf751 Viresh Kumar      2019-07-04  186  static inline s32 __dev_p=
m_qos_resume_latency(struct device *dev)
0759e80b84e34a Rafael J. Wysocki 2017-11-07  187  			{ return PM_QOS_RESUME=
_LATENCY_NO_CONSTRAINT; }
2a79ea5ec53973 Viresh Kumar      2019-07-04  188  static inline s32 dev_pm_=
qos_read_value(struct device *dev,
2a79ea5ec53973 Viresh Kumar      2019-07-04  189  					enum dev_pm_qos_req_=
type type)
2a79ea5ec53973 Viresh Kumar      2019-07-04  190  {
2a79ea5ec53973 Viresh Kumar      2019-07-04  191  	switch (type) {
2a79ea5ec53973 Viresh Kumar      2019-07-04  192  	case DEV_PM_QOS_RESUME_L=
ATENCY:
2a79ea5ec53973 Viresh Kumar      2019-07-04  193  		return PM_QOS_RESUME_LA=
TENCY_NO_CONSTRAINT;
208637b37824c8 Viresh Kumar      2019-07-04 @194  	case DEV_PM_QOS_MIN_FREQ=
UENCY:
208637b37824c8 Viresh Kumar      2019-07-04 @195  		return PM_QOS_MIN_FREQU=
ENCY_DEFAULT_VALUE;
208637b37824c8 Viresh Kumar      2019-07-04 @196  	case DEV_PM_QOS_MAX_FREQ=
UENCY:
208637b37824c8 Viresh Kumar      2019-07-04 @197  		return PM_QOS_MAX_FREQU=
ENCY_DEFAULT_VALUE;
2a79ea5ec53973 Viresh Kumar      2019-07-04  198  	default:
2a79ea5ec53973 Viresh Kumar      2019-07-04  199  		WARN_ON(1);
2a79ea5ec53973 Viresh Kumar      2019-07-04  200  		return 0;
2a79ea5ec53973 Viresh Kumar      2019-07-04  201  	}
2a79ea5ec53973 Viresh Kumar      2019-07-04  202  }
2a79ea5ec53973 Viresh Kumar      2019-07-04  203  =


:::::: The code at line 194 was first introduced by commit
:::::: 208637b37824c8956fe28d277835a403ee35fa84 PM / QoS: Add support for M=
IN/MAX frequency constraints

:::::: TO: Viresh Kumar <viresh.kumar(a)linaro.org>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki(a)intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Cent=
er
https://lists.01.org/pipermail/kbuild-all                   Intel Corporati=
on

--===============1435583378950774609==
Content-Type: application/gzip
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config.gz"

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
5mgEVbkzdIRqp8fWCQ4UfgDhSF/VDWgAAA==
--===============1435583378950774609==--

