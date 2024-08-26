Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3082D198A3B
	for <acpica-devel@lists.linux.dev>; Mon, 26 Aug 2024 17:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692404; cv=none; b=KDxDi8jRdNeo8ijIKAq276UoWMslx87tSPPJXcb2hV3fY9cA5IzsaqYWU+fv2n+c9rUCGZ2yT0ZvhucaAugsDAI5Ghz8Uf4bE9Q0ckNBvRynk4B+zAphDivauOfJfoT7p0IWISLxglTnE2YMe0mmz0MIqTBObeWVUqQ7I8uWC2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692404; c=relaxed/simple;
	bh=CUdwSZJktH/q1DEP07BLl57arbag2rOym3j5NvBYQc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5XqAb++uFZ7unvA199VA8r3ZMOfSlWJiMbTA8dkEmOMUgbZW/s396BpFAeXGVOmpIN+/DIcndMDQmitMVfWbN383PQmd/Km+xNyYraa0u03ldZ/QY9k/vQuNRjqc+sg/x3X7Y/kMkb89Kt8eJ29c5YiPIkyBSXvbd7I7egAm4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=U1PrWiU5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="U1PrWiU5"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-428243f928cso40866305e9.3
        for <acpica-devel@lists.linux.dev>; Mon, 26 Aug 2024 10:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1724692401; x=1725297201; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=owbqJXu8r6ZVrIB9CmtF0sA6DYb33fLeb9l3H1ArS6Y=;
        b=U1PrWiU5SDJrhm4X6l1c+feB10fSbux/Nr2N3a4p8Fl4TYTSQ2MlWiMGqHcdiTUvsd
         J9If52E8A76BSsUFIq8M0EkXaJ7oD/tdHeTu5R44SQNq/6OxehJfuCSSeyaPO2dedEiV
         MFLSVRTqeJX8S6BQGHsdSPndtXBuarX5xdAeOc74Qpye4OBw0u7w+1z4xzk8XQlywwE2
         rSqVPcVhakteQO9Cp6JqG8yRmC20KimH5XKM1Qwvt0BiXwnyUhnMBAdrgXe3pEzNHI44
         JyHWlef8CA+Lsyjpspd6zLRjH0vTfp9m6oHU0mq/DriD2+ZE+T1BZz+WA12YMiuSakYB
         cGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724692401; x=1725297201;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=owbqJXu8r6ZVrIB9CmtF0sA6DYb33fLeb9l3H1ArS6Y=;
        b=WYw3EiGi6BcKdxKI8ub8wbihRayfTNovAYik4pJ26hcIbGS7Dglc6h57qnTI0iKtpe
         tnm13392gg64zYYbLBcLwbIIdQHy5axzZ8+LByCrlNBuncfs5TI3+pq8Lw7wJyXdEC75
         q5N1GRD//9e+yxFBsOst05IuujLtzHNvCWcAiI4J2nnYJTy+lG5jIHQ1ckG9Cwdi6KqJ
         nZJzejqR4r7uLX7o4XXWTPm29aJt45wdH4/jnzITfUDYUPCP6BbmVmY9NXSzNL4z59E4
         pXLRhOtjqg2sjPUyGlEtsZHRbEQYVYZN4M5GWs7H+TbSgPnfw8K60/O9W3zmQyjn0Ybf
         rTMg==
X-Forwarded-Encrypted: i=1; AJvYcCUiKHQVS1LhFttUMokFnBsCeFQ+tgm7JSXqZkyU+88xMi38TdMF1prKkyOUHWttQwQAl/wM3knvRxW60J8=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxn7SWfPR/eFToMUA3pvu8YelzvvkY1oGYEos0FgfreT5lUR/n3
	UgyihLockC6noXqUjGfetyUpE4EQuAVbZAx9kzKnynDULFNo/6mqsuuXsuBKuzM=
X-Google-Smtp-Source: AGHT+IE/SRgvK54LwpBMAx+pBV1j6adr/sKFTs5Qr83pIPvX8proSmWucvbwrmsFVhpNjSBejE38cQ==
X-Received: by 2002:a05:600c:444e:b0:428:1965:450d with SMTP id 5b1f17b1804b1-42acc8e2397mr78248345e9.17.1724692401303;
        Mon, 26 Aug 2024 10:13:21 -0700 (PDT)
Received: from sunil-laptop ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abed8b666sm196588125e9.1.2024.08.26.10.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 10:13:20 -0700 (PDT)
Date: Mon, 26 Aug 2024 22:43:07 +0530
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
Message-ID: <Zsy3o_N8hvc6GfTp@sunil-laptop>
References: <20240812005929.113499-1-sunilvl@ventanamicro.com>
 <ZrlgVUXC_dCW9ISM@sunil-laptop>
 <87mskzcnmf.ffs@tglx>
 <CAJZ5v0imJcU4cwDuZKEvGf93fZm4ea4s2Ocp3Cnfb3+nBQ0-Gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0imJcU4cwDuZKEvGf93fZm4ea4s2Ocp3Cnfb3+nBQ0-Gg@mail.gmail.com>

On Mon, Aug 26, 2024 at 06:15:18PM +0200, Rafael J. Wysocki wrote:
> On Mon, Aug 26, 2024 at 5:25 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Mon, Aug 12 2024 at 06:37, Sunil V. L. wrote:
> > > On Mon, Aug 12, 2024 at 06:29:12AM +0530, Sunil V L wrote:
> > >> This series adds support for the below ECR approved by ASWG.
> > >> 1) MADT - https://drive.google.com/file/d/1oMGPyOD58JaPgMl1pKasT-VKsIKia7zR/view?usp=sharing
> > >>
> > >> The series primarily enables irqchip drivers for RISC-V ACPI based
> > >> platforms.
> > >
> > > This series has spent quite a bit of time now on the list. As you are
> > > aware, few clarifications like _PIC codes are also done now. There is
> > > no major change after you had agreed for the design. So, can this be
> > > considered for the next release please?
> >
> > Rafael, if you want to take it through the ACPI tree, then for the
> > irqchip parts please add:
> >
> >   Acked-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Yes, I'm going ro do this.
> 
> Thank you!
Thanks!

There will be a conflict in PLIC irqchip driver due to a recent patch [1].
This patch is not in latest RC5 release but in linux-next. I usually base the
series on latest RC release. Should I rebase to linux-next in this case
and send the next revision of the series resolving the conflict?

[1] - https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=4d936f10ff80274841537a26d1fbfe9984de0ef9

Thanks,
Sunil
