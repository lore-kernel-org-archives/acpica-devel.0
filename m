Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655892420A
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 13 Nov 2023 20:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iaj61IcI"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 206E360B19
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 13 Nov 2023 20:10:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 206E360B19
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iaj61IcI
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DHTrsM5DNtax
	for <acpica-devel@lists.linuxfoundation.org>;
	Mon, 13 Nov 2023 20:10:49 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6DA8560ABD
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 13 Nov 2023 20:10:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6DA8560ABD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699906248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
	b=iaj61IcIA2tUyM9x/d9+idowVQkji2UXaoYRwKlEpIEy/7x9FyEhmZgy08n0EKwfdVaX2L
	Obecpyg3ritw20v5Epb0YRsRxgpK6udNtiXboZgPRMoD74T4n6ETwi8jIJf8yGMdVyCGul
	CeDL5HsedbM7kfdGVsEnScDeITNKUpc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-Kj_oqV0RNF2ahYAI6Xo5xw-1; Mon, 13 Nov 2023 15:10:46 -0500
X-MC-Unique: Kj_oqV0RNF2ahYAI6Xo5xw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7789a691086so580920085a.0
        for <acpica-devel@lists.linuxfoundation.org>; Mon, 13 Nov 2023 12:10:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699906246; x=1700511046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=ud7cyRfjr5+zwB+F9/5PlzuXpfL18LL8bmigqzG9wPwzsmu8X+CQFfTwBfnkFgtrkx
         OHk8dOcuwS58j8pj9F6XeqqJA4aTWH/RkEJhyBHGyv9FaV55OvWRtsektb1cU0KWiRhn
         036DUJqem80330nqzQjPWfJaYPMh5yEa3GNgL7pd8N2wmc9FbaPlMoXvc9/yxJTTvfMr
         pp9ELZIoP3jlXh+vQnG+u4f01PFwcC9f644AHP06m5lmYB4vGyrUP/xsdjPSo0/a3Htc
         Pw9pAjfy4yDtXK6jgEQxKvIv5axxtpzOGJbWwZT0zLFa0Ji2J5Wskvmg/zT0mG+Fii3c
         Xa/w==
X-Gm-Message-State: AOJu0YzzKdhaGUGdD+CjAws+n/ED/92f0LyTKCmHktD6sl4yD/8MdF0I
	3/2x7a55PcbnLpnFPIgMmFBzA7rHaWPEGZD4DlnU/ak4xIYx/6zo8iyPdVZD8UIRAJqV+/ARyNd
	/EWBiIcrA+0uHZjr5Xq8zuZ45OoGpdLO2XAFdOw==
X-Received: by 2002:a05:620a:3710:b0:776:fb0c:6b5c with SMTP id de16-20020a05620a371000b00776fb0c6b5cmr322032qkb.13.1699906245979;
        Mon, 13 Nov 2023 12:10:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTedyYglCJvmi92iRdR2D4BIAbVzeajOKcDR1OXvlL6dJaLGV+tVe1Q6WIBYPyxZBc3gPFSw==
X-Received: by 2002:a05:620a:3710:b0:776:fb0c:6b5c with SMTP id de16-20020a05620a371000b00776fb0c6b5cmr321979qkb.13.1699906245767;
        Mon, 13 Nov 2023 12:10:45 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id o6-20020a05620a130600b007742bc74184sm2112406qkj.110.2023.11.13.12.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:10:45 -0800 (PST)
Date: Mon, 13 Nov 2023 13:10:44 -0700
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
Subject: Re: [PATCH RFC 05/17] iommu: Make iommu_fwspec->ids a distinct
 allocation
Message-ID: <bhbvxv5bt7b5tad27cuvy6efpkg2fwxx2delgcmnsd7sttqngl@irtpllmr7wq4>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <5-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <5-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

