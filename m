Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91FA1DE2BE
	for <acpica-devel@lists.linux.dev>; Thu, 16 Jan 2025 11:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737027549; cv=none; b=lgz2lnKMuWTQVdqEmIWaiNDVC1LWrP0/EEjVbRU6kUgCU1k8BvwTookzCuk8PNFqlmj73TUfLeADZo3yhUzA9wUUNTMC2/MyDaE4DGNGvwY48U1Sinhxuj6GPHc18DPtCK9WPmgX5qViBAEXyz8xTcBHBZUdUZ0OpSnZ0JenlIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737027549; c=relaxed/simple;
	bh=iXmKHxfX3cmFNPMxlw03hBHLwxLoJ6KyqJxiZQT+cug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FmUg00+C31gCKEaV3GZ5WmuGyJEy6q5h5PqXWhAFudim5NRXJNmaBTgTD2qkXHyodOJnFtFZuKV74eoBXHAMv1CGI4svuFFoAckxS9y5tTyk+SsVXdB10MYK/TeeSxiP3Tv7vch76/Nia4GI23OMiRac4JdWsspJCjR9a/c2CdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vr6wn+Ag; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vr6wn+Ag"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3eb790888c6so256498b6e.2
        for <acpica-devel@lists.linux.dev>; Thu, 16 Jan 2025 03:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737027547; x=1737632347; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jeyrR5zpiHrATXOHkGinrudHepB19bo1wvgd9FNzEGY=;
        b=Vr6wn+AglDFIHgg3uKqJFv23eRJM3QxoqAFPhWfHdhqULHJ1kSvQu4b5yoTVsuxn0o
         c2PPnKxjjIVnQdAUnh/Hi2fKI5wLeFYIt3PJdQGu32mHHCwHJUbXR8zAOJp4VSfVVO9O
         U5W0EcMrQlzn7+klbOFP4pBsaqhor2eW89U3CMCLOa2553QBpYQm4bH5irKLNbPXmWbn
         IarnxwM0UO+d5vIdkeGZY2q2MNSg2pM9ONkWCfxHxFK3rD4FR25qk7ftATnq5uxEp3Hi
         c9QxFaKKPSBTRL4bl5PjlM4pmVwjGvQyqehXaxChicNpovbwOqy45mzi7iKx9/+GvhUb
         LfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737027547; x=1737632347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jeyrR5zpiHrATXOHkGinrudHepB19bo1wvgd9FNzEGY=;
        b=Yn0qe5HypBZXJqeCjQSOoJKhjrseggZKsU7F5B4b3DpqmGjX1wE5Uay64e7i3MV1oO
         QQYd5qcVWHyiS8fKrmxdfCshkII/bw386BjVLTyfNZOMAxnEirgw0GuJiGgqpYZRc12i
         yOdmpEI5aNdwLCkIixzSLTYzvG5T39dwv3e/jjL/Vtfgj3A4foPVfASqC+7ZS0TQmzjk
         hGV3o93HFSEXwkFL+HzD7COZJ8+0kyVifIle3ScfPwOyK5AqhH/RiVTKXdXK1Iv4cEI6
         ikXLdRTDBkyO+Bua+TO6xEzyzkv2vhWsydPJp59vMij7IrFZxzH++H2VkiHs9VqYLUZq
         +ccw==
X-Gm-Message-State: AOJu0Yw2QYQQJGTM2XZ2X40n3QdgxrQwVG1XdJBAsDKEKrzeyeXx4N2B
	/eVqF3aaLRV+36IPfZg7PpFl8Qq1ngX9St6hxc/lVbLEZarDRTWI
X-Gm-Gg: ASbGncu1+yuiICLiNYKdzkwPN2TUEW9DKK6Ax8hedRVRlqcws5Sad2m+2WETQIWTYqG
	PVYGkXe3gzuCQmsp/3iNWn6A1xlVw8f3oNlP+6rndwHUlIqoijgXHeIM4PteKtEbcY7edDKn80q
	zmXtVvK9aksYDe43To2CvR03p3E8f/LubmbUYxxt+aLuCwoYZQNRkZlKWhqUC2qNfcNvNUdNTzF
	GDRzfpynmAjBkbYU6itqv3IaKnXyb4gUysVlu4dIW/xhFCClEaLyRSjuml5vxKZlvPcgKdE
X-Google-Smtp-Source: AGHT+IEFdGmDTMKc/IfH1eYMsdUc7ecJvD67ozxyMeX4N9BgwSLyzX9rNJ11UDGdAfFp96tFY1vrhQ==
X-Received: by 2002:a05:6808:2006:b0:3eb:58b0:ac6f with SMTP id 5614622812f47-3ef2edd1da9mr15803241b6e.32.1737027546868;
        Thu, 16 Jan 2025 03:39:06 -0800 (PST)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2ad8059e39esm7285526fac.31.2025.01.16.03.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 03:39:06 -0800 (PST)
Message-ID: <21654032-a394-4da9-8ee9-d7cb9df8c855@gmail.com>
Date: Thu, 16 Jan 2025 05:39:04 -0600
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] cpufreq: CPPC: Support for autonomous selection in
 cppc_cpufreq
To: Lifeng Zheng <zhenglifeng1@huawei.com>, rafael@kernel.org,
 lenb@kernel.org, robert.moore@intel.com, viresh.kumar@linaro.org,
 mario.limonciello@amd.com, gautham.shenoy@amd.com, ray.huang@amd.com,
 pierre.gondois@arm.com
Cc: acpica-devel@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linuxarm@huawei.com,
 jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com,
 hepeng68@huawei.com, fanghao11@huawei.com
References: <20250113122104.3870673-1-zhenglifeng1@huawei.com>
 <20250113122104.3870673-7-zhenglifeng1@huawei.com>
Content-Language: en-US
From: Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <20250113122104.3870673-7-zhenglifeng1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

I noticed something here just as a user casually browsing the mailing list.

On 1/13/25 6:21 AM, Lifeng Zheng wrote:
> Add sysfs interfaces for CPPC autonomous selection in the cppc_cpufreq
> driver.
> 
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  .../ABI/testing/sysfs-devices-system-cpu      |  54 +++++++++
>  drivers/cpufreq/cppc_cpufreq.c                | 109 ++++++++++++++++++
>  2 files changed, 163 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 206079d3bd5b..3d87c3bb3fe2 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -268,6 +268,60 @@ Description:	Discover CPUs in the same CPU frequency coordination domain
>  		This file is only present if the acpi-cpufreq or the cppc-cpufreq
>  		drivers are in use.
>  

[...snip...]

> +What:		/sys/devices/system/cpu/cpuX/cpufreq/energy_perf
> +Date:		October 2024
> +Contact:	linux-pm@vger.kernel.org
> +Description:	Energy performance preference
> +
> +		Read/write an 8-bit integer from/to this file. This file
> +		represents a range of values from 0 (performance preference) to
> +		0xFF (energy efficiency preference) that influences the rate of
> +		performance increase/decrease and the result of the hardware's
> +		energy efficiency and performance optimization policies.
> +
> +		Writing to this file only has meaning when Autonomous Selection is
> +		enabled.
> +
> +		This file only presents if the cppc-cpufreq driver is in use.

In intel_pstate driver, there is file with near-identical semantics:

/sys/devices/system/cpu/cpuX/cpufreq/energy_performance_preference

It also accepts a few string arguments and converts them to integers.

Perhaps the same name should be used, and the semantics made exactly
identical, and then it could be documented as present for either
cppc_cpufreq OR intel_pstate?

I think would be more elegant if userspace tooling could Just Work with
either driver.

One might object that the frequency selection behavior that results from
any particular value of the register itself might be different, but they
are *already* different between Intel's P and E-cores in the same CPU
package. (Ugh.)

--
Thanks,
Russell


