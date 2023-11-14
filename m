Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0BC2C1B0
	for <acpica-devel@lists.linux.dev>; Tue, 14 Nov 2023 18:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8Xzr+Rl"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-359d796abd6so152565ab.0
        for <acpica-devel@lists.linux.dev>; Tue, 14 Nov 2023 10:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699985379; x=1700590179; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xxYwdpdF8JJ3J8eR5fcrs9vFQuvJKtKmfDNv9P4y+IA=;
        b=h8Xzr+Rl9pdhFKBAq8khGr+wtE3+mT1gWpSLLKa/T7iYxjbeS5ypZtKUbcdW0fE+GF
         IQEg9nrViOXofNjaJF1o6hq0EKIwRv4yHaDusrMMknRU/EprEcmdmUWzJC8WXLK3d2Fe
         vqy8P5JCJ6V5ni+M4312Npsu2tnOYykyN6jPeN9z9/OTPFMvX2njFitOAngIt9yAEKIu
         vyGyp0hmAcgOgdu5tQgICEGEYQl6W+Rs62N0IPx/MOwXoKFwiPggHss5wbv+hOWZurhY
         E7ulil4HsAf2mihfIc6qtKMA8xfE3y4C1fKyYnRpJyfk8OzGfQ0Q5mqIhEl2/zuBPAJH
         gAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699985379; x=1700590179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xxYwdpdF8JJ3J8eR5fcrs9vFQuvJKtKmfDNv9P4y+IA=;
        b=Fn3KkWSQ9ctpmHLalglulsZRCMbCKIGQiW5CI3YHw1XfGFxxgIH8QeDlq4DYU2acVu
         LAvya3iqbBbueUedLJqIiEGGqq0e+/2Lg8SiB3zFORnSXytHsx3i+zEYvrix1qcFtxlo
         34hM+eLWg1DyBa5lY4yXBeMUMXCtaAemXvXhIsZjEzhs+jheRQgBNgOthWR5BVEtDrUo
         3t9msv4n5MY6aaB0LAgR3UcwZC5NwzmGjISaFU747bb1DOVbB0F+94Nh+3wyqQ2hUviR
         XaLlPOkDAXdBEzWqoHxybtYsXPyTsFO/SWH+g995Tq94Dm879dbE9mK+34mg2gkav47W
         A4nA==
X-Gm-Message-State: AOJu0Yx8sNxtGn6HT5wXf5aVPxlsoPTUMQrDM6pv5We02jebot3w5y6S
	jnXR1ztUMuA4f+J7cuavZR4=
X-Google-Smtp-Source: AGHT+IFRlkfEouch/0EEOLd8mbYLL0IWatZQFkhv2orilRN+MVYu2ZPc6Aiq2uW+RdzhcoQXU8703A==
X-Received: by 2002:a05:6e02:1b05:b0:359:315c:368b with SMTP id i5-20020a056e021b0500b00359315c368bmr3551685ilv.4.1699985379589;
        Tue, 14 Nov 2023 10:09:39 -0800 (PST)
Received: from ?IPV6:2001:470:42c4:101:767d:e2ee:ed0:5f02? ([2001:470:42c4:101:767d:e2ee:ed0:5f02])
        by smtp.gmail.com with ESMTPSA id i15-20020a056e021b0f00b0035acf801fe5sm347413ilv.64.2023.11.14.10.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 10:09:39 -0800 (PST)
Message-ID: <b2354c21-3a1a-c446-fee0-db0c78d05c71@gmail.com>
Date: Tue, 14 Nov 2023 11:09:37 -0700
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] ACPI: acenv: Permit compilation from within the kernel
Content-Language: en-US
To: Linus Walleij <linus.walleij@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Robert Moore <robert.moore@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Dan Williams <dan.j.williams@intel.com>, Hanjun Guo <guohanjun@huawei.com>,
 Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20231114-arm-build-bug-v1-1-458745fe32a4@linaro.org>
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <20231114-arm-build-bug-v1-1-458745fe32a4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/23 16:08, Linus Walleij wrote:
> After commit a103f46633fd the kernel stopped compiling for
> several ARM32 platforms that I am building with a bare metal
> compiler. Bare metal compilers (arm-none-eabi-) don't
> define __linux__.

Hi Linus,

I saw the same baremetal-compiler error here on the ARM64 side of the 
fence, and narrowed the problem to the same commit as you.

> 
> This is because the header <acpi/platform/acenv.h> is now
> in the include path for <linux/irq.h>:

More generally, I think it's because of this addition to linux/acpi.h:
+#include <linux/fw_table.h>

linux/acpi.h is supposed to ensure _LINUX is defined (if it isn't 
already done by a non-baremetal compiler) before we start pulling in 
ACPICA includes, so that ACPICA knows the platform. But because 
fw_table.h contains:
#include <linux/acpi.h>
#include <acpi/acpi.h>

...the circular include does nothing (linux/acpi.h's include guard stops 
the include before _LINUX is defined) and we end up pulling in 
acpi/acpi.h before we're ready.

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
> One solution to make compilation with a bare metal compiler
> work again is to say the file is used with Linux from within
> the kernel if __KERNEL__ is defined so I did that.

I am not an ACPI subsystem maintainer, but my understanding is that the 
files in include/acpi/ are copied verbatim from ACPICA, so any change to 
those files will have to be sent to the ACPICA project and wouldn't be 
accepted here.

More likely, we'd want to do something about the circular-include 
situation between linux/fw_table.h<->linux/acpi.h. That may have further 
consequences down the road than just our problem here. Perhaps just 
dropping both #includes from fw_table.h, and lowering the fw_table.h 
include from within linux/acpi.h to be below <acpi/acpi.h>, is the way 
to go?

Kind regards,
Sam
