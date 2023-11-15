Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2C72FC35
	for <acpica-devel@lists.linux.dev>; Wed, 15 Nov 2023 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+reQVdP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700060051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1FlIYAXhM/ERDubCadB5WwuUe+5s0MuhfY1IPTS1Qc0=;
	b=D+reQVdP4TG7r0peSpVec3+DtrSPG3FmfhpxsxuBtCzGMZwZLmYbX9xNM/ih3mwVmW9Mzs
	pOduPmQgiZOlj/zWR//zynVpxE/9DMMXO2TDS1iFokWk/t61zeLaOcMo3Gp0KPEQW0QHzl
	zmv0L6F6kWf4W8G5Xik8ReI2tWAEcQY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-4PuR1m0NPz2OaOd8Z6Ju7g-1; Wed, 15 Nov 2023 09:54:08 -0500
X-MC-Unique: 4PuR1m0NPz2OaOd8Z6Ju7g-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7788fa5f1b0so804842985a.2
        for <acpica-devel@lists.linux.dev>; Wed, 15 Nov 2023 06:54:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700060047; x=1700664847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FlIYAXhM/ERDubCadB5WwuUe+5s0MuhfY1IPTS1Qc0=;
        b=ByQ46xfn2+eM2acVIPXp613iAlom4IC88OBedaALm7NIRUVEj6RRcLoMEyOVwRKWBL
         NRvGaR7sO6nENx4qM/ma3xfmdkJOu6E+KM03WE0i7W0wGflq8H3Jfs/BUFAm+2hAjsc/
         uDFeCSzjVz4HvzOx4DXJeTbIS6vwlYg74b60gumR6O1DBZQ2Uou+l+EFG0Bf7ghzAXz2
         +11DuFURknvU7vcHBvaHeEZBRyksCgfYX+MVANdUB01h3xZae6qzl7it61+wf4zGCcCw
         vLHvAHMaz/v3py7Cz1/1kjtb8bmAL7kRWQnQbk+V3nP8q86+P9OHDtci8ofRsHzquCzt
         ALFA==
X-Gm-Message-State: AOJu0YxfJrMaWhWDJ1njFSRPqA186xPeN3khFTuplQGYpVvszXESgIQ0
	p9fFZVtUbDYDAa84wR4iNw9aqGRm07Tak5La+9C6mXRqNp8eppGQVWs2iCUpIVg2/m3qQ642Nd7
	EK6nbF3eCiAb4pYB34btZ7cs/
X-Received: by 2002:a05:620a:560b:b0:77b:b34e:6262 with SMTP id vu11-20020a05620a560b00b0077bb34e6262mr6700741qkn.46.1700060047601;
        Wed, 15 Nov 2023 06:54:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8Q+hB6LwGEOpBjf0tTy48HeUIb95APpcQR8cIO4M7kaLSCpN0/vvs5U/8Y5mL2TRIxjAUaQ==
X-Received: by 2002:a05:620a:560b:b0:77b:b34e:6262 with SMTP id vu11-20020a05620a560b00b0077bb34e6262mr6700714qkn.46.1700060047365;
        Wed, 15 Nov 2023 06:54:07 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id dx8-20020a05620a608800b0076cc0a6e127sm3521399qkb.116.2023.11.15.06.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 06:54:07 -0800 (PST)
Date: Wed, 15 Nov 2023 07:54:05 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev, Catalin Marinas <catalin.marinas@arm.com>, 
	Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>, Frank Rowand <frowand.list@gmail.com>, 
	Hanjun Guo <guohanjun@huawei.com>, Haiyang Zhang <haiyangz@microsoft.com>, iommu@lists.linux.dev, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-snps-arc@lists.infradead.org, linux-tegra@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Hector Martin <marcan@marcan.st>, 
	Palmer Dabbelt <palmer@dabbelt.com>, patches@lists.linux.dev, 
	Paul Walmsley <paul.walmsley@sifive.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Rob Herring <robh+dt@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Sven Peter <sven@svenpeter.dev>, 
	Thierry Reding <thierry.reding@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Krishna Reddy <vdumpa@nvidia.com>, Vineet Gupta <vgupta@kernel.org>, virtualization@lists.linux.dev, 
	Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>, 
	=?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Christoph Hellwig <hch@lst.de>, Moritz Fischer <mdf@kernel.org>, 
	Zhenhua Huang <quic_zhenhuah@quicinc.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 00/17] Solve iommu probe races around iommu_fwspec
Message-ID: <ah7jh6pi5o3s47mz5y4tms46fvpbmaisw6orom6tke2vdsqejm@qvjnxhejqs5i>
References: <0-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <0-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Did patch 12 v2 get sent? I'm not seeing it locally, nor in lore, and b4 doesn't find it when pulling then thread.

Regards,
Jerry

