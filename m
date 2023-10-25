Return-Path: <peterz@infradead.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CEEB840A71
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AEBAA4050C
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=I6U4cMAF+dRQvQ4QB4nnl2voztgx7oKwkMlBlghU/+4=; b=i7e/GIkirCK3eMrF1Pc/JShL2T
 jDeHz4PgvI28zCGWCfM/azocWWYqV9X6M49ANkRpZLWdKau34PCzf2Ul3K0T7X7Y6X5oD97pOu8+/
 m1EDR5zg+J8icTnYY0ikCFep4W3RfKCyLzcUv6LOq8mOrAztmpeLa3idMiIQU3W4swChebqjoGePo
 7FKb9COKfG3Z/cPUR7URWf+5tniJVYnuGLVZJ1xw4lieDsXqXD5AQawmnEs44dQ+znx6bgGiwUpxE
 Ui0t4ctoZVBEjH1HV4cVAYRWOeK03xabavg5zvMzQ4IU+8mfbuL7bHPL7nVc7wQP+EdAGMBv8yS4M
 yxvnrWbQ==;
Date: Wed, 25 Oct 2023 13:54:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
Message-ID: <20231025115456.GD31201@noisy.programming.kicks-ass.net>
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-5-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018162540.667646-5-vincent.guittot@linaro.org>
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
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: juri.lelli@redhat.com, catalin.marinas@arm.com, robert.moore@intel.com, bsegall@google.com, conor.dooley@microchip.com, pierre.gondois@arm.com, linux-riscv@lists.infradead.org, will@kernel.org, acpica-devel@lists.linuxfoundation.org, vschneid@redhat.com, ajones@ventanamicro.com, linux@armlinux.org.uk, linux-acpi@vger.kernel.org, mingo@redhat.com, bristot@redhat.com, lftan@kernel.org, viresh.kumar@linaro.org, mgorman@suse.de, aou@eecs.berkeley.edu, linux-pm@vger.kernel.org, rostedt@goodmis.org, paul.walmsley@sifive.com, dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, palmer@dabbelt.com, sudeep.holla@arm.com, suagrfillet@gmail.com, lenb@kernel.org, ionela.voinescu@arm.com, lukasz.luba@arm.com

On Wed, Oct 18, 2023 at 06:25:38PM +0200, Vincent Guittot wrote:
> The last item of a performance domain is not always the performance point
> that has been used to compute CPU's capacity. This can lead to different
> target frequency compared with other part of the system like schedutil and
> would result in wrong energy estimation.
> 
> A new arch_scale_freq_ref() is available to return a fixed and coherent
> frequency reference that can be used when computing the CPU's frequency
> for an level of utilization. Use this function to get this reference
> frequency.
> 
> Energy model is never used without defining arch_scale_freq_ref() but
> can be compiled. Define a default arch_scale_freq_ref() returning 0
> in such case.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Tested-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> ---
>  include/linux/energy_model.h | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index b9caa01dfac4..1b0c8490d4bd 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -204,6 +204,14 @@ struct em_perf_state *em_pd_get_efficient_state(struct em_perf_domain *pd,
>  	return ps;
>  }
>  
> +#ifndef arch_scale_freq_ref
> +static __always_inline
> +unsigned int arch_scale_freq_ref(int cpu)
> +{
> +	return 0;
> +}
> +#endif

Hmm, did I not see the exact same thing in cpufreq.h two patches ago?
