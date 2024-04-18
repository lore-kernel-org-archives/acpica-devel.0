Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3C31649D2
	for <acpica-devel@lists.linux.dev>; Thu, 18 Apr 2024 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448747; cv=none; b=NS5zl9ur5cRmb5RzwFlbb3jpVTEDdVjnjwpHL9hxsiUK7aqTwK7LJTQZbt/Ej7f+wwi5dsWJDPJIPkAKvsIjN9G5efyAcGBVf6svlzViiBQSylasCahJnR50tFpfwPkjUEBsLcY7PozstD1cDqoyZ8IXBFLU1VeXnnKO5zLiwCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448747; c=relaxed/simple;
	bh=JT3JZZTJ2Qm1KqHFfbHbqKzfMjaDTTZGcTW42XX/i6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3A4i6V83k6J/dKp0EMnSvtXsNk1iUdUx4aj6sp3hlQ83trfb8/yb1ZcrSKdJAxbEoT+veWqSiz4E5U1Ca6Y9xFL1PuMynwBUEtv18JYqvAxEYu0HDTkQkNmJ4nvUAIGW54w0BZn6iv+s1Ay15LILF8MHb+gTWaUuP0madFzlOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Ej/8daxo; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Ej/8daxo"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ecec796323so944758b3a.3
        for <acpica-devel@lists.linux.dev>; Thu, 18 Apr 2024 06:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713448745; x=1714053545; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WZO5tEmqpe+L1U/C8UD1PE69dEQv50EfBPcTW8iw+NY=;
        b=Ej/8daxoDcc5E323El7eZL1yPAS+BTzaeR7sWebjPsJzjGIaD/IdkfpnOlWycoTXLb
         sw22ThSq8mVQArMVW47scMbszhQWz8JNaYMqh+5Ms8DHvxOP6emF+sZCYggyB+Z8rL1U
         iPg21gOSmQ+0I3r2Hi7KH8WUJyoQoWYupET/6S9pYM2uctsqM+5dJP2TpNYlQoGEtfvs
         QiJ83/ncDxfH3jiunifB7W3nGp93Df9wwJRilXsUFVqgVnQnBRV7+NYc6U/m0kKGo/GZ
         I/Sh3lCq0PWtXuNhlExcl+FoU7isByIl0ftYMl3Qalcaw1Noz2Ar8TBWK0O7g5f+rBYt
         oeVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713448745; x=1714053545;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WZO5tEmqpe+L1U/C8UD1PE69dEQv50EfBPcTW8iw+NY=;
        b=w6ZrUNExomZQNMBS7NFZcEkn1L85gp5ndD8yYLsw1As5pd0/a06pV1OueJKkszRX8x
         4wDcXRoItiJMFAOsRlU88nCv+BlWhaeWEKHroK5awTjuyizSWbgO/l3k8mrXZAh1RNKm
         nSU6+KO0nGYrARwsA2wFp1cQbeTZxJdWOvu5OVqDunPGxvPr9sGR467HZ7DD+ulKq46Q
         TVIITeuB0JToiWF9KlrqfDDMliN3T4SkXsTZ7Flg7wQzmRVyMEJJQxlu0EqSZ9sq8Wy7
         9n2vAR2uAMecom9/VIV0DehZR8unJX+E919zT90sXKKq5fUeM9+ShMkd676IbT0jHsqx
         mCiw==
X-Forwarded-Encrypted: i=1; AJvYcCWVwtM6ZwOim5El/lFyA4rfoV8wFmrrPflBhXZWUpUT8B/Y+6WKUTgtvKd4UHQUCaiIrtmQYAQMWyBQcxzG/VNqMO6njnMMya5GzHIF
X-Gm-Message-State: AOJu0YzdYYfckOlcvRwUFPHfjvqzXnqe6dgQIufje7WkRDE9eEVZx9Kp
	lTf/5FAPvULlkv0mEBoKlFE33c6uh8VCgRXoAFVRs3CWQGuRXSgid0/gf060Kds=
X-Google-Smtp-Source: AGHT+IGUjEe5kgj82Lo/86KEUqPTE4pNtd6avdOYxdh0NqwVwVbNQ8pG380MXUqn5yro6JHyVQnxWQ==
X-Received: by 2002:a05:6a00:8a0f:b0:6ec:da6c:fd69 with SMTP id ic15-20020a056a008a0f00b006ecda6cfd69mr2885160pfb.7.1713448744818;
        Thu, 18 Apr 2024 06:59:04 -0700 (PDT)
Received: from sunil-laptop ([106.51.189.72])
        by smtp.gmail.com with ESMTPSA id km3-20020a056a003c4300b006eaa21301a7sm1488660pfb.162.2024.04.18.06.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:59:04 -0700 (PDT)
Date: Thu, 18 Apr 2024 19:28:54 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: [RFC PATCH v4 00/20] RISC-V: ACPI: Add external interrupt
 controller support
Message-ID: <ZiEnHtWbT04bXYmP@sunil-laptop>
References: <20240415170113.662318-1-sunilvl@ventanamicro.com>
 <87a5lqsrvh.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a5lqsrvh.fsf@all.your.base.are.belong.to.us>

On Thu, Apr 18, 2024 at 03:49:22PM +0200, Björn Töpel wrote:
> Sunil V L <sunilvl@ventanamicro.com> writes:
> 
> > This series adds support for the below ECR approved by ASWG.
> > 1) MADT - https://drive.google.com/file/d/1oMGPyOD58JaPgMl1pKasT-VKsIKia7zR/view?usp=sharing
> >
> > The series primarily enables irqchip drivers for RISC-V ACPI based
> > platforms.
> >
> > The series can be broadly categorized like below. 
> >
> > 1) PCI ACPI related functions are migrated from arm64 to common file so
> > that we don't need to duplicate them for RISC-V.
> >
> > 2) Added support for re-ordering the probe of interrupt controllers when
> > IRQCHIP_ACPI_DECLARE is used.
> >
> > 3) To ensure probe order between interrupt controllers and devices,
> > implicit dependency is created similar to when _DEP is present.
> >
> > 4) When PNP devices like Generic 16550A UART, have the dependency on the
> > interrupt controller, they will not be added to PNP data structures. So,
> > added second phase of pnpacpi_init to handle this.
> >
> > 5) ACPI support added in RISC-V interrupt controller drivers.
> >
> > This series is still kept as RFC to seek feedback on above design
> > changes. Looking forward for the feedback!
> >
> > Changes since RFC v3:
> > 	1) Moved to _DEP method instead of fw_devlink.
> > 	2) PLIC/APLIC driver probe using namespace devices.
> > 	3) Handling PNP devices as part of clearing dependency.
> > 	4) Rebased to latest linux-next to get AIA DT drivers.
> >
> > Changes since RFC v2:
> > 	1) Introduced fw_devlink for ACPI nodes for IRQ dependency.
> > 	2) Dropped patches in drivers which are not required due to
> > 	   fw_devlink support.
> > 	3) Dropped pci_set_msi() patch and added a patch in
> > 	   pci_create_root_bus().
> > 	4) Updated pnp_irq() patch so that none of the actual PNP
> > 	   drivers need to change.
> >
> > Changes since RFC v1:
> > 	1) Abandoned swnode approach as per Marc's feedback.
> > 	2) To cope up with AIA series changes which changed irqchip driver
> > 	   probe from core_initcall() to platform_driver, added patches
> > 	   to support deferred probing.
> > 	3) Rebased on top of Anup's AIA v11 and added tags.
> >
> > To test the series,
> >
> > 1) Qemu should be built using the riscv_acpi_namespace_v1 branch at
> > https://github.com/vlsunil/qemu.git
> >
> > 2) EDK2 should be built using the instructions at:
> > https://github.com/tianocore/edk2/blob/master/OvmfPkg/RiscVVirt/README.md
> 
> Hi Sunil,
> 
> I started playing with your work, and FYI: Using U-boot instead of EDK2
> works out of the box (with acpi.config added to U-boot).
> 
> I changed my rootfs/boot tooling like [1], and it boots.
> 
> (For those who prefer working with U-boot UEFI instead of EDK2.)
> 
> 
Hi Björn,

This is cool!. I was not aware that u-boot also supports ACPI on
RISC-V. Many thanks!

Thanks,
Sunil
