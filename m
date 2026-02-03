Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BE9257824
	for <acpica-devel@lists.linux.dev>; Tue,  3 Feb 2026 01:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770082580; cv=none; b=kXuSIa2MlWd7s+//zX/fS0VEObDsJjvaCmjU/WzaMwaQbRHapAQMbdUIIBI3FLOi81/WaFRTMCjmhxS71g3sIqouZn4ZyAJTLAqGU9qHMjHgsvz6/kgK0q+Zu1HDvibUxP4pU3BbbI0pYb4hwVSCEzObD80uj0KwLoLPM1WV4Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770082580; c=relaxed/simple;
	bh=2X+mytXBtNSV0apIC0KsjvAvt2VlH2ZbcBkfrYklwOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqUlADEWIdsnCQbvSFnwb5PgC6Y24d8WqtMRsXBdKrUPpUXmYgKc8vfVEyBTtCfcZT4RaA8xJVyvEezTKnrGWSAQ7uHmnj6YoEaNB+0n4vd915w/f8U6pZuFu4XD7XlK6OERgehBBOtOLNznmYC9Oq4YrOkPMqV3epbb+pGRBrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FK830q6o; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FK830q6o"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-649ba412cd4so2088639d50.0
        for <acpica-devel@lists.linux.dev>; Mon, 02 Feb 2026 17:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770082578; x=1770687378; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IDGINNniODK4Zc3R8bth6pqq7qdppNjLL1gm7R6GyLM=;
        b=FK830q6oz0MiWVLt8Pd7XNzetS2DCj0IqpG0X9dohfA555oZlwwabxJXidUMzdz324
         m6NzYt5g22dw9/l9uMrXoxm/A/5zi6BA1q67fJTDXr2V7rt3VJlm+/VbUKqOXSa3J3ut
         SZW9qKlteW6rc9Auwbo512oDz+3H/HNSMh4sTwDBpPzsvQgjStNp2VLFUyvKnuTo/jf9
         dHBPmOvYQGfPagtRT0zV8vNygWZUvUAPMa0Le5UtjERMbRSbCWKc7Y5fI8+wVycumy2B
         sAFXEQ7eRj+bi6IZmfqDYLgzs3uBKoBI3oudhoNF6a9LQ98S3mJxDNvwY/poS2rOtDQx
         +N0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770082578; x=1770687378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IDGINNniODK4Zc3R8bth6pqq7qdppNjLL1gm7R6GyLM=;
        b=JYBbspv60grG/NBLhv967TKzWrCqVwDQzc2ME0lb72hbRYWcO4L7yNOxvj1g5jRvxd
         vi2wzGA3sJQVY4gYY+F1KrceXBroKocBwpiFQlyMzNAW/vxAZQK21SfNGv/0CMqQfjhK
         jstr2RFcJCY5tPr729fRspbvX9Fn2iR4xiw3OYTyTBA+VPaBQLoTLiETZ2xUQ4oU13FA
         UKkYh9CU9nWKIGJ62xFt915tctivLmVmzcebPIqrG2MVkIP/acEA03LDO6WjlcXT15Pt
         3mP0jFlhfbZRD9wuIgD9aD+j3ydlVe/8W2iYz7UkW3tO9Doq3Fn1gIJXftp1cdbgjag8
         HqMw==
X-Forwarded-Encrypted: i=1; AJvYcCX+mQlpFODxvRD8KeB36ZvyF/lgDmQFOSG859pZz2PnciUv6pM9pPfeQfsZ0itLyHYn8001MT+tO5o33Cw=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxtc0ZLmL0xDfKMbt2n2XhlFRCQwrZqOs4Fnzp3ChsJqCQpgJPJ
	tKFopUhAEA6cDQlHcm30LAX/B45kEpoR9U/WXTwCfCx1lG81QE0SqE9Q
X-Gm-Gg: AZuq6aLoc2LrVMiBehh5wQc2w5IwI3icIARKqdddzXEecb2u7yCmrXV0gWMEHd+XNPH
	8ivNcNKPZlXQAeaG6+zHqsdeCtMiUdQ4W3RZW9sgCtxaEsGtsmclKbwUN4/Uo2aus4yRnHD8pKu
	MvrsZcLdUPW9Y8DgZNV7fprboCHlImGQPcvfKN8my/55zvFJGwjaU2Tzj0j2CBYW22ZQt6CZa3d
	zdHIjmKkg/8myoxkBxKWR89F/EDfdbmanK3KP9u2iyV7tB+eRDGns17o7Wth4Suz1kSmqs9Gz1R
	4sR4D7rHHC/PPIGPZtX7uB3WleHCNQyQcsqYes73y2kJfo6x2iS4zIBKQ8qvg9aerLNItI1rMcJ
	SS/cXPfN8TB8x1LvX/UhEb2TUq+IW+6pd3l1bc3uO/DCibOjuEuO7kQxuua0MeFwTAqrU5tVDqv
	h4E34WJX4e7/h1fhhNwEVj9KbcKl6RlL2cAUE4UQ==
X-Received: by 2002:a05:690e:408e:b0:649:523d:e701 with SMTP id 956f58d0204a3-649a852de09mr10271339d50.92.1770082578400;
        Mon, 02 Feb 2026 17:36:18 -0800 (PST)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id 956f58d0204a3-649d447df2bsm423325d50.4.2026.02.02.17.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 17:36:17 -0800 (PST)
Message-ID: <74f3e6cf-7c13-43e6-a8f6-2b46184b8ad6@gmail.com>
Date: Mon, 2 Feb 2026 19:36:14 -0600
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/7] ACPI: CPPC: add APIs and sysfs interface for
 min/max_perf
To: Sumit Gupta <sumitg@nvidia.com>, "zhenglifeng (A)"
 <zhenglifeng1@huawei.com>, pierre.gondois@arm.com
Cc: rafael@kernel.org, viresh.kumar@linaro.org, ionela.voinescu@arm.com,
 lenb@kernel.org, robert.moore@intel.com, corbet@lwn.net,
 rdunlap@infradead.org, ray.huang@amd.com, gautham.shenoy@amd.com,
 mario.limonciello@amd.com, perry.yuan@amd.com, zhanjie9@hisilicon.com,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, nhartman@nvidia.com,
 bbasu@nvidia.com
References: <20260129104817.3752340-1-sumitg@nvidia.com>
 <20260129104817.3752340-5-sumitg@nvidia.com>
 <4432fa04-e67c-422a-aae4-2938be431985@huawei.com>
 <c96312c7-b13f-4f5c-9512-cc0382c1c77b@nvidia.com>
Content-Language: en-US
From: Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <c96312c7-b13f-4f5c-9512-cc0382c1c77b@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/31/26 7:58 AM, Sumit Gupta wrote:
> 
> On 31/01/26 09:36, zhenglifeng (A) wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Hi Sumit,
>>
>> I am thinking that maybe it is better to call these two sysfs interface
>> 'min_freq' and 'max_freq' as users read and write khz instead of raw
>> value.
> 
> Thanks for the suggestion.
> Kept min_perf/max_perf to match the CPPC register names
> (MIN_PERF/MAX_PERF), making it clear to users familiar with
> CPPC what's being controlled.
> The kHz unit is documented in the ABI.
> 
> Thank you,
> Sumit Gupta

On my x86 machine with kernel 6.18.5, the kernel is exposing raw values:

> grep . /sys/devices/system/cpu/cpu0/acpi_cppc/*
/sys/devices/system/cpu/cpu0/acpi_cppc/feedback_ctrs:ref:342904018856568
del:437439724183386
/sys/devices/system/cpu/cpu0/acpi_cppc/guaranteed_perf:63
/sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf:88
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq:0
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_nonlinear_perf:36
/sys/devices/system/cpu/cpu0/acpi_cppc/lowest_perf:1
/sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq:3900
/sys/devices/system/cpu/cpu0/acpi_cppc/nominal_perf:62
/sys/devices/system/cpu/cpu0/acpi_cppc/reference_perf:62
/sys/devices/system/cpu/cpu0/acpi_cppc/wraparound_time:18446744073709551615

It would be surprising for a nearby sysfs interface with very similar
names to use kHz instead.

Thanks,

Russell Haley
