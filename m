Return-Path: <vincent.guittot@linaro.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7710E4ED9F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9156A4F33B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698238319; x=1698843119;
 darn=lists.linuxfoundation.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RvB5kqMmUp8d1e0rOJcbxAUMfkyNt35m6Sgeu0KyMRI=;
 b=A+zX/a3J4Cay4lqzNAE7pL+Sxf8B3+MYAqEHVccj86CXPgeauQOWaiCHpTEfpQa6hy
 3DPielbM8/FR81evSsGXs08rlOnualUaihbJZ73/q8L/iNiH07smj8NkKYn1JMUxBX1p
 CmgtCcVw4V9KYPmuvLzJLNZC7vsqDeNKj7pwUNAlsy05LeC1rV7JCuXcl5w750dm2skw
 3JzQy8qgjClBnne/m77SuKKVJ84D+Zm2/Dm+O/5dUYjExFExlREYgpRjC/gvUjthBRUG
 Twnl/dKLbXqL6PAWjEV6EDLlS8dKogu7RCRyQnAxIkZUaOzrqz1Xjlv0IDNl8OiiIGLg
 L0+A==
MIME-Version: 1.0
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-4-vincent.guittot@linaro.org>
 <20231025115324.GC31201@noisy.programming.kicks-ass.net>
In-Reply-To: <20231025115324.GC31201@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 25 Oct 2023 14:51:47 +0200
Message-ID: <CAKfTPtDqFy-1dXH51JJ28XdH452K4ACrC3gr-v212s5-hH9RBw@mail.gmail.com>
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
To: Peter Zijlstra <peterz@infradead.org>
Cc: juri.lelli@redhat.com, catalin.marinas@arm.com, robert.moore@intel.com, bsegall@google.com, conor.dooley@microchip.com, pierre.gondois@arm.com, linux-riscv@lists.infradead.org, will@kernel.org, acpica-devel@lists.linuxfoundation.org, vschneid@redhat.com, ajones@ventanamicro.com, linux@armlinux.org.uk, linux-acpi@vger.kernel.org, mingo@redhat.com, bristot@redhat.com, lftan@kernel.org, viresh.kumar@linaro.org, mgorman@suse.de, aou@eecs.berkeley.edu, linux-pm@vger.kernel.org, rostedt@goodmis.org, paul.walmsley@sifive.com, dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, palmer@dabbelt.com, sudeep.holla@arm.com, suagrfillet@gmail.com, lenb@kernel.org, ionela.voinescu@arm.com, lukasz.luba@arm.com

On Wed, 25 Oct 2023 at 13:53, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 18, 2023 at 06:25:37PM +0200, Vincent Guittot wrote:
>
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
> Hmm, what should x86 do here? I know it mostly doesn't use these things,
> but would it make sense to stick the base frequency in ?

get_capacity_ref_freq() should return the frequency that is used as
the reference for the max compute capacity.

On Arm64, we have seen some inconsistency especially because we use
the energy model, we compute the CPU's capacity at boot and we can
have different compute capacity in our system whereas x86 always uses
SCHED_CAPACITY_SCALE even on hybrid system if I'm not wrong

So I was not sure that this will make any difference for x86 platform

>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
