Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7772EBB9C
	for <acpica-devel@lists.linux.dev>; Mon, 10 Nov 2025 11:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772458; cv=none; b=ne5eemFiLsguEtlloUnyFLUbif50VL2QO986sFNs0tZkyIOwlALxdsjuPS3TzOqwWoz1zwEK1igJsFxG4b4fr/Uvz7/dj5AtHnSdNsD+ew3opvkFVD/69/U5x6K/e7wXIWvz2LRZ4cyilgmPrKt4iJiVjNlQ6+KmZaMIWsXZbN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772458; c=relaxed/simple;
	bh=j/sDhA1BE/crBk5MB3jz5Gyqsa0mwcEpYJuOnY+51Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZBcHE4xawL2Ct+JBnjZRPy29MzUFZ+fJOxva2wtWRUXF/obBga8ybnnD0d/3vEDUMO2rJA9U7OUmg4ZaKgvu1MSjJilYhBYS38S9+L2QjMwMZH+eIRKRSmXetoWwbYoz8fFLfI8eS2UfqcwMzF+5nTf7cJXhIQDO9OPJgrhPEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bl41rIFH; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bl41rIFH"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-782e93932ffso2321410b3a.3
        for <acpica-devel@lists.linux.dev>; Mon, 10 Nov 2025 03:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762772455; x=1763377255; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YrIRy6Lhq+4eE5yPFjSN9IOBDP8Cyczj9KXwJvvJFlc=;
        b=Bl41rIFH3q8TJW5AGkYQgaoqHB6qrzMsM9tr+HYJWM+w03C4V+hQkOzAK5/neQ3qhX
         4HxPNnRvHw1PJR0PVrcGuuW7JHq8hcXuDeXSwKBKDVZ6HBjdvZ+iXUhR922Gg1d739no
         LiCpayj+kCMNateJWLix6fwke1eFNb5vx5GbYYe3edz2P1VKyGexv8RPSBXp9ozoyPKP
         QOOBLiuV8UDCm+pyQ/lMSZl34q+HAVal1JQ8l/0Gjp7VGvNv+kpXaNaEM09N5ihYXEoS
         4TBn9iBk2EBKpP2ET6/OU4v8pdlDrtp0zGBsfI7MnDLMFIf9eJosP0XrQ+08Os+iCw5e
         Umtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762772455; x=1763377255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YrIRy6Lhq+4eE5yPFjSN9IOBDP8Cyczj9KXwJvvJFlc=;
        b=eucsn9X6ISKxNmBogLPcpYdyqA3AkAbZoHi5k27s3cfyFPn+vKi5JtJ7HNwFLKfAI+
         qWVMVpNEEQACd82J8f9lIDyO0dUPQUiL5aApQd7LhZybBlwVLZkfTExVynTgvE48MzJJ
         cW/ein8iYzZ2ZLNOK8c6v6g6am9BVzy+8Vrh8m/aGlwGqa+V/KcFcARUj44yosnq3GU0
         3DipaE1NdFonYjaSldbfw6mZXCHcD84aqE8WfIoJAhqYtxV7RVHzkvQEBBYegIZV1Frx
         s2ym3I6kt4Ga9lfNVYEb2ddGcq3BEc3dzU2vGh+U5v4T5qbT/xEfUFy+yziARO2DgCUl
         PpUg==
X-Forwarded-Encrypted: i=1; AJvYcCX7ZBurUvRRDuZ5ZQiX8hUGC+vTeYLgfJchZLfLhweQBMup6q31tjBQbYZV4589ds1vUNJmWv4Hu1q/XLE=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywh7Y3DSGkPmGLbzwyyuMpNTugoBeg5YKk6B2OYZ/LzTwrRnP32
	KFhJt8/feVx4+/PgaTK76wGKq0+CgS3Hg+dyVGG7m8d2L0I8DYITQrh/U9we9vC14Qs=
X-Gm-Gg: ASbGnctzvgGf1smOZJPuZvsz7BVyxYGsaT8NpwHz2LyWf8V73BqW3w2FFVY1zevDXHU
	jV5OZj7kcE0q7aal6LG6pO258qoTAVweofJoj+FIT7FeqjQNzGaMz0jHhqT/x3sg11dlGbeMQQG
	lbEeb2tce+9hvvHaoiHPnbop+n+c4hKfwQjEMhO77Nn89zGnNuM3GW4dcihNEer/TzcuAEw4xJW
	gFgxnETnajPEbuJHttXO0Hravbngdy8aOJRkBCp9ZcQHoIg44Kcd7g8G5itVcVk/ytzPR3TNnNc
	2FzI1VHYPSpgEDdgMuYhaY9HJycoR0NhOSoDk09znsGGDzn3rYrWC3qs2xIKnBtCVzpPls2EYBw
	6AKu/uM6+XJc3cX4mYfqBZsG4eRMkQ866j2VuPHsupbymXD5Dp+oFrYE/ek7QwPAZIWyr+Fs8aD
	Euness8GV/7Z0=
X-Google-Smtp-Source: AGHT+IGOFDbu7mquDmNhSqV97BdY6cG6MLgvb5Xp7QodBHXn8La7j+gNEL/xmdVl7cozIyrmwIAy9g==
X-Received: by 2002:a05:6a21:3291:b0:350:1872:7023 with SMTP id adf61e73a8af0-353a4163b2bmr9937463637.55.1762772455121;
        Mon, 10 Nov 2025 03:00:55 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c963586fsm11304602b3a.10.2025.11.10.03.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 03:00:54 -0800 (PST)
Date: Mon, 10 Nov 2025 16:30:52 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sumit Gupta <sumitg@nvidia.com>, pierre.gondois@arm.com, 
	zhanjie9@hisilicon.com, ionela.voinescu@arm.com, beata.michalska@arm.com
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com, 
	corbet@lwn.net, zhenglifeng1@huawei.com, rdunlap@infradead.org, 
	ray.huang@amd.com, gautham.shenoy@amd.com, mario.limonciello@amd.com, 
	perry.yuan@amd.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com, 
	ksitaraman@nvidia.com, sanjayc@nvidia.com, nhartman@nvidia.com, bbasu@nvidia.com
Subject: Re: [PATCH v4 0/8] Enhanced autonomous selection and improvements
Message-ID: <hjrcoq7dapqcodk3iiyvjeuq3cwvyccqr4wnlcoi6eduqg5ahf@tszrjvfnkjux>
References: <20251105113844.4086250-1-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105113844.4086250-1-sumitg@nvidia.com>

On 05-11-25, 17:08, Sumit Gupta wrote:
> This patch series enhances the ACPI CPPC CPUFREQ driver with
> comprehensive support for autonomous performance selection, expanded
> runtime control interfaces and improvements.
> 
> It adds support for below:
> - Expose sysfs to read/write the Minimum/Maximum Performance Registers
>   using frequency (kHz), with internal conversion to performance values.
>   Also, update the policy min/max accordingly.
>     /sys/.../cpufreq/policy*/min_perf and max_perf
> 
> - Expose sysfs to read/write the Performance Limited Register.
>     /sys/.../cpufreq/policy*/perf_limited
> 
> - When toggling autonomous selection, synchronize the policy limits
>   by updating the policy min/max.
> 
> - System-wide autonomous mode configuration via 'auto_sel_mode' boot
>   parameter. Mode can be switched dynamically on individual CPUs.
> 
> - Generic sysfs helper functions to reduce code duplication.
> 
> The patches are grouped as below:
> - Patch 1, 2 & 3: Improvements. Can be applied independently.
> - Patch 4: Sysfs to update min/max_perf. Can be applied independently.
> - Patch 5: Sysfs to update perf_limited. Can be applied independently.
> - Patch 6: add sysfs documentation. Depends on 'Patch 4 and 5'.
> - Patch 7: sync policy min/max with auto_select. Depends on 'Patch 4'.
> - Patch 8: Boot Parameter Support. Depends on 'Patch 4 and 7'.

Beata/Ionela/Jie, any feedback on the CPPC changes ?

-- 
viresh
