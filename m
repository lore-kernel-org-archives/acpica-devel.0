Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CE713AA32
	for <acpica-devel@lists.linux.dev>; Tue, 16 Apr 2024 08:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713255856; cv=none; b=UyQQoRfsNY020JZ9fRtj/GDiVDfIpYcvz98tQWjQeEgH4bL5mhGWFpE2Wad5nUykjd9DOX5oB8OZo1BIW8cv87cEAhPCH15/lpwBnj+PYaDk49cQ2SxIylGevE0MKEOU4DJ87zN2fei1EtvzMPG0l64bNpsaPie5lKl7Dc99MMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713255856; c=relaxed/simple;
	bh=sze8yZb++qhFw0hrhcH+G01pDCr7nF4LIAaKF7TjURE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmkrZL0xJHgNNIFIShnTV54KvzLwY0jpV1+B/FKFLpWW3HN5BehSt93Nm6GpG+IIi1atvbh9haqdw1CaTUaHBXyjvARpPuaSeaL+Y2PFyh2waWlB0OgBw23JPNXicil5kp6bpo4YAw6KCzW7HR7LJuHOmmTwUkxngVSypeUNegk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=BMj28rco; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="BMj28rco"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso2805662a12.1
        for <acpica-devel@lists.linux.dev>; Tue, 16 Apr 2024 01:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713255854; x=1713860654; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A8bGjiZPk9FOE86PWXYntaE4YFnpmEJwu/r5kYeeL8c=;
        b=BMj28rco/F8+AyAHHdnIVdVdL9A9djXkiQOf7kbJx0nkfUKnrg6GO5AV1cKfKyu92V
         RSpEpfQUFVtIvJkdtQlYxSZHK2RQV7XeZeWfSSqDKQ32sdhd426w3O1jQB6eVS+vWg/G
         qcwECz82RWWykg6uYK8qs+fk3h42T7se2klJB/ptsOkKcJ55aUZwypkAK7diCr3CXaiH
         gwQ5xZEkNMspnEbCxU3I0QPFDu05nBiqJ1qzWYRTloV2DAWf9fTssPrHa1iOiJ/VbSsU
         ztRiltRkE308+hmRHJb74/RxnIiLKf3ndnRuUrmP2gkPnBcR1ZOhx1TdoFtxKsQTyB3r
         cIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713255854; x=1713860654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8bGjiZPk9FOE86PWXYntaE4YFnpmEJwu/r5kYeeL8c=;
        b=JCSKD2UuSKHxErvJN97+u4cI6tzphMobdhDbXu2tRSksaZnIlyQvK2YSSy7C6rvIBK
         utfMlbzNsLLJmcyftofsU/v41aaeP83XemVc078W7nyGeyZs+i3JJny82kSqqbaqYF4a
         XKyanh+2RIDXNEmLcOrLy+qD/6vy9aJjeD0hJ8c1D3WDIH8JuKtTdtqWTVRgOSDKgRfR
         OdulOamMqD8Q3GV2VQf+rr4KMRkeEoEP9cHCrug0cRlGrG9kEXPDpxgVW5H1nNZGMDP2
         GF9cgzLm1+UF8KpQKJkRAM1J334H84vCXJ0B1N9nX3YH5KRBie0pVFm4+8heytkX2yv6
         VuuA==
X-Forwarded-Encrypted: i=1; AJvYcCVCDXvMpiP/f4I5IxbrRhq1hO/Kr8M4CcMoPkFdpwBiAf7JZw/ztiN3WtGSNznK8syCvDx7fzvXmNt7Yrri/27u1DAGCj6Vqv6P7iwt
X-Gm-Message-State: AOJu0YzPcfJeMb6JfGqiWHMacTmebcBn56L2HwpUyq2/Uhhlj+Aaf8nD
	ytGt36Gw6xdabUPmYxQHMU0Gqup+J1kYK7klf2jwz6ZgbrGtyTiSfs9fMYOwZ1A=
X-Google-Smtp-Source: AGHT+IEtNrPBcSyqGZZnDLBEg+cxYbGo3RSOg3xz8lC9cOiauWkZaAkBaPfo4SIdnCTTCnH+XxMOOw==
X-Received: by 2002:a05:6a20:3c8e:b0:1a7:89bd:9e8d with SMTP id b14-20020a056a203c8e00b001a789bd9e8dmr12355925pzj.7.1713255854107;
        Tue, 16 Apr 2024 01:24:14 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id az21-20020a17090b029500b002a0187d84f0sm8458211pjb.20.2024.04.16.01.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 01:24:13 -0700 (PDT)
Date: Tue, 16 Apr 2024 13:54:04 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Bjorn Helgaas <helgaas@kernel.org>
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
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Subject: Re: [RFC PATCH v4 03/20] PCI: Make pci_create_root_bus() declare its
 reliance on MSI domains
Message-ID: <Zh41pOmtAJ0EcbiN@sunil-laptop>
References: <20240415170113.662318-4-sunilvl@ventanamicro.com>
 <20240415231523.GA139682@bhelgaas>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415231523.GA139682@bhelgaas>

Hi Bjorn,

On Mon, Apr 15, 2024 at 06:15:23PM -0500, Bjorn Helgaas wrote:
> On Mon, Apr 15, 2024 at 10:30:56PM +0530, Sunil V L wrote:
> > Similar to commit 9ec37efb8783 ("PCI/MSI: Make
> > pci_host_common_probe() declare its reliance on MSI domains"), declare
> > this dependency for PCI probe in ACPI based flow.
> > 
> > This is required especially for RISC-V platforms where MSI controller
> > can be absent. However, setting this for all architectures seem to cause
> > issues on non RISC-V architectures [1]. Hence, enabled this only for
> > RISC-V.
> > 
> > [1] - https://lore.kernel.org/oe-lkp/202403041047.791cb18e-oliver.sang@intel.com
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  drivers/pci/probe.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 1325fbae2f28..e09915bee2ee 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -3048,6 +3048,9 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
> >  	bridge->sysdata = sysdata;
> >  	bridge->busnr = bus;
> >  	bridge->ops = ops;
> > +#ifdef CONFIG_RISCV
> > +	bridge->msi_domain = true;
> > +#endif
> 
> Ugh.  I looked at [1], but that's not a very good justification for
> this #ifdef.  The fault mentioned in [1] would need to be fixed, but
> not this way.
> 

Thank you again for the feedback!

I agree. This is due to my limitation with knowledge and resources to
debug the issue happening on non-UEFI x86 system with some particular
PCIe RC. Also, I was worried that we get into a rat hole of
assumptions/quirks with various architecture/PCIe RC combinations.

For ex: I think the issue is, somehow MSI domain is not set at the time
of PCI host bridge registration in pci_register_host_bridge() causing
PCI_BUS_FLAGS_NO_MSI to be set. This causes pci_alloc_irq_vectors() to
fail. In portdrv.c, pcie_init_service_irqs() doesn't switch to INTx
handling if MSI can not be used. It switches only if pcie_pme_no_msi()
returns true. I couldn't find who actually sets up MSI domain bit late
on this platform so that it somehow worked when we didn't set this flag.

Unfortunately, I don't have system to root cause and fix this issue with
confidence. Also, I don't know if any other architectures have similar
issues which are not caught yet. Hence, I thought it may be better
just restrict the change to RISC-V.

Let me know your thoughts. If there are better ways, I will be happy to
update.

Thanks,
Sunil


