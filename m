Return-Path: <peterz@infradead.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 25314851EF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 69EB2851E8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Iw+hAI2RZyKf3pkny9wI5k8uvYF1PKP6s1iFZu6PRHc=; b=X/M+QWAi63DcW2qYREzSvndZwt
 7X/GeKDC8gewFlEre7f8MPiHWzeV5zv0CdaZCAebgzUIbA8eplVsZ0IzgTNUe2Y2/CYgrCJKgvKfh
 yul1Lx8JtKZwmk0bzufa6faCwQJ6nZb8kg6kdcf4cx45FHJ5JcaA6V7bwMnd4Z1SSaGgRbwmT5mGc
 zZyhiIAv3k99+T1uE1JqCkX6I20Pga7G/rX+pIW76zuCiOPsEHyR7CnBK/cvRRCzvptNwSU1GXd6Q
 1qyuRg9+8ce32XB5Ht4ddRMmc+rvKQ7UkFGGMyp8cniRP6wklfpbEO7pD2cIsmwJf/tnACOgsauPi
 9KX6P0nQ==;
Date: Wed, 25 Oct 2023 13:53:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
Message-ID: <20231025115324.GC31201@noisy.programming.kicks-ass.net>
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-4-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018162540.667646-4-vincent.guittot@linaro.org>
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
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: juri.lelli@redhat.com, catalin.marinas@arm.com, robert.moore@intel.com, bsegall@google.com, conor.dooley@microchip.com, pierre.gondois@arm.com, linux-riscv@lists.infradead.org, will@kernel.org, acpica-devel@lists.linuxfoundation.org, vschneid@redhat.com, ajones@ventanamicro.com, linux@armlinux.org.uk, linux-acpi@vger.kernel.org, mingo@redhat.com, bristot@redhat.com, lftan@kernel.org, viresh.kumar@linaro.org, mgorman@suse.de, aou@eecs.berkeley.edu, linux-pm@vger.kernel.org, rostedt@goodmis.org, paul.walmsley@sifive.com, dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, palmer@dabbelt.com, sudeep.holla@arm.com, suagrfillet@gmail.com, lenb@kernel.org, ionela.voinescu@arm.com, lukasz.luba@arm.com

On Wed, Oct 18, 2023 at 06:25:37PM +0200, Vincent Guittot wrote:

> +static __always_inline
> +unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy)
> +{
> +	unsigned int freq = arch_scale_freq_ref(policy->cpu);
> +
> +	if (freq)
> +		return freq;
> +
> +	if (arch_scale_freq_invariant())
> +		return policy->cpuinfo.max_freq;
> +
> +	return policy->cur;
> +}

Hmm, what should x86 do here? I know it mostly doesn't use these things,
but would it make sense to stick the base frequency in ?
