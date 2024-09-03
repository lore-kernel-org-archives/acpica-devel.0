Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82861DAC6C
	for <acpica-devel@lists.linux.dev>; Tue,  3 Sep 2024 07:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350229; cv=none; b=AG7LrxWlNPXAUakLW0jPECATL4veyUeVnIV5vkPUO9WUEkhThs4Vu/26jsmgGNAFDSRthotF1uKFs7ir+rdiuh8ea1GFiIlOA4ZmbSatLRuUPAX+eFTG5fwI+imvaYxxEIbBBxxGs69py1Ob5ShI4qJRuT+GkV2a0/m7CdXuwcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350229; c=relaxed/simple;
	bh=bLFrm8+W36cFU2HdRdXUPsjNB7gq91ms8m5UZQZPs/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwLB7ljMkvSmWBn7ObIZ204cCQ4EPhzhTD0dDHlHTdf6nG/EvARa6TMzYNk9DQluFg9Zq5Ib4Yn72Ms6XduPeEo0XpYTdfib1SuZglC/ZSOaH9CRilVZhgev6zI0W1KLONFrlv13lqsDZW42pRJDXHK9CspZwChCvWt3r7NOAP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZnuqnHAj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZnuqnHAj"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-427fc9834deso112135e9.0
        for <acpica-devel@lists.linux.dev>; Tue, 03 Sep 2024 00:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725350226; x=1725955026; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EpqgvHYsrTqtiBbD2gubTtjEbMzyUsaQNI2kDwROGw4=;
        b=ZnuqnHAjb7+lrNwPOhLhdA2JKB2kvffia+aMxY98xxoBYz7/NTeJOt3fAxXXq1E6/W
         mHP6DTn1k9nHE1Hh3+pG5rSv6DfnDGhLzCCacGgrtORCaQiztBtjUreCbr+7D9VpNs9A
         YT7YR9nQW4Y2CkU+7KPB7SgHRgcZHZdMxlNEQ+OKfE695tjyBBeIiw3sQEHseLRjKQUU
         3ICcHmrUjB7ZPqWuOw4fpGz+RnrhDo8Hj05Y6WLNpdnCJeMhL2aUGME+bBbW9GBxmdK9
         4Ot1/sx1LvrAXxDpOLg/dkSPul5keRZngBjAtBiNfN4qwi57Klmy50p5AbTMjDK5A0aU
         Sbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725350226; x=1725955026;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EpqgvHYsrTqtiBbD2gubTtjEbMzyUsaQNI2kDwROGw4=;
        b=XfYV6ndjgOU88dGusO3OkESoteZg3wDAzpnaD7dSOE5611zQkhxBxtcew+6wzTdJmu
         ZlQ+//QdnYA/9DTcY3kilKLLmQuwttc3kPQVJhedSccmMfr+u2gDUPDrDeF4wJzixsBx
         dmAGkPChGTUqOUyy4P3xDDkpGmIJI0Z4CSslYAxpWdQlZHqpjvAiUIZun8/d2tPJ2B86
         EHAoR75Gfdd2uzA7LK84xby0nMFRA6TowoGwzERFzIXPfA8NwaH2bUla2Wpn70Bo/Kf7
         YPpRKIxLmVs7zzcbBQ4SHsd4j2abIqciiXuwrg+iC2dDxQzv0Z8kAUSVVQcCh4zytMIi
         BTVg==
X-Gm-Message-State: AOJu0YyFADXb3EuEKvYCOyLJV1bLwy9+ZoVodmzw0tUBN/Iec7jlzCWL
	Eapm+ViGIduM9ZBZiYrNI37oXAfzASF+znx37WQYTNFTO0ELaGVKV3ekPmpU9Q==
X-Google-Smtp-Source: AGHT+IHgA6nmHG1PnRdTR7J4T9ZeBV+88BPig2e5l9HlhMUvcfgRj5uIoCkj4peI2Tcgr2az2ArssQ==
X-Received: by 2002:a05:600c:1d9f:b0:428:e6eb:1340 with SMTP id 5b1f17b1804b1-42c33a5fb71mr3188345e9.4.1725350225593;
        Tue, 03 Sep 2024 00:57:05 -0700 (PDT)
Received: from google.com (109.36.187.35.bc.googleusercontent.com. [35.187.36.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb5969234sm165927345e9.17.2024.09.03.00.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 00:57:05 -0700 (PDT)
Date: Tue, 3 Sep 2024 07:57:01 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linux.dev, Hanjun Guo <guohanjun@huawei.com>,
	iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Moritz Fischer <mdf@kernel.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 2/8] iommu/arm-smmu-v3: Use S2FWB when available
Message-ID: <ZtbBTX96OWdONhaQ@google.com>
References: <0-v2-621370057090+91fec-smmuv3_nesting_jgg@nvidia.com>
 <2-v2-621370057090+91fec-smmuv3_nesting_jgg@nvidia.com>
 <ZtHhdj6RAKACBCUG@google.com>
 <20240830164019.GU3773488@nvidia.com>
 <ZtWFkR0eSRM4ogJL@google.com>
 <20240903000546.GD3773488@nvidia.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240903000546.GD3773488@nvidia.com>

On Mon, Sep 02, 2024 at 09:05:46PM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 02, 2024 at 09:29:53AM +0000, Mostafa Saleh wrote:
> > On Fri, Aug 30, 2024 at 01:40:19PM -0300, Jason Gunthorpe wrote:
> > > On Fri, Aug 30, 2024 at 03:12:54PM +0000, Mostafa Saleh wrote:
> > > > > +	/*
> > > > > +	 * If for some reason the HW does not support DMA coherency then using
> > > > > +	 * S2FWB won't work. This will also disable nesting support.
> > > > > +	 */
> > > > > +	if (FIELD_GET(IDR3_FWB, reg) &&
> > > > > +	    (smmu->features & ARM_SMMU_FEAT_COHERENCY))
> > > > > +		smmu->features |= ARM_SMMU_FEAT_S2FWB;
> > > > I think that’s for the SMMU coherency which in theory is not related to the
> > > > master which FWB overrides, so this check is not correct.
> > > 
> > > Yes, I agree, in theory.
> > > 
> > > However the driver today already links them together:
> > > 
> > > 	case IOMMU_CAP_CACHE_COHERENCY:
> > > 		/* Assume that a coherent TCU implies coherent TBUs */
> > > 		return master->smmu->features & ARM_SMMU_FEAT_COHERENCY;
> > > 
> > > So this hunk was a continuation of that design.
> > > 
> > > > What I meant in the previous thread that we should set FWB only for coherent
> > > > masters as (in attach s2):
> > > > 	if (smmu->features & ARM_SMMU_FEAT_S2FWB && dev_is_dma_coherent(master->dev)
> > > > 		// set S2FWB in STE
> > > 
> > > I think as I explained in that thread, it is not really correct
> > > either. There is no reason to block using S2FWB for non-coherent
> > > masters that are not used with VFIO. The page table will still place
> > > the correct memattr according to the IOMMU_CACHE flag, S2FWB just
> > > slightly changes the encoding.
> > 
> > It’s not just the encoding that changes, as
> > - Without FWB, stage-2 combine attributes
> > - While with FWB, it overrides them.
> 
> You mean there is some incomming attribute in the transaction
> (obviously not talking PCI here) and S2FWB combines with that?

Yes, stuff as cacheability (as defined by Arm spec)
I am not sure about PCI, but according to the spec:
	“PCIe does not contain memory type attributes, and each transaction
	takes a system-defined memory type when it progresses into the system”

> 
> > So a cacheable mapping in stage-2 can lead to a non-cacheable
> > (or with different cachableitiy attributes) transaction based on the
> > input. I am not sure though if there is such case in the kernel.
> 
> If the kernel supplies IOMMU_CACHE then the kernel also skips all the
> cache flushing. So it would be a functional problem if combining was
> causing a non-cachable access through a IOMMU_CACHE S2 already. The
> DMA API would fail if that was the case.

Correct, but it’s not just about cacheable/non-cacheable, as I mentioned
it’s about other attributes also, this is a very niche case, and again I
am not sure if there are devices affected in the kernel, but I just
wanted to highlight it’s not just a different encoding for stage-2.

> 
> > > If anything should be changed then it would be the above
> > > IOMMU_CAP_CACHE_COHERENCY test, and I don't know if
> > > dev_is_dma_coherent() would be correct there, or if it should do some
> > > ACPI inspection or what.
> > 
> > I agree, I believe that this assumption is not accurate, I am not sure
> > what is the right approach here, but in concept I think we shouldn’t
> > enable FWB for non-coherent devices (using dev_is_dma_coherent() or
> > other check)
> 
> The DMA API requires that the cachability rules it sets via
> IOMMU_CACHE are followed. In this way the stricter behavior of S2FWB
> is a benefit, not a draw back.
> 
> I'm still not seeing a problm here??

Basically, I believe we shouldn’t set FWB blindly just because it’s supported,
I don’t see how it’s useful for stage-2 only domains.

And I believe making assumptions about VFIO (which actually is not correctly
enforced at the moment) is fragile, and we should only set FWB for coherent
devices in nested setup only where the VMM(or hypervisor) knows better than
the VM.

Thanks,
Mostafa

> 
> Jason
