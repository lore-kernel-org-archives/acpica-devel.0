Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D43215E7F1
	for <acpica-devel@lists.linux.dev>; Thu, 18 Apr 2024 11:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713440768; cv=none; b=Vo92CV5eP9myIRg9c4O/qGBH818jEShz5ZVQ738W86XIA6y0wQ6xhASCRzUPMlzkikKc7F55U6i4a5LHs1GB9RLF6YBsWx+qjnm3Q+pMvyY6Q6a8h8B5A9cNheXxfs/DjChJ2pNH++TyQNProkMlcDrz+SXKlLfTYjP5MjIr+Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713440768; c=relaxed/simple;
	bh=RRGuCpmn9QpJJtwiZl5qPKqvfeSljByY3/4eHt18EWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1qsKvd9Z7/ZS/thMTlkhFk1VkucO3ajZk4vAW+HiQFpVYxIPkz6DaN9tzdmA+qsLOqa0P0qmep9sNvKntzdJVWH5b9NUsBjVB1iJPOhyOEdmirJzOLzTvJhtlKrV6qGKDwZ0TnW6EJrDaIs/kuyILf5owgpV+l33bVJHnncAPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=CTRY/soJ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CTRY/soJ"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e424bd30fbso6730525ad.0
        for <acpica-devel@lists.linux.dev>; Thu, 18 Apr 2024 04:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713440765; x=1714045565; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tse31PpId242mWCWoF9F68b2IO88pQ6rFBjaTyilK9M=;
        b=CTRY/soJNBu59A2zngHTyWk2HT4mDUTHx/PRr/cE/YW5RBe7DO7IeFy04bvb+K13XE
         zQf0Xokz4JKxpcBSawH4LKJ5wgwTJWJXZVmauFqUOSFes0+8S9YbhsMaTWj2W+9luj3S
         cheftyT8P0v5AbgjuU6bn/DP1XxptzmElubjxgIDKoEVrKraebvbMMoO/4EqJEv8HxO4
         hbAWBMfl+0xRS7uJB6LMckb5KFXuIT8B9Jl2xCnBMQnNcHEjo+/NdyywQQZgYUhZMdKW
         eRuO8jxgjgXPVLrP8i0lJh8aI4W3dlMXKoPu7LACkwXNsxJvksSWFp5iB9EX0Zg1O9xw
         nG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713440765; x=1714045565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tse31PpId242mWCWoF9F68b2IO88pQ6rFBjaTyilK9M=;
        b=nLY8Y2mPLfW+IE2BnxoQHLY9Hd9oeCdNjPS343WRWG5kdsnp7cJIrJP1QALTQLK3Kw
         vnoquhqBBcpAmKfJy11+/8/WsSrEVAobMCqfXKKt8Un1vVn1dFlOiLdBb6F104wxqlrh
         ZLEbiaZfVikUetgvFSYj41XnieXmvwEIZPSynjRMjXFJQTHscPyxnzq4OAA8tL8HeyGT
         Zf3F81z1093C6hyp9uhmjyhwNO5nvUxMtvr7V2idrGJWvu770KlZSd+Q1iiyaTLxJ/O3
         hrjartcc1d889UohhtOXlMg0kHQ2uYWgDHVJnlcz3xem80s5MYyALF6xtPmyr88iCAv+
         1a8w==
X-Forwarded-Encrypted: i=1; AJvYcCUIcbc34hl+Ev9UXQVvKds1CgYXsnp8sHEmQp79EqXyJwL48xxfOVVIoaT+6VNUFFC8oetaP5BO+I2GLOStYFzseQ6Skg3/vk72sbnM
X-Gm-Message-State: AOJu0YzlRnnOXQZOnVpWl8vh55za1NIMJtOGicLpRJ5UvV27O1Cp3qFb
	THBzqlGAPREqh6WF4XKODIEWrlp6v9rqC+pt28sFs/qWzaGrRcjplpYqWS+nz/A=
X-Google-Smtp-Source: AGHT+IHRN0PX0++JRfnr2/T3yLJtW4R020dQU6g3OEB6EOIeUseXqxzCCZJlgMQ9PVF1Si/Jw1nqbQ==
X-Received: by 2002:a17:902:ec90:b0:1e4:911b:7a6b with SMTP id x16-20020a170902ec9000b001e4911b7a6bmr3458551plg.61.1713440764817;
        Thu, 18 Apr 2024 04:46:04 -0700 (PDT)
Received: from sunil-laptop ([106.51.189.72])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902ec8100b001e5cadbdf8csm1327734plg.37.2024.04.18.04.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 04:46:04 -0700 (PDT)
Date: Thu, 18 Apr 2024 17:15:53 +0530
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
Message-ID: <ZiEH8VF6VhCMnXz1@sunil-laptop>
References: <Zh41pOmtAJ0EcbiN@sunil-laptop>
 <20240416204653.GA164172@bhelgaas>
 <Zh/rroBTGTq/Q/FN@sunil-laptop>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh/rroBTGTq/Q/FN@sunil-laptop>

Hi Bjorn,

On Wed, Apr 17, 2024 at 09:03:13PM +0530, Sunil V L wrote:
<snip>
> 
> I think fundamentally there are two issues here.
> 
> 1) MSI domain should have been setup properly when
> pci_register_host_bridge() is called. I see that pci_arch_init() which
> is supposed to get called early calls x86_create_pci_msi_domain().
> pci_register_host_bridge() also calls pci_set_bus_msi_domain() to setup
> the MSI domain which can walk up to host bridge to find. So, not sure
> why PCI_BUS_FLAGS_NO_MSI is getting set. Is there an issue in walking up
> the tree?
> 
I think I understand now why this is happening on X86. In X86, even
though x86_create_pci_msi_domain() sets up the MSI domain, it never
informs IRQ framework. Only later in pcibios_device_add(), the device's
MSI domain will be set which is too late for this bridge logic. So, when
pci_set_bus_msi_domain() is called from pci_register_host_bridge(), it
will not get it.

It works in RISC-V (I guess ARM64 as well) because, the irqchip driver
for MSI controller registers using pci_msi_register_fwnode_provider().
But, if we set bridge->msi_domain = true in X86, it will disable MSI
even though it supports MSI which is really bad.

Please correct me if I am wrong with the analysis. If correct, what do
you think the way forward if using CONFIG option is not good? I tried to
register the domain in below commit but I don't feel it is a cleaner way.
https://github.com/vlsunil/linux/commit/d6cf76f10c225c94fffb286b7a3e803a4e37df54

Thanks,
Sunil
