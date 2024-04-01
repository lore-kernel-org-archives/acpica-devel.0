Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6F2BA39
	for <acpica-devel@lists.linux.dev>; Mon,  1 Apr 2024 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711958669; cv=none; b=KSRgykFUUr3O0HjJTtLDc9wnhlq9Lo6ajjiApVBGafSDM9Be2uH9Zu+IOYGKxT+78OXboXKOZKKWwpkKxMrdYWyLzqQJkdJOcvrNguQPQCd4dR6A/lEBGM+5XZOr6oSZvmFlmMxUY+0uH1lqDMQT1cH9oLMgvbZfm8tkI0go3Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711958669; c=relaxed/simple;
	bh=MqCZEthzj+56GwiyzSk1Iz5eNGmS1DlYXJDS/UbVRh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwF3jpg9dpmk2E2zecpfj7xaC48NtsuIETLn0PznISP9ZQXUP2HrmsmuwMxKOviewulsOiiaL5mT8HlLWT+OtLTW6Ab95ONQrcZhrl45ithA1eC+piEcYx9OEDEJU3IJBugULYr7MdcLt83BuBs/VY4qfkNVnyL6YjU8RkTT5HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTflgOlU; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTflgOlU"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d23114b19dso51988151fa.3
        for <acpica-devel@lists.linux.dev>; Mon, 01 Apr 2024 01:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711958665; x=1712563465; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIPBLDUKvVlC/efDjwEAjrOmS6XB1w+iWO2tkQJfZSI=;
        b=KTflgOlUfPvFQFQEb2ZNAA2ApelkSZlPaRhcYWj1b3MfEMI+ypWLY7B+q5fuDjkyrO
         g2aJqOBDRqoIcQsLXWqBE+xV5F4tyhUDZ+dsZcr7UQaG0P73qABd86Gdu6W+fEpP+2I6
         +xb8P7R9sU/tUXRlscqTIafgk8Cg3TmsPefeloDDQOTyaYo/1Z0RrjKsSk9bwyP9j9M9
         qTvocFz+KEkTrhePU7Hc1xq7Hek2zVAWAWqFNegwFGxHY/rbpzkY0qAtWTt6+6B+I6oU
         yZmXrb+L0FZg+Q5LqG1mqZGdlO1dfOZW3iXc2sO53DsJw419zKh8U20xzijuXTHvY4Yd
         qvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711958665; x=1712563465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIPBLDUKvVlC/efDjwEAjrOmS6XB1w+iWO2tkQJfZSI=;
        b=e4Pukkv3NEkkBGo2pzQOVsMJOTwc4boNFeHPVzgtSpFhrSKUtbkM7D9Z21ImNHVDjp
         q1xXTosRRFFHpovr/kiZRon4AtK2+m17tt4zcjTUQniSKEBZsxYZHHqGgQY3VYepd5qC
         WtBb5ElIoCshcOGZCOxuQT43OjRebx8sW5opoE6Cw7JRi6jGPfmcpiXZMIVNmKI1Yfgq
         T4ngm/SX8d6reUVWJfqoLtB/xwvKU8TfmOyyU5AmCkEDX4RVTVJDg4uYMf+Ur4JNw5kV
         qwWJtRyBbxqejPmSSf7lFdnRao+o5jpiefx1jjmxSAvQHPhZDRPClv6kNHfgEDuMkNqw
         2djQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW5LlFy7OQY5RKcN6WXwYj2dTTYp+OqMxcu55BeHl6NtosTRfE/6LRloPz9D47U5gHO3rY8JSsZ4ypA1YXHZuX5AsG7xPfvvKfH0iv
X-Gm-Message-State: AOJu0Yz4M75xjUx56AuR/QEFvC+KxvAqYrNsn+tY8eQc3sEbYeaLh97j
	2PcHKIxrxkxZcdwWV94icp0YcpO3wG8OiiMdYW84mk+oYyb2/wOLIw/y0lDiafog+xPN7yXhRs1
	wycaVLQrZIGJZNZA0V93aOjL5z7g=
X-Google-Smtp-Source: AGHT+IF6MZSEh0qpjHWy2tctMPsCT4wg3Q6kZZ6mM8KnuUoKqHKr0TeNgyq+KgbADsJN1HMt9yrxPapQuQRzM4rXDtQ=
X-Received: by 2002:a2e:9141:0:b0:2d6:f085:1f64 with SMTP id
 q1-20020a2e9141000000b002d6f0851f64mr5832377ljg.48.1711958665425; Mon, 01 Apr
 2024 01:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1709780590.git.haibo1.xu@intel.com> <01cb5780041565784d459cd94a5c4f55eaa87739.1709780590.git.haibo1.xu@intel.com>
 <Zgpf0rqUSEZcSiAV@sunil-laptop>
In-Reply-To: <Zgpf0rqUSEZcSiAV@sunil-laptop>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Mon, 1 Apr 2024 16:04:13 +0800
Message-ID: <CAJve8om9-cTtYKLmB0R=6Wwh5KQ9z+16AFR-tuUkJhJjbn0UEA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] ACPI: RISCV: Enable ACPI based NUMA
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: Haibo Xu <haibo1.xu@intel.com>, ajones@ventanamicro.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Greentime Hu <greentime.hu@sifive.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Zong Li <zong.li@sifive.com>, 
	Jisheng Zhang <jszhang@kernel.org>, Baoquan He <bhe@redhat.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chen Jiahao <chenjiahao16@huawei.com>, 
	Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Evan Green <evan@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Marc Zyngier <maz@kernel.org>, 
	Anup Patel <apatel@ventanamicro.com>, Tony Luck <tony.luck@intel.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Yuntao Wang <ytcoode@gmail.com>, 
	Alison Schofield <alison.schofield@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 3:18=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com>=
 wrote:
>
> Hi Haibo,
>
> On Thu, Mar 07, 2024 at 04:47:58PM +0800, Haibo Xu wrote:
> > Enable ACPI based NUMA for RISCV in Kconfig.
> >
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  arch/riscv/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 0bfcfec67ed5..0fb55f166701 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -447,6 +447,7 @@ config NUMA
> >       select HAVE_SETUP_PER_CPU_AREA
> >       select NEED_PER_CPU_EMBED_FIRST_CHUNK
> >       select NEED_PER_CPU_PAGE_FIRST_CHUNK
> > +     select ACPI_NUMA if ACPI
>
> If the firmware didn't provide the SRAT/SLIT on ACPI based systems, then
> there will be a message "Failed to initialise from firmware" from
> arch_acpi_numa_init(). This is not specific to RISC-V. But I am
> wondering why should it be pr_info instead of pr_debug.
>

My understanding is maybe it just wants to expose explicit logs to
avoid any potential
bugs from FW or Kernel.

> Thanks,
> Sunil
> >       select OF_NUMA
> >       select USE_PERCPU_NUMA_NODE_ID
> >       help
> > --
> > 2.34.1
> >
