Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E22210A09
	for <acpica-devel@lists.linux.dev>; Mon, 29 Apr 2024 06:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372874; cv=none; b=EKUFC6YnqbwLDuFNByyn7IH7BI8kNi7nHXT30TO5l03YHdQ8sydeDCQx8vggDqyWcyTV/cU8n0Ko+HFTZq9LNGvSp+SPkmxNbUsKxOfpJugy4hFwNygAMaFgjfRMvWcZeLSVYfzRiQMVBPPkkR1IGpBpwq4LysDf5QrDC1P6G+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372874; c=relaxed/simple;
	bh=YeRC4XxrlBzoc6aB9nHXzHEeLpZealXCAg5sLvD6yWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLmUcyzcpG7h8cPEGJfesC7OYU7+yzq6xV9nNT3EIF2DLpYgqBFQ/qX3UE5kxz32vyqzDf2N23WhjlaNXnQv8XFF9r2DK6U8h0CroQKI1tC6ZhkuMep5KhBjdt+0KSSvFpJheLWHLe0zWNCRaa61YslPeqUXCg3fz0tWNOwm9zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ZSPbsYuS; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ZSPbsYuS"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e2bbc2048eso35306135ad.3
        for <acpica-devel@lists.linux.dev>; Sun, 28 Apr 2024 23:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714372872; x=1714977672; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g3CHl/SFXqYAERGdLxtaMngC8S6DnU6XgXGwCxtAafo=;
        b=ZSPbsYuSeaGByNItTEW1ERBmA5H9AHHJ8ve4E+dT8tSjROl4ZCjAunExCvTH8Xx/j2
         yB4ygyWsfSZdNmejB8QvFh00iGMD4qbsahyhi6iFLM1hMvCtBK+KJUjQw9/LEoyhLBLG
         66R0H1lilf/cJfD4SCHKe7tGYPVwnf9V/4Zq5RWcRAOrR4EeodHtSCmaPmMHxL/LsYN8
         A0AeVpJhXsb3W0IJmib47imT+hNGIVEw+Qto60urwOq3CI8vsRmxI9bANF7TcXjLATZL
         ILBk0AHs1CGj+n/pvZ02zdD4YY0CBh47M6v8zwmt4UsiEwgV/hEsvU4VHaT3rss1NEct
         yLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714372872; x=1714977672;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3CHl/SFXqYAERGdLxtaMngC8S6DnU6XgXGwCxtAafo=;
        b=feFYXFOeaycIJJo3bNYCC5jeIFnwZ+A1xPVn7mH7uodY1MZ4PGD9z4SPmIz5flAYsD
         9cfyGEP60hgB+wqSa4FKv6JmTs0EQFwIh41seSsOVZA38FufQi001aVU9ewB4lqFyVMH
         nOcsjROuCqkJ7/xBNZThqvOZ5riOLVNL6cRHQyr5IGn+cuhKat3M5L+De6QVxJAdgB3y
         r2Gus8Z7Iqn5iLC6xYwZBTohaFO/pBtJSyB08J1a16BMTuEN9RJNftfINwqHldcQfHJp
         F9G+MR6SSmMip/KIY1tgmeHWPBonhgzRmTquFLoNIdU+gsypCPlIgBr6QtObbMWJ/mRC
         bAVA==
X-Forwarded-Encrypted: i=1; AJvYcCUecICmtsnEqJlgECimKvO6klcOqu01a0r67TLFWlxL1RPPPBJth/AQzKQ9yvWZedp31V2Uj3BLeen1rNCUb/z3W3haaNvv6Vtn7/I/
X-Gm-Message-State: AOJu0YyeJDylJTyeTiebnX8zwLmgkF2LL/E2Fnfc4YfisJQ0DhXpmmlG
	28oziy+QaCWE965j0p4FUUrYXf9dwvNPQ9RkE9LPA0BaBvFmUyxZ46MPizXp3UY=
X-Google-Smtp-Source: AGHT+IHJIq5O7lAJlnVgT2TPMMefYPHPYX81CZ0/PXoTk2cDvl0s5hdpuoLRaOXaOY+XM//0LK1HGQ==
X-Received: by 2002:a17:902:bf01:b0:1e8:32ed:6f6d with SMTP id bi1-20020a170902bf0100b001e832ed6f6dmr9271613plb.39.1714372871641;
        Sun, 28 Apr 2024 23:41:11 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.62])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902bf4900b001e26b7ac950sm19421830pls.272.2024.04.28.23.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 23:41:11 -0700 (PDT)
Date: Mon, 29 Apr 2024 12:11:00 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [RFC PATCH v4 00/20] RISC-V: ACPI: Add external interrupt
 controller support
Message-ID: <Zi9A/KQv5fB/8nB3@sunil-laptop>
References: <20240415170113.662318-1-sunilvl@ventanamicro.com>
 <CAJZ5v0gTzn3TDoh0+0UQjMeJVdU+z16dDOT_fKMhr0XrOxyRtA@mail.gmail.com>
 <871q6uir15.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871q6uir15.fsf@all.your.base.are.belong.to.us>

On Wed, Apr 24, 2024 at 07:55:50PM +0200, Björn Töpel wrote:
> "Rafael J. Wysocki" <rafael@kernel.org> writes:
> 
> > On Mon, Apr 15, 2024 at 7:01 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
> >>
> >> This series adds support for the below ECR approved by ASWG.
> >> 1) MADT - https://drive.google.com/file/d/1oMGPyOD58JaPgMl1pKasT-VKsIKia7zR/view?usp=sharing
> >>
> >> The series primarily enables irqchip drivers for RISC-V ACPI based
> >> platforms.
> >>
> >> The series can be broadly categorized like below.
> >>
> >> 1) PCI ACPI related functions are migrated from arm64 to common file so
> >> that we don't need to duplicate them for RISC-V.
> >>
> >> 2) Added support for re-ordering the probe of interrupt controllers when
> >> IRQCHIP_ACPI_DECLARE is used.
> >>
> >> 3) To ensure probe order between interrupt controllers and devices,
> >> implicit dependency is created similar to when _DEP is present.
> >>
> >> 4) When PNP devices like Generic 16550A UART, have the dependency on the
> >> interrupt controller, they will not be added to PNP data structures. So,
> >> added second phase of pnpacpi_init to handle this.
> >>
> >> 5) ACPI support added in RISC-V interrupt controller drivers.
> >>
> >> This series is still kept as RFC to seek feedback on above design
> >> changes. Looking forward for the feedback!
> >
> > I've looked at the patches and I don't see anything deeply concerning
> > in them from the ACPI core code perspective.
> >
> > The changes look reasonably straightforward to me.
> 
> Sunil, given Rafael's input, it sounds like it's time for a patch
> proper. This is really the missing piece to make ACPI usable on RISC-V!
> 
> Thanks for the nice work!
> Björn
> 
> FWIW,
> Tested-by: Björn Töpel <bjorn@rivosinc.com>
> 
Sorry for the delayed response. I was AFK last week.

Many thanks!!, Rafael. Let me send next version without RFC.

Thank you very much Björn for testing it.

Thanks,
Sunil
