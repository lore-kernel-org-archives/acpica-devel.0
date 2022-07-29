Content-Type: multipart/mixed; boundary="===============1205439302791111137=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
Subject: [Devel] Re: [PATCH] ACPI: CPPC: Disable FIE if registers in PCC
 regions
Date: Fri, 29 Jul 2022 10:55:12 +0800
Message-ID: <202207291003.Wk3c06eH-lkp@intel.com>
In-Reply-To: 20220726145948.2194684-1-jeremy.linton@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1205439302791111137==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeremy,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on linus/master v5.19-rc8 next-20220728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeremy-Linton/ACPI-C=
PPC-Disable-FIE-if-registers-in-PCC-regions/20220726-230217
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
 linux-next
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/202=
20729/202207291003.Wk3c06eH-lkp(a)intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=3D1 build):
        # https://github.com/intel-lab-lkp/linux/commit/a4dd80cfc857eef429f=
60e999bdc9479179d495e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jeremy-Linton/ACPI-CPPC-Disable-FI=
E-if-registers-in-PCC-regions/20220726-230217
        git checkout a4dd80cfc857eef429f60e999bdc9479179d495e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=3D1 O=3Dbuild_dir ARCH=3Dx86_64 SHELL=3D/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp(a)intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from drivers/cpufreq/acpi-cpufreq.c:29:
>> include/acpi/cppc_acpi.h:177:12: warning: no previous prototype for 'cpp=
c_perf_ctrs_in_pcc' [-Wmissing-prototypes]
     177 | extern int cppc_perf_ctrs_in_pcc(void)
         |            ^~~~~~~~~~~~~~~~~~~~~
--
   ld: drivers/cpufreq/intel_pstate.o: in function `cppc_perf_ctrs_in_pcc':
>> include/acpi/cppc_acpi.h:178: multiple definition of `cppc_perf_ctrs_in_=
pcc'; drivers/cpufreq/acpi-cpufreq.o:include/acpi/cppc_acpi.h:178: first de=
fined here


vim +178 include/acpi/cppc_acpi.h

   135	=

   136	#ifdef CONFIG_ACPI_CPPC_LIB
   137	extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
   138	extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
   139	extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *per=
f_fb_ctrs);
   140	extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls=
);
   141	extern int cppc_set_enable(int cpu, bool enable);
   142	extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
   143	extern int cppc_perf_ctrs_in_pcc(void);
   144	extern bool acpi_cpc_valid(void);
   145	extern bool cppc_allow_fast_switch(void);
   146	extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *c=
pu_data);
   147	extern unsigned int cppc_get_transition_latency(int cpu);
   148	extern bool cpc_ffh_supported(void);
   149	extern bool cpc_supported_by_cpu(void);
   150	extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
   151	extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
   152	#else /* !CONFIG_ACPI_CPPC_LIB */
   153	static inline int cppc_get_desired_perf(int cpunum, u64 *desired_per=
f)
   154	{
   155		return -ENOTSUPP;
   156	}
   157	static inline int cppc_get_nominal_perf(int cpunum, u64 *nominal_per=
f)
   158	{
   159		return -ENOTSUPP;
   160	}
   161	static inline int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ct=
rs *perf_fb_ctrs)
   162	{
   163		return -ENOTSUPP;
   164	}
   165	static inline int cppc_set_perf(int cpu, struct cppc_perf_ctrls *per=
f_ctrls)
   166	{
   167		return -ENOTSUPP;
   168	}
   169	static inline int cppc_set_enable(int cpu, bool enable)
   170	{
   171		return -ENOTSUPP;
   172	}
   173	static inline int cppc_get_perf_caps(int cpu, struct cppc_perf_caps =
*caps)
   174	{
   175		return -ENOTSUPP;
   176	}
 > 177	extern int cppc_perf_ctrs_in_pcc(void)
 > 178	{
   179		return false;
   180	}
   181	static inline bool acpi_cpc_valid(void)
   182	{
   183		return false;
   184	}
   185	static inline bool cppc_allow_fast_switch(void)
   186	{
   187		return false;
   188	}
   189	static inline unsigned int cppc_get_transition_latency(int cpu)
   190	{
   191		return CPUFREQ_ETERNAL;
   192	}
   193	static inline bool cpc_ffh_supported(void)
   194	{
   195		return false;
   196	}
   197	static inline int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 =
*val)
   198	{
   199		return -ENOTSUPP;
   200	}
   201	static inline int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64=
 val)
   202	{
   203		return -ENOTSUPP;
   204	}
   205	#endif /* !CONFIG_ACPI_CPPC_LIB */
   206	=


-- =

0-DAY CI Kernel Test Service
https://01.org/lkp
--===============1205439302791111137==--

