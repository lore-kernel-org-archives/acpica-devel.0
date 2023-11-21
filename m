Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025A6584FC
	for <acpica-devel@lists.linux.dev>; Tue, 21 Nov 2023 21:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDh1+kat"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6cb7951d713so167912b3a.1
        for <acpica-devel@lists.linux.dev>; Tue, 21 Nov 2023 13:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700603397; x=1701208197; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Gtgz9FsdyKFDL5tR7CMd1m/DpQtkGweBHqoxGbzpzs=;
        b=fDh1+katfnf6mQ194MnDp8YpzqnsJb2nIIpk3YyjgY4Wgm4VyX2cxLhZSYrd7rvCMN
         fZj8/GNEaHXZLibD/T6oa1uuASukuHG7exZcvXNpZLm+SNmgulair9uOJBVoiuRJWlKx
         3XhjmzYGdVe7Tm1+6gfgdFC9OqDDIBfLbYKK9v+QR7yUVyBIhyvR9E6SbjNcf5q4eu6V
         ObIPj4hYQIJ9V6qfkS1Bv26elk0D0+4S4zG0ietDo4od+jhES6wu1ZnuvytGhE8UvwLI
         kXeyAfq8zJoEDv4VvQMby4e0nqwL2Isul7qH7QYtZ1b3lgU8Df/+wWCtHNlXkrUcPr+d
         K+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700603397; x=1701208197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Gtgz9FsdyKFDL5tR7CMd1m/DpQtkGweBHqoxGbzpzs=;
        b=uFLWA4vaj3DBMa+B8o5TmzM7WtOQVkRrom+4dSwB+8jkTqCl9Mi/+Kgm+/VJ18jh+5
         jHYRaqti3/Wvp+afdbgUSGM+WOeoWniVwfgKNdNIpuXv511SSY+n4eeLGVRC0ODSrpDb
         teI/MffE4lOf+hoVN5/0SvacE3DMQlFECiejH1Ll6oU837nHDPX8Tez0dImrzkqc+DMR
         uU2nTH9c0a7CXP8KPRxGxzFenyAsYK0aBsDxg6F3eASGI5OkQ0+Zq8dr2b88DJwMmZ7J
         ksckTN8kmZkJr7RqIUaBHuC+InfQDfp2Q1D9R2JIXD/jr3S7IkNrjJbh15QyPCSyg18a
         VJfw==
X-Gm-Message-State: AOJu0Yy3RhfpwXQGMCNhwEMdbc0gSUwOapIySAppF9ODApvYO9KNU9kN
	3krK4kRhpFlSubt640WUZS8=
X-Google-Smtp-Source: AGHT+IGvhU9AXpv6DkrhrnepHN3HLJircjSluq81o11W8qfsOoNA0iOUwKAD0D6E1evrcgiZsgbd7Q==
X-Received: by 2002:a05:6a21:a59b:b0:187:962d:746b with SMTP id gd27-20020a056a21a59b00b00187962d746bmr1015699pzc.9.1700603397092;
        Tue, 21 Nov 2023 13:49:57 -0800 (PST)
Received: from [10.64.107.252] (static-198-54-134-172.cust.tzulo.com. [198.54.134.172])
        by smtp.gmail.com with ESMTPSA id 9-20020a630b09000000b005b92d3cb4c2sm8385412pgl.58.2023.11.21.13.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 13:49:56 -0800 (PST)
Message-ID: <7e4038d8-ef60-f943-a7ba-db59ce9a2aa7@gmail.com>
Date: Tue, 21 Nov 2023 13:49:54 -0800
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] acpi: Fix ARM32 platforms compile issue introduced by
 fw_table changes
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, linus.walleij@linaro.org,
 rafael@kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, lenb@kernel.org,
 robert.moore@intel.com, Jonathan.Cameron@huawei.com,
 dan.j.williams@intel.com, guohanjun@huawei.com, arnd@arndb.de,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <170058229266.2356592.11579977558324549374.stgit@djiang5-mobl3>
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <170058229266.2356592.11579977558324549374.stgit@djiang5-mobl3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/21/23 07:58, Dave Jiang wrote:
> Linus reported that:
> After commit a103f46633fd the kernel stopped compiling for
> several ARM32 platforms that I am building with a bare metal
> compiler. Bare metal compilers (arm-none-eabi-) don't
> define __linux__.
> 
> This is because the header <acpi/platform/acenv.h> is now
> in the include path for <linux/irq.h>:
> 
>    CC      arch/arm/kernel/irq.o
>    CC      kernel/sysctl.o
>    CC      crypto/api.o
> In file included from ../include/acpi/acpi.h:22,
>                   from ../include/linux/fw_table.h:29,
>                   from ../include/linux/acpi.h:18,
>                   from ../include/linux/irqchip.h:14,
>                   from ../arch/arm/kernel/irq.c:25:
> ../include/acpi/platform/acenv.h:218:2: error: #error Unknown target environment
>    218 | #error Unknown target environment
>        |  ^~~~~
> 
> The issue is caused by the introducing of splitting out the ACPI code to
> support the new generic fw_table code.
> 
> Rafael suggested moving the fw_table.h include in linux/acpi.h to below
> the asm/acpi.h. The move also helped with eliminating the inclusion of
> acpi/acpi.h in fw_table.h. The unfortunate circular inclusion of
> linux/acpi.h is needed for fw_table.h due fw_table code needing the
> defined acpi structs in order to build.
> 
> Fixes: a103f46633fd ("acpi: Move common tables helper functions to common lib")
> Reported-by: Linus Walleij <linus.walleij@linaro.org>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   include/linux/acpi.h     |   23 ++++++++++++-----------
>   include/linux/fw_table.h |    1 -
>   2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 54189e0e5f41..2789beb26138 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -15,7 +15,6 @@
>   #include <linux/mod_devicetable.h>
>   #include <linux/property.h>
>   #include <linux/uuid.h>
> -#include <linux/fw_table.h>
>   
>   struct irq_domain;
>   struct irq_domain_ops;
> @@ -25,16 +24,6 @@ struct irq_domain_ops;
>   #endif
>   #include <acpi/acpi.h>
>   
> -#ifdef CONFIG_ACPI_TABLE_LIB
> -#define EXPORT_SYMBOL_ACPI_LIB(x) EXPORT_SYMBOL_NS_GPL(x, ACPI)
> -#define __init_or_acpilib
> -#define __initdata_or_acpilib
> -#else
> -#define EXPORT_SYMBOL_ACPI_LIB(x)
> -#define __init_or_acpilib __init
> -#define __initdata_or_acpilib __initdata
> -#endif
> -
>   #ifdef	CONFIG_ACPI
>   
>   #include <linux/list.h>
> @@ -48,6 +37,18 @@ struct irq_domain_ops;
>   #include <acpi/acpi_io.h>
>   #include <asm/acpi.h>
>   
> +#include <linux/fw_table.h>
> +
> +#ifdef CONFIG_ACPI_TABLE_LIB
> +#define EXPORT_SYMBOL_ACPI_LIB(x) EXPORT_SYMBOL_NS_GPL(x, ACPI)
> +#define __init_or_acpilib
> +#define __initdata_or_acpilib
> +#else
> +#define EXPORT_SYMBOL_ACPI_LIB(x)
> +#define __init_or_acpilib __init
> +#define __initdata_or_acpilib __initdata
> +#endif
> +
>   static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
>   {
>   	return adev ? adev->handle : NULL;
> diff --git a/include/linux/fw_table.h b/include/linux/fw_table.h
> index ff8fa58d5818..a722300c215b 100644
> --- a/include/linux/fw_table.h
> +++ b/include/linux/fw_table.h
> @@ -26,7 +26,6 @@ struct acpi_subtable_proc {
>   };
>   
>   #include <linux/acpi.h>
> -#include <acpi/acpi.h>

Hi Dave,

Seems to me that the #include <linux/acpi.h> should go too, to break the 
circular including cycle. If it remains, I fear that there could be 
subtle problems in the future depending on which header is included 
first in a compilation unit. It sounds now like the only correct way to 
get fw_table.h included is transitively via linux/acpi.h (of note: 
lib/fw_table.c will have to be updated; it's the only file that 
currently breaks this rule) so that removal will just help enforce this. 
Plus, includes in the middle of non-preprocessor declarations are a 
(sometimes necessary, definitely not here) code smell, in my view.

If this include must remain for some reason, perhaps a comment should be 
added to call attention to the circular situation and provide justification?

Cheers,
Sam

>   
>   union acpi_subtable_headers {
>   	struct acpi_subtable_header common;
> 
> 
> 
> 
