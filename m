Return-Path: <jgg@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C14CC40123
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8B44540129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0N3UjEeMLLLJeEcMRxl+2AVCyMLY2lxA+HXUiMeqqxY=;
 b=nQ10BXo3foZ7VKHpk5Sd2L0jFiO6PuawDJImHvAosJlMPsMzKI4LitTjlbnebZ0pf23do2RZRbSMy6B5AaMk4RRppalAcLM0bqDPPCeQ1Ywm9UeZD9NEDN4LLkZ9RHj0+imwL/WCN0saTPErXTTIGHOW4Gj4RcNSsY+pnGZux5x0G5Hs7klcJCgChPLRAS16QUnuWSaeAot42/wPPQldk2AaTNTG1yC1vE+iQj4AFYiJDPkHCYM/SvEXkdcVeyhC7Pp63yg0IED1tJl+mEHtZWDYBGI9OnpsfGHwtx8PTqROxdBqJvpOOeJX+Uir7vnQFsbsgtbutXk9tm0fJbzcgw==
From: Jason Gunthorpe <jgg@nvidia.com>
Date: Fri,  3 Nov 2023 13:44:53 -0300
Message-ID: <8-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Acpica-devel] [PATCH RFC 08/17] of: Do not use dev->iommu within
	of_iommu_configure()
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

This call chain is using dev->iommu->fwspec to pass around the fwspec
between the three parts (of_iommu_configure(), of_iommu_xlate(),
iommu_probe_device()).

However there is no locking around the accesses to dev->iommu, so this is
all racy.

Allocate a clean, local, fwspec at the start of of_iommu_configure(), pass
it through all functions on the stack to fill it with data, and finally
pass it into iommu_probe_device_fwspec() which will load it into
dev->iommu under a lock.

Move the actual call to ops->of_xlate into the core code under
iommu_fwspec_of_xlate().

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c    | 29 ++++++++++++++
 drivers/iommu/of_iommu.c | 82 +++++++++++++++++-----------------------
 include/linux/iommu.h    |  3 ++
 3 files changed, 67 insertions(+), 47 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 36561c9fbf6859..ad2963d69a0538 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2990,6 +2990,35 @@ static int iommu_fwspec_assign_iommu(struct iommu_fwspec *fwspec,
 	return 0;
 }
 
+int iommu_fwspec_of_xlate(struct iommu_fwspec *fwspec, struct device *dev,
+			  struct fwnode_handle *iommu_fwnode,
+			  struct of_phandle_args *iommu_spec)
+{
+	int ret;
+
+	ret = iommu_fwspec_assign_iommu(fwspec, dev, iommu_fwnode);
+	if (ret)
+		return ret;
+
+	if (!fwspec->ops->of_xlate)
+		return -ENODEV;
+
+	if (!dev_iommu_get(dev))
+		return -ENOMEM;
+
+	/*
+	 * ops->of_xlate() requires the fwspec to be passed through dev->iommu,
+	 * set it temporarily.
+	 */
+	if (dev->iommu->fwspec && dev->iommu->fwspec != fwspec)
+		iommu_fwspec_dealloc(dev->iommu->fwspec);
+	dev->iommu->fwspec = fwspec;
+	ret = fwspec->ops->of_xlate(dev, iommu_spec);
+	if (dev->iommu->fwspec == fwspec)
+		dev->iommu->fwspec = NULL;
+	return ret;
+}
+
 struct iommu_fwspec *iommu_fwspec_alloc(void)
 {
 	struct iommu_fwspec *fwspec;
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 4f77495a2543ea..b232a6909e0d45 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -19,40 +19,19 @@
 
 #define NO_IOMMU	-ENODEV
 
-static int of_iommu_xlate(struct device *dev,
+static int of_iommu_xlate(struct iommu_fwspec *fwspec, struct device *dev,
 			  struct of_phandle_args *iommu_spec)
 {
-	const struct iommu_ops *ops;
-	struct fwnode_handle *fwnode = &iommu_spec->np->fwnode;
-	int ret;
-
-	ops = iommu_ops_from_fwnode(fwnode);
-	if ((ops && !ops->of_xlate) ||
-	    !of_device_is_available(iommu_spec->np))
+	if (!of_device_is_available(iommu_spec->np))
 		return NO_IOMMU;
 
-	ret = iommu_fwspec_init(dev, &iommu_spec->np->fwnode, ops);
-	if (ret)
-		return ret;
-	/*
-	 * The otherwise-empty fwspec handily serves to indicate the specific
-	 * IOMMU device we're waiting for, which will be useful if we ever get
-	 * a proper probe-ordering dependency mechanism in future.
-	 */
-	if (!ops)
-		return driver_deferred_probe_check_state(dev);
-
-	if (!try_module_get(ops->owner))
-		return -ENODEV;
-
-	ret = ops->of_xlate(dev, iommu_spec);
-	module_put(ops->owner);
-	return ret;
+	return iommu_fwspec_of_xlate(fwspec, dev, &iommu_spec->np->fwnode,
+				     iommu_spec);
 }
 
-static int of_iommu_configure_dev_id(struct device_node *master_np,
-				     struct device *dev,
-				     const u32 *id)
+static int of_iommu_configure_dev_id(struct iommu_fwspec *fwspec,
+				     struct device_node *master_np,
+				     struct device *dev, const u32 *id)
 {
 	struct of_phandle_args iommu_spec = { .args_count = 1 };
 	int err;
@@ -63,12 +42,13 @@ static int of_iommu_configure_dev_id(struct device_node *master_np,
 	if (err)
 		return err == -ENODEV ? NO_IOMMU : err;
 
-	err = of_iommu_xlate(dev, &iommu_spec);
+	err = of_iommu_xlate(fwspec, dev, &iommu_spec);
 	of_node_put(iommu_spec.np);
 	return err;
 }
 
-static int of_iommu_configure_dev(struct device_node *master_np,
+static int of_iommu_configure_dev(struct iommu_fwspec *fwspec,
+				  struct device_node *master_np,
 				  struct device *dev)
 {
 	struct of_phandle_args iommu_spec;
@@ -77,7 +57,7 @@ static int of_iommu_configure_dev(struct device_node *master_np,
 	while (!of_parse_phandle_with_args(master_np, "iommus",
 					   "#iommu-cells",
 					   idx, &iommu_spec)) {
-		err = of_iommu_xlate(dev, &iommu_spec);
+		err = of_iommu_xlate(fwspec, dev, &iommu_spec);
 		of_node_put(iommu_spec.np);
 		idx++;
 		if (err)
@@ -90,6 +70,7 @@ static int of_iommu_configure_dev(struct device_node *master_np,
 struct of_pci_iommu_alias_info {
 	struct device *dev;
 	struct device_node *np;
+	struct iommu_fwspec *fwspec;
 };
 
 static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
@@ -97,14 +78,16 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 	struct of_pci_iommu_alias_info *info = data;
 	u32 input_id = alias;
 
-	return of_iommu_configure_dev_id(info->np, info->dev, &input_id);
+	return of_iommu_configure_dev_id(info->fwspec, info->np, info->dev,
+					 &input_id);
 }
 
-static int of_iommu_configure_device(struct device_node *master_np,
+static int of_iommu_configure_device(struct iommu_fwspec *fwspec,
+				     struct device_node *master_np,
 				     struct device *dev, const u32 *id)
 {
-	return (id) ? of_iommu_configure_dev_id(master_np, dev, id) :
-		      of_iommu_configure_dev(master_np, dev);
+	return (id) ? of_iommu_configure_dev_id(fwspec, master_np, dev, id) :
+		      of_iommu_configure_dev(fwspec, master_np, dev);
 }
 
 /*
@@ -117,19 +100,15 @@ static int of_iommu_configure_device(struct device_node *master_np,
 int of_iommu_configure(struct device *dev, struct device_node *master_np,
 		       const u32 *id)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct iommu_fwspec *fwspec;
 	int err;
 
 	if (!master_np)
 		return -ENODEV;
 
-	if (fwspec) {
-		if (fwspec->ops)
-			return 0;
-
-		/* In the deferred case, start again from scratch */
-		iommu_fwspec_free(dev);
-	}
+	fwspec = iommu_fwspec_alloc();
+	if (IS_ERR(fwspec))
+		return PTR_ERR(fwspec);
 
 	/*
 	 * We don't currently walk up the tree looking for a parent IOMMU.
@@ -140,27 +119,36 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 		struct of_pci_iommu_alias_info info = {
 			.dev = dev,
 			.np = master_np,
+			.fwspec = fwspec,
 		};
 
 		pci_request_acs();
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
 					     of_pci_iommu_init, &info);
 	} else {
-		err = of_iommu_configure_device(master_np, dev, id);
+		err = of_iommu_configure_device(fwspec, master_np, dev, id);
 	}
 
 	if (err == -ENODEV || err == -EPROBE_DEFER)
-		return err;
+		goto err_free;
 	if (err)
 		goto err_log;
 
-	err = iommu_probe_device(dev);
-	if (err)
+	err = iommu_probe_device_fwspec(dev, fwspec);
+	if (err) {
+		/*
+		 * Ownership for fwspec always passes into
+		 * iommu_probe_device_fwspec()
+		 */
+		fwspec = NULL;
 		goto err_log;
+	}
 	return 0;
 
 err_log:
 	dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
+err_free:
+	iommu_fwspec_dealloc(fwspec);
 	return err;
 }
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 531382d692d71a..2644c61b572b8f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -685,6 +685,9 @@ struct iommu_sva {
 
 struct iommu_fwspec *iommu_fwspec_alloc(void);
 void iommu_fwspec_dealloc(struct iommu_fwspec *fwspec);
+int iommu_fwspec_of_xlate(struct iommu_fwspec *fwspec, struct device *dev,
+			  struct fwnode_handle *iommu_fwnode,
+			  struct of_phandle_args *iommu_spec);
 
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		      const struct iommu_ops *ops);
-- 
2.42.0

