Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272F1313E36
	for <acpica-devel@lists.linux.dev>; Fri, 29 May 2026 13:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780060332; cv=none; b=rxecBRR0zJYdZ1sEy24AMgWSZ+jBRNhcj+k2lOEbOvPArpfW+KVRblQUUdYdnKe/1ju+wAUDrJjDbLplYQPXHKWyIVhml0djuHpGeW/468rciS3ho05v4aMJtLuoJLHAOPDz6Js3bcI+KK98ZG51c73Zll5u10m1Hn7Xl2BK+Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780060332; c=relaxed/simple;
	bh=NWesLKco5m/X9+wT5+m7tBqm69QwtpwwaWWeHJXlkSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GGYVp/HQgFQtkbypTS1EsjU4dlhzwhx9EvGt0IxfHNOi2UeWcttr9TR8RekOzZOAeuJKb7oV8Z++qk0JB4ogeYek/xl+y9iG7hpY0BxcmTMXN8QHv5V0GJwaNgZL0Axg8faiCpnuJhhEi+/TydEbgw7Lqqe9cugCXTedP72CpMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qMFzpoAu; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qMFzpoAu"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 740BE20E3;
	Fri, 29 May 2026 06:12:04 -0700 (PDT)
Received: from [10.57.69.151] (unknown [10.57.69.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4823B3F905;
	Fri, 29 May 2026 06:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780060329; bh=NWesLKco5m/X9+wT5+m7tBqm69QwtpwwaWWeHJXlkSg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qMFzpoAu5/20wWYV5BRMcntvCa2zY9gbeHEHECfKVmTlyIapX1D683zZxSupgmy6f
	 HlLgECMO+9e2NB/O3nMQVdzIYV5ljuGs4s+odsYJdSqZVPt3ABYNK21+4+Ael8XFhS
	 HdabcIDhR/C1k95CXRFRp0w4A5SofEzbCnQMcgC8=
Message-ID: <19b92583-ab78-4b45-a260-03a13874b0fe@arm.com>
Date: Fri, 29 May 2026 14:12:02 +0100
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] ACPI: CPPC: Add ospm_nominal_perf support
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, pierre.gondois@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, mario.limonciello@amd.com,
 saket.dumbre@intel.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 acpica-devel@lists.linux.dev
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
References: <20260527194626.185286-1-sumitg@nvidia.com>
 <20260527194626.185286-3-sumitg@nvidia.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260527194626.185286-3-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/27/26 20:46, Sumit Gupta wrote:
> Expose the OSPM Nominal Performance register (ACPI 6.6, Section
> 8.4.6.1.2.6), which conveys the desired nominal performance level
> at which the platform may run. Unlike the existing read-only
> Nominal Performance register, it is writable and lets OSPM
> request a lower nominal level than the platform-reported nominal.
> The platform classifies performance above this level as boosted
> and below as throttled for its power/thermal decisions.
> 
> It is exposed as a per-policy cpufreq sysfs attribute in kHz, to
> match the cpufreq sysfs unit convention:
> 
>   /sys/devices/system/cpu/cpufreq/policyN/ospm_nominal_freq
> 
> The attribute is documented in
> Documentation/ABI/testing/sysfs-devices-system-cpu.
> 
> Writes are converted to perf via cppc_khz_to_perf(), validated
> against [Lowest Performance, Nominal Performance], and applied to
> every CPU in policy->cpus.
> 
> The register is write-only; the kernel caches the last written
> value in struct cppc_cpudata for sysfs readback (returns 0 until
> userspace writes a value).
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  .../ABI/testing/sysfs-devices-system-cpu      | 17 ++++++
>  drivers/acpi/cppc_acpi.c                      | 35 +++++++++++
>  drivers/cpufreq/cppc_cpufreq.c                | 60 +++++++++++++++++++
>  include/acpi/cppc_acpi.h                      | 12 ++++
>  4 files changed, 124 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 82d10d556cc8..ac1bf1b89ac4 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -346,6 +346,23 @@ Description:	Performance Limited
>  
>  		This file is only present if the cppc-cpufreq driver is in use.
>  
> +What:		/sys/devices/system/cpu/cpuX/cpufreq/ospm_nominal_freq
> +Date:		May 2026
> +Contact:	linux-pm@vger.kernel.org
> +Description:	OSPM Nominal Performance (kHz)
> +
> +		OSPM uses this attribute to request a nominal performance
> +		level lower than the platform-reported nominal. The
> +		platform treats performance above this level as boost
> +		and below as throttle for power and thermal decisions.
> +
> +		Read returns the last written value in kHz, or 0 if no
> +		value has been written. Write a kHz value in the range
> +		[lowest_freq, nominal_freq].
> +
> +		This file is only present if the cppc-cpufreq driver is
> +		in use.
> +

Given that this value, based also on firmware behavior, can create vast asymmetries
between CPUs, which the scheduler would be unaware of I wonder if this warrants
a similar disclaimer like intel_pstate carries for their per-CPU EPP:
https://www.kernel.org/doc/html/v7.0/admin-guide/pm/intel_pstate.html#energy-vs-performance-hints

"[Note that tasks may by migrated from one CPU to another by the scheduler’s load-balancing algorithm and if different energy vs performance hints are set for those CPUs, that may lead to undesirable outcomes. To avoid such issues it is better to set the same energy vs performance hint for all CPUs or to pin every task potentially sensitive to them to a specific CPU.]"
