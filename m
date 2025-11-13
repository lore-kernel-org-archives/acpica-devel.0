Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3841B34E744
	for <acpica-devel@lists.linux.dev>; Thu, 13 Nov 2025 12:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763037686; cv=none; b=WOPluIPgQMJxtUxv55M6Xbxhm2CJ1WGNDgxT/ljqjKNRYGn9CvG/LsYHvT3+8l+jC1SnVIGYIP/G71Y/JVjyDMOYsWeTDhLJPb3wO6TiUYQtDz1zpXT3818HAWJyR89fULP5chdCZyzSkyEMuhdHxoqBbtyKW12jVn8FMA582sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763037686; c=relaxed/simple;
	bh=XaTNNB/CqGz+V+OMzj/mIjV+mLYVDACn92ZqVORRSbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3oKws/ZfcHktV2o/wi6dv/e6iXqxLNoSVFCTw2AH29h0H3WHZHChsTwec5R+aJqR/n2H+zlFTwPTHVg0PEN2MCMHOgVvYWZMIASSfOUsnDp7T5EypAhturvSnpUgpt47V39CxWfiPCcXnuA82FON1KZfx+rBGINr3nVRibhMRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C26B012FC;
	Thu, 13 Nov 2025 04:41:16 -0800 (PST)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.80.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 026C73F5A1;
	Thu, 13 Nov 2025 04:41:24 -0800 (PST)
Date: Thu, 13 Nov 2025 12:41:19 +0000
From: Ionela Voinescu <ionela.voinescu@arm.com>
To: Sumit Gupta <sumitg@nvidia.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, lenb@kernel.org,
	robert.moore@intel.com, corbet@lwn.net, pierre.gondois@arm.com,
	zhenglifeng1@huawei.com, rdunlap@infradead.org, ray.huang@amd.com,
	gautham.shenoy@amd.com, mario.limonciello@amd.com,
	perry.yuan@amd.com, zhanjie9@hisilicon.com,
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
	ksitaraman@nvidia.com, sanjayc@nvidia.com, nhartman@nvidia.com,
	bbasu@nvidia.com
Subject: Re: [PATCH v4 6/8] cpufreq: CPPC: Add sysfs for min/max_perf and
 perf_limited
Message-ID: <aRXR7yKyG6l1Agfq@arm.com>
References: <20251105113844.4086250-1-sumitg@nvidia.com>
 <20251105113844.4086250-7-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105113844.4086250-7-sumitg@nvidia.com>

Hi,

On Wednesday 05 Nov 2025 at 17:08:42 (+0530), Sumit Gupta wrote:
> Add sysfs interfaces for Minimum Performance, Maximum Performance
> and Performance Limited Register in the cppc_cpufreq driver.
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  .../ABI/testing/sysfs-devices-system-cpu      | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 8aed6d94c4cd..6f1f70696000 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -327,6 +327,52 @@ Description:	Energy performance preference
>  
>  		This file is only present if the cppc-cpufreq driver is in use.
>  
> +What:		/sys/devices/system/cpu/cpuX/cpufreq/min_perf
> +Date:		December 2025
> +Contact:	linux-pm@vger.kernel.org
> +Description:	Minimum Performance Frequency
> +
> +		Read/write a frequency value in kHz from/to this file. This
> +		file conveys the minimum performance level (as frequency) at
> +		which the platform may run. The frequency value is internally
> +		converted to a performance value and must correspond to a
> +		performance level in the range [Lowest Performance, Highest
> +		Performance], inclusive. The minimum must be less than or equal
> +		to the maximum performance. The performance range can be checked
> +		from nodes:
> +			/sys/devices/system/cpu/cpuX/acpi_cppc/highest_perf
> +			/sys/devices/system/cpu/cpuX/acpi_cppc/lowest_perf

I think information on highest/lowest performance is irrelevant here. If
the user is expected to provide a frequency value, it should only care
about it being in the range [cpuinfo_min_freq, cpuinfo_max_freq].

I think ideally all of these controls (auto-select, EPP, min, max, etc.)
would have been better placed under
/sys/devices/system/cpu/cpuX/acpi_cppc, but I suppose the intention
was/is to have all performance related controls under cpufreq. But that
means that the user should not be concerned about the underlying CPPC
scale and only use /sys/devices/system/cpu/cpuX/acpi_cppc for
information purposes.

Thanks,
Ionela.

> +
> +		This file is only present if the cppc-cpufreq driver is in use.
> +
> +What:		/sys/devices/system/cpu/cpuX/cpufreq/max_perf
> +Date:		December 2025
> +Contact:	linux-pm@vger.kernel.org
> +Description:	Maximum Performance Frequency
> +
> +		Read/write a frequency value in kHz from/to this file. This
> +		file conveys the maximum performance level (as frequency) at
> +		which the platform may run. The frequency value is internally
> +		converted to a performance value and must correspond to a
> +		performance level in the range [Lowest Performance, Highest
> +		Performance], inclusive. The performance range can be checked
> +		from nodes:
> +			/sys/devices/system/cpu/cpuX/acpi_cppc/highest_perf
> +			/sys/devices/system/cpu/cpuX/acpi_cppc/lowest_perf
> +
> +		This file is only present if the cppc-cpufreq driver is in use.
> +
> +What:		/sys/devices/system/cpu/cpuX/cpufreq/perf_limited
> +Date:		December 2025
> +Contact:	linux-pm@vger.kernel.org
> +Description:	Performance Limited
> +
> +		Read/write a 32 bits value from/to this file. This file indicates
> +		to OSPM that an unpredictable event has limited processor
> +		performance, and the delivered performance may be less than
> +		desired/minimum performance.
> +
> +		This file is only present if the cppc-cpufreq driver is in use.
>  
>  What:		/sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
>  Date:		August 2008
> -- 
> 2.34.1
> 
