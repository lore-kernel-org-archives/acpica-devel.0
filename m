Content-Type: multipart/mixed; boundary="===============1644472214814560350=="
MIME-Version: 1.0
From: Jeremy Linton <jeremy.linton at arm.com>
Subject: [Devel] Re: [PATCH v3 1/2] ACPI: CPPC: Disable FIE if registers in
 PCC regions
Date: Wed, 24 Aug 2022 11:11:09 -0500
Message-ID: <2cfad670-9b3a-38c4-4d0f-45173da35d95@arm.com>
In-Reply-To: 59f3ba6f-b657-2da2-cb2a-9736e1488908@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1644472214814560350==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 8/24/22 09:41, Lukasz Luba wrote:
> Hi Jeremy,
> =

> +CC Dietmar, Morten and Souvik
> =

> On 8/18/22 22:16, Jeremy Linton wrote:
>> PCC regions utilize a mailbox to set/retrieve register values used by
>> the CPPC code. This is fine as long as the operations are
>> infrequent. With the FIE code enabled though the overhead can range
>> from 2-11% of system CPU overhead (ex: as measured by top) on Arm
>> based machines.
>>
>> So, before enabling FIE assure none of the registers used by
>> cppc_get_perf_ctrs() are in the PCC region. Furthermore lets also
>> enable a module parameter which can also disable it at boot or module
>> reload.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton(a)arm.com>
>> ---
>> =C2=A0 drivers/acpi/cppc_acpi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 41=
 ++++++++++++++++++++++++++++++++++
>> =C2=A0 drivers/cpufreq/cppc_cpufreq.c | 31 +++++++++++++++++++++----
>> =C2=A0 include/acpi/cppc_acpi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 5 +++++
>> =C2=A0 3 files changed, 73 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 1e15a9f25ae9..c840bf606b30 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1240,6 +1240,47 @@ int cppc_get_perf_caps(int cpunum, struct =

>> cppc_perf_caps *perf_caps)
>> =C2=A0 }
>> =C2=A0 EXPORT_SYMBOL_GPL(cppc_get_perf_caps);
>> +/**
>> + * cppc_perf_ctrs_in_pcc - Check if any perf counters are in a PCC =

>> region.
>> + *
>> + * CPPC has flexibility about how counters describing CPU perf are =

>> delivered.
>> + * One of the choices is PCC regions, which can have a high access =

>> latency. This
>> + * routine allows callers of cppc_get_perf_ctrs() to know this ahead =

>> of time.
>> + *
>> + * Return: true if any of the counters are in PCC regions, false =

>> otherwise
>> + */
>> +bool cppc_perf_ctrs_in_pcc(void)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int cpu;
>> +
>> +=C2=A0=C2=A0=C2=A0 for_each_present_cpu(cpu) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cpc_register_resource=
 *ref_perf_reg;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cpc_desc *cpc_desc;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpc_desc =3D per_cpu(cpc_des=
c_ptr, cpu);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (CPC_IN_PCC(&cpc_desc->cp=
c_regs[DELIVERED_CTR]) ||
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPC_=
IN_PCC(&cpc_desc->cpc_regs[REFERENCE_CTR]) ||
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPC_=
IN_PCC(&cpc_desc->cpc_regs[CTR_WRAP_TIME]))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn true;
>> +
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ref_perf_reg =3D &cpc_desc->=
cpc_regs[REFERENCE_PERF];
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If reference perf re=
gister is not supported then we should
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * use the nominal perf=
 value
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!CPC_SUPPORTED(ref_perf_=
reg))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ref_=
perf_reg =3D &cpc_desc->cpc_regs[NOMINAL_PERF];
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (CPC_IN_PCC(ref_perf_reg))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn true;
>> +=C2=A0=C2=A0=C2=A0 }
> =

> Do we have a platform which returns false here?

I'm not aware of one, but I don't have access to every bit of HW either.


> =

>> +=C2=A0=C2=A0=C2=A0 return false;
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc);
>> +
>> =C2=A0 /**
>> =C2=A0=C2=A0 * cppc_get_perf_ctrs - Read a CPU's performance feedback co=
unters.
>> =C2=A0=C2=A0 * @cpunum: CPU from which to read counters.
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c =

>> b/drivers/cpufreq/cppc_cpufreq.c
>> index 24eaf0ec344d..32fcb0bf74a4 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -63,7 +63,15 @@ static struct cppc_workaround_oem_info wa_info[] =3D {
>> =C2=A0 static struct cpufreq_driver cppc_cpufreq_driver;
>> +static enum {
>> +=C2=A0=C2=A0=C2=A0 FIE_UNSET =3D -1,
>> +=C2=A0=C2=A0=C2=A0 FIE_ENABLED,
>> +=C2=A0=C2=A0=C2=A0 FIE_DISABLED
>> +} fie_disabled =3D FIE_UNSET;
>> +
>> =C2=A0 #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>> +module_param(fie_disabled, int, 0444);
>> +MODULE_PARM_DESC(fie_disabled, "Disable Frequency Invariance Engine =

>> (FIE)");
> =

> Why we need the modules support?
> I would drop this, since the fie_disabled would be set properly when
> needed. The code would be cleaner (more below).

Well the original version was simpler, but I tend to agree with Ionela =

who proposed this version in a previous review. The module param at this =

point is a debugging/testing statment since it allows the user to force =

FIE on or off independent of the PCC decision. Until we have a clear =

statment about how/when/where this feature is useful, having the ability =

to make the choice dynamically at runtime is quite useful and less =

intrusive than having multiple kernels/modules on the machine with the =

config option flipped, and requiring a reboot.

> =

>> =C2=A0 /* Frequency invariance support */
>> =C2=A0 struct cppc_freq_invariance {
>> @@ -158,7 +166,7 @@ static void cppc_cpufreq_cpu_fie_init(struct =

>> cpufreq_policy *policy)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cppc_freq_invariance *cppc_fi;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int cpu, ret;
>> -=C2=A0=C2=A0=C2=A0 if (cppc_cpufreq_driver.get =3D=3D hisi_cppc_cpufreq=
_get_rate)
>> +=C2=A0=C2=A0=C2=A0 if (fie_disabled)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for_each_cpu(cpu, policy->cpus) {
>> @@ -199,7 +207,7 @@ static void cppc_cpufreq_cpu_fie_exit(struct =

>> cpufreq_policy *policy)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cppc_freq_invariance *cppc_fi;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int cpu;
>> -=C2=A0=C2=A0=C2=A0 if (cppc_cpufreq_driver.get =3D=3D hisi_cppc_cpufreq=
_get_rate)
>> +=C2=A0=C2=A0=C2=A0 if (fie_disabled)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* policy->cpus will be empty here, use r=
elated_cpus instead */
>> @@ -229,7 +237,21 @@ static void __init cppc_freq_invariance_init(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>> -=C2=A0=C2=A0=C2=A0 if (cppc_cpufreq_driver.get =3D=3D hisi_cppc_cpufreq=
_get_rate)
>> +=C2=A0=C2=A0=C2=A0 switch (fie_disabled) {
>> +=C2=A0=C2=A0=C2=A0 /* honor user request */
>> +=C2=A0=C2=A0=C2=A0 case FIE_DISABLED:
>> +=C2=A0=C2=A0=C2=A0 case FIE_ENABLED:
> =

> This module's over-write doesn't look 'clean'.
> Is it OK to allow a user to go with the poor performing
> system (likely on many platforms)? Or we assume that there are
> platforms which has a bit faster mailboxes and they already
> have the FIE issue impacting task's utilization measurements.

I think with this patch applied we aren't any worse than before, but =

that is based on the fact that I've not seen a machine that has actual =

CPPC hardware registers (rather than mailboxes).

So I think your suggesting that we will then have to revisit the code =

(to maybe avoid all the cppc_fie task/etc overhead) if a machine appears =

with hardware registers. And I tend to sorta agree, but that is what the =

second patch is for :) which will likely be what most distro's end up =

applying on generic kernels.

> =

> It looks like we are not sure about the solution. On one hand
> we implement those checks in the cppc_perf_ctrs_in_pcc()
> which could set the flag, but on the other hand we allow user
> to decide. IMO this creates diversity that we are not able to control.
> It creates another tunable knob in the kernel, which then is forgotten
> to check.

Your average user will never turn this knob, and if they do, its likely =

to solve a problem, or test for performace. The fact that we aren't 100% =

sure of where/when this feature is useful is the argument for making it =

a tunable.


> =

> I still haven't seen information that the old FIE was an issue on those
> servers and had impact on task utilization measurements. This should be
> a main requirement for this new feature. This would be after we proved
> that the utilization problem was due to the FIE and not something else =

> (like uArch variation or workload variation).
> =

> IMO let's revert the ACPI_CPPC_CPUFREQ_FIE. When we get data that
> FIE is an issue on those servers we can come back to this topic.

I don't really have an opinion about this, maybe someone else can =

comment :)

Although, with both of these patches applied we can kick the decision =

down the road and revisit it in a couple years, and maybe have a clearer =

view.




--===============1644472214814560350==--

