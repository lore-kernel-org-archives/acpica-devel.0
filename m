Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C76929AF
	for <acpica-devel@lists.linux.dev>; Mon,  1 Apr 2024 07:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711954877; cv=none; b=sCvCyKlSqSnrD/o3jmdBtD2ZInfxhDAqin90BR6q2gqSMAn2+/VrSLHYRwexbqG+MHlxitbVR+x24MzfpuVKKSikr9hPhsBEsh63/KnZjw5iA8c+WGi/Ns3BlBaxogQFpC2AMNbwDgl1NPUqnnHnIEhB+KO135SjrQGlcOO/IsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711954877; c=relaxed/simple;
	bh=0UxXqbvneBknkvUjHFo+1LfyNPC9qRMw/RiQNbhnucc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P43xRmV8xPCyy/dTZ7SztQrYTMtTa7F+eGjKXX4Mqf5VpvgYP+WXy7i34Cq9NG+bo+flHgOZmN4gsiMNcFs5FixCqMIJcQhMbAbWyBwM08iN7WHqZdyDbZ7w0Cfhfc0oB42ZS8bC5zIxW3PaYSSr0MMryxKLn/A1RUSHsEvmow8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ch0nKlP2; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ch0nKlP2"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bbd6ea06f5so1582829b6e.1
        for <acpica-devel@lists.linux.dev>; Mon, 01 Apr 2024 00:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1711954873; x=1712559673; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CR3iwkHe4Np8Vng7wVF9RKBPosLNIp8pBnmcewjQ5aU=;
        b=ch0nKlP2KtJF1bXEHiQ1j4ZH5wVQU5UVNkPMB1GRvvvJ2ql7rXqReqSm5p8v3rAibl
         NTOwPgM4oENEmcGlorPrxU0uRgSzQWw4kLbZG993IXgRGBDquD5AlNA7myLRKUB+SjI6
         lsL3b3ngt8Sp5/sK0E1yfyUFJZ2szfFomTnddyWGjPB9NNOf2oBB/bppYuisdQihxgXk
         f6Mh8y6A35tJu1Ssj/AHP3Z8n5Be8onu/jxOJgK9O7TJ0mT54GPB9e6FNfMiz6/sHm4T
         +k24KIigpQudCApo9r1LGVHbe+N7rj9QinsT6zcJs6k59dTe8C0iEES1Ly7ItYDxILTA
         vCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711954873; x=1712559673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CR3iwkHe4Np8Vng7wVF9RKBPosLNIp8pBnmcewjQ5aU=;
        b=KJ7OzyD3r89lIrALdktwzuj3JMB1Yh2KabFPTvbQq2ZGzLEMWqYXJsoNP0cS7OU23s
         3Gsc6a58a2I1fY5SGnG+C62rM9i1JEurRgt8EWw+/Ktt+GlOjFpOwUvwW8MtDPBCW6DS
         CcpYFo89cIj9uRBY1ywMtMyTcApqDWjka4WEUnkaByqQTtWh+H5ieVL7SMYvJJtdtffU
         +5EBnIKWICqhF0JDNtgbC02kzyuMMqkMd/H+270eobo4p7eviHq7TTgteeHwS25Hz+6X
         WLvULCMj1XiiNh0y2Jfa5KRGcw7vqc8vxt6K5CN/ITkZxBwp0V7NZHTKMtz+8IsGfLii
         R4xw==
X-Forwarded-Encrypted: i=1; AJvYcCXvnMg2kZKYrdodDhv0vru1TZSu96uuwmt537c186cqL/2sgKLiZA06uLE8SN6nNTZglJPzbe5hkK6oR/l5MQAJanNknGVqH0+U+bqp
X-Gm-Message-State: AOJu0YyOThzEsPX8gXBrAVqW/ZXbFmcvIwN6eMpNsZwzfgH/3jrEGVt1
	w2pibIbfUfol19QkwZ/z/r6qUWCdtUKT8Mmzxmc1fk9OXVPIOonZzQbVyEAV7tw=
X-Google-Smtp-Source: AGHT+IHNVXbtf4nFi0CjQtWkGz+KO+8YX+Nli7rw8a7TjQYiIWVV4PVHNMdRC2/hIgsRYyvZbdhOXQ==
X-Received: by 2002:a05:6808:309c:b0:3c3:c157:5dc7 with SMTP id bl28-20020a056808309c00b003c3c1575dc7mr3557976oib.13.1711954873346;
        Mon, 01 Apr 2024 00:01:13 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id l7-20020a056808020700b003c4dac3b55dsm1018840oie.3.2024.04.01.00.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 00:01:12 -0700 (PDT)
Date: Mon, 1 Apr 2024 12:30:56 +0530
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
	Anup Patel <apatel@ventanamicro.com>, Zong Li <zong.li@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Jisheng Zhang <jszhang@kernel.org>, Baoquan He <bhe@redhat.com>,
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>,
	Evan Green <evan@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Tony Luck <tony.luck@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v2 4/6] ACPI: NUMA: Make some NUMA related parse
 functions common
Message-ID: <ZgpbqAraGbQqZv5d@sunil-laptop>
References: <cover.1709780590.git.haibo1.xu@intel.com>
 <c8b86184d9e6d078e9b9949d4837bc6e392c3f52.1709780590.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8b86184d9e6d078e9b9949d4837bc6e392c3f52.1709780590.git.haibo1.xu@intel.com>

On Thu, Mar 07, 2024 at 04:47:56PM +0800, Haibo Xu wrote:
> The acpi_numa_slit_init(), acpi_numa_memory_affinity_init()
> and acpi_parse_cfmws() functions are common enough to be used
> on platforms that support ACPI_NUMA(x86/arm64/loongarch).
> Remove the condition to avoid long defined(CONFIG_ARCH) check
> when new platform(riscv) support was enabled.
> 
> Suggested-by: Sunil V L <sunilvl@ventanamicro.com>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  drivers/acpi/numa/srat.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 1946431c0eef..938c4adb7ec4 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -219,7 +219,6 @@ int __init srat_disabled(void)
>  	return acpi_numa < 0;
>  }
>  
> -#if defined(CONFIG_X86) || defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH)
>  /*
>   * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for
>   * I/O localities since SRAT does not list them.  I/O localities are
> @@ -351,13 +350,6 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  	(*fake_pxm)++;
>  	return 0;
>  }
> -#else
> -static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> -				   void *arg, const unsigned long table_end)
> -{
> -	return 0;
> -}
> -#endif /* defined(CONFIG_X86) || defined (CONFIG_ARM64) */
>  
>  static int __init acpi_parse_slit(struct acpi_table_header *table)
>  {
LGTM.
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
