Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C041804E
	for <acpica-devel@lists.linux.dev>; Wed, 15 Nov 2023 14:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eMisUO8G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700059545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
	b=eMisUO8GETcoW33XgbVvGFoZSGvcs6sr8qGR7HdNuy6l7n+3b1r3cCgVaaTc4rmVnvIdFs
	esAP0rORkrKtXky+DkVYgB6FJ4yK+vA/nAux7Gys3mK38+iEZ1SFTozp/AS0YvkuyBj+qC
	QN055SZdG2DH06ofT8KRCvBNYieATAE=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-14u9SYUFNOKEzhWsQF3mvA-1; Wed, 15 Nov 2023 09:45:44 -0500
X-MC-Unique: 14u9SYUFNOKEzhWsQF3mvA-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b2ecaf68dbso8020203b6e.0
        for <acpica-devel@lists.linux.dev>; Wed, 15 Nov 2023 06:45:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700059543; x=1700664343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=TpSZPGYpY6kvyhuIZVMn8Ux7m2BYp2VJLM5FzE7Qz6U5Xx5Qevnb3ccPZ1nAnCQsE2
         UIq3nX3qavlXZiZNitBgCiSXmlJH2YTeaD09nFYKMuUsMeV2fZ42TfXAAOn7WrCSKjcR
         eevArI95P9cQ1FBE+zkQZMG6cxuTNwlt6lnZtRbtYwyr/ZUl2/epmgDmehQUNJxeXQ9K
         Nnsg3FuSXMO5xjtNQBt4Af7kb9+QbFBIdTErT6eXLwwXho4gUwNb1utpPtHOdJ+8hYmG
         0wtY6L/Hd+CfPVvSij0UnAndB+h+Ka9DsIQU/vdjzPmk6M6JwUqaWTMH58elpA9gyqsL
         VT5g==
X-Gm-Message-State: AOJu0YxOZ/Zay4yuiL+uPcV9oqatkQlTj+pnqR0jhyi5d8AG29ESEqTs
	5ueekAVTyvffoFJJAGTZ7FVYjCR//g6h1QNKz4G33FoU05RN1iQ2WTnoG65gYu5kc+YtOy/kpDS
	BFC6sfGv/YqZu4K9sTlNzLQE/
X-Received: by 2002:a05:6358:919a:b0:16b:c64b:5dad with SMTP id j26-20020a056358919a00b0016bc64b5dadmr7077931rwa.10.1700059543527;
        Wed, 15 Nov 2023 06:45:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcJVORPEWxErQUmTJ/FpxcV4QjvJjDEY7Ir6ZH3gFB8P/4S+/kGnZXTGDIbciHJXITaJ6Zhw==
X-Received: by 2002:a05:6358:919a:b0:16b:c64b:5dad with SMTP id j26-20020a056358919a00b0016bc64b5dadmr7077772rwa.10.1700059540988;
        Wed, 15 Nov 2023 06:45:40 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id v10-20020a0cf90a000000b00655d6d31470sm577985qvn.43.2023.11.15.06.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 06:45:40 -0800 (PST)
Date: Wed, 15 Nov 2023 07:45:39 -0700
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
Subject: Re: [PATCH v2 04/17] acpi: Do not return struct iommu_ops from
 acpi_iommu_configure_id()
Message-ID: <qmb2wshxcq75o43xikgw3ks6d72yyiranapupkwmwcm5b4vkgp@mgm36neokikv>
References: <0-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
 <4-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <4-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

