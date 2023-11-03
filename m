Return-Path: <jsnitsel@redhat.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D379540343
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DE8B84013A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699041891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1OzQ+mysgekhlmn5TVv8N1n5lIKYQ3IFVh9mWG/eO8g=;
 b=CWPZTF6e9gNQZ5SbNMwXE4KXKeOBYiCRrfnCLJSfh4Y1EnbuJE3hPInbVV6/MjikM5YPFH
 JJSf+SFgLJekz/9hRmbUq0Gfyk2u07bjkW/fIgZEoV4VDHjfEsIhKU90xthBNfRiklPHUs
 Hln0z2wpBbJwPeYLFkoEKHd/kI3WUFk=
Date: Fri, 3 Nov 2023 13:04:47 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
Message-ID: <zrelyki44xy2jfqse2op5jjddnejbg4zpysvdkfx6ty2ylcjzw@ynuastkbx4kp>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <1-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <1-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [Acpica-devel] [PATCH RFC 01/17] iommu: Remove struct iommu_ops
 *iommu from arch_setup_dma_ops()
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-hyperv@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Robert Moore <robert.moore@intel.com>, Thierry Reding <thierry.reding@gmail.com>, Hanjun Guo <guohanjun@huawei.com>, acpica-devel@lists.linuxfoundation.org, "K. Y. Srinivasan" <kys@microsoft.com>, Frank Rowand <frowand.list@gmail.com>, Christoph Hellwig <hch@lst.de>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Marek Szyprowski <m.szyprowski@samsung.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, Dexuan Cui <decui@microsoft.com>, Russell King <linux@armlinux.org.uk>, linux-riscv@lists.infradead.org, Jonathan Hunter <jonathanh@nvidia.com>, linux-acpi@vger.kernel.org, iommu@lists.linux.dev, Vineet Gupta <vgupta@kernel.org>, linux-snps-arc@lists.infradead.org, Len Brown <lenb@kernel.org>, devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>, Sven Peter <sven@svenpeter.dev>, Haiyang Zhang <haiyangz@microsoft.com>, Krishna Reddy <vdumpa@nvidia.com>, Rob Herring <robh+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Robin Murphy <robin.murphy@arm.com>, Zhenhua Huang <quic_zhenhuah@quicinc.com>, Hector Martin <marcan@marcan.st>, linux-mips@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, asahi@lists.linux.dev, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Sudeep Holla <sudeep.holla@arm.com>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>



Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

