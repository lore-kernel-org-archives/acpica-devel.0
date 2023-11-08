Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04BB34CEC
	for <acpica-devel@lists.linuxfoundation.org>; Wed,  8 Nov 2023 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cLUTk3vz"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2118A81F1D
	for <acpica-devel@lists.linuxfoundation.org>; Wed,  8 Nov 2023 18:13:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2118A81F1D
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cLUTk3vz
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uj0imF6321Ow
	for <acpica-devel@lists.linuxfoundation.org>;
	Wed,  8 Nov 2023 18:13:02 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EF71881F14
	for <acpica-devel@lists.linuxfoundation.org>; Wed,  8 Nov 2023 18:13:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EF71881F14
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c5071165d5so95849421fa.0
        for <acpica-devel@lists.linuxfoundation.org>; Wed, 08 Nov 2023 10:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699467180; x=1700071980; darn=lists.linuxfoundation.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XyM6VQ+HEN7IzJJ5bMoPN5/yYHnG+EAx9sBxv2Z/Ai8=;
        b=cLUTk3vz9yEVmFTjR7xtAhGKu2mg2PnUgdXuUh1BZfjmznzW8Iadvty5mpChvsIhxj
         fbBuF8VVrXgPczXv8Ov2V/XFUuedN36ykKL6PFyR8Rq3LflTR+KmNT0RSmFZ3EdHqktC
         w0kFHbZueccsV22Ib97BdVQEXmotZbui0PqGYkYcNmz9FFKO4YD8jqD8w41b1UD0ch+r
         4w5kNU4MFHtyPArMvYh9Vdb+LMTz6/59p0LeUoL7cF5xb0wLU6nhBS66kBLycbiCBPT0
         dtWIQ1ppQqtWHXcVTEX83y3+GRpJifb25buwMwBjJfpGY0Je+0Bry6UL9RsvYZ2cmC2V
         q7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699467180; x=1700071980;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XyM6VQ+HEN7IzJJ5bMoPN5/yYHnG+EAx9sBxv2Z/Ai8=;
        b=woqsWQ7s+NRLOrx1NOcbe8wKnPJRsQGP3fDbdMT11SqD7PXrv4qnOSFuHOHKTXXVds
         iIvWXIZiLq7mVl/UHa63lHLjX60HHAbR1gGwKbg639dbs8U1LftcBcOADKPKjDwWY2GR
         fl4rjhsgdwYZlW26L5ibwuY+GRq+wmF+BkZaQxaiNkhOv7mBbEEqpNOCzPsfJmxX2lzb
         orGNc05A7bL17AwTmK0RzrSVwM/R6GeV0leflKwVTgqTwOS6w98qtTsA1FXt3y50xmDJ
         uU9St2JulRehtbKo6kHip7ESPoWcxaBlTv0UBPgr8aJpC8NhwBrZevc1rymSRRR/8fAs
         qL9w==
X-Gm-Message-State: AOJu0YxS0dH+c+55jgA4TZEcOjv4UV1Yuus4rS31Xw2f3Cw6p2OqaTQC
	ZJD6TjqiGdprrNebnsF/n1BA5w==
X-Google-Smtp-Source: AGHT+IEAPIM/7orU2/kUz+9e+TY8CYDTNJKLdVzPi+Pze4e6FKjzPA1Tq2W37LpeXm1IyotL7oPMlg==
X-Received: by 2002:a2e:8e7b:0:b0:2c5:582:fd8d with SMTP id t27-20020a2e8e7b000000b002c50582fd8dmr2179335ljk.30.1699467179768;
        Wed, 08 Nov 2023 10:12:59 -0800 (PST)
Received: from [10.1.1.118] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id d20-20020a05600c4c1400b003fd2d3462fcsm739766wmp.1.2023.11.08.10.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 10:12:58 -0800 (PST)
Message-ID: <e57f11915745674521b8c73d88a198a0b9c32c21.camel@linaro.org>
Subject: Re: [PATCH RFC 12/17] iommu: Make iommu_ops_from_fwnode() static
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Jason Gunthorpe <jgg@nvidia.com>,
 acpica-devel@lists.linuxfoundation.org,  Alyssa Rosenzweig
 <alyssa@rosenzweig.io>, Albert Ou <aou@eecs.berkeley.edu>,
 asahi@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>, Catalin Marinas
 <catalin.marinas@arm.com>,  Dexuan Cui <decui@microsoft.com>,
 devicetree@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,  Frank
 Rowand <frowand.list@gmail.com>, Hanjun Guo <guohanjun@huawei.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Christoph Hellwig <hch@lst.de>,
 iommu@lists.linux.dev,  Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-hyperv@vger.kernel.org,  linux-mips@vger.kernel.org,
 linux-riscv@lists.infradead.org,  linux-snps-arc@lists.infradead.org,
 linux-tegra@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Hector Martin <marcan@marcan.st>, Palmer
 Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore
 <robert.moore@intel.com>, Rob Herring <robh+dt@kernel.org>,  Robin Murphy
 <robin.murphy@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Suravee
 Suthikulpanit <suravee.suthikulpanit@amd.com>, Sven Peter
 <sven@svenpeter.dev>, Thierry Reding <thierry.reding@gmail.com>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Krishna Reddy
 <vdumpa@nvidia.com>, Vineet Gupta <vgupta@kernel.org>, 
 virtualization@lists.linux-foundation.org, Wei Liu <wei.liu@kernel.org>,
 Will Deacon <will@kernel.org>
Cc: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Date: Wed, 08 Nov 2023 18:12:56 +0000
In-Reply-To: <12-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References: <12-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4-1 
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jason,

On Fri, 2023-11-03 at 13:44 -0300, Jason Gunthorpe wrote:
> There are no external callers now.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
> =C2=A0drivers/iommu/iommu.c | 3 ++-
> =C2=A0include/linux/iommu.h | 6 ------
> =C2=A02 files changed, 2 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 62c82a28cd5db3..becd1b881e62dc 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2945,7 +2945,8 @@ bool iommu_default_passthrough(void)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(iommu_default_passthrough);
> =C2=A0
> -const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle
> *fwnode)
> +static const struct iommu_ops *
> +iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct iommu_ops *o=
ps =3D NULL;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iommu_device *iomm=
u;
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 27e4605d498850..37948eee8d7394 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -701,7 +701,6 @@ static inline void iommu_fwspec_free(struct
> device *dev)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->iommu->fwspec =3D NU=
LL;
> =C2=A0}
> =C2=A0int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)=
;
> -const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle
> *fwnode);
> =C2=A0int iommu_fwspec_append_ids(struct iommu_fwspec *fwspec, u32 *ids,
> int num_ids);
> =C2=A0
> =C2=A0static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct
> device *dev)
> @@ -1044,11 +1043,6 @@ static inline int iommu_fwspec_add_ids(struct
> device *dev, u32 *ids,
> =C2=A0}
> =C2=A0
> =C2=A0static inline
> -const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle
> *fwnode)
> -{
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return NULL;
> -}
> -
> =C2=A0static inline int
> =C2=A0iommu_dev_enable_feature(struct device *dev, enum iommu_dev_feature=
s
> feat)

This leaves the extra line with 'static inline', it should also be
removed.

Cheers,
Andre'

