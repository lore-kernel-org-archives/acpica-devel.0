Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09A1154431
	for <acpica-devel@lists.linux.dev>; Fri,  3 May 2024 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714744792; cv=none; b=mgOq95oqVwYgQiYsuh0LqH0c721rwgnNGznkkoL4bLdsYRMyg/2hGBshFly8d8UxXJchsNLrQ0aZ5J4EwVS2Qc+qgT3qx07EUTl45Gr6goZ+0duBtaEuPetStxiIwRmAbyCNynJedTHeRdLX/h1d6iYctMvWmqHVHlSgnM2vxkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714744792; c=relaxed/simple;
	bh=9XTu69i9//N23QjLUaRVeITayCFaVH/ZcxE8frlF8/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLeJN6QYBVCZ+5chP+Oz62A09nsAJalPdOp2jmL1SyKohwmWVrm7YjA8C5GK1eXt6uKWISb1tNS19CQsuwFeE9MkuwpRijup5BTr0i7zc8RxrOqERJfTOa+MQEtv205EWpcHvaahu2E/5jad0lau1t4A/sKJlbtDk6M4T+B7KK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=nP/xno4A; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="nP/xno4A"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-de610800da0so4732586276.2
        for <acpica-devel@lists.linux.dev>; Fri, 03 May 2024 06:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714744789; x=1715349589; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ChPcRq4NfZHnrwL48HNhQ7iFI35ROHq79DvxMeghd44=;
        b=nP/xno4Ac1HCoy726q4+Fg5/rE+9jyQD5J7z3b7OB9Led+4jjeJoMQcyjL81H/TBhE
         6PvY8cpLgBCZrnimm8XVdhP1+VPB5xo6kkq+ZjWuKhUuq9tEm4FWDHFVuFzOouzrEpUc
         ZF1MAEZbBxEuhan5aP+H16XY21MUZ6x6Pq4t8BOpzxronxlGap948s+SsnrRulM4JBZ6
         qSSPwcUCpGrpcASZClizRS0WqC58GpermNtPCG1LN0dNfUTiLt2bbMFThb3MDEoJI6xv
         PZEv2nmP54QkJi7KCFeAn3yX07iolRLdZq1MgY9+xo246HuzUiIyFv4SEQ9xz6kuHl3U
         s/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714744789; x=1715349589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ChPcRq4NfZHnrwL48HNhQ7iFI35ROHq79DvxMeghd44=;
        b=SvUcdbFA2tviMf163Jr8hjzwdBwzdTbr5pC4xH0Ga5klKCCzP/YTo7jGX9p1NlKm/R
         Q+4UnSJ5vL8L7BK4RGK0H2lPM6SFJtn1K53L7CscYT//V5e5P8x0cIs//mdxMnsxE6Ud
         3MPdYwjzAxnwQaSsCUuaOdETKxI13bFjH8GtNc8d9m9MucQAR7MxDUiaAgcyws4FIUwT
         BhcM6LdJo/kOagU3ENZSCjl7akr4Tw74wWvz6lZQkMrpzMSWHLsUqT5KB4+ulKgbBu3W
         yq/VCPhi21904SELv2JvHNdP2tLe9yfr40otKFRFzDGtgUw5s/A9JaljCBj9l31KVXen
         Fs0g==
X-Forwarded-Encrypted: i=1; AJvYcCX1uT0Pa4jV/ePR/lW9Rd6rSIOZbDa55zbx9uR62n/YvLtgpPMum0sif/gmljxlaPL369XpVsBlhYycSxvUBGW+4vGb+TXMhu3YkpnF
X-Gm-Message-State: AOJu0YxGP5q1qOoZRe20f7U0Vmg30lFiVMEpm8h8fPNmz/+uv5FeTByw
	D8BTP2oJE4oNEW8Cfjy5f2CSFBfZ5K9Kgyl6c/dtTmaDRc9oRozHD8I/RF9vHew=
X-Google-Smtp-Source: AGHT+IFctvodowwbTmaaEDSmGBZj/O9adwDNYje40Gk9jTBEJueLXsMCVV/UKXpClCHAizcOHif2cQ==
X-Received: by 2002:a05:6902:246:b0:de5:e046:6ac with SMTP id k6-20020a056902024600b00de5e04606acmr2994231ybs.5.1714744789552;
        Fri, 03 May 2024 06:59:49 -0700 (PDT)
Received: from sunil-laptop ([106.51.191.139])
        by smtp.gmail.com with ESMTPSA id l14-20020a25bf8e000000b00de51b87bfefsm627782ybk.18.2024.05.03.06.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 06:59:48 -0700 (PDT)
Date: Fri, 3 May 2024 19:29:35 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Subject: Re: [PATCH v5 17/17] serial: 8250: Add 8250_acpi driver
Message-ID: <ZjTtx88zk4GvCImk@sunil-laptop>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
 <20240501121742.1215792-18-sunilvl@ventanamicro.com>
 <ZjNaR-YtVTm4pbP7@smile.fi.intel.com>
 <ZjNh0Llcx+0VHevy@sunil-laptop>
 <ZjNmdfR2J6hNnYle@smile.fi.intel.com>
 <ZjN3GQI3gegYOIgS@sunil-laptop>
 <ZjOy2G0qN5G076i0@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjOy2G0qN5G076i0@smile.fi.intel.com>

On Thu, May 02, 2024 at 06:35:52PM +0300, Andy Shevchenko wrote:
> On Thu, May 02, 2024 at 04:50:57PM +0530, Sunil V L wrote:
> > On Thu, May 02, 2024 at 01:09:57PM +0300, Andy Shevchenko wrote:
> > > On Thu, May 02, 2024 at 03:20:08PM +0530, Sunil V L wrote:
> > > > On Thu, May 02, 2024 at 12:17:59PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > > > This driver is not a duplicate of 8250_pnp. It just relies on UART
> > > > enumerated as platform device instead of using PNP interfaces.
> > > > Isn't it better and simple to have an option to enumerate as platform
> > > > device instead of PNP? 
> > > 
> > > Ah, then extract platform driver first from 8250_core.c.
> > > 
> > Let me know if I understand your suggestion correctly. Do you mean call
> > something like serial8250_acpi_init() from serial8250_init() and
> > register the driver directly in serial8250_acpi_init()?
> 
> Extract the code to be 8250_platform.c and update that file.
> I have locally the extraction of RSA code, I will see if I can help you
> with the rest.
> 
Thanks!. That will be helpful. TBH, I don't understand what to do for
extracting the platform driver code. There are already several vendor
specific UART drivers (ex: 8250_fsl.c) which are enumerated as platform
devices. 8250_core.c looks cleanly supporting such drivers which can
register themselves with the core. For generic UART, DT has 8250_of.c
and ACPI has 8250_pnp.c. But 8250_pnp.c comes with baggage of PNP
contract. So, the driver in this patch is similar to vendor specific
drivers to support generic uart devices which are enumerated as platform
device. I can rename 8250_acpi.c to 8250_platform.c if that is better.

Could you please help with a patch even if not compiled so that I can
understand your suggestion better? 

Thanks for your help!
Sunil
