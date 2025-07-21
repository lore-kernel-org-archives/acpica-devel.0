Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F08A28FFE3
	for <acpica-devel@lists.linux.dev>; Mon, 21 Jul 2025 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753112611; cv=none; b=q2/cWmT2Cu4NrNfhQdZrnhpnoDYW7FbysOusXDvYpM1vP3i4CnI2TrR2MhQAB0jVpBCjkPcaGt3+nVpELQtZxtFHtd2hhVOOOCiZ4q9/jp/hMTd348pM7eGQKXMYasTR95u9zs6PP3wOi7e9lX4I75AIkkr0yMQfsl0IdxPn9EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753112611; c=relaxed/simple;
	bh=FmHzynu9CSyBjY7snrkDKw/+CacF/IzAQo3vvCbvS+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByCd8QCoNqYkMEjhXbrUcpDxZFAKqh1S0fs6quqbVTDD4k+WYcPAKFuxRQ62GzcUFOI7KRAQ4HgsQYp8vZf82eEt7qmKKE3HN/Ow1OBGwkCOZF2CUzbojJv1cxjzSjlxGbHrjQMxt0T1NbAVvO/Y2BL2b/UX/H2iKht4WFEPlxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso7929822a12.2
        for <acpica-devel@lists.linux.dev>; Mon, 21 Jul 2025 08:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753112608; x=1753717408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8EMch7mkTjcU9bPeMD8J/i/5F0EvPo6dc4/iWe3Dl8=;
        b=J8F7LIgr9aP2ycq2LLfPG7Tyg/+6NPlZ8Bh0ofvRwwjWJ70jl6UqtjHs16EaE7Pfod
         CrBbBOO4XfBsbVecAeiD3ZsvQ589aH4uXKY4ugyuyLYo8UTwdn0WVWZ2ufDuq0C1LnbU
         Bm8f2t3yG7mTH8mdq9UqUj3wLB509S8k8qbEE7T23gjSrodWzjjoU4sMblA2nScve2Ct
         v/R4orSbyo70uTNQHKXfbqW32pIAyR6gAzlY1D06EwDN+XusSjEpA4jKj3bTk2MC9Uqm
         Q82ZxUW6tKE1N23QoN/belvI4s5s9iKeP3UeH1Ae1ztQz/ggstnXLcQGpGvrxRO//PRN
         ar3w==
X-Forwarded-Encrypted: i=1; AJvYcCVvV2q4WozuI146vJMmICBz9VqPfMlwFy/ZYZynKmDpVTk9xg8UqTTRlMAmSNr8c88MW62Zn3xNVBfBW5o=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxth7+yOJ6iBp0wPOsvNY2zAtMiynWXJ66TbDsXwg2CsLt+FEgg
	0Z8VT9GF+azMWFRn3cw3ZaK2KjyiMB+rEje0lixY5zI8GiDkbMd+XRxE
X-Gm-Gg: ASbGnctdEepF8ZC5zg3P4LBAxiVSbpJaruKlwG4Wi9TuOUpM0C2zkJe+D9013nbsE1O
	KprWQ9LrOOV5foC4kaTpTQjF3ognU/r9BpwV3Qeh/WwCgR0gCh8lBBRFWlfdaKLKchhr7M0GNxm
	XVk1RbT1rfjbDq6AO94D4wUUJIbh1d4Lz7HCvwBIWqNFGe0YPXPdbJecj23XN2yryh0b9pxPbHg
	BlsG2PvPPv4FFaPxoLee3R6kEE2Cq3J5vLly4sNi9FsFx2juLwK0VWSc4LXcydROvbKNf8n80ZZ
	NSUNdP6ntojpRGBsCp3gIGSYfDot28mcgIsJzw/cjPaXyvKWJ08OQjsVLxeYaepUpxixtEMJAfr
	InK6BNMFjKxJkEh2zq9LRNRI=
X-Google-Smtp-Source: AGHT+IHiVZajLNzCqasc/a84TFi9Eq0YagQ04C+1iS6aqNPgOjIXzg/tFI2BWhK3viZOkIp11MJmpg==
X-Received: by 2002:a05:6402:13c8:b0:612:b573:f4bb with SMTP id 4fb4d7f45d1cf-612b57401cfmr14728022a12.0.1753112608001;
        Mon, 21 Jul 2025 08:43:28 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c8f0a0e2sm5675860a12.4.2025.07.21.08.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 08:43:27 -0700 (PDT)
Date: Mon, 21 Jul 2025 08:43:24 -0700
From: Breno Leitao <leitao@debian.org>
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, 
	Robert Moore <robert.moore@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev, osandov@osandov.com, 
	xueshuai@linux.alibaba.com, konrad.wilk@oracle.com, linux-edac@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2] vmcoreinfo: Track and log recoverable hardware errors
Message-ID: <crxrexye2nmqebct6eisgkvpc7btrg6ckh5qr7tmhpkdnqys2h@6dpf2j6yhlxq>
References: <20250721-vmcore_hw_error-v2-1-ab65a6b43c5a@debian.org>
 <20250721135718.GAaH5HPinaKvXjM-1g@renoirsky.local>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721135718.GAaH5HPinaKvXjM-1g@renoirsky.local>

Hello Borislav,

On Mon, Jul 21, 2025 at 03:57:18PM +0200, Borislav Petkov wrote:
> On Mon, Jul 21, 2025 at 03:13:40AM -0700, Breno Leitao wrote:
> > Introduce a generic infrastructure for tracking recoverable hardware
> > errors (HW errors that did not cause a panic) and record them for vmcore
> > consumption. This aids post-mortem crash analysis tools by preserving
> > a count and timestamp for the last occurrence of such errors.
> > 
> > This patch adds centralized logging for three common sources of
> 
> "Add centralized... "

Ack!

> > recoverable hardware errors:
> > 
> >   - PCIe AER Correctable errors
> >   - x86 Machine Check Exceptions (MCE)
> >   - APEI/CPER GHES corrected or recoverable errors
> > 
> > hwerror_tracking is write-only at kernel runtime, and it is meant to be
> > read from vmcore using tools like crash/drgn. For example, this is how
> > it looks like when opening the crashdump from drgn.
> > 
> > 	>>> prog['hwerror_tracking']
> > 	(struct hwerror_tracking_info [3]){
> > 		{
> > 			.count = (int)844,
> > 			.timestamp = (time64_t)1752852018,
> > 		},
> > 		...
> > 
> 
> I'm still missing the justification why rasdaemon can't be used here.
> You did explain it already in past emails.

Sorry, I will update it.

> > +enum hwerror_tracking_source {
> > +	HWE_RECOV_AER,
> > +	HWE_RECOV_MCE,
> > +	HWE_RECOV_GHES,
> > +	HWE_RECOV_MAX,
> > +};
> 
> Are we confident this separation will serve all cloud dudes?

I am not, but, I've added them to CC list of this patch, so, they are
more than free to chime in.

> > +void hwerror_tracking_log(enum hwerror_tracking_source src)
> 
> A function should have a verb in its name explaining what it does:
> 
> hwerr_log_error_type()
> 
> or so.

Ack!

I will wait a bit more and send an updated version.

Thanks for the review
--breno
