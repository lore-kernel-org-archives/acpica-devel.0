Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C1F156665
	for <acpica-devel@lists.linux.dev>; Wed, 16 Oct 2024 02:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729045444; cv=none; b=MnZh6V6QmUpNz2yz5L20dpXeEqD6So/IFSWLAiiRJGeFtaR87q1sotYQOlKgUjSv7anjZquK2S5DfFqt27zE68GfWqn8occZVYAY++fmCGCSXVpJgC64+pW4YVaFBsGq36bLQLI4RVN9pRSx5V5djCDk42GFKVn6roM24gvjLMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729045444; c=relaxed/simple;
	bh=+GF1oCaa4XIdm2rCPBWvV+uTROdOd1KyxDhkbhawAvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OeCO0FH3KwngCS4fK8StQ9qizt400EoxiQng93gfu7mlBvxaM+N7R5BL3/ZQrB61o9992Z/11Tz564/iw3L2s8RMgX+I3CfGBFaK/p5Ur5V/I/rcl9v6m4Lo/prsY64WITJMi63NtryK81q7N+CfG75ciAtJGroVHeQEKaTYC/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nofvZaOf; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nofvZaOf"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539d9fffea1so4879756e87.2
        for <acpica-devel@lists.linux.dev>; Tue, 15 Oct 2024 19:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729045441; x=1729650241; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qiWvrpKzeq83YnQqOE7ISPaRFxYtddrp60dv+zolb9U=;
        b=nofvZaOfyWsBjfzInq6Nt5348snRx1WfxC8/qUyceii+muEi+UPrZLzPtbO35vJmzY
         WoOnUDYgUY7NS935HNxhPMqa738rDPNZJl9/t//bhdwBox68qoOzfS/Fb8ImybKAtmwc
         811UEjfXwKpbEJxjuTTO8k3i7bAgDdimRnn7yfZpZR22aEqHFGQ8zRn9wSyff4DH8smz
         6rI8kXlZL4ExKYnY1uvWSvhwdzMJnBP+E7ZBq20Z2hLPgjE0VDZ8M1lyFwtzYWnUatrt
         LE1Dmd6TCcljMgkSHq9Mk1us+qHMezNwxA2vfDMRJmbTJmCXu6oCpP10d4iWxNYPXkYp
         bCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729045441; x=1729650241;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qiWvrpKzeq83YnQqOE7ISPaRFxYtddrp60dv+zolb9U=;
        b=sRY/2SYCSxRPmmddAI3mze8cmCA0vByw/a3NYsGFrjbYlLSrkH+t/g/NnxSwJk6xfr
         volYT88McGutxsMs4S/aipILeet01TWv2Mmz6OL9+a/n+G/APQYLoAL2yh0jHfj2S6sn
         1wtxIB2miBYBS3bolkYfWsPmvvtQs6KKt6px2HXJe/Cm3Z4FAd+/uOrzxa0YYRvhGmqq
         iFPt5kcXrrnQm4TsnJL8kkN53fgKxtSFMA4X/vMXD3LMAkNdddwsNpocX5kd+2X2Gowm
         KDEH8rfDJ5KoISONVaR/1u5gT5EpfgFMxRHK0ZrSn2k9T/688LfjBPhzUDmX3cNf1L72
         t4Mg==
X-Gm-Message-State: AOJu0YwNOn0Vf9KEV4LHogXIv2IAaMk3Kq2+jbVAFAwLoluA3Ato3kHX
	yJZz3YwNbVf0YA+nK1VfRUMxegs1g16muxI152dzeDLMsW5kELHMr5Hz1ZkmQ5FrOSajvDPF8XG
	J15rgEnMxwYkN4mfQCz0zIxpGz33+hrwKw2gF1g==
X-Google-Smtp-Source: AGHT+IEV/byr5lu2UsUC2RRVM2gDVA1eLiMxNLS7gT854PVdY6PhxgM/HLAZnNXx36HxSizxkKPg933nd9PyJjzpqHw=
X-Received: by 2002:a05:6512:3094:b0:539:da76:c77e with SMTP id
 2adb3069b0e04-53a03f045ecmr1718387e87.5.1729045440632; Tue, 15 Oct 2024
 19:24:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v2-621370057090+91fec-smmuv3_nesting_jgg@nvidia.com>
In-Reply-To: <0-v2-621370057090+91fec-smmuv3_nesting_jgg@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 16 Oct 2024 10:23:49 +0800
Message-ID: <CABQgh9E32c5inrn=Q5HWThuJQ4xV=EFWLGwbyxVLHQVUZ_uYCA@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Initial support for SMMUv3 nested translation
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linux.dev, Hanjun Guo <guohanjun@huawei.com>, 
	iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>, 
	kvm@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>, 
	Alex Williamson <alex.williamson@redhat.com>, Eric Auger <eric.auger@redhat.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Moritz Fischer <mdf@kernel.org>, 
	Michael Shavit <mshavit@google.com>, Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi, Jason

On Tue, 27 Aug 2024 at 23:51, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> This brings support for the IOMMFD ioctls:
>
>  - IOMMU_GET_HW_INFO
>  - IOMMU_HWPT_ALLOC_NEST_PARENT
>  - IOMMU_DOMAIN_NESTED
>  - ops->enforce_cache_coherency()
>
> This is quite straightforward as the nested STE can just be built in the
> special NESTED domain op and fed through the generic update machinery.
>
> The design allows the user provided STE fragment to control several
> aspects of the translation, including putting the STE into a "virtual
> bypass" or a aborting state. This duplicates functionality available by
> other means, but it allows trivially preserving the VMID in the STE as we
> eventually move towards the VIOMMU owning the VMID.
>
> Nesting support requires the system to either support S2FWB or the
> stronger CANWBS ACPI flag. This is to ensure the VM cannot bypass the
> cache and view incoherent data, currently VFIO lacks any cache flushing
> that would make this safe.

What if the system does not support S2FWB or CANWBS, any workaround to
passthrough?
Currently I am testing nesting by ignoring this check.

Thanks
