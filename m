Return-Path: <rjwysocki@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 46171421DE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9BB44421D3
MIME-Version: 1.0
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-3-vincent.guittot@linaro.org>
In-Reply-To: <20231018162540.667646-3-vincent.guittot@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Message-ID: <CAJZ5v0iu9AjZWNbMPQbwErYRTz8y0PEGDyh7CU_NwxGj6KXMOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Acpica-devel] [PATCH v3 2/6] cpufreq: use the fixed and
 coherent frequency for scaling capacity
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Wed, 18 Oct 2023 17:23:26 -0000
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: juri.lelli@redhat.com, peterz@infradead.org, catalin.marinas@arm.com, robert.moore@intel.com, bsegall@google.com, conor.dooley@microchip.com, pierre.gondois@arm.com, linux-riscv@lists.infradead.org, will@kernel.org, acpica-devel@lists.linuxfoundation.org, vschneid@redhat.com, linux@armlinux.org.uk, linux-acpi@vger.kernel.org, mingo@redhat.com, mgorman@suse.de, lftan@kernel.org, viresh.kumar@linaro.org, lenb@kernel.org, aou@eecs.berkeley.edu, ionela.voinescu@arm.com, linux-pm@vger.kernel.org, rostedt@goodmis.org, paul.walmsley@sifive.com, dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, palmer@dabbelt.com, sudeep.holla@arm.com, suagrfillet@gmail.com, ajones@ventanamicro.com, bristot@redhat.com, lukasz.luba@arm.com

On Wed, Oct 18, 2023 at 6:25=E2=80=AFPM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> cpuinfo.max_freq can change at runtime because of boost as an example. Th=
is
> implies that the value could be different from the frequency that has bee=
n
> used to compute the capacity of a CPU.
>
> The new arch_scale_freq_ref() returns a fixed and coherent frequency
> that can be used to compute the capacity for a given frequency.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Tested-by: Lukasz Luba <lukasz.luba@arm.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/cpufreq/cpufreq.c | 4 ++--
>  include/linux/cpufreq.h   | 9 +++++++++
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 60ed89000e82..8c4f9c2f9c44 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -454,7 +454,7 @@ void cpufreq_freq_transition_end(struct cpufreq_polic=
y *policy,
>
>         arch_set_freq_scale(policy->related_cpus,
>                             policy->cur,
> -                           policy->cpuinfo.max_freq);
> +                           arch_scale_freq_ref(policy->cpu));
>
>         spin_lock(&policy->transition_lock);
>         policy->transition_ongoing =3D false;
> @@ -2174,7 +2174,7 @@ unsigned int cpufreq_driver_fast_switch(struct cpuf=
req_policy *policy,
>
>         policy->cur =3D freq;
>         arch_set_freq_scale(policy->related_cpus, freq,
> -                           policy->cpuinfo.max_freq);
> +                           arch_scale_freq_ref(policy->cpu));
>         cpufreq_stats_record_transition(policy, freq);
>
>         if (trace_cpu_frequency_enabled()) {
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 71d186d6933a..bbc483b4b6e5 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -1211,6 +1211,15 @@ void arch_set_freq_scale(const struct cpumask *cpu=
s,
>  {
>  }
>  #endif
> +
> +#ifndef arch_scale_freq_ref
> +static __always_inline
> +unsigned int arch_scale_freq_ref(int cpu)
> +{
> +       return 0;
> +}
> +#endif
> +
>  /* the following are really really optional */
>  extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
>  extern struct freq_attr cpufreq_freq_attr_scaling_boost_freqs;
> --
> 2.34.1
>
