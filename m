Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD1A286419
	for <acpica-devel@lists.linux.dev>; Wed, 25 Mar 2026 02:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774405915; cv=pass; b=XGjEA+7ww+Ojr4BjF++yQIOjKzygjxfNlJmo06YWcH4XqEOk3hD0VLfSx6RRuxid+cZzz1W+N0tl12H1DqtApOXDf+cw6C9tZBR8wjvzzXD34cQNMYKD7RxkuWRZzznt5aNj/FIo8Q2UhcJd8uacUWMAwSy4H1S+DxLBeeuU0lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774405915; c=relaxed/simple;
	bh=PyO7nXn0BKvL4OXhMD1Xm1VJSQgBBVytDo/XkUUyNfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hBWUg1Jzn0e9GWsMIu3QOcYEcM0UhSqyoeKRfi+CoTA4XvmSC1o2L3B0jcYrDLxmbKq9M0ahTOJv+hvlTuloXzfR614VfZ+QqOdZ/VW6Zoa3R1QFl4C3BHMIL+bS6L8RQETAHmcG3YKm6Z1+qPh43kvt9oD4+KW2zRPcu2y/50k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ioDdYKey; arc=pass smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ioDdYKey"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d7f09aa39fso4943731a34.0
        for <acpica-devel@lists.linux.dev>; Tue, 24 Mar 2026 19:31:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774405911; cv=none;
        d=google.com; s=arc-20240605;
        b=GjO3TcQrGr+kP7GpaNeMxgu1MYRFB9ml1JLp5DRP9r1aJGJycskCCa0g67e5U+XbHm
         FoTy6OUXk5sMVk4UCpEO1REWs+C6tZPe1N8O3tnOjlmg8bXGidWHiHaIrW8DScYOI/DR
         pKzVQGs3GWVOsudI/6LIRv0yKk19/rH8Sg80NAqJIgWIKnwPsBo1hHchYEE8sTAznZSw
         t2Ds8qat42mpz6fMgh6fu2xUSSutxzaekXTmSRNTOf77o7028UNhH2Ec52Ufxt2RbJM/
         bMygMHKVLLJOTnoVCmtre1oFdKB228OcBvKq9DHoHojKoVjlge2yd1612A2V+54mnOUV
         tjGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z6L/dK9RXBU0ye50vaCd1XpagmdaKpcR91kPPZAxHEc=;
        fh=pnSfkbwc8tQyh84Rd3Stjyez+d7HpcEY2VYx8Y/s42E=;
        b=O6aR0/ykW+Aetg5m4UNzMVzF46SIBPCdNAX5NmjstMh4TkT4o+bffApTW0hoZzYoel
         SI8AfhdJqEpSHTcAHW+HZPKFWLx8gw2kviI2AEV+U1TFEUVUSMA0cdppaiENF1t3tqT+
         NAAj5f5A/mSf0+f+9XZCd2eJhhY3ysdLRb6OdIGfElhb+j+iubnjE6Qm/2KbE9wNvCk0
         YAc81ivCusvcJDF3eOT3Ejh3QQT/tZAGDuvqlDjmTCG4vrj5cD3K/j22QOW1rDbAOJqf
         Gmd8Pi6M9Vy57vrB5u8fp/tDTvfbgBL2V6c8o09RWEE9glh4y0KAdwOHtPVb9oT6Ii3n
         5iYg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1774405911; x=1775010711; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6L/dK9RXBU0ye50vaCd1XpagmdaKpcR91kPPZAxHEc=;
        b=ioDdYKeyfVLgQOIL7Tjtq3So8nUqOLW2WusL1k4qucsFUkqgGmknYOlq0NsY9I6oU6
         cfGbNokH3fR9BI9NTfaZh7rD31ZH35C0m31gKWdBlctHkaVfOo3sNpkHP3BxP2M5IzZ2
         zNHXa8F2NrMyVOw7I053J3f6T5pr6uXax8hWG2EBKgMJMQUUwNg3bGZKER2QiniwrR5N
         5wXL//+1f2Gd9HjVrA9Q0/EhqNMf6J7w3RKLKAtJxHDVDrt5PJFO2jQFdo4Sr5+t8m5T
         iY97WLNrPYUwFQIaj+Cw28NpNfAZ9A1ScjuREWYPQ2K6ulbijttZ71D2zLtWbqfEqQcK
         WBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774405911; x=1775010711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z6L/dK9RXBU0ye50vaCd1XpagmdaKpcR91kPPZAxHEc=;
        b=rP7IUL2NKXakbufwStQBuxgcff+UlhXgKawnaPSCZRJypvyj903a1HLjdqJFofbgdu
         Yp2zrZcvJWHfSfvCeTgoBKgjLcGFLPVYCdppxYUtLGjpP2a48DmHJ82N7ZM3SL4TpW2f
         W3Vy+1PELsE+SNKX7XXZMobbQ7XtO55uTinDD2LAaspkCnIpDKeHjnTNt8VRxgWdHzv1
         t/SSlAMsNQUjURzXgsE5GrVIgv15m2NC5gubovc5ids8lhKBfiBQ1PBJejsl8mU08XPM
         VvrfFTuLV4ugFQm7Gm7YMO7GZ5N4XnRPd4dXvdz1k1fkTlTZjiDHe+X8+QShM0ySsQRV
         Z9vA==
X-Forwarded-Encrypted: i=1; AJvYcCXLaqSvR98KIZM7ecImcrHxvyHbhVohFFi6ng2hztWkS30PtsdjJoJzn6fL2iHwvxccPUykA8MjH+HJ/rY=@lists.linux.dev
X-Gm-Message-State: AOJu0YzCkJ3JeaJC0XSGFyOd7sz79e/TJPhtx7rL4JB2N//HqA2A2Izt
	HaaUUiSviFV3nZBLbJsnVaQjSS6WyRBNPueAjvpp6LRCKCrqV71zAbF7evbV4SCzgx9qC/2/J53
	uxmQK/7FJBGNAMenCaE24Y0/AxKpQzLRGC1ylIDsOrw==
X-Gm-Gg: ATEYQzwv/IPIh9hrTDNFDvwEz9J13gO5BHFwdQBByK9PCkwPful9k+BE+1PvKNqNfs0
	aVWAlEy7gtcsAVCEWeLvRtKkPa6ZQOo9qRWWfP8YLY1gXIGsXB38wcq7nPzHVL5ZfHIj3hyAq2V
	m7337Maj8Bng8s6KO3+UFm4ffSB9+rccKqqSey2htMNAcH3eaOQxGtfO+PwtY3tck43I5MkkVK8
	f3BDZrknKKzKUjPLMAbnziSk0LPB0r4b/zCHKNkznVsLtTcqOGkjEI3aOrDockLelpIsCjYzFj1
	YMxSOZWFFOUTdw==
X-Received: by 2002:a05:6830:82b4:b0:7d9:b46f:ee21 with SMTP id
 46e09a7af769-7d9d69cdf4bmr897075a34.16.1774405910770; Tue, 24 Mar 2026
 19:31:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org> <20260128-ssqosid-cbqri-v2-6-dca586b091b9@kernel.org>
In-Reply-To: <20260128-ssqosid-cbqri-v2-6-dca586b091b9@kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 25 Mar 2026 10:31:39 +0800
X-Gm-Features: AaiRm50kmkkX4lpUb-H53j141xOJJF0B4hNLojrNS59qLQl25FnWptD4NwPaAxM
Message-ID: <CAEEQ3wmuAnHU1VBFDwbCBFb8j63ZcizJ3jEC2SiVWnoMPc4=SA@mail.gmail.com>
Subject: Re: [External] [PATCH RFC v2 06/17] RISC-V: QoS: define CBQRI resctrl
 resources and domains
To: Drew Fustini <fustini@kernel.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Adrien Ricciardi <aricciardi@baylibre.com>, 
	Nicolas Pitre <npitre@baylibre.com>, =?UTF-8?Q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
	Atish Patra <atish.patra@linux.dev>, Atish Kumar Patra <atishp@rivosinc.com>, 
	Vasudevan Srinivasan <vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, 
	Chen Pei <cp0613@linux.alibaba.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
	Weiwei Li <liwei1518@gmail.com>, guo.wenjia23@zte.com.cn, liu.qingtao2@zte.com.cn, 
	Reinette Chatre <reinette.chatre@intel.com>, Tony Luck <tony.luck@intel.com>, 
	Babu Moger <babu.moger@amd.com>, Peter Newman <peternewman@google.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, James Morse <james.morse@arm.com>, 
	Ben Horgan <ben.horgan@arm.com>, Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, x86@kernel.org, 
	Rob Herring <robh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Drew,

On Thu, Jan 29, 2026 at 4:28=E2=80=AFAM Drew Fustini <fustini@kernel.org> w=
rote:
>
> Define data structures to encapsulate the resctrl resource
> and domain structures.
>
> Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> [fustini: rebased current upstream]
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
>  arch/riscv/kernel/qos/internal.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/arch/riscv/kernel/qos/internal.h b/arch/riscv/kernel/qos/int=
ernal.h
> index ff2c7eff50be..c0402dd06cfa 100644
> --- a/arch/riscv/kernel/qos/internal.h
> +++ b/arch/riscv/kernel/qos/internal.h
> @@ -65,6 +65,11 @@
>  #define CBQRI_BC_ALLOC_CTL_OP_READ_LIMIT   2
>  #define CBQRI_BC_ALLOC_CTL_STATUS_SUCCESS  1
>
> +int qos_resctrl_setup(void);
> +void qos_resctrl_exit(void);
> +int qos_resctrl_online_cpu(unsigned int cpu);
> +int qos_resctrl_offline_cpu(unsigned int cpu);
> +
>  /* Capacity Controller hardware capabilities */
>  struct riscv_cbqri_capacity_caps {
>         u16 ncblks; /* number of capacity blocks */
> @@ -125,4 +130,26 @@ struct cbqri_controller {
>         bool mon_capable;
>  };
>
> +struct cbqri_resctrl_res {
> +       struct rdt_resource     resctrl_res;
> +       struct cbqri_controller controller;
> +       u32 max_rcid;
> +       u32 max_mcid;
> +};
> +
> +struct cbqri_resctrl_dom {
> +       struct rdt_domain_hdr       resctrl_dom_hdr;
> +       struct rdt_ctrl_domain  resctrl_ctrl_dom;
> +       struct rdt_mon_domain   resctrl_mon_dom;
> +       u64 cbm;
> +       u64 rbwb;
> +       u64 *ctrl_val;
> +       struct cbqri_controller *hw_ctrl;
> +};
> +

Can we trim down some fields? For example:
 struct cbqri_resctrl_res {
        struct rdt_resource     resctrl_res;
-       struct cbqri_controller controller;
        u32 max_rcid;
        u32 max_mcid;
 };

 struct cbqri_resctrl_dom {
-       struct rdt_domain_hdr       resctrl_dom_hdr;
        struct rdt_ctrl_domain  resctrl_ctrl_dom;
        struct rdt_mon_domain   resctrl_mon_dom;
-       u64 cbm;
-       u64 rbwb;
        u64 *ctrl_val;
        struct cbqri_controller *hw_ctrl;
 };

> +struct cbqri_config {
> +       u64 cbm; /* capacity block mask */
> +       u64 rbwb; /* reserved bandwidth blocks */
> +};
> +
>  #endif /* _ASM_RISCV_QOS_INTERNAL_H */
>
> --
> 2.43.0
>

Thanks,
Yunhui
