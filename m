Return-Path: <jgg@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C21B1400AB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8AD7E40123
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NI7RAIKRcJ5qH/Il69MCPxVy1cLdUTnarPzV/9bS8I=;
 b=tqLtCRAwe6sfgccaKzIHotgmbvBLI4baib7Tt1tmNyfR0kG80I93uGUn4WsP657356RbxWl0v+k/tpZkz0HDOCwf0CN3YgTdpuJu8QuAcezPsQyz4p2XrYnqelsCL3ApB6bG3oaXzS6eL14uW+mLmtfQ+nMs/dVuXs/f6xyqrmhEUG2BnTqm3YZZtgMDfeIMuQvkwAbK4AZBgZ+PCrH+iDiI8AVakOifI+rxfQDte6KQpN20+DbBvsxaKtIQ6pMbfpO66zdrQiuf4L64dPFy/F7g3QT56j1BuaQmo3DTNoYbJq/7g2XguqaYXPPLl2blKNHLdbX6buhN6d9K55AiLA==
From: Jason Gunthorpe <jgg@nvidia.com>
Date: Fri,  3 Nov 2023 13:44:47 -0300
Message-ID: <2-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Acpica-devel] [PATCH RFC 02/17] of: Do not return struct iommu_ops
	from of_iommu_configure()
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

Nothing needs this pointer. Return a normal error code with the usual
IOMMU semantic that ENODEV means 'there is no IOMMU driver'.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/of_iommu.c | 29 ++++++++++++++++++-----------
 drivers/of/device.c      | 22 +++++++++++++++-------
 include/linux/of_iommu.h | 13 ++++++-------
 3 files changed, 39 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 157b286e36bf3a..e2fa29c16dd758 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -107,20 +107,26 @@ static int of_iommu_configure_device(struct device_node *master_np,
 		      of_iommu_configure_dev(master_np, dev);
 }
 
-const struct iommu_ops *of_iommu_configure(struct device *dev,
-					   struct device_node *master_np,
-					   const u32 *id)
+/*
+ * Returns:
+ *  0 on success, an iommu was configured
+ *  -ENODEV if the device does not have any IOMMU
+ *  -EPROBEDEFER if probing should be tried again
+ *  -errno fatal errors
+ */
+int of_iommu_configure(struct device *dev, struct device_node *master_np,
+		       const u32 *id)
 {
 	const struct iommu_ops *ops = NULL;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	int err = NO_IOMMU;
 
 	if (!master_np)
-		return NULL;
+		return -ENODEV;
 
 	if (fwspec) {
 		if (fwspec->ops)
-			return fwspec->ops;
+			return 0;
 
 		/* In the deferred case, start again from scratch */
 		iommu_fwspec_free(dev);
@@ -163,14 +169,15 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 		err = iommu_probe_device(dev);
 
 	/* Ignore all other errors apart from EPROBE_DEFER */
-	if (err == -EPROBE_DEFER) {
-		ops = ERR_PTR(err);
-	} else if (err < 0) {
+	if (err < 0) {
+		if (err == -EPROBE_DEFER)
+			return err;
 		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
-		ops = NULL;
+		return -ENODEV;
 	}
-
-	return ops;
+	if (!ops)
+		return -ENODEV;
+	return 0;
 }
 
 static enum iommu_resv_type __maybe_unused
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 65c71be71a8d45..873d933e8e6d1d 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -93,12 +93,12 @@ of_dma_set_restricted_buffer(struct device *dev, struct device_node *np)
 int of_dma_configure_id(struct device *dev, struct device_node *np,
 			bool force_dma, const u32 *id)
 {
-	const struct iommu_ops *iommu;
 	const struct bus_dma_region *map = NULL;
 	struct device_node *bus_np;
 	u64 dma_start = 0;
 	u64 mask, end, size = 0;
 	bool coherent;
+	int iommu_ret;
 	int ret;
 
 	if (np == dev->of_node)
@@ -181,21 +181,29 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 	dev_dbg(dev, "device is%sdma coherent\n",
 		coherent ? " " : " not ");
 
-	iommu = of_iommu_configure(dev, np, id);
-	if (PTR_ERR(iommu) == -EPROBE_DEFER) {
+	iommu_ret = of_iommu_configure(dev, np, id);
+	if (iommu_ret == -EPROBE_DEFER) {
 		/* Don't touch range map if it wasn't set from a valid dma-ranges */
 		if (!ret)
 			dev->dma_range_map = NULL;
 		kfree(map);
 		return -EPROBE_DEFER;
-	}
+	} else if (iommu_ret == -ENODEV) {
+		dev_dbg(dev, "device is not behind an iommu\n");
+	} else if (iommu_ret) {
+		dev_err(dev, "iommu configuration for device failed with %pe\n",
+			ERR_PTR(iommu_ret));
 
-	dev_dbg(dev, "device is%sbehind an iommu\n",
-		iommu ? " " : " not ");
+		/*
+		 * Historically this routine doesn't fail driver probing
+		 * due to errors in of_iommu_configure()
+		 */
+	} else
+		dev_dbg(dev, "device is behind an iommu\n");
 
 	arch_setup_dma_ops(dev, dma_start, size, coherent);
 
-	if (!iommu)
+	if (iommu_ret)
 		of_dma_set_restricted_buffer(dev, np);
 
 	return 0;
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index 9a5e6b410dd2fb..e61cbbe12dac6f 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -8,20 +8,19 @@ struct iommu_ops;
 
 #ifdef CONFIG_OF_IOMMU
 
-extern const struct iommu_ops *of_iommu_configure(struct device *dev,
-					struct device_node *master_np,
-					const u32 *id);
+extern int of_iommu_configure(struct device *dev, struct device_node *master_np,
+			      const u32 *id);
 
 extern void of_iommu_get_resv_regions(struct device *dev,
 				      struct list_head *list);
 
 #else
 
-static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
-					 struct device_node *master_np,
-					 const u32 *id)
+static inline int of_iommu_configure(struct device *dev,
+				     struct device_node *master_np,
+				     const u32 *id)
 {
-	return NULL;
+	return -ENODEV;
 }
 
 static inline void of_iommu_get_resv_regions(struct device *dev,
-- 
2.42.0

