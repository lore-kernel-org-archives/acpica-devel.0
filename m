Return-Path: <jgg@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4BC23400AB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0EB3940129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soH1zWNK7AVR4Z/sQmplqCYXMA35gKd2FYFGGTX9220=;
 b=brZ3lz4iEEHAqgnwC4/zE1B96CqntidirXbzQpfN8fCJE753DAovErkMR3L+WbhHrXAYjdKKysTgXkQu1QOreOgzBFEgC+Sl95Gg34GSX62oO3uDA6v2jMHJxsE0D0FGEPJB3Cu3/m2l+F4TYz8VpFPw5wrCylmij9JIzAdhrX/OPXiYh2KG3kUivmuDVGOPLDokrIWZ4uEL9nG2jJnfmdPwLnvFdD4ETO6DzV74bZNi4cxYiwu1KsVL3auV8Vqz2n80zNsOMHcM33lYl2VunMVYRP4zv4w29G5ddo5dA9f26ilX9UEZ8gza5NwEMSDFuuXDEr+imGX7URhWCci34Q==
From: Jason Gunthorpe <jgg@nvidia.com>
Date: Fri,  3 Nov 2023 13:44:56 -0300
Message-ID: <11-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Acpica-devel] [PATCH RFC 11/17] iommu: Hold
	iommu_probe_device_lock while calling ops->of_xlate
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

This resolves the race around touching dev->iommu while generating the OF
fwspec on the of_iommu_configure() flow:

     CPU0                                     CPU1
of_iommu_configure()                iommu_device_register()
 ..                                   bus_iommu_probe()
  iommu_fwspec_of_xlate()              __iommu_probe_device()
                                        iommu_init_device()
   dev_iommu_get()
                                          .. ops->probe fails, no fwspec ..
                                          dev_iommu_free()
   dev->iommu->fwspec    *crash*

CPU1 is holding the iommu_probe_device_lock for iommu_init_device(),
holding it around the of_xlate() and its related manipulation of
dev->iommu will close it.

The approach also closes a similar race for what should be a successful
probe where the above basic construction results in ops->probe observing a
partially initialized fwspec.

Reported-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Closes: https://lore.kernel.org/linux-arm-kernel/20231017163337.GE282036@ziepe.ca/T/#mee0d7bdc375541934a571ae69f43b9660f8e7312
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9cfba9d12d1400..62c82a28cd5db3 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -41,6 +41,7 @@
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
 static DEFINE_IDA(iommu_global_pasid_ida);
+static DEFINE_MUTEX(iommu_probe_device_lock);
 
 static unsigned int iommu_def_domain_type __read_mostly;
 static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_DMA_STRICT);
@@ -498,7 +499,6 @@ static int __iommu_probe_device(struct device *dev,
 	struct iommu_fwspec *fwspec = caller_fwspec;
 	const struct iommu_ops *ops;
 	struct iommu_group *group;
-	static DEFINE_MUTEX(iommu_probe_device_lock);
 	struct group_device *gdev;
 	int ret;
 
@@ -3002,8 +3002,11 @@ int iommu_fwspec_of_xlate(struct iommu_fwspec *fwspec, struct device *dev,
 	if (!fwspec->ops->of_xlate)
 		return -ENODEV;
 
-	if (!dev_iommu_get(dev))
+	mutex_lock(&iommu_probe_device_lock);
+	if (!dev_iommu_get(dev)) {
+		mutex_unlock(&iommu_probe_device_lock);
 		return -ENOMEM;
+	}
 
 	/*
 	 * ops->of_xlate() requires the fwspec to be passed through dev->iommu,
@@ -3015,6 +3018,7 @@ int iommu_fwspec_of_xlate(struct iommu_fwspec *fwspec, struct device *dev,
 	ret = fwspec->ops->of_xlate(dev, iommu_spec);
 	if (dev->iommu->fwspec == fwspec)
 		dev->iommu->fwspec = NULL;
+	mutex_unlock(&iommu_probe_device_lock);
 	return ret;
 }
 
@@ -3044,6 +3048,8 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	int ret;
 
+	lockdep_assert_held(&iommu_probe_device_lock);
+
 	if (fwspec)
 		return ops == fwspec->ops ? 0 : -EINVAL;
 
@@ -3097,6 +3103,8 @@ int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
+	lockdep_assert_held(&iommu_probe_device_lock);
+
 	if (!fwspec)
 		return -EINVAL;
 	return iommu_fwspec_append_ids(fwspec, ids, num_ids);
-- 
2.42.0

