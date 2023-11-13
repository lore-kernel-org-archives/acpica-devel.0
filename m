Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20D22420D
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 13 Nov 2023 20:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ad4b1lZt"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D1D9B4176B
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 13 Nov 2023 20:11:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D1D9B4176B
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ad4b1lZt
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G9uw-48hkeVi
	for <acpica-devel@lists.linuxfoundation.org>;
	Mon, 13 Nov 2023 20:11:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2EFD141704
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 13 Nov 2023 20:11:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2EFD141704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699906284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
	b=Ad4b1lZtd61Vuf5abjVAKldS78A63DVRnlTajGp5zX+H+Nag7ZYs6prr/HvWLA4QSSIDFa
	Ut0Goxb5lYeVCqMfpV7xQXKWfctqgN0Yy68GiQUW1l0Iteu04QSRIcCp3bdb/YlFo798E0
	GulQpfe+Pftp+oCCJXX8diIV8ih7Wuc=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-oxJNwC1gOp-z3hADk7_bKw-1; Mon, 13 Nov 2023 15:11:23 -0500
X-MC-Unique: oxJNwC1gOp-z3hADk7_bKw-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-5a909b4e079so66605427b3.2
        for <acpica-devel@lists.linuxfoundation.org>; Mon, 13 Nov 2023 12:11:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699906282; x=1700511082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=dAqc/dwFTl/zBhIcGyeE21DIms86SpX8gxgfJ854nsHZNLRf8P8VOH06sbJo0sKxsC
         xvLSjTxeYDlam0/vbHdg5/14Adxe56SjQZkX1X7/nj0p8S3oxIZKP2x6iobP3ImMTVS0
         9au1DegA+GSaIfw5+FvplYfTNG+yPlPqeP1oWu1kWiwhr+KKLBQqUmpbTPcKD0V7wV0z
         Rw0tb5pfzqWMv4582bnowoGQ5MHAzfGFB3t20dLNDK61No2rZRysinJrhUD8P7TMUTH0
         dXMQ6ULB1WEwgcizylSo+WOojdDPwc+g13P45yzOsJpiLmDwDKhKTtWRMEBmIbJQo6IL
         RXFg==
X-Gm-Message-State: AOJu0Yy9l5mTSHwXZbCLn9yTMTwYHSLWXooTfXNjZaIUYtvwBT/hGNV/
	QgObRGvv7xKr2k2EUXEfIvvq5qMuakqaq2RyCUvRjGU1VWC6QnZ8jFBGm/wPsT9DAm5KS6JSaoM
	UrwmaRam5k5VzLs9k8FZgDMfdRZ8D6pb3YRBNqA==
X-Received: by 2002:a0d:ce45:0:b0:5a8:1d2e:e3e4 with SMTP id q66-20020a0dce45000000b005a81d2ee3e4mr8477339ywd.35.1699906282683;
        Mon, 13 Nov 2023 12:11:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPvmsC2qHDAh0Qw02m6ztA4jHl4uXRCi8o2kOZJlZ5OQtATt5oXfPPiPdyIMyU/zTa6M8O2g==
X-Received: by 2002:a0d:ce45:0:b0:5a8:1d2e:e3e4 with SMTP id q66-20020a0dce45000000b005a81d2ee3e4mr8477311ywd.35.1699906282465;
        Mon, 13 Nov 2023 12:11:22 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id z10-20020ac8710a000000b004196a813639sm2170954qto.17.2023.11.13.12.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:11:22 -0800 (PST)
Date: Mon, 13 Nov 2023 13:11:20 -0700
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
Subject: Re: [PATCH RFC 06/17] iommu: Add iommu_fwspec_alloc/dealloc()
Message-ID: <qc6zidfhp2x6jmkteemyvi55wnaxlnqyfurdmdft2huxjh26ar@ffbwr7yaa3dl>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <6-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <6-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

