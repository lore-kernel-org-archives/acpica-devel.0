Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA727558BB
	for <acpica-devel@lists.linux.dev>; Fri, 23 Aug 2024 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724394824; cv=none; b=QX5fB0nVRZCRPeAs3iZ7k6FTeb8YYnGEwiUwh1adJhGQ136uh28zAmULj1yOsY5e/3TR9GJlcUWRzqgh2R3pb2u0J7zMqO5ZqOUDx54zuzHTHFSRZKh0CewsdzGb5e3NEArV1wBO5Q6RSHNI7myPpIuZPpe9fH6Irl+tPTWL420=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724394824; c=relaxed/simple;
	bh=x0K0LEJWtcXiX9pS8782m4VauBznWN2r2hfMVYg5vPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmTFLySNV9o5gjYjmb4TtKAL6rlKOeiy7pEI8KomKhsmUFvNOh41SzPDoLCo5ATFqtHlxEYGIgNa/3aKYun36d3/fSeTbgi/sR3u+vRegxaPp5Bc6SdBZN5SGhT9kQe8Z7injXu0jJWVvYUVPa5dG27Mvsz82sKFo4iywCN5bwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=M2m8LWhG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="M2m8LWhG"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-428178fc07eso11446235e9.3
        for <acpica-devel@lists.linux.dev>; Thu, 22 Aug 2024 23:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1724394820; x=1724999620; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nwwa4zZWKWT0C7ngpvIXaYQp8a5Xf4joWxzD56LK+ns=;
        b=M2m8LWhGTm5oy/7RHjtOFLKoG6lx1c4m+VFKCNpmpWvJ8K0i+umeF7ZDFK71DKpT/3
         A4or87iE/VYwyIiHSIAECKfapdpxAL9gKAdjHErCxQUS27TAqCXNOHr0f23FXudXw6so
         41ophsWVcxU4zWQAqllgAmCPX9fq2nbAT7EekmV2FUrPULQNGHSRv/SffMK2293ZSghJ
         l/SXpBMErsC3GCNP6shTjr5pADHxKBNGKefWq6eJKOeZspjCfPycGKGJ0S0WmR4kWFy/
         6sA9yIPaoFdIKrFLFQlOZQKLRj/8yaYojurX7hTIUVdfkkJPJmF58pdztrkKUnV6FmhD
         a+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724394820; x=1724999620;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nwwa4zZWKWT0C7ngpvIXaYQp8a5Xf4joWxzD56LK+ns=;
        b=J9r/JJL1FT5vX73Tu9y4M7Dfk5DlIiGxtQrBVNbBLafNgT0iolBf20U032oEzYnlRH
         08PIoSbatYSgYH7wNBxGo3p1qkzobWnzNM1dvtckB3ftf3CrQ9aHaADful2yZ5FwigpS
         epSKypWRwzbvnd9CC8KePcxYLz64ILVhVwvjwi8hdsDGrkwm8c9Sv70WFkVM7bp8w+9o
         lSOEtGtKmUHBJwTODefp3glYemeh9A4RSA40xHK5yJ6HI18AXV0ChaX1PaOedfX7T+zr
         6ccdwnUTVr+/uJs7tzfN9yoGfLn0+7nt2D0wZV0sOb65ihUAd8CTWhja6SIRx9sqLqB8
         ilEA==
X-Forwarded-Encrypted: i=1; AJvYcCXWXxjsTemaj0QehvhyyRbLETeD9Z6jQ4cdQ/azJSXuH1D+Vs29dBJqg2jFB+03kWD/1eszCNS/9qasCbQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YxxquuBPxyBJl54KormVtpVhvj7W75Hg+7ZaoJdU0J7ealKPPDO
	Z3s1lhl8Tf9oc3553WjuwDL6KPAv7ecMTfDykUmESHw1O6rQ7oFjgnWKHdUlpUQ=
X-Google-Smtp-Source: AGHT+IE1rLgEUi/E+JRWhk5yegpaazjUMmQ/t/cN3D8r5PCsnRrmCPHJTAiKkoCLeX2MUJRaLJ7WWw==
X-Received: by 2002:a05:600c:4e01:b0:426:654e:16da with SMTP id 5b1f17b1804b1-42acd39e07cmr7246735e9.0.1724394820150;
        Thu, 22 Aug 2024 23:33:40 -0700 (PDT)
Received: from sunil-laptop ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abee8c2dbsm83828835e9.21.2024.08.22.23.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 23:33:39 -0700 (PDT)
Date: Fri, 23 Aug 2024 12:03:25 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Subject: Re: [PATCH v8 08/17] ACPI: pci_link: Clear the dependencies after
 probe
Message-ID: <ZsgtNbBLfP3SygYv@sunil-laptop>
References: <20240812005929.113499-9-sunilvl@ventanamicro.com>
 <20240822214415.GA351762@bhelgaas>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240822214415.GA351762@bhelgaas>

Hi Bjorn,

On Thu, Aug 22, 2024 at 04:44:15PM -0500, Bjorn Helgaas wrote:
> On Mon, Aug 12, 2024 at 06:29:20AM +0530, Sunil V L wrote:
> > RISC-V platforms need to use dependencies between PCI host bridge, Link
> > devices and the interrupt controllers to ensure probe order. The
> > dependency is like below.
> > 
> > Interrupt controller <-- Link Device <-- PCI Host bridge.
> > 
> > If there is no dependency between Link device and PCI Host Bridge,
> > then PCI devices may be probed prior to Link devices.  If a PCI
> > device is probed before its Link device, we won't be able to find
> > its INTx mapping.
> 
> This seems to explain why we want these dependencies, which is useful,
> but *this* patch only removes the dependencies.
> 
> Maybe this description should be in the patch that *adds* the
> dependencies, e.g., "ACPI: RISC-V: Implement function to add implicit
> dependencies"?
>
Okay. Let me move this to the patch you suggested.
 
> > So, add the link device's HID to dependency honor list and clear the
> > dependency after probe is done so that the dependent devices are
> > unblocked to probe.
> 
> This still claims this patch adds HID, which I don't think it does.
>
Please see below.
 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Tested-by: BjÃ¶rn TÃ¶pel <bjorn@rivosinc.com>
> > ---
> >  drivers/acpi/pci_link.c | 2 ++
> >  drivers/acpi/scan.c     | 1 +
> >  2 files changed, 3 insertions(+)
> > 
> > diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> > index aa1038b8aec4..b727db968f33 100644
> > --- a/drivers/acpi/pci_link.c
> > +++ b/drivers/acpi/pci_link.c
> > @@ -748,6 +748,8 @@ static int acpi_pci_link_add(struct acpi_device *device,
> >  	if (result)
> >  		kfree(link);
> >  
> > +	acpi_dev_clear_dependencies(device);
> > +
> >  	return result < 0 ? result : 1;
> >  }
> >  
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index 28a221f956d7..753539a1f26b 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -863,6 +863,7 @@ static const char * const acpi_honor_dep_ids[] = {
> >  	"INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c access to camera sensors */
> >  	"RSCV0001", /* RISC-V PLIC */
> >  	"RSCV0002", /* RISC-V APLIC */
> > +	"PNP0C0F",  /* PCI Link Device */
This is the change which I meant adding HID to the honor list. Do you
recommend to make this change separate patch so that it doesn't confuse
with adding a new HID to the probe match table?

Thanks!
Sunil
