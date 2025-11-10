Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C37930748A
	for <acpica-devel@lists.linux.dev>; Mon, 10 Nov 2025 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772181; cv=none; b=I2CkN8PSLZuBY80bKlNh6eomPvU4Ln4nL1ork8+tMNYpIc7OfJUkPw6h31vmt847DHUXwnTWl2PaVXgV+53V2dypBLwwaVDFm3o/x6FABhzRAw5jOMM8cHchxJkpl+32u4Kn7LjOVC+kI36iBK0/J7kmy9nV+0LbBAbA/ZUpkf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772181; c=relaxed/simple;
	bh=dEl+crxWx0Ue6Eap9IyJQOsh+WWdfuIJZKBgNUUOskU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bK4nsf/JCJ92yZ/jFM1AO29DqaH4Ku5BKGkCUegl5r5e/KJU0I45lbO5szCc4KpesprAT/MhYDQJtBzJYQyaxLqnZI7UBh1enCJk5z093RegeG6VIPeqoOo2qklkYUx9X8xvi8ex9ljSjz2JaeuI8oS3B/nvdepO/YXY5n468sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xPdiQjkS; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xPdiQjkS"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b99dc8f439cso1212172a12.0
        for <acpica-devel@lists.linux.dev>; Mon, 10 Nov 2025 02:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762772178; x=1763376978; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HOTgQEUB8GcmpUQcmIkml8fFvXO2yWgEKzXQF7vCTcc=;
        b=xPdiQjkSpBUcw6KUEisbhtOQlsEYzyk8pAL4yKkadKnaKcrfyR+Fzh3gKV8bqs2y0/
         6m0633zvYRXSxyKFvU884GyiscRrE2/iywJBeUojhFgogu/pK0wg/FU54U45s9EW0Vlu
         +akE0PeNS+qu6mPtTzqXmKkK5Tv7xKRYHrprMfNXsjUT3WYU4nappQwT7xzLm/mxfmT9
         AF8DoGzEkCr6M/C6amh3+9NGWJhG3MA+Oui3sR11xSzARakE2KSYONkC2YJcIyzvX7TX
         q5kPFX4DrvaDv8SOEmryhwfwWbfmDpoL1aU2Fv61djwlAMoyUyFpagOACZqylH+aHLGp
         g/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762772178; x=1763376978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOTgQEUB8GcmpUQcmIkml8fFvXO2yWgEKzXQF7vCTcc=;
        b=oQ/5LvLrCOn6s6jeWtIeI9FkcWR3I/g+edbpseWFYfCZgNs36CkK+G6Ea9+YXDQDxI
         B5mQH6HZbpcvjXgG4wXh5BhMDHOK1w3OK7AHA+R5YOKS3RstLjCvwyw4P50klA2HgrJ4
         noyu0mlpMEBizsMoS4LZtVIHJ4ERZKMID3F0Cis1hRUbUUTSdRvbrmx8u6Tmeymq4sDP
         XcQ/J+RXd/jw6ocwkS0izcuRBhUnNFOgTc1UZzCOQhiBKKW+bchLS92ZlOj2oBEaAPNh
         5yIXJn85IDBs93lYxlXvPvmkphukTOBK0MHvjsdAQNqFgVqzgk7f212LIKW+qK/Mo14v
         THFA==
X-Forwarded-Encrypted: i=1; AJvYcCUY2l2E36iYp2MTwszHRWPORtJDCp7q1lPM4nLLKSu20qwzNGT3Pdy5Gyc1bf/LlLmIChQtq16iicKa8gs=@lists.linux.dev
X-Gm-Message-State: AOJu0YxN3kfxnt8FdGtzlA9bcP6KLBu0vUykfHtDXn1EfpZxyRgdvB2C
	I6HAH/NYjMUSbSJ9lP/bGakHk4NpwAUITC6p/gTQE21pd24hpsMesEsFTH/xwdEAtew=
X-Gm-Gg: ASbGncuyJOAiFVzfVt2RcPaiqhw2S5FnyTX25OVW3d27eDT8z+5pxuG8pdNWu2kuA9S
	ked8RQXiGeIZnTul7A8FciNj71K+NEuD0lnhPram93smak2R5R+1t8nqX/QJptIAu4V5dAtbny+
	ybjffm1JIQzOivaL8ARp+JkE/PuuDlIa2ufmcGTobmDBymSKv8eKz/j+btpeD2Z9V11+I6+8EWl
	wKreQGmZmoAiHhC6i1miHRvUVf5D4lqJI4Y1TlnX7c5ulpmjwTXEgtn7xIB+Zrq04OLNK5YjfDy
	l7Dto4YKt2bbZBTj6GGwEMx7SZOtI3hyS70mV1PfX86TW4X4pgqEAKdW5ehMzZhr84ug5sbLuTN
	fjAMkULKFThpk0bBKYHsYzA6Lckb1CEDG+8eHxUuLs8sqCiUCoPsyXY/XurrQAjsD93GmSFJMJA
	OJPdJ8t8E5bHk=
X-Google-Smtp-Source: AGHT+IELCZjjS9db2GOOi5gG1D3fReIWK6Fsulo/YaMjMnn+TlgjP5Y2DF6HQCR7hzQBYtF9UG4Urg==
X-Received: by 2002:a17:902:d551:b0:27e:ec72:f6d with SMTP id d9443c01a7336-297e53e7af3mr99902655ad.11.1762772178225;
        Mon, 10 Nov 2025 02:56:18 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297fe688c96sm49938925ad.58.2025.11.10.02.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:56:17 -0800 (PST)
Date: Mon, 10 Nov 2025 16:26:15 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sumit Gupta <sumitg@nvidia.com>
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com, 
	corbet@lwn.net, pierre.gondois@arm.com, zhenglifeng1@huawei.com, 
	rdunlap@infradead.org, ray.huang@amd.com, gautham.shenoy@amd.com, 
	mario.limonciello@amd.com, perry.yuan@amd.com, ionela.voinescu@arm.com, 
	zhanjie9@hisilicon.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com, 
	ksitaraman@nvidia.com, sanjayc@nvidia.com, nhartman@nvidia.com, bbasu@nvidia.com
Subject: Re: [PATCH v4 1/8] cpufreq: CPPC: Add generic helpers for sysfs
 show/store
Message-ID: <s5xt53i6c5wryje5x6zlq75r3lx6nxb7pat6umnghpnldi4p2h@jaeew4iimdd3>
References: <20251105113844.4086250-1-sumitg@nvidia.com>
 <20251105113844.4086250-2-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105113844.4086250-2-sumitg@nvidia.com>

On 05-11-25, 17:08, Sumit Gupta wrote:
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> -static ssize_t show_auto_act_window(struct cpufreq_policy *policy, char *buf)
> +static ssize_t cppc_cpufreq_sysfs_show_u64(unsigned int cpu, int (*get_func)(int, u64 *), char *buf)
>  {
>  	u64 val;
> -	int ret;
> -
> -	ret = cppc_get_auto_act_window(policy->cpu, &val);
> +	int ret = get_func(cpu, &val);

Why no casting required here, when you need it ... 

> -static ssize_t store_auto_act_window(struct cpufreq_policy *policy,
> -				     const char *buf, size_t count)
> +static ssize_t cppc_cpufreq_sysfs_store_u64(unsigned int cpu, int (*set_func)(int, u64),
> +					    const char *buf, size_t count)
>  {
> -	u64 usec;
> +	u64 val;
>  	int ret;
>  
> -	ret = kstrtou64(buf, 0, &usec);
> +	ret = kstrtou64(buf, 0, &val);
>  	if (ret)
>  		return ret;
>  
> -	ret = cppc_set_auto_act_window(policy->cpu, usec);
> -	if (ret)
> -		return ret;
> +	ret = set_func((int)cpu, val);

... here ?

-- 
viresh
