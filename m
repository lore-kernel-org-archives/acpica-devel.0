Return-Path: <jgg@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 65AEF400AB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 303274011A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiuB3Wvk72iR9li9Kvdx0Wd/AMHJDjh4+qRdzb4+xX0=;
 b=rSkGFmlM9ePXKxq5v/5VG4NOAO0EYDcXDGhGNhUFPgxeJx65+M3CGocihlI7kEktKbol+RTI/S2wEBrvFKfjs9utLP0x88SM4p6AcskQ6kOKcnFGk628AtCLChzL56LJBIvcSSUJVqDvqIf822Re3Q9TZElkzoX+sl5IUjwz+12xxzufBk0hR1j99nxAmwJfWrOMqbqttNbYsE4LRuSTvT3+qfdMON4q6MPHUOx+KfZ80Uf2v59EJlu1EMVmMCEAJ45L87V6zXbBdR8evsAGQ7gPtBZ+AYjgxlghj4R4KEDiUgSkPjqgK1v/7l1ed1lavhDF49zZ/9cG0u0pwDi0Hg==
From: Jason Gunthorpe <jgg@nvidia.com>
Date: Fri,  3 Nov 2023 13:44:54 -0300
Message-ID: <9-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Acpica-devel] [PATCH RFC 09/17] iommu: Add
	iommu_fwspec_append_ids()
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

This is a version of iommu_fwspec_add_ids() that takes in the fwspec as an
argument instead of getting it through dev->iommu.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 17 +++++++++++------
 include/linux/iommu.h |  1 +
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ad2963d69a0538..15dbe2d9eb24c2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3067,15 +3067,10 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_init);
 
-
-int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
+int iommu_fwspec_append_ids(struct iommu_fwspec *fwspec, u32 *ids, int num_ids)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	int i, new_num;
 
-	if (!fwspec)
-		return -EINVAL;
-
 	new_num = fwspec->num_ids + num_ids;
 	if (new_num <= 1) {
 		if (fwspec->ids != &fwspec->single_id)
@@ -3097,6 +3092,16 @@ int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 	fwspec->num_ids = new_num;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(iommu_fwspec_append_ids);
+
+int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
+	if (!fwspec)
+		return -EINVAL;
+	return iommu_fwspec_append_ids(fwspec, ids, num_ids);
+}
 EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
 
 /*
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2644c61b572b8f..c5a5e2b5e2cc2a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -700,6 +700,7 @@ static inline void iommu_fwspec_free(struct device *dev)
 }
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
 const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
+int iommu_fwspec_append_ids(struct iommu_fwspec *fwspec, u32 *ids, int num_ids);
 
 static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
 {
-- 
2.42.0

