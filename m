Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ABB284898
	for <acpica-devel@lists.linux.dev>; Mon,  9 Feb 2026 14:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770646624; cv=none; b=LoILPT3BrF5LPXm9KXiVdD7+Sv0iLyYWIA/+1Ca+XGNh/x3LPmZyrTlkfpesK5WvumwUzfxEYnFAfSLU/NQACApEJj3vzsJLw+nmGv702hWLrXtIxjubScCCkMobGDh444mo0N0e2+xw+fliJsNVPBJ+9LET5v4kC0TtHuPL4/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770646624; c=relaxed/simple;
	bh=gfTEdIsMmUOuJYpGHiGGK9+1z6kQlfXxsYz33NHV2IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ng84eB261rAg9U43Wy8J/hMemLMOY08pI5x6/TqtravoLDZ2LewIX4g1QnjLbW+1MMruW/tyHTbAjI3xxCGZlp+ZwYgiVTKa7vaM1zs/TlL7n1/4vXLRb8CTG3kmYzn84N6ihnsD3bPS5BKqFPsn+dMl+Weg3UsGldWoFY8kpag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeuErdDJ; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeuErdDJ"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-35305538592so2684928a91.0
        for <acpica-devel@lists.linux.dev>; Mon, 09 Feb 2026 06:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770646623; x=1771251423; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+vhAUWptZLQYZPG8ROuiqprar1JCQQK4npIFBepuBs=;
        b=HeuErdDJIOeNg/43gR3nb82ySS1Id+V7GPtrV+9ilBGVLeLcLWPnuho0S5QkQwIQIw
         sia1fVouB+sFrnPAzXJMqwtLuvtEWCypT/xO/8+CX/fagS/Uz/0OgjfE7JrCwImz1ce8
         Quvz5TvEWUEkM9kpiPouWXNCYW2otYYfK6ysEWB/PVv++2n4H3fzCJhVz079AZ2e8/5b
         ohP0LwzSwFbchqfwUfPqnm+2dPy3xHg4OY3Y0gp4Xc8Qm3OG2UzxgNG2bVHd6hFRfsNi
         wsa8WtlpxcYkgEX6+4HysiYQbAcjTkGH6iGH9jjauuJwKySsfazQI4OPiQeWelSK0jcL
         8LXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770646623; x=1771251423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J+vhAUWptZLQYZPG8ROuiqprar1JCQQK4npIFBepuBs=;
        b=DWKfGyTuRWNZnw8rnepz7zChHA7etfFb0MsfbngbIMFqXLg4a8/VTBzB8N0FwIydHS
         EYHdHfjzZhANg/qBLviG6gxzXbZyUi/oSMZ8gEBYPJblz8iiwIukh+KJWMJPTzcEJzy6
         FQFlb4v0CZaHFNddaZrkJ0LcwVpg5Gdqna7TFm1gGPsjB/2ohKVG6yBvAkn5rvech3Wb
         3kA2XPc4EvghC/IbApBlJTpkX3Nywm0EAra+J23iokVL5WgTLI2+hi+Or3oK3TFfSVgA
         TObDnf68k/zonyI6k9z29OtMlSOZ2zq4TeXe5ub5pbQjw/IPM3n+BjgGRVYt7Vn9M+pU
         Js3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWki7+aZAz1i11W+6hTSPtpPNFrdf+MgQ1kFmLArkKrZE3fW9e9MCLv3Hl7VoK12gClnYD3k0+ofYwoN8I=@lists.linux.dev
X-Gm-Message-State: AOJu0YwkgC/0y94yMWmyH3hIRY1LfhdLU4BzsP8KF3+R3m/UjrZslZCS
	OyyExpW83RalbALDXmzk57DI5QWB9L8gFGE7wLopuE78JirAEhg/DVCo
X-Gm-Gg: AZuq6aK48tG79E6SlEb//tnI6Pc6m7w6o4sBubNW3mMq4HYWc4PXBbpV4/4sodFxTAC
	CILuMqONZvskFUYmmhtGcLMkS0bN9WkN45XViqtxzg7ujp+HiD2+2CEPhqJR9Mjch7JwuOX7VQ6
	+K2zbzfu32pMSyenbnzjkekntimXT1X4yj8+Tr8bvFqjTLX9eFAqmQlATl2fZb+5kLHGx6ajcXX
	gFqAlqHl00xv2fL9rugK2FLjZvyQh9L85xRiB5GrZjjFp7QwfL4xYzMNP8lGLj6xePZ/Z8RyoJf
	+5HfGw1kDJdKH5LhZH4rRK/1U6PO3U2iHXzpf341rfyjDwuznlzAorfv6qMjMxXhBuHvf6qr6IH
	1IQi/1aRzNY6T/Hcns+xqpxr6kuwTmmDqjgO+lbvLz9dfaOkSCz0eJpP4R2UPA5GicQqou0sEpP
	kcCvPTY2epsQV3pTXxWR/CFgeuYsSewiGZVw==
X-Received: by 2002:a17:90a:d010:b0:356:2eac:b650 with SMTP id 98e67ed59e1d1-3562eacbbccmr4038749a91.3.1770646623298;
        Mon, 09 Feb 2026 06:17:03 -0800 (PST)
Received: from localhost.localdomain ([106.38.154.106])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3549c5955a7sm14852844a91.17.2026.02.09.06.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 06:17:02 -0800 (PST)
From: Gong Shuai <gsh517025@gmail.com>
X-Google-Original-From: Gong Shuai <gong.shuai@sanechips.com.cn>
To: fustini@kernel.org
Cc: Dave.Martin@arm.com,
	acpica-devel@lists.linux.dev,
	alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	aricciardi@baylibre.com,
	atish.patra@linux.dev,
	atishp@rivosinc.com,
	babu.moger@amd.com,
	ben.horgan@arm.com,
	conor+dt@kernel.org,
	cp0613@linux.alibaba.com,
	cuiyunhui@bytedance.com,
	devicetree@vger.kernel.org,
	fenghua.yu@intel.com,
	guo.wenjia23@zte.com.cn,
	james.morse@arm.com,
	krzk+dt@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	liu.qingtao2@zte.com.cn,
	liwei1518@gmail.com,
	mindal@semihalf.com,
	npitre@baylibre.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	peternewman@google.com,
	pjw@kernel.org,
	rafael@kernel.org,
	reinette.chatre@intel.com,
	rkrcmar@ventanamicro.com,
	robert.moore@intel.com,
	robh@kernel.org,
	samuel.holland@sifive.com,
	sunilvl@ventanamicro.com,
	tony.luck@intel.com,
	vasu@rivosinc.com,
	ved@rivosinc.com,
	x86@kernel.org,
	zhiwei_liu@linux.alibaba.com,
	gong.shuai@sanechips.com.cn
Subject: Re: [PATCH RFC v2 08/17] RISC-V: QoS: add resctrl interface for CBQRI controllers
Date: Mon,  9 Feb 2026 22:16:49 +0800
Message-ID: <20260209141649.330184-1-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128-ssqosid-cbqri-v2-8-dca586b091b9@kernel.org>
References: <20260128-ssqosid-cbqri-v2-8-dca586b091b9@kernel.org>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, Drew

> Add interface for CBQRI controller drivers to make use of the resctrl
> filesystem.
> 
> Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> Signed-off-by: Drew Fustini <fustini@kernel.org>
>
> ...
>
> +u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *d,
> +			    u32 closid, enum resctrl_conf_type type)
> +{
> +	struct cbqri_resctrl_dom *hw_dom;
> +	struct cbqri_controller *ctrl;
> +	int reg_offset;
> +	u32 percent;
> +	u32 rbwb;
> +	u64 reg;
> +	int err;
> +
> +	hw_dom = container_of(d, struct cbqri_resctrl_dom, resctrl_ctrl_dom);
> +
> +	ctrl = hw_dom->hw_ctrl;
> +
> +	if (!r->alloc_capable)
> +		return resctrl_get_default_ctrl(r);
> +
> +	switch (r->rid) {
> +	case RDT_RESOURCE_L2:
> +	case RDT_RESOURCE_L3:
> +		/* Clear cc_block_mask before read limit operation */
> +		cbqri_set_cbm(ctrl, 0);
> +
> +		/* Capacity read limit operation for RCID (closid) */
> +		err = cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT, type, closid);

It looks like the parameter order might be incorrect. I believe it
should be:
cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT, closid, type);

> +		if (err < 0) {
> +			pr_err("%s(): operation failed: err = %d", __func__, err);
> +			return resctrl_get_default_ctrl(r);
> +		}
> ...

Sorry for the resend, my company email had some formatting issues,
so I'm sending this from my personal address.

Hope it doesn't cause any trouble!

Thanks,
Shuai
