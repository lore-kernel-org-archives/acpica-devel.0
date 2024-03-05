Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37EA3D0C1
	for <acpica-devel@lists.linux.dev>; Tue,  5 Mar 2024 05:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709616409; cv=none; b=fhEVdy8478nHoJwTD1JXtvpMrOT63bgAPH7WfaUFixNFCM+lhDomWkb45lJKJXsTSnjKlEtXaVJlbNZLX2kBjDZzc/OOiu59Om9EGvsCFHLyLxMa33Hu+t9oU+eKGlB37iE7kDU5WP83BO/fzTjyNvlpfR+aUIlX5HPzyyNcz0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709616409; c=relaxed/simple;
	bh=IUUnXu41nv70y8HvfDJJUOOnZ7pf++QXfILZ3C80xAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COjM5FIWl3KspdV9ukWD4VlqgDzY08Bg/udzDPr6uw5PzMwD2MA1h5+8Y5Vanr5STdHGfQ1ah6Pyr7P7Du/jYFvwNPfyOWkzwCLYEW1kg1vYYZ0I5Am47SLDGk5AoTomFiY9kjP2f00BQCZBuP4GTJWkMn8TrBVUMNFFow9QWl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=jSBCiSDg; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="jSBCiSDg"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dc9222b337so52238835ad.2
        for <acpica-devel@lists.linux.dev>; Mon, 04 Mar 2024 21:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1709616406; x=1710221206; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KMCvUOJfUJZd1FjH5xJXeLVB97fRCdKEGxvILGRlgeg=;
        b=jSBCiSDgrXgmt1wBlFjjagJuZxleN9tWmf/AU4WGq/RqlVdtbZun5iqOMUfHqnGNjg
         kX62xCRyfGVXSgxBHX+/VXrUSuCiNt2pkzMsIVfG3nEeGvxrq+Of7Bm3xXmd6PIaK3A2
         HoCakEoi67WcHAasQaWJlX/pXN6c5m9hoqzb/qR7oLY6RNyg2wJ9nJw0TTQ+JMB0KBUv
         d95GtNMqOct4nFdTJjVBrS1OfOOQMoW14n2e2J7LuCQzIOWYsk713Aq6wDrXwLNorFdK
         fU8u4HP4htz6SWUW+tIlQ4wyZIgu6/oqaiT37H1reo5vk61pF3PIFhUULQXLoCm61Pln
         naYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709616406; x=1710221206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMCvUOJfUJZd1FjH5xJXeLVB97fRCdKEGxvILGRlgeg=;
        b=a4UfW0wuRxs0Re56hLRZSYT7rLqonxRtfSsgOxGtE5yFzL2I94175Wuw95XBHlideO
         8PdJAkHwfQb9TQXWcOlTUfGdjvQLq5gCVRR/XLZzV41EvY5WRf9FjPoIXNg5iSsggo7s
         cIVYmOl05fmn3u7GXx3XrmF3L4FbYXRnF0Qkcd2YeIBqhO/ule96s0ERTJ3UrzvKvufo
         Z7fvkFFP0WGLs7CbXa/oiW+HevbSsHvQtmpD69IoL2cfQ3vWF4cNdR/F4zfnY1izDUSd
         ysY7+U5RXCoFbFXqInlMUhN0Nz5tsJQL+KPU8GRoXz0kwKCgnP0zWyr1DpVqRAwe/QXO
         8IHA==
X-Forwarded-Encrypted: i=1; AJvYcCUIcnTMnnNYG2H1DFb1E8NOBM4woAd3LCUD3sJLmMIH70Cqwg/TjfopBDsVh4HWyS3LKH/gfx1zzp3LYNaK2M0lCpQ1VaQ5lulsJJpt
X-Gm-Message-State: AOJu0YxopmoIaQVbK8gQGSW9vOrTjP5c6FF5PfwMBVcs+vFz5Tx8jEwq
	Sn38G04cgN7H/uJy1Qj7DGeh5OU7Zqm4Il8DtG045IPhXjvVQH+GppXW9E/3O88=
X-Google-Smtp-Source: AGHT+IGs95PUoXAEeVYkFgLUnlTCMmRM9UBfrxIhvh57F9nTPhSjmTGyccBIiPgnhfiEPKqxoObiIA==
X-Received: by 2002:a17:902:f552:b0:1dc:ce28:a47d with SMTP id h18-20020a170902f55200b001dcce28a47dmr929601plf.17.1709616406218;
        Mon, 04 Mar 2024 21:26:46 -0800 (PST)
Received: from sunil-laptop ([106.51.184.12])
        by smtp.gmail.com with ESMTPSA id e8-20020a170902b78800b001dcc1597377sm9455663pls.230.2024.03.04.21.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 21:26:45 -0800 (PST)
Date: Tue, 5 Mar 2024 10:56:32 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Haibo Xu <haibo1.xu@intel.com>
Cc: xiaobo55x@gmail.com, ajones@ventanamicro.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Guo Ren <guoren@kernel.org>, Anup Patel <apatel@ventanamicro.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
	Baoquan He <bhe@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Evan Green <evan@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Ard Biesheuvel <ardb@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Yuntao Wang <ytcoode@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH 4/4] ACPI: RISCV: Enable ACPI based NUMA
Message-ID: <ZeatCIUZ/eJa1WHs@sunil-laptop>
References: <cover.1706603678.git.haibo1.xu@intel.com>
 <0be49d4d7d7e43933534aad6f72b35d3380519fd.1706603678.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0be49d4d7d7e43933534aad6f72b35d3380519fd.1706603678.git.haibo1.xu@intel.com>

On Wed, Jan 31, 2024 at 10:32:01AM +0800, Haibo Xu wrote:
> Enable ACPI based NUMA for RISCV in Kconfig.
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  arch/riscv/Kconfig        | 1 +
>  drivers/acpi/numa/Kconfig | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index bffbd869a068..e586ab959f34 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -438,6 +438,7 @@ config NUMA
>  	select HAVE_SETUP_PER_CPU_AREA
>  	select NEED_PER_CPU_EMBED_FIRST_CHUNK
>  	select NEED_PER_CPU_PAGE_FIRST_CHUNK
> +	select ACPI_NUMA if ACPI
>  	select OF_NUMA
>  	select USE_PERCPU_NUMA_NODE_ID
>  	help
> diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
> index 849c2bd820b9..525297c44250 100644
> --- a/drivers/acpi/numa/Kconfig
> +++ b/drivers/acpi/numa/Kconfig
> @@ -2,7 +2,7 @@
>  config ACPI_NUMA
>  	bool "NUMA support"
>  	depends on NUMA
> -	depends on (X86 || ARM64 || LOONGARCH)
> +	depends on (X86 || ARM64 || LOONGARCH || RISCV)
Is it possible to remove this if IA64 is removed now? 

Thanks,
Sunil
>  	default y if ARM64
>  
>  config ACPI_HMAT
> -- 
> 2.34.1
> 
