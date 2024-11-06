Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652A918FDDE
	for <acpica-devel@lists.linux.dev>; Wed,  6 Nov 2024 05:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730871570; cv=none; b=oWXK7/pYFgDs05iILIFT6UaYHNXuX30EasSv4gsi83RJi88l488ATCfhBwUO7oucyeyMrsBdjsmUnCc5kt7p0nkz8iKFFniQ7i6PXrYIATFRp6h6jFULChpXeurZoKE+p1gDNvO5Gj+roXlyMdtoBK7pvJyklzg8/jQiT5fCRZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730871570; c=relaxed/simple;
	bh=3qBDiqpY9XDqbY2Y9odYYAPqOm9MdhCQLElgiaodrH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y2vIu+HtZYJq/rJuEmTsVgw1orJteAu6RXpVKAs44BcNBpxodlBXFEnkJ2u9Mak4SZ90NLcR/dlAwR2+tJPPNldlzAF3DtWL+9wnZdss/A6pnWIMEFHlI1T9CEgONtyYIe2hmYAgESbx9VNeSqfZF+IhaHLvOhs3ptnWNdZ1bmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eWOAUpvw; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eWOAUpvw"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53c78ebe580so493323e87.1
        for <acpica-devel@lists.linux.dev>; Tue, 05 Nov 2024 21:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730871565; x=1731476365; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AN4uQlg4JmmnskoZUbD9ajWs6/v+l9dkVw03I1zm8cw=;
        b=eWOAUpvwcpojXTxRa/r/aSdVLbridQ8KRMfdpu+u9AZdSYfX/hze+IIUH/zM55HJoY
         Wipz2BQA5f94yw4pkYll2mTWXuLxEprfdO9mEn7yvzaTxSvKO2Y99neucUOZ6JpD3dSI
         v8NCwHP6H/WNKLRjZm9hZU8prT694mjXonFTiNHTONWMLW7mpMijUle9mVRILe5SbrlQ
         LRaBBHN2k1Tt8LfxFN8f4vODioHeF1Azd5YyFqEWah69R5+WhyPVKmo1wp3X6bbruNTA
         QvWwkI0FqhexA41Q7FgoK9rmMUdmrZAKaoS7XuS7NtCZHw7BpZKW3iZz9j6gv1LPz9W5
         mpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730871565; x=1731476365;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AN4uQlg4JmmnskoZUbD9ajWs6/v+l9dkVw03I1zm8cw=;
        b=sUmbHLeP0r8mYdipC8O05ZVSrQ/GfB7uVPk0jaeeAHbUSWTlC3FTDNPXJimC0I2iJ4
         FopRmP1qj8jkEdrKjUYvikexmzTACYruPmRrGx5Ark9lsXHjpGsxMlNl73rGSXcuiu3W
         4mRqJhn0PzzbC+j/gS0DESUdF78NQvUjqH6ib+/XpEwiPId6fqLpIAfj0HQcYkjTzWl8
         0ZfI/OrpnzhqgdRanwKlXOghNsuXlhJP5+YpZBfhXpICdZ6Sr7yYLGJTVY70FdQXYYpN
         rXJ9EM6G8eYn2ra49LVituyZjelY7LO3o+rPEcDozs6KmSzEllK6QjvCXPJ6rroB5Wu0
         8aZA==
X-Gm-Message-State: AOJu0YxW4CYJ2z3nH8T2nAPqjD1dtJroLrnVRHAHHLVmvFYwzQeDxInT
	x92J5s6qiRR8QBIeRHQsTlNyi9wJnbTgLXjgxg+ZlnImPwP19/rgXDVjp4ebgJuzScXjEjIa86I
	6CXp6Qr9cnVxH0P6Vy2v2G1+pjdWf0JARvhJayw==
X-Google-Smtp-Source: AGHT+IHkFZmS15Yat+yA6wTIjddaBPNP6Qu4/1YXgkU7r7C/EE/mZc+JCaJP3gRrzyZ+p7mBuvSg1qn/MJDQimjHDOk=
X-Received: by 2002:a05:6512:4803:b0:53b:1ede:9174 with SMTP id
 2adb3069b0e04-53d7cff7502mr316569e87.28.1730871564937; Tue, 05 Nov 2024
 21:39:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v4-9e99b76f3518+3a8-smmuv3_nesting_jgg@nvidia.com>
 <9-v4-9e99b76f3518+3a8-smmuv3_nesting_jgg@nvidia.com> <CABQgh9HoGFGDTEqziQt6WrJ7Bm9d-0c259PYsms3nOVEidn5BA@mail.gmail.com>
 <20241104171931.GB10193@nvidia.com>
In-Reply-To: <20241104171931.GB10193@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 6 Nov 2024 05:39:13 +0000
Message-ID: <CABQgh9HSAhat3_P43F_z07oqDaJ9h_YrZ-+SdHZ=ijzrZD1CVw@mail.gmail.com>
Subject: Re: [PATCH v4 09/12] iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linux.dev, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>, 
	Alex Williamson <alex.williamson@redhat.com>, Donald Dutile <ddutile@redhat.com>, 
	Eric Auger <eric.auger@redhat.com>, Hanjun Guo <guohanjun@huawei.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, 
	Moritz Fischer <mdf@kernel.org>, Michael Shavit <mshavit@google.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	patches@lists.linux.dev, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Nov 2024 at 17:19, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Thu, Oct 31, 2024 at 02:21:11PM +0800, Zhangfei Gao wrote:
>
> > > +static struct iommu_domain *
> > > +arm_vsmmu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
> > > +                             const struct iommu_user_data *user_data)
> > > +{
> > > +       struct arm_vsmmu *vsmmu = container_of(viommu, struct arm_vsmmu, core);
> > > +       struct arm_smmu_nested_domain *nested_domain;
> > > +       struct iommu_hwpt_arm_smmuv3 arg;
> > > +       int ret;
> > > +
> > > +       if (flags)
> > > +               return ERR_PTR(-EOPNOTSUPP);
> >
> > This check fails when using user page fault, with flags =
> > IOMMU_HWPT_FAULT_ID_VALID (4)
> > Strange, the check is not exist in last version?
> >
> > iommufd_viommu_alloc_hwpt_nested ->
> > viommu->ops->alloc_domain_nested(viommu, flags, user_data) ->
> > arm_vsmmu_alloc_domain_nested
>
> It should permit IOMMU_HWPT_FAULT_ID_VALID, I'll add this hunk:
>
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -178,12 +178,18 @@ arm_vsmmu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
>                               const struct iommu_user_data *user_data)
>  {
>         struct arm_vsmmu *vsmmu = container_of(viommu, struct arm_vsmmu, core);
> +       const u32 SUPPORTED_FLAGS = IOMMU_HWPT_FAULT_ID_VALID;
>         struct arm_smmu_nested_domain *nested_domain;
>         struct iommu_hwpt_arm_smmuv3 arg;
>         bool enable_ats = false;
>         int ret;
>
> -       if (flags)
> +       /*
> +        * Faults delivered to the nested domain are faults that originated by
> +        * the S1 in the domain. The core code will match all PASIDs when
> +        * delivering the fault due to user_pasid_table
> +        */
> +       if (flags & ~SUPPORTED_FLAGS)
>                 return ERR_PTR(-EOPNOTSUPP);

Thanks Jason, this works
