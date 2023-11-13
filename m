Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A75D24A03
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 13 Nov 2023 20:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tzf7Yhg6"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D04481A23
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 13 Nov 2023 20:14:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1D04481A23
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Tzf7Yhg6
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5BV9IIGyHBCV
	for <acpica-devel@lists.linuxfoundation.org>;
	Mon, 13 Nov 2023 20:14:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2B4EB8177A
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 13 Nov 2023 20:14:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2B4EB8177A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699906490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
	b=Tzf7Yhg6Bq2BeMpQ5Xi8ymvsfnm3NlqXJsHQGY1U5Wq0JlPYuv5VbIp86+aIDx0sN3qqxi
	Y+uVOdBseHHMtdMgKrShwiFxnLZpv0A8wZqI1+nofGfJTRgcxcFXxDyRV3SkftmGMFlQ9c
	bUAkngv8+ZS7oAKNUOLWMLISZq2Dp5Q=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-YcIlSpmRMACeluieYOupSA-1; Mon, 13 Nov 2023 15:14:48 -0500
X-MC-Unique: YcIlSpmRMACeluieYOupSA-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-d9cb10a5d44so3269173276.0
        for <acpica-devel@lists.linuxfoundation.org>; Mon, 13 Nov 2023 12:14:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699906488; x=1700511288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=KG8xg7aT53D8aHJXk+oK/pBOHYA2wj2b33zXrU2w45ehC4zoD2Q7lpF4riCWR+T1jx
         T6saNjuvkOVqqBjyU6Y0gdLjIGM4CHKkRL2ReIxz4d8CeKnP3UjZVj1vwayTu/+R1Vsy
         VUedy178d1AdOe1H+qce23KWmp1XF2ooRppHjhMQnYy578YP3CbCTabz3FG4NVvPqFbm
         VzIxbsX/ThbyLLLWUOZQlWwHwTdEJmAqUQPXjn+0TSqcGAs3xU5k0CKEPTg5SCtfIwRv
         C+FfJ/j5nat9OSMi9YqyWW0k+bHdYFF3uxn57QBwINuECEUATak7RjWW4D44k3QUgvSR
         T/3g==
X-Gm-Message-State: AOJu0YwCMAcKHEKdpJxP6ISTE+axxTUCdBJKDvvunEQAM4okIwMs+TXe
	iNOlLhhqxDRl6xUIcDXy32BAyQyfeQ5StNlVg0BNAo9ZsIf0dQFgJsWPVMDi3AZ4W+IEOoHrGI9
	VAnQpz0WKKz8qV+9CSrVXQ0kW7CipE5JgdQ4Uzw==
X-Received: by 2002:a25:5:0:b0:da0:3510:d46b with SMTP id 5-20020a250005000000b00da03510d46bmr6598103yba.52.1699906487826;
        Mon, 13 Nov 2023 12:14:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtyhAPtrfBL5j0rs4OChIjX0J0MQ7pAdoQ6mY8g3IfqhpmTKneVz9ovn0oCERZBj6Wc4LsPQ==
X-Received: by 2002:a25:5:0:b0:da0:3510:d46b with SMTP id 5-20020a250005000000b00da03510d46bmr6598052yba.52.1699906487554;
        Mon, 13 Nov 2023 12:14:47 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id mg3-20020a056214560300b0065afcf19e23sm2297469qvb.62.2023.11.13.12.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:14:47 -0800 (PST)
Date: Mon, 13 Nov 2023 13:14:45 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linuxfoundation.org, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev, 
	Lu Baolu <baolu.lu@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>, Frank Rowand <frowand.list@gmail.com>, 
	Hanjun Guo <guohanjun@huawei.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-snps-arc@lists.infradead.org, linux-tegra@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Hector Martin <marcan@marcan.st>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Sven Peter <sven@svenpeter.dev>, Thierry Reding <thierry.reding@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Krishna Reddy <vdumpa@nvidia.com>, 
	Vineet Gupta <vgupta@kernel.org>, virtualization@lists.linux-foundation.org, 
	Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>, 
	Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: Re: [PATCH RFC 11/17] iommu: Hold iommu_probe_device_lock while
 calling ops->of_xlate
Message-ID: <5qix66x7f4mgnnylgy4uv2g5oeqxkwvdkrbleyxxfw3hlrhsth@fsqukzhyal6r>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <11-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <11-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

