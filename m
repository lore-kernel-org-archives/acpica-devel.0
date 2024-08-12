Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96B84C7B
	for <acpica-devel@lists.linux.dev>; Mon, 12 Aug 2024 01:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723424867; cv=none; b=hz5wgaR5PutaZ316YfayAx1+qtlRX7mYhO06XwUK3os95D86+Pk7/EjJz+91MekTz63IZ6UhmPTL1NZHl8SCUyqLQDAtIXTOoS7inBkKm1RQVkmWctZhodSkFgAx9+PAizFSwBiWTDYMcr/+fZJYM3s7qQbb4VxRcIKd/tnpcQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723424867; c=relaxed/simple;
	bh=2sNswRQwFYvamsccTf71Mx+B1uS30lOIX5Wufuwq/zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGtd+OFKEK2TvK6fER+mYFwmgun26VGNtBPaFqB1J7r9ugGDFbhXZN6DcsptJK3CqFo2KAMTNWOzsBDfw7b1zpcYwxTRo7Y71mkHawbBNYtKg4DCuHHpXTyw+Ho3m2FKQqACZ2Gm7v3rhIJF45F2Q/eAqczJ2A1HGmBc+2Qyxts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=k8O/1OsK; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="k8O/1OsK"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fd640a6454so28439015ad.3
        for <acpica-devel@lists.linux.dev>; Sun, 11 Aug 2024 18:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723424865; x=1724029665; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Crz27ST5X2jO2vrF90biTTCavSItjpCBUjBKFknbYQ=;
        b=k8O/1OsKEOTIcRDvfYQ6V9gJbj6Lv9nrcTVncpxhZmyPgXc381lNrE9NZm3SrNckyp
         O3zhIQmTZPKXcWN51JHfv6hDXO88qBTHHZaTtxzRDRzzCJJWNS6PtijGA5jnWVurxCM8
         j1NxE4kyPeKydcQ4owW3wXWjs4jtYzBO04MjqBEC0UemrFxpzOao5jeJ/n4x0/kFXjTS
         GCyj8KJ4+OBOaqG3NKItAcPK5PB4pUkUCv0ubcqi+Q6OQMOOCObwTMDbUItAjJ4YE61J
         SKhwpV5oiOAgO4+5tDtVBnDKtmf7aiKI6ls5gvINDY1FKoXzqrj158poAUlsq+gqSvpr
         eD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723424865; x=1724029665;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Crz27ST5X2jO2vrF90biTTCavSItjpCBUjBKFknbYQ=;
        b=OqgfE4u8KwiKekk+bKcfHXsHnQ4KmAYu73hspOUUFe2aPEaOmTMsYZnWy0cPWJmB3q
         UhqRTE1dsE+CM5s8zIM1jNSOdYdaX1akLmbw3yEN33z8F0DvpVl0QSwt/6vyUqtrv/1v
         IWxHnrXi+BTQQuAapjFFmd6+bVftsdB5+gd2bkHg2bIvXSzbhx516C5Yc/NKTUyk6yqd
         2mQTo+4jXuirwwfh4LNKMESoXr/A7K+l078n9tjH/imUCH3/gG1d6vqATIzv9cuL9rgn
         rbomYp0sf3dVSBm9m4Ig/f74Mo2aYQ3W5GW1IAFS4e7VP9gTiVoE7pTlmnUtEqG/nA2G
         X8ow==
X-Forwarded-Encrypted: i=1; AJvYcCW1JAAYR2Rt1HqPHMp043jWqIkEW9+SeTeeetSvBcGe3mwEEenxxEqps4IclHzAcU4++uROlLqZd2oorus=@lists.linux.dev
X-Gm-Message-State: AOJu0YzYtww41K9EecGzPwnIQ0mndSAI7yX2K05Uykj/rMd9cQRdncHp
	lPuVf/FuRvX+EczXGVc7AbZdFf7tLSSa+7UWoLVZ/XVuzwVCWnH1oU9nnVNRXng=
X-Google-Smtp-Source: AGHT+IFy5zs1UKvROLW81s0IANcAfrd4dDGTMIm7sbcPUJ21ofUGfdTh3DNcEjKHaI13Ofh/d6iuAg==
X-Received: by 2002:a17:90b:4a42:b0:2c8:a8f:c97 with SMTP id 98e67ed59e1d1-2d1e8078a15mr6034174a91.37.1723424864290;
        Sun, 11 Aug 2024 18:07:44 -0700 (PDT)
Received: from sunil-laptop ([2405:204:5602:8c56:518:77d3:10fd:70a0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1fcfed6c1sm3637969a91.36.2024.08.11.18.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 18:07:43 -0700 (PDT)
Date: Mon, 12 Aug 2024 06:37:33 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Will Deacon <will@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v8 00/17] RISC-V: ACPI: Add external interrupt controller
 support
Message-ID: <ZrlgVUXC_dCW9ISM@sunil-laptop>
References: <20240812005929.113499-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240812005929.113499-1-sunilvl@ventanamicro.com>

On Mon, Aug 12, 2024 at 06:29:12AM +0530, Sunil V L wrote:
> This series adds support for the below ECR approved by ASWG.
> 1) MADT - https://drive.google.com/file/d/1oMGPyOD58JaPgMl1pKasT-VKsIKia7zR/view?usp=sharing
> 
> The series primarily enables irqchip drivers for RISC-V ACPI based
> platforms.
> 
> The series can be broadly categorized like below. 
> 
> 1) PCI ACPI related functions are migrated from arm64 to common file so
> that we don't need to duplicate them for RISC-V.
> 
> 2) Added support for re-ordering the probe of interrupt controllers when
> IRQCHIP_ACPI_DECLARE is used.
> 
> 3) To ensure probe order between interrupt controllers and devices,
> implicit dependency is created similar to when _DEP is present.
> 
> 4) ACPI support added in RISC-V interrupt controller drivers.
> 
> Changes since v7:
> 	1) Updated commit messages as per feedback from Bjorn on patches 2, 3 and 8.
> 	2) Addressed Anup Patel's comments.
> 	3) Added Tested-by tag from Björn Töpe which I missed to add in previous version.
> 	4) Rebased to 6.11-rc3 and updated the RB tags from Anup.
> 
> Changes since v6:
> 	1) Update to commit message/code comments as per feedback from Bjorn.
> 	2) Rebased to 6.11-rc1.
> 
> Changes since v5:
> 	1) Addressed feedback from Thomas.
> 	2) Created separate patch for refactoring DT code in IMSIC
> 	3) Separated a fix in riscv-intc irqchip driver and sent
> 	   separately. This series depends on that patch [1].
> 	4) Dropped serial driver patch since it depends on Andy's
> 	   refactoring series [2]. RISC-V patches will be sent
> 	   separately later once Andy series get accepted.
> 	5) Rebased to v6.10-rc1 which has AIA DT patches.
> 	6) Updated tags.
> 
> Changes since RFC v4:
> 	1) Removed RFC tag as the RFCv4 design looked reasonable.
> 	2) Dropped PCI patch needed to avoid warning when there is no MSI
> 	   controller. This will be sent later separately after the
> 	   current series.
> 	3) Dropped PNP handling of _DEP since there is new ACPI ID for
> 	   generic 16550 UART. Added the serial driver patch instead.
> 	4) Rebased to latest linux-next.
> 	5) Reordered/squashed patches in the series
> 
> Changes since RFC v3:
> 	1) Moved to _DEP method instead of fw_devlink.
> 	2) PLIC/APLIC driver probe using namespace devices.
> 	3) Handling PNP devices as part of clearing dependency.
> 	4) Rebased to latest linux-next to get AIA DT drivers.
> 
> Changes since RFC v2:
> 	1) Introduced fw_devlink for ACPI nodes for IRQ dependency.
> 	2) Dropped patches in drivers which are not required due to
> 	   fw_devlink support.
> 	3) Dropped pci_set_msi() patch and added a patch in
> 	   pci_create_root_bus().
> 	4) Updated pnp_irq() patch so that none of the actual PNP
> 	   drivers need to change.
> 
> Changes since RFC v1:
> 	1) Abandoned swnode approach as per Marc's feedback.
> 	2) To cope up with AIA series changes which changed irqchip driver
> 	   probe from core_initcall() to platform_driver, added patches
> 	   to support deferred probing.
> 	3) Rebased on top of Anup's AIA v11 and added tags.
> 
Hi Rafael,

Hope you are back this week!.

This series has spent quite a bit of time now on the list. As you are
aware, few clarifications like _PIC codes are also done now. There is
no major change after you had agreed for the design. So, can this be
considered for the next release please?

Thanks!
Sunil
