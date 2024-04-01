Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4248480
	for <acpica-devel@lists.linux.dev>; Mon,  1 Apr 2024 07:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711955942; cv=none; b=e2DPDxp8AoLlb74vLwE7JKz7JCmX474XDgKpR7rX7CwB8J/humxLiCxIXvgw1DNfNsSCmyCQEShc7u0AQjo47x8ZyK05FmPM2jiT0tElIOxOa5HwIVtP/cTXNgh3JsLn6BiAdarxxhR/JD9BDeEcH2jBO/wL5HTUmW+RwgZRBo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711955942; c=relaxed/simple;
	bh=MD+7DnurC6++x6pB8zRG9Hnf+SzLYopSLmHUgVuanGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZP9pNOYk3NQNO8S+jFfy+fsi+IBTlxMtcDaCu1RHXHjHvqHF/1SAP11GHFAkajgJOrUE+KaBXd9JKuuqX2u6GJR/MOhJo78eB56q0yGoWsTBTrFz/WKHLYpGXmSsL5ltENRefXQg84iC2XTxCUM8MsxoctHtBfARGGd8xun/FPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=IgW54efJ; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="IgW54efJ"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e89bdd4e3fso369327a34.0
        for <acpica-devel@lists.linux.dev>; Mon, 01 Apr 2024 00:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1711955939; x=1712560739; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KmnMPiHdZwTuSyiAmUBbotIL+Wtz9SccD/2TsEE+0ng=;
        b=IgW54efJK1Mau2rFp8shoNTAxBt+YIpQvNwBUR+8nbr+h8H2Pu9C5Qo2zE1YXKQx8I
         FUZ6QvyoIAL4GKLp0OOA8Uh4MhTSWyiVrlIf7QRnd3EmZ5/uPVOv2H/bHF+YNxJWUwsm
         CEZwTU9lHS6dN+sDIZzZefckwSVkAIEC3ny2H9c8fUhviGv5FcX4Z33ubjSWpA6BNHd1
         F4aIIqE/NC2EGewAatocqbsezdI0ya157UNBxRqLDlPfrhSNVbimsDTVNzpP1r4Nchd1
         b7DSyEoY14eji9/Ay5n+wdDDuTKXc+sM9niuDWq07istYduYeaBx6E5K+P0O3vEMlWL+
         9XGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711955939; x=1712560739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmnMPiHdZwTuSyiAmUBbotIL+Wtz9SccD/2TsEE+0ng=;
        b=FYCRbTjTfy+XSdrDjn2Hja8eZPJyfWkoUSN1fJ35ztDIP3a0O+MXoASQHbS4R70L30
         pwBwJpTUZAgGVziYhrlibPKzQhbfFrAZI0NY/IsyAEmFWX2uLHWIfkuVY9AFhNzvG9oz
         AaJvt49l7pSVdr1gmvL5MbAQ+NxDzT9HRWaI/89jDCpMhM+qav3wYcmFzCfz1adJSbfM
         6XI4BQ0RQhPJozUyRyjBcbi9qZFlAFchRHOfagiQQJvzt+jbROVD9hqvhQXs/t192c7R
         zPDh1ROu0oABPLGyx3yuLSmfoDV030QxskMBGMkXS7xCugP8MmmzV3rKHNTPb36Q22ha
         h4xA==
X-Forwarded-Encrypted: i=1; AJvYcCUpF1NANKOLV4yi9fHOZQDmNOQ56e/RY/EqEA/fXfTa8kdpbzyQSdsBvKlb3LqH8v81rSq8xcGK4A9q4+B9nQ0+88g0Mxoa6fYPbnjE
X-Gm-Message-State: AOJu0Yw7gMdDIpA+Ao3QlpHZakvDVSV9EkoM5xoDY42RZhWSB9Zj9Itl
	xVvTJ3sr3HpYg4cn62Yz7ziBcVtKGeTc0cU+qQEbAVnaa8emMQVHCrr9Fxt29j8=
X-Google-Smtp-Source: AGHT+IGSfvqjOauFHIchIvjURLPiv+JlWEBBSRMGmtVtVu+cf9tXS/DlNmsy1MccDtCO/34D8tR6/w==
X-Received: by 2002:a05:6870:2309:b0:221:9227:e006 with SMTP id w9-20020a056870230900b002219227e006mr10279412oao.47.1711955938782;
        Mon, 01 Apr 2024 00:18:58 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id gy8-20020a056870288800b00222649d5b4esm2717950oab.16.2024.04.01.00.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 00:18:58 -0700 (PDT)
Date: Mon, 1 Apr 2024 12:48:42 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Haibo Xu <haibo1.xu@intel.com>
Cc: xiaobo55x@gmail.com, ajones@ventanamicro.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Guo Ren <guoren@kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Zong Li <zong.li@sifive.com>, Jisheng Zhang <jszhang@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Evan Green <evan@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Marc Zyngier <maz@kernel.org>, Anup Patel <apatel@ventanamicro.com>,
	Tony Luck <tony.luck@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v2 6/6] ACPI: RISCV: Enable ACPI based NUMA
Message-ID: <Zgpf0rqUSEZcSiAV@sunil-laptop>
References: <cover.1709780590.git.haibo1.xu@intel.com>
 <01cb5780041565784d459cd94a5c4f55eaa87739.1709780590.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01cb5780041565784d459cd94a5c4f55eaa87739.1709780590.git.haibo1.xu@intel.com>

Hi Haibo,

On Thu, Mar 07, 2024 at 04:47:58PM +0800, Haibo Xu wrote:
> Enable ACPI based NUMA for RISCV in Kconfig.
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0bfcfec67ed5..0fb55f166701 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -447,6 +447,7 @@ config NUMA
>  	select HAVE_SETUP_PER_CPU_AREA
>  	select NEED_PER_CPU_EMBED_FIRST_CHUNK
>  	select NEED_PER_CPU_PAGE_FIRST_CHUNK
> +	select ACPI_NUMA if ACPI

If the firmware didn't provide the SRAT/SLIT on ACPI based systems, then
there will be a message "Failed to initialise from firmware" from
arch_acpi_numa_init(). This is not specific to RISC-V. But I am
wondering why should it be pr_info instead of pr_debug.

Thanks,
Sunil
>  	select OF_NUMA
>  	select USE_PERCPU_NUMA_NODE_ID
>  	help
> -- 
> 2.34.1
> 
