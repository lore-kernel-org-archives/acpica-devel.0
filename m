Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D5E1F4E27
	for <acpica-devel@lists.linux.dev>; Tue, 11 Feb 2025 10:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739270674; cv=none; b=nOsQ34yzPod/Q0iqghjbuLgBDboTiy2pKPEjzL04+SOyIDV5ULRDVFlv8ihEVHN+X+jo7l0VLrbTq4Azb/IKggi9ZhQXxKdYDj2tnfAn6PPPH9cvf/oOgeP2KpIGSJinbcLc6zAWpKwNF9SVFPfpmh+Afwx4yhAVEPUqUo7wQ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739270674; c=relaxed/simple;
	bh=lyQGPOiFZfI8iuJQWeJ/ZTEHobti30YMVFPeLxYKCIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emVpIzK+QMR20OJWEaJJ93olKmgsr3AV778+TkBKGVcv0Gy2HtuSD/cBS9gHgKErhuIo5velKAZKw3SyMmQq8AsKHfvvzqJal/KThn4feOfV6He1iiDFYk2pvNkVtvliiKSH9QLUr9ZLtYSvx1NfPoGVL/UPFXE0abDg/TwT+qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VxuTA8IV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VxuTA8IV"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f2339dcfdso84315255ad.1
        for <acpica-devel@lists.linux.dev>; Tue, 11 Feb 2025 02:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739270671; x=1739875471; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KGyAcIVzwdxp3SxUx+rEML92I4jzvu6KhWaUMgM+hIg=;
        b=VxuTA8IVhjfuuV+Nmj2eySiRCwkcYm5p4Q8TJdUVx1UavcR8nYCZAQTIbSr1izCEXg
         ZJ7sIGXicaJ882w/80J3UBF1gz7pi5RZpWa1tpanUHCTRMreeRkhvAwsoHZAHGPaqjCc
         g1nJIPTSmDzuXoHkGBfCo6JINvRq4oF2VXQCnluFM6M8mqXHzeQS4HC+5lB6m1DVtaYX
         uJn+Hs579Ku0+zV8GRZ5PsIBhkWI/fGabWxQBqNIJXfwfoqc4MAf93nLpHL6nsqXoyCj
         VDkQbRUDII+0CmL4PefANMpDdVeQkjMr6x6FLoNEMT9q21KaqdQMYgk1nqgXKHgDd5j4
         cEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739270671; x=1739875471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGyAcIVzwdxp3SxUx+rEML92I4jzvu6KhWaUMgM+hIg=;
        b=K2va2U/8oOVNp6QFPoTe398a+kM01xNSw3yWJQIAmfdMd1xw2Ebw/B/UBnmO7eIYPZ
         tApD4oFeovAvpWYPx1m4qOGM2w9ugyhBTiNeZ9+Ha/VugZZzt2tFpb2K8UMgvNrjdFFY
         HCuhu1d4Janu/RGVeBh9Iibru6GASsmR0wR8KzEgODhXBnxK/8Ws8++YwKLXpnHUAAf/
         9VOWjD1woflcWCmuOKHsIS00APt9qcVbKLjliwY8esAoXtj0WUrbmriVZVIo2Mk8D+rv
         tp07iv0+A4BjZko+ycCyshz8x6+8HBGL7J2pZBvWPndQDKqdfitV7qtFnzk68P0dSxaD
         LBtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUihtHdVvZymJ2h5nd/8QhP9d3p6i5uE1LrO+aMDI4qH6nm17u0tp52QfZi4B9Msoypub8h/0qDLKlDmY=@lists.linux.dev
X-Gm-Message-State: AOJu0YyqzaLLIPtylUEaO/Rh5rmPKjEgOXIV539WNWlXt9zl54WKfg20
	GcnYn1DDmxTUK/fwbBCBDqdPcFFjdoXJHlm38nYZ8sp7zEuHlSVmEb9l5UAM6kU=
X-Gm-Gg: ASbGnctw7GXqoluvc990ylcrTtKqh+6nxrrRZwnUSdy/J2k1g293UVSqRZ9ypqCHSfD
	pAOgrgYxl7Fc01XMHKPthgrLyvXRIRljF9GN2X+QlTW1U0P+y0OPEhDhWYzRa8sqiy/5xT/zI3x
	f9/pNDNfmkzdkEfX6qme3BMNFZ8/kpitGC10c2hpFz7xAzOVs/M8vp6Uh0l0maxVGTy5SfzYKUs
	6A5g+PhaLkssi6X9OgWUhWF1uHU+if982JRdBdUh3dA8/T3+h0/GRItTg6rGCBRf6l3JlSrgTiK
	T92ulfIvpLRrbDBJAA==
X-Google-Smtp-Source: AGHT+IFkGzG5Hx5dxP8FNIuWUPeK9ACiFX9V+SrVY6ss/7yixFEmLNDBn5grfGl0BrfxDpYTkhCtJQ==
X-Received: by 2002:a17:902:f641:b0:215:9eac:1857 with SMTP id d9443c01a7336-21fb6bf622fmr47511905ad.5.1739270671078;
        Tue, 11 Feb 2025 02:44:31 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa618e5e18sm5506354a91.41.2025.02.11.02.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 02:44:30 -0800 (PST)
Date: Tue, 11 Feb 2025 16:14:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sumit Gupta <sumitg@nvidia.com>, Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
	corbet@lwn.net, linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, treding@nvidia.com,
	jonathanh@nvidia.com, sashal@nvidia.com, vsethi@nvidia.com,
	ksitaraman@nvidia.com, sanjayc@nvidia.com, bbasu@nvidia.com
Subject: Re: [Patch 0/5] Support Autonomous Selection mode in cppc_cpufreq
Message-ID: <20250211104428.dibsnxmkiluzixvz@vireshk-i7>
References: <20250211103737.447704-1-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211103737.447704-1-sumitg@nvidia.com>

On 11-02-25, 16:07, Sumit Gupta wrote:
> This patchset supports the Autonomous Performance Level Selection mode
> in the cppc_cpufreq driver. The feature is part of the existing CPPC
> specification and already present in Intel and AMD specific pstate
> cpufreq drivers. The patchset adds the support in generic acpi cppc
> cpufreq driver.

Is there an overlap with:

https://lore.kernel.org/all/20250206131428.3261578-1-zhenglifeng1@huawei.com/

?

> It adds a new 'cppc_cpufreq_epp' instance of the 'cppc_cpufreq' driver
> for supporting the Autonomous Performance Level Selection and Energy
> Performance Preference (EPP).
> Autonomous selection will get enabled during boot if 'cppc_auto_sel'
> boot argument is passed or the 'Autonomous Selection Enable' register
> is already set before kernel boot. When enabled, the hardware is
> allowed to autonomously select the CPU frequency within the min and
> max perf boundaries using the Engergy Performance Preference hints.
> The EPP values range from '0x0'(performance preference) to '0xFF'
> (energy efficiency preference).
> 
> It also exposes the acpi_cppc sysfs nodes to update the epp, auto_sel
> and {min|max_perf} registers for changing the hints to hardware for
> Autonomous selection.
> 
> In a followup patch, plan to add support to dynamically switch the
> cpufreq driver instance from 'cppc_cpufreq_epp' to 'cppc_cpufreq' and
> vice-versa without reboot.
> 
> The patches are divided into below groups:
> - Patch [1-2]: Improvements. Can be applied independently.
> - Patch [3-4]: sysfs store nodes for Auto mode. Depend on Patch [1-2].
> - Patch [5]: Support for 'cppc_cpufreq_epp'. Uses a macro from [3].
> 
> Sumit Gupta (5):
>   ACPI: CPPC: add read perf ctrls api and rename few existing
>   ACPI: CPPC: expand macro to create store acpi_cppc sysfs node
>   ACPI: CPPC: support updating epp, auto_sel and {min|max_perf} from
>     sysfs
>   Documentation: ACPI: add autonomous mode ctrls info in cppc_sysfs.txt
>   cpufreq: CPPC: Add cppc_cpufreq_epp instance for Autonomous mode
> 
>  Documentation/admin-guide/acpi/cppc_sysfs.rst |  28 ++
>  .../admin-guide/kernel-parameters.txt         |  11 +
>  drivers/acpi/cppc_acpi.c                      | 311 ++++++++++++++++--
>  drivers/cpufreq/cppc_cpufreq.c                | 260 ++++++++++++++-
>  include/acpi/cppc_acpi.h                      |  19 +-
>  5 files changed, 572 insertions(+), 57 deletions(-)

-- 
viresh
