Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45441249EB
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 13 Nov 2023 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTAMur/c"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC1F74174F
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 13 Nov 2023 20:13:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EC1F74174F
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BTAMur/c
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.599
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n1JoVI4wcM4l
	for <acpica-devel@lists.linuxfoundation.org>;
	Mon, 13 Nov 2023 20:13:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5481641704
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 13 Nov 2023 20:13:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5481641704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699906408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
	b=BTAMur/cBw2cWs7noaCA7jACSGU6/fvCxXI4GJgjtzQYKK2uSIjJubLxewIvr1eKap3KxK
	okVLNJjrjh79wGXuQUJU3CJDv2c8C3wHRnDIMnjE7dvjZ80shYOXX5AV8C16fIIsH0ZUWh
	jVvWHxvR5bZzXFBHvR2B3c+tOforPGk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-vT3DTcw6Oken1yyTSN8fmg-1; Mon, 13 Nov 2023 15:13:27 -0500
X-MC-Unique: vT3DTcw6Oken1yyTSN8fmg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-66d08175882so54859086d6.1
        for <acpica-devel@lists.linuxfoundation.org>; Mon, 13 Nov 2023 12:13:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699906407; x=1700511207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=vJ1XqZlRDmwigjyzm2p2pfyG/HS+H7G0Hge6FRHZeQPj8Sm9tTfE/sogdFKp+7rfhn
         7eWxjR99dY9oDXFIAzDBPRCMlrPF2cHlEHY3motCbyTG7AoCDnTKpNm7yfL1t71kXKaS
         XGCyAuTj6mIjxLwvVxcnYzZXirQ+y4kOLQ0UTLnfVXGK9ise2A/UyBbcGlBLARU1Y2nH
         CSOEHCAO1ukLsTR9DIu8K+OklTHusM2aSx2MlPEQqj+npXDAbguJVxxwsXUDxjAH2BVn
         wucGNbpCFrCCrs61dEh9qtXB2hw/2nzv1mJU64cjMzKuEMj9Oesx4p2g3VU8jh/d/x+G
         QcwA==
X-Gm-Message-State: AOJu0YwVr9dzudl54gN81lo9HzlEtdNx/1YdMDL3FVwtfI/MeqiogFXr
	BNUG/g9nIx3j+V5f1aevRt6v/xVqX/YWYuo9qRBseg+OtEu3gvfqgrmqKiqeyJronbZWXEib3z4
	WXp+vOgJakDGyE1tIsJxouvA1ZYtWRZIosoX78A==
X-Received: by 2002:ad4:4bad:0:b0:65b:2660:f577 with SMTP id i13-20020ad44bad000000b0065b2660f577mr248771qvw.3.1699906406572;
        Mon, 13 Nov 2023 12:13:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsDIxiixJLIxKwkxODRjUhycdO5JesTQ8JOYTeYOzxmk+ReEPp+gf8876uIJbrOmvoudG57Q==
X-Received: by 2002:ad4:4bad:0:b0:65b:2660:f577 with SMTP id i13-20020ad44bad000000b0065b2660f577mr248760qvw.3.1699906406355;
        Mon, 13 Nov 2023 12:13:26 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id c4-20020a05621401c400b006754772bfd4sm2302000qvt.21.2023.11.13.12.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:13:25 -0800 (PST)
Date: Mon, 13 Nov 2023 13:13:24 -0700
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
Subject: Re: [PATCH RFC 10/17] acpi: Do not use dev->iommu within
 acpi_iommu_configure()
Message-ID: <aqbuvpgu577fdpf4ndhoghfgewki7lg4hf2yewljonxf6y6oxv@xisq2p5bi3kb>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <10-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <10-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

