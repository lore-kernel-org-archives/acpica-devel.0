Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309661D2788
	for <acpica-devel@lists.linux.dev>; Tue, 27 Aug 2024 18:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782391; cv=none; b=mxVCr4fFJhJbJ1g1JIfxOyyMsB0ovRCB1R216vvwLibyVKLb+/p+NDpP2JGHgfUSONSC8nBtqRQ72XQNNB/qTuVPyMZN6MYYDDRkI5IWUkeDUkb0kkA17G3uxGfKg5xC9IDBTkuKw7FYhNubpGfDXEXF4lF8VMm70WPTbD2yaNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782391; c=relaxed/simple;
	bh=VcDmWN5tuvcf9Gn2Ph/J9APylvM2kII9TBKe7Yws0B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWepz65HSn2s+XRMg2QIiDqph3DHQ6itkgVYTbWpSXP1VqkkWz5sQSI6jS7cLNY5hJWnTe7tkkxL3FjqgtMHhFT7oCuDyxXWyrjawQJE5U5qkJVt903vUeNrjRXTkT6lc+7RAY79cK29hKafidvQjlMuh79uVQH6aUVu7HAeXS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=BYEwyRFg; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="BYEwyRFg"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7143ae1b48fso3372728b3a.1
        for <acpica-devel@lists.linux.dev>; Tue, 27 Aug 2024 11:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1724782389; x=1725387189; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MPA+hJJLDVmD4KICeVltx2lJ4690a/Dvth1Aghkw/GI=;
        b=BYEwyRFg3ZGPHvBiP2YOKW4WPwAZDuA48oFY3VOnyeeIWRt7PjcRKCZjtVcGLc3kZ6
         dHQGEZT+IdPO+nnSIjVMJ2oFEHwMaf1HX8wOUmMeCck5WoeDYHqP5CVODPhR0zWQLRnz
         P/99jMb4AFeEE0aGKAZitbYqwt/qftu5FT/p0xDf8Mf2ygZsGEPORs/IocwS3sDSQn0z
         wXqA/YMu/viBTScV493ru2U4FeTAgzpFTQSE6l88B8Ie3WNSah/E7Vjp5IZGkEVg9hwO
         lXyLuMrSQWu78Hg7HbMwo4gz5YbqYFbjaQN7nkPPGIzPo6CbKFTTS6zmFvZd+mHYbiJM
         jl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724782389; x=1725387189;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MPA+hJJLDVmD4KICeVltx2lJ4690a/Dvth1Aghkw/GI=;
        b=cplvqIraT+GJFYgqcxurXJR20Q6IYlRQbc9jwX+gmh0Kv8cv5pv2OTrXD32nfL4ECd
         5dpRUfiaxPX4DszU4AYq5is9pM0r4A56IQ/nT8ktX/R1jGjvEjziZ2AVqBoHRbDquezC
         MD29V3T7caOwY2vs0NcxpomYuioXp7Fls5qkyncpoQPMYI8NJr6sccevgsaYF2ElMmyi
         n/O2ZpTxgpMXpKWnxePI3CLYRbbhGd7sjMqE78pmOT84kLabhXyaqaIEE2JSWz/xunK9
         xeciVt8aTGZ0hen+TK32HCv7p8EDXc/8gXHcj6FF9olwompX/xh9wnbZSr64KrAKxVM6
         vOZA==
X-Forwarded-Encrypted: i=1; AJvYcCVP3cARzIkD9SKJglb6QczoKlxh5pUqicW/HAg9guBDR3lbxvSfWUrEVXbty3+4qUWTvIW/OJEyz+t289Q=@lists.linux.dev
X-Gm-Message-State: AOJu0YyznbklvLJZOAkclhYvwtsQrGTlbKnc8ypm5XUVD7cyuDmxhOSK
	5y5OvehrUBDyDIDd/xmuoGkJMQ7s/4VCV0p0pGtq48rSqURXnY2qfB3flCZGXAk=
X-Google-Smtp-Source: AGHT+IGEsVPP4TjFJ+n/ifWb2tjPXQhtvEJKI4QpcXf0fpsIED85YBXgVczc0V+0pl8DdWJzUA5R6g==
X-Received: by 2002:a05:6a00:91db:b0:70d:311b:8569 with SMTP id d2e1a72fcca58-71445ed4f93mr12988732b3a.26.1724782389449;
        Tue, 27 Aug 2024 11:13:09 -0700 (PDT)
Received: from sunil-laptop ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342e09c3sm8820322b3a.122.2024.08.27.11.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 11:13:08 -0700 (PDT)
Date: Tue, 27 Aug 2024 23:42:58 +0530
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
Message-ID: <Zs4XKootCrW5ZPy7@sunil-laptop>
References: <87mskzcnmf.ffs@tglx>
 <CAJZ5v0imJcU4cwDuZKEvGf93fZm4ea4s2Ocp3Cnfb3+nBQ0-Gg@mail.gmail.com>
 <Zsy3o_N8hvc6GfTp@sunil-laptop>
 <CAJZ5v0hxoT9tBjm3xRPU4fHx3MgHfYAx_Vyf4oe2toa3GWAN+Q@mail.gmail.com>
 <87jzg3c7bz.ffs@tglx>
 <CAJZ5v0iMpaxBevgPWmD2Ym_JG1ChkjzVFf22fV7Xw8-ssg9+Ag@mail.gmail.com>
 <Zs4HCZH3M9nRXUvu@sunil-laptop>
 <CAJZ5v0i-8N8VG-D4FRh0qFxt44Ax4TKY_CiFhZxLCzkhQrt0=Q@mail.gmail.com>
 <Zs4NcmM79kMUc7Ol@sunil-laptop>
 <CAJZ5v0hRWxNSrx9XPBdsU-mQpDurRJAUmzHtHNkyCTf0Hz1TgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hRWxNSrx9XPBdsU-mQpDurRJAUmzHtHNkyCTf0Hz1TgQ@mail.gmail.com>

On Tue, Aug 27, 2024 at 07:56:52PM +0200, Rafael J. Wysocki wrote:
> On Tue, Aug 27, 2024 at 7:31 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
> >
> > On Tue, Aug 27, 2024 at 07:12:11PM +0200, Rafael J. Wysocki wrote:
> > > On Tue, Aug 27, 2024 at 7:04 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
> > > >
> > > > On Tue, Aug 27, 2024 at 06:20:24PM +0200, Rafael J. Wysocki wrote:
> > > > > On Mon, Aug 26, 2024 at 11:22 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > > > >
> > > > > > On Mon, Aug 26 2024 at 19:27, Rafael J. Wysocki wrote:
> > > > > > > On Mon, Aug 26, 2024 at 7:22 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
> > > > > > >> There will be a conflict in PLIC irqchip driver due to a recent patch [1].
> > > > > > >> This patch is not in latest RC5 release but in linux-next. I usually base the
> > > > > > >> series on latest RC release. Should I rebase to linux-next in this case
> > > > > > >> and send the next revision of the series resolving the conflict?
> > > > > > >
> > > > > > > No, please don't.
> > > > > > >
> > > > > > > That will be resolved at the merge time.
> > > > > >
> > > > > > Alternatively you can pull
> > > > > >
> > > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-08-25
> > > > > >
> > > > > > which I'm about to send to Linus latest tomorrow morning. That contains
> > > > > > the conflicting change.
> > > > >
> > > > > So I've applied the series on top of the above.
> > > > >
> > > > Thanks!
> > > >
> > > > > This included a full-swing rebase of the last patch, which I hope I've
> > > > > done correctly, but Sunil please see
> > > > >
> > > > Yeah, sorry about that. You have resolved most of the conflicts but few
> > > > are missing (which were not obvious anyway). Could you please take below
> > > > commit and squash?
> > > >
> > > > https://github.com/vlsunil/linux/commit/c85f9d0dc31c0e77916ecdbb457748c05cf4e75a
> > >
> > > Can you please send me a diff?
> > >
> > Hi Rafael,
> >
> > I have sent the diff to you. Hope that is fine.
> 
> Squashed and pushed out, please see
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=9153fdae30867fe5d71f6a15b8a1974d7e801f39
> 
LGTM. Thanks!
