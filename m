Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312D816EB56
	for <acpica-devel@lists.linux.dev>; Tue, 15 Oct 2024 03:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728962530; cv=none; b=jZcAh3gNM8kL18HoJRKYBksndX+j2wRkwfmLwIrClZz1M0qQofPbEPjyZVbEuhwD7G/F8mBD1HIcLg2Qk1rLjMCzvCkkygPqGLm3IC652XwQgH1b+sEuFTv7Ts5m+Dp8KoM4lBo2K70X1j4M3hsUNN+dq8WWtYmp3seO7u+A/lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728962530; c=relaxed/simple;
	bh=DjLX5fBkgJU8CT8xqfpFI/dbFLVg02xVhUhJ9U952wA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIqgJrAXjW6L2uY+B2uZK85mO+bPnHQGVS/jF9TzviTZeJqlJ/Gh/d/Ys1iS+k9x/A9pZ39FTrmQsl/M7l5NN/tjVUalwbPcbJIPEPA7FUOvZ+h0Wqj66UEdk0dna66LUMiDALp1DMJr+oAVHb0rwK4ZxSXJd8M8sP96hgtx6VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mle7hv7P; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mle7hv7P"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539eb97f26aso2279433e87.2
        for <acpica-devel@lists.linux.dev>; Mon, 14 Oct 2024 20:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728962526; x=1729567326; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jgc3X3B5k3iTM1+4K9yayTFXC9bD3mynK1laekJ4N5Y=;
        b=mle7hv7P7y/8KqeiK4W83Bkqx50hqhdJV4063qs+KjbAC301qnz1wkHUjZQ3Q7VLNz
         yCS2b6V4lOhadTov+DxR3KZugYnSqq7EDAx9I1guJ/lFG6QVmQDjGI5Nk1TW+rZUTGG0
         wWhsxSBNs7vA+MQxW9WsjSedbvEEE8ZMwyh/AlYOWd9CUOfgPTLCScQ+tFXYSOwB1H1w
         iT3qYUtW8/aa3WqAxNZb6hXSF00WljlJJjxRadhBBHy3QSEKvyYT2XOVTpOJ59ln1YHy
         MuwbqYg4BVymIvyCd/AQqdRgL2FZTmb3JwW/aPQ1d7DO05EzHJXOQULiaT+rS1Tbs8Q3
         d8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728962526; x=1729567326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jgc3X3B5k3iTM1+4K9yayTFXC9bD3mynK1laekJ4N5Y=;
        b=Gv1OXkIxnZUK/CuSx2P8l6S/428CYtP1ddxsfdMvq4ENfkoCQ+38D6cjudByNYpa4V
         NTagHOhyMm8DNsHiNpCzLB+BgH18OPE7TPOnPt8WvweWkuPetXNhBaEkLjauxWVnAjS2
         i7DifO0N8cnRHMXuG1+nScaQh7R9sfEpJdMFCykTvNfeVA8VbwQZT6KjW4CWX6zXk83W
         JXWXNCHjlURcH+WyU3NQ2pkAfSGYQvCcngj/BzEVoT8mvttxaCOvfHXsxylAc/xNFiir
         9zIZ9176iNdakZTeXUHPb3udfAaNJmi1svmv58iSY4C54hChtyikWwazz1y/zq5Hlo/t
         TqYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZVB/HF7yX2JB6NoGJDxBKceK9Y1EdV7LeZ3flKuajXiVRGSLhxJAg73oaBbj0SazAq23olcUXKSBorUU=@lists.linux.dev
X-Gm-Message-State: AOJu0YxCuZ5yvTdcY2TF9T5Ij7tgdW44KbTZKjw15e3id0yQSiiKWKeM
	B4ld8JJCCj/omDDwifbADciUNAgFgF4fYNMV14hlvYZ7nMKWJ6tmx+zxvT54a26YF68AQoZKPjn
	owL11vALyRKMhCYmroHp9Q3L71lUPnvgJDjS5cQ==
X-Google-Smtp-Source: AGHT+IF5KKFkOMyYhkCoT9zofFw4RA3mLNEAwadNBcjduiYPc6MyoAx/qz66sum4SmIdy3qH5oAV2Lmd2pGB9QF/oXw=
X-Received: by 2002:a05:6512:2581:b0:539:e1ea:c298 with SMTP id
 2adb3069b0e04-539e1eac668mr5428955e87.22.1728962526175; Mon, 14 Oct 2024
 20:22:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-621370057090+91fec-smmuv3_nesting_jgg@nvidia.com>
 <Zs5Fom+JFZimFpeS@Asurada-Nvidia> <CABQgh9HChfeD-H-ghntqBxA3xHrySShy+3xJCNzHB74FuncFNw@mail.gmail.com>
 <ee50c648-3fb5-4cb4-bc59-2283489be10e@linux.intel.com>
In-Reply-To: <ee50c648-3fb5-4cb4-bc59-2283489be10e@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Tue, 15 Oct 2024 11:21:54 +0800
Message-ID: <CABQgh9ESU51ReMa1JXRanPr4AugKM6gJDGDPz9=2TfQ3BaAUyw@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Initial support for SMMUv3 nested translation
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, acpica-devel@lists.linux.dev, 
	Hanjun Guo <guohanjun@huawei.com>, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>, 
	Alex Williamson <alex.williamson@redhat.com>, Eric Auger <eric.auger@redhat.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Moritz Fischer <mdf@kernel.org>, 
	Michael Shavit <mshavit@google.com>, patches@lists.linux.dev, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Sept 2024 at 12:29, Baolu Lu <baolu.lu@linux.intel.com> wrote:

> > Have you tested the user page fault?
> >
> > I got an issue, when a user page fault happens,
> >   group->attach_handle = iommu_attach_handle_get(pasid)
> > return NULL.
> >
> > A bit confused here, only find IOMMU_NO_PASID is used when attaching
> >
> >   __fault_domain_replace_dev
> > ret = iommu_replace_group_handle(idev->igroup->group, hwpt->domain,
> > &handle->handle);
> > curr = xa_store(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
> >
> > not find where the code attach user pasid with the attach_handle.
>
> Have you set iommu_ops::user_pasid_table for SMMUv3 driver?

Thanks Baolu

Can we send a patch to make it as default?

+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3570,6 +3570,7 @@ static struct iommu_ops arm_smmu_ops = {
        .viommu_alloc           = arm_vsmmu_alloc,
        .pgsize_bitmap          = -1UL, /* Restricted during device attach */
        .owner                  = THIS_MODULE,
+       .user_pasid_table       = 1,


Thanks
