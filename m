Return-Path: <jgg@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 13CF640123
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D381C4011A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QP10aZ4Quqbs9zFZPRTR3Au32TdVHu3cIHkvtTh4E+8=;
 b=J9+NTAilQwoRv4xPnDjJGuV/J6siGnMvKC6xLsXvMQvWwAOaEunZ28w1bXLQ8fsWgE7jyie8ZWFtvvngPBzcyRP8bJvojqRLOB4YteOxL0pjjIwSZ5AT0HHrQKwGGtdQd5JPxYrfrbCRQLxWMGCSFq0qamfBYfrs+4ZgF2Hzpq40OGHdF67FFpIiPnrTPhz++7QpsxlnlUBhwuwbeC5e7bkAGGKQ8yGQl60YFnz+FF60HJL3WHCX4Ux+RLEbxkjsOhnZdi97Iw8HzlicFl0tAtu3SaMWuxC7HBNvVkZ+WRgyPQ84UfAKVJ48BS7oNTWi8EjBYTj8KM0qJtpBMbtlcQ==
From: Jason Gunthorpe <jgg@nvidia.com>
Date: Fri,  3 Nov 2023 13:44:50 -0300
Message-ID: <5-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Acpica-devel] [PATCH RFC 05/17] iommu: Make iommu_fwspec->ids a
	distinct allocation
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

The optimization of kreallocing the entire fwspec only works if the fwspec
pointer is always stored in the dev->iommu. Since we want to change this
remove the optimization and make the ids array a distinct allocation.

Allow a single id to be stored inside the iommu_fwspec as a common case
optimization.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 20 ++++++++++++--------
 include/linux/iommu.h |  3 ++-
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c9a05bb49bfa17..d5e86985f6d363 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2948,8 +2948,7 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 	if (!dev_iommu_get(dev))
 		return -ENOMEM;
 
-	/* Preallocate for the overwhelmingly common case of 1 ID */
-	fwspec = kzalloc(struct_size(fwspec, ids, 1), GFP_KERNEL);
+	fwspec = kzalloc(sizeof(*fwspec), GFP_KERNEL);
 	if (!fwspec)
 		return -ENOMEM;
 
@@ -2982,13 +2981,18 @@ int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 		return -EINVAL;
 
 	new_num = fwspec->num_ids + num_ids;
-	if (new_num > 1) {
-		fwspec = krealloc(fwspec, struct_size(fwspec, ids, new_num),
-				  GFP_KERNEL);
-		if (!fwspec)
+	if (new_num <= 1) {
+		if (fwspec->ids != &fwspec->single_id)
+			kfree(fwspec->ids);
+		fwspec->ids = &fwspec->single_id;
+	} else if (new_num > fwspec->num_ids) {
+		ids = krealloc_array(
+			fwspec->ids != &fwspec->single_id ? fwspec->ids : NULL,
+			new_num, sizeof(fwspec->ids[0]),
+			GFP_KERNEL | __GFP_ZERO);
+		if (!ids)
 			return -ENOMEM;
-
-		dev_iommu_fwspec_set(dev, fwspec);
+		fwspec->ids = ids;
 	}
 
 	for (i = 0; i < num_ids; i++)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ddc25d2391063b..66ea1d08dc3f58 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -668,7 +668,8 @@ struct iommu_fwspec {
 	struct fwnode_handle	*iommu_fwnode;
 	u32			flags;
 	unsigned int		num_ids;
-	u32			ids[];
+	u32			single_id;
+	u32			*ids;
 };
 
 /* ATS is supported */
-- 
2.42.0

