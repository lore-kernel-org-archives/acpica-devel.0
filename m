Content-Type: multipart/mixed; boundary="===============4570291762630357767=="
MIME-Version: 1.0
From: Rafael J. Wysocki <rafael at kernel.org>
Subject: [Devel] Re: [PATCH] ACPI: CPPC: Disable FIE if registers in PCC
 regions
Date: Tue, 26 Jul 2022 20:31:10 +0200
Message-ID: <CAJZ5v0i-bCi0=FN=rMWCWCyKYQ6-upOhXteu9p6xAaf5=m93+w@mail.gmail.com>
In-Reply-To: 20220726145948.2194684-1-jeremy.linton@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4570291762630357767==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 26, 2022 at 5:00 PM Jeremy Linton <jeremy.linton(a)arm.com> wro=
te:
>
> PCC regions utilize a mailbox to set/retrieve register values used by
> the CPPC code. This is fine as long as the operations are
> infrequent. With the FIE code enabled though the overhead can range
> from 2-11% of system CPU overhead (ex: as measured by top) on Arm
> based machines.
>
> So, before enabling FIE assure none of the registers used by
> cppc_get_perf_ctrs() are in the PCC region. Furthermore lets also
> enable a module parameter which can also disable it at boot or module
> reload.
>
> Signed-off-by: Jeremy Linton <jeremy.linton(a)arm.com>
> ---
>  drivers/acpi/cppc_acpi.c       | 31 +++++++++++++++++++++++++++++++
>  drivers/cpufreq/cppc_cpufreq.c | 19 +++++++++++++++----
>  include/acpi/cppc_acpi.h       |  5 +++++
>  3 files changed, 51 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 3c6d4ef87be0..ad84c55b6409 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1246,6 +1246,37 @@ int cppc_get_perf_caps(int cpunum, struct cppc_per=
f_caps *perf_caps)
>  }
>  EXPORT_SYMBOL_GPL(cppc_get_perf_caps);
>

A kerneldoc, please.

> +int cppc_perf_ctrs_in_pcc(void)

Why int and not bool?

> +{
> +       int cpu;
> +       struct cpc_desc *cpc_desc;
> +       struct cpc_register_resource *delivered_reg, *reference_reg,
> +               *ref_perf_reg, *ctr_wrap_reg;

No line wraps here, please and follow the reverse xmas tree convention.

> +
> +       for_each_present_cpu(cpu) {

Declare the variables only used in this loop here and you only need two.

> +               cpc_desc =3D per_cpu(cpc_desc_ptr, cpu);
> +               delivered_reg =3D &cpc_desc->cpc_regs[DELIVERED_CTR];
> +               reference_reg =3D &cpc_desc->cpc_regs[REFERENCE_CTR];
> +               ref_perf_reg =3D &cpc_desc->cpc_regs[REFERENCE_PERF];
> +               ctr_wrap_reg =3D &cpc_desc->cpc_regs[CTR_WRAP_TIME];

I would do

if (CPC_IN_PCC(&cpc_desc->cpc_regs[DELIVERED_CTR]) ||
    CPC_IN_PCC(&cpc_desc->cpc_regs[REFERENCE_CTR]) ||
    CPC_IN_PCC(&cpc_desc->cpc_regs[CTR_WRAP_TIME]))
        return true;

ref_perf_reg =3D &cpc_desc->cpc_regs[REFERENCE_PERF];
if (!CPC_SUPPORTED(ref_perf_reg))
    ref_perf_reg =3D &cpc_desc->cpc_regs[NOMINAL_PERF];

if (CPC_IN_PCC(ref_perf_reg))
    return true;

> +
> +               /*
> +                * If reference perf register is not supported then we sh=
ould
> +                * use the nominal perf value
> +                */
> +               if (!CPC_SUPPORTED(ref_perf_reg))
> +                       ref_perf_reg =3D &cpc_desc->cpc_regs[NOMINAL_PERF=
];
> +
> +               /* Are any of the regs PCC ?*/
> +               if (CPC_IN_PCC(delivered_reg) || CPC_IN_PCC(reference_reg=
) ||
> +                       CPC_IN_PCC(ctr_wrap_reg) || CPC_IN_PCC(ref_perf_r=
eg)) {
> +                       return true;
> +               }
> +       }
> +       return false;
> +}
> +EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc);
> +
>  /**
>   * cppc_get_perf_ctrs - Read a CPU's performance feedback counters.
>   * @cpunum: CPU from which to read counters.
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufre=
q.c
> index 24eaf0ec344d..a66d3013d0f8 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -63,6 +63,10 @@ static struct cppc_workaround_oem_info wa_info[] =3D {
>
>  static struct cpufreq_driver cppc_cpufreq_driver;
>
> +static bool fie_disabled;
> +module_param(fie_disabled, bool, 0444);
> +MODULE_PARM_DESC(fie_disabled, "Disable Frequency Invariance Engine (FIE=
)");
> +
>  #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>
>  /* Frequency invariance support */
> @@ -158,7 +162,7 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_=
policy *policy)
>         struct cppc_freq_invariance *cppc_fi;
>         int cpu, ret;
>
> -       if (cppc_cpufreq_driver.get =3D=3D hisi_cppc_cpufreq_get_rate)
> +       if (fie_disabled)
>                 return;
>
>         for_each_cpu(cpu, policy->cpus) {
> @@ -199,7 +203,7 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_=
policy *policy)
>         struct cppc_freq_invariance *cppc_fi;
>         int cpu;
>
> -       if (cppc_cpufreq_driver.get =3D=3D hisi_cppc_cpufreq_get_rate)
> +       if (fie_disabled)
>                 return;
>
>         /* policy->cpus will be empty here, use related_cpus instead */
> @@ -229,7 +233,12 @@ static void __init cppc_freq_invariance_init(void)
>         };
>         int ret;
>
> -       if (cppc_cpufreq_driver.get =3D=3D hisi_cppc_cpufreq_get_rate)
> +       if (cppc_perf_ctrs_in_pcc()) {
> +               pr_debug("FIE not enabled on systems with registers in PC=
C\n");
> +               fie_disabled =3D true;
> +       }
> +
> +       if (fie_disabled)
>                 return;
>
>         kworker_fie =3D kthread_create_worker(0, "cppc_fie");
> @@ -247,7 +256,7 @@ static void __init cppc_freq_invariance_init(void)
>
>  static void cppc_freq_invariance_exit(void)
>  {
> -       if (cppc_cpufreq_driver.get =3D=3D hisi_cppc_cpufreq_get_rate)
> +       if (fie_disabled)
>                 return;
>
>         kthread_destroy_worker(kworker_fie);
> @@ -940,6 +949,8 @@ static void cppc_check_hisi_workaround(void)
>                 }
>         }
>
> +       fie_disabled =3D true;
> +
>         acpi_put_table(tbl);
>  }
>
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index d389bab54241..f4ff571fcdcb 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -140,6 +140,7 @@ extern int cppc_get_perf_ctrs(int cpu, struct cppc_pe=
rf_fb_ctrs *perf_fb_ctrs);
>  extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
>  extern int cppc_set_enable(int cpu, bool enable);
>  extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
> +extern int cppc_perf_ctrs_in_pcc(void);
>  extern bool acpi_cpc_valid(void);
>  extern bool cppc_allow_fast_switch(void);
>  extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_d=
ata);
> @@ -173,6 +174,10 @@ static inline int cppc_get_perf_caps(int cpu, struct=
 cppc_perf_caps *caps)
>  {
>         return -ENOTSUPP;
>  }
> +extern int cppc_perf_ctrs_in_pcc(void)
> +{
> +       return false;
> +}
>  static inline bool acpi_cpc_valid(void)
>  {
>         return false;
> --
--===============4570291762630357767==--

