Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221E823535C
	for <acpica-devel@lists.linux.dev>; Fri,  1 Aug 2025 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754061213; cv=none; b=AM3KetUXH6H/rCQ2W8w55H3aNiFs3XPvziplG3nU1E029rDCXKXAQdIyB5tndpaQM2ejo+G1JsFl95FMcJ6idrjoppTLFAlnAr1AoCSTMpNPatkEd18ElAyPhHq3cGQTgp8iRm99lv1KVf7mGJ/hIJDodTlgjLdwn/Swld1LC7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754061213; c=relaxed/simple;
	bh=nBk+x/sL+91shEFy5WplqXsJOJbjQ0q5hTrrJ7agcU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ycaz4mRj2rsbP2/TFQSKX/yNgLMKOuiPOdig/6PCOVtVA1uYU+0kxVxgsggzqQXdP4WfiOQwD9QQvNyjQXDycgC8nJfBrjLVB5YfEDkCNX+UxIA/LHCxkHdbSrUMFP47SD9xa7vwlPNIxo6U0wu9JDdQVp1vb6tnNL+gSt5WcS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so397885866b.3
        for <acpica-devel@lists.linux.dev>; Fri, 01 Aug 2025 08:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754061210; x=1754666010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLvAFPQ8DYraj8LtMTWkc3DYDv2AWsFej7nsT5sUEtI=;
        b=aKmas9Wx8oCIPbnghrl/nL7mQAaSJGCOvF/t5nJo+ZyXxjcRraGFN2TrmmCFK67z7R
         TkgRSUVPezDKFsmW1yT7LW1wlsbxddsgZGA9Ax5E/iw8c5BMfrtbHJ84WReT9j3lpcWN
         +CeuR1t4G0JEZewgswoOqhYP3hD7Dsbmxhr3ENmU2xxNod0sAbfiAaXY3tTQkJVcNZ7b
         /9Qbq2kCtI1qswfa53yiXMCd1w7czV5O1D7CaN2es1n3f7EXP4mpkFtWBJEg17yXzMKj
         Sip1ySH9Nd8iyuUQibTCuZjftlHLsy0nvXw96CGjU9/FhdYKIg8Us+k6kbQWgqRjiAZu
         yq/g==
X-Forwarded-Encrypted: i=1; AJvYcCVUhM31nCSaCKYCL2ZJ8XnUvPvORDQEQbZ9H6uZ1PwrgpW2QZw7gUhEpKgU5MLs5iPCi4rTYLe6Ns8WaTc=@lists.linux.dev
X-Gm-Message-State: AOJu0YzAr7tPggWYrdB/Bu3uxzqxd6B5denkT/CsG11/lrXfJiAwzInd
	oUNPCWAulk46EF+7XyE3GXepDvLz81oIxpLldXaUD8UBDVTtMgwmap5k
X-Gm-Gg: ASbGncu/64hoz3He2SWSXYIiYJxPXt9iwa5XjwP/6s3w1P0Ssoo2Qh2zKX3UhnhgQlD
	Ayl8CfDKL5witmCYyA2fsogtBlBq04DMC9yFGnCoJjFdxMiiI5bcQqBZQzzGnp6q/zsyEEW6sLW
	FdddlvMFyR4iOBtUfYM11p7ufR6HXC9H226l+cRIh8V3/2pqHBTRnsaZJdFdat90A+R26rFOZIA
	D86DNx+qJCVJm4L0r4Jyg8EoleqoC04tP24N4lF4Sd0k1duwHZ7SrvGY3AeobIumddJVJjauXvv
	Nnp4/g5OxCGyNgtSGtPx3mZkVHUootzV7GIIZqb0nYXZYVJ/34ILehxeIjzw0RofpWwAYgneNWE
	SZzYBAJCOmYEsuw==
X-Google-Smtp-Source: AGHT+IHxwNCV+mxtZBzz5cvZjpfuoqtgwb9V8VUnUiYcYZ36deiu6WNQjZZGI0DAGbFT+RybIxFgAA==
X-Received: by 2002:a17:907:9706:b0:ae3:cd73:efde with SMTP id a640c23a62f3a-af9401b0c5emr13383466b.44.1754061210083;
        Fri, 01 Aug 2025 08:13:30 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a24062esm303137466b.126.2025.08.01.08.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 08:13:29 -0700 (PDT)
Date: Fri, 1 Aug 2025 08:13:26 -0700
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
Message-ID: <f3yl424iqiyctgz4j36hzjrhkgae3a2h5smhalm2qbmq3nrpzd@oeuprthscfez>
References: <20250801-vmcore_hw_error-v4-1-fa1fe65edb83@debian.org>
 <85663f65-d746-4e2c-b8a6-d594d9d0ba42@intel.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85663f65-d746-4e2c-b8a6-d594d9d0ba42@intel.com>

Hello Dave,

On Fri, Aug 01, 2025 at 07:52:17AM -0700, Dave Hansen wrote:
> On 8/1/25 05:31, Breno Leitao wrote:
> > Introduce a generic infrastructure for tracking recoverable hardware
> > errors (HW errors that are visible to the OS but does not cause a panic)
> > and record them for vmcore consumption.
> ...
> 
> Are there patches for the consumer side of this, too? Or do humans
> looking at crash dumps have to know what to go digging for?
> 
> In either case, don't we need documentation for this new ABI?

I have considered this, but the documentation for vmcoreinfo
(admin-guide/kdump/vmcoreinfo.rst) solely documents what is explicitly
exposed by vmcore, which differs from the nature of these counters.

Where would be a good place to document it?

> > @@ -1690,6 +1691,9 @@ noinstr void do_machine_check(struct pt_regs *regs)
> >  	}
> >  
> >  out:
> > +	/* Given it didn't panic, mark it as recoverable */
> > +	hwerr_log_error_type(HWERR_RECOV_MCE);
> > +
> 
> Does "MCE" mean anything outside of x86?

AFAIK this is a MCE concept.

> I wonder if this would be better left as "HWERR_RECOV_ARCH" or something.

Sure. I can update it to be more generic.

> > +void hwerr_log_error_type(enum hwerr_error_type src)
> > +{
> > +	if (src < 0 || src >= HWERR_RECOV_MAX)
> > +		return;
> > +
> > +	/* No need to atomics/locks given the precision is not important */
> 
> Sure, but it's not even more lines of code to do:
> 
> 	atomic_inc(&hwerr_data[src].count);
> 	WRITE_ONCE(hwerr_data[src].timestamp, ktime_get_real_seconds());
> 
> So why not?

Sure, we can do that, I will update it also.

> > +	hwerr_data[src].count++;
> > +	hwerr_data[src].timestamp = ktime_get_real_seconds();
> > +}
> > +EXPORT_SYMBOL_GPL(hwerr_log_error_type);
> 
> I'd also love to hear more about _actual_ users of this. Surely, someone
> hit a real world problem and thought this would be a nifty solution. Who
> was that? What problem did they hit? How does this help them?

Yes, this has been extensively discussed in the very first version of
the patch. Borislav raised the same question, which was discussed in the
following link:

https://lore.kernel.org/all/20250715125327.GGaHZPRz9QLNNO-7q8@fat_crate.local/

Thanks for the review,
--breno
