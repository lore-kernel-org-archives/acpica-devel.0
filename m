Return-Path: <jgg@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DB5BB400AB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9D8854012F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDk+Rk7r4cwKBoGlOIOvdq9eKJeO1hxpOVqu1F7DQc8=;
 b=M4n93yqEgDBEd+UDMIXCySXwAuTXWII1Op8tZqByM7O6phaSYDsp7XY+IDslEq8c4GUmrcARFrpKbHpb/B+ogS4OkDKq5veiIstIFPA6hrUo+ctN5vemJVLb5wimelXHI18OYJmaVF+rWRVG6YuKruVj/TX8NOBe1btF/uMK/o6vJdZ++1RFDU99/TunGx346JnYjauY1gKLoGu0TCXKdzFpfBG2qpKwoD7nlAoZ4JCgg2JYBpzLIh1IikIOxD74c2S1TNyBhP234mGl/qn+8sIV7sT+UhcobUo8M0ScHf/5P14maY7PCFqGeBkRxJOf/5GXptjl702xh+4yCO2bpg==
From: Jason Gunthorpe <jgg@nvidia.com>
Date: Fri,  3 Nov 2023 13:45:02 -0300
Message-ID: <17-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Acpica-devel] [PATCH RFC 17/17] iommu: Mark dev_iommu_priv_set()
	with a lockdep
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

A perfect driver would only call dev_iommu_priv_set() from its probe
callback. We've made it functionally correct to call it from the of_xlate
by adding a lock around that call.

lockdep assert that iommu_probe_device_lock is held to discourage misuse.

Exclude PPC kernels with CONFIG_FSL_PAMU turned on because FSL_PAMU uses a
global static for its priv and abuses priv for its domain.

Remove the pointless stores of NULL, all these are on paths where the core
code will free dev->iommu after the op returns.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c                   | 2 --
 drivers/iommu/apple-dart.c                  | 1 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 -
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 1 -
 drivers/iommu/intel/iommu.c                 | 2 --
 drivers/iommu/iommu.c                       | 9 +++++++++
 drivers/iommu/omap-iommu.c                  | 1 -
 include/linux/iommu.h                       | 5 +----
 8 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 089886485895bc..604056eb0f5f8a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -549,8 +549,6 @@ static void amd_iommu_uninit_device(struct device *dev)
 	if (dev_data->domain)
 		detach_device(dev);
 
-	dev_iommu_priv_set(dev, NULL);
-
 	/*
 	 * We keep dev_data around for unplugged devices and reuse it when the
 	 * device is re-plugged - not doing so would introduce a ton of races.
diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index ee05f4824bfad1..56cfc33042e0b5 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -740,7 +740,6 @@ static void apple_dart_release_device(struct device *dev)
 {
 	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
 
-	dev_iommu_priv_set(dev, NULL);
 	kfree(cfg);
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b1309f04ebc0d9..df81fcd25a75b0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2698,7 +2698,6 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 
 err_free_master:
 	kfree(master);
-	dev_iommu_priv_set(dev, NULL);
 	return ERR_PTR(ret);
 }
 
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 8c4a60d8e5d522..6fc040a4168aa3 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1423,7 +1423,6 @@ static void arm_smmu_release_device(struct device *dev)
 
 	arm_smmu_rpm_put(cfg->smmu);
 
-	dev_iommu_priv_set(dev, NULL);
 	kfree(cfg);
 }
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d5d191a71fe0d5..890c2cc9759b51 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4401,7 +4401,6 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 		ret = intel_pasid_alloc_table(dev);
 		if (ret) {
 			dev_err(dev, "PASID table allocation failed\n");
-			dev_iommu_priv_set(dev, NULL);
 			kfree(info);
 			return ERR_PTR(ret);
 		}
@@ -4419,7 +4418,6 @@ static void intel_iommu_release_device(struct device *dev)
 	dmar_remove_one_dev_info(dev);
 	intel_pasid_free_table(dev);
 	intel_iommu_debugfs_remove_dev(info);
-	dev_iommu_priv_set(dev, NULL);
 	kfree(info);
 	set_dma_ops(dev, NULL);
 }
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1cf9f62c047c7d..254cde45bc5c1c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -387,6 +387,15 @@ static u32 dev_iommu_get_max_pasids(struct device *dev)
 	return min_t(u32, max_pasids, dev->iommu->iommu_dev->max_pasids);
 }
 
+void dev_iommu_priv_set(struct device *dev, void *priv)
+{
+	/* FSL_PAMU does something weird */
+	if (!IS_ENABLED(CONFIG_FSL_PAMU))
+		lockdep_assert_held(&iommu_probe_device_lock);
+	dev->iommu->priv = priv;
+}
+EXPORT_SYMBOL_GPL(dev_iommu_priv_set);
+
 /*
  * Init the dev->iommu and dev->iommu_group in the struct device and get the
  * driver probed. Take ownership of fwspec, it always freed on error
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index c66b070841dd41..c9528065a59afa 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1719,7 +1719,6 @@ static void omap_iommu_release_device(struct device *dev)
 	if (!dev->of_node || !arch_data)
 		return;
 
-	dev_iommu_priv_set(dev, NULL);
 	kfree(arch_data);
 
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2fac54a942af54..de52217ee4f4c0 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -722,10 +722,7 @@ static inline void *dev_iommu_priv_get(struct device *dev)
 		return NULL;
 }
 
-static inline void dev_iommu_priv_set(struct device *dev, void *priv)
-{
-	dev->iommu->priv = priv;
-}
+void dev_iommu_priv_set(struct device *dev, void *priv);
 
 int iommu_probe_device_fwspec(struct device *dev, struct iommu_fwspec *fwspec);
 static inline int iommu_probe_device(struct device *dev)
-- 
2.42.0

