Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F9429CE6
	for <acpica-devel@lists.linux.dev>; Wed, 13 Nov 2024 01:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731459717; cv=none; b=NhW2cGYBNR7s0Jbl3ISTHUTWuOU6dP06znuPCw4AVIJXtZfO1HyLD483q+QeRpkc5cFl3oQrZIR52jjzP3NgHyxq6r0MzhNkCw/igp7R7aysp1HbqYiDcyPH+LBjk6Kauj2ZaoZ71eeWOFWUMEuRBpZM19xcZDV4duS3UBIXuI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731459717; c=relaxed/simple;
	bh=5v0Pumd1wdfkWfYkDyIym/XT5Jsmn2z22aIpke3ZD48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rNGZNX0NZKTN7OIiZXdERAUZpX+mf1MUcfyIEli3xHoIWexlagtNCzg15KZt128jirk7h/dLo9vyGz8uZj6P1iFWCIZiiyc0de3gqs3t4SpvRzyYLOCnM+4bxxGMvbOpKRANcLPN7/mgwTji7r41dX8G/NoY7byD/jwaOaP5AXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WUAlv8Oe; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WUAlv8Oe"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e63c8678so7364118e87.0
        for <acpica-devel@lists.linux.dev>; Tue, 12 Nov 2024 17:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731459713; x=1732064513; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X/yyOuGNVIzT+zYvh4v3hplD3RNbNSCQhrz/FBYBpRw=;
        b=WUAlv8Oee8KJ+cX44lXGDjCwRCu/OVC5DjG6etP3FC+thz79YMprikjJJsgCueear9
         QzpE1xqnsPhx7a6rb805QcHH3j1N6cXAGzDlTKv5+tf2RdjslT/NBKW6ai91o1map5wb
         TRql401a1WZzcFtwoCqnzYINF8od3X33HitbgtWSZd22+VEsvx+QxrQP2qiRfEdSR9cH
         i5T40LP9Xj1jUTfEuPIdyXgWODyVOtAdQAWmPvyPciq9lPgSKcnDWQIL8iEaCQtJraE9
         ik/5FY5o8JEgGMAEGX5QpxqTXortJKvCiN7U5Q8PK1SjNIUDmv/fN+mkfDe0csE8iQoq
         E6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731459713; x=1732064513;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/yyOuGNVIzT+zYvh4v3hplD3RNbNSCQhrz/FBYBpRw=;
        b=g7R7lPKxAEWi5hEEL9jGRrl+egsvL4VMPtMf3CEvIsoQERtN8UBksVj6PugwaBvNtZ
         +RB7nRgVJLet6gIdIaBVTXESOiDbtjTnIlUJmt1QGAOcZkCCGz9Ound1u/R+0d5LNkU/
         CBoFn21w/bYCGtWx8A6Y3Ecq9O+ofSU0mC+1IHtLnmT6rTfO1MQgaLKW4AddNmx84c8o
         +7gy8/cWcLX6xPfqhrtBH3JWFsOEOScoI90ngvR8ObA7g+ccrT2bMpZz2THLWQG7JJf3
         sFnHjEPoRaGOwkKXGR+IMrGLGROL+2oJ3BkpFwMksCYsympOqm1mYn9d1Md7v4I2DJ/w
         IOBg==
X-Gm-Message-State: AOJu0YzCJ6mH7RsflOvQfZakHSrHA6/aNm/+1CmIZrv80GGwx+uOLrDN
	C01pxlqqZAwkhj+ev0PHKkMC4GOeAIFUoaUng8Zi3B79M/0a278noTEFOjO+TreNCHh8oEe01+N
	DoIacwj8kGdXT+MIJD1R0bnHh3DUxtoCzl7XXMQ==
X-Google-Smtp-Source: AGHT+IGrTpBP4XZN2inszS5LiWIDhaTOAjWYv1IN45jLudjPrpRKEn2OnUUglHnQBM+zZuWyWdAuDjaQVoneTf1/DNk=
X-Received: by 2002:a05:6512:ba0:b0:539:e436:f1cd with SMTP id
 2adb3069b0e04-53d862d38c5mr9315032e87.16.1731459712927; Tue, 12 Nov 2024
 17:01:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v4-9e99b76f3518+3a8-smmuv3_nesting_jgg@nvidia.com> <20241112182938.GA172989@nvidia.com>
In-Reply-To: <20241112182938.GA172989@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 13 Nov 2024 09:01:41 +0800
Message-ID: <CABQgh9HOHzeRF7JfrXrRAcGB53o29HkW9rnVTf4JefeVWDvzyQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] Initial support for SMMUv3 nested translation
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

On Wed, 13 Nov 2024 at 02:29, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Wed, Oct 30, 2024 at 09:20:44PM -0300, Jason Gunthorpe wrote:
> > Jason Gunthorpe (7):
> >   iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED
> >   iommu/arm-smmu-v3: Use S2FWB for NESTED domains
> >   iommu/arm-smmu-v3: Allow ATS for IOMMU_DOMAIN_NESTED
> >
> > Nicolin Chen (5):
> >   iommu/arm-smmu-v3: Support IOMMU_VIOMMU_ALLOC
> >   iommu/arm-smmu-v3: Support IOMMU_HWPT_INVALIDATE using a VIOMMU object
>
> Applied to iommufd for-next along with all the dependencies and the
> additional hunk Zhangfei pointed out.

Thanks Jason, I have verified on aarch64 based on your
jason/smmuv3_nesting branch

https://github.com/Linaro/linux-kernel-uadk/tree/6.12-wip
https://github.com/Linaro/qemu/tree/6.12-wip

Still need this hack
https://github.com/Linaro/linux-kernel-uadk/commit/eaa194d954112cad4da7852e29343e546baf8683

One is adding iommu_dev_enable/disable_feature IOMMU_DEV_FEAT_SVA,
which you have patchset before.
The other is to temporarily ignore S2FWB or CANWBS.

Thanks
