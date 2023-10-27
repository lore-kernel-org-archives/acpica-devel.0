Return-Path: <mingo.kernel.org@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 754C284D21
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ACD1F84D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698399149; x=1699003949;
 darn=lists.linuxfoundation.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=4TGQezb/2UwSSANsvO0wTZNbBZ1J9wDNV1NfnwhXP5Y=;
 b=Xjulyl3FpH2hDwaB6lpKPNbJHfqq/blhktEWtVPDKFq8qQWoBaxCi/7wOKciTbtYSX
 NpoM3aIX4+XZIQ1b4vcgoxzxsg8Ehs2FbscIJrvluHk96ZOsAurEBAyDkR56bKhadziG
 JAPzaupJt82g5j+LcLeDJu7GQl56rtzcEgrMgOhk5v57C1XxlGB3JpXO6W/R6yjtbEm9
 Y6oQFrHjsGNoRsigEXuR/U7feBJG6cge0RvXBGTm2FcT+SXHqS2BnVzyO7XxZYA2LSlo
 REAU24kbmtfnKfMnYa/6gyA8h4HoK53fjLNKzqr+KRaCPNzA2ldtVnlYchwJobiqy6IV
 2jjQ==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 27 Oct 2023 11:32:24 +0200
From: Ingo Molnar <mingo@kernel.org>
Message-ID: <ZTuDqCFL6uM3tqDd@gmail.com>
References: <20231027080400.56703-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027080400.56703-1-vincent.guittot@linaro.org>
Subject: Re: [Acpica-devel] [PATCH v4 0/7] consolidate and cleanup CPU
	capacity
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

> Vincent Guittot (7):
>   topology: add a new arch_scale_freq_reference
>   cpufreq: use the fixed and coherent frequency for scaling capacity
>   cpufreq/schedutil: use a fixed reference frequency
>   energy_model: use a fixed reference frequency
>   cpufreq/cppc: move and rename cppc_cpufreq_{perf_to_khz|khz_to_perf}
>   cpufreq/cppc: set the frequency used for computing the capacity
>   arm64/amu: use capacity_ref_freq to set AMU ratio

Just a general comment wrt. titles: please capitalize the verb, as we'd do 
in a proper sentence. Saves maintainers one more thing to fix when applying 
patches.

Thanks,

	Ingo
