Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E1330CEF
	for <acpica-devel@lists.linuxfoundation.org>; Wed,  8 Nov 2023 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C11841B77
	for <acpica-devel@lists.linuxfoundation.org>; Wed,  8 Nov 2023 16:11:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4C11841B77
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.151
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 87tcQ2Hvnuaz
	for <acpica-devel@lists.linuxfoundation.org>;
	Wed,  8 Nov 2023 16:11:42 +0000 (UTC)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 91E5A418F9
	for <acpica-devel@lists.linuxfoundation.org>; Wed,  8 Nov 2023 16:11:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 91E5A418F9
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3b58d96a3bbso2942019b6e.1
        for <acpica-devel@lists.linuxfoundation.org>; Wed, 08 Nov 2023 08:11:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699459901; x=1700064701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egO/3A8usR47pYsFMHy7at49a3WUUkqONQqbQuU8j7Y=;
        b=UUvzvjdRMdVkNxPOxuzOcfsenMy0jfKUVACEDVB7ADwlIhWlKI7RAQaKLmYvI0SuGj
         aIKNB6bE4ytNIiuZls4pes3vVeSYxPh8IKFyt844BXZHRGwTZpplum8s6qxbLVxWUxUs
         xgGGq4nIKKw8rUeRgq+lxTRlqnWMs9aB/J4PmY+9XWJYRim8XYDJA3RLEODqaajONkqG
         n3CFXx6O9w4idH4wY1iUarV7abP4Q0mTNtQ3gOLUM7dw3Rt5OjdTCNCT0WRGBvrfaY/w
         mHljHb6G0vXdN34CcjjM8/IhlmODa1XKxeOZnpGfYhG0sJ0CJMUpK/oyhdE2sfV0HBud
         ZVwQ==
X-Gm-Message-State: AOJu0YxljRr+WQsl3/e60JaUxKDE6fTO5ZhFBsD9h9/y/J4iXQm+zm4W
	Ib2cMt7blYVzh3R7pAbZpw==
X-Google-Smtp-Source: AGHT+IFG1ydbraxTf3qUlkUHE402Zq2u5RjAY4fdhcYCPQiBAZE+mNt+Ni+JkQlZMBRuNIEkL2d3Ow==
X-Received: by 2002:a05:6808:15a8:b0:3a9:cfb5:4641 with SMTP id t40-20020a05680815a800b003a9cfb54641mr3241896oiw.48.1699459901513;
        Wed, 08 Nov 2023 08:11:41 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bg42-20020a05680817aa00b003afc33bf048sm1959000oib.2.2023.11.08.08.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 08:11:40 -0800 (PST)
Received: (nullmailer pid 2284755 invoked by uid 1000);
	Wed, 08 Nov 2023 16:11:38 -0000
Date: Wed, 8 Nov 2023 10:11:38 -0600
From: Rob Herring <robh@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linuxfoundation.org, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev, 
	Lu Baolu <baolu.lu@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>, Frank Rowand <frowand.list@gmail.com>, 
	Hanjun Guo <guohanjun@huawei.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Len Brown <lenb@kernel.org>, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org, 
	linux-tegra@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Hector Martin <marcan@marcan.st>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Sven Peter <sven@svenpeter.dev>, 
	Thierry Reding <thierry.reding@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Krishna Reddy <vdumpa@nvidia.com>, Vineet Gupta <vgupta@kernel.org>, 
	virtualization@lists.linux-foundation.org, Wei Liu <wei.liu@kernel.org>, 
	Will Deacon <will@kernel.org>, Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: Re: [PATCH RFC 03/17] of: Use -ENODEV consistently in
 of_iommu_configure()
Message-ID: <20231108161138.GA2254211-robh@kernel.org>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <3-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>

On Fri, Nov 03, 2023 at 01:44:48PM -0300, Jason Gunthorpe wrote:
> Instead of returning 1 and trying to handle positive error codes just
> stick to the convention of returning -ENODEV. Remove references to ops
> from of_iommu_configure(), a NULL ops will already generate an error code.

nit: "iommu: of: ..." or "iommu/of: " for the subject. "of: ..." is 
generally drivers/of/.

> 
> There is no reason to check dev->bus, if err=0 at this point then the
> called configure functions thought there was an iommu and we should try to
> probe it. Remove it.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/of_iommu.c | 42 +++++++++++++---------------------------
>  1 file changed, 13 insertions(+), 29 deletions(-)
