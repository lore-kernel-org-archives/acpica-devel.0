Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F96318BBBB
	for <acpica-devel@lists.linux.dev>; Sat, 26 Oct 2024 20:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729974368; cv=none; b=idyGbX48OnHjveeYTwg0saWJdThwI0HoCl1NcKsu1y40AhAqMAlKlIbNgpykn9mVtTTN2Ojf67t12zqx2iJzUqXqSmQFUbN0CZn46SkNDEvpXrRWEnmMJIDJNzjUf44lCOZB+IZFxx2P31GR4fJE+Cuk8OyJ3S47vK3l7eSXt10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729974368; c=relaxed/simple;
	bh=tUAUvQ737sodN9yK5aQGONrT7W7Or4tB2oyzGkwlZQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FEj7acaB6cBoW80GWyfGBOibr5KmI2Vl6C/RTCL4gWMVrtrAacOkvIYhpNSnI19hKwtRF1YFdFK3cpb+8+ZHzp2QvCyXi93KZ8kEm9PFVXX5GiGNy3cqQ17Q8B7Q3Pf6J7ALcCJWbQYJOhWCbnNmxF0RKov3NRCYKwW57f+WN/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W0EwPZa0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W0EwPZa0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729974365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ILgF2ANT9OZDmDrUe3BvutpFI6Z0i+T3Y7sxTWoDZw=;
	b=W0EwPZa0PllVW4W0lMoRw4uGuPynigAo4CW8mf1jEafXGaj4L559N2UPyzCSCaWtmfC4Db
	d/WtXIWckZIqh22w3RMJu5cBwi3hLwEGpqd+lCTjodDoPjbwc3oCTZlyLBchTcmYYRBPzT
	7oIdCKlWgunPNALnHJAiV5x84/AM5V8=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-fqKuxJnsMVuB4icAGq7u0A-1; Sat, 26 Oct 2024 16:26:03 -0400
X-MC-Unique: fqKuxJnsMVuB4icAGq7u0A-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-71e49bad8adso3290363b3a.1
        for <acpica-devel@lists.linux.dev>; Sat, 26 Oct 2024 13:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729974363; x=1730579163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ILgF2ANT9OZDmDrUe3BvutpFI6Z0i+T3Y7sxTWoDZw=;
        b=hbXj10A47UH4tQMAUUkYJBu4fIdSMQUg0oPDh9PThnzU41lx+Y6cLtZIHG/kSg92VG
         ooN01pxOheZGkjkRKyW4w7+oPAMZYD6JiHT5YjEzR+4g8YGPmyvv2FVt+DLFk4SNAH5S
         bX4R5mHS/P4ODDHW8kzc9d210Ako1UpcbgPmQNcHcyJ2arvd0XmLVYm9T8xFyVvqpUo+
         S9w1/tlIYaO44MMlCVP+V+G6CZemPSAxMY2GjkXXF2caFKrm0Jk9FpVvKeapcF9hiKWT
         L/y4llju9+Q/VV/emPACjfNXTqW0nyCc+gLKcacW/wg1oPbuIDZ/B/WFHm3bED9YdWYx
         VhWw==
X-Gm-Message-State: AOJu0Yz6of+DAevR6WJ8ZZ8+5Sg5Sy/T4Vj/IuoXmTYDZjmHfbDkO4pz
	j/Tuk9ZeY4p5e+VuwR7DAhJfehTygbS1p6qBpIbyk/hbX9UB6vxhTDu9LKvZr+EEWXioTJJO+0Z
	BX2zLjO3iK4R7V+Evm7YMJurw16fytVF6KlXoOymci2APWYhZjKxNRdCx+789Zw==
X-Received: by 2002:a05:6a21:394b:b0:1d9:3acf:8bdd with SMTP id adf61e73a8af0-1d9a767bdfamr5925538637.22.1729974362656;
        Sat, 26 Oct 2024 13:26:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwP/m05oeFk9b8sbVzI0tK+++7zBHiaxMX3MviGhXhL+kZBBndL9iS5Tpoq327xlI5FsMfmw==
X-Received: by 2002:a05:6a21:394b:b0:1d9:3acf:8bdd with SMTP id adf61e73a8af0-1d9a767bdfamr5925511637.22.1729974362246;
        Sat, 26 Oct 2024 13:26:02 -0700 (PDT)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205791dda2sm3081517b3a.42.2024.10.26.13.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 13:26:01 -0700 (PDT)
Date: Sat, 26 Oct 2024 13:26:00 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linux.dev, Hanjun Guo <guohanjun@huawei.com>, 
	iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, Len Brown <lenb@kernel.org>, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>, 
	Alex Williamson <alex.williamson@redhat.com>, Eric Auger <eric.auger@redhat.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Moritz Fischer <mdf@kernel.org>, 
	Michael Shavit <mshavit@google.com>, Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, 
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v3 0/9] Initial support for SMMUv3 nested translation
Message-ID: <7uv6kandebgqyw64im2kfwmiqahsikpsb6yp2tkd6qol3li3r3@fxsra3soryma>
References: <0-v3-e2e16cd7467f+2a6a1-smmuv3_nesting_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <0-v3-e2e16cd7467f+2a6a1-smmuv3_nesting_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 09, 2024 at 01:23:06PM -0300, Jason Gunthorpe wrote:
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
> eventually move towards the vIOMMU owning the VMID.
> 
> Nesting support requires the system to either support S2FWB or the
> stronger CANWBS ACPI flag. This is to ensure the VM cannot bypass the
> cache and view incoherent data, currently VFIO lacks any cache flushing
> that would make this safe.
> 
> Yan has a series to add some of the needed infrastructure for VFIO cache
> flushing here:
> 
>  https://lore.kernel.org/linux-iommu/20240507061802.20184-1-yan.y.zhao@intel.com/
> 
> Which may someday allow relaxing this further.
> 
> Remove VFIO_TYPE1_NESTING_IOMMU since it was never used and superseded by
> this.
> 
> This is the first series in what will be several to complete nesting
> support. At least:
>  - IOMMU_RESV_SW_MSI related fixups
>     https://lore.kernel.org/linux-iommu/cover.1722644866.git.nicolinc@nvidia.com/
>  - vIOMMU object support to allow ATS and CD invalidations
>     https://lore.kernel.org/linux-iommu/cover.1723061377.git.nicolinc@nvidia.com/
>  - vCMDQ hypervisor support for direct invalidation queue assignment
>     https://lore.kernel.org/linux-iommu/cover.1712978212.git.nicolinc@nvidia.com/
>  - KVM pinned VMID using vIOMMU for vBTM
>     https://lore.kernel.org/linux-iommu/20240208151837.35068-1-shameerali.kolothum.thodi@huawei.com/
>  - Cross instance S2 sharing
>  - Virtual Machine Structure using vIOMMU (for vMPAM?)
>  - Fault forwarding support through IOMMUFD's fault fd for vSVA
> 
> The vIOMMU series is essential to allow the invalidations to be processed
> for the CD as well.
> 
> It is enough to allow qemu work to progress.
> 
> This is on github: https://github.com/jgunthorpe/linux/commits/smmuv3_nesting
> 
> v3:
>  - Rebase on v6.12-rc2
>  - Revise commit messages
>  - Consolidate CANWB checks into arm_smmu_master_canwbs()
>  - Add CONFIG_ARM_SMMU_V3_IOMMUFD to compile out iommufd only features
>    like nesting
>  - Shift code into arm-smmu-v3-iommufd.c
>  - Add missed IS_ERR check
>  - Add S2FWB to arm_smmu_get_ste_used()
>  - Fixup quirks checks
>  - Drop ARM_SMMU_FEAT_COHERENCY checks for S2FWB
>  - Limit S2FWB to S2 Nesting Parent domains "just in case"
> v2: https://patch.msgid.link/r/0-v2-621370057090+91fec-smmuv3_nesting_jgg@nvidia.com
>  - Revise commit messages
>  - Guard S2FWB support with ARM_SMMU_FEAT_COHERENCY, since it doesn't make
>    sense to use S2FWB to enforce coherency on inherently non-coherent hardware.
>  - Add missing IO_PGTABLE_QUIRK_ARM_S2FWB validation
>  - Include formal ACPIA commit for IORT built using
>    generate/linux/gen-patch.sh
>  - Use FEAT_NESTING to block creating a NESTING_PARENT
>  - Use an abort STE instead of non-valid if the user requests a non-valid
>    vSTE
>  - Consistently use 'nest_parent' for naming variables
>  - Use the right domain for arm_smmu_remove_master_domain() when it
>    removes the master
>  - Join bitfields together
>  - Drop arm_smmu_cache_invalidate_user patch, invalidation will
>    exclusively go via viommu
> v1: https://patch.msgid.link/r/0-v1-54e734311a7f+14f72-smmuv3_nesting_jgg@nvidia.com
> 
> Jason Gunthorpe (6):
>   vfio: Remove VFIO_TYPE1_NESTING_IOMMU
>   iommu/arm-smmu-v3: Report IOMMU_CAP_ENFORCE_CACHE_COHERENCY for CANWBS
>   iommu/arm-smmu-v3: Implement IOMMU_HWPT_ALLOC_NEST_PARENT
>   iommu/arm-smmu-v3: Expose the arm_smmu_attach interface
>   iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED
>   iommu/arm-smmu-v3: Use S2FWB for NESTED domains
> 
> Nicolin Chen (3):
>   ACPICA: IORT: Update for revision E.f
>   ACPI/IORT: Support CANWBS memory access flag
>   iommu/arm-smmu-v3: Support IOMMU_GET_HW_INFO via struct
>     arm_smmu_hw_info
> 
>  drivers/acpi/arm64/iort.c                     |  13 ++
>  drivers/iommu/Kconfig                         |   9 +
>  drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
>  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 204 ++++++++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 114 ++++++----
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  83 ++++++-
>  drivers/iommu/arm/arm-smmu/arm-smmu.c         |  16 --
>  drivers/iommu/io-pgtable-arm.c                |  27 ++-
>  drivers/iommu/iommu.c                         |  10 -
>  drivers/iommu/iommufd/vfio_compat.c           |   7 +-
>  drivers/vfio/vfio_iommu_type1.c               |  12 +-
>  include/acpi/actbl2.h                         |   3 +-
>  include/linux/io-pgtable.h                    |   2 +
>  include/linux/iommu.h                         |   5 +-
>  include/uapi/linux/iommufd.h                  |  55 +++++
>  include/uapi/linux/vfio.h                     |   2 +-
>  16 files changed, 465 insertions(+), 98 deletions(-)
>  create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> 
> 
> base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
> -- 
> 2.46.2
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

