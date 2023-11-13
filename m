Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D1F24203
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 13 Nov 2023 20:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TETKR5gE"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3600441704
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 13 Nov 2023 20:11:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3600441704
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TETKR5gE
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SFVYNH2FUYXS
	for <acpica-devel@lists.linuxfoundation.org>;
	Mon, 13 Nov 2023 20:11:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8D58F4174F
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 13 Nov 2023 20:11:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8D58F4174F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699906302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
	b=TETKR5gEqAHG8BMIkcGPuwULTW0Rk8Vc9TY0Nk3rmBw9RrQDuw/NQ7rtYPDQtXOal9X/FY
	HeGfV8BmQ1aMhp3IyZO3rjBi76cxpjCzrLKZoXRSipuLu7hu1zeVCnSbbdf3eWZ1lZTYQV
	3B69cOWP2DBPlgeaRbvgL3Cku0KAn94=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-cxt7EmfxNIyo6LuSSXWZXw-1; Mon, 13 Nov 2023 15:11:40 -0500
X-MC-Unique: cxt7EmfxNIyo6LuSSXWZXw-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-589fa8cd181so3873752eaf.2
        for <acpica-devel@lists.linuxfoundation.org>; Mon, 13 Nov 2023 12:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699906300; x=1700511100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=IQVRcVeXpIHGGlk0vcQr9e2lNJr/K11wFc+8yOK+14y4pUD5fgr8fuZJHp5bjuO05Q
         ifgpu7XKx7IxyLO4vbMzeJ04RDnQ5z/TJ1fmqp1cM+sYD0x3unAJ1LveI4FQJvIf7mJs
         OSehjvCizqeIu+5kaDpd8PLMHPyocYEK4aFdzLnTM0Fa7pXIlBhUuQm7/m3ipYlAM2qm
         h1ZIuButSWWdxUC7ccW68eq70SbfVuNDUnjZlOcKAGinhwPbB21LXAQaaBn0lYvIHlbv
         YjT+x8Jh0dpCEVB+DBGaX78iXlqAvRLDAvAuamge2uOxRF+cmDU+m9IsqLRwEsXCbYmt
         ObLw==
X-Gm-Message-State: AOJu0Yw5rDXOlTqBBVEElO9BpFjukY9PHWb9jOt9CQYO7+uEp+RWZ8Jb
	4hKVNXj8pwd0l8nEKyT2pKCXd29BhzEb2QTrRV5xtregLqJYYrxvoF736RUV+cQIBAfriPL8N0u
	CtBNEkkjKouqr+Xjm5m/N9jcvymhIotoywanVqA==
X-Received: by 2002:a05:6358:2904:b0:168:e592:f8d2 with SMTP id y4-20020a056358290400b00168e592f8d2mr367439rwb.25.1699906299930;
        Mon, 13 Nov 2023 12:11:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIOetclT7JIwJMgw/sY1gBz67FNYTbvIhgzf8jdwnJ0WmLDY550/th30Kkt+kh8RpDUm+sYQ==
X-Received: by 2002:a05:6358:2904:b0:168:e592:f8d2 with SMTP id y4-20020a056358290400b00168e592f8d2mr367389rwb.25.1699906299658;
        Mon, 13 Nov 2023 12:11:39 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id i2-20020ac87642000000b004194c21ee85sm2173891qtr.79.2023.11.13.12.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:11:39 -0800 (PST)
Date: Mon, 13 Nov 2023 13:11:37 -0700
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
Subject: Re: [PATCH RFC 07/17] iommu: Add iommu_probe_device_fwspec()
Message-ID: <uw2q27tpuqmxe5gzjjsmnjy2rvtztqomdh4czbws3yredeshzl@7zy6ls5ozqg7>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <7-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <7-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

