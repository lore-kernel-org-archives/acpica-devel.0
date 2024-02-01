Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9E839FEE
	for <acpica-devel@lists.linux.dev>; Thu,  1 Feb 2024 02:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706756346; cv=none; b=I40MSguJgedk6O0z9RLPq4ngHCGLtQVPZRn7rmDMqiq+nrxNRJW+y7qdIPygKrF7QLgUDcxBWad72RQCwKbK+HPYNNHO25//fpuqCVKSZwFO5nSPVjCVCmirECG4kOF4CyH+3tLEwvIFiEpeIwZgdUd5JxP8PvoBQND+lvhmnvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706756346; c=relaxed/simple;
	bh=ZMY5v0iedCBTdeMF74iUuLp9UhUF3Cl+Fp1XwNAGpK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cKZUJx3lW/ty/AWWL8u2A/IgQDGiHkS3FpQBWPTmUsBv5osIpa3VzmvlI9NK/z6xugNfn9QY+RZz4Ay3wYUX9Vvh/Hm6axVIsOeybCQid723KKpsSHRNGaIQvW15nGYTjzZxXc7G9/rP/SgXZmSMsbAWAX/85rP7oFZHmcpj4j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipbyMtl9; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipbyMtl9"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-510322d5363so633592e87.1
        for <acpica-devel@lists.linux.dev>; Wed, 31 Jan 2024 18:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706756343; x=1707361143; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CpLZHn3p6Y5uqROAkr3ACzV/aHb9p+4CqdQVObwG5g=;
        b=ipbyMtl9Eh+EgfFglXlb8k285RRzvwJnXmoUY0S1AJzDLScXuB/TN7OR346l4gJB8R
         urgaAe6lCm51GG0TzJCk6ig6yERN5M78tJxTZAn9MpwTLlShrEk+tNWTgBzpwPdM7Eb8
         /Trswmjz04Gjtj4NC8PaamvEI5R6LXGbhBASx0XiS56BhriVVrzO7DUC/AO3rMoBvPB9
         BraL9cEReVur6urEdQTFI8UEWPfOTQmJTwItWPTJ8GaRDRajQsIco7KENKC7IwqNFkYW
         cmcBvjrBIEGixnqOzuMAUBeVAETZvuQ/OPGXVDiiDa74IzQ0JM1YNfsECbyeu19u6Eqh
         uh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706756343; x=1707361143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CpLZHn3p6Y5uqROAkr3ACzV/aHb9p+4CqdQVObwG5g=;
        b=NW1ElGbasu6wdPQhnvvjssMxfAcDiwXrAIdKndFq/+nqxSH9/Sw8/NYVqAeiXbC11Y
         llg7g6iAy49C3DIS50+bP3OmHNMMyE2m4RKk/7prR+a86UtI0TaxYN5QM2/n2xYEqvCq
         fMEYgmJ5hxOJKJKyqW2Ji5mQvSUJ26CJbkhrQoSQjVz6vJHp0FGbE/2GUTljYaPvJar2
         IB5pGDI+Q752bpRY1809IMPGFY0gYwK04DODFRW0d2wmgdjb9sTJzHMd+grx7dtUWY6+
         WJSc7cIz+zHbSDLw1vE2wsVh1XJ0L31xc+zXzUqOXQUkpCTNCivy3xs+p2LihUSewoMm
         u7Bw==
X-Gm-Message-State: AOJu0YwfUl2vF3RxN2YABMgvp3We09qXCLcl9VTbFvuoU1uO4Vz6svvK
	HAVwsndPQxWPDprH5ltbNQ2BruKU/FRLeQqPQgmNXb5bGjjbV629B0hUPK0To5R/QU9R+i3zMCk
	FvwRx1eXIiz7XyaQCZ1yfW+ZhBhE=
X-Google-Smtp-Source: AGHT+IFqBWvZMFSoe1kdbaLQ4YMXumTydevNBtADzyVBBimPtohOhhboE3z66Jft4SF2LF6fmofYSXZ8L/E6AOgsCdI=
X-Received: by 2002:a05:6512:3d04:b0:511:2e99:c03 with SMTP id
 d4-20020a0565123d0400b005112e990c03mr439801lfv.8.1706756342679; Wed, 31 Jan
 2024 18:59:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1706603678.git.haibo1.xu@intel.com> <0be49d4d7d7e43933534aad6f72b35d3380519fd.1706603678.git.haibo1.xu@intel.com>
 <682f037e-0efe-4d73-b867-f1f86a244836@app.fastmail.com>
In-Reply-To: <682f037e-0efe-4d73-b867-f1f86a244836@app.fastmail.com>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Thu, 1 Feb 2024 10:58:51 +0800
Message-ID: <CAJve8okV_9qs6urESw2N-v8LT2-QP40jc1WhHYci7n-r9EoA9Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] ACPI: RISCV: Enable ACPI based NUMA
To: Arnd Bergmann <arnd@arndb.de>
Cc: Haibo Xu <haibo1.xu@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	linux-kernel@vger.kernel.org, "Conor.Dooley" <conor.dooley@microchip.com>, 
	guoren <guoren@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, 
	James Morse <james.morse@arm.com>, linux-riscv@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>, acpica-devel@lists.linux.dev, 
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, 
	Sami Tolvanen <samitolvanen@google.com>, Greentime Hu <greentime.hu@sifive.com>, 
	Len Brown <lenb@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Dan Williams <dan.j.williams@intel.com>, 
	Chen Jiahao <chenjiahao16@huawei.com>, Yuntao Wang <ytcoode@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Anup Patel <apatel@ventanamicro.com>, Tony Luck <tony.luck@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, 
	Samuel Holland <samuel.holland@sifive.com>, Evan Green <evan@rivosinc.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 5:33=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Wed, Jan 31, 2024, at 03:32, Haibo Xu wrote:
> > diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
> > index 849c2bd820b9..525297c44250 100644
> > --- a/drivers/acpi/numa/Kconfig
> > +++ b/drivers/acpi/numa/Kconfig
> > @@ -2,7 +2,7 @@
> >  config ACPI_NUMA
> >       bool "NUMA support"
> >       depends on NUMA
> > -     depends on (X86 || ARM64 || LOONGARCH)
> > +     depends on (X86 || ARM64 || LOONGARCH || RISCV)
>
> The dependency is no longer needed now since these are
> the four architectures that support ACPI now that IA64
> is gone.
>
> All of them also 'select ACPI_NUMA' by default, though on
> x86 this can still be disabled by manually turning off
> CONFIG_X86_64_ACPI_NUMA. I suspect we don't actually ever
> want to turn it off on x86 either, so I guess the Kconfig
> option can just be removed entirely.
>

Good catch! Will revert the change in the next version.

To remove the dependency entirely, I think we need a separate patch for it.
What's your opinion?

Regards,
Haibo

>      Arnd
