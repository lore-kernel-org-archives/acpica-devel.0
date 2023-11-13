Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828832420D
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 13 Nov 2023 20:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hm4gRkCB"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 32E754174F
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 13 Nov 2023 20:12:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 32E754174F
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hm4gRkCB
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0TI24nWN6HZa
	for <acpica-devel@lists.linuxfoundation.org>;
	Mon, 13 Nov 2023 20:12:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C6B5441704
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 13 Nov 2023 20:12:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C6B5441704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699906357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
	b=Hm4gRkCBuIO9rmOii3qGBKiY2plZL5PcCwmmp7SN/T+J1tLfgYnvCmGz43FSmkwPF+dJy5
	PM14dTgEOMqc+QehedM7btPN5Gl5eHElUYTKgE773fxtgBZAWjHT58+n5vNsku8UeDHKX2
	pi/oCIxSWN25n2Dzg4bgjkKK/7D5C0E=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-mvwyZMtoNBCLdGBK469Bew-1; Mon, 13 Nov 2023 15:12:36 -0500
X-MC-Unique: mvwyZMtoNBCLdGBK469Bew-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-5a7bbe0a453so56655567b3.0
        for <acpica-devel@lists.linuxfoundation.org>; Mon, 13 Nov 2023 12:12:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699906356; x=1700511156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=Yqx973kYpmDMBxk3zVO2mDbm6ndeP/fbECVj4Ifl3ZMPhLPOAdKNqOdiEEr0nwDK5K
         96BHH0BwxHESQbZgddsP67TnJ2g+X3WBVvhXH/YQ3Q33UaiOysyHdfdtf85famT58cEQ
         p+dph32TvSD4PqbTKYe1tkeK/PcTZpMAKs9kstERJjX3RSAJ+6esTs2//Yw8OWemWEiT
         eyG19asUM3J5P11MgcS6X1C2+1UgabYzFmouFKNqIbC6o87QWlTkSskPfFWkyA6Uu6Tp
         BLfSj/C9F6gFl0jkk95/9eiG9Ykic5EClCQ0g4q4aAjj4Q4vif1EYZ2vECt5ODCPJyHo
         tuew==
X-Gm-Message-State: AOJu0YxxwoWuwo6wgIFsxnbpdurWbG1wfZfDUF++pgzCIwN5T8Z7Hrhf
	ym2SrXAgIVqYa7KFnYweK10r9x7z1BaHo2lIjOS2FYNb29Zey6TUNAZuMt7R62OOgRb4tdZfBVh
	u1WIq+aBXjl1H9stDRZToEHwwVWeEwn2ktmuhyA==
X-Received: by 2002:a81:a1c8:0:b0:5a7:b8e6:6441 with SMTP id y191-20020a81a1c8000000b005a7b8e66441mr5681661ywg.16.1699906356193;
        Mon, 13 Nov 2023 12:12:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8TAFaS4ERYYFs+8jp6ZPsOwc5cP1r90IboZbxfRfwy6gwcqiZWRR9jIiN36BiWY+6zJFv5g==
X-Received: by 2002:a81:a1c8:0:b0:5a7:b8e6:6441 with SMTP id y191-20020a81a1c8000000b005a7b8e66441mr5681632ywg.16.1699906355905;
        Mon, 13 Nov 2023 12:12:35 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id a10-20020a0dd80a000000b005a7ba08b2acsm1972894ywe.0.2023.11.13.12.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:12:35 -0800 (PST)
Date: Mon, 13 Nov 2023 13:12:34 -0700
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
Subject: Re: [PATCH RFC 09/17] iommu: Add iommu_fwspec_append_ids()
Message-ID: <xv2544jtubq5aefvzaiabazmz5uf32alw6blcdbvsui6wn37ep@vpykzk2vvyp5>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <9-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <9-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

