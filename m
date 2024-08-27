Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F421CFEBA
	for <acpica-devel@lists.linux.dev>; Tue, 27 Aug 2024 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724779904; cv=none; b=VCxDkfPxtVKCIyPx/i1pel6RUJlzie37ZoCzz3BfIT4WmPpMzFp8UqCizjlz/6fT4MXWuEa+5uwM1WBSQpWDohH+Iva/WlJdlyPVBZ9GmzwAlt7NY+3jBjrF3BpU2G+bGqWcpu4HHNw3jchiN0nxxuS9ol58LQVcGLn5Am1b9c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724779904; c=relaxed/simple;
	bh=lMxqEwCHue8352wDt5PH7yOS5++RVWZI4siqNz83c6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=taUZezG/ozuuMAX8UN8FtfmfKw7rmVp/+fRqLGmfftanyBtegiSyOa2A0CgzQTBVtHO9ACTpIWM0dGHtAiq1McwOH4cjlxE17ttcpqwB6rQ01VkftXU5Dv6cdsbjwj/tPNkXJj4NwMFz3Ryvo3nz2PTxVBe7lqPlLiIhjhB6o/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=jyRsSfUP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="jyRsSfUP"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-202508cb8ebso39160095ad.3
        for <acpica-devel@lists.linux.dev>; Tue, 27 Aug 2024 10:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1724779902; x=1725384702; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eyakK3kXJdL4Hi3Zxsy/Z79bQ5vm7LShwCBS+rqjrc0=;
        b=jyRsSfUPq4g4sgd4WfB0H1cDJxGt0L9gFEcoGxT4fjv6jVfVKBGf6SyDAslAvPuJD6
         Iv5KdE0hjifuTQuRGHATOHhhHMg75vHWVV84EN9+CRO4MVOzd7hHjPjawazLz6eIB/8T
         EGJwlFAnU1fAECnKx/JQIZxiI9hXFeosdX2o7CxuHIpmSZ/Qe1IYo8rtXHfEV3EMWvvX
         3O8yevD0EkH/nd8hvMQO9sRnjbYakHF9hIU19ugs/dDsjm4LjepmL3iFrOCeeHfnwvIM
         /KDU961Cxc4pO3xTZliD7f6utk0kFc3Ux2BhMwimqK13Sq1hXQvmXcGFW/JOifXOuUUk
         FdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724779902; x=1725384702;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eyakK3kXJdL4Hi3Zxsy/Z79bQ5vm7LShwCBS+rqjrc0=;
        b=Y80APUAIQS7Fnb3fH5Jq97bhmfMTJjl1iXn+CNKbkWyNTiNdAtEAP2KlR7eipGID4l
         yh7f73Wr4hr8kVv1o3L2uBjKMajPdnDYW3p2AkpGDDG61BeuDVljzQPecUxjOSqIUkav
         yPSU6aOPepDxYmMN9fJ0PBnKiMqKCVMBMxaoTq0GKacCGg7OeFDjqX0yi7TjtIAmqzLC
         KiX2uN7Vz/i08f3+SXvd8rnFNh1Tm9M8PytfeyZSrKDY4Lv7XjVOaFqKV1eP/m1GBM9C
         xnM6jYjNTrFnbzSDS0NFaJe9USrhn4XwE2R9zuArSeXcsj5U6544xYAuDZAlgYKD8Shm
         33Kw==
X-Forwarded-Encrypted: i=1; AJvYcCU7/AVXUTCjcq8/+Eid7LbFqbBkycXroE43qoZ4nT5K9pJMlsjIz+Kcnn/VWutM5guvqfawk3yZP81hOxI=@lists.linux.dev
X-Gm-Message-State: AOJu0YxLcaE4NE/m7pMT8AZAOHMlLvB4GqOo7yRV1IfV9HNDydIg0Vup
	Ektrc9X9l1otPZreBSK0WZJdzJLsRtZ1g2hkuyRbIc61B0z0KLPfWlCY4Baas2E=
X-Google-Smtp-Source: AGHT+IHflfR+4oEKIX2AdkLpfmbDgIyQiynrQVhbNue6r8R5xP1CRH6FV9dXMTMD0eIz75yo1iaVkQ==
X-Received: by 2002:a17:903:2349:b0:201:cda4:69cb with SMTP id d9443c01a7336-204df029fbamr35148895ad.9.1724779901775;
        Tue, 27 Aug 2024 10:31:41 -0700 (PDT)
Received: from sunil-laptop ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385566611sm86220445ad.2.2024.08.27.10.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 10:31:41 -0700 (PDT)
Date: Tue, 27 Aug 2024 23:01:30 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
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
Message-ID: <Zs4NcmM79kMUc7Ol@sunil-laptop>
References: <20240812005929.113499-1-sunilvl@ventanamicro.com>
 <ZrlgVUXC_dCW9ISM@sunil-laptop>
 <87mskzcnmf.ffs@tglx>
 <CAJZ5v0imJcU4cwDuZKEvGf93fZm4ea4s2Ocp3Cnfb3+nBQ0-Gg@mail.gmail.com>
 <Zsy3o_N8hvc6GfTp@sunil-laptop>
 <CAJZ5v0hxoT9tBjm3xRPU4fHx3MgHfYAx_Vyf4oe2toa3GWAN+Q@mail.gmail.com>
 <87jzg3c7bz.ffs@tglx>
 <CAJZ5v0iMpaxBevgPWmD2Ym_JG1ChkjzVFf22fV7Xw8-ssg9+Ag@mail.gmail.com>
 <Zs4HCZH3M9nRXUvu@sunil-laptop>
 <CAJZ5v0i-8N8VG-D4FRh0qFxt44Ax4TKY_CiFhZxLCzkhQrt0=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0i-8N8VG-D4FRh0qFxt44Ax4TKY_CiFhZxLCzkhQrt0=Q@mail.gmail.com>

On Tue, Aug 27, 2024 at 07:12:11PM +0200, Rafael J. Wysocki wrote:
> On Tue, Aug 27, 2024 at 7:04 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
> >
> > On Tue, Aug 27, 2024 at 06:20:24PM +0200, Rafael J. Wysocki wrote:
> > > On Mon, Aug 26, 2024 at 11:22 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > >
> > > > On Mon, Aug 26 2024 at 19:27, Rafael J. Wysocki wrote:
> > > > > On Mon, Aug 26, 2024 at 7:22 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
> > > > >> There will be a conflict in PLIC irqchip driver due to a recent patch [1].
> > > > >> This patch is not in latest RC5 release but in linux-next. I usually base the
> > > > >> series on latest RC release. Should I rebase to linux-next in this case
> > > > >> and send the next revision of the series resolving the conflict?
> > > > >
> > > > > No, please don't.
> > > > >
> > > > > That will be resolved at the merge time.
> > > >
> > > > Alternatively you can pull
> > > >
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-08-25
> > > >
> > > > which I'm about to send to Linus latest tomorrow morning. That contains
> > > > the conflicting change.
> > >
> > > So I've applied the series on top of the above.
> > >
> > Thanks!
> >
> > > This included a full-swing rebase of the last patch, which I hope I've
> > > done correctly, but Sunil please see
> > >
> > Yeah, sorry about that. You have resolved most of the conflicts but few
> > are missing (which were not obvious anyway). Could you please take below
> > commit and squash?
> >
> > https://github.com/vlsunil/linux/commit/c85f9d0dc31c0e77916ecdbb457748c05cf4e75a
> 
> Can you please send me a diff?
> 
Hi Rafael,

I have sent the diff to you. Hope that is fine.

Thanks!
Sunil
