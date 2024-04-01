Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD69153BE
	for <acpica-devel@lists.linux.dev>; Mon,  1 Apr 2024 07:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711957333; cv=none; b=BU7Mdz2NCHMJ8lf2kZ+m7eXRzte1ih0NSM55z5WPrjFt5msNQw+5iUzkunGDbSK6cDJpNAy/wPgBPYwYYzIMpoAN8vdaJClH9W49YG2X2O2daicEukBPag06KxLdt7pW1g8NKbOn2JZ/YWAoX/hfKSwWZbtF+zBU0BLHZMXcc3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711957333; c=relaxed/simple;
	bh=P//M+IKlwXWXeRYmsYCshnL9dhQNOzT6a0koi/j5vcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecrvVQF39ciLkJCsHGekpx+92gM9B9L3Wf94IZaCkdYa7mukF+Z+xBsMyqgRNo1AFJSUO61aCJiwwyxWszpp2QyUob5xqXhlB+wVAWz63G3qmXC88l8teWf4Hn0JN/jfkG8B5sGn09VoVcWzkV94yTDBeNuzIQXsRLXwWxq49hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jh1qm5Gg; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jh1qm5Gg"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d68cf90ec4so54054161fa.1
        for <acpica-devel@lists.linux.dev>; Mon, 01 Apr 2024 00:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711957330; x=1712562130; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SSJljyfKnuJeOjPki7PuFiCXRujcBFkC7jlbcW3GDA=;
        b=Jh1qm5GgVfPmlMQZ1nwt/5voNm7g5a09T00O2r476avNQ1OiAufIEcBdIigSdbOiGQ
         zHvj+l2l0dlsur1g1lgBECpcTVUR+Wu1FXT4XTJ8oBMtR2tuVsSddu4HFgGS/mt/vAY1
         qAhrcb8ClUDUH6Q8X9EmHujSdSZbASXhXxXiQlinUtfomLboYGO6bvroAh/oRn4Xz+oR
         mel48sARiDtg3S6LNNkU11RqoqINTrFsJtXAKsAXBDUqLunLT7oitalgFFcd0xljozMC
         giXKw4L6xkLwhVM0rWtGgvUxN97bQMs14lH7/Bj1agY2Q7q9wuT5kdpn/j+iuG0csoxx
         gazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711957330; x=1712562130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SSJljyfKnuJeOjPki7PuFiCXRujcBFkC7jlbcW3GDA=;
        b=pO+JNQSvXxAJbZ8eg7GDRWU91Z8A7dkEkj2142Cjq9g6UboWokbcGpUJztEFKXW2e+
         Wmfx1BlAXKsyMKLJam5iO+pGi70GzK/hkwbFneHxrCcCFZdYmhFfR3cY4KprWtI7d8lQ
         cvAFZDDXikuC8EX034HENjfRT5SziIhlu9YLVrkKBLl+uLA5PfJYodRnfbT25SuND+Yt
         CLsa76dYDBj73p4NbWyES51ILV/98XzAQxhDCm5b93fXvyn0yU9FkSNtw0pO9kJDXaXN
         IqqovT/xA3TjAAdVPgY3rradEJM4gSegUQMYXUOObui2MwNU1Ht0hvn9bLBe/RctNvPl
         3vGg==
X-Forwarded-Encrypted: i=1; AJvYcCVHD5EgcbiZ47UEkKBnEPxq0ZRWWZmLpn2aCQvAZRZDyLEpeBfj6PT04aFck3qlKjGx4JXdf+KEAOXXj2qgHufsG1+Mz/BUeEl0oVCW
X-Gm-Message-State: AOJu0Yz2hHD3ge/KsUlBOX5Nm0Wi4eg8eDxuM73fzJSFXcTEp09FVtGg
	05FsH0oCy5v6jUzzSG0B3wLU3O1K3EGMcVKHebBRnB7piHiCz/rUZZxggQtPRWCYzJlUa9Ki9xp
	68S9/eByqJecDjTOrT2BUdrZB90E=
X-Google-Smtp-Source: AGHT+IHCeA3ZB/fyrTz8pMLnWGInr5YcrgiR+a/NUwxJXCLgasVcZNlOpzcH0Q5xA1D7XlYsXG2Jk7k5azBlx/fUck4=
X-Received: by 2002:a2e:a455:0:b0:2d6:f5db:4d6e with SMTP id
 v21-20020a2ea455000000b002d6f5db4d6emr4780215ljn.40.1711957329905; Mon, 01
 Apr 2024 00:42:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1709780590.git.haibo1.xu@intel.com> <7ca110c59cbb2fb358304a9ba4f9c7cbeb191345.1709780590.git.haibo1.xu@intel.com>
 <Zgpc/qW/as+gbb+I@sunil-laptop>
In-Reply-To: <Zgpc/qW/as+gbb+I@sunil-laptop>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Mon, 1 Apr 2024 15:41:58 +0800
Message-ID: <CAJve8o=s-hN28hXPB30oJB0cAoDAEPUbTYNh3V0Nzd-2DoT4vQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] ACPI: RISCV: Add NUMA support based on SRAT and SLIT
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: Haibo Xu <haibo1.xu@intel.com>, ajones@ventanamicro.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Greentime Hu <greentime.hu@sifive.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Sami Tolvanen <samitolvanen@google.com>, Zong Li <zong.li@sifive.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chen Jiahao <chenjiahao16@huawei.com>, 
	Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Evan Green <evan@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Marc Zyngier <maz@kernel.org>, 
	Anup Patel <apatel@ventanamicro.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, Yuntao Wang <ytcoode@gmail.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 3:06=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com>=
 wrote:
>
> On Thu, Mar 07, 2024 at 04:47:54PM +0800, Haibo Xu wrote:
> > Add acpi_numa.c file to enable parse NUMA information from
> > ACPI SRAT and SLIT tables. SRAT table provide CPUs(Hart) and
> > memory nodes to proximity domain mapping, while SLIT table
> > provide the distance metrics between proximity domains.
> >
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > ---
> >  arch/riscv/include/asm/acpi.h |  15 +++-
> >  arch/riscv/kernel/Makefile    |   1 +
> >  arch/riscv/kernel/acpi.c      |   5 --
> >  arch/riscv/kernel/acpi_numa.c | 131 ++++++++++++++++++++++++++++++++++
> >  arch/riscv/kernel/setup.c     |   4 +-
> >  arch/riscv/kernel/smpboot.c   |   2 -
> >  include/linux/acpi.h          |   6 ++
> >  7 files changed, 154 insertions(+), 10 deletions(-)

> >  #ifndef PHYS_CPUID_INVALID
> >  typedef u32 phys_cpuid_t;
> >  #define PHYS_CPUID_INVALID (phys_cpuid_t)(-1)
> > --
> This is a large patch spanning across multiple files. Can we split this
> into multiple smaller patches? Changes look fine to me though.
>

Thanks for the review!
I will try to break them in v3.

> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
