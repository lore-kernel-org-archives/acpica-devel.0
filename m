Return-Path: <mingo.kernel.org@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8808F4EF41
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C4A744EF3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698399497; x=1699004297;
 darn=lists.linuxfoundation.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=Hp6XVPEWlKxTXMoDywd4XYa7dN3u7ZNoCSpHDxvreZE=;
 b=SxNMC3GLhp+LPAGssjgFUzfl6E+XxQoXCE6tluc/OKTNBOXjEWStKzmwCTDTmI/1Sp
 5x2FsceJ6wf0pfmLTVrHwx23lzy+SthJTp+mFXPXSSGycp1Uu1A8tkLWzpvOeynmoLGa
 BCjpEkme9cOnVVVYEezFTOLzKmAueMHTTu9ERQT9COJRl8bCCVIO3C2TUdhm2oOA1BKN
 Vc1vt0AEzbICWDHT8WjC127pb5H58imc20c8vdglk07rJZZ9DPdhLrPrVbZKZjNcxIlH
 yDHejVmYlwvyCK8odUEcitW/xP/jchA4JO4IQoy/sIfH2RjRWEeKu/DW241rOtvqjGi/
 +dRQ==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 27 Oct 2023 11:38:13 +0200
From: Ingo Molnar <mingo@kernel.org>
Message-ID: <ZTuFBeVIjA2hjbPh@gmail.com>
References: <20231027080400.56703-1-vincent.guittot@linaro.org>
 <20231027080400.56703-6-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027080400.56703-6-vincent.guittot@linaro.org>
Subject: Re: [Acpica-devel] [PATCH v4 5/7] cpufreq/cppc: move and rename
 cppc_cpufreq_{perf_to_khz|khz_to_perf}
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

> +/* Look up the max frequency in DMI */
> +static u64 cppc_get_dmi_max_khz(void)
> +{
> +	u16 mhz = 0;
> +
> +	dmi_walk(cppc_find_dmi_mhz, &mhz);
> +
> +	/*
> +	 * Real stupid fallback value, just in case there is no
> +	 * actual value set.
> +	 */
> +	mhz = mhz ? mhz : 1;
> +
> +	return (1000 * mhz);

Nit, and I realize this is pre-existing code, but 'return' is a keyword, 
not a function, so the parentheses are not needed.

Thanks,

	Ingo
