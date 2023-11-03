Return-Path: <jgg@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C83FE820EC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C4424820C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmE0NhIPVyfgk5oqoV569KUNfHY8bHemcOTponDtm+w=;
 b=L/OsCeKGNV/oDH+CnJPsnhvvLVq/l2ywYQbUZ3Q28jaMMKyVzG5LdPah6G+LR4z1WW6WzCMnb8uBN4JDbMKyCzeThgtG7v2rJuii1qbc1hoPY5Yqo5oJwM4cDyhKgSWtBm0qo7jdXfBWFR6irJ7QQAHbDqS9JUhY/B+h6UzZWjlOkqbOfMqu221KZKI2WDgQZk5dE+NQggXCUu45cDK6tCmqEp69n/KGZ3w0Xw2O17uDMLhs18YTlA/HiI+0WIsAosyKRno8FEzQCoZvj+FpZ2kMUz4FjLXlY8ZYTFVEOOe+hkuLNQ2Tcw8smJCQW8qarg3jR08WFk+lY0o5HOfoLg==
From: Jason Gunthorpe <jgg@nvidia.com>
Date: Fri,  3 Nov 2023 13:45:00 -0300
Message-ID: <15-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Acpica-devel] [PATCH RFC 15/17] iommu: Add ops->of_xlate_fwspec()
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

The new callback takes in the fwspec instead of retrieving it from the
dev->iommu. Provide iommu_fwspec_append_ids() to work directly on the
fwspec.

Convert SMMU, SMMUv3, and virtio to use iommu_fwspec_append_ids() and the
new entry point.

This avoids having to touch dev->iommu at all, and doesn't require the
iommu_probe_device_lock.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 +++++---
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 8 +++++---
 drivers/iommu/iommu.c                       | 3 +++
 drivers/iommu/virtio-iommu.c                | 8 +++++---
 include/linux/iommu.h                       | 3 +++
 5 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 7445454c2af244..b1309f04ebc0d9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2748,9 +2748,11 @@ static int arm_smmu_enable_nesting(struct iommu_domain *domain)
 	return ret;
 }
 
-static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
+static int arm_smmu_of_xlate_fwspec(struct iommu_fwspec *fwspec,
+				    struct device *dev,
+				    struct of_phandle_args *args)
 {
-	return iommu_fwspec_add_ids(dev, args->args, 1);
+	return iommu_fwspec_append_ids(fwspec, args->args, 1);
 }
 
 static void arm_smmu_get_resv_regions(struct device *dev,
@@ -2858,7 +2860,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.probe_device		= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
 	.device_group		= arm_smmu_device_group,
-	.of_xlate		= arm_smmu_of_xlate,
+	.of_xlate_fwspec	= arm_smmu_of_xlate_fwspec,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.remove_dev_pasid	= arm_smmu_remove_dev_pasid,
 	.dev_enable_feat	= arm_smmu_dev_enable_feature,
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 854efcb1b84ddf..8c4a60d8e5d522 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1510,7 +1510,9 @@ static int arm_smmu_set_pgtable_quirks(struct iommu_domain *domain,
 	return ret;
 }
 
-static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
+static int arm_smmu_of_xlate_fwspec(struct iommu_fwspec *fwspec,
+				    struct device *dev,
+				    struct of_phandle_args *args)
 {
 	u32 mask, fwid = 0;
 
@@ -1522,7 +1524,7 @@ static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	else if (!of_property_read_u32(args->np, "stream-match-mask", &mask))
 		fwid |= FIELD_PREP(ARM_SMMU_SMR_MASK, mask);
 
-	return iommu_fwspec_add_ids(dev, &fwid, 1);
+	return iommu_fwspec_append_ids(fwspec, &fwid, 1);
 }
 
 static void arm_smmu_get_resv_regions(struct device *dev,
@@ -1562,7 +1564,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.release_device		= arm_smmu_release_device,
 	.probe_finalize		= arm_smmu_probe_finalize,
 	.device_group		= arm_smmu_device_group,
-	.of_xlate		= arm_smmu_of_xlate,
+	.of_xlate_fwspec	= arm_smmu_of_xlate_fwspec,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.def_domain_type	= arm_smmu_def_domain_type,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d14438ffb0feb7..9f23e113f46bc7 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3000,6 +3000,9 @@ int iommu_fwspec_of_xlate(struct iommu_fwspec *fwspec, struct device *dev,
 	if (ret)
 		return ret;
 
+	if (fwspec->ops->of_xlate_fwspec)
+		return fwspec->ops->of_xlate_fwspec(fwspec, dev, iommu_spec);
+
 	if (!fwspec->ops->of_xlate)
 		return -ENODEV;
 
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 379ebe03efb6d4..2283f1d1155981 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1027,9 +1027,11 @@ static struct iommu_group *viommu_device_group(struct device *dev)
 		return generic_device_group(dev);
 }
 
-static int viommu_of_xlate(struct device *dev, struct of_phandle_args *args)
+static int viommu_of_xlate_fwspec(struct iommu_fwspec *fwspec,
+				  struct device *dev,
+				  struct of_phandle_args *args)
 {
-	return iommu_fwspec_add_ids(dev, args->args, 1);
+	return iommu_fwspec_append_ids(fwspec, args->args, 1);
 }
 
 static bool viommu_capable(struct device *dev, enum iommu_cap cap)
@@ -1050,7 +1052,7 @@ static struct iommu_ops viommu_ops = {
 	.release_device		= viommu_release_device,
 	.device_group		= viommu_device_group,
 	.get_resv_regions	= viommu_get_resv_regions,
-	.of_xlate		= viommu_of_xlate,
+	.of_xlate_fwspec	= viommu_of_xlate_fwspec,
 	.owner			= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev		= viommu_attach_dev,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5e1f9222bde856..2fac54a942af54 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -41,6 +41,7 @@ struct notifier_block;
 struct iommu_sva;
 struct iommu_fault_event;
 struct iommu_dma_cookie;
+struct iommu_fwspec;
 
 /* iommu fault flags */
 #define IOMMU_FAULT_READ	0x0
@@ -287,6 +288,8 @@ struct iommu_ops {
 	/* Request/Free a list of reserved regions for a device */
 	void (*get_resv_regions)(struct device *dev, struct list_head *list);
 
+	int (*of_xlate_fwspec)(struct iommu_fwspec *fwspec, struct device *dev,
+			       struct of_phandle_args *args);
 	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
 	bool (*is_attach_deferred)(struct device *dev);
 
-- 
2.42.0

