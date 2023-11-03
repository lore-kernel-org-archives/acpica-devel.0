Return-Path: <jgg@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C21F140123
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DCFB14012B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PPs0isl+3c2oxqrW7MT5Ff1zFSIMTNVaxMmUPjPXsc=;
 b=r9ozleM2+soDLIOUHJ4VZtKEei+18qw1cnd1jP48P4Xf3cyChHTROFexg/DccaPi/LzTjijwyITf7mVjnelT+vYXFpL0/IILmKLeKr5xnFTi9HxJ9H55W8lgQw2G11yfQFgr8GryROJknh/PM7+MjgMpXMs+bXtpFYb8LY2f62dbyVKAa+1P89IA9jpomdIJK4hursykynwHu7OfGe0liCEpmORGpJCpaUCnuMEhw39lNEHaY+r56+wlzc5pfX3ucTt97O4hIZ0TD6OlJtdVVDlqAXHHW2UfDfxs1AXlFYeh/lUHD2cp9W74VPwx2GNYvYcZQSNqwrsYpRaeuvl77A==
From: Jason Gunthorpe <jgg@nvidia.com>
Date: Fri,  3 Nov 2023 13:44:58 -0300
Message-ID: <13-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Acpica-devel] [PATCH RFC 13/17] iommu: Remove
	dev_iommu_fwspec_set()
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: acpica-devel@lists.linuxfoundation.org, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>, Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Frank Rowand <frowand.list@gmail.com>, Hanjun Guo <guohanjun@huawei.com>, Haiyang Zhang <haiyangz@microsoft.com>, Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev, Jean-Philippe Brucker <jean-philippe@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org, linux-tegra@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Hector Martin <marcan@marcan.st>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore <robert.moore@intel.com>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Sven Peter <sven@svenpeter.dev>, Thierry Reding <thierry.reding@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Krishna Reddy <vdumpa@nvidia.com>, Vineet Gupta <vgupta@kernel.org>, virtualization@lists.linux-foundation.org, Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>
Cc: Zhenhua Huang <quic_zhenhuah@quicinc.com>

This is only used internally to iommu.c now, get rid of it to discourage
things outside iommu.c from trying to manipulate dev->iommu->fwspec.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 2 +-
 include/linux/iommu.h | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index becd1b881e62dc..d14438ffb0feb7 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3068,7 +3068,7 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		return ret;
 	}
 
-	dev_iommu_fwspec_set(dev, fwspec);
+	dev->iommu->fwspec = fwspec;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_init);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 37948eee8d7394..5e1f9222bde856 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -711,12 +711,6 @@ static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
 		return NULL;
 }
 
-static inline void dev_iommu_fwspec_set(struct device *dev,
-					struct iommu_fwspec *fwspec)
-{
-	dev->iommu->fwspec = fwspec;
-}
-
 static inline void *dev_iommu_priv_get(struct device *dev)
 {
 	if (dev->iommu)
-- 
2.42.0

