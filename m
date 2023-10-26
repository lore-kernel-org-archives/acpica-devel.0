Return-Path: <vincent.guittot@linaro.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1767E83E3D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4030B83E1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698330665; x=1698935465;
 darn=lists.linuxfoundation.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cyPzF6zImIluItqkN237S1HDHY3vs2wBArSwbVc/hzA=;
 b=OqGeYmvWrvfGyUPVF9doKfpeXE+5nxdszW8a1jfCmgjwGpMpACnv5gz5bpPv/fjBpk
 0B9ZdN0u0hILYBBd+Tc4VD418I3x55KrwI2ITh9M/iQ71d1Awvqvblare5RANAS9cx0J
 R1OFmRX7WSL1RQijZ7IBoGXdY+gD3e5EW3TnGsfEu9B146YtAUp4ghAzRZP9Tb3O4CTE
 CFQyqe7g5GNVAwckThW72MV4Z9KnAZZYHORVvAKl7HETEs1mxgZc996BWQpIHA7+u9HE
 8Lpb2M+DN4DsyaG7B/xPq0pc/ZmzpNP49ZGNuJiYzxXXgX1cGXuDND3S6wILF44qLlAR
 JexQ==
MIME-Version: 1.0
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-7-vincent.guittot@linaro.org>
 <ZTbebQrK3K+JwWxR@arm.com>
 <CAKfTPtA0KBE8TFifOEXddF9d_wqDjb4QUvgK8c0DTtyLrX0atA@mail.gmail.com>
 <c000f7a3-caeb-4d75-8c88-40ed02950ec1@arm.com>
In-Reply-To: <c000f7a3-caeb-4d75-8c88-40ed02950ec1@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 26 Oct 2023 16:30:53 +0200
Message-ID: <CAKfTPtC7vtCKXG4y+7TwtjRJKkzjhPQ1Wb61OXihTDPaetGeWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Acpica-devel] [RFC v3 6/6] arm64/amu: use capacity_ref_freq to
	set AMU ratio
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
Cc: juri.lelli@redhat.com, peterz@infradead.org, catalin.marinas@arm.com, robert.moore@intel.com, bsegall@google.com, conor.dooley@microchip.com, pierre.gondois@arm.com, linux-riscv@lists.infradead.org, will@kernel.org, acpica-devel@lists.linuxfoundation.org, vschneid@redhat.com, linux@armlinux.org.uk, linux-acpi@vger.kernel.org, mingo@redhat.com, mgorman@suse.de, lftan@kernel.org, viresh.kumar@linaro.org, lenb@kernel.org, aou@eecs.berkeley.edu, Ionela Voinescu <ionela.voinescu@arm.com>, linux-pm@vger.kernel.org, rostedt@goodmis.org, paul.walmsley@sifive.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, palmer@dabbelt.com, sudeep.holla@arm.com, suagrfillet@gmail.com, ajones@ventanamicro.com, bristot@redhat.com, lukasz.luba@arm.com

On Thu, 26 Oct 2023 at 13:19, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 24/10/2023 11:58, Vincent Guittot wrote:
> > On Mon, 23 Oct 2023 at 22:58, Ionela Voinescu <ionela.voinescu@arm.com> wrote:
> >>
> >> Hi,
> >>
> >> On Wednesday 18 Oct 2023 at 18:25:40 (+0200), Vincent Guittot wrote:
> >>> Use the new capacity_ref_freq to set the ratio that is used by AMU for
> >>> computing the arch_scale_freq_capacity().
> >>> This helps to keep everything aligned using the same reference for
> >>> computing CPUs capacity.
> >>>
> >>> The default value of the ratio ensures that arch_scale_freq_capacity()
> >>> returns max capacity until it is set to its correct value with the
> >>> cpu capacity and capacity_ref_freq.
>
> Nitpick: Could you mention that arch_max_freq_scale is the default value
> for this ratio? Took me a while to recreate the (not so simple) story
> for this change, i.e. make the connection between ratio and
> arch_max_freq_scale.

something like :
"
The default value of the ratio (saved in per_cpu(arch_max_freq_scale)
ensures that arch_scale_freq_capacity() returns max capacity until it
is set to its correct value with the cpu capacity and
capacity_ref_freq.
"

Or I can rename the variable per_cpu(arch_max_freq_ratio)

>
> init_cpu_capacity_callback()
>
>   freq_inv_set_max_ratio()
>
>     u64 ratio
>     ...
>     per_cpu(arch_max_freq_scale, cpu) = (unsigned long)ratio
>             ^^^^^^^^^^^^^^^^^^^
>
>
> static struct scale_freq_data amu_sfd = {
>         .set_freq_scale = amu_scale_freq_tick,
> }
>
> #define arch_scale_freq_tick topology_scale_freq_tick
>
> topology_scale_freq_tick()
>
>   sfd->set_freq_scale()
>
>
> amu_scale_freq_tick()
>
>   ...
>   scale *= this_cpu_read(arch_max_freq_scale)
>                          ^^^^^^^^^^^^^^^^^^^
>   ...
>   this_cpu_write(arch_freq_scale, (unsigned long)scale);
>
>
> #define arch_scale_freq_capacity topology_get_freq_scale
>
> topology_get_freq_scale(cpu)
>
>   return per_cpu(arch_freq_scale, cpu)
>
> [...]
>
