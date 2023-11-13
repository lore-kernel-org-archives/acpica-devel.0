Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953AE24A11
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 13 Nov 2023 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EsoPlO93"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4248A81FCE
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 13 Nov 2023 20:25:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4248A81FCE
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EsoPlO93
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fpxM1YI4Y2z6
	for <acpica-devel@lists.linuxfoundation.org>;
	Mon, 13 Nov 2023 20:25:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E03AD81F8B
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 13 Nov 2023 20:25:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E03AD81F8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699907126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
	b=EsoPlO93xa9IbDgvEh3uBrUaKHGA2TgVsMGRGD6Yx6oHWeRvWdx1aV+WWOGBv88/IX6hVd
	jV3XdIqepXP+Swe2na1/oMMYrFc0INXer/5N3Uc8mVMUhhyywzfPBMZg18P/bO1wHQLLHT
	5mWePEi+opY3VO3GMuFts4mAiSIzw3U=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-_strlBL4OByWZb-M4KMGgQ-1; Mon, 13 Nov 2023 15:25:25 -0500
X-MC-Unique: _strlBL4OByWZb-M4KMGgQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-66fe14725aeso61926626d6.2
        for <acpica-devel@lists.linuxfoundation.org>; Mon, 13 Nov 2023 12:25:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699907125; x=1700511925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=a+XUA1qB2o7qROCaY4WViLW1rWgHIElM3gdp33D6qQE3t7B8nBItetwmxgvQBn5OKC
         iLFjQbr3ZEeCJD3ZOOSxq05UFyyymxvgOcfJ8VG6oOnDzWDlSukUFZWId1XHeryTBt9/
         3Nn+/kvXDmRlC5avr8CKnO8RYfTA/JUOMmNLwiiYlyVcfMsoZAwukRH4/ihpRbuq2TkI
         /wY0rXHS3ajU02ItrYzSzx6NW7LdKhTLGKUCDamUCDItbYGN39nZpYmuv/RGEL6PRXgs
         Va0fI7W9hPJGc1P62chnXFcDsueuRixfNDsDq8O3dzUW3JqrMPNFIOApxVKBmXdRBj1K
         j+aw==
X-Gm-Message-State: AOJu0YxXvkjB7Tmz+aABbBX1/sykVpv6ON+uUtlQVRUOMtxXJXU1OP07
	5+sA9eqivvxrxfS5zAw9L36K50hETZ3T7S6IXIT3wEb71vvtxeA2YbPzbLriI5Dkxgz317OS5el
	IXQ8AVrNyP5zQxP7qpyhpVw1b1k6MM2XMDVWT9w==
X-Received: by 2002:a05:6214:2a9:b0:672:3f54:b94f with SMTP id m9-20020a05621402a900b006723f54b94fmr343497qvv.7.1699907125267;
        Mon, 13 Nov 2023 12:25:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDuwvOtoyPZ5iPmtgsnzi3ZmT4SfzU8sjdIavaCXICAagXeDLzw8KJuwOG1DaOAnqE0bqGXg==
X-Received: by 2002:a05:6214:2a9:b0:672:3f54:b94f with SMTP id m9-20020a05621402a900b006723f54b94fmr343444qvv.7.1699907125050;
        Mon, 13 Nov 2023 12:25:25 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id qz6-20020a05620a8c0600b00774292e636dsm2120525qkn.63.2023.11.13.12.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:25:24 -0800 (PST)
Date: Mon, 13 Nov 2023 13:25:23 -0700
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
Subject: Re: [PATCH RFC 16/17] iommu: Mark dev_iommu_get() with lockdep
Message-ID: <avqfvjfck64kedxvjtsw5rc7x2dkubbpm5ytz6roog6pb7of2z@g6up6nxawsmo>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <16-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <16-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

