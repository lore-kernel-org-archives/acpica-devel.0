Content-Type: multipart/mixed; boundary="===============6337221363539746399=="
MIME-Version: 1.0
From: Jeremy Linton <jeremy.linton at arm.com>
Subject: [Devel] Re: [PATCH v5 1/1] ACPI: CPPC: Disable FIE if registers in
 PCC regions
Date: Thu, 22 Sep 2022 17:07:11 -0500
Message-ID: <6936c836-03e7-ea15-e7ed-2a213458f872@arm.com>
In-Reply-To: 20220912203722.205185-2-jeremy.linton@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6337221363539746399==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Raphael,

Ping, are we good here?

Thanks,


On 9/12/22 15:37, Jeremy Linton wrote:
> PCC regions utilize a mailbox to set/retrieve register values used by
> the CPPC code. This is fine as long as the operations are
> infrequent. With the FIE code enabled though the overhead can range
> from 2-11% of system CPU overhead (ex: as measured by top) on Arm
> based machines.
> =

> So, before enabling FIE assure none of the registers used by
> cppc_get_perf_ctrs() are in the PCC region. Finally, add a module
> parameter which can override the PCC region detection at boot or
> module reload.
> =

> Signed-off-by: Jeremy Linton <jeremy.linton(a)arm.com>
> Acked-by: Viresh Kumar <viresh.kumar(a)linaro.org>
> ---
>   drivers/acpi/cppc_acpi.c       | 42 ++++++++++++++++++++++++++++++++++
>   drivers/cpufreq/cppc_cpufreq.c | 25 ++++++++++++++++----
>   include/acpi/cppc_acpi.h       |  5 ++++
>   3 files changed, 68 insertions(+), 4 deletions(-)
> =

> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 1e15a9f25ae9..55693e6f7153 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1240,6 +1240,48 @@ int cppc_get_perf_caps(int cpunum, struct cppc_per=
f_caps *perf_caps)
>   }
>   EXPORT_SYMBOL_GPL(cppc_get_perf_caps);
>   =

> +/**
> + * cppc_perf_ctrs_in_pcc - Check if any perf counters are in a PCC regio=
n.
> + *
> + * CPPC has flexibility about how CPU performance counters are accessed.
> + * One of the choices is PCC regions, which can have a high access laten=
cy. This
> + * routine allows callers of cppc_get_perf_ctrs() to know this ahead of =
time.
> + *
> + * Return: true if any of the counters are in PCC regions, false otherwi=
se
> + */
> +bool cppc_perf_ctrs_in_pcc(void)
> +{
> +	int cpu;
> +
> +	for_each_present_cpu(cpu) {
> +		struct cpc_register_resource *ref_perf_reg;
> +		struct cpc_desc *cpc_desc;
> +
> +		cpc_desc =3D per_cpu(cpc_desc_ptr, cpu);
> +
> +		if (CPC_IN_PCC(&cpc_desc->cpc_regs[DELIVERED_CTR]) ||
> +		    CPC_IN_PCC(&cpc_desc->cpc_regs[REFERENCE_CTR]) ||
> +		    CPC_IN_PCC(&cpc_desc->cpc_regs[CTR_WRAP_TIME]))
> +			return true;
> +
> +
> +		ref_perf_reg =3D &cpc_desc->cpc_regs[REFERENCE_PERF];
> +
> +		/*
> +		 * If reference perf register is not supported then we should
> +		 * use the nominal perf value
> +		 */
> +		if (!CPC_SUPPORTED(ref_perf_reg))
> +			ref_perf_reg =3D &cpc_desc->cpc_regs[NOMINAL_PERF];
> +
> +		if (CPC_IN_PCC(ref_perf_reg))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc);
> +
>   /**
>    * cppc_get_perf_ctrs - Read a CPU's performance feedback counters.
>    * @cpunum: CPU from which to read counters.
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufre=
q.c
> index 24eaf0ec344d..9e2a48ac5830 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -63,7 +63,15 @@ static struct cppc_workaround_oem_info wa_info[] =3D {
>   =

>   static struct cpufreq_driver cppc_cpufreq_driver;
>   =

> +static enum {
> +	FIE_UNSET =3D -1,
> +	FIE_ENABLED,
> +	FIE_DISABLED
> +} fie_disabled =3D FIE_UNSET;
> +
>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
> +module_param(fie_disabled, int, 0444);
> +MODULE_PARM_DESC(fie_disabled, "Disable Frequency Invariance Engine (FIE=
)");
>   =

>   /* Frequency invariance support */
>   struct cppc_freq_invariance {
> @@ -158,7 +166,7 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_=
policy *policy)
>   	struct cppc_freq_invariance *cppc_fi;
>   	int cpu, ret;
>   =

> -	if (cppc_cpufreq_driver.get =3D=3D hisi_cppc_cpufreq_get_rate)
> +	if (fie_disabled)
>   		return;
>   =

>   	for_each_cpu(cpu, policy->cpus) {
> @@ -199,7 +207,7 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_=
policy *policy)
>   	struct cppc_freq_invariance *cppc_fi;
>   	int cpu;
>   =

> -	if (cppc_cpufreq_driver.get =3D=3D hisi_cppc_cpufreq_get_rate)
> +	if (fie_disabled)
>   		return;
>   =

>   	/* policy->cpus will be empty here, use related_cpus instead */
> @@ -229,7 +237,15 @@ static void __init cppc_freq_invariance_init(void)
>   	};
>   	int ret;
>   =

> -	if (cppc_cpufreq_driver.get =3D=3D hisi_cppc_cpufreq_get_rate)
> +	if (fie_disabled !=3D FIE_ENABLED && fie_disabled !=3D FIE_DISABLED) {
> +		fie_disabled =3D FIE_ENABLED;
> +		if (cppc_perf_ctrs_in_pcc()) {
> +			pr_info("FIE not enabled on systems with registers in PCC\n");
> +			fie_disabled =3D FIE_DISABLED;
> +		}
> +	}
> +
> +	if (fie_disabled)
>   		return;
>   =

>   	kworker_fie =3D kthread_create_worker(0, "cppc_fie");
> @@ -247,7 +263,7 @@ static void __init cppc_freq_invariance_init(void)
>   =

>   static void cppc_freq_invariance_exit(void)
>   {
> -	if (cppc_cpufreq_driver.get =3D=3D hisi_cppc_cpufreq_get_rate)
> +	if (fie_disabled)
>   		return;
>   =

>   	kthread_destroy_worker(kworker_fie);
> @@ -936,6 +952,7 @@ static void cppc_check_hisi_workaround(void)
>   		    wa_info[i].oem_revision =3D=3D tbl->oem_revision) {
>   			/* Overwrite the get() callback */
>   			cppc_cpufreq_driver.get =3D hisi_cppc_cpufreq_get_rate;
> +			fie_disabled =3D FIE_DISABLED;
>   			break;
>   		}
>   	}
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index f73d357ecdf5..c5614444031f 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -140,6 +140,7 @@ extern int cppc_get_perf_ctrs(int cpu, struct cppc_pe=
rf_fb_ctrs *perf_fb_ctrs);
>   extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
>   extern int cppc_set_enable(int cpu, bool enable);
>   extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
> +extern bool cppc_perf_ctrs_in_pcc(void);
>   extern bool acpi_cpc_valid(void);
>   extern bool cppc_allow_fast_switch(void);
>   extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_=
data);
> @@ -173,6 +174,10 @@ static inline int cppc_get_perf_caps(int cpu, struct=
 cppc_perf_caps *caps)
>   {
>   	return -ENOTSUPP;
>   }
> +static inline bool cppc_perf_ctrs_in_pcc(void)
> +{
> +	return false;
> +}
>   static inline bool acpi_cpc_valid(void)
>   {
>   	return false;

--===============6337221363539746399==--

