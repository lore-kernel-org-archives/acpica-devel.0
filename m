Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFED56457
	for <acpica-devel@lists.linux.dev>; Thu,  2 May 2024 09:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714642369; cv=none; b=f2kluj5eqM+g+yNwY4IubGwUbtIsYRxRzryiBss1s/Ryx9UdlCXPWUNv/gUtQdgNnWN6rJ70TpET0JsFftpC+dml5KIpBHcqzURu5HSfU/57zlvzruEzT2q6WuVoWeS5pQPnrFJIaLab+e6V1apvc3Lmnc72lxKbcb08WbKZg1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714642369; c=relaxed/simple;
	bh=+KdPWEN16wQ9Tm9ok2b58EnczYYvk8kPtRWjVxLHs/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1uStz136EMRsjEHwR6JV5GT63arkfBcFww0cc9ajm4kY0NgYPw/Wyvy+uRPwCbN4SnNSd2TvT9KSkBrQ81stAVaMeczYGdVMI80H3f0a+n+gMQfdqpGJ+e+qL1+N+d4kX4ygmcLRJZIDdFGi0FzXog2+eRU3Gc7jJSFmo1k08M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=kPPRWhN1; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="kPPRWhN1"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c71c7e2d40so1797167b6e.3
        for <acpica-devel@lists.linux.dev>; Thu, 02 May 2024 02:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714642367; x=1715247167; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FvW/lnO7fBno/xaBzZIt3Emz2T8DvtxIkgq7/bGwou8=;
        b=kPPRWhN1Ub50xOl9LJJPq0pmdPuxhnI1eMXP4Tud0euCAj9yUQyMTaJjZAfpuc+3ZB
         SYYBngfft2I7M7liOTKDBo4CabvLiZ4DrCgMQKu0yHou8kx0qPsw2jNnangtLPpHo+t/
         apGDaOZr/K4gGYvY+USn6UeB9JkXz63MZrfffbGXd3svRGj6zxP+29EB0Qy7arjQbd/p
         RbSbHScMz4P7al4e1+m5NdbiEWWL+uoO900ONdqWszUGZ4GY1fghmvdFBwd7Ne7vuUA2
         /8C9/twQ5FuBWU40zV7ZUWhv0OfX1XcGbnxkl62HXDNpzb82nwWolApfI3R2jCnt0u6J
         U/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714642367; x=1715247167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvW/lnO7fBno/xaBzZIt3Emz2T8DvtxIkgq7/bGwou8=;
        b=Q7LS/zZxhmyKade5MvdH8ffwB8La/vyv6tJIceszR60ILKoUGa9n/7l6AgOl4SbOaU
         JEto4Nm+yoyfV0Iv/Ryx11TRlh6yp2YDoHVlV5cvAkOPEr0m8GoHSaZg86CshgNKCtiE
         gvQMh/2jWIE5v6Hd3e65I5hqPuHxNlWtbDGEQ0aVtfpaWI0v4b3vnS5lSRZESsN5PD+m
         CK8XWJvluAFzZnVc10gjjk+aoDbXsaYVQ9QL7A5TXZBsn7Vx9YhFjxsKjLVC/AMyPAJq
         ZNsVfIJOfzTBs4aYgzySps63r9e7JBdJhnRaFsE72uVW1XwwZ/qiML/gzxLUmO+P3UWK
         rWgw==
X-Forwarded-Encrypted: i=1; AJvYcCUC5AUx/xiO24jJhAp2KUa5Z8/LFImSkgu9iivdaFr8u2w1EpHq4jBw9XntBfP0hp0Xh3fgBK92F68UQr8I6XRv8U2LbM3R2eG6qr3Q
X-Gm-Message-State: AOJu0YyiRh3RcnBOLmKisO151gsILQ0iJKhBE02Az3VsNG6wdiuQeOfL
	7FAKCB2lRNpNvR6scUxS7Y5CIyKwN9r1QVaEx+MdSPy1F59camZwYjvBW+MsYdE=
X-Google-Smtp-Source: AGHT+IF4b+lPGskb1gHK2IpUgfNkpEMYBXho2rUofukPTZVb0za3mVEu5Rsh7KTHfVzjAbIKdeiEtg==
X-Received: by 2002:a05:6359:4c9e:b0:18f:673e:fce2 with SMTP id kk30-20020a0563594c9e00b0018f673efce2mr6283164rwc.6.1714642367069;
        Thu, 02 May 2024 02:32:47 -0700 (PDT)
Received: from sunil-laptop ([106.51.190.19])
        by smtp.gmail.com with ESMTPSA id l25-20020a63ba59000000b0060795a08227sm692025pgu.37.2024.05.02.02.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 02:32:46 -0700 (PDT)
Date: Thu, 2 May 2024 15:02:33 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
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
Subject: Re: [PATCH v5 08/17] ACPI: pci_link: Clear the dependencies after
 probe
Message-ID: <ZjNdsWP46su9drAK@sunil-laptop>
References: <20240501121742.1215792-9-sunilvl@ventanamicro.com>
 <20240501165615.GA758227@bhelgaas>
 <ZjNcDyLRm9c7BAi3@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjNcDyLRm9c7BAi3@smile.fi.intel.com>

On Thu, May 02, 2024 at 12:25:35PM +0300, Andy Shevchenko wrote:
> On Wed, May 01, 2024 at 11:56:15AM -0500, Bjorn Helgaas wrote:
> > On Wed, May 01, 2024 at 05:47:33PM +0530, Sunil V L wrote:
> > > RISC-V platforms need to use dependencies between PCI host bridge, Link
> > > devices and the interrupt controllers to ensure probe order. The
> > > dependency is like below.
> > > 
> > > Interrupt controller <-- Link Device <-- PCI Host bridge.
> > > 
> > > If there is no dependency added between Link device and PCI Host Bridge,
> > > then the PCI end points can get probed prior to link device, unable to
> > > get mapping for INTx.
> > > 
> > > So, add the link device's HID to dependency honor list and also clear it
> > > after its probe.
> > > 
> > > Since this is required only for architectures like RISC-V, enable this
> > > code under a new config option and set this only in RISC-V.
> 
> ...
> 
> > > +	if (IS_ENABLED(CONFIG_ARCH_ACPI_DEFERRED_GSI))
> > > +		acpi_dev_clear_dependencies(device);
> > 
> > This is really a question for Rafael, but it doesn't seem right that
> > this completely depends on a config option.
> 
> +1 here, fells like a hack and looks like a hack.
> 
I can remove the config option. I just thought this would probably never
required to be called on other architectures.

Unless there is an objection, I will remove it in next version.

Thanks!
Sunil
> > Is there a reason this wouldn't work for all architectures, i.e., what
> > would happen if you just called acpi_dev_clear_dependencies()
> > unconditionally?
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
