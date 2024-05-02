Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427F25FDB5
	for <acpica-devel@lists.linux.dev>; Thu,  2 May 2024 11:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714647672; cv=none; b=oVRDs0LXj/LaASfwjSLTY6aEyvcyxXhs0tpREjLLeFcgaDf4g0s1LhD7lsMsHcpzpEcPbTzobLHzfV6Ii/OGdTtzB1Jyh1l0qaTLsGnb5HFEn2ClVCqVJBzarkso0CR3vsimM6DoGdO742UUKKybIyY5KgRPD+8mDMoHwOzrQho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714647672; c=relaxed/simple;
	bh=ndLSvNTaHy7rcB+YkF1gfmdHrNAQTVgDr2rY9G9+Z/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhDIaMWGhbg+lJ0IXrxP+yIOA3nJgGDNiTQRqfm3KuCGz8CZv3vpmXltmH8sJ+vVkrUADdfKPt09sCAl5CEFCyve3//O0Rvy9DaIeM19AlluWkUet1sEsrVtKPo0R3saY8GqnTNgiUPZ263G+cnRqFrYWsebXWfP29pCig809Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=K6RvsGKg; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="K6RvsGKg"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-617e42a3f94so83567607b3.2
        for <acpica-devel@lists.linux.dev>; Thu, 02 May 2024 04:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714647670; x=1715252470; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yjTLbsaK8lFll8/qZ6Wbe+KOojRpVIeEGiQdgeTUV/M=;
        b=K6RvsGKgnmqjrbmQe157B5vOKfTPdSOlhRB2eWekEhtXoZw+GcumJur9URJzk1JMXj
         A3mofPm+BQ+jHpZlor5hJegymcrnPshmoLaHpHOd/tkE7P62ttYVTQrLpS8oPvY/jDmg
         6IM6gXLxlzOLR6dUCCL8swiVyC7NaLnwLugzgaYuawdNdrNc9TXWQykPLyPIWijiqcyE
         +h0G5n5z68Sljo4DWZnvOMVAd3iPZRo9f2szDwvBUXIiW9tkxt1JbE+g9RRhax+wFont
         dAVUeivWAHjyx/nt6a/Nk92P5O5B4rggF9OoAZaVwkw7990aPtD1eAsiJrdf+oVfZzX5
         SCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714647670; x=1715252470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjTLbsaK8lFll8/qZ6Wbe+KOojRpVIeEGiQdgeTUV/M=;
        b=CYj9hJHIDjLOjSmz9XKh/eAwUBRYvrZmtJ2p9g3TbhVTsjW91bppSj7hGtemAx7NzX
         MqmSGc3ghEF4vMoCoEEjMqj72SFiaMkHGZFZwZZ8n+b6Iwdx3diGU1hhrlSVE+7fA29P
         LSCA4nfMyNjckqcQ71t2puvHMprWTvAci16Z7r9JPyoQB7dh7ziULnkKIqcUkeEqzahR
         49Ky9Wjr27VDvntTbf/LhHIKXqgw5weimM19gywm3xI64Aww6FU41HGa3AOQFNONQkaH
         FmgI5zcEaUMHKLsLHVkqTb7c+0CDSJDFLbNvIlMF49xugbY5rcBjzfqpIup+ckCsqKwX
         zYMA==
X-Forwarded-Encrypted: i=1; AJvYcCWo46UhfAJq5GBqgosM1UkGxEp+S2e1u1aySWIig3KxlPmtBRrsyFXtIRn/sbNBOzt3HhY9ZpAQKADMmH6fTLULwWYiIT/vcU5MjxT4
X-Gm-Message-State: AOJu0YzVa5rfeUPltMCu7WeBwTy0O/I6RX18E8YHs2uOtPGg0N98khcY
	h4gp/BZJQmjX518c9g0hWDRzSyrdbH/Yxgv8RtPClHU/mpJEHmWXgNcoG/cMGyw=
X-Google-Smtp-Source: AGHT+IHfkJrlGnon/mEX5fWtLywYkDj4de083FrQTvrfO2XC94gdhaKM/ttBrgT+XJ2VbkvvaIQxaw==
X-Received: by 2002:a05:690c:d88:b0:61a:d2d9:5488 with SMTP id da8-20020a05690c0d8800b0061ad2d95488mr6160180ywb.7.1714647670339;
        Thu, 02 May 2024 04:01:10 -0700 (PDT)
Received: from sunil-laptop ([106.51.190.19])
        by smtp.gmail.com with ESMTPSA id dg17-20020a05690c0fd100b0061adfb01cc2sm147882ywb.90.2024.05.02.04.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 04:01:09 -0700 (PDT)
Date: Thu, 2 May 2024 16:30:50 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
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
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Subject: Re: [PATCH v5 03/17] ACPI: bus: Add acpi_riscv_init function
Message-ID: <ZjNyYkgpyAa47F4b@sunil-laptop>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
 <20240501121742.1215792-4-sunilvl@ventanamicro.com>
 <ZjNbvlUoCfa5UUHF@smile.fi.intel.com>
 <ZjNksbTQF1lMQ0k0@sunil-laptop>
 <ZjNnG6JqFCZGj1qv@bogus>
 <ZjNoy6KLtOCTe52q@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjNoy6KLtOCTe52q@smile.fi.intel.com>

On Thu, May 02, 2024 at 01:19:55PM +0300, Andy Shevchenko wrote:
> On Thu, May 02, 2024 at 11:12:43AM +0100, Sudeep Holla wrote:
> > On Thu, May 02, 2024 at 03:32:25PM +0530, Sunil V L wrote:
> > > On Thu, May 02, 2024 at 12:24:14PM +0300, Andy Shevchenko wrote:
> > > > On Wed, May 01, 2024 at 05:47:28PM +0530, Sunil V L wrote:
> > > > > Add a new function for RISC-V to do any architecture specific
> > > > > initialization. This function will be used to create platform devices
> > > > > like APLIC, PLIC, RISC-V IOMMU etc. This is similar to acpi_arm_init().
> > > >
> > > > What is the special about this architecture that it requires a separate
> > > > initialization that is _not_ going to be in other cases?
> > > > Please, elaborate.
> > > >
> > > This init function will be used to create GSI mapping structures and in
> > > future may be others like iommu. Like I mentioned, ARM already has
> > > similar function acpi_arm_init(). So, it is not new right?
> > 
> > Just to add:
> > 
> > This is to initialise everything around all the arch specific tables
> > which you will not have on any other architectures. We could execute
> > on all architectures but the tables will never be found. The main point
> > is why do we want to do that if we can optimise and skip on all other
> > archs.
> 
> You need to carefully write the commit messages. Some kind of the above
> paragraphs has to be in there.
> 
Sure, let me update the commit message on similar lines.

Thanks,
Sunil
