Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251A63D64
	for <acpica-devel@lists.linux.dev>; Sun,  7 Apr 2024 02:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712458416; cv=none; b=fwLIj8aZbNL6O7PjnMy9Jyz6GMo6PSgNJbnYzC1eE/fR1jzzAphctHFsNggLodcCddq72WrotbbU8k+lWRZtLQu8Nf9S7+yWnHdtUXOFqDulv6ILNedoJwCK286Haf+geDYOx1ftFx81tpWdilnpTsGkX5eLNYgm6KelMq/J3+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712458416; c=relaxed/simple;
	bh=7eg5LJVoCgGpvIy5viIhvb7qyO28VADsvG9BNbWNZpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rcAQg8UL2rp+FTZi8B3rR+WESm3GoCCvsx8rQ2Xjt6p7bHYLeYt0RFzOgdZNNE2p0MIMICmkNux7FCMZb3r4NiRwx7t62frhLBeeKl/SYUiykMDj58iH0X7ebt+mdG9bvhFjMkGYy4tjjZ8tIQ097tIYahQWZzdlI+HnGRjTlT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNvI+Tih; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNvI+Tih"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516d0161e13so3581771e87.3
        for <acpica-devel@lists.linux.dev>; Sat, 06 Apr 2024 19:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712458413; x=1713063213; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7eg5LJVoCgGpvIy5viIhvb7qyO28VADsvG9BNbWNZpc=;
        b=JNvI+TiheZ7ryfSB+jUE94aBBg9DmpRb9dQxKtJJUP23ueMTA44d7sXXwk9tjEdqiq
         c9BXQbuYK1kD5A627jBHpvL337y8gTjKf6KMUDI3YoKMCz8J6thduY/Xw0dwAxuAjxYD
         HifViDkgr8c/98Iv+YcRMLPtZTfcKjPwIjoOoUae066W5hedDqvGxfIknPO07Eol5pph
         iTsGhTKGbXpWKQe1qJFz5HMU7rFRBnTlrsuiLu7Mw0k/5kZyHtuuS1dc8MpLiIz7ZO/S
         zCW3+7HWTWrxnjVPFNnmQa6dPjO0tcONSfE9Hv0qOQaNN0WipqNroWhbz0MV6S4QJhG0
         eEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712458413; x=1713063213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7eg5LJVoCgGpvIy5viIhvb7qyO28VADsvG9BNbWNZpc=;
        b=mLRFWF6CbgF4ZJpyPlOSW/3w514ohOHHUmIQ8Y+GElAWrbv4J+BbL69FgYXmFRCAJ+
         tO24n5rwQRvOqGozYa0hq90AM2Pdx1wD6B9whpnAnnC/kwt8DvB8JviHHerz4kuuLyMc
         FvSMD9OqDHnEO1BGwRPoHMVUVwLqkD38o7YjxrkyRIuwc79IEFQNY3rE8idn22gDcqdb
         IbLDMvMMiWC1DI5PAI2jwRAA8Q82tsvncNx5QHUT4hjMEBPd96sx+LuHzQ33HzUfre3e
         xcvcygvfs25U+O0mYmuTg6oZoMzt+dDUcTDIRX/Md+nQJ4x4Z/GrDXKsLJyoT8LpdUuV
         gMzw==
X-Forwarded-Encrypted: i=1; AJvYcCUT04XPb5lGQPT2A1IJWe5zQi7D6eoCWlf9Eu1zcUGaTjilu0K1oF/3z337/TXQVRQDuudZtknlgzfZslNhdKjj9wVvaS+WeFfVZwZb
X-Gm-Message-State: AOJu0YxZhwpbQyxf+/UcuauWuXa5kFVG1+7OqaDWWilGwuyY4UL+MRV6
	VEfyxGTBPeVljgDr+KF/4pjx4qVJjO6sIJ0L4fS0UJPtYWl+R+tkHy2tBZm/O10GmKHHoR1Ucpx
	Cb2kyRR/XZ5F4PJ7IQufp2gqIurM=
X-Google-Smtp-Source: AGHT+IGPNaBY7p9jhIbr7kM96+qmULR+lYEMhFuh42Rbxchab60jlMaC+Feq12fbmoMqIEL4NxFEm18CO0ttHSM12Dc=
X-Received: by 2002:ac2:44b7:0:b0:513:cf75:2ccc with SMTP id
 c23-20020ac244b7000000b00513cf752cccmr3762064lfm.0.1712458413059; Sat, 06 Apr
 2024 19:53:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1709780590.git.haibo1.xu@intel.com> <01cb5780041565784d459cd94a5c4f55eaa87739.1709780590.git.haibo1.xu@intel.com>
 <Zgpf0rqUSEZcSiAV@sunil-laptop> <CAJve8om9-cTtYKLmB0R=6Wwh5KQ9z+16AFR-tuUkJhJjbn0UEA@mail.gmail.com>
 <SJ1PR11MB6083B43290D216B1568642B0FC3F2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZgzS7W83iWRII73G@sunil-laptop>
In-Reply-To: <ZgzS7W83iWRII73G@sunil-laptop>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Sun, 7 Apr 2024 10:53:21 +0800
Message-ID: <CAJve8o=VMXGwgGKQJvXiBXFLpqt+afFTG0vFvW-bTguzY76KMg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] ACPI: RISCV: Enable ACPI based NUMA
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, "Xu, Haibo1" <haibo1.xu@intel.com>, 
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	"Moore, Robert" <robert.moore@intel.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Greentime Hu <greentime.hu@sifive.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Zong Li <zong.li@sifive.com>, 
	Jisheng Zhang <jszhang@kernel.org>, Baoquan He <bhe@redhat.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chen Jiahao <chenjiahao16@huawei.com>, 
	Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Evan Green <evan@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Marc Zyngier <maz@kernel.org>, 
	Anup Patel <apatel@ventanamicro.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Yuntao Wang <ytcoode@gmail.com>, "Schofield, Alison" <alison.schofield@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 11:54=E2=80=AFAM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> On Mon, Apr 01, 2024 at 04:57:30PM +0000, Luck, Tony wrote:
> > >> If the firmware didn't provide the SRAT/SLIT on ACPI based systems, =
then
> > >> there will be a message "Failed to initialise from firmware" from
> > >> arch_acpi_numa_init(). This is not specific to RISC-V. But I am
> > >> wondering why should it be pr_info instead of pr_debug.
> > >>
> > >
> > > My understanding is maybe it just wants to expose explicit logs to
> > > avoid any potential bugs from FW or Kernel.
> >
> > There are lots of ACPI enabled systems that aren't NUMA (single
> > socket servers, desktops, laptops). Making this "pr_info()" would just
> > add noise to the boot on all of those.
> >
> Exactly. But this is an existing pr_info message across architectures.
> My suggestion is to add one more patch in this series to convert
> this to pr_debug unless someone has strong reason to keep it pr_info.
>

Sure. I will add a patch to fix it in v3.

Thanks,
Haibo

> Thanks,
> Sunil
