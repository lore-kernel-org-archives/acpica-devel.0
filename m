Return-Path: <jgg@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 41D7C400AB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F220C40108
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JQ35AEWNWv/xnhSZvoDLuDgdERnHhd761qmfhbRcko=;
 b=uMyAI9kXWURKRrrES7AJYqdKq2xNWc/zSYnSL4zOW6qu+Qe57xhdcvwwjr62jOq5LsSviMt/OGuS2FujKBC6DylhIKtpw36e9j8OMSxWcnXY1Pnw6ZIAPUGquvOC+ecNBKMeb2nDmembE/LkVD6S01x+GW19OyWLqnFUx48Vchw2VuFIbjUAruXYr3kKh/En0j3cdQQaGHm73/4ocznuSzJ6X3uJaRfh6LQ3G2sANuKffVftVsBF7zV5c+UAiHazmeeq4hQezIQj+EDW4hCgxxBq2paPF6RA92rU5gNgBXCDVram7FzgGKf2DQUxDPiOHKLgnilytk5+uHomP1FNYw==
From: Jason Gunthorpe <jgg@nvidia.com>
Date: Fri,  3 Nov 2023 13:44:51 -0300
Message-ID: <6-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Acpica-devel] [PATCH RFC 06/17] iommu: Add
	iommu_fwspec_alloc/dealloc()
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

Allow fwspec to exist independently from the dev->iommu by providing
functions to allow allocating and freeing the raw struct iommu_fwspec.

Reflow the existing paths to call the new alloc/dealloc functions.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 82 ++++++++++++++++++++++++++++++++-----------
 include/linux/iommu.h | 11 +++++-
 2 files changed, 72 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d5e86985f6d363..46f3d19a1291b0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -361,10 +361,8 @@ static void dev_iommu_free(struct device *dev)
 	struct dev_iommu *param = dev->iommu;
 
 	dev->iommu = NULL;
-	if (param->fwspec) {
-		fwnode_handle_put(param->fwspec->iommu_fwnode);
-		kfree(param->fwspec);
-	}
+	if (param->fwspec)
+		iommu_fwspec_dealloc(param->fwspec);
 	kfree(param);
 }
 
@@ -2937,10 +2935,61 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 	return ops;
 }
 
+static int iommu_fwspec_assign_iommu(struct iommu_fwspec *fwspec,
+				     struct device *dev,
+				     struct fwnode_handle *iommu_fwnode)
+{
+	const struct iommu_ops *ops;
+
+	if (fwspec->iommu_fwnode) {
+		/*
+		 * fwspec->iommu_fwnode is the first iommu's fwnode. In the rare
+		 * case of multiple iommus for one device they must point to the
+		 * same driver, checked via same ops.
+		 */
+		ops = iommu_ops_from_fwnode(iommu_fwnode);
+		if (fwspec->ops != ops)
+			return -EINVAL;
+		return 0;
+	}
+
+	if (!fwspec->ops) {
+		ops = iommu_ops_from_fwnode(iommu_fwnode);
+		if (!ops)
+			return driver_deferred_probe_check_state(dev);
+		fwspec->ops = ops;
+	}
+
+	of_node_get(to_of_node(iommu_fwnode));
+	fwspec->iommu_fwnode = iommu_fwnode;
+	return 0;
+}
+
+struct iommu_fwspec *iommu_fwspec_alloc(void)
+{
+	struct iommu_fwspec *fwspec;
+
+	fwspec = kzalloc(sizeof(*fwspec), GFP_KERNEL);
+	if (!fwspec)
+		return ERR_PTR(-ENOMEM);
+	return fwspec;
+}
+
+void iommu_fwspec_dealloc(struct iommu_fwspec *fwspec)
+{
+	if (!fwspec)
+		return;
+
+	if (fwspec->iommu_fwnode)
+		fwnode_handle_put(fwspec->iommu_fwnode);
+	kfree(fwspec);
+}
+
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		      const struct iommu_ops *ops)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	int ret;
 
 	if (fwspec)
 		return ops == fwspec->ops ? 0 : -EINVAL;
@@ -2948,29 +2997,22 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 	if (!dev_iommu_get(dev))
 		return -ENOMEM;
 
-	fwspec = kzalloc(sizeof(*fwspec), GFP_KERNEL);
-	if (!fwspec)
-		return -ENOMEM;
+	fwspec = iommu_fwspec_alloc();
+	if (IS_ERR(fwspec))
+		return PTR_ERR(fwspec);
 
-	of_node_get(to_of_node(iommu_fwnode));
-	fwspec->iommu_fwnode = iommu_fwnode;
 	fwspec->ops = ops;
+	ret = iommu_fwspec_assign_iommu(fwspec, dev, iommu_fwnode);
+	if (ret) {
+		iommu_fwspec_dealloc(fwspec);
+		return ret;
+	}
+
 	dev_iommu_fwspec_set(dev, fwspec);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_init);
 
-void iommu_fwspec_free(struct device *dev)
-{
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-
-	if (fwspec) {
-		fwnode_handle_put(fwspec->iommu_fwnode);
-		kfree(fwspec);
-		dev_iommu_fwspec_set(dev, NULL);
-	}
-}
-EXPORT_SYMBOL_GPL(iommu_fwspec_free);
 
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 66ea1d08dc3f58..b827dd6a5844b0 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -683,9 +683,18 @@ struct iommu_sva {
 	struct iommu_domain		*domain;
 };
 
+struct iommu_fwspec *iommu_fwspec_alloc(void);
+void iommu_fwspec_dealloc(struct iommu_fwspec *fwspec);
+
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		      const struct iommu_ops *ops);
-void iommu_fwspec_free(struct device *dev);
+static inline void iommu_fwspec_free(struct device *dev)
+{
+	if (!dev->iommu)
+		return;
+	iommu_fwspec_dealloc(dev->iommu->fwspec);
+	dev->iommu->fwspec = NULL;
+}
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
 const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
 
-- 
2.42.0

