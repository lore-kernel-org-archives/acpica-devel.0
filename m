Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571A9186E5C
	for <acpica-devel@lists.linux.dev>; Mon,  2 Sep 2024 08:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725267480; cv=none; b=XgKXe9cN/NDl706iK4JDfD2i2AcVGAfFLbZZnWFX6axTASdi2Svge7koVkUiZRRROvz/ImEjF+Wg16xHw5peV1JNJVRx613NhDrC/fJj85C34peAkFMl8PFUR2e+8A9VfKXHX2N0qsz9e+LvGAra4KZgsZPwB7KbXX0d7j5FgTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725267480; c=relaxed/simple;
	bh=c0OW0xQ0WrcxXFjOgX053qT4DVNz5MYcUfMesZuHjIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSOKJJOla8LTzH5lUZggOJtBCU6tszMESPWgwHn4Gp1aQIBxZkSky5CUmbDypfSMKs4mW84hFiOCXjxOBCl+NHYsj8hb0qQ0N2hOcxLCl8m+YxQ6u+wFgJx9IjRxhnOteXmak6mm5ckLFPfUQzk/BGi+4dwrhhoi0zuAfembzj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4eqNLuEL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4eqNLuEL"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42bba6a003bso61885e9.0
        for <acpica-devel@lists.linux.dev>; Mon, 02 Sep 2024 01:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725267476; x=1725872276; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rDJ3c/SnX1xtZaObviOe/fqhAy0qt+DAWX/W/IrfKf8=;
        b=4eqNLuELYs/7+9NBZ1UQqLFA/vVDk3ATw8lQMFwdf4XRAahGEijDOAxo26kzs0VXFF
         0WNFIsRLzO8pq2hmYSbMZrd8HE1XmIlDausdD9u+dznlkBVcnvcuXA3hJpiAOmQIVaOk
         aX03K6V0JUxEgTljdZ+V3ih1JTI56LP0G4DcLYMl4d89lSw/RusoKsH+brFuLJxOrYpA
         XRhZe9mmUVaD4xhZd2xkZSBFqMxs+81u9UJT5IgtSep3dvzcOlJ8+AxYIlrTzoaC5Es8
         2zREKSzc3Q59zHLF8K1aBjQqq+9Cot5+BYiPhF8kuj+mcnMKuBtWzA1Q5QxHw4M81Qre
         qCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725267476; x=1725872276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDJ3c/SnX1xtZaObviOe/fqhAy0qt+DAWX/W/IrfKf8=;
        b=J7/aHlvsmGIz3W1Bed1LxwnKg2fFtvl3+aiWqKoJYSU28+EFT3h+HhbZ0Y0K2rgwfv
         uJ4pnrbKLPiItP2j48X4SQRFMtZbu/5AknuZcSPQf54hdB4e5Kp45ouAQtI3sbhS0Xv4
         q0bYXvruwOLW1adYjsrHZBCSCgNN/2bDZpU6zqXl+eVsdmKAwWb3DEDbwFmdynBiowxC
         Kjvki2YMRu6VnbB7XHF9RtrlI5Cu7v2BvarZTOI2CyPxuVHT33A3yLTFHysvK6HMZ12k
         YbgjmUohj45sCYE0KnJfx4Gi4TLKjSVV6D0oLjyXmwmaQLht9Lb2xSn71SgYDWSlP0XS
         HHlQ==
X-Gm-Message-State: AOJu0YyskNlmzIK/9fILaYATm0L/siX31eJ1kQufzHwkd0tJ4QGfOaLs
	3hkygavErq6p10H8x+IixOPMD7QDE47bDo/7KWruHNn8FFOhBi2X+jeILW/fbw==
X-Google-Smtp-Source: AGHT+IEaLVJ/wTV51wop3m+lk/qJDgyUDoC18kpCfu1q8TvT9dKkREX0von9jbn66ji3B2gnWNgrVA==
X-Received: by 2002:a05:600c:3ac8:b0:428:31c:5a4f with SMTP id 5b1f17b1804b1-42c787685fbmr1905585e9.3.1725267475261;
        Mon, 02 Sep 2024 01:57:55 -0700 (PDT)
Received: from google.com (109.36.187.35.bc.googleusercontent.com. [35.187.36.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c2ffe062sm4918816f8f.29.2024.09.02.01.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 01:57:54 -0700 (PDT)
Date: Mon, 2 Sep 2024 08:57:50 +0000
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
Subject: Re: [PATCH v2 7/8] iommu/arm-smmu-v3: Implement
 IOMMU_HWPT_ALLOC_NEST_PARENT
Message-ID: <ZtV-DvqIDx5ZFAph@google.com>
References: <0-v2-621370057090+91fec-smmuv3_nesting_jgg@nvidia.com>
 <7-v2-621370057090+91fec-smmuv3_nesting_jgg@nvidia.com>
 <ZtHkxFrojjXplvvn@google.com>
 <20240830171817.GY3773488@nvidia.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830171817.GY3773488@nvidia.com>

On Fri, Aug 30, 2024 at 02:18:17PM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 30, 2024 at 03:27:00PM +0000, Mostafa Saleh wrote:
> > Hi Jason,
> > 
> > On Tue, Aug 27, 2024 at 12:51:37PM -0300, Jason Gunthorpe wrote:
> > > For SMMUv3 the parent must be a S2 domain, which can be composed
> > > into a IOMMU_DOMAIN_NESTED.
> > > 
> > > In future the S2 parent will also need a VMID linked to the VIOMMU and
> > > even to KVM.
> > > 
> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > > ---
> > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > index ec2fcdd4523a26..8db3db6328f8b7 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > @@ -3103,7 +3103,8 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
> > >  			   const struct iommu_user_data *user_data)
> > >  {
> > >  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> > > -	const u32 PAGING_FLAGS = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
> > > +	const u32 PAGING_FLAGS = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
> > > +				 IOMMU_HWPT_ALLOC_NEST_PARENT;
> > >  	struct arm_smmu_domain *smmu_domain;
> > >  	int ret;
> > >  
> > > @@ -3116,6 +3117,14 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
> > >  	if (!smmu_domain)
> > >  		return ERR_PTR(-ENOMEM);
> > >  
> > > +	if (flags & IOMMU_HWPT_ALLOC_NEST_PARENT) {
> > > +		if (!(master->smmu->features & ARM_SMMU_FEAT_NESTING)) {
> > > +			ret = -EOPNOTSUPP;
> > I think that should be:
> > 	ret = ERR_PTR(-EOPNOTSUPP);
> 
> Read again :)

Oops, sorry about the noise.

Thanks,
Mostafa
> 
> static struct iommu_domain *
> arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
> 			   struct iommu_domain *parent,
> 			   const struct iommu_user_data *user_data)
> {
> 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> 	const u32 PAGING_FLAGS = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
> 				 IOMMU_HWPT_ALLOC_NEST_PARENT;
> 	struct arm_smmu_domain *smmu_domain;
> 	int ret;
>      ^^^^^^^^^^^^^^
> 
> err_free:
> 	kfree(smmu_domain);
> 	return ERR_PTR(ret);
>            ^^^^^^^^^^^^^^^^^^
> 
> Jason
