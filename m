Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A6F1B4F0E
	for <acpica-devel@lists.linux.dev>; Fri,  1 Aug 2025 17:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754067640; cv=none; b=UoXmBdJr5+89wj2uQNfx32OjXKIMfbjWko3L48uUsczcpSHpvIzNmhqdR/8yvHimb+HKRfI++kx2jJvP9aKuhfpaphRu6c+S2X1D95dOQgu8GDYE3JvneA3H469CA+LuvmrFOxCEjp+Iq5LIy16zV/NqK3E/gdJufXfvDef2j1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754067640; c=relaxed/simple;
	bh=PykCCBJs105n+LC2iU2zPr6kU0wR30+97kLkwypCJZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOQj2pDITMDPsK3B56dYpdaRuphA1Cv4stDiQh6g7kra7S8bvpZp8tAxVCqhZQ1GDtAjADuLwNH3zTYBgXTa9oTHA2+gBGC3g9U61rq6pxUzMkUtSE7+becbltRWDE+5IUbB70yKZwKsaIgmCQIKTn+f5tzknm2CRL074ipt1Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae708b0e83eso339600066b.2
        for <acpica-devel@lists.linux.dev>; Fri, 01 Aug 2025 10:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754067637; x=1754672437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfCYUUeNzqTP+LwSzZh8YLP72/OXU9Xwsponm3y55nE=;
        b=EnBL7ea91WS2V6rvk2aqEqyCWhF/2qB9Le9EM2jbCCN5/hm/m7VJz4ZWZXFVZJkUG2
         2J+yK+DrS/dR1uznJNyA1vDspDr0UdKC9frUHUe+wdwOxJqpEuBKxltafkMzWH+eLkfZ
         TfUWwcLREPWPFo6arlCx7eNbsQ2NfPi/GV6ETJTifLoTUI5UltwDfkKWQCtQVvtMnrYb
         2DeTVtRn5712Tw+Bz7EF2S9YZbRhfUzJJBGiPu3ODyTQfpmPIBEuf/9UhAdKLKCRqMJ5
         J3uMd9G9vu2fmVR7ljXHxBw5hubCUedWIdmzRA++kwtExk2zLB4p8s+dbpYztuamZQJF
         0XhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVm1HeyUUXdaedkK21o+mMC29RqHwWEc3hANGLPWDkx9XfgP+4+vhF5yVJ+8KVd0KveiIto2H5H8TtKDmc=@lists.linux.dev
X-Gm-Message-State: AOJu0YznpDa19Afi+H+mz9C+MXcv0Ia7h8RXoWksQU5MCMSVKbYBtJVt
	/ffocoMzcdr+7YtVmjFyw4MJIEFWeqy8Pc3ObryDXraTYdFSACitztwf
X-Gm-Gg: ASbGnctvYpO4GC+AYBQryX3wZk8iV1X59FyabYVm3wYWJYfLs+v2tTH0ldelvSI0gDM
	ndFWEWKYA6MnZ/zfTobar2gJ9+5hHCFLo9jBTYGwsVLSzGLeHCTZqjJWvcij2Jw5Oij43bT5pOe
	SUnIRQ3hv77NxMCxcK3okXSzJBvQAFDbm3qwm0ss0xSP1CPmgqkzAEd8liVjfyl5zD3Rx4p1Pl3
	KHO7N2D9+2+6M5CFrfeiuly8e/chUwZjwakKsmI5rVFyHve7pk8YlVaD9Wuefe8WKyd7uvM7Lp3
	HtKJZTclcsgx/s3hZncFipFrex72K2ZJQ8XlTszTkOKcepFMGky2k2PeqzaNSU3iSCcofqx3UiK
	A+4v3HTurj8EpZA==
X-Google-Smtp-Source: AGHT+IGpq60CKY3QvKTsc9HB8eSUqXk3f/gsXwEntEJaK1GEY6vGj3gABeOiP8jIzbPXR/Pw3PU1uA==
X-Received: by 2002:a17:907:7fa3:b0:af9:2bb9:ea36 with SMTP id a640c23a62f3a-af93ffbe3c3mr59933566b.7.1754067637034;
        Fri, 01 Aug 2025 10:00:37 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91b36e91dsm295781466b.69.2025.08.01.10.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 10:00:36 -0700 (PDT)
Date: Fri, 1 Aug 2025 10:00:33 -0700
From: Breno Leitao <leitao@debian.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Robert Moore <robert.moore@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev, osandov@osandov.com, 
	xueshuai@linux.alibaba.com, konrad.wilk@oracle.com, linux-edac@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, kernel-team@meta.com, osandov@fb.com
Subject: Re: [PATCH v4] vmcoreinfo: Track and log recoverable hardware errors
Message-ID: <buhwuankenpnvmio6jeoxverixoyfpn2eh62ix7vzxw7xvlxcv@rpibcrufr2yg>
References: <20250801-vmcore_hw_error-v4-1-fa1fe65edb83@debian.org>
 <85663f65-d746-4e2c-b8a6-d594d9d0ba42@intel.com>
 <f3yl424iqiyctgz4j36hzjrhkgae3a2h5smhalm2qbmq3nrpzd@oeuprthscfez>
 <0c045f1b-44d0-430c-9e8a-58b65dd84453@intel.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c045f1b-44d0-430c-9e8a-58b65dd84453@intel.com>

hello Dave,

On Fri, Aug 01, 2025 at 09:24:43AM -0700, Dave Hansen wrote:
> On 8/1/25 08:13, Breno Leitao wrote:
> > On Fri, Aug 01, 2025 at 07:52:17AM -0700, Dave Hansen wrote:
> >> On 8/1/25 05:31, Breno Leitao wrote:
> >>> Introduce a generic infrastructure for tracking recoverable hardware
> >>> errors (HW errors that are visible to the OS but does not cause a panic)
> >>> and record them for vmcore consumption.
> >> ...
> >>
> >> Are there patches for the consumer side of this, too? Or do humans
> >> looking at crash dumps have to know what to go digging for?
> >>
> >> In either case, don't we need documentation for this new ABI?
> > 
> > I have considered this, but the documentation for vmcoreinfo
> > (admin-guide/kdump/vmcoreinfo.rst) solely documents what is explicitly
> > exposed by vmcore, which differs from the nature of these counters.
> > 
> > Where would be a good place to document it?
> 
> I'm not picky. But you also didn't quite answer the question I was asking.
> 
> Is this new data for humans or machines to read?

I would say that the main consumer for this are post-mortem tools that
collect information of the vmcore and do diagnostic and correlation.
This is a common tooling for cloud providers, AFAIK.

In my work environment, there is a script that runs `drgn` on every
vmcore to capture information that would help operator to address the
problem. The information that this patch is proposing adds another field
that would help to potentially correlate crashes with recoverable error.

> >> Does "MCE" mean anything outside of x86?
> > 
> > AFAIK this is a MCE concept.
> 
> I'm not really sure what that response means.
> 
> There are two problems here. First is that HWERR_RECOV_MCE is defined in
> arch-generic code, but it may never get used by anything other than x86
> when CONFIG_X86_MCE.
> 
> That also completely wastes space in your data structure when
> HWERR_RECOV_MCE=n. Not a huge deal as-is, but it's still a bit sloppy
> and wasteful.

Would a solution like this look better?

	enum hwerr_error_type {
		HWERR_RECOV_CPU,
		HWERR_RECOV_MEMORY,
		HWERR_RECOV_PCI,
		HWERR_RECOV_CXL,
		HWERR_RECOV_OTHERS,
	#ifdef CONFIG_X86_MCE
		HWERR_RECOV_MCE,
	#endif
		HWERR_RECOV_MAX,
	};

Or, would you prefer to have HWERR_RECOV_ARCH and keep it always there?

> >> I'd also love to hear more about _actual_ users of this. Surely, someone
> >> hit a real world problem and thought this would be a nifty solution. Who
> >> was that? What problem did they hit? How does this help them?
> > 
> > Yes, this has been extensively discussed in the very first version of
> > the patch. Borislav raised the same question, which was discussed in the
> > following link:
> > 
> > https://lore.kernel.org/all/20250715125327.GGaHZPRz9QLNNO-7q8@fat_crate.local/
> 
> When someone raises a concern, we usually try to alleviate the concern
> in a way that is self-contained in the next posting. A cover letter with
> a full explanation would be one place to put the reasoning, for example.
> 
> But expecting future reviewers to plod through all the old threads isn't
> really feasible.

Sorry. I tried to improve the documentation and wrote the following
message to the commit message, which was clearly not enough.

	This helps fleet operators quickly triage whether a crash may be
	influenced by hardware recoverable errors (which executes a uncommon
	code path in the kernel), especially when recoverable errors occurred
	shortly before a panic, such as the bug fixed by
	commit ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them
	when destroying the pool")

For next commit I will add a cover-letter, with the summary of the
details of that discussion.

Thanks for the review and suggestions,
--breno

