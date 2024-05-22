Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DB81422CD
	for <acpica-devel@lists.linux.dev>; Wed, 22 May 2024 17:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716399393; cv=none; b=rx67BIYVaojBWNe3DXoPsErwoMMh2z2MGxAMBVYaLjbgclvXWeZcd68JU8WIYJmuBNNXTtwz12Z9B8DHJiRb5JCj1B+vR5tnDeO3JidWT1dwB1YCJ4doGkHsgm6X7DWLKWswiqv+NVcXxQxWAQx2c+qFfBd4j0M3Sk8XDN8GE7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716399393; c=relaxed/simple;
	bh=Y48rB+eqfN+F9yAGBd3CkyYTUauUSy/FAiGo3hsm9gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bo355MdF6XsUM/tupP5XG6AUXgdpwguo7UB0YatF+EN/6yIkpVUW1tJeGX4V0htDbLVadOpK3w68KJMMGGk7WAhvSsSQVZX1nU/86PJC5fynrD5DuBeZX3FQQ9ZAW5baI8QTckJu3toqZkHZXgmVB4fuBsBDwBLFTpco60rjvsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=JTXFMfTs; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="JTXFMfTs"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f44b390d5fso1522300b3a.3
        for <acpica-devel@lists.linux.dev>; Wed, 22 May 2024 10:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1716399391; x=1717004191; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fDl/ZkDPbSW3xCzUR/DuRNxJiVwY9Xt5ThAS5ddvXhg=;
        b=JTXFMfTsElwMfwk7wmTEmJZQPq+cN9O9F5bpZkiDBEKSYW9NUi81pEVeOOeLmM5+u7
         VDTBETbGoPbojdq5A+odJkzMevUofqenJPPnuq3lP/bcQUery3sBXjOQEw393NGXOygo
         GOFarCQSGoMvJB4Aseov/Ujul69ArKSPZIUQwgUpf6Tiun9g/hNaDWOabKurAp6EHdIK
         uK4nMMzb5tXkjzpzby5cqM8gCDbxOzscU/wQZza0yeB4jGU8dKl/7SjOl90RE2iHe5TP
         E4cyMQiwzR+ougyJXiqlX+Fv4JEYy4NymHYBuJkXmjcVLpzIDjQUVkG1/5YNVF+upHnh
         NPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716399391; x=1717004191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDl/ZkDPbSW3xCzUR/DuRNxJiVwY9Xt5ThAS5ddvXhg=;
        b=P+5h6xR5GvLYqkjZNKnVTgl0rTR+3X9fEuwYYHPTMunYrjOQhTqScxfwtSp8f0D03C
         H5uVdvR8Sv1argJCFs1p26iaZH9bm5Dfgfy7cwwapGTGem9GuUzD9OgnzkYeDrvei5xv
         6YUoNnb+GSJfufIxyWzoBYVL+B64QPDNuDqZHMYWyqvIju5Xa8vOOxQIDePqdlHL/TuC
         fhJ2JtVkDcQDAYSmqmVLQIwAM2jp6pcgiFvIxvokQtyGhuzLJV1pJRZlFNVIVkR5q+ay
         uNAKGSeWY/ijqRYixZg/ATnNe9dVwhwDRRthsABLP0RVGemRIP2ZwNGnvNSfyBoXs+qa
         y5wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUruuVYxRbzxK36t+RwqUXj6GUD0ihWznmfmBkm1QDY5xy452a/9/0EJDuxaQO3D7AGMjcA7xeKYurXK+iUEoiXw6ubsDXw2OHRJvYu
X-Gm-Message-State: AOJu0YxPEU94Qdp9aooL2yTmfguoUpsWseQXoTQzQQ4ClVaSE+oxe/Sg
	yOo1egfzO5BXbi2q+zvjrvYAiqmyMBuGpJManA+DOT0TDCR3DGqs44FH1hEv6e4=
X-Google-Smtp-Source: AGHT+IE/Z1uXsIhp0DCO9v3F7b1s/kf5KJKCU5p/KxlUXSDW4uxdWvE53WL9qx0kDHx4AoziD5mkTw==
X-Received: by 2002:a05:6a20:258e:b0:1ac:8824:156f with SMTP id adf61e73a8af0-1b1f88a30a9mr3119543637.33.1716399391193;
        Wed, 22 May 2024 10:36:31 -0700 (PDT)
Received: from sunil-laptop ([106.51.188.31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2ae0fc9sm22689883b3a.132.2024.05.22.10.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 10:36:30 -0700 (PDT)
Date: Wed, 22 May 2024 23:06:13 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Haibo Xu <haibo1.xu@intel.com>
Cc: arnd@arndb.de, xiaobo55x@gmail.com, ajones@ventanamicro.com,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Guo Ren <guoren@kernel.org>, Greentime Hu <greentime.hu@sifive.com>,
	Baoquan He <bhe@redhat.com>, Charlie Jenkins <charlie@rivosinc.com>,
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	James Morse <james.morse@arm.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Evan Green <evan@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
	Tony Luck <tony.luck@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v3 6/6] ACPI: NUMA: replace pr_info with pr_debug in
 arch_acpi_numa_init
Message-ID: <Zk4tDa0UPL3Xo/0H@sunil-laptop>
References: <cover.1713778236.git.haibo1.xu@intel.com>
 <70870d88a26f50677eb31ac72bd8c343f428e5b6.1713778236.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70870d88a26f50677eb31ac72bd8c343f428e5b6.1713778236.git.haibo1.xu@intel.com>

On Wed, Apr 24, 2024 at 01:46:26PM +0800, Haibo Xu wrote:
> There are lots of ACPI enabled systems that aren't NUMA and If the
> firmware didn't provide the SRAT/SLIT, then there will be a message
> "Failed to initialise from firmware" from arch_acpi_numa_init() which
> adding noise to the boot on all of those kind of systems. Replace the
> pr_info with pr_debug in arch_acpi_numa_init() to avoid it.
> 
> Suggested-by: Sunil V L <sunilvl@ventanamicro.com>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  drivers/base/arch_numa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
> index 5b59d133b6af..555aee3ee8e7 100644
> --- a/drivers/base/arch_numa.c
> +++ b/drivers/base/arch_numa.c
> @@ -445,7 +445,7 @@ static int __init arch_acpi_numa_init(void)
>  
>  	ret = acpi_numa_init();
>  	if (ret) {
> -		pr_info("Failed to initialise from firmware\n");
> +		pr_debug("Failed to initialise from firmware\n");
>  		return ret;
>  	}
>  
LGTM. Thanks.

Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
