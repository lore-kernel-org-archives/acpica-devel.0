Return-Path: <pierre.gondois@arm.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1CD0C83BB1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CBB87837CD
Message-ID: <89b5db0e-1121-4d0c-a8f4-1202465f5251@arm.com>
Date: Thu, 2 Nov 2023 10:06:50 +0100
MIME-Version: 1.0
References: <20231027080400.56703-1-vincent.guittot@linaro.org>
 <20231027080400.56703-7-vincent.guittot@linaro.org>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20231027080400.56703-7-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Acpica-devel] [PATCH v4 6/7] cpufreq/cppc: set the frequency
 used for computing the capacity
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: Vincent Guittot <vincent.guittot@linaro.org>, linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, sudeep.holla@arm.com, gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com, lukasz.luba@arm.com, ionela.voinescu@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org
Cc: suagrfillet@gmail.com, conor.dooley@microchip.com, lftan@kernel.org, ajones@ventanamicro.com

Hello Vincent,

On 10/27/23 10:03, Vincent Guittot wrote:
> Save the frequency associated to the performance that has been used when
> initializing the capacity of CPUs.
> Also, cppc cpufreq driver can register an artificial energy model. In such
> case, it needs the frequency for this compute capacity.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   drivers/base/arch_topology.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 9a073c2d2086..d4bef370feb3 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -349,6 +349,7 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
>   
>   void topology_init_cpu_capacity_cppc(void)
>   {
> +	u64 capacity, capacity_scale = 0;
>   	struct cppc_perf_caps perf_caps;
>   	int cpu;
>   
> @@ -365,6 +366,10 @@ void topology_init_cpu_capacity_cppc(void)
>   		    (perf_caps.highest_perf >= perf_caps.nominal_perf) &&
>   		    (perf_caps.highest_perf >= perf_caps.lowest_perf)) {
>   			raw_capacity[cpu] = perf_caps.highest_perf;
> +			capacity_scale = max_t(u64, capacity_scale, raw_capacity[cpu]);
> +
> +			per_cpu(capacity_ref_freq, cpu) = cppc_perf_to_khz(&perf_caps, raw_capacity[cpu]);
> +

To continue Beata's point, I think there is an issue with the following:
cppc_perf_to_khz() and cppc_khz_to_perf() were previously used with a struct containing
frequencies in KHz, cf. [1].
In the original _CPC object, frequencies are in MHz. It means that the perf_caps struct
here contains frequencies in MHz, and per_cpu(capacity_ref_freq, cpu) is in MHz aswell.

[1] https://github.com/torvalds/linux/blob/master/drivers/cpufreq/cppc_cpufreq.c#L682


>   			pr_debug("cpu_capacity: CPU%d cpu_capacity=%u (raw).\n",
>   				 cpu, raw_capacity[cpu]);
>   			continue;
> @@ -375,7 +380,15 @@ void topology_init_cpu_capacity_cppc(void)
>   		goto exit;
>   	}
>   
> -	topology_normalize_cpu_scale();
> +	for_each_possible_cpu(cpu) {
> +		capacity = raw_capacity[cpu];
> +		capacity = div64_u64(capacity << SCHED_CAPACITY_SHIFT,
> +				     capacity_scale);
> +		topology_set_cpu_scale(cpu, capacity);
> +		pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
> +			cpu, topology_get_cpu_scale(cpu));
> +	}
> +
>   	schedule_work(&update_topology_flags_work);
>   	pr_debug("cpu_capacity: cpu_capacity initialization done\n");
>   
