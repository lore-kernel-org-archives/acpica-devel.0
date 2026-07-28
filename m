Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2298F41D119
	for <acpica-devel@lists.linux.dev>; Tue, 28 Jul 2026 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785245109; cv=none; b=o1jJ7VQmm0lhGMZhmBlXYH54sstZH7EnFSnhnZaJP7+T3XgBEpodJUPjCS93z3CbtMkP6DmbjJGvonqr9nWnq1w4/TFjdV+cccPs1pNtsQaDyqXcOFhTeLAe8Ca/C3kE84x5LcBj03TZV2RZ4xZMUwB3YAywqNE4378E6j7CgFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785245109; c=relaxed/simple;
	bh=AxnBcZ/fTAYNRGKDrrevsDEu3/4MslJ2Oz95DNs+rPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SpLT7Wft7J7vxgNtXAXWAWxLay7jqdAjF7hzG6hKHREoY7xQuJBw+GSz+OBEF52KFUgh11+BAS7ujABuBuQ6aIWMD1fI0NDHp+1C+nthoOGbj0bGIwiegz8DLhBaaMhhLqok7jBwP6spoXHeQq8tC6JmkRg316M6BqSmfEFNyK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WlfJR5hs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kAf73H74; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WlfJR5hs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kAf73H74"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SDOemO2411714
	for <acpica-devel@lists.linux.dev>; Tue, 28 Jul 2026 13:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R5PEfpB9NVCbVrnFwLgb+8nUp0J1gUezJGpi4PwLSEA=; b=WlfJR5hstOdy1nAF
	Ae0zMOh5O5D+JhJ7RqOdRHpSS8GdVbyvNeIAhzQ4+s67QZnwRbBv8rtb00PguLko
	kpOl43rJEkAqbN8dXzXEMLNtA8O6HvzTRn2OpXgxHJ889cGAXKmnYvdXKJ0qb6vP
	xEjKQiOd1Tz2QTb+xwTC5hgPXOg3PrWTsI5PxYkX9pXyRIQvjJ0PBdI2YNoJ0FkX
	aJBStFyHug9lKecZTzVrDGRGb+N1qxTeug246HJyD88/gF78iXE5Fk0bv/myDbQ3
	XSRYJBHalPvB5XJM9jYH9EaDb9n2j6BhpkaVtn0G5K7WyZ11IRVDTLIcXTkRwTF2
	rqNAJA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fppttsts1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <acpica-devel@lists.linux.dev>; Tue, 28 Jul 2026 13:25:07 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e7b87ce77so9237044a91.0
        for <acpica-devel@lists.linux.dev>; Tue, 28 Jul 2026 06:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785245107; x=1785849907; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R5PEfpB9NVCbVrnFwLgb+8nUp0J1gUezJGpi4PwLSEA=;
        b=kAf73H74IFFyk3hoI6EL4gw1kqXHjHUx0KWK9V6GrTvCdi+ru1CVZ1nG9G1EGHay2x
         GG4/K4M89KYGbHsEd497Vm+SA9S4NQfR9pHmzj2WQ3BBeqWuPeytUA7fu0WTmXooRP+V
         jb0Qt67W2nDEkCc69r3Hzin9tNkQE8JmvbTEpMbA10zueocO3dSraLr3k2BNy0ov4myP
         GiS6rUz3ZxwetH+6anhpJWCbyCV5D7sC3nEIq24xXrJ5054ctFQ27D5Az2mkPm76IP9l
         9/Fp1Y86Wn/BRi+QhrBXUEef4rgxbNjIpwENYospIi4yipdPttVs2g2x5VAJqM1N9qxZ
         Q32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785245107; x=1785849907;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R5PEfpB9NVCbVrnFwLgb+8nUp0J1gUezJGpi4PwLSEA=;
        b=h2ViCXyRVdQ8x86QVZkhLJooTXAyqm+NWoZox8bVN8KOTJWOlcfKUuZCMXnZWNFZod
         rx49Lr4s5h2OtNJ7bKpt2JctYphZhP/PsbQU9CIHryKMi7wnX7573QBkMUyTB4fmg5Jz
         aLx2wfc8GYdqVzH8bJaTUll3YNkJSuDQ0+mu3tIgE9iNsw8ysXamqXu8dVeidqdM9GSs
         yJMavx8eMmPGnm7ZAgd3S5SCXJ80k4Op7RM4Wht7Z1/VSlx8rqmvf76G9ihOEWdXC2e6
         1nH+lxrXz6ovKh8iFpwRlsHAtBO0cE50tTey17LRB4ftbEzjv82K38IxvB9E05fdbwcT
         6jQg==
X-Forwarded-Encrypted: i=1; AHgh+RpW6Kii674ODHPZBpopnpiNIpboz5z5yYCWncZPU8CEiNEj24qkIcn+BEYUIbV+hsXmCNhXLz1K5v1cOGE=@lists.linux.dev
X-Gm-Message-State: AOJu0YxICcrEvBRJcsCFKj4XKQZ35vNCIdVSPmDw39fVwTEyN3Gl9Izy
	AkwmDajdFSBzyxbhCCzjwxCea08URtT6+Az8xEGpYDeV/KGI6g/Ft1dqftTehMiSwZpGkj1Lubc
	9h+DgviVHwcs0I3aeiJ0HC0crUSU1vNdpnj9Iv+IdFzDEGOScJWfymbeyPuh79C3BtAw=
X-Gm-Gg: AR+sD12uUdaI+yvWypY051wm811B4WW00B6NHKfjoulbayj88FOmeEPwLddSJlukpZw
	Vz3xB/Z73X5ClhvRepEcfc9j/S6kFXuzOAriloM9zJh7bVMhvBwK3agrRCy0zYAaQceW+nqwMly
	1e7eIdK32rCOOGuFOE+bHMgFD8CnqXdX2lRcHpcXLAjbi5hqnKpLdlPXiO5foAgk7wCJrwKmf+Z
	xcyi7exHbQ5ceFOYv53PAfCwjApVsBpvvveeFJ5TQUi1ynV6+E5z7WuoU8owyg17E/jDTpIM7yF
	CJvxOY4wZAlCbt21wgQXKbfn1x0EC+d1M0kluo5o3/4r0B2/OxXaK5f0KXHlyug3ZnW8ILpNRlh
	IdcTGfVYe1jENG0i0/Rw7DjSUpem9Qg==
X-Received: by 2002:a17:90b:2251:b0:381:792d:f993 with SMTP id 98e67ed59e1d1-38f6a43e810mr2538814a91.17.1785245106499;
        Tue, 28 Jul 2026 06:25:06 -0700 (PDT)
X-Received: by 2002:a17:90b:2251:b0:381:792d:f993 with SMTP id 98e67ed59e1d1-38f6a43e810mr2538769a91.17.1785245105985;
        Tue, 28 Jul 2026 06:25:05 -0700 (PDT)
Received: from [10.239.133.197] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f642baeeesm1353818a91.12.2026.07.28.06.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 06:25:05 -0700 (PDT)
Message-ID: <57a80bff-948c-449d-ad17-cb3fba89ed5f@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 21:24:57 +0800
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] ACPI: CPPC: Add ospm_nominal_perf support
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, pierre.gondois@arm.com,
        christian.loehle@arm.com, ionela.voinescu@arm.com,
        zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, lenb@kernel.org,
        saket.dumbre@intel.co, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linux.dev, linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
        ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com,
        bbasu@nvidia.com, zhongqiu.han@oss.qualcomm.com
References: <20260717215330.2215058-1-sumitg@nvidia.com>
 <20260717215330.2215058-2-sumitg@nvidia.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260717215330.2215058-2-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDExOSBTYWx0ZWRfX1FVjrcHC6xCM
 yOyjelvne9jk1cQFOAyZmtHfHCMrJPdpC27XdjgjD/yucoo0BGD7m5o3U1JWnjHIUO494IR/IuL
 nfo9amArPMnUmjiibJh3YwOLeH8gaE8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDExOSBTYWx0ZWRfXwS5ylj3/pssa
 Yk+GntgNeUTYM5a+wZ3TubVy1uvaumOOHNi+NbsAiE8wVXmFzt9J+0gqeOsvEgN9756A/orZa8A
 ffe4OmqNl7VD3uBZh2OkZm8RALp/FUZjYkTjVM+T3e/lo7A5wkCjM/xIrPaD8c1aXzro2Ps5JPb
 b04acrKGEeBWwYJLb3m8Tqq+wBSMqzlk0hAs/73kKNPO8JNldBGVr6CcJQXfwx1kaVxZT2fa7Mu
 tjWVv6WXkAgFLk4tPbdOC6UtPbTC0doEcZ6uKuV6vQq4wrpKeNoH133wHoNxZXaqsXA/0k8gMTS
 Q973NRMHkhSGKd+X8EvAzph3RZ4JL4KIE3RpFiUwIlwVFDejSwQL3OVv8kDjSQDJ1wgWklPFbHa
 tgl4sLvkZL9AxWndKBoioVqTY2T+uUpuNysWhX8UkXU3HONRoAIlgXNAdT0KkKiiIjZ4l5yZaqF
 Q20IlXSXaHwwvm6o3wQ==
X-Authority-Analysis: v=2.4 cv=aa1RWxot c=1 sm=1 tr=0 ts=6a68adb3 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8 a=iQLh-lR14_TgILYPUVUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: C7P1Pxmx3AscbWSs0xJ75WMvPt2TDBqa
X-Proofpoint-ORIG-GUID: C7P1Pxmx3AscbWSs0xJ75WMvPt2TDBqa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011 adultscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280119

Hello Sumit,

On 7/18/2026 5:53 AM, Sumit Gupta wrote:
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
>    /sys/devices/system/cpu/cpuX/cpufreq/ospm_nominal_freq
> 
> The attribute is documented in
> Documentation/ABI/testing/sysfs-devices-system-cpu.
> 
> Writes are converted to perf via cppc_khz_to_perf(), validated
> against [Lowest Performance, Nominal Performance], and applied to
> the policy->cpu. The register is assumed shared across the
> policy->cpus.
> 
> On read, the current register value is returned, or
> "<unsupported>" if the platform does not implement the register.
> 
> Also add the register to the OSPM-set register save/restore
> table, so its value survives CPU hotplug and reverts to the
> firmware value on driver unload, like the other registers in
> the table.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>   .../ABI/testing/sysfs-devices-system-cpu      | 26 ++++++++++
>   drivers/acpi/cppc_acpi.c                      | 32 +++++++++++++
>   drivers/cpufreq/cppc_cpufreq.c                | 47 +++++++++++++++++++
>   include/acpi/cppc_acpi.h                      | 10 ++++
>   4 files changed, 115 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 82d10d556cc8..a8d592c08823 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -346,6 +346,32 @@ Description:	Performance Limited
>   
>   		This file is only present if the cppc-cpufreq driver is in use.
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
> +		Read returns the current value in kHz, or "<unsupported>"
> +		if the platform does not implement the register. Write a
> +		kHz value in the range [lowest_freq, nominal_freq].
> +
> +		Note that tasks may be migrated from one CPU to another
> +		by the scheduler's load-balancing algorithm, and if
> +		different OSPM Nominal Performance values are set for
> +		those CPUs (through different cpufreq policies), that may
> +		lead to undesirable outcomes. To avoid such issues it is
> +		better to set the same value across all policies, or to
> +		pin every task potentially sensitive to it to a specific
> +		CPU.
> +
> +		This file is only present if the cppc-cpufreq driver is
> +		in use.
> +
>   What:		/sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
>   Date:		August 2008
>   KernelVersion:	2.6.27
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index a7fec6c93178..681d4fd40c11 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1685,6 +1685,38 @@ int cppc_set_epp(int cpu, u64 epp_val)
>   }
>   EXPORT_SYMBOL_GPL(cppc_set_epp);
>   
> +/**
> + * cppc_set_ospm_nominal_perf() - Write OSPM Nominal Performance register.
> + * @cpu: CPU on which to write register.
> + * @ospm_nominal_perf: Value to write to the OSPM Nominal Performance register.
> + *
> + * OSPM Nominal Performance conveys the desired nominal performance level
> + * at which the platform may run. Per ACPI 6.6, s8.4.6.1.2.6, the value
> + * must lie within [Lowest Performance, Nominal Performance] and may be
> + * set independently of Minimum, Maximum and Desired performance. The
> + * caller is responsible for validating the range.
> + *
> + * Return: 0 on success or negative error code.
> + */
> +int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
> +{
> +	return cppc_set_reg_val(cpu, OSPM_NOMINAL_PERF, ospm_nominal_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_ospm_nominal_perf);
> +
> +/**
> + * cppc_get_ospm_nominal_perf() - Read OSPM Nominal Performance register.
> + * @cpu: CPU from which to read register.
> + * @ospm_nominal_perf: Pointer to store the OSPM Nominal Performance value.
> + *
> + * Return: 0 on success or negative error code.
> + */
> +int cppc_get_ospm_nominal_perf(int cpu, u64 *ospm_nominal_perf)
> +{
> +	return cppc_get_reg_val(cpu, OSPM_NOMINAL_PERF, ospm_nominal_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_ospm_nominal_perf);
> +
>   /**
>    * cppc_get_auto_act_window() - Read autonomous activity window register.
>    * @cpu: CPU from which to read register.
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 9c88512d635c..eb6746810fa6 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -37,6 +37,7 @@ enum cppc_saved_reg_id {
>   	CPPC_SAVED_AUTO_SEL,
>   	CPPC_SAVED_EPP,
>   	CPPC_SAVED_AUTO_ACT_WINDOW,
> +	CPPC_SAVED_OSPM_NOMINAL_PERF,
>   	CPPC_NR_SAVED_REGS,
>   };
>   
> @@ -55,6 +56,9 @@ static const struct cppc_saved_reg cppc_saved_regs[CPPC_NR_SAVED_REGS] = {
>   	[CPPC_SAVED_AUTO_ACT_WINDOW] = {
>   		cppc_get_auto_act_window, cppc_set_auto_act_window,
>   	},
> +	[CPPC_SAVED_OSPM_NOMINAL_PERF] = {
> +		cppc_get_ospm_nominal_perf, cppc_set_ospm_nominal_perf,
> +	},
>   };
>   
>   /*
> @@ -1166,11 +1170,53 @@ static int cppc_get_perf_limited_filtered(int cpu, u64 *perf_limited)
>   CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited_filtered,
>   			 cppc_set_perf_limited)
>   
> +static ssize_t show_ospm_nominal_freq(struct cpufreq_policy *policy, char *buf)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	u64 perf;
> +	int ret;
> +
> +	ret = cppc_get_ospm_nominal_perf(policy->cpu, &perf);
> +	if (ret == -EOPNOTSUPP)
> +		return sysfs_emit(buf, "<unsupported>\n");
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%u\n",
> +			  cppc_perf_to_khz(&cpu_data->perf_caps, perf));

In patch 2/2, cppc_cpufreq_get_effective_nominal() reads the OSPM
Nominal into ospm_nominal via the output pointer of
cppc_get_ospm_nominal_perf(policy->cpu, &ospm_nominal), then checks
ospm_nominal for zero ("A zero value means OSPM has not selected a
nominal level") and substitutes the platform Nominal in that case.

However, show_ospm_nominal_freq() passes the value read through the same
output pointer straight into cppc_perf_to_khz() without the equivalent
zero check. This looks a bit inconsistent — is it intentional, or
should show() apply the same "zero means not selected" handling?


> +}
> +
> +static ssize_t store_ospm_nominal_freq(struct cpufreq_policy *policy,
> +				       const char *buf, size_t count)
> +{
> +	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	unsigned int freq_khz;
> +	u32 perf;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 0, &freq_khz);
> +	if (ret)
> +		return ret;
> +
> +	perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
> +	if (perf < cpu_data->perf_caps.lowest_perf ||
> +	    perf > cpu_data->perf_caps.nominal_perf)
> +		return -EINVAL;
> +
> +	/* The register is assumed shared across the policy's CPUs. */
> +	ret = cppc_set_ospm_nominal_perf(policy->cpu, perf);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
>   cpufreq_freq_attr_ro(freqdomain_cpus);
>   cpufreq_freq_attr_rw(auto_select);
>   cpufreq_freq_attr_rw(auto_act_window);
>   cpufreq_freq_attr_rw(energy_performance_preference_val);
>   cpufreq_freq_attr_rw(perf_limited);
> +cpufreq_freq_attr_rw(ospm_nominal_freq);
>   
>   static struct freq_attr *cppc_cpufreq_attr[] = {
>   	&freqdomain_cpus,
> @@ -1178,6 +1224,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
>   	&auto_act_window,
>   	&energy_performance_preference_val,
>   	&perf_limited,
> +	&ospm_nominal_freq,
>   	NULL,
>   };
>   
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index cd07e1e92bf4..4c9e59643cc0 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -180,6 +180,8 @@ extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
>   extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
>   extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
>   extern int cppc_set_epp(int cpu, u64 epp_val);
> +extern int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf);
> +extern int cppc_get_ospm_nominal_perf(int cpu, u64 *ospm_nominal_perf);
>   extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
>   extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
>   extern int cppc_get_auto_sel(int cpu, bool *enable);
> @@ -268,6 +270,14 @@ static inline int cppc_set_epp(int cpu, u64 epp_val)
>   {
>   	return -EOPNOTSUPP;
>   }
> +static inline int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int cppc_get_ospm_nominal_perf(int cpu, u64 *ospm_nominal_perf)
> +{
> +	return -EOPNOTSUPP;
> +}
>   static inline int cppc_get_auto_act_window(int cpu, u64 *auto_act_window)
>   {
>   	return -EOPNOTSUPP;


-- 
Thx and BRs,
Zhongqiu Han
