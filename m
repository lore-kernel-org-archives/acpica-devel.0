Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52781280CE5
	for <acpica-devel@lists.linux.dev>; Wed,  5 Nov 2025 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762331626; cv=none; b=oEo2osPLF3QO++9byEGXPl8jHatGTOf7KK/1em7IXEVCbDWDfcZiXLEd9PT6JYnj39sRTK/3t9xV7dJsJqWbhSX+V38Io5c+EtJHlLbBHvwqp2ApDq2VdW62sTndJ3Iy6zwFL+XXxArCVp9IlnLAZmXwT0zpwPaeJ4S8EO71POA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762331626; c=relaxed/simple;
	bh=BwPh3ox3ihF8gLYDzcrOK44f4OtqgF+2Fb0Dh0+BLJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sNJZvmR1VbnR/W6x4lQ4AOhOwHdhMQMGOEb+ro07SkjFYZ2Vv1RBJygFHECzv0vAA/+rMLi18W3t+rTthkcHi+yvNkShwKOSDVjrtXb2P2d3wdTiuV3Z8MFSQuA99OKvILNWOZkZCMvMrJ3frPIsYca4i8/pafId9gC9mWBGcvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=EkJ3bqKf; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="EkJ3bqKf"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b991ddb06a9so2494872a12.3
        for <acpica-devel@lists.linux.dev>; Wed, 05 Nov 2025 00:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1762331623; x=1762936423; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HpTquQODFrk3k7PTmJWFoZkkIUY08cVx4+GYG+eKacw=;
        b=EkJ3bqKflXeVkZFSpWK9qukeDN5XcX6aM+sst2g1gU0+yq5zO/GifX3N7P8WE3uk7x
         JY4sYFHXlWCi/h/oNqyR6iGXQkIqX+RtTtSJLbks/RvEzsyu6lVO/1szBYo30J2npixb
         f2A6ZGnq2Ct9ylv9BuHZ2smpbfttMJk6ZC5pH4rFFsfkjcczkfHcVXuqOW1ErSP5xFtz
         xvf+wVoEs9SreFnzY0Zpy84uevIE1fi+eYcEDzt4hNQVnaGXBY7PQPGddOczekeeYYV8
         tB4m+QFuiY10rkEI28vwwazZzekCLO8Bg2RJt/g/x/vTU0qqTzlV61RLwzXWm7SlOd27
         SjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762331623; x=1762936423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HpTquQODFrk3k7PTmJWFoZkkIUY08cVx4+GYG+eKacw=;
        b=uGI9KomMwRLYdO9RIyxk7ZkrSHKTuc4F0Zwg1+eusuGDPUgPCiMCYVt8+ifszsqD/6
         IY3zdMZTnqfOw27UHmhjxTMf7owsRRlpTV8PV6Zj4TV6PrkjCvpobcXSuMdhm2FR3ft0
         dcz/EZwWni7UvU9oEKhgL937oGFv00cyiYZlGpoLJ0kZMcfdOtsgH6/mTYlaRmggm2bc
         p/fQ69DoRR9wwoD5TLSQUGNYPiPLB4XMieCv2I6Vi9slXn8gEPR9O64SVfzKoTwDPgXw
         f6K6GIHCQaPjOOm8TdKj9J3vV1bfg2Bqgh4Ea/qyTA6n8gzNU2yIiVehe+5zwN43yJ+A
         7paA==
X-Forwarded-Encrypted: i=1; AJvYcCX0sKtQOtb/4uWCoZUJwHbCmX0hDv7ekBAd30+SffXfE1aXChN2mq8mN/dgGLgHqTHUSoGafh/FAOJ87LI=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxs+inN96E+n+T4H7Ek3yoCOK0YNtH4A87XPu1EIS0gttWl0HQv
	e9rCNZFSIYmOqaoIAKYoQoF6EVb0wgZXQvXxrOWqUmv5b2zz8jGjuKi7EuBzdQEc2Qw=
X-Gm-Gg: ASbGncuqPy6sbpFBA5533QwdOME4PCGi77RczAxpO87qpv4AJuopV8i1UBimPtoUBiw
	fd5ueUNdsXzcbnM3qUjQvoW+CeePo0AfzZFl6yALhW21WibghIl2GXRYuDWU9PWWlrfEkZ71STa
	mRaEUjzrXyifTmTdrFY5mDf+bzpjQIbb60erR8LGDvB8PM9T+DuF6DitSbLrZrmAqHAQPDDa8Jp
	7f8MbbauYAb0ROPgxH64tyuKy926L3GCk6bhtpieBUsxkc9tekw+M7lcxWlKSXAGOAT3CryiKSc
	SM2yo5uDvN5GTorFUEOquKfqYWEPHUWwxDh9AT20FPsv+B2GH355GRkO3HTI74nP1I47YJaYgno
	7apWNTw3efiN2NcSKuFO5/VIFnawyQJFKMUPh/hZoe4m97G5resr2/EbHzrC/SkCpbRfnTZNd8Q
	apfwgs40jUM5uqVro0lHHaTdlxkaXx334ZilJ0lq3CS7ngnA==
X-Google-Smtp-Source: AGHT+IHDFgcvO6z3yf7vgJuVKi/Izk8w235XWF6jlBUbkg3bEglTQPQvHCk60pfVQnoZVc+QCi6Lug==
X-Received: by 2002:a05:6300:800a:b0:34f:c83b:b3ec with SMTP id adf61e73a8af0-34fc83bbb89mr1922411637.15.1762331623396;
        Wed, 05 Nov 2025 00:33:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ae256df261sm1899131b3a.73.2025.11.05.00.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 00:33:42 -0800 (PST)
Message-ID: <15298563-967c-4609-9410-4bc0b6a75be6@rivosinc.com>
Date: Wed, 5 Nov 2025 09:33:30 +0100
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/10] acpi: Introduce SSE in HEST notification
 types
To: Himanshu Chauhan <hchauhan@ventanamicro.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
 acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, lenb@kernel.org,
 james.morse@arm.com, tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
 robert.moore@intel.com, sunilvl@ventanamicro.com, apatel@ventanamicro.com
References: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
 <20251029112649.3811657-4-hchauhan@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20251029112649.3811657-4-hchauhan@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/29/25 12:26, Himanshu Chauhan wrote:
> Introduce a new HEST notification type for RISC-V SSE events.
> The GHES entry's notification structure contains the notification
> to be used for a given error source. For error sources delivering
> events over SSE, it should contain the new SSE notification type.
> 
> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> ---
>  include/acpi/actbl1.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 7f35eb0e8458..20b490227398 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -1535,7 +1535,8 @@ enum acpi_hest_notify_types {
>  	ACPI_HEST_NOTIFY_SEI = 9,	/* ACPI 6.1 */
>  	ACPI_HEST_NOTIFY_GSIV = 10,	/* ACPI 6.1 */
>  	ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED = 11,	/* ACPI 6.2 */
> -	ACPI_HEST_NOTIFY_RESERVED = 12	/* 12 and greater are reserved */
> +	ACPI_HEST_NOTIFY_SSE = 12, /* RISCV SSE */
> +	ACPI_HEST_NOTIFY_RESERVED = 13	/* 13 and greater are reserved */
>  };

Hi Himanshu,

Looks good to me,

Reviewed-by: Clément Léger <cleger@rivosinc.com>

Thanks,

Clément

>  
>  /* Values for config_write_enable bitfield above */


