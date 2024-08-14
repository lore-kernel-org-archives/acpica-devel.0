Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F23D41746
	for <acpica-devel@lists.linux.dev>; Wed, 14 Aug 2024 05:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723613537; cv=none; b=gokWnhmU/QOsUnkov8/Bg6j8WHhjjipcJ67STDJqurqnWF15ztWFjIsb4eg8vIRmGnfSceGZXrXLzN8r1dHnhNU9FfFsGTsw3bpqW9ZAVc3nvy0tvpiTkL9tGBAWi6VUQgAikOcw8Q+OpcdmL7W1lRCFiBCnUiWX3cc1R4wQteA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723613537; c=relaxed/simple;
	bh=XWUT7Ncd4BhNORqSMjGJ4T2+gOtx/xZlS5w6FWK9m40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwpXCcmD7/cj31272JektzOFeQxDaF4IosDmSPxjQEww2JPLQtqbCXzjqbn/bZ82KpbgNrbPpSsAp4/PS+FhqeBn1jN5/SyqzsNdJ9BeN+VjjaRvQJzcyd55t38kBxYHwks7aipr3W2Imtuv8hvzMIEmkEZPa6vBuAajOMp2bNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=QNt8s9bh; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="QNt8s9bh"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7a1be7b7bb5so4515257a12.0
        for <acpica-devel@lists.linux.dev>; Tue, 13 Aug 2024 22:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723613535; x=1724218335; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MW1voiVkiK6ybB7ai4q3hjESE3gnEZP9taq8A0sM4Ac=;
        b=QNt8s9bhQp96wOd5yB4qx+cAbVqQUS8gtiZDKc1QcLD18DKfp7xmPCYGk0+3iqC7S/
         5WJ1B1xILb103QNVcSrkwofDS8NZwbnnl1UbeYJBdXhulD6gfvc77auf8bnKuHrlQGQG
         BQ2F2F9LfUv7F12B+Yq60jFFc12VXcytrR+TlOS/MsKNas1EXRhWZO8qy2ohSWlJgWqH
         q1Nu71wz8Ir1Uy8W4MvrjfFDZPoKIin+CaundKEPYpZxekyKi9bV7eo9elp3ZpciLM03
         nAPjLixfZO/zSGqKr5gzBSwDuAetZkI9wffinTtfqAfGZpIPt18+5jdlP8D3ufi5GBUW
         xBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723613535; x=1724218335;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MW1voiVkiK6ybB7ai4q3hjESE3gnEZP9taq8A0sM4Ac=;
        b=LqPO3o9gp1rkwrpnxq9l+f2KG5ducpOZ50mXX9zOsylEWQb3ppPjzIrhWBGC+pRJCf
         4xJZlz4raKBcXQArIO3aDXFauX605au65LFRcVdo9T0n1TU79qvUHwu2rLx7zCApqtvj
         g2Q0W6i/DySTvbk4e1yy9UFJ3Uq86hzA+gXwI7+p5FRsfBO7vqRQ+Zp6wPRSuBOxj+sw
         be3a4HqKhinK2rr96EbWB3i8uhg+4YwCu9lK90SVsz3H/hF6DMqAouqC3m+K9KVW4/5q
         m+Zyg+CKigucHsZ7NkyTCNt2jZoSgHbGXOlfIrUdYD2l1ShqPrfZbcYNUeJeLXZYwXfH
         3H2A==
X-Forwarded-Encrypted: i=1; AJvYcCWLXGwHN47mMAP2ywxL/aOJPvio2UOb1Pf5BBOv2T0THtSQ3YY4448eIo5EqsWNzK3/iwPQnD3uMmrRAYUe2Wz0VQUffu+RRmgrmhh0
X-Gm-Message-State: AOJu0Yz3RdNW7S2tMdy43oUkKGPbH3n35b6lWREDX92elF76Xl6Ivnx9
	KE2MQ5oiwCMBbKCgFOosj4Ji70CPcC3KARdQnY653JhBCabw1gMLcc+jcWNo2/c=
X-Google-Smtp-Source: AGHT+IG+HZ5EWjYic/b5QeOk5+VPgQJcNuvLcWtvoSZVAm6KKwkjPRIE2/NWQY79ieZs+RokBTE9nw==
X-Received: by 2002:a05:6a20:9f44:b0:1c6:9e5e:2ec4 with SMTP id adf61e73a8af0-1c8eaf8b3c0mr2418490637.50.1723613535290;
        Tue, 13 Aug 2024 22:32:15 -0700 (PDT)
Received: from sunil-laptop ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac7ca35fsm629732a91.9.2024.08.13.22.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 22:32:14 -0700 (PDT)
Date: Wed, 14 Aug 2024 11:02:03 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Subject: Re: [PATCH v8 01/17] arm64: PCI: Migrate ACPI related functions to
 pci-acpi.c
Message-ID: <ZrxBU4cPA6QAaxIs@sunil-laptop>
References: <20240812005929.113499-2-sunilvl@ventanamicro.com>
 <20240812180912.GA286962@bhelgaas>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240812180912.GA286962@bhelgaas>

On Mon, Aug 12, 2024 at 01:09:12PM -0500, Bjorn Helgaas wrote:
> On Mon, Aug 12, 2024 at 06:29:13AM +0530, Sunil V L wrote:
> > The functions defined in arm64 for ACPI support are required
> > for RISC-V also. To avoid duplication, move these functions
> > to common location.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Acked-by: Will Deacon <will@kernel.org>
> > Tested-by: BjÃ¶rn TÃ¶pel <bjorn@rivosinc.com>
> 
> Looks like "Björn Töpel" got corrupted somewhere along the line.
>
Thanks for noticing it, Bjorn!. Not sure how it happened. Sorry about
that. Let me wait for Rafael's inputs. I hope maintainers can edit it.
Otherwise, I can update and send another revision if required.

Thanks!
Sunil
