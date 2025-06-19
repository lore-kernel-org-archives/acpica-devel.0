Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F94242D7C
	for <acpica-devel@lists.linux.dev>; Thu, 19 Jun 2025 05:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750312015; cv=none; b=Z6L4eiWi74FzL2PK2AoqQihAWOQ1sr4pDOI7+a5CQugSM6TfTgy9OFMA7HKes7Hev5tA3LFkQWUqHfa9q2qq79jJp9uHMt4qCvKxcj3TBqxD1Lr55KwsQ7evtrMtDbrbJIzEW1Jl5KJLav+9zB+xpQ+kVDwHtJvgqzOqpGklZVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750312015; c=relaxed/simple;
	bh=Bn70nPJu3HUp/M+KYcLviCtpjLHOrJf1pcJLvrjQ/Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5JKJHBabdYAKTpLJkzETXuZDs4leZxhABQA96jRPTaIkqbj4QmpwzTDITsp4+1DKdfzft7eCFmVqZgsSawYcRyNnghogSSERm1KBfbeORl0jLjLBr5LGZoPpD1csnJqFb+z49SdPV0sOxJTNf5XteTKP1Vw9QXdxZmZnJAoAUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v2Nd2COm; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v2Nd2COm"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7426c44e014so313370b3a.3
        for <acpica-devel@lists.linux.dev>; Wed, 18 Jun 2025 22:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750312013; x=1750916813; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L1Xvm2/dcHJBRt7NYvlZ+VTR+ErXbR50l14mI16oEhY=;
        b=v2Nd2COm8lE9J5boVm4yPy4P0dklM74igy/F4y7sEJ9V0At7rqb/KuQ9g3nF+360bm
         bUs9CQmgNDcZu1wnZ+x9rix2JXrPqFu6rgDCsFmJsEhEoX0RYq97BRnzRlwupDQfr+33
         nyNF7XnMqmYC8WvjQ+CTNotTE4r/btznlvpychviur+EMsMG6ATPp8QuC6snO+godNvO
         slNQG/VGuyfvvnGOKWbz3eE52fMW27Yp8rJ+oj3QD/L+wS3YdqtgEdezg2dlXpOQIgWK
         GW8TD8O+Yx7wmxe8qA+CyvsRXBqHHvuS6k2L2skcqbO1BGvHMQPrFF/0MEq8T6csU51m
         xctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750312013; x=1750916813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1Xvm2/dcHJBRt7NYvlZ+VTR+ErXbR50l14mI16oEhY=;
        b=plPOKk6RWpd0m3WxjfQdu9VvNygc0ma6PkBqPS2gq7Ue5FKfXgh7M+uGS8w/vGrj3d
         6bb1hSVLYQFHebLvWis71FSqpsa5BG1zoInTZPP8VF4e5h75ST8ih49r1XcVBi1xjpkb
         /5BpUuGviqxHa7idjNsBzAPw1eg5NIH66DrgFPP3v94jM2SMaUG3OxIvy3H1IduUuB3d
         3Kv9CV/pLeFtC50VMWJSkTebM1JHLF+AkI+TlvKQ33QshYKubh2xt+HUgZtiN95QAoyW
         trTDlqL0r2XADppZukzAErB7xaeq7/c67H1P1WAs+SJeW0DOdkFEc9aeKOtXprcgYXew
         O9Mw==
X-Forwarded-Encrypted: i=1; AJvYcCU2WF6hFG4DsfBv9Sdlm8bFhQ2ExjYW8XEdt0i0YayHUiDwZBbKjKTcUoPnRETVvL7YwyRN38s2i2pve00=@lists.linux.dev
X-Gm-Message-State: AOJu0YwLL/2iWvRB5dtb8ke4uP6u1WOQ9lNDpM2trA1wQ/JWMKyv5SZP
	feKZ3vOcgwABsAXh+PRtf+ZoNpttZtUZT7Jxfy8CVeaMGnvepvd85En2mi5lVAV3NJlPGwf4OZ+
	YM5Nc
X-Gm-Gg: ASbGncsqQKjgd5IUj1rseP6l9rDzrBPRGDGHihbt5eiVN8sI1F+U/LlHYe/h7J2sQ1b
	cdQmdkya0RUPPAZFS5HadstRF7BJGcZfi3tjLVmLjaG/UYK3LrPIO9CrKxF221iCnutHXrJq8bc
	U+6iFHS3BZKYIkf7KV+hv5QgAnEcPH1WvAU4/bCJqpwcKyyuZ9W+AmJNBjtJfsebLj9Y1+Ehb+2
	MXwLIoE/x7jR2rz0V9jhS9HRZSmoedcecciLeIe1PsvV5m1TRpIDgdx20fZwBC+XfHat72RbuHd
	3a/gIJaQAQvFIuGPveIxMBAWo3W0SB5iYBNhFXITD/S4xd086xKOQgPB+zDMNRU=
X-Google-Smtp-Source: AGHT+IGx25UdEAzlmqfQKTPAu3rI0FpfbMxJfPd/PkIc3VTClQaEGNZW5YGAM1Nh7zWb+auXSU7+sw==
X-Received: by 2002:a05:6a00:10d2:b0:748:fd94:e62a with SMTP id d2e1a72fcca58-748fd94edb7mr1182029b3a.1.1750312013191;
        Wed, 18 Jun 2025 22:46:53 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748e86b5527sm2820713b3a.86.2025.06.18.22.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 22:46:52 -0700 (PDT)
Date: Thu, 19 Jun 2025 11:16:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, robert.moore@intel.com, lenb@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	linuxarm@huawei.com, jonathan.cameron@huawei.com,
	zhanjie9@hisilicon.com, lihuisong@huawei.com,
	cenxinghai@h-partners.com, yubowen8@huawei.com
Subject: Re: [PATCH 0/3] cpufreq: CPPC: Some optimizations for cppc_cpufreq.c.
Message-ID: <20250619054650.pl5ase2l5juu5pm2@vireshk-i7>
References: <20250526113057.3086513-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526113057.3086513-1-zhenglifeng1@huawei.com>

On 26-05-25, 19:30, Lifeng Zheng wrote:
> This patch series makes some minor optimizations for cppc_cpufreq.c to
> makes codes cleaner.
> 
> Lifeng Zheng (3):
>   cpufreq: CPPC: Remove cpu_data_list
>   cpufreq: CPPC: Return void in populate_efficiency_class()
>   cpufreq: CPPC: Remove forward declaration of
>     cppc_cpufreq_register_em()
> 
>  drivers/cpufreq/cppc_cpufreq.c | 59 +++++++++-------------------------
>  include/acpi/cppc_acpi.h       |  1 -
>  2 files changed, 15 insertions(+), 45 deletions(-)

Applied. Thanks.

-- 
viresh
