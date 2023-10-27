Return-Path: <vincent.guittot@linaro.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5A2B984B59
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 839C2849BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698419960; x=1699024760;
 darn=lists.linuxfoundation.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W/jyxUKjs+ivpArfOLxbtvoP8jhQ6Kn3kdcGQik3464=;
 b=ixbdMiZX3prXPRnxEmb3MG8ttUEuZh59wzAIW79ox7WkU7I7sjNZkG9m5U+6eAL+OQ
 kF+c9VfT0x06QRjZ1X7J8Qjnd0sKP9zvQbZC5m70Uk2FJF/GKmInp9I1S+TKHy1E278/
 SK0fju41wsaHe35ah/Pfmh7LJEiMIRm0etksY+WIHsjljbFMrtS+4CuAQHuXosKdLgn5
 j5wDOpj9GGrP4WlWyIwZRvFCH9GAVv7S1EEov1SO63UbSrsXk6r0KH9UR4GQ1NKyXj4d
 7cXujv/5VJ5J0Zy/boQcMgg+7sUWL3F7UWzsbYz24EUbbuye+1HDrVYK73CokbmAwETe
 BaWw==
MIME-Version: 1.0
References: <20231027080400.56703-1-vincent.guittot@linaro.org>
 <20231027080400.56703-2-vincent.guittot@linaro.org>
 <ZTuDW8lXZLQP1Ruq@gmail.com>
In-Reply-To: <ZTuDW8lXZLQP1Ruq@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 27 Oct 2023 17:19:07 +0200
Message-ID: <CAKfTPtDgUiY3COzR4xMZ80yKuK2FWNx=wnVXhRTR8vZ6JSnAoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Acpica-devel] [PATCH v4 1/7] topology: add a new
	arch_scale_freq_reference
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: Ingo Molnar <mingo@kernel.org>
Cc: juri.lelli@redhat.com, peterz@infradead.org, catalin.marinas@arm.com, robert.moore@intel.com, bsegall@google.com, conor.dooley@microchip.com, pierre.gondois@arm.com, linux-riscv@lists.infradead.org, will@kernel.org, acpica-devel@lists.linuxfoundation.org, vschneid@redhat.com, linux@armlinux.org.uk, linux-acpi@vger.kernel.org, mingo@redhat.com, mgorman@suse.de, lftan@kernel.org, viresh.kumar@linaro.org, lenb@kernel.org, aou@eecs.berkeley.edu, ionela.voinescu@arm.com, linux-pm@vger.kernel.org, rostedt@goodmis.org, paul.walmsley@sifive.com, dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, palmer@dabbelt.com, sudeep.holla@arm.com, suagrfillet@gmail.com, ajones@ventanamicro.com, bristot@redhat.com, lukasz.luba@arm.com

On Fri, 27 Oct 2023 at 11:31, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> > --- a/include/linux/arch_topology.h
> > +++ b/include/linux/arch_topology.h
> > @@ -27,6 +27,13 @@ static inline unsigned long topology_get_cpu_scale(int cpu)
> >
> >  void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity);
> >
> > +DECLARE_PER_CPU(unsigned long, capacity_ref_freq);
> > +
> > +static inline unsigned long topology_get_freq_ref(int cpu)
> > +{
> > +     return per_cpu(capacity_ref_freq, cpu);
> > +}
> > +
> >  DECLARE_PER_CPU(unsigned long, arch_freq_scale);
>
> So mind naming it in a way that expresses that this is indeed a maximum
> frequency? arch_scale_ref_freq_max or so?

This does not always have to be the max frequency of the CPU but the
frequency that has been used to compute the capacity of the CPU so
it's the "reference" frequency used for computing the capacity and
that must be used to compute  the capacity for a given frequency and
the other way. That 's why I have intentionally not used freq_max

Then other similar functions start with arch_scale_freq_something

>
> Also, is there any particular concept behind naming one new symbol
> 'freq_ref', the other 'ref_freq'? If not then please standardize on one
> variant.

no particular reason. ref_freq comes from "reference frequency" but
interfaces follows arch_scale_freq_something or
topology_*_freq_something

so we should keep freq_ref to keep interfaces aligned

>
> Thanks,
>
>         Ingo
