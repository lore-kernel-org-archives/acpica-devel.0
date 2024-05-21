Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222A63D963;
	Tue, 21 May 2024 05:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716269736; cv=none; b=RPN7PIdCDDgC3Sz9hYFU1FEytN4dH66cakHuYEHWVEnGU1qYABpStKHM8CxvhmeC+u3LX6ghHaLJVvAiMR2cM/MtxwCPyym3XSdqF9Fvc79Jql333Eu5yvsmFllvbYuaSgwdZcfkBW2mg8OP6pF1FUUfoyeUz3TfmwONARSYXd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716269736; c=relaxed/simple;
	bh=v5v+mxXJGbuu9swM4ML+rIqDChwIBSC5ilbvTHWRBV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ed2SjhpvRDUFdXMO3feS9ZFuPWMDJ6J8BF19OGAJ0gxm9g+DmXK/hu/RewwBdWSwlNEDgkRKSJeJlBWVn7DK+y+DxdJqc76WHM+X2YNvvjWn8QnZ8ZEvPltsmxrucqq+prEiZ+UL25acIWmC54ZRPvk5OdFUGBHp8pAzoBN6/OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkaJnUrP; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkaJnUrP"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-520f9d559f6so6073399e87.3;
        Mon, 20 May 2024 22:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716269733; x=1716874533; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ig5IFTDhN8p1vBKS35cjX3QT6gQn7mrpFK4GK2Ml+nc=;
        b=JkaJnUrPqzEWE0NqG8MaGUqYAorMSY6StLbPG1AhRWgLO1aX0e1vxiEQah5JVqhW0X
         pg97K0JYxpoetUMN+/OrutiLzH24Td1+6FiOI72JTZ7q0DuYGGJ8yiWZ9xAfYYo+bMWE
         FfpnvjX8KQyi9IN1dk+ZanjLKxcuE41cn9FIonsp0/nV/w4vdyBt44K7ZUjPTz04LkVG
         AxR7xx4SAINyPRfKhhw4cIjO2IDSB0pBxOpnEAhqU3XzECQCXNHmIONmIhsUX037Go3L
         NpwZuSADGetkXx+5zq8VMCqztLIawMQwuTG4F44OuQ+UCRKgqIF6i5MdOgIqJMPWDjBZ
         eBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716269733; x=1716874533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ig5IFTDhN8p1vBKS35cjX3QT6gQn7mrpFK4GK2Ml+nc=;
        b=g3CcFByWpFdcwujvAX73ce9ldCvaABtm7Yk1IStsrcJTANCBUD2YUMHX2lKN3uwbD0
         tQo4ov7b1zS8GQG6E8idmMvxViY2NELO1c9/8BUsSqI9obKF1wOCQLR+UscISv25pSxS
         sYn+u7H/+pq9BrKj2jzpRhyFX9OHsvYVMrX9djDMUrBEC/yi73dA+ZxrHjLwW5JyfAXM
         KJWKif2aUFhNivVdh0tMeCWN4M2Bc55gcDNDXGjwdEAPomnJHHvwykO5b1fUgoNCiadf
         suRiz4R5wXLeqVcYhfBVCjCuwDxOjgtRil7705yaCLZ6iO8HC42vHahUiaov6X69RQJU
         VwMg==
X-Forwarded-Encrypted: i=1; AJvYcCUEohM34tM2KFQi+XV++25JWIHIetDMGnmIHrRkuMqV20uLueDbKy3gL2fb+7jPr7BTCYN0lxH99CthZHsJJZqp3gyH4STW7fpQ2rAALmGagkbBpDWPbcvljtGHmX565DB0F7KYlZth
X-Gm-Message-State: AOJu0YzYX4XBTPSliS0B4GoQ/ToRQ8ac9CbOGgA0Di9FHq8+Mo0fWSrK
	G02zHT/YyeZi8omjwSC+omdIsSVM2/sBfARTvsBOEPbPUHE+mb9a3LcT+C4/tjHZaP4xi/zru1j
	aPGjq1GBbjq2egv9mAsMgWtwdUs8=
X-Google-Smtp-Source: AGHT+IEwwSxGvw+su8rRrZrkNwlYiQ2EFKkWxDMRK3KWzk3cnll9uMBfnc1fpRtZZF+HmjwRiHVlXMVqPB5OOrvsChI=
X-Received: by 2002:a05:6512:2248:b0:523:3be3:cbfe with SMTP id
 2adb3069b0e04-5233be3cc5bmr18150114e87.65.1716269733053; Mon, 20 May 2024
 22:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1713778236.git.haibo1.xu@intel.com> <5c3a005a67096010cf3c465f8e3362651763fe3b.1713778236.git.haibo1.xu@intel.com>
In-Reply-To: <5c3a005a67096010cf3c465f8e3362651763fe3b.1713778236.git.haibo1.xu@intel.com>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Tue, 21 May 2024 13:35:21 +0800
Message-ID: <CAJve8okHV1r4H-yCNbMTg_Bg1pTgeh6zPTyqZtS25G+GVOu8ww@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] ACPI: NUMA: change the ACPI_NUMA to a hidden option
To: Haibo Xu <haibo1.xu@intel.com>
Cc: sunilvl@ventanamicro.com, arnd@arndb.de, ajones@ventanamicro.com, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Robert Moore <robert.moore@intel.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Guo Ren <guoren@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Greentime Hu <greentime.hu@sifive.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Zong Li <zong.li@sifive.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Chen Jiahao <chenjiahao16@huawei.com>, Jisheng Zhang <jszhang@kernel.org>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, James Morse <james.morse@arm.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Evan Green <evan@rivosinc.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ard Biesheuvel <ardb@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	Yuntao Wang <ytcoode@gmail.com>, Alison Schofield <alison.schofield@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

@Arnd Bergmann

Could you help review this patch?

Thanks,
Haibo

On Wed, Apr 24, 2024 at 1:31=E2=80=AFPM Haibo Xu <haibo1.xu@intel.com> wrot=
e:
>
> x86/arm64/loongarch would select ACPI_NUMA by default and riscv
> would do the same thing, so change it to a hidden option and the
> select statements except for the X86_64_ACPI_NUMA can also go away.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: Sunil V L <sunilvl@ventanamicro.com>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  arch/arm64/Kconfig        | 1 -
>  arch/loongarch/Kconfig    | 1 -
>  drivers/acpi/numa/Kconfig | 5 +----
>  3 files changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7b11c98b3e84..c6c667898da6 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1439,7 +1439,6 @@ config HOTPLUG_CPU
>  config NUMA
>         bool "NUMA Memory Allocation and Scheduler Support"
>         select GENERIC_ARCH_NUMA
> -       select ACPI_NUMA if ACPI
>         select OF_NUMA
>         select HAVE_SETUP_PER_CPU_AREA
>         select NEED_PER_CPU_EMBED_FIRST_CHUNK
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index a5f300ec6f28..29d574a5c34c 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -465,7 +465,6 @@ config NR_CPUS
>  config NUMA
>         bool "NUMA Support"
>         select SMP
> -       select ACPI_NUMA if ACPI
>         help
>           Say Y to compile the kernel with NUMA (Non-Uniform Memory Acces=
s)
>           support.  This option improves performance on systems with more
> diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
> index 849c2bd820b9..f33194d1e43f 100644
> --- a/drivers/acpi/numa/Kconfig
> +++ b/drivers/acpi/numa/Kconfig
> @@ -1,9 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  config ACPI_NUMA
> -       bool "NUMA support"
> -       depends on NUMA
> -       depends on (X86 || ARM64 || LOONGARCH)
> -       default y if ARM64
> +       def_bool NUMA && !X86
>
>  config ACPI_HMAT
>         bool "ACPI Heterogeneous Memory Attribute Table Support"
> --
> 2.34.1
>
