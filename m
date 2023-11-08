Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75864358A2
	for <acpica-devel@lists.linuxfoundation.org>; Wed,  8 Nov 2023 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dsn5Ek11"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E5BB661046
	for <acpica-devel@lists.linuxfoundation.org>; Wed,  8 Nov 2023 18:35:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E5BB661046
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Dsn5Ek11
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wGV5NlPyJ3dq
	for <acpica-devel@lists.linuxfoundation.org>;
	Wed,  8 Nov 2023 18:35:04 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C697E60ACD
	for <acpica-devel@lists.linuxfoundation.org>; Wed,  8 Nov 2023 18:35:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C697E60ACD
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40790b0a224so53676205e9.0
        for <acpica-devel@lists.linuxfoundation.org>; Wed, 08 Nov 2023 10:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699468502; x=1700073302; darn=lists.linuxfoundation.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n9ZiV2Esj98CTfgH59OBDcgahkXqDMdEC5lhTkmlSa0=;
        b=Dsn5Ek11Y1G65kP4nMlXiEqVx5iTyIkYIjQKvVyXtbCRF8/mqjmTWlmkBS59sI28Ff
         g+rd7+ntFQeDZXb9BoUnBhPq9gMSAfCLrSL265tbXfbGr584pwn3ebJ7XEuBFtJyt6zV
         JM++yiib98RMDoKN2L/L/AjK/kUPWRNnRvd5fZ/rdUXeFFLvxtcriOxEZ7ALrUkT75dU
         E/eleg3dzhPL7mGcaFCQScoFuDG5JGJYuxa4uHkdS7x7l2ZUj63nCxPUTT9+ZAg2Hbj1
         gexONKrpvXkiB7UQw/ycY/Otfytmv0K+sH1nkWBRnFx0Rf3Lc/OJyDcva+dLMa1E/YL8
         tGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699468502; x=1700073302;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n9ZiV2Esj98CTfgH59OBDcgahkXqDMdEC5lhTkmlSa0=;
        b=Ke0dKmFFtMiGHHhO1O8DWls3DVmZg9Ifg9YF7ArRmI0099tBwZL9QDiSviA+WyAz8P
         oBIiJx4ua1zKuS7S+A7/0xrFuBGsikElVr5OtEhCy6SXGFvdlrel/3QWEMWx5Wsl+aM3
         T7tvjiFtMCtOqxSeNLkqW6g33rodYqmRhoArSnhjHqgWGFEDw1J4UGbIb7/KnVv/yBTh
         lzYqPgVYRGkCspjy1ty8ecpEiCbJ6Ifj+d/FrZd6TPBC27Eb+3vgNzz0x7ZtOtbL/W2b
         gsWKy6/ozq5BXJq0GbrRodbYoNip8dHohwEzY8ENUzufzSDCDyXzV7Lnaco/Pm9DFwbo
         7RGA==
X-Gm-Message-State: AOJu0Yw6LJ9BEoMRjRoVnzhF3ooE7htasQKNqYSmeMGkfDREKMPwsM1s
	Z9+6WM0ndv/MDRXxw/3Rhk+/bA==
X-Google-Smtp-Source: AGHT+IEerzRoblFu8LqWqAyQVzl32Dow78v7sZDoe2sPpmQgBWRRfSrEcftCpyNmsXV1yimnvtHQ6A==
X-Received: by 2002:a05:600c:190e:b0:405:1c19:b747 with SMTP id j14-20020a05600c190e00b004051c19b747mr2262734wmq.15.1699468501866;
        Wed, 08 Nov 2023 10:35:01 -0800 (PST)
Received: from salami.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id g4-20020a05600c310400b004068e09a70bsm20156528wmo.31.2023.11.08.10.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 10:35:00 -0800 (PST)
Message-ID: <d6664edcccd81edc5caa54e8da43b5c571a3ea76.camel@linaro.org>
Subject: Re: [PATCH RFC 00/17] Solve iommu probe races around iommu_fwspec
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Zhenhua Huang <quic_zhenhuah@quicinc.com>, 
 acpica-devel@lists.linuxfoundation.org, Alyssa Rosenzweig
 <alyssa@rosenzweig.io>,  Albert Ou <aou@eecs.berkeley.edu>,
 asahi@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,  Catalin
 Marinas <catalin.marinas@arm.com>, Dexuan Cui <decui@microsoft.com>,
 devicetree@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Frank
 Rowand <frowand.list@gmail.com>, Hanjun Guo <guohanjun@huawei.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Christoph Hellwig <hch@lst.de>,
 iommu@lists.linux.dev, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, "K.
 Y. Srinivasan" <kys@microsoft.com>,  Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org, 
 linux-tegra@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Hector Martin <marcan@marcan.st>, Palmer
 Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore
 <robert.moore@intel.com>, Rob Herring <robh+dt@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Suravee
 Suthikulpanit <suravee.suthikulpanit@amd.com>, Sven Peter
 <sven@svenpeter.dev>, Thierry Reding <thierry.reding@gmail.com>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>,  Krishna Reddy
 <vdumpa@nvidia.com>, Vineet Gupta <vgupta@kernel.org>, 
 virtualization@lists.linux-foundation.org, Wei Liu <wei.liu@kernel.org>,
 Will Deacon <will@kernel.org>
Date: Wed, 08 Nov 2023 18:34:58 +0000
In-Reply-To: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1-1 
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jason,

On Fri, 2023-11-03 at 13:44 -0300, Jason Gunthorpe wrote:
> This is a more complete solution that the first attempt here:
> https://lore.kernel.org/r/1698825902-10685-1-git-send-email-quic_zhenhuah=
@quicinc.com
>=20
> I haven't been able to test this on any HW that touches these paths, so i=
f
> some people with HW can help get it in shape it can become non-RFC.

Thank you for this series.

Please note that we're also observing this issue on 6.1.
I think this series is a good candidate for a back port (slightly complicat=
ed by
the fact that various refactors have happened since).

For me, it's working fine so far on master, and I've also done my own back =
port
to 6.1 and am currently testing both. An official back port once finalised
could be useful, though :-)


Cheers,
Andre'

