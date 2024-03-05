Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC7D4D9FD
	for <acpica-devel@lists.linux.dev>; Tue,  5 Mar 2024 08:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709627548; cv=none; b=H44qqMWm/rI26jBXHPYyzMYEWnz+SXPvob7PpPZa/84vimiQtZUmtTyD+JXRC6m1oN71IezmLR5PfVl5tn7X5D9uPX/Xg315DlR9kJx7kO4F7iYCdOy+dcwd1a6rkNigOZUIIzw5+WQDfqqwI3xc8EmtTl+gicCxsRTMTYPfbAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709627548; c=relaxed/simple;
	bh=tqTaYVx4Sf4z2nZaPA9gTuNW0DhU57NkHahdzD5dQJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VoQxmdZ9w4W8SY8VuSOOPmm8qdlBo0+7+sMs84R1uDDbQV+Cz5j1iCoBo8viw6bc6R/vGYQ/03XVEEb2Ydepy5mwcAYRQ/KGU3aD+peNR8QnKoFKuRNkPvZ3VUr18iQOyzsS9YnEx/3NK2EYyR10rHwUpj0FDR+UuBmHe7nBv6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGF04w4Y; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGF04w4Y"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d09cf00214so67330701fa.0
        for <acpica-devel@lists.linux.dev>; Tue, 05 Mar 2024 00:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709627545; x=1710232345; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ethXSKdD3YM8zYFiv0Mh/2ibhnJt7eqBZOvLVeN7M8o=;
        b=nGF04w4YgGJK4Zn9RPPXBqUR3t76ttxZb0gHTv+3O97Xd7GDOLu18gT8xpc7qm7wcb
         d0Bz0bIHtnZH1PMKkuaS5Xag9XSXCDQIp95Eyre3iUfl8rLc5rpr673YgHHKcSQKxAq4
         NpLjmMSc7/gdtN13TTShGYXSr/pJ32ekChZ51e/otC8CokM9KwK/iAauY3ORSgQvgq8m
         umeos1YUNCeiPhs1MlSH9Mdb/QpN9VcZ57tpo+CGApg6u/n6RhR7+l1anf0uE5tGQ1f8
         4nzHVJ1OHlZxkkI7EzeWfr3kEIOYeUXEHrO6YQyznph0E2Z9AJd7ZtRwZvAnbhm7m80x
         FU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709627545; x=1710232345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ethXSKdD3YM8zYFiv0Mh/2ibhnJt7eqBZOvLVeN7M8o=;
        b=q4zlzI5Aknhwm6sHohoXP3SJg2RRckgsghZ+a/WatVczoVi31AlUWFeJOnZ785qRxm
         BBsuoRqnbJ3heUNN6g6cv7uT6ALpm/sWnepQY1BltTCjkrKa0ZQSkh6KMWc58EII1DaM
         tkKUQL5JCU8cdfaG79DUNciJW1PA2tnpne8T9RbELHlwCGFmEEH0sS9SdfN72pF/iXtB
         XUpV7jLqt5K6QqmlywqmrZD54tqw9FCHakjoKy88IkHtN3O37H4NGMTuIzmEgDXiBBxN
         BMAa2NoMs4h+m3FsiMPvV//9xxeiH0wI1i/EBssKzDi1p+sZEZOW7S1dq1n3V1yVD31+
         rZkA==
X-Forwarded-Encrypted: i=1; AJvYcCXmHo0IL7Dx2Y5/LjmO4picmrs7/sdqqM42gOeoCvHk5Q1TwYNS+QdbiyRQjKoxJhA4ONaz4GZx5pHEkEKtG0lwDboE1KrENXFiiqWE
X-Gm-Message-State: AOJu0YwYYCCFLku0oUbbFSDzIhgSKBcFKUe1IWn9yMcp4K2jF1A6/H2f
	iWjAhHFCXlmbI75mV80TDyqiGx0EcR8iIFutHZT23CUIcQaD9dDKBO6xigwg8g5Q71OtgYmDJng
	ehQGbMDLbzzdLz1QW4NJ+CKh2rvA=
X-Google-Smtp-Source: AGHT+IHOYeWGaFKAzUJPrDZmmHE+LVTyfiv0q3uVMfUxGU07PXgnFSmnCFMHXZtTfZpJfuf1uxbMfPp+8OPCiwRzXhU=
X-Received: by 2002:a2e:a23b:0:b0:2d2:b915:e073 with SMTP id
 i27-20020a2ea23b000000b002d2b915e073mr631884ljm.27.1709627544665; Tue, 05 Mar
 2024 00:32:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1706603678.git.haibo1.xu@intel.com> <0be49d4d7d7e43933534aad6f72b35d3380519fd.1706603678.git.haibo1.xu@intel.com>
 <ZeatCIUZ/eJa1WHs@sunil-laptop>
In-Reply-To: <ZeatCIUZ/eJa1WHs@sunil-laptop>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Tue, 5 Mar 2024 16:32:13 +0800
Message-ID: <CAJve8onPknQLfZNwUMUm3SSy8rPOJoLvcbzNAFB64EuznEn2jA@mail.gmail.com>
Subject: Re: [PATCH 4/4] ACPI: RISCV: Enable ACPI based NUMA
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: Haibo Xu <haibo1.xu@intel.com>, ajones@ventanamicro.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, Anup Patel <apatel@ventanamicro.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Greentime Hu <greentime.hu@sifive.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Jisheng Zhang <jszhang@kernel.org>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Baoquan He <bhe@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Chen Jiahao <chenjiahao16@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
	James Morse <james.morse@arm.com>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Evan Green <evan@rivosinc.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Tony Luck <tony.luck@intel.com>, Yuntao Wang <ytcoode@gmail.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 1:26=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com>=
 wrote:
>
> On Wed, Jan 31, 2024 at 10:32:01AM +0800, Haibo Xu wrote:
> > Enable ACPI based NUMA for RISCV in Kconfig.
> >
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  arch/riscv/Kconfig        | 1 +
> >  drivers/acpi/numa/Kconfig | 2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index bffbd869a068..e586ab959f34 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -438,6 +438,7 @@ config NUMA
> >       select HAVE_SETUP_PER_CPU_AREA
> >       select NEED_PER_CPU_EMBED_FIRST_CHUNK
> >       select NEED_PER_CPU_PAGE_FIRST_CHUNK
> > +     select ACPI_NUMA if ACPI
> >       select OF_NUMA
> >       select USE_PERCPU_NUMA_NODE_ID
> >       help
> > diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
> > index 849c2bd820b9..525297c44250 100644
> > --- a/drivers/acpi/numa/Kconfig
> > +++ b/drivers/acpi/numa/Kconfig
> > @@ -2,7 +2,7 @@
> >  config ACPI_NUMA
> >       bool "NUMA support"
> >       depends on NUMA
> > -     depends on (X86 || ARM64 || LOONGARCH)
> > +     depends on (X86 || ARM64 || LOONGARCH || RISCV)
> Is it possible to remove this if IA64 is removed now?
>

Yes. Arnd also suggest removing this totally.
Will update it in v2.

> Thanks,
> Sunil
> >       default y if ARM64
> >
> >  config ACPI_HMAT
> > --
> > 2.34.1
> >
