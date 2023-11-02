Return-Path: <vincent.guittot@linaro.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4FA0884CEF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3B1B184C24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698921768; x=1699526568;
 darn=lists.linuxfoundation.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Pd/NLx66E9zKbyZKSmW6GKzzom6QC7VJQH4VG6waGJI=;
 b=LDM7TShdK2AMvm0laAKiN244rgkrUS0wYPdA/y2fnqkidK2YZSpEDUDtDv4wpFl8rM
 277IAAT8fmAqOFsviF2unmGvTX67/gJ+sHeJ8nj3JuhFYIfXIWOsqOJoOKbRwFNdcRFw
 6wvd0a53/CdzbGH33jExlPyWaXkq8FE7p4PhphDg5MKC637hEf0IxPTkk09gDfySi5Cv
 qFclltR2INWFJRQretVe3+rU3IQTUO3N7FFqES0ZhLjQ2lQByYlP6rNN9anpRWB+4vin
 tbKIm9gqbxvk7SdMmdMYEUl++/yGXZnCnaOOFUJctyZ20uZhhemgne/CCFS1Gt2CA3jv
 LEbA==
MIME-Version: 1.0
References: <20231027080400.56703-1-vincent.guittot@linaro.org>
 <20231027080400.56703-7-vincent.guittot@linaro.org>
 <89b5db0e-1121-4d0c-a8f4-1202465f5251@arm.com>
In-Reply-To: <89b5db0e-1121-4d0c-a8f4-1202465f5251@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 2 Nov 2023 11:42:37 +0100
Message-ID: <CAKfTPtDKMhNpjATHtVuTvas59=ugtw7Q2T3fVKx8T83=-nM3xQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: juri.lelli@redhat.com, peterz@infradead.org, catalin.marinas@arm.com, robert.moore@intel.com, bsegall@google.com, conor.dooley@microchip.com, linux-riscv@lists.infradead.org, will@kernel.org, acpica-devel@lists.linuxfoundation.org, vschneid@redhat.com, linux@armlinux.org.uk, linux-acpi@vger.kernel.org, mingo@redhat.com, mgorman@suse.de, lftan@kernel.org, viresh.kumar@linaro.org, lenb@kernel.org, aou@eecs.berkeley.edu, ionela.voinescu@arm.com, linux-pm@vger.kernel.org, rostedt@goodmis.org, paul.walmsley@sifive.com, dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, palmer@dabbelt.com, sudeep.holla@arm.com, suagrfillet@gmail.com, ajones@ventanamicro.com, bristot@redhat.com, lukasz.luba@arm.com

Hi Pierre,

On Thu, 2 Nov 2023 at 10:07, Pierre Gondois <pierre.gondois@arm.com> wrote:
>
> Hello Vincent,
>
> On 10/27/23 10:03, Vincent Guittot wrote:
> > Save the frequency associated to the performance that has been used when
> > initializing the capacity of CPUs.
> > Also, cppc cpufreq driver can register an artificial energy model. In such
> > case, it needs the frequency for this compute capacity.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >   drivers/base/arch_topology.c | 15 ++++++++++++++-
> >   1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > index 9a073c2d2086..d4bef370feb3 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -349,6 +349,7 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
> >
> >   void topology_init_cpu_capacity_cppc(void)
> >   {
> > +     u64 capacity, capacity_scale = 0;
> >       struct cppc_perf_caps perf_caps;
> >       int cpu;
> >
> > @@ -365,6 +366,10 @@ void topology_init_cpu_capacity_cppc(void)
> >                   (perf_caps.highest_perf >= perf_caps.nominal_perf) &&
> >                   (perf_caps.highest_perf >= perf_caps.lowest_perf)) {
> >                       raw_capacity[cpu] = perf_caps.highest_perf;
> > +                     capacity_scale = max_t(u64, capacity_scale, raw_capacity[cpu]);
> > +
> > +                     per_cpu(capacity_ref_freq, cpu) = cppc_perf_to_khz(&perf_caps, raw_capacity[cpu]);
> > +
>
> To continue Beata's point, I think there is an issue with the following:
> cppc_perf_to_khz() and cppc_khz_to_perf() were previously used with a struct containing
> frequencies in KHz, cf. [1].
> In the original _CPC object, frequencies are in MHz. It means that the perf_caps struct
> here contains frequencies in MHz, and per_cpu(capacity_ref_freq, cpu) is in MHz aswell.

Yeah, I haven't noticed this intermediate step in cppc_cpufreq. I'm
going to fix this

>
> [1] https://github.com/torvalds/linux/blob/master/drivers/cpufreq/cppc_cpufreq.c#L682
>
>
> >                       pr_debug("cpu_capacity: CPU%d cpu_capacity=%u (raw).\n",
> >                                cpu, raw_capacity[cpu]);
> >                       continue;
> > @@ -375,7 +380,15 @@ void topology_init_cpu_capacity_cppc(void)
> >               goto exit;
> >       }
> >
> > -     topology_normalize_cpu_scale();
> > +     for_each_possible_cpu(cpu) {
> > +             capacity = raw_capacity[cpu];
> > +             capacity = div64_u64(capacity << SCHED_CAPACITY_SHIFT,
> > +                                  capacity_scale);
> > +             topology_set_cpu_scale(cpu, capacity);
> > +             pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
> > +                     cpu, topology_get_cpu_scale(cpu));
> > +     }
> > +
> >       schedule_work(&update_topology_flags_work);
> >       pr_debug("cpu_capacity: cpu_capacity initialization done\n");
> >
