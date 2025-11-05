Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA582652B2
	for <acpica-devel@lists.linux.dev>; Wed,  5 Nov 2025 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332120; cv=none; b=RLn189xIGcStjyiUBsv20qSYr9TnHvpAzi53u54lXsQVfZfsUOhoajTaT1dVlxxUI24Ef+aAmUBkeM7JMmBs3FVTDCb6TOWdJGagktIF087DEF1h854PFxrSYZ/hAXuKRvSsaHh3ITwNUd8pH5jqnWIWP1UOreM60/0lye1svlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332120; c=relaxed/simple;
	bh=lycGLt/AmYhVMaxxlc2sFqXsptoJSH+28KSwY6rR74o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQJpCQ/4hPAmfSMElZPiIF1kqrcD/qvUWocNeoXdn2m+aH+2cTfwaPNM60toqV9/7i5nP+QWfLUQIxUNpENJ/abauUko+mrktRB7GvGrrSRiHcWwEewkr/fI4T+5A/saTnO/Aq0kL0OkKa8pyTgrsPmE1/8xsstAuatPQ5jiXDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=MFjbEFCx; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="MFjbEFCx"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-340bcc92c7dso722192a91.0
        for <acpica-devel@lists.linux.dev>; Wed, 05 Nov 2025 00:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1762332118; x=1762936918; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tUkopRdeDHdh9AWy0RMXnD+iemi5ZwANhUDqA8Z7pVY=;
        b=MFjbEFCxNhEIexd9f85CU73jVbkcZdGtx/vjx19HQ4k+fMhvjerAzUOzKUHdb6x7+X
         FF/P3mOXdvZCDsYzAimtXqfDvOyLd4ss9S9TRdYxx5kbi3IGZwAoyuUiUBPiW6Me8iqN
         Sm/fmb5gALMq96eyzscDQ0jm11U3rrOFQF9pOs3ayNaa8+vBI2TlknC5OBJSw8MW1HKs
         GgszApQUKFmFZocNaW+6cG91SiLATJgfc3hoS4m7fazDTUMYTE8EKeojCHqtDe6GKDrN
         npO4FnJeZYs3nCwktsRp84dOd857dWJp5gCiwzlVG5ezhxeJVZm96fq4tIavDZTvEEG3
         cvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762332118; x=1762936918;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tUkopRdeDHdh9AWy0RMXnD+iemi5ZwANhUDqA8Z7pVY=;
        b=lM9YOmi65WI1O+/VbRK3vINYXxdALXRsOYq9PQ6z+ZYp1xCHZTqOF4EqAU8+ju3uQL
         KLp1ObEeeC7D+cXdUtVG9cOApyIn9+lNPd0fXKt/soHIl7tnq8Af3/23pWMjHuVAs/iH
         aBTp94cxXUwjHFXR+CebzLGy6rcdKlCmgz9XSAKpGvDknRdAk9EcfIOGXPDpA7vSSX8/
         dCFOYqzZLeEPjcCvkkl8bMIce4y52ahFryL4y6gzk28VpCyey6AwE0oartn7AcEMqXFG
         8Ihhteg39AYKuluUgf/7bLxHTVRrO+IW42fBQRcuNUydXPr1uamtxEtslQp/u9bQXXRx
         OYuA==
X-Forwarded-Encrypted: i=1; AJvYcCVyfQsjbr3lteegcH4iCEFeCrgaeM/Q6eqj0feXb8C141WZt+avc5Kb4pmvXTUUTTBNeyjkuLPcpQCDHn4=@lists.linux.dev
X-Gm-Message-State: AOJu0YxVm99jrK4IsPPkmyvNVjWt5XSMg5BJxjmksxUrcgfQ8f4CdS2V
	Yk7qFPN9rre8/7zM1FTpK1Y8WgsoP2u2bj1at8yQOuaFmZooUlBwC5qIeC05G6PlBZI=
X-Gm-Gg: ASbGncs3z8yWRvChYapd9Temf63Ik1QLLwYZFYV+YC6mGKc2fwoAWse2+X4peyom+90
	Z9o/s3Q2QC6pVLU7qBn9LXnEu9bujGviKoXmQXkOqp8sUaiJNCsjQNqTuvmtBEbd1xcqpg89SLB
	gLyy/BwMvg3rOxF03i9T9pOlRVRC4IAyOKRZWQuEIiLGjWbN1NXl3ic2BIA/t5QjDpv2DbRmFbw
	csqVIkxHAF1m1XL/2Z0GQKoaCKprAtoexekN/g189xNbjKAm2J1gG2fDQUCCIsNS9mpuy23ujwt
	Fy+dIT9Wz8qVawzKViwOQuNg/C8hNl/Hq6JnqfT75NgxHtThnGsxeNXovasS4qMa7gr3K+biUij
	+YrKbI5hZtYNqXDv/Ob5LjM2cyYi3h8hMhQPSzG9wfnjYNiRIyeW4Qfuzpb/xN4J09qfPQMlDhP
	ebg8b8tgYk4kfue2OIsLU0snosOccOSFXiAJ8xat2KhFh7BA==
X-Google-Smtp-Source: AGHT+IH5fMD1INFs9eEGKYVtBDuuIJ1FKf0Z38BpsziCkXGqBqC8vDLl4i3lj3Io8I0ea2eccHNQTg==
X-Received: by 2002:a17:902:d48c:b0:24b:270e:56d4 with SMTP id d9443c01a7336-2962ad0fba0mr32538305ad.4.1762332118155;
        Wed, 05 Nov 2025 00:41:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601972a9fsm52542895ad.20.2025.11.05.00.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 00:41:57 -0800 (PST)
Message-ID: <913ad5f8-89cf-475f-8ab4-3fa5e21d2941@rivosinc.com>
Date: Wed, 5 Nov 2025 09:41:46 +0100
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 04/10] riscv: Add fixmap indices for GHES IRQ and
 SSE contexts
To: Himanshu Chauhan <hchauhan@ventanamicro.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
 acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, lenb@kernel.org,
 james.morse@arm.com, tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
 robert.moore@intel.com, sunilvl@ventanamicro.com, apatel@ventanamicro.com
References: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
 <20251029112649.3811657-5-hchauhan@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20251029112649.3811657-5-hchauhan@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/29/25 12:26, Himanshu Chauhan wrote:
> GHES error handling requires fixmap entries for IRQ notifications.
> Add fixmap indices for IRQ, SSE Low and High priority notifications.
> 
> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> ---
>  arch/riscv/include/asm/fixmap.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
> index 0a55099bb734..e874fd952286 100644
> --- a/arch/riscv/include/asm/fixmap.h
> +++ b/arch/riscv/include/asm/fixmap.h
> @@ -38,6 +38,14 @@ enum fixed_addresses {
>  	FIX_TEXT_POKE0,
>  	FIX_EARLYCON_MEM_BASE,
>  
> +#ifdef CONFIG_ACPI_APEI_GHES
> +	/* Used for GHES mapping from assorted contexts */
> +	FIX_APEI_GHES_IRQ,
> +#ifdef CONFIG_RISCV_SBI_SSE
> +	FIX_APEI_GHES_SSE_LOW_PRIORITY,
> +	FIX_APEI_GHES_SSE_HIGH_PRIORITY,
> +#endif /* CONFIG_RISCV_SBI_SSE */
> +#endif /* CONFIG_ACPI_APEI_GHES */
>  	__end_of_permanent_fixed_addresses,
>  	/*
>  	 * Temporary boot-time mappings, used by early_ioremap(),

Hi Himanshu,

Reviewed-By: Clément Léger <cleger@rivosinc.com>

Thanks,

Clément
