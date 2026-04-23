Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E374F3590A4
	for <acpica-devel@lists.linux.dev>; Thu, 23 Apr 2026 22:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776984312; cv=none; b=t0rzw03qnw5Jib5uCreDsrUheMFAc17HgwfcYnpwzdTvZUGx92wL4m4Vri/zcNUmZ0QYVVmWHYOdsn//MS2n2swSxxv1iq9c/ANq661H8G9w9WA6voDBZ2unaMwGVDN0Su7cVCYAUwZcgayI9qs+2Yt9pzXz1nc2hFEAQfgWN9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776984312; c=relaxed/simple;
	bh=Yh35ooV5k2ic+R5vE8oeNjphhYaG5GuCEktYzyHuivU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2On3OkShL0Q5tzkSQpBSdHmpGLanEgmsehPUqDZNAaZEGNNvRG1LOZonMkIF6pXhtSgNxJDRcTgElauCBpaWb2ECeY/3Rhfq22/OiQ/v71oIa6ya9mkYCGwUScUwcWnO/W7VRp7zqPHS7pq5Fg3mDqi7zYqf+Vum+zqUFyg+j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ABHFGqmi; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ABHFGqmi"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8d4f78fc9f6so775550485a.3
        for <acpica-devel@lists.linux.dev>; Thu, 23 Apr 2026 15:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776984310; x=1777589110; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VHs1SB6C6q+VxGSLs4PEu15EKKlh8msoZuhCPbHV/WQ=;
        b=ABHFGqmiqeTjZPx+N5frAjYe4txgVL6E+22cya7nBoCndQ2413aX9efDk1vRuOrdbn
         9MQCigFClWrBsjr9RCTUGqyqS2R46vDbiAT5o6G+HTiyKPOvArdCyEceKADJJFOWAZLC
         MWSwVo9iRZ//RCNHV6hx16t0SdvjdIFX1cm2WpvIzsWj6mOPxGj8nC+1RQM5K/8hh5wK
         XyR3ngSCUpBMIVoWon447ClaP6KjrU2aDybBF5hv55gUgE2QEnIeuKBQDiGUHgIfDS7p
         FvlVLltrv+Wy1LfQmONXdC9nUDDnFGTlYrvRuNsGYSdY2xQTEUZEkhN4PiAxuOQQZQRS
         SNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776984310; x=1777589110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHs1SB6C6q+VxGSLs4PEu15EKKlh8msoZuhCPbHV/WQ=;
        b=ZgLz7D3hNocCtB2HA3Os1PuTVGJQ8AwY1ziMkwPN/IKqUuGP6ylnijML8lVsBkXv4Z
         a3jTuJ7cQHdG8x5dFrlUEGWHfOay4xS3sZbr2UIDNM0/M69Vlcr74msMrEcHox2Lop31
         wXs8Ao5/4azXcb9wCXzMlunotzogbROh4IKC54Nm0eOPuEIifibEreo98shsKSJKp5Qp
         KnJ1EAJTnL1U1nHU/psktZP1Qx0hCNYDWakGRzmOeF8NWDKQerguvRML3/irGfCEhmp5
         AyAvWaHacWOP1kaqLh9o8B1iU5K5xE4pqEKZKAwdLEEta4YzaLkSkNe+u62Mpyt9NSHf
         fKYg==
X-Forwarded-Encrypted: i=1; AFNElJ8KdOjliXFsRloN0GLqTz63atwu80w1EvmIztuW0hFCWG79h+Y9nusOYQtaS1zYiQdnmIywkT/3RUGU3qE=@lists.linux.dev
X-Gm-Message-State: AOJu0YxAiO7auGBuBGqUOYqlVN7txgQBkkD1SxFusHRPeL+DmLkdBq/A
	YB1wvTjMedtBWUrHi8N+kLBDRBBnSfi9GNCkzVpQk5eOgXSonAh33Bo1+BMVOGS7iR4=
X-Gm-Gg: AeBDieswV5w/o7sLD/KSck2drX19iKh7p5dnhTi6YN1tfcDUHI9x9IwJ97XTDNusZZG
	YtWNKNmpH2VwK2ki9ctKN1XdkEpk73BdP9F/pE/ZcHBDeD0w0Q3LwdJVyo/4YNSaTwiAV5BA1a+
	VzlKBuIGhe03qhNKvWWJOGsuq/2P1gHf4IX8yy9KTVS8O++ofU12QX7tg2r8PsXFlExn/ls0ZeS
	u6xzD8WowGlG2CH10fggcS5RgHBEo1nvcXndpn5zm++iShiqUIAqcDzYJlIAt31B/prHXV71t/E
	PO2feq+3PAgkG4xfqGPljGwHnA2xj2MFw9jNt7xnHDNzwzO8UkzjPlQbW0zALQtpQtjepCw4oZF
	b/LbV+cMFWoUyDFAxMXnlFGLpZaVRCE8WqauW6mXNv66Kct+yvxJPwWOjD4Ab9PIjiCW13dzWgP
	AA7fbOvS/w3aJ9FtVOZzreyHfir6QXtppMPFhPLeyDVom6aIspLPYJiQDBc2opZ9sAl2AkH9PfL
	Yi+OhKExJhrCgWj
X-Received: by 2002:a05:620a:4554:b0:8ee:2c17:2ff3 with SMTP id af79cd13be357-8ee2c1733c4mr2169354085a.0.1776984309768;
        Thu, 23 Apr 2026 15:45:09 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8eb9becc72dsm1271207885a.34.2026.04.23.15.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 15:45:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wG2nE-0000000GLqe-155A;
	Thu, 23 Apr 2026 19:45:08 -0300
Date: Thu, 23 Apr 2026 19:45:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: rafael@kernel.org, lenb@kernel.org, saket.dumbre@intel.com,
	lpieralisi@kernel.org, guohanjun@huawei.com,
	sudeep.holla@kernel.org, will@kernel.org, catalin.marinas@arm.com,
	joro@8bytes.org, robin.murphy@arm.com, nicolinc@nvidia.com,
	praan@google.com, vsethi@nvidia.com, sdonthineni@nvidia.com,
	kthota@nvidia.com, sagar.tv@gmail.com, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, acpica-devel@lists.linux.dev,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 3/3] iommu/arm-smmu-v3: Honor IORT Root Complex PASID
 descriptors
Message-ID: <20260423224508.GU3611611@ziepe.ca>
References: <20260423191417.2031652-1-vidyas@nvidia.com>
 <20260423191417.2031652-4-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423191417.2031652-4-vidyas@nvidia.com>

On Fri, Apr 24, 2026 at 12:44:17AM +0530, Vidya Sagar wrote:
> The SMMUv3 driver currently calls pci_enable_pasid() for any PCI
> master that exposes a PASID capability, regardless of whether the
> upstream Root Complex actually supports PASID and regardless of the
> RC's declared Max PASID Width. With IORT spec E.c (RC node revision
> >= 4) firmware reports both, so we can do better:
> 
>   - If the IORT Root Complex node says PASID is not supported
>     (Flags bit 0 == 0 at byte offset 36), enabling PASID on the
>     endpoint is futile - the RC will not forward the PASID prefix to
>     the SMMU - so skip pci_enable_pasid() silently.
> 
>   - If the IORT Root Complex node reports a Max PASID Width (bits[4:0]
>     of PASID Capabilities at offset 33), clamp the endpoint's
>     pci_max_pasids() result by 1 << width before computing the SMMU
>     SSID width. This prevents master->ssid_bits from exceeding what
>     the RC can actually carry.
> 
> Both behaviours are gated on iort_pci_rc_pasid_max_width_known(), i.e.
> RC node revision >= 4, so platforms with older IORT firmware see no
> behavioural change and continue to enable PASID purely on the basis
> of the endpoint capability.
> 
> Use the new IOMMU_FWSPEC_PCI_RC_PASID fwspec flag (set by IORT) for
> the support check, and call iort_pci_rc_pasid_max_width_for_dev() for
> the width clamp; both pieces are wired up in
> iort_iommu_configure_id() by the previous patch.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 26 ++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index e8d7dbe495f0..2b269307fd33 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3071,16 +3071,28 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
>  
>  static int arm_smmu_enable_pasid(struct arm_smmu_master *master)
>  {
> -	int ret;
> -	int features;
> -	int num_pasids;
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
>  	struct pci_dev *pdev;
> +	int features, num_pasids, ret, rc_width;

Don't reformat the code like this.

Otherwise the series broadly makes sense to me

Jason
