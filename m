Return-Path: <vincent.guittot@linaro.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DAB8E84F27
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C96A084F25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698933055; x=1699537855;
 darn=lists.linuxfoundation.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vQsf0uxz+p9a7ZD7Gz0obekgX/RPQUCjSUYXjonlb9s=;
 b=nBWjbpqQg9cbAiZMkqeb8QfD7/8XVh7/W3trO46N5WpBpuenOxN0QbCTgfkA2R48ob
 jnKvEaDSbeg3mClOu53LOPib0frUQKCxD7opslvZNSexaheKmME0churonY/h9zwjTpB
 YYEZ5hN6KH7r2EdDHy0Boc8UkhodvFJDx3XUeIN/dASnsiDPQRF4PPf60NKlWxkZ5jfE
 8Q5kWGJ0ctV4gLZvPi9Gwn68uBPXFGeak43OMTnCTGEIrOvR5kCZCdAWhvyo0aKzUDly
 QwntwefXoznEQEwhcwYkRMw5bNVxzpqL8PWQtL1YuHf3fVXxqx6ua5o0T4I831iwTJnw
 Vrww==
MIME-Version: 1.0
References: <20231027080400.56703-1-vincent.guittot@linaro.org>
 <20231027080400.56703-8-vincent.guittot@linaro.org>
 <ZUGUvdjrpw9NHSex@e129154.nice.arm.com>
 <CAKfTPtDDouduP57P8GH6J4qDjbKUasVRe-K0QUKcZHC2NZ+syQ@mail.gmail.com>
 <ZUN6K4d9FD31phbs@e129154.nice.arm.com>
 <CAKfTPtATBHyCvGkoKrN1Y9LpWX7nb3njY2zFPiJyj2bTSfbcNw@mail.gmail.com>
In-Reply-To: <CAKfTPtATBHyCvGkoKrN1Y9LpWX7nb3njY2zFPiJyj2bTSfbcNw@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 2 Nov 2023 14:50:43 +0100
Message-ID: <CAKfTPtCv1WUDr72eqWeJh6iakkn+d4rX1N0d=8G8TEdyeOxH3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Acpica-devel] [PATCH v4 7/7] arm64/amu: use capacity_ref_freq
	to set AMU ratio
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: Beata Michalska <beata.michalska@arm.com>, pierre.gondois@arm.com
Cc: juri.lelli@redhat.com, peterz@infradead.org, catalin.marinas@arm.com, robert.moore@intel.com, bsegall@google.com, conor.dooley@microchip.com, linux-riscv@lists.infradead.org, will@kernel.org, acpica-devel@lists.linuxfoundation.org, vschneid@redhat.com, linux@armlinux.org.uk, linux-acpi@vger.kernel.org, mingo@redhat.com, mgorman@suse.de, lftan@kernel.org, viresh.kumar@linaro.org, lenb@kernel.org, aou@eecs.berkeley.edu, ionela.voinescu@arm.com, linux-pm@vger.kernel.org, rostedt@goodmis.org, paul.walmsley@sifive.com, dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, palmer@dabbelt.com, sudeep.holla@arm.com, suagrfillet@gmail.com, ajones@ventanamicro.com, bristot@redhat.com, lukasz.luba@arm.com

On Thu, 2 Nov 2023 at 11:40, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> On Thu, 2 Nov 2023 at 11:31, Beata Michalska <beata.michalska@arm.com> wrote:
> >
> > Hi Vincent,
> >
> > On Wed, Nov 01, 2023 at 10:04:27AM +0100, Vincent Guittot wrote:
> > > Hi Beata,
> > >
> > > On Wed, 1 Nov 2023 at 00:59, Beata Michalska <beata.michalska@arm.com> wrote:
> > > >
> > > > On Fri, Oct 27, 2023 at 10:04:00AM +0200, Vincent Guittot wrote:
> > > > > Use the new capacity_ref_freq to set the ratio that is used by AMU for
> > > > > computing the arch_scale_freq_capacity().
> > > > > This helps to keep everything aligned using the same reference for
> > > > > computing CPUs capacity.
> > > > >
> > >
> > > [..]
> > >
> > > > > @@ -381,6 +385,9 @@ void topology_init_cpu_capacity_cppc(void)
> > > > >       }
> > > > >
> > > > >       for_each_possible_cpu(cpu) {
> > > > > +             freq_inv_set_max_ratio(cpu,
> > > > > +                                    per_cpu(capacity_ref_freq, cpu) * HZ_PER_KHZ);
> > > > > +
> > > > The capacity_ref_freq set earlier will still lead to units mismatch,
> > > > as at the point of calling topology_init_cpu_capacity_cppc the lowest & nominal
> > > > frequencies will be provided in MHz (unless I have missed smth).
> > >
> > > I don't get your point:
> > > the unit of per_cpu(capacity_freq_ref, cpu) is Khz
> > >
> > > For cppc, we have
> > > per_cpu(capacity_freq_ref, cpu) = cppc_perf_to_khz(&perf_caps,
> > > raw_capacity[cpu]);
> > >
> > > freq_inv_set_max_ratio() uses
> > > arch_timer_get_rate() which returns a freq in Hz
> > > and
> > > per_cpu(capacity_freq_ref, cpu) * HZ_PER_KHZ. to get a freq in Hz too.
> > >
> > Apologies, I should have been more verbose here.
> > Before the change made in [1] the cppc_perf_to_khz was indeed operating on
> > lowest & nominal frequency values expressed in kHZ, as those were appropriately
> > amended:
> > cppc_cpufreq_cpu_init
> >         |__> cppc_cpufreq_get_cpu_data:
> >                 |__>    ...
> >                         /* Convert the lowest and nominal freq from MHz to KHz */
> >                         cpu_data->perf_caps.lowest_freq *= 1000;
> >                         cpu_data->perf_caps.nominal_freq *= 1000;
> >
> > So far cppc_perf_to_khz (previously cppc_cpufreq_perf_to_khz) was being called
> > with the post-processed CPC data (through cppc_cpufreq_get_cpu_data) and thus
> > guaranteed to be operating on values in kHz.
> > With the new changes the cppc_perf_to_khz will operate on raw CPC data,
> > which are expressed in MHz.(as per acpi spec)
>
> Ok, thanks for the explanation. I haven't noticed that cppc_cpufreq
> was processing the raw CPC data  (*1000) before using them. I'm going
> to fix that.

With cppc_perf_to_khz() being moved into the generic cppc_acpi.c, we
can't change perf_caps.nominal_freq and perf_caps.lowest_freq
directly. So, I'm planning to add the conversion from MHz to kHz in
the functions cppc_perf_to_khz() and cppc_khz_to_perf() and remove the
2 conversions above in cppc_cpufreq_get_cpu_data().

>
>
> >
> > ---
> > Best Regards
> > B.
> > > > This means that use of both, the capacity_ref_freq and the arch_freq_scale
> > > > will generate unexpected results, so I guess this should get amended in the
> > > > preceding patch (?) [1]
> > > >
> > > > ---
> > > > BR
> > > > B.
> > > >
> > > > [1] https://lore.kernel.org/linux-arm-kernel/20231027080400.56703-4-vincent.guittot@linaro.org/T/#m42daa167097edc190b1cfc05382c385ed801d909
> > > >
> > > > >               capacity = raw_capacity[cpu];
> > > > >               capacity = div64_u64(capacity << SCHED_CAPACITY_SHIFT,
> > > > >                                    capacity_scale);
> > > > > @@ -422,8 +429,11 @@ init_cpu_capacity_callback(struct notifier_block *nb,
> > > > >
> > > > >       cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus);
> > > > >
> > > > > -     for_each_cpu(cpu, policy->related_cpus)
> > > > > +     for_each_cpu(cpu, policy->related_cpus) {
> > > > >               per_cpu(capacity_ref_freq, cpu) = policy->cpuinfo.max_freq;
> > > > > +             freq_inv_set_max_ratio(cpu,
> > > > > +                                    per_cpu(capacity_ref_freq, cpu) * HZ_PER_KHZ);
> > > > > +     }
> > > > >
> > > > >       if (cpumask_empty(cpus_to_visit)) {
> > > > >               topology_normalize_cpu_scale();
> > > > > diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> > > > > index 38ca6c76af56..ffdf0b7c55fa 100644
> > > > > --- a/include/linux/arch_topology.h
> > > > > +++ b/include/linux/arch_topology.h
> > > > > @@ -99,6 +99,7 @@ void update_siblings_masks(unsigned int cpu);
> > > > >  void remove_cpu_topology(unsigned int cpuid);
> > > > >  void reset_cpu_topology(void);
> > > > >  int parse_acpi_topology(void);
> > > > > +void freq_inv_set_max_ratio(int cpu, u64 max_rate);
> > > > >  #endif
> > > > >
> > > > >  #endif /* _LINUX_ARCH_TOPOLOGY_H_ */
> > > > > --
> > > > > 2.34.1
> > > > >
