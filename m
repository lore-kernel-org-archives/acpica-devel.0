Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317022141D9
	for <acpica-devel@lists.linux.dev>; Wed, 30 Oct 2024 16:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730305641; cv=none; b=VBkNe5kCnFjVgtNi1XS/eNnbSD00b3bRKaWk7icPD8wLrCV1Php9AtHzwJEJ2TRP005maHXPnz4EruP+UAzBSLWNuKg2HDYyId3Mq5G7YQzylX+o83agCAhm2fDaN8AomcWFyOmgx38N4lxv6kc8a+yvhQyUocc17OanLTdXC2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730305641; c=relaxed/simple;
	bh=UblSNSNMS2SOQAz7chOMf7T7raYYYerjDvTtLkicoW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FR6SinhnSFz2Oy4YxHazg7f1xo8x4TzJJGLHewWElOt/EyaQXmhRfalRQK84CEe40F3d0LxYrkg1w7GaETddJpTdU9V7g1dFXi2Rlp3Y7H1rDdWol5R5/XWrLmiRM2S5IcjSnki/d/9KiMWNVxUXIj3tAXb24q6mcQzTzKfkbhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yzu2W2FC; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yzu2W2FC"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43150ea2db6so262585e9.0
        for <acpica-devel@lists.linux.dev>; Wed, 30 Oct 2024 09:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730305635; x=1730910435; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yYoXZbQ0uAqOxJs4pfuNVgj8x5cCoQnCDnibucZBWDk=;
        b=yzu2W2FCvWmZzNR6wJHmBWm3CURBDg93sUL5bi4IBYCMsnMDS/as3b63skPv27zLJG
         svAfTHY5XPWoT13vEorHbXXh9/nhQ7bFzJUN2sDzMbr2EddVTg1uiyJ3UnK3CwLvlSrx
         tcorJ3JSYuIbPBaAC9hNW89Q80e+Lhzerxz3d+HE/kmgmspQHffnAyrOuuDd5e/GW/Qo
         MFyBAXZVNQzF61ZfORR6AwbJXVNz7XsTWLM/6mJAVQ/Uc2cucG2twFD4r4RvocDV7DBg
         YIqKg7zLaIkJoPg9GO1fTvwM9W52ZFQMaH0WzxHM6DJspWBdn8bfPjyH/4wYOO28PiDD
         qwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730305635; x=1730910435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYoXZbQ0uAqOxJs4pfuNVgj8x5cCoQnCDnibucZBWDk=;
        b=Zs6mot/aPI1yiCmEkGATIVp70I3jwUF0FWlUK5sobyw/BPhHJsYp4YRx8QS4abrXTL
         Z41UFIzELZ9K6RU/pougTKYfS23b5ifQenJbL3N9Sa1wiOc047PU/gOB0IdNhJUBzXST
         dlb5WUIiErEaXgOlzp0pU3qF3EHx5wzDgdgRf2ov50dRe0p5K7Sg0DYXBQz6Vq8Dlv12
         KGZJUGSOLbBC6J/++2dnl50L10MVNqknC4FJgiv5XZ8Z81B1K/i/gIkmI99mABkGbx2j
         tl80FO+QQ82oUO9KJuFld0epI5pAvjPO7ugmS1iNgZLRXL3ghcUnlQe4vvvExzZ66xAb
         YzEA==
X-Gm-Message-State: AOJu0YyQdU6U6cUPhJ8ecNezNNSiZV2HEVbzwoU/iPzgmQ92f65D9yoE
	cqEt2VtILOlBBY+iAznt3+WbN3flNHE8c+DiQhTq5bdAT+rgOSEtL4K7zBI+bJbhggssBKa7UaF
	P5g==
X-Gm-Gg: ASbGncsGWNcksRAao/DsojBOpeJmUe413tqsI0/Gov9JBsiixB5Adw/EzBh10QnwoKF
	A0ZbPAys10LfSMzkQkPB9s1QCqgApHs4p16W8lCwR9wZp5NT+7Z6Zg4U7NAWP34cbxuCjVSjacN
	qNuwCwtRCoXsCcS6qqqmQCI4TFOIO69wVeT8+O9zeF6hMGCT6MHHi93HY35UddMiX5nrccKZbY1
	TuiZsB2mAna28bVqLtxtD3EchPDdmJ0xThXxRZ/kVe4J25gfJR+cL0kxNaZrayNAB+gtB7Fw177
	sa1PQ4xl2A==
X-Google-Smtp-Source: AGHT+IEOBtDGTbd6gFd1Z2+Q52Kfzjw/j8SXp0CbEXKBAIwCsXgB74M2Jp4jqtd+Hp2Dw2dtDYw8jw==
X-Received: by 2002:a05:600c:1d83:b0:42c:acd7:b59b with SMTP id 5b1f17b1804b1-431b3cdeb16mr11198215e9.6.1730305635387;
        Wed, 30 Oct 2024 09:27:15 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9ca818sm25801655e9.40.2024.10.30.09.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 09:27:08 -0700 (PDT)
Date: Wed, 30 Oct 2024 16:26:59 +0000
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
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v3 7/9] iommu/arm-smmu-v3: Expose the arm_smmu_attach
 interface
Message-ID: <ZyJeU9Kkos6RibsR@google.com>
References: <0-v3-e2e16cd7467f+2a6a1-smmuv3_nesting_jgg@nvidia.com>
 <7-v3-e2e16cd7467f+2a6a1-smmuv3_nesting_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7-v3-e2e16cd7467f+2a6a1-smmuv3_nesting_jgg@nvidia.com>

On Wed, Oct 09, 2024 at 01:23:13PM -0300, Jason Gunthorpe wrote:
> The arm-smmuv3-iommufd.c file will need to call these functions too.
> Remove statics and put them in the header file. Remove the kunit
> visibility protections from arm_smmu_make_abort_ste() and
> arm_smmu_make_s2_domain_ste().
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 22 ++++-------------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 27 +++++++++++++++++----
>  2 files changed, 27 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 80847fa386fcd2..b4b03206afbf48 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1549,7 +1549,6 @@ static void arm_smmu_write_ste(struct arm_smmu_master *master, u32 sid,
>  	}
>  }
>  
> -VISIBLE_IF_KUNIT
>  void arm_smmu_make_abort_ste(struct arm_smmu_ste *target)
>  {
>  	memset(target, 0, sizeof(*target));
> @@ -1632,7 +1631,6 @@ void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
>  }
>  EXPORT_SYMBOL_IF_KUNIT(arm_smmu_make_cdtable_ste);
>  
> -VISIBLE_IF_KUNIT
>  void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
>  				 struct arm_smmu_master *master,
>  				 struct arm_smmu_domain *smmu_domain,
> @@ -2505,8 +2503,8 @@ arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
>  	}
>  }
>  
> -static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
> -					 const struct arm_smmu_ste *target)
> +void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
> +				  const struct arm_smmu_ste *target)
>  {
>  	int i, j;
>  	struct arm_smmu_device *smmu = master->smmu;
> @@ -2671,16 +2669,6 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
>  	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
>  }
>  
> -struct arm_smmu_attach_state {
> -	/* Inputs */
> -	struct iommu_domain *old_domain;
> -	struct arm_smmu_master *master;
> -	bool cd_needs_ats;
> -	ioasid_t ssid;
> -	/* Resulting state */
> -	bool ats_enabled;
> -};
> -
>  /*
>   * Start the sequence to attach a domain to a master. The sequence contains three
>   * steps:
> @@ -2701,8 +2689,8 @@ struct arm_smmu_attach_state {
>   * new_domain can be a non-paging domain. In this case ATS will not be enabled,
>   * and invalidations won't be tracked.
>   */
> -static int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
> -				   struct iommu_domain *new_domain)
> +int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
> +			    struct iommu_domain *new_domain)
>  {
>  	struct arm_smmu_master *master = state->master;
>  	struct arm_smmu_master_domain *master_domain;
> @@ -2784,7 +2772,7 @@ static int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
>   * completes synchronizing the PCI device's ATC and finishes manipulating the
>   * smmu_domain->devices list.
>   */
> -static void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
> +void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
>  {
>  	struct arm_smmu_master *master = state->master;
>  
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 66261fd5bfb2d2..c9e5290e995a64 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -830,21 +830,22 @@ struct arm_smmu_entry_writer_ops {
>  	void (*sync)(struct arm_smmu_entry_writer *writer);
>  };
>  
> +void arm_smmu_make_abort_ste(struct arm_smmu_ste *target);
> +void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
> +				 struct arm_smmu_master *master,
> +				 struct arm_smmu_domain *smmu_domain,
> +				 bool ats_enabled);
> +
>  #if IS_ENABLED(CONFIG_KUNIT)
>  void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits);
>  void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer, __le64 *cur,
>  			  const __le64 *target);
>  void arm_smmu_get_cd_used(const __le64 *ent, __le64 *used_bits);
> -void arm_smmu_make_abort_ste(struct arm_smmu_ste *target);
>  void arm_smmu_make_bypass_ste(struct arm_smmu_device *smmu,
>  			      struct arm_smmu_ste *target);
>  void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
>  			       struct arm_smmu_master *master, bool ats_enabled,
>  			       unsigned int s1dss);
> -void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
> -				 struct arm_smmu_master *master,
> -				 struct arm_smmu_domain *smmu_domain,
> -				 bool ats_enabled);
>  void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
>  			  struct arm_smmu_master *master, struct mm_struct *mm,
>  			  u16 asid);
> @@ -902,6 +903,22 @@ static inline bool arm_smmu_master_canwbs(struct arm_smmu_master *master)
>  	       IOMMU_FWSPEC_PCI_RC_CANWBS;
>  }
>  
> +struct arm_smmu_attach_state {
> +	/* Inputs */
> +	struct iommu_domain *old_domain;
> +	struct arm_smmu_master *master;
> +	bool cd_needs_ats;
> +	ioasid_t ssid;
> +	/* Resulting state */
> +	bool ats_enabled;
> +};
> +
> +int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
> +			    struct iommu_domain *new_domain);
> +void arm_smmu_attach_commit(struct arm_smmu_attach_state *state);
> +void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
> +				  const struct arm_smmu_ste *target);
> +
>  #ifdef CONFIG_ARM_SMMU_V3_SVA
>  bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
>  bool arm_smmu_master_sva_supported(struct arm_smmu_master *master);
> -- 
> 2.46.2
> 
