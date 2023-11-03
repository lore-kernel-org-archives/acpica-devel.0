Return-Path: <jgg@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9FF42820C6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 65DD582129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XNehcFHCv/WWEYzFVtCePx11LeVzFec8nSPjCUW5KM=;
 b=SjAMSqVERHC9uchVXkvF4ywBqG2t28Wek+SKPF0uIofjdl+6WLtH7cHJoD2Yigh+w5HRmTdt2mtFndhTLl3HiLeWf7RyQ2apyReW0aOLcfnPP74XxMN3ErhmdtLzB7jsYtg58uTeHMmyu7bkRgP2MmEMhO3Xr3ve/p+Y5JsXhFNwKMdmYJxidZrzJpD+6UTdyEEkQKvrgBvUNGYBrrxS4HCTn5vIHFS3jQ65jbtR0c1f8ZydFxvQH6XrnVYrmf5K7DH2pXE3P8noJo6p3v4/6k077m9jm2LH1BONDy7dH3gxcofgmMpeYWUjiAFF2eiNt5GwczOirg4pB4UO2x3NoQ==
From: Jason Gunthorpe <jgg@nvidia.com>
Date: Fri,  3 Nov 2023 13:44:52 -0300
Message-ID: <7-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Acpica-devel] [PATCH RFC 07/17] iommu: Add
	iommu_probe_device_fwspec()
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

Instead of obtaining an iommu_fwspec from dev->iommu allow a caller
allocated fwspec to be passed into the probe logic. To keep the driver ops
APIs the same the fwspec is stored in dev->iommu under the
iommu_probe_device_lock.

If a fwspec is available use it to provide the ops instead of the bus.

The lifecycle logic is a bit tortured because of how the existing driver
code works. The new routine unconditionally takes ownership, even for
failure. This could be simplified we can get rid of the remaining
iommu_fwspec_init() callers someday.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 53 +++++++++++++++++++++++++++++++------------
 include/linux/iommu.h |  6 ++++-
 2 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 46f3d19a1291b0..36561c9fbf6859 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -386,16 +386,24 @@ static u32 dev_iommu_get_max_pasids(struct device *dev)
 
 /*
  * Init the dev->iommu and dev->iommu_group in the struct device and get the
- * driver probed
+ * driver probed. Take ownership of fwspec, it always freed on error
+ * or freed by iommu_deinit_device().
  */
-static int iommu_init_device(struct device *dev, const struct iommu_ops *ops)
+static int iommu_init_device(struct device *dev, struct iommu_fwspec *fwspec,
+			     const struct iommu_ops *ops)
 {
 	struct iommu_device *iommu_dev;
 	struct iommu_group *group;
 	int ret;
 
-	if (!dev_iommu_get(dev))
+	if (!dev_iommu_get(dev)) {
+		iommu_fwspec_dealloc(fwspec);
 		return -ENOMEM;
+	}
+
+	if (dev->iommu->fwspec && dev->iommu->fwspec != fwspec)
+		iommu_fwspec_dealloc(dev->iommu->fwspec);
+	dev->iommu->fwspec = fwspec;
 
 	if (!try_module_get(ops->owner)) {
 		ret = -EINVAL;
@@ -483,16 +491,17 @@ static void iommu_deinit_device(struct device *dev)
 	dev_iommu_free(dev);
 }
 
-static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
+static int __iommu_probe_device(struct device *dev,
+				struct iommu_fwspec *caller_fwspec,
+				struct list_head *group_list)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	struct iommu_fwspec *fwspec = caller_fwspec;
+	const struct iommu_ops *ops;
 	struct iommu_group *group;
 	static DEFINE_MUTEX(iommu_probe_device_lock);
 	struct group_device *gdev;
 	int ret;
 
-	if (!ops)
-		return -ENODEV;
 	/*
 	 * Serialise to avoid races between IOMMU drivers registering in
 	 * parallel and/or the "replay" calls from ACPI/OF code via client
@@ -502,13 +511,25 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	 */
 	mutex_lock(&iommu_probe_device_lock);
 
-	/* Device is probed already if in a group */
-	if (dev->iommu_group) {
-		ret = 0;
+	if (!fwspec && dev->iommu)
+		fwspec = dev->iommu->fwspec;
+	if (fwspec)
+		ops = fwspec->ops;
+	else
+		ops = dev->bus->iommu_ops;
+	if (!ops) {
+		ret = -ENODEV;
 		goto out_unlock;
 	}
 
-	ret = iommu_init_device(dev, ops);
+	/* Device is probed already if in a group */
+	if (dev->iommu_group) {
+		ret = 0;
+		iommu_fwspec_dealloc(caller_fwspec);
+		goto out_unlock;
+	}
+
+	ret = iommu_init_device(dev, fwspec, ops);
 	if (ret)
 		goto out_unlock;
 
@@ -566,12 +587,16 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	return ret;
 }
 
-int iommu_probe_device(struct device *dev)
+/*
+ * Ownership of fwspec always transfers to iommu_probe_device_fwspec(), it will
+ * be free'd even on failure.
+ */
+int iommu_probe_device_fwspec(struct device *dev, struct iommu_fwspec *fwspec)
 {
 	const struct iommu_ops *ops;
 	int ret;
 
-	ret = __iommu_probe_device(dev, NULL);
+	ret = __iommu_probe_device(dev, fwspec, NULL);
 	if (ret)
 		return ret;
 
@@ -1820,7 +1845,7 @@ static int probe_iommu_group(struct device *dev, void *data)
 	struct list_head *group_list = data;
 	int ret;
 
-	ret = __iommu_probe_device(dev, group_list);
+	ret = __iommu_probe_device(dev, NULL, group_list);
 	if (ret == -ENODEV)
 		ret = 0;
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b827dd6a5844b0..531382d692d71a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -725,7 +725,11 @@ static inline void dev_iommu_priv_set(struct device *dev, void *priv)
 	dev->iommu->priv = priv;
 }
 
-int iommu_probe_device(struct device *dev);
+int iommu_probe_device_fwspec(struct device *dev, struct iommu_fwspec *fwspec);
+static inline int iommu_probe_device(struct device *dev)
+{
+	return iommu_probe_device_fwspec(dev, NULL);
+}
 
 int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
 int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features f);
-- 
2.42.0

