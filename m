Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F79184E
	for <acpica-devel@lists.linux.dev>; Mon, 27 May 2024 04:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716785542; cv=none; b=uTyxpf9EWabZVmlF5VTnghUGJ1EopbmYyipX5QrImnZC4Zpt4U9ctQP7ERSMIQr65fRJEZYcpPHFcmIXbwI8EpJz+n9XowhwFmcBPFJ7KobWLZ7BUa9ek7HH73Dj9YhULQr536sPvMsY9borJOyfEUOM+OrChHiH+UMPj/KQKe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716785542; c=relaxed/simple;
	bh=AMS5ARv3IfVq3Q8iY1GykVsvHQU5Z7iIP9RDyXjiVic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRiziyQJmXzYP3702uUMhbxyNLaB+Zdfpdc7BES1Eia4eamcxKJicscQcwjzRvKXStmTg1nNHgJXcMj+qvok5StJUhp+3RiJZqZWXPhuIL+luA948RATKoNj9HpbIoik5eXaHzpXKwj+r/UKNAtHuTfSDa8IuJl7LCUGSgTVxrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Km8x4coa; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Km8x4coa"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f966840af7so2173623b3a.2
        for <acpica-devel@lists.linux.dev>; Sun, 26 May 2024 21:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1716785541; x=1717390341; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7OwVnHZBL6wTRkCGzMu3WG8eEJumBpr030yY2OMz5XY=;
        b=Km8x4coaYFl25wQnXOqHGgj6j/+Kv36pRxnB8jWb7lBegU/rc6SR1n5kbO0mnYe3ob
         xdeX3/hvzHt2NlYy9iGT2gBcXk8LrBvKkTWSTFKBQjXwM5Y5ECnSQtgk3COsZ9ORR3Dg
         QIN5so0d2uMJPy4DYq9jjm//KxBCIa9xZyjPAEOqF5k0nyMa1vYnf30ccbBiiaSBxqg3
         IwFDuGE2+AGe5+R12KJB4PJWq6MrHwzDbKpc0/Q7O6Jc2zAge6/FNe6quFmALT+Y52Au
         mrL8an1kBk+aPCEV/rvQCJQ+ZM6LJZqxwljANinuaPKlRVC5q96RymiZdLHRKRTntEGX
         s84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716785541; x=1717390341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OwVnHZBL6wTRkCGzMu3WG8eEJumBpr030yY2OMz5XY=;
        b=TkxX2EKhqvtqoJQytxlv1NeOqv0VY5PDKEJi+jXhoIf4zE2HQ5zGIUvGH6/adCXeok
         Lbp8Ux9qCTDZ9u2rPMHNsg3mVCD2TrKjscRnGLO84LhZF8xnaoiryjvbtx0Pk+y9s5ad
         6JocP8YUI+GjM3tUph1pkqlaRflq6evw+SK5G7EySaLLvqkm8HgdJGKLpcsvanXcfb3i
         XFUl/fWUiKAGfz+GEVMn0S15Zrp4xTxw0x7UGfnq4P0PyvWm3NKUMo7XBzvSxHW7KJv2
         vTsPX5Vcw64afOJAzHxEFpKCO2/mVDEoF18RdhOCzWiA6CprviyB9vgqBdkivsBPlWlG
         Sa+A==
X-Forwarded-Encrypted: i=1; AJvYcCUzuE8kyj31QFe3yxSx5lVfjwl/l9qtO99fSSrT0MRkJ6GhZMwWSgZglgRbyhygD01RkuEaK0QIcnLo3UfFZo55oknqhaWp+1K9aMkE
X-Gm-Message-State: AOJu0YxO0M2vU0fs0X6wcc4RFelor50pxm7fTedDonr5qiNS00Q6Wcy9
	e4pvjEdnwT7V9BE7rGttOifNPcAhvnwEY01XU6NmzGB8v3aWhnnE8/Kv/86Psfs=
X-Google-Smtp-Source: AGHT+IH1+6Rmi8dE36D+B+xJAB7lUPPIYa2o+TDUzseyC6rijf8D9sllaHoXY4NG8W+kwmTTtncYfQ==
X-Received: by 2002:a05:6a21:191:b0:1a9:d6e2:66e9 with SMTP id adf61e73a8af0-1b212d4aee2mr9906286637.28.1716785540658;
        Sun, 26 May 2024 21:52:20 -0700 (PDT)
Received: from sunil-laptop ([106.51.188.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f483584be5sm19427935ad.258.2024.05.26.21.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 21:52:20 -0700 (PDT)
Date: Mon, 27 May 2024 10:22:08 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Subject: Re: [PATCH v5 14/17] irqchip/riscv-imsic: Add ACPI support
Message-ID: <ZlQReOytuJcMsXUW@sunil-laptop>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
 <20240501121742.1215792-15-sunilvl@ventanamicro.com>
 <871q5sfatm.ffs@tglx>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q5sfatm.ffs@tglx>

On Fri, May 24, 2024 at 12:00:21AM +0200, Thomas Gleixner wrote:
> On Wed, May 01 2024 at 17:47, Sunil V L wrote:
> 
> > RISC-V IMSIC interrupt controller provides IPI and MSI support.
> > Currently, DT based drivers setup the IPI feature early during boot but
> > defer setting up the MSI functionality. However, in ACPI systems, ACPI,
> > both IPI and MSI features need to be initialized early itself.
> 
> Why?
> 
Sorry, commit message got truncated by mistake. Basically, in ACPI PCI
scan happens very early and there is no concept of msi-parent/dependency
on MSI controller like in DT. It just assumes MSI is setup already. Due
to this, we need to setup MSI controller early as well.

> > +
> > +#ifdef CONFIG_ACPI
> > +
> > +static struct fwnode_handle *imsic_acpi_fwnode;
> > +
> > +struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev)
> 
> Why is this function global? It's only used in the very same file and
> under the same CONFIG_ACPI #ifdef, no?
> 
For platform devices using MSIs, we need a way to determine the MSI
domain. This function is exported so that platform device like
APLIC/IOMMU can find the MSI irqdomain.

For PCI, pci_msi_register_fwnode_provider() is registered by the MSI
driver for this purpose.

Let me know if this can be made better.

> > +{
> > +	return imsic_acpi_fwnode;
> > +}
> > +
> > +static int __init imsic_early_acpi_init(union acpi_subtable_headers *header,
> > +					const unsigned long end)
> > +{
> > +	struct acpi_madt_imsic *imsic = (struct acpi_madt_imsic *)header;
> > +	int rc;
> > +
> > +	imsic_acpi_fwnode = irq_domain_alloc_named_fwnode("imsic");
> > +	if (!imsic_acpi_fwnode) {
> > +		pr_err("unable to allocate IMSIC FW node\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	/* Setup IMSIC state */
> > +	rc = imsic_setup_state(imsic_acpi_fwnode, (void *)imsic);
> 
> Pointless (void *) cast.
> 
Okay.

> > +	if (rc) {
> > +		pr_err("%pfwP: failed to setup state (error %d)\n", imsic_acpi_fwnode, rc);
> > +		return rc;
> > +	}
> > +
> > +	/* Do early setup of IMSIC state and IPIs */
> > +	rc = imsic_early_probe(imsic_acpi_fwnode);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = imsic_platform_acpi_probe(imsic_acpi_fwnode);
> > +
> > +#ifdef CONFIG_PCI
> > +	if (!rc)
> > +		pci_msi_register_fwnode_provider(&imsic_acpi_get_fwnode);
> > +#endif
> > +
> > +	return rc;
> 
> Any error return in this function leaks the firmware node and probably
> some more stuff.
>
Yeah, fwnode needs free up and need to update the code a bit. Thanks!
 
> > +}
> > +
> > +IRQCHIP_ACPI_DECLARE(riscv_imsic, ACPI_MADT_TYPE_IMSIC, NULL,
> > +		     1, imsic_early_acpi_init);
> > +#endif
> 
> ...
> 
> > -	/* Find number of interrupt identities */
> > -	rc = of_property_read_u32(to_of_node(fwnode), "riscv,num-ids",
> > -				  &global->nr_ids);
> > -	if (rc) {
> > -		pr_err("%pfwP: number of interrupt identities not found\n", fwnode);
> > -		return rc;
> > +		/* Find number of guest interrupt identities */
> > +		rc = of_property_read_u32(to_of_node(fwnode), "riscv,num-guest-ids",
> > +					  &global->nr_guest_ids);
> > +		if (rc)
> > +			global->nr_guest_ids = global->nr_ids;
> > +	} else {
> > +		global->guest_index_bits = imsic->guest_index_bits;
> > +		global->hart_index_bits = imsic->hart_index_bits;
> > +		global->group_index_bits = imsic->group_index_bits;
> > +		global->group_index_shift = imsic->group_index_shift;
> > +		global->nr_ids = imsic->num_ids;
> > +		global->nr_guest_ids = imsic->num_guest_ids;
> >  	}
> 
> Seriously?
> 
> Why can't you just split out the existing DT code into a separate
> function in an initial patch which avoulds all of this unreviewable
> churn of making the DT stuff indented ?
> 
Sure, makes sense. let me create separate patch first as you suggested.

> > +#ifdef CONFIG_ACPI
> > +int imsic_platform_acpi_probe(struct fwnode_handle *fwnode);
> > +struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev);
> > +#else
> > +static inline struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev)
> > +{
> > +	return NULL;
> > +}
> > +#endif
> 
> Oh well.
> 
I guess this is related to your prior comment about the need to make
this public function. Let me know if I am missing something.

Thanks!
Sunil
