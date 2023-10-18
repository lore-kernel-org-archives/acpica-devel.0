Return-Path: <rjwysocki@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB04582CDE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EF2FA82CA5
MIME-Version: 1.0
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-4-vincent.guittot@linaro.org>
In-Reply-To: <20231018162540.667646-4-vincent.guittot@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Message-ID: <CAJZ5v0i58HLmgp=JYCbq5B6LUe0tEAhd9Ed9WKqkkHjVEO_W6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Acpica-devel] [PATCH v3 3/6] cpufreq/schedutil: use a fixed
	reference frequency
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Wed, 18 Oct 2023 17:22:53 -0000
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: juri.lelli@redhat.com, peterz@infradead.org, catalin.marinas@arm.com, robert.moore@intel.com, bsegall@google.com, conor.dooley@microchip.com, pierre.gondois@arm.com, linux-riscv@lists.infradead.org, will@kernel.org, acpica-devel@lists.linuxfoundation.org, vschneid@redhat.com, linux@armlinux.org.uk, linux-acpi@vger.kernel.org, mingo@redhat.com, mgorman@suse.de, lftan@kernel.org, viresh.kumar@linaro.org, lenb@kernel.org, aou@eecs.berkeley.edu, ionela.voinescu@arm.com, linux-pm@vger.kernel.org, rostedt@goodmis.org, paul.walmsley@sifive.com, dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, palmer@dabbelt.com, sudeep.holla@arm.com, suagrfillet@gmail.com, ajones@ventanamicro.com, bristot@redhat.com, lukasz.luba@arm.com

On Wed, Oct 18, 2023 at 6:25=E2=80=AFPM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> cpuinfo.max_freq can change at runtime because of boost as an example. Th=
is
> implies that the value could be different than the one that has been
> used when computing the capacity of a CPU.
>
> The new arch_scale_freq_ref() returns a fixed and coherent reference
> frequency that can be used when computing a frequency based on utilizatio=
n.
>
> Use this arch_scale_freq_ref() when available and fallback to
> policy otherwise.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Tested-by: Lukasz Luba <lukasz.luba@arm.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

>
> ---
>  kernel/sched/cpufreq_schedutil.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sche=
dutil.c
> index 458d359f5991..6e4030482ae8 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -114,6 +114,28 @@ static void sugov_deferred_update(struct sugov_polic=
y *sg_policy)
>         }
>  }
>
> +/**
> + * cpufreq_get_capacity_ref_freq - get the reference frequency of a give=
n CPU that
> + * has been used to correlate frequency and compute capacity.
> + * @policy: the cpufreq policy of the CPU in question.
> + * @use_current: Fallback to current freq instead of policy->cpuinfo.max=
_freq.
> + *
> + * Return: the reference CPU frequency to compute a capacity.
> + */
> +static __always_inline
> +unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy)
> +{
> +       unsigned int freq =3D arch_scale_freq_ref(policy->cpu);
> +
> +       if (freq)
> +               return freq;
> +
> +       if (arch_scale_freq_invariant())
> +               return policy->cpuinfo.max_freq;
> +
> +       return policy->cur;
> +}
> +
>  /**
>   * get_next_freq - Compute a new frequency for a given cpufreq policy.
>   * @sg_policy: schedutil policy object to compute the new frequency for.
> @@ -140,10 +162,10 @@ static unsigned int get_next_freq(struct sugov_poli=
cy *sg_policy,
>                                   unsigned long util, unsigned long max)
>  {
>         struct cpufreq_policy *policy =3D sg_policy->policy;
> -       unsigned int freq =3D arch_scale_freq_invariant() ?
> -                               policy->cpuinfo.max_freq : policy->cur;
> +       unsigned int freq;
>
>         util =3D map_util_perf(util);
> +       freq =3D get_capacity_ref_freq(policy);
>         freq =3D map_util_freq(util, freq, max);
>
>         if (freq =3D=3D sg_policy->cached_raw_freq && !sg_policy->need_fr=
eq_update)
> --
> 2.34.1
>
