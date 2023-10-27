Return-Path: <mingo.kernel.org@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 876A084D15
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 354C084D14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698399072; x=1699003872;
 darn=lists.linuxfoundation.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=N4F8FZ57kpr13z/xUt6ki2x46rIiQW8y2N6vuceQyfU=;
 b=LZsvcrNzi1C6MpYnjlWYWq0ietzZfT4wEa+PvML0/ewTe+IoR58hDLb07xKsbh6iOR
 WVNbFVD5e2joCPLt1V49YozGeuNYnjRLbKBiWMAKn//vr5parRx5P7UGW5y+/abtXKrd
 pGp5ayUpqiw/So6FHsAPpZ9pkE30rsV5tXiCkh+G5eFirdronYXh566lOHbrakeV+mQj
 RUu6+VNwZsjbc5dG0Wz6mSyDfOkkLvdSoNCzcm2TW19FJJWt0txKm3UuFFtRlArofgmC
 x+E4dd1Z5N4rZE2M8hLw/SBm/rlJiEOJEpWoB08b3l5dhImIiYaHJiSiJ9D+SnKhViFo
 utqw==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 27 Oct 2023 11:31:07 +0200
From: Ingo Molnar <mingo@kernel.org>
Message-ID: <ZTuDW8lXZLQP1Ruq@gmail.com>
References: <20231027080400.56703-1-vincent.guittot@linaro.org>
 <20231027080400.56703-2-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027080400.56703-2-vincent.guittot@linaro.org>
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
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: juri.lelli@redhat.com, peterz@infradead.org, catalin.marinas@arm.com, robert.moore@intel.com, bsegall@google.com, conor.dooley@microchip.com, pierre.gondois@arm.com, linux-riscv@lists.infradead.org, will@kernel.org, acpica-devel@lists.linuxfoundation.org, vschneid@redhat.com, linux@armlinux.org.uk, linux-acpi@vger.kernel.org, mingo@redhat.com, mgorman@suse.de, lftan@kernel.org, viresh.kumar@linaro.org, lenb@kernel.org, aou@eecs.berkeley.edu, ionela.voinescu@arm.com, linux-pm@vger.kernel.org, rostedt@goodmis.org, paul.walmsley@sifive.com, dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, palmer@dabbelt.com, sudeep.holla@arm.com, suagrfillet@gmail.com, ajones@ventanamicro.com, bristot@redhat.com, lukasz.luba@arm.com


* Vincent Guittot <vincent.guittot@linaro.org> wrote:

> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -27,6 +27,13 @@ static inline unsigned long topology_get_cpu_scale(int cpu)
>  
>  void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity);
>  
> +DECLARE_PER_CPU(unsigned long, capacity_ref_freq);
> +
> +static inline unsigned long topology_get_freq_ref(int cpu)
> +{
> +	return per_cpu(capacity_ref_freq, cpu);
> +}
> +
>  DECLARE_PER_CPU(unsigned long, arch_freq_scale);

So mind naming it in a way that expresses that this is indeed a maximum 
frequency? arch_scale_ref_freq_max or so?

Also, is there any particular concept behind naming one new symbol 
'freq_ref', the other 'ref_freq'? If not then please standardize on one 
variant.

Thanks,

	Ingo
