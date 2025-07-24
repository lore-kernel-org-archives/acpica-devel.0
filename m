Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA5027D77D
	for <acpica-devel@lists.linux.dev>; Thu, 24 Jul 2025 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753364078; cv=none; b=XqedIMpmgzezUMsyS0ha7qEMNKuNaYBq6EkK3R2nnvbtLIOCigcNvfnwXz91tMVajI5KldoqBnHQKDs6AZkWgbS589TSFKG9d9GX+DarCPQsUJ7csPH5G2zQDaf+/Lkt9AMXmMKnbwXHCbreueJaSxzHlgXqCXlf94tJE44FKME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753364078; c=relaxed/simple;
	bh=MVJ3E/91h69I0bmDMezkRZP4rkHbijJOQ6KILSOiZCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5TyZl0Q/3dEAIVMrh+F5EwN6S8zkpA3m/nPOtrkN1yhMDK4zPqNQ2CJ3LaPpijwzi8y1wZPKKv1W/sUNXcbQ95y3JxmQeGjVTKVsluR+pT7WJ+Lkxt3SZs7X8jpFEshXmmiSTE5BBTu7RoEjAqY5dmjkqMaFUHrMlBiG9T2Wp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-af0dc229478so148238266b.1
        for <acpica-devel@lists.linux.dev>; Thu, 24 Jul 2025 06:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753364075; x=1753968875;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/fx+2jC1brmgVu9hs4XiOEifPBnLGokabrEM+R2kq2s=;
        b=vwzJMT4Si83W6K1n8KeRQJtm8V4SNnTz81iHQpiNr04KC6e3HVjycTT+G84foOrUiQ
         kHVpYjzA3uxX4lQdaO+FKpYIV6AlaO+jq4W00XNHx5vlrhQXJ6cfo+y1DL2Uj2v3hDy0
         CU7svfxa3zfPmx2I1MCLknLDSLm04fc9ybep4nE/D5q91ZS8zAIjibPmwTuU9RD+b2oO
         3rmR3UJtOR5ObJY+2a3f9N0xSX2p07NHV9HWQo4P4VhBOuODTDxCVNHKeGveoX0P3bGr
         G3qcwKMPsmrdRxWbVgwK+JK7jJGC22MTIyQnKANqGr01l24C//1vvkX4OTyiY/Uztawl
         InCg==
X-Forwarded-Encrypted: i=1; AJvYcCXv2b/RDfjhb/Hzwot6LvQcZUGz3G2uLkgaQXhU9+MGCJJEwgBZVAU/OSR8HzJfzagX0OuFrlTSkhhiVfI=@lists.linux.dev
X-Gm-Message-State: AOJu0YzdBpUydyt8aTRPgl+mp1oFUKRnblId0PjWpjZlKoXx2ygIUtnC
	5qGutiI2hbWoyVG26+Kp/MabnmFQxYOji62xmlvUjNR/j79+D24vFkoc
X-Gm-Gg: ASbGncuQ0Q2WuCz9If0EgkOA0JgtIYGsVM5iswQv5e8aEyl56edm2HhXeU3rYRc2A4r
	DBIlWlSrr/8XaQRXgIkU0iqwZYcBFWg9gb3Xpe4m5wqi89Rfi6xlhKpFk7HWTDpERfoWppr8+Os
	Rc+VINRx0/DITME+EIaXtWYb8xTCOlfTnp203IodRKiIh+Mpqa7cnh9gNb2qELZEnQAxBorQlad
	ssAtuN+BFKaKcpdaJi8S5w7aBrMIaoEpmYs7y/GLamirAx4h/W9lZ3Yvvl3Dq2GTAOjTWhmyF6t
	XNlRK3uvHyM1uu+qt4ph2tzTCd7lrRmfpTzhZsENxDV62mP/EHkqHbNETpYJKKdJ1hkOTYr+GQl
	jEamIomU03A==
X-Google-Smtp-Source: AGHT+IErTV5E5SvHgukSA8OS+U/Vctcx7DT/kAXhifsJMwbjohYquNlfTpV+af0AGvLRHpjhkGn6qQ==
X-Received: by 2002:a17:907:e8e:b0:aec:76c6:6ef6 with SMTP id a640c23a62f3a-af2f8d4fc6amr617861566b.50.1753364074854;
        Thu, 24 Jul 2025 06:34:34 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47f861d7bsm111509066b.119.2025.07.24.06.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:34:34 -0700 (PDT)
Date: Thu, 24 Jul 2025 06:34:31 -0700
From: Breno Leitao <leitao@debian.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Robert Moore <robert.moore@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev, osandov@osandov.com, 
	konrad.wilk@oracle.com, linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3] vmcoreinfo: Track and log recoverable hardware errors
Message-ID: <4qh2wbcbzdajh2tvki26qe4tqjazmyvbn7v7aqqhkxpitdrexo@ucch4ppo7i4e>
References: <20250722-vmcore_hw_error-v3-1-ff0683fc1f17@debian.org>
 <7ce9731a-b212-4e27-8809-0559eb36c5f2@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ce9731a-b212-4e27-8809-0559eb36c5f2@linux.alibaba.com>

Hello Shuai,

On Thu, Jul 24, 2025 at 04:00:09PM +0800, Shuai Xue wrote:
> 在 2025/7/23 00:56, Breno Leitao 写道:
> > Introduce a generic infrastructure for tracking recoverable hardware
> > errors (HW errors that did not cause a panic) and record them for vmcore
> > consumption. This aids post-mortem crash analysis tools by preserving
> > a count and timestamp for the last occurrence of such errors.
> > 
> > Add centralized logging for three common sources of recoverable hardware
> > errors:
> 
> The term "recoverable" is highly ambiguous. Even within the x86
> architecture, different vendors define errors differently. I'm not
> trying to be pedantic about classification. As far as I know, for 2-bit
> memory errors detected by scrub, AMD defines them as deferred errors
> (DE) and handles them with log_error_deferred, while Intel uses
> machine_check_poll. For 2-bit memory errors consumed by processes,
> both Intel and AMD use MCE handling via do_machine_check(). Does your
> HWERR_RECOV_MCE only focus on synchronous UE errors handled in
> do_machine_check? What makes it special?

I understand that deferred errors (DE) detected by memory scrubbing are
typically silent and may not significantly impact system stability. In
other words, I’m not convinced that including DE metrics in crash dumps
would be helpful for correlating crashes with hardware issues—it might
just add noise.

Do you think it would be valuable to also log these events within
log_error_deferred()?

> > -	if (ghes_severity(estatus->error_severity) >= GHES_SEV_PANIC)
> > +	sev = ghes_severity(estatus->error_severity);
> > +	if (sev == GHES_SEV_RECOVERABLE || sev ==  GHES_SEV_CORRECTED)
> > +		hwerr_log_error_type(HWERR_RECOV_GHES);
> 
> APEI does not define an error type named GHES. GHES is just a kernel
> driver name. Many hardware error types can be handled in GHES (see
> ghes_do_proc), for example, AER is routed by GHES when firmware-first
> mode is used. As far as I know, firmware-first mode is commonly used in
> production. Should GHES errors be categorized into AER, memory, and CXL
> memory instead?

I also considered slicing the data differently initially, but then
realized it would add more complexity than necessary for my needs.

If you believe we should further subdivide the data, I’m happy to do so.

You’re suggesting a structure like this, which would then map to the
corresponding CPER_SEC_ sections:

	enum hwerr_error_type {
	HWERR_RECOV_AER,     // maps to CPER_SEC_PCIE
	HWERR_RECOV_MCE,     // maps to default MCE + CPER_SEC_PCIE
	HWERR_RECOV_CXL,     // maps to CPER_SEC_CXL_*
	HWERR_RECOV_MEMORY,  // maps to CPER_SEC_PLATFORM_MEM
	}

Additionally, what about events related to CPU, Firmware, or DMA
errors—for example, CPER_SEC_PROC, CPER_SEC_FW, CPER_SEC_DMAR? Should we
include those in the classification as well?


Thanks for your review and for the ongoing discussion!
--breno
