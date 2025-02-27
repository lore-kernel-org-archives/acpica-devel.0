Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F123322D781
	for <acpica-devel@lists.linux.dev>; Thu, 27 Feb 2025 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740661070; cv=none; b=n93EHah7RMOGAbL1InEEWp5EIyo9av4BAQ5QOHJjmxzA1oSaUE8npfEdPoTPxGnbb1EjVUIvxxTKiocV6QrkklnclpFyWNjqVuLK8pd9UTmGiImSld/wWyjmCCHtmslxUQQEgfhKENE3trRZip1zC42siJq0Hbuzdpb5PhUh4Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740661070; c=relaxed/simple;
	bh=+rMrTSbujll9t1goCljjQZX7rGGUeT4ByaL+2IU1WjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VGgi/Kk2Tk0c3qJUB8Mu5mXq+hrDcbJ1h8UNCTI811wP+ib1tA0moFWx2KiWjMyW8RPymrK+5Olw7iOFYsboT2x9lyfsPZ86PefG30dBjFcm5RKMu0R28a0o/N+9HkecgEAOnJST6VC5JEG8osEmWfu0lMXQ+jHR/FI9dgRk4iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=cPA1U25Q; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="cPA1U25Q"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-219f8263ae0so14752615ad.0
        for <acpica-devel@lists.linux.dev>; Thu, 27 Feb 2025 04:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740661066; x=1741265866; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pf96MEttABttkon6JyPzDs9JgVTWCcxQW9KTdzVlvqQ=;
        b=cPA1U25QNVr3tyO8AUfNH1Uy2fwVjt3vmfGF/VYBQeNAeAuNamSOqoXWcWduw2FPVK
         x//r4hKl5CQLUL/UgQHbR6M28eTU2jx4jN40TOVSb2e6jG0pXkBoJ30sE/AB49A6i8RU
         ezkjHAPdgYmjXxNMKn2ESdeMb7109oUym5Y6Im+M4w6Q3ILnZcRQKqSeVFkGXvXRr1Sw
         IgPw3qgdWr3ExRWJ4iVYipAwCL0D5eZw9yHbOcWHhkaL6lftwP3oWjpZZHPXjgpmtM5N
         xWfz1Hu27gqyUJ6rJh7NMT5TEApoQtEuY54i/0znW8LRv9n4HV7mQH9WEcXznhHPDaHQ
         ryXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740661066; x=1741265866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pf96MEttABttkon6JyPzDs9JgVTWCcxQW9KTdzVlvqQ=;
        b=kPfhK0Wy0jxs9k32rUW7KZL5DsKnRMHshRljVr5mHmxsSlMkrJzbvldAAa1s5aRyVQ
         6vIGuqcAtOXal70W4xvoSqeG9Qptf+q94NgZw7/c7Oi24O7dCVeiAc7ilvPGiioROZve
         8Or68Fyuw0DUyR/GfXmWisQTQlmU9ucVzOWcxMdi+NKmVXQlRiQsByKPuCJBDbcumPOZ
         XMXmurYIwLpEQjOWaI+CQwOyU+OulwxuL4YcDwN0rOab3TFCxCuT2+xnsoj3b7wFX9Xy
         FJHpVUHwUwcym1LVdr7Ya/82o6IB2Whb1iDBJ3/XRbuRBY8xOcbcUMaD4uKN3F6wB+Yx
         bw4w==
X-Forwarded-Encrypted: i=1; AJvYcCUoyapgip0u9mw6uBfkb0+V7bDR0zqelw0z/TszZ0klH1UtEE1xzmuZj4T84tO8zmmbiBn3fq7/qudoqGc=@lists.linux.dev
X-Gm-Message-State: AOJu0YyrV540p8tc7SJEvdDeiMTjlFFKMQlKeyopIbY+cZkXyYc9muyO
	zSYc+v6OkoHnUHwgNpJNRCtYrfOioNPyxeoaWNCJytsk6QXuGtK1rkmv8KpK/fsrbuhFJeVQIu2
	m
X-Gm-Gg: ASbGncslNOQQM+UvkexuyVwDw1EvLHvhXv8Ozlp3bjByjWypxmrr9JSsEwlQkQUpp2w
	3mb4RTy8UmQIPKjQMG+wMXjnFyZG2BAtHiX7XjDEc6r/VM2ZbrRB17xBzrEW1aVgQkNI0/LMqcs
	x9U+Tzfm831sZr5bb/Wrl3YT4x7fRh6Uzk2OmQCLY63368pDmWhyKBv8NUfqF/pa+B32qiT30KB
	g5wjQ0jL1CUIjTbtFxPgJaQOT5iEwRatL6m8SsT6NhAtWi3197S95KjzQ216b77xPzpw3MEZ2Gj
	Qdw+/KprSTM4/PKBKY5LnF37tjzowFUNIbMFo4Cpvcq9yeuuegvRk2s4zoqbL6LjKfWwByM=
X-Google-Smtp-Source: AGHT+IFx4pIh3JIPBr0kkMiUgEYGJKIIZ775OsAddLWn3ffImcN2wl1+nGQSMf4FINEK1qVgjm20Mw==
X-Received: by 2002:a05:6a21:6d9a:b0:1ee:d6da:b646 with SMTP id adf61e73a8af0-1eef52d935emr44541622637.11.1740661066261;
        Thu, 27 Feb 2025 04:57:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe48865sm1508632b3a.50.2025.02.27.04.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 04:57:45 -0800 (PST)
Message-ID: <cf568ee0-8baf-4701-9e22-0b71792cf329@rivosinc.com>
Date: Thu, 27 Feb 2025 13:57:31 +0100
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 02/10] riscv: Define arch_apei_get_mem_attribute
 for RISC-V
To: Himanshu Chauhan <hchauhan@ventanamicro.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
 acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, lenb@kernel.org,
 james.morse@arm.com, tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
 robert.moore@intel.com, sunilvl@ventanamicro.com, apatel@ventanamicro.com
References: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
 <20250227123628.2931490-3-hchauhan@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250227123628.2931490-3-hchauhan@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 27/02/2025 13:36, Himanshu Chauhan wrote:
> ghes_map function uses arch_apei_get_mem_attribute to get the
> protection bits for a given physical address. These protection
> bits are then used to map the physical address.
> 
> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> ---
>  arch/riscv/include/asm/acpi.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> index 6e13695120bc..0c599452ef48 100644
> --- a/arch/riscv/include/asm/acpi.h
> +++ b/arch/riscv/include/asm/acpi.h
> @@ -27,6 +27,26 @@ extern int acpi_disabled;
>  extern int acpi_noirq;
>  extern int acpi_pci_disabled;
>  
> +#ifdef	CONFIG_ACPI_APEI
> +/*
> + * acpi_disable_cmcff is used in drivers/acpi/apei/hest.c for disabling
> + * IA-32 Architecture Corrected Machine Check (CMC) Firmware-First mode
> + * with a kernel command line parameter "acpi=nocmcoff". But we don't
> + * have this IA-32 specific feature on ARM64, this definition is only

Hi Himanshu

s/ARM/RISC-V

Thanks,

Clément

> + * for compatibility.
> + */
> +#define acpi_disable_cmcff 1
> +static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
> +{
> +	/*
> +	 * Until we have a way to look for EFI memory attributes.
> +	 */
> +	return PAGE_KERNEL;
> +}
> +#else /* CONFIG_ACPI_APEI */
> +#define acpi_disable_cmcff 0
> +#endif /* !CONFIG_ACPI_APEI */
> +
>  static inline void disable_acpi(void)
>  {
>  	acpi_disabled = 1;

