Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FA12A1D3
	for <acpica-devel@lists.linux.dev>; Thu, 12 Sep 2024 07:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726126376; cv=none; b=sryQuP1w5GTOUCA6NE2nhcfaOonhIUMOfFBXl4dNPlneYhLQOdgSYg1SZmFPOfvX8pIYBEoxy3lCDkzTFnoZ6i1jNeK79X6Rfsrby4rMj27VkS3K4VjT1a5Zmjeqa0IDenEqaiJWVOKh22KzN8mAvoIIHR/inEPWP6OigIUBYa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726126376; c=relaxed/simple;
	bh=FzBKh+AU40CN9oHzR3BSVFgBams1zQxhZ8kcZSCD9k0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILVUseFPbnDoYftcNqNw91ktTSs9X1zAsdDwD6qzkqCOA2Se1i9guDTzR2wuBMqAL75p86gp6TISg9Y2WuU2YKtMoj5EyJpBquCAblSQ2cD+8Bv5QkqUKBMfLy7rQhXvcBweESz+s6Xgxc3FmJtnquZ+p6U1dlmrn6MNVy6jrvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=icc7yQDL; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="icc7yQDL"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5356ab89665so701405e87.1
        for <acpica-devel@lists.linux.dev>; Thu, 12 Sep 2024 00:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726126373; x=1726731173; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mORgeThFItSKRVvwL2eU52STgrT61e2xyY47HCtu0j0=;
        b=icc7yQDLEC2KxcaOTNz+se27hbS/GyLjMcad6M3+zf5+/iqwxPqNtPLgGn24IiQbxE
         qeWwWPYh9yn4IRxw1oFKiDKvIctmHA0mHNvK4lGaJ2AwAxrNhwBS3hzEOHGJY9ja8NgX
         YkT+f3COP3pvIm/PcTE5qXLgeMHPz8Cs7XpXYOf17BH26SfXY307sM8x1T+yJEF8Iilk
         m5EgXExAI8e6JigwnlplRRtFkO0ZxmB+VHItN+NKnw9ob0KuZoC31OsoVUSaBYFr16Wb
         qe5ydeBB3eUg20ELQ7cP7rhFlUl+fvc/iWOtrv1yevbl94FEq32rraLOi94Kg76/Q1sq
         4e2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726126373; x=1726731173;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mORgeThFItSKRVvwL2eU52STgrT61e2xyY47HCtu0j0=;
        b=D+mZJnXmMrIoEfTUk9iJIKphJw4wk47YusSo6ypjZLAANUKOryFtBoiGYR8BtxQtV3
         AnS9efX62/GBy1YRE8vt6o7gVorV5ha1miNTfA73sKCP03IVUiY3rGQxw7eaDwWZWhU3
         MU38YDPAxNUOx8ELOk3mJzs0dDHnWrsn7y/Dm/9KHGS6wbFhVBns9Ij46xMsAVfZfD49
         FXpNtZFmP9606PqJTSfBSNC5kFxfEupZjYkuJtzrpXcOH+hpFgdJrAvk8ysqt7Gd/IPy
         EI1cSFGn8Dh/REhaIKaRfLFtU5fkWShpa5J3tTcsyT5QYVNB+WWClYsUDdV/KQs14D/V
         ajew==
X-Forwarded-Encrypted: i=1; AJvYcCWh1KZOBu1/c4c3IAMpA5ApwOsqni5LjZnfkTfDg45019sZdDs3JabOSS928aRXUpifabK20iJJTEyFNzk=@lists.linux.dev
X-Gm-Message-State: AOJu0YyOqaP1PCbLpabgt8gkKlr9IoCBgZl886ZZhaDdi3tjdAMFLkyM
	gpCYh2mXf0hJLbBxWxt3qWnqOHFHx/FLNzQwVzEzERz1uDdYp257HpTAorFHYlrlSQWB14xdeUH
	jX0KqDVbUz30VPOB/yFac2Fawq8VgAxYYGvhkQw==
X-Google-Smtp-Source: AGHT+IE2qH+DDo5DbegofrZD/Jk3qp04GIJFuzg8g/g2YGLkO7heSfzNnSID+VNatE+0Yyh1SXo2NwGwNJsgxGu/4kI=
X-Received: by 2002:a05:6512:ac9:b0:535:d4e9:28bb with SMTP id
 2adb3069b0e04-53678feb448mr861902e87.46.1726126371795; Thu, 12 Sep 2024
 00:32:51 -0700 (PDT)
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
Date: Thu, 12 Sep 2024 15:32:40 +0800
Message-ID: <CABQgh9H2+uTgsQxgLSuua7h0kxSwfYZE1=GM1TA4H30jNsM9OQ@mail.gmail.com>
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
>
> On 9/12/24 11:42 AM, Zhangfei Gao wrote:
> > On Wed, 28 Aug 2024 at 05:32, Nicolin Chen<nicolinc@nvidia.com>  wrote:
> >> On Tue, Aug 27, 2024 at 12:51:30PM -0300, Jason Gunthorpe wrote:
> >>> This brings support for the IOMMFD ioctls:
> >>>
> >>>   - IOMMU_GET_HW_INFO
> >>>   - IOMMU_HWPT_ALLOC_NEST_PARENT
> >>>   - IOMMU_DOMAIN_NESTED
> >>>   - ops->enforce_cache_coherency()
> >>>
> >>> This is quite straightforward as the nested STE can just be built in the
> >>> special NESTED domain op and fed through the generic update machinery.
> >>>
> >>> The design allows the user provided STE fragment to control several
> >>> aspects of the translation, including putting the STE into a "virtual
> >>> bypass" or a aborting state. This duplicates functionality available by
> >>> other means, but it allows trivially preserving the VMID in the STE as we
> >>> eventually move towards the VIOMMU owning the VMID.
> >>>
> >>> Nesting support requires the system to either support S2FWB or the
> >>> stronger CANWBS ACPI flag. This is to ensure the VM cannot bypass the
> >>> cache and view incoherent data, currently VFIO lacks any cache flushing
> >>> that would make this safe.
> >>>
> >>> Yan has a series to add some of the needed infrastructure for VFIO cache
> >>> flushing here:
> >>>
> >>>   https://lore.kernel.org/linux-iommu/20240507061802.20184-1-yan.y.zhao@intel.com/
> >>>
> >>> Which may someday allow relaxing this further.
> >>>
> >>> Remove VFIO_TYPE1_NESTING_IOMMU since it was never used and superseded by
> >>> this.
> >>>
> >>> This is the first series in what will be several to complete nesting
> >>> support. At least:
> >>>   - IOMMU_RESV_SW_MSI related fixups
> >>>      https://lore.kernel.org/linux-iommu/cover.1722644866.git.nicolinc@nvidia.com/
> >>>   - VIOMMU object support to allow ATS and CD invalidations
> >>>      https://lore.kernel.org/linux-iommu/cover.1723061377.git.nicolinc@nvidia.com/
> >>>   - vCMDQ hypervisor support for direct invalidation queue assignment
> >>>      https://lore.kernel.org/linux-iommu/cover.1712978212.git.nicolinc@nvidia.com/
> >>>   - KVM pinned VMID using VIOMMU for vBTM
> >>>      https://lore.kernel.org/linux-iommu/20240208151837.35068-1-shameerali.kolothum.thodi@huawei.com/
> >>>   - Cross instance S2 sharing
> >>>   - Virtual Machine Structure using VIOMMU (for vMPAM?)
> >>>   - Fault forwarding support through IOMMUFD's fault fd for vSVA
> >>>
> >>> The VIOMMU series is essential to allow the invalidations to be processed
> >>> for the CD as well.
> >>>
> >>> It is enough to allow qemu work to progress.
> >>>
> >>> This is on github:https://github.com/jgunthorpe/linux/commits/smmuv3_nesting
> >>>
> >>> v2:
> >> As mentioned above, the VIOMMU series would be required to test
> >> the entire nesting feature, which now has a v2 rebasing on this
> >> series. I tested it with a paring QEMU branch. Please refer to:
> >> https://lore.kernel.org/linux-iommu/cover.1724776335.git.nicolinc@nvidia.com/
> >> Also, there is another new VIRQ series on top of the VIOMMU one
> >> and this nesting series. And I tested it too. Please refer to:
> >> https://lore.kernel.org/linux-iommu/cover.1724777091.git.nicolinc@nvidia.com/
> >>
> >> With that,
> >>
> >> Tested-by: Nicolin Chen<nicolinc@nvidia.com>
> >>
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

Thanks Baolu, Nico

Yes, after arm_smmu_ops = {
+       .user_pasid_table       = 1,

find_fault_handler can go inside attach_handle =
iommu_attach_handle_get(IOMMU_NO_PASID);
qemu handler also gets called.

But hardware reports errors and needs reset, still in check.
[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 0

Thanks
