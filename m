Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844B256753
	for <acpica-devel@lists.linux.dev>; Thu,  2 May 2024 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714643801; cv=none; b=F8rEQ0lks4Dhs4BWcBYOH7jTRCybCIjq0IPWnxiXXAMmbAYTq8SDVKfccMZ+4Vjdc9w/noGzmV091QyRuTk2NOg7vRJVF+XZKthrUF6h28K+f/AmixDEh4Crq3esQN/68bRnIDj1c8yjkjWwKFtFFGwwX+INtOruv4gqAq4HwN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714643801; c=relaxed/simple;
	bh=3l3zV1CvMpPQ6M3agjT4bErcSYjrF9CaWcpEI3wJ9GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCnT6sXfmNbseH34qupx1/olSMDB9eQJUtxfgPbDxm5OzlomozXuRwCxeLEFmqHqFeEHQ/blo4QcM1JqN59kzkICIzZklFxk81jqnROqcy+BaRDs81V9xJHSIw+ZPSXAmImI7rYBnmyz61vYwlCN8qeA7CTtMKDXsuxfEPmdFqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=jkJXqnUu; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="jkJXqnUu"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6082fd3e96eso5629540a12.1
        for <acpica-devel@lists.linux.dev>; Thu, 02 May 2024 02:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714643800; x=1715248600; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sucCdO5kXmwHz0FAAtAAGExlkRhEC3HqOy4Cv/qw8KI=;
        b=jkJXqnUuEdPcDHW5EHNphvYs88w3hajS17R5Nj1QPVWJMj6AxWRVsPS3vNLecvWEjP
         +guxmt873/Ih6G7VcyZecXiy25/bEehKrOOfEGf45MD2MOl5D7avXmb7HuBesC0cfhaR
         wMv2T6wVI5R2AjCnxFeBbDxflHmPhgvostxWDH+FmSGV1aSUE2W2I97u/pbvWRk15xEv
         wgYcGjPQU3MNsODwLSupJR7mWqJD30W7kbSB89quIL15tLtzmfxd+fcTOLMKqx5W2pd5
         +ZByriaXK5GriYoZkIu2vg24c/UPZzO8qvvLfj/O+EThM/Hd/xr5sdIAEyFSBquaGwXt
         qFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714643800; x=1715248600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sucCdO5kXmwHz0FAAtAAGExlkRhEC3HqOy4Cv/qw8KI=;
        b=aAVQp0EVdKIhHbTzGCfEuTLUuMgyyOERJfp1OmToGWVdbAd3vcM2l1+BaTe82ViiLJ
         C4yKrxIjWtfQFdIHeWPXBEGpuS25j7zNvM0zENxtNGAcgl2CYgAAq0FRn1aAAn4OM/oa
         5A+j/hBIvaqYo9uMp3vYDsTcvKGh6bGFZ8cdD4lCGxGZgcUA2HMEWGod8vyL2PLvIHlu
         Ac+zk/ArOSyw2DchoccMTdUZCNQ28qeW3hx5zYY8d4qDs4NqYMakdsMRf1b2bgZS2o3h
         28vUi6s1v2YsaRv/tk5FR4EUf8SwcKVNZcU6yOcRBz+OiL7zcIOCIq2nwoRzBYCBZcIj
         N02g==
X-Forwarded-Encrypted: i=1; AJvYcCUd24Jmc43ZVRQWNGCm8uMl6liYY/bqT/HnYgPd/t5rN7L6aKha/MG9hO1jWskmlZz3vCUUJKoMEV/qrhz3wNFNVkvmDxCwSDrsh3fQ
X-Gm-Message-State: AOJu0Yz+0MyvMf6la2s9T3rOK0WQaziU7pyZGOma8M0whDcue+7h8IFA
	3f0m/Bq6p6B+i/ICnnQC7OkIimQQoqaF3db4I7NFiaK5R4+n+fzqbnDXHrLddmg=
X-Google-Smtp-Source: AGHT+IEdqN4j0tZUjqkf7AiQCf6AILBV0FVoUPT7pSiU8sVSt1YtTCq7aHm3fUhXEYUOJZhfGVfIwA==
X-Received: by 2002:a05:6a20:7f86:b0:1a7:5402:8a92 with SMTP id d6-20020a056a207f8600b001a754028a92mr1702915pzj.31.1714643799826;
        Thu, 02 May 2024 02:56:39 -0700 (PDT)
Received: from sunil-laptop ([106.51.190.19])
        by smtp.gmail.com with ESMTPSA id lf12-20020a170902fb4c00b001eb53dcf458sm864846plb.188.2024.05.02.02.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 02:56:39 -0700 (PDT)
Date: Thu, 2 May 2024 15:26:26 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Subject: Re: [PATCH v5 01/17] arm64: PCI: Migrate ACPI related functions to
 pci-acpi.c
Message-ID: <ZjNjSpJus7EYT6zn@sunil-laptop>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
 <20240501121742.1215792-2-sunilvl@ventanamicro.com>
 <ZjNbVPYIjINdk4Fn@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjNbVPYIjINdk4Fn@smile.fi.intel.com>

On Thu, May 02, 2024 at 12:22:28PM +0300, Andy Shevchenko wrote:
> On Wed, May 01, 2024 at 05:47:26PM +0530, Sunil V L wrote:
> > The functions defined in arm64 for ACPI support are required
> > for RISC-V also. To avoid duplication, move these functions
> > to common location.
> 
> ...
> 
> There are -M -C parameters to git format-patch. Use them in the next version of
> the series. (Note, you may add percentage numbers to each of those parameters
> to get prettier result.)
> 
Yeah, I tried different combination of percentage after you told me last
time. I just didn't see any difference in the patch generated. Let me
try again while sending next version. Thanks!

