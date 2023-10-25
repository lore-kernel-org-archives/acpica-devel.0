Return-Path: <vincent.guittot@linaro.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 32E18708A0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9CE1D7054B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698238479; x=1698843279;
 darn=lists.linuxfoundation.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CPGldAWJyTZnXByR/bf8zHHVWHLwPdXuNiykPl5PWWs=;
 b=bWYBuSizuJnY6gQGqO89tyLy7cav6abiS6h/Qxw/wvbAR4KId0p4BJWypFBEjovBJN
 Ca4Ne1F5dpOjhjXS2WYlfu5rTcVC/epqHEdpRY5Ba20E2w6ZHJuMnasYS71TIAX+9t6H
 7lCbU3Tvnpk7TwzMfcH8PYfrA9arjB0z2F3MsG1WHw/Detn076cFb6DSFYKnDX1tHQc7
 qmBl8LTXMFBsJ1qEYdvDW1KFk8vCxeBoRZDwYbwzQxk1mGE265ChajhmvTc8D6YLLJHx
 O1fjsH/EDv3BQ0LuHgqJG2z7cuWQS1tBbN8bm3H7IxAf9PpxV83VPz/+38LlGuQQK+JC
 XHqg==
MIME-Version: 1.0
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-5-vincent.guittot@linaro.org>
 <20231025115456.GD31201@noisy.programming.kicks-ass.net>
In-Reply-To: <20231025115456.GD31201@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 25 Oct 2023 14:54:27 +0200
Message-ID: <CAKfTPtDhRcyHQKGy0aNLXLzGJ6LS+Of7ZjeQGGGv5f5qtNxiBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Acpica-devel] [PATCH v3 4/6] energy_model: use a fixed
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

On Wed, 25 Oct 2023 at 13:55, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 18, 2023 at 06:25:38PM +0200, Vincent Guittot wrote:
> > The last item of a performance domain is not always the performance point
> > that has been used to compute CPU's capacity. This can lead to different
> > target frequency compared with other part of the system like schedutil and
> > would result in wrong energy estimation.
> >
> > A new arch_scale_freq_ref() is available to return a fixed and coherent
> > frequency reference that can be used when computing the CPU's frequency
> > for an level of utilization. Use this function to get this reference
> > frequency.
> >
> > Energy model is never used without defining arch_scale_freq_ref() but
> > can be compiled. Define a default arch_scale_freq_ref() returning 0
> > in such case.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> > Tested-by: Lukasz Luba <lukasz.luba@arm.com>
> >
> > ---
> >  include/linux/energy_model.h | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> > index b9caa01dfac4..1b0c8490d4bd 100644
> > --- a/include/linux/energy_model.h
> > +++ b/include/linux/energy_model.h
> > @@ -204,6 +204,14 @@ struct em_perf_state *em_pd_get_efficient_state(struct em_perf_domain *pd,
> >       return ps;
> >  }
> >
> > +#ifndef arch_scale_freq_ref
> > +static __always_inline
> > +unsigned int arch_scale_freq_ref(int cpu)
> > +{
> > +     return 0;
> > +}
> > +#endif
>
> Hmm, did I not see the exact same thing in cpufreq.h two patches ago?

Probably, this has been added because of error returned by some
allyes/randconfig on x86

>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
