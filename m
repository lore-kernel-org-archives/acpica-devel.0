Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA06E1DF754
	for <acpica-devel@lists.linux.dev>; Wed, 30 Jul 2025 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896182; cv=none; b=ml9kzr3UoS1fTe0Fao5xPFHKlgXpv3zOd8RBR9zSdWHA/1rLyQAcwNxMpXaynmma8wDJ58QS9AFNAcUfITh8gqqy86s6g6LVXEii4yMXjuO+Id+/Xxx4PDVx6QDugwsgDQkS9NpwPyqnT7uACvrroroICwivjds0Fun94HwzpS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896182; c=relaxed/simple;
	bh=2inB9lrYIxnh5dD0KnQ79CfqCqa2mBwK28Hu1ed57RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyKxbBM5g8AXkrBswQjUE05h2GNiRvsipyYufFSMLFy2nyuqhx7P7MdBAMBd9hYpn4g53KsNouK9TFvO2lgb0c3TC7qeFG3q5FGkYP/1ecf5onJ6DsHvOHtWwqBzsOEzuZwO1KyzYomU7OhCJeAZkxsY+Mq0NQdq/5Iy3/IY9K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae0ccfd5ca5so1839766b.3
        for <acpica-devel@lists.linux.dev>; Wed, 30 Jul 2025 10:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753896179; x=1754500979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVG5g2ageWB6fvYTmlrchc1VftQuavVCJU6Q16hxq1Q=;
        b=RYW1/fN5nYrstJssvvQ/m4tQKG0kCdDzP6B89S+E1WvjcASqjfUOuQwOQemmhtui2z
         WbtgCtcpWaBzjIBAT3GeJqML0t5HcTecZh2NfVdU5Yvc8iwPDhkjHko19CSEEAtVHuYW
         SozOgPE3ZzuvOZTsY0R+LPdH9PiKA7je+cY1Fmr/sXLs4SRv7ouzQ5az2QhWM76WteIC
         BlRBZymOzzKXwJ7DM0LSc1rXWtV4XKJ8f6i9WVdmQ30YsVAJ58wkTl2BsZ6oHWrKrIsL
         gG62ZA66FKmWFhBR/Z4PofTC+MWrBaHfgoTt1Sz1bi+5RWWWyfVBHyXEBzux5RSfV7ab
         a0kA==
X-Forwarded-Encrypted: i=1; AJvYcCXXD9mcY1LZeNilqydiwzlCCoXg8T/y2TUlgXLChwZYNfAjHa4roxzLXA+C5khE0MFFPyBYeI1DPtagWrc=@lists.linux.dev
X-Gm-Message-State: AOJu0Yywmv875Lm3jO6ySRzWNQOV8DU+0ud1zLwOZuuYU8jANlz7h77H
	UBjlEPbcEpGZ5OfyZfwF8m8McdgVxU8trr51LUIQj/njpOqCQIXXAHav
X-Gm-Gg: ASbGncukEaM3kLHzkGuSbwY/wLwVlidIfKQS3Ws3D22xa9KBjUJtEga23PfMGKJr4j/
	yc3z+0KKzNw7+cWZk5C1KJm6Z8LvZErw4K4AO16yi/QwQizD+NjsBqQpXs59SzjrLAc69/Hqufj
	g2qsEZJZPWdE1baND7y0gIhFbNuKJU3U9soePFdhXAWQNY6fSiCq1MVSs/5Ssyc14LwivQHUV3x
	Zd1VF16gDPKLQOAbDaTNklxIfsDmQb7mMimJOeMAPgmDBTLBYtBOwnOpZ167prDsdDsFejPjbw/
	ApENVATjk81KEDitBLkhokcRWAGqq0J1pnpCyvbD1KRXpoyvsC3gAAvrgGK7TeoPkrdtxa28cbz
	8ejlPrV5Mtw3w
X-Google-Smtp-Source: AGHT+IEUbbT7MGZ9RPV14AyB319B+ILu1Zn4HTqqRjqhmc6jefo1B6r2lcAh4WufQuwJ5cKV1ZycMA==
X-Received: by 2002:a17:907:3d0f:b0:ade:3eb6:3c6 with SMTP id a640c23a62f3a-af8fd71454bmr552748166b.15.1753896178789;
        Wed, 30 Jul 2025 10:22:58 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635a63a5bsm781297566b.93.2025.07.30.10.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 10:22:58 -0700 (PDT)
Date: Wed, 30 Jul 2025 10:22:55 -0700
From: Breno Leitao <leitao@debian.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, 
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
	Robert Moore <robert.moore@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev, osandov@osandov.com, 
	konrad.wilk@oracle.com, linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3] vmcoreinfo: Track and log recoverable hardware errors
Message-ID: <4w7adjalaisxhdx4l2zzl6ghanky4geijl523q2ezz7b5kj4kq@fr44nlwsw6qa>
References: <20250722-vmcore_hw_error-v3-1-ff0683fc1f17@debian.org>
 <7ce9731a-b212-4e27-8809-0559eb36c5f2@linux.alibaba.com>
 <4qh2wbcbzdajh2tvki26qe4tqjazmyvbn7v7aqqhkxpitdrexo@ucch4ppo7i4e>
 <fdb5dced-ea5a-48b8-bbb4-fc3ade7f3df8@linux.alibaba.com>
 <ldlansfiesfxf4a6dzp5z2etquz5jgiq6ttx3al6q7sesgros6@xh4lkevbzsow>
 <4ef01be1-44b2-4bf5-afec-a90d4f71e955@linux.alibaba.com>
 <2a7ok3hdq3hmz45fzosd5vve4qpn6zy5uoogg33warsekigazu@wgfi7qsg5ixo>
 <a87c5e74-082f-4be6-bbfd-4867bf72ddcc@linux.alibaba.com>
 <zc4jm3hwvtwo5y2knk2bqzwmpf7ma7bdzs6uv2osavzcdew3nk@lfjrlp6sr7zz>
 <20250730182137.18605ea1@foz.lan>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730182137.18605ea1@foz.lan>

Hello Mauro,

On Wed, Jul 30, 2025 at 06:21:37PM +0200, Mauro Carvalho Chehab wrote:
> Em Wed, 30 Jul 2025 06:11:52 -0700
> Breno Leitao <leitao@debian.org> escreveu:
> > On Wed, Jul 30, 2025 at 10:13:13AM +0800, Shuai Xue wrote:
> > > In ghes_log_hwerr(), you're counting both CPER_SEV_CORRECTED and
> > > CPER_SEV_RECOVERABLE errors:  
> > 
> > Thanks. I was reading this code a bit more, and I want to make sure my
> > understanding is correct, giving I was confused about CORRECTED and
> > RECOVERABLE errors.
> > 
> > CPER_SEV_CORRECTED means it is corrected in the background, and the OS
> > was not even notified about it. That includes 1-bit ECC error.
> > THose are not the errors we are interested in, since they are irrelavant
> > to the OS.
> 
> Hardware-corrected errors aren't irrelevant. The rasdaemon utils capture
> such errors, as they may be a symptom of a hardware defect. In a matter
> of fact, at rasdamon, thresholds can be set to trigger an action, like
> for instance, disable memory blocks that contain defective memories.

Sorry, I meant that Hardware-corrected errors aren't relevant in the
context of this patch, where we are errors that the OS has some
influence and decision.

> This is specially relevant on HPC and supercomputer workloads, where
> it is a lot cheaper to disable a block of bad memory than to lose
> an entire job because that could take several weeks of run time on
> a supercomputer, just because a defective memory ended causing a
> failure at the application.

Agree. These errors are used in several ways, including to detect
hardware aging and hardware replacement at maintenance windows.

In this patchset, I am more focused on what information to add to
crashdump, so, it makes it easy to correlate crashes to hardware events,
and RECOVERABLE are the main ones.
