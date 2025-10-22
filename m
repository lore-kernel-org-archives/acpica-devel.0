Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8472B320CDF
	for <acpica-devel@lists.linux.dev>; Wed, 22 Oct 2025 12:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761134536; cv=none; b=IHTfeeK//fG4a1gZwq2yEoce7ejaUtXjhS9MdYnE6RGfCESY7LzE/5gmwojSjaZmDaKdF6oJn/iSRMi0rFLjp2qORtOCG3Phhx1mGJMaaiu1phoVeAkF2MofLPYRxftfC+Cty2VdmxHRDBI8JZ+YXq2kRQMfaHMRYkeovFifpqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761134536; c=relaxed/simple;
	bh=IsuZfxhGKpHeb5TgVu9VxMiAddZ0SUSvHT55nq8MAaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwvMLuVusMibH19r92CDRcyxnObNKzd6LkBOVhD8Tq9G4HlsOKEqsn7Xw+aHABiA1l7LPXMqQ0WSKv2atZX+q5HkK/RUJGqr8edE8vortK/05BvLRxQyMTJiLJv0phBmat7f494PnptN4YTPWXHRAa4R/+TfFgCFPIdiJt9qivo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B54CB1063;
	Wed, 22 Oct 2025 05:02:05 -0700 (PDT)
Received: from localhost (ionvoi01-desktop.cambridge.arm.com [10.2.80.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FE633F63F;
	Wed, 22 Oct 2025 05:02:13 -0700 (PDT)
Date: Wed, 22 Oct 2025 13:02:11 +0100
From: Ionela Voinescu <ionela.voinescu@arm.com>
To: Sumit Gupta <sumitg@nvidia.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, lenb@kernel.org,
	robert.moore@intel.com, corbet@lwn.net, pierre.gondois@arm.com,
	zhenglifeng1@huawei.com, rdunlap@infradead.org, ray.huang@amd.com,
	gautham.shenoy@amd.com, mario.limonciello@amd.com,
	perry.yuan@amd.com, linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, treding@nvidia.com,
	jonathanh@nvidia.com, vsethi@nvidia.com, ksitaraman@nvidia.com,
	sanjayc@nvidia.com, bbasu@nvidia.com
Subject: Re: [PATCH v3 6/8] cpufreq: CPPC: Add sysfs for min/max_perf and
 perf_limited
Message-ID: <aPjHw5Sr4IYw+Dum@arm.com>
References: <20251001150104.1275188-1-sumitg@nvidia.com>
 <20251001150104.1275188-7-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001150104.1275188-7-sumitg@nvidia.com>

Hi,

On Wednesday 01 Oct 2025 at 20:31:02 (+0530), Sumit Gupta wrote:
> Add sysfs interfaces for Minimum Performance, Maximum Performance
> and Performance Limited Register in the cppc_cpufreq driver.
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  .../ABI/testing/sysfs-devices-system-cpu      | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index ab8cd337f43a..82141b45d58c 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -327,6 +327,49 @@ Description:	Energy performance preference
>  
>  		This file is only present if the cppc-cpufreq driver is in use.
>  
> +What:		/sys/devices/system/cpu/cpuX/cpufreq/min_perf
> +Date:		September 2025
> +Contact:	linux-pm@vger.kernel.org
> +Description:	Minimum Performance
> +
> +		Read/write a 32 bits value from/to this file. This file
> +		conveys the minimum performance level at which the platform
> +		may run. Minimum performance may be set to any performance
> +		value in the range [Lowest Performance, Highest Performance],
> +		inclusive but must be set to a value that is less than or
> +		equal to that specified by the Maximum Performance Register.
> +
> +		Writing to this file only has meaning when Autonomous Selection
> +		is enabled.

In the ACPI specification I don't see a clear dependency between the
minimum and maximum performance registers and autonomous selection.
There's nothing to say that min and max do not have meaning with
autonomous selection is disabled.

Thanks,
Ionela.

> +
> +		This file is only present if the cppc-cpufreq driver is in use.
> +
> +What:		/sys/devices/system/cpu/cpuX/cpufreq/max_perf
> +Date:		September 2025
> +Contact:	linux-pm@vger.kernel.org
> +Description:	Minimum Performance
> +
> +		Read/write a 32 bits value from/to this file. This file conveys
> +		the maximum performance level at which the platform may run.
> +		Maximum performance may be set to any performance value in the
> +		range [Lowest Performance, Highest Performance], inclusive.
> +
> +		Writing to this file only has meaning when Autonomous Selection is
> +		enabled.
> +
> +		This file is only present if the cppc-cpufreq driver is in use.
> +
> +What:		/sys/devices/system/cpu/cpuX/cpufreq/perf_limited
> +Date:		September 2025
> +Contact:	linux-pm@vger.kernel.org
> +Description:	Minimum Performance
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
> 
