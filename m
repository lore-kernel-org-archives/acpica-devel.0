Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB361D04A0
	for <acpica-devel@lists.linux.dev>; Tue, 27 Aug 2024 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778262; cv=none; b=DdZWEcaj32ovSHhAwuaOOQh+/JRCIjarlACcBVTKdz5rq4611pW29BtwapZiYHUDuAHJ5brPpFNO7m+QX6j8Dc4IBxMoegQhhBSFOlqMPDQXkkoHSH5jbQLVID5Pok4gEWFN6CWqS5q2EBBFYOp82omOtmC8ySYgtNuPt2owGK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778262; c=relaxed/simple;
	bh=obttAat1+8vwA+epeBCm2vdJfbrMJZxdRheqx2UuBrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJ8GRwJNbxb8N3SWw+gHHS0I1Tg4M959YLGw71DTHkX1/ZfmPJbbd98BOplHTpoP7e41DVGkggWMs9Z4QPpHGQwiEeGHkrkXJrMiCewMwKczvMqbCrTTaNvoJrmg3ZJ02vXxGqbGrUfz4CfmsULyqqgO/Iph5pxJh0uTbCYInPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=OzfVUv3+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OzfVUv3+"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-204eebfaebdso3724385ad.1
        for <acpica-devel@lists.linux.dev>; Tue, 27 Aug 2024 10:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1724778260; x=1725383060; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cHVS6GvCBnOPsiOYcG8jjXps+ccwvzgozbmG4OKMFBE=;
        b=OzfVUv3+XfBaoFuhpowExIDRLm0pMTNT3LdQH3jOw8CFRocbGkZjAlqpnZOKAG4JGB
         gSOxT6ASY13ObBAsg5IDBoTsBhS6aWYZ0a4uOkjcTTi5wHG4Jd2nY7x8DNNqW+7viDUP
         8QXqxPTLETrSTMsz3blEWwIxkp6ShFHRUiODF8J3NIPXkVdbUCKM3H07/afBZAtT83NE
         8INq5lKEml2gWh1/TxTz0wyJUZqXMQtMk8H+trV+XKuD6n98qsVZe7VFAhYamYGbndN3
         B3rYRqOImPoc8TnrZMNcTPl5vHZfKiaMFTv7jw+weWAAbm9cSVsw4RDp9AVZdssAXkG8
         GBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724778260; x=1725383060;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cHVS6GvCBnOPsiOYcG8jjXps+ccwvzgozbmG4OKMFBE=;
        b=U/8JgqV6HFG9ikX90iEzXBSY9k8McZl5EEp+t0J0ln9NZuohBq8WA3IhYG+D6O0Rg1
         O0oA6MbLHoxdnPiMU33zNoxBJmzH65YeC7axbDhSwq0ouuNkXugfETLscSEAxUM2kZ3f
         7tOul/krEN1GEn2z+MsFbxWxtK4cYbHkXwH3foTKhWKjW9lRo8Md/sCwvQHOxBXScMJ1
         bCxtzCJcTM5nGC6VeAvaAYrHLry4X5H/8zNbS7diKnBH007r2xrXRvyaBmliBm4D5DWs
         +mc68YW/yH/xsKZz1QM5AqEEEt81h+JLPZxmEaipxR58hLnwQAqPxzS0PRu0NHVTfDWB
         L5tg==
X-Forwarded-Encrypted: i=1; AJvYcCX5QJRJAoeRaGSRvlWmKOL3wMveRB6cIrEkr2QK7V/cUzHKME8/82xlUEJ6RaXXz1XzA6oVJcsOkdEk6iI=@lists.linux.dev
X-Gm-Message-State: AOJu0YznHvvEXNo55snBrrKtb/trsVxs3bB2y23Aj5hf8Fn6KsIbbRXJ
	OMI9gM180aOF1lGqppMetrQsnqx8ARBvcUNaeWHOykIV5z2dMs4244MOn0kTjXo=
X-Google-Smtp-Source: AGHT+IGpFb01J/dDnA2pToqsW0uyDaKXkNpjJlhzI0wYO6p2DBoqiGpaSi2i/MYfsiurNdOQfC7Pkw==
X-Received: by 2002:a17:903:41cb:b0:1ff:6b6e:d2bb with SMTP id d9443c01a7336-2039e4ef31fmr140578985ad.45.1724778260470;
        Tue, 27 Aug 2024 10:04:20 -0700 (PDT)
Received: from sunil-laptop ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855e2075sm85741915ad.120.2024.08.27.10.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 10:04:19 -0700 (PDT)
Date: Tue, 27 Aug 2024 22:34:09 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v8 00/17] RISC-V: ACPI: Add external interrupt controller
 support
Message-ID: <Zs4HCZH3M9nRXUvu@sunil-laptop>
References: <20240812005929.113499-1-sunilvl@ventanamicro.com>
 <ZrlgVUXC_dCW9ISM@sunil-laptop>
 <87mskzcnmf.ffs@tglx>
 <CAJZ5v0imJcU4cwDuZKEvGf93fZm4ea4s2Ocp3Cnfb3+nBQ0-Gg@mail.gmail.com>
 <Zsy3o_N8hvc6GfTp@sunil-laptop>
 <CAJZ5v0hxoT9tBjm3xRPU4fHx3MgHfYAx_Vyf4oe2toa3GWAN+Q@mail.gmail.com>
 <87jzg3c7bz.ffs@tglx>
 <CAJZ5v0iMpaxBevgPWmD2Ym_JG1ChkjzVFf22fV7Xw8-ssg9+Ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iMpaxBevgPWmD2Ym_JG1ChkjzVFf22fV7Xw8-ssg9+Ag@mail.gmail.com>

On Tue, Aug 27, 2024 at 06:20:24PM +0200, Rafael J. Wysocki wrote:
> On Mon, Aug 26, 2024 at 11:22 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Mon, Aug 26 2024 at 19:27, Rafael J. Wysocki wrote:
> > > On Mon, Aug 26, 2024 at 7:22 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
> > >> There will be a conflict in PLIC irqchip driver due to a recent patch [1].
> > >> This patch is not in latest RC5 release but in linux-next. I usually base the
> > >> series on latest RC release. Should I rebase to linux-next in this case
> > >> and send the next revision of the series resolving the conflict?
> > >
> > > No, please don't.
> > >
> > > That will be resolved at the merge time.
> >
> > Alternatively you can pull
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-08-25
> >
> > which I'm about to send to Linus latest tomorrow morning. That contains
> > the conflicting change.
> 
> So I've applied the series on top of the above.
> 
Thanks!

> This included a full-swing rebase of the last patch, which I hope I've
> done correctly, but Sunil please see
>
Yeah, sorry about that. You have resolved most of the conflicts but few
are missing (which were not obvious anyway). Could you please take below
commit and squash?

https://github.com/vlsunil/linux/commit/c85f9d0dc31c0e77916ecdbb457748c05cf4e75a

Thanks!
Sunil 
