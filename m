Return-Path: <vincent.guittot@linaro.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B40E783E66
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E429583E64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698333223; x=1698938023;
 darn=lists.linuxfoundation.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sIQNokBhQSScd068h2R0va+GxK2e4ptgRXBIV8yGO3Q=;
 b=zO4mpllQBLUJT6AmoSPMbK2VXahF9Ez2ykAhzTrY4vtJNiNl1ioeBnk0yPlsiS2EzI
 RmimoZR0dFM0mKz446NHXfi3wWyCEruHLlWnC1O13gHsxf23sV064GHSUkWXBTzPO6C4
 5I0JFS11Iab1zoW3Pg2P6UKnavxUaXYAlM3P3ZJZx8wG3Mg75ZnczhEYOxXH/gIaXgCd
 B4asWZvUAK1ugxEqTSQ/ebcOcAsnpkQer+uiUPKq55jBpZQzSuWlkiQHlJ06gEKla0cZ
 JcQZgl/TyZ7YF0u/2eMTktb+qFbE1D3A4nRxOS3wc0D9dYU9LTjWS7CMsQ+rel0JWz6d
 Pwdg==
MIME-Version: 1.0
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-4-vincent.guittot@linaro.org>
 <f5e398f3-fbb7-4840-9084-14c8254b2118@arm.com>
In-Reply-To: <f5e398f3-fbb7-4840-9084-14c8254b2118@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 26 Oct 2023 17:13:31 +0200
Message-ID: <CAKfTPtBJRT56dL7+UW-viZuK3wKfGimQfrkvtuCQ_20g4N5LPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: juri.lelli@redhat.com, peterz@infradead.org, catalin.marinas@arm.com, robert.moore@intel.com, bsegall@google.com, conor.dooley@microchip.com, pierre.gondois@arm.com, linux-riscv@lists.infradead.org, will@kernel.org, acpica-devel@lists.linuxfoundation.org, vschneid@redhat.com, ajones@ventanamicro.com, linux@armlinux.org.uk, linux-acpi@vger.kernel.org, mingo@redhat.com, bristot@redhat.com, lftan@kernel.org, viresh.kumar@linaro.org, mgorman@suse.de, aou@eecs.berkeley.edu, linux-pm@vger.kernel.org, rostedt@goodmis.org, paul.walmsley@sifive.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, palmer@dabbelt.com, sudeep.holla@arm.com, suagrfillet@gmail.com, lenb@kernel.org, ionela.voinescu@arm.com, lukasz.luba@arm.com

On Wed, 25 Oct 2023 at 22:13, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 18/10/2023 18:25, Vincent Guittot wrote:
> > cpuinfo.max_freq can change at runtime because of boost as an example. This
> > implies that the value could be different than the one that has been
> > used when computing the capacity of a CPU.
> >
> > The new arch_scale_freq_ref() returns a fixed and coherent reference
> > frequency that can be used when computing a frequency based on utilization.
> >
> > Use this arch_scale_freq_ref() when available and fallback to
> > policy otherwise.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> > Tested-by: Lukasz Luba <lukasz.luba@arm.com>
> >
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 26 ++++++++++++++++++++++++--
> >  1 file changed, 24 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 458d359f5991..6e4030482ae8 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -114,6 +114,28 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy)
> >       }
> >  }
> >
> > +/**
> > + * cpufreq_get_capacity_ref_freq - get the reference frequency of a given CPU that
>
> s/cpufreq_get_capacity_ref_freq/get_capacity_ref_freq
>
> s/of a given CPU/for a given cpufreq policy ? (of which the CPU managing
> it is used for the arch_scale_freq_ref() call in the function.
>
> > + * has been used to correlate frequency and compute capacity.
> > + * @policy: the cpufreq policy of the CPU in question.
> > + * @use_current: Fallback to current freq instead of policy->cpuinfo.max_freq.
>
> Looks like use_current does not exists as a parameter.

Thanks for the review. I'm going to apply your comments

>
> > + *
> > + * Return: the reference CPU frequency to compute a capacity.
> > + */
> > +static __always_inline
> > +unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy)
> > +{
> > +     unsigned int freq = arch_scale_freq_ref(policy->cpu);
> > +
> > +     if (freq)
> > +             return freq;
> > +
> > +     if (arch_scale_freq_invariant())
> > +             return policy->cpuinfo.max_freq;
> > +
> > +     return policy->cur;
> > +}
>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>
>
>
