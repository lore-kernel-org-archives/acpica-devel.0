Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9610F1DF24F;
	Wed, 23 Jul 2025 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285020; cv=none; b=DS5yKbeIbQr5obTcCYPEdWxawSaqlRboDcnXYBInRiqIQNiRLtLlxA0PcGMIyJBfGDNmVl8m4DBBuKbT1EmbR8EyVyUfhP1i2+MbrI7xzoG8t0a/PLLpG4jl70ymZwF5CyjqrnkUZg97kamQM1wXttoTT0LV1RA56Es00UHRmIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285020; c=relaxed/simple;
	bh=+ER8pn1/f3NYVV2anIhl2ZioKi8MBMvlAz4WwMCtweQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWMtNVJGNRRJFYW5U66XXhmNimSWJE+WPewaL5v1ZHfndRwBLeEIc/e0Ri8D5+1bzy5NMCyFTrMzwYXzDvvhnChlPBBN/1NCBtzu0lSJa8PHso/aflEEZpkXMMDGdTNh6+ov8ECc4+hsTY7LAhmotE7Uy17meaQ8cTBdfaS1/V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae708b0e83eso1235077866b.2;
        Wed, 23 Jul 2025 08:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753285017; x=1753889817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxQ3M1WeHEo+nA3pDBj1z9ZXTmnmq5hk8Qm0uzS3eUY=;
        b=IHMQ5Gv5IpdQN99T1PeJsVwCnxisJY1UmDtIvpl3bA1a9gJ1oYDQzJumzZfJQ6bOUu
         TZYNEb32Q0VXfdOtKgwZAFHuENSKzytge19td+mBv7xz7doAA0r8BoKufCbPqbkL3mJb
         AxdEeoHDsVGAacV/YlrdoEOdXndVe/PwHVcKIIZsJhpqWF9PdqhL2T/NntMzAt141NtE
         iragcA3Byhs+yaLs41O/gA2ZpTNGaHzBTnRMFRb8PvNQG2bjjRAe82/dRXXtAAXPa8be
         GXkKITaM7yWEtP2/wYbMVrWcu5j2eYnjSjMq7EQyxdhtEUYT9LcNku2dcfoXpSl3rMXO
         uCOg==
X-Forwarded-Encrypted: i=1; AJvYcCVDCDdDKulw8iYXkKRPBsWtjAkEC/T28lVwq+dGn5glyni3RvT1zm4if8AaVhgpoYV/fc0iYC+V51GiiSmM6w==@lists.linux.dev, AJvYcCWsrCWoFfiOvST2UYeea3AddhTdOkXImPwxbBD+NEBc1Bc1MnzhS4UUPdPu9cKEIH1UuBNwD5k/0MmnqkU=@lists.linux.dev
X-Gm-Message-State: AOJu0YyhUPPYQQQdKHPYaK69GbdVM/kR4XfpaW6ZlS2YamdLRFKW0MuE
	/SNIwT6UuQKrooPY1EcH4PwCul3WlZWauXVN4GzADDGiU9c01waDq/UN
X-Gm-Gg: ASbGncu41UBL+FMD9cc0FDTdfjIBv9INJiK9cuskmndPYCt9ytdVQG7FL0MpP/sdOpC
	FdFVSLuP5OIalIPK1zgDt6WdNy/Kc+JXYI+haIvLm/vCVnU91YxpyULFxQwFcEsb3u6H4VGwu1g
	mkVjpCYiStwbGpUJvqHRRyjr0TRYjJwacgGx6agGuS3so5kOQKr3xOswyPMCsrsy6olBKwCVeIa
	j2HaS9ke2XLp6Ou2QOlJo3FnKo32nNdvYobTSh1CPVBeAQGktakvehNJQTwNGr1ZWShnam9Ss86
	T1oS1Sp/I/GxscsrxI5/7HyElLu6sA1cUZifeM+cE9/QVNbFO9aqvpmIbUeLg54TQHaDN71uYL5
	M7gzK3daMltKk3g==
X-Google-Smtp-Source: AGHT+IETRaOgydL5D9alhTF8zO82hzgDecgDyn/Edc5pZ0K0bOUQXLbkxv/O/N+5sE2Ilhir+6nemA==
X-Received: by 2002:a17:907:74a:b0:ad8:a935:b905 with SMTP id a640c23a62f3a-af2f6c0c6a1mr324567566b.22.1753285016210;
        Wed, 23 Jul 2025 08:36:56 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca7bc99sm1068454266b.109.2025.07.23.08.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 08:36:55 -0700 (PDT)
Date: Wed, 23 Jul 2025 08:36:52 -0700
From: Breno Leitao <leitao@debian.org>
To: kernel test robot <lkp@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Robert Moore <robert.moore@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev, osandov@osandov.com, 
	xueshuai@linux.alibaba.com, konrad.wilk@oracle.com, linux-edac@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3] vmcoreinfo: Track and log recoverable hardware errors
Message-ID: <cdlrppnrheyq7z3gmwmwsmktpmoiwq7g5hxa67rcx4iem5i6ge@jksa5o5use4w>
References: <20250722-vmcore_hw_error-v3-1-ff0683fc1f17@debian.org>
 <202507232209.GrgpSr47-lkp@intel.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202507232209.GrgpSr47-lkp@intel.com>

On Wed, Jul 23, 2025 at 10:28:29PM +0800, kernel test robot wrote:
> Hi Breno,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 97987520025658f30bb787a99ffbd9bbff9ffc9d]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Breno-Leitao/vmcoreinfo-Track-and-log-recoverable-hardware-errors/20250723-005950
> base:   97987520025658f30bb787a99ffbd9bbff9ffc9d
> patch link:    https://lore.kernel.org/r/20250722-vmcore_hw_error-v3-1-ff0683fc1f17%40debian.org
> patch subject: [PATCH v3] vmcoreinfo: Track and log recoverable hardware errors
> config: x86_64-buildonly-randconfig-001-20250723 (https://download.01.org/0day-ci/archive/20250723/202507232209.GrgpSr47-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250723/202507232209.GrgpSr47-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202507232209.GrgpSr47-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> vmlinux.o: warning: objtool: do_machine_check+0x5cc: call to hwerr_log_error_type() leaves .noinstr.text section

Oh, it seems a real issue.

Basically there are two approaches, from what I understand:

	1) mark do_machine_check() as noinstr

	2) Move hwerr_log_error_type() earlier inside the
	instrumentation_begin() area.

Probably option 1 might be more flexible, given that
hwerr_log_error_type() doesn't seem a function that anyone wants to
instrument?!
