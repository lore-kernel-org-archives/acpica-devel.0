Return-Path: <jgg@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 73F0A4011A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4542940108
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amWEmLVGHcqZlQAIojeO7Vy3AmHrjvzfegrj+mYY+d0=;
 b=Cs4ItXs1Wq+hxCZk4+j1cz4TsykKvVS3gEPeRmjhkw58h+L1jv9L4ZI3zCndmJVMxOKhf7DSW7Lfou7y1gtdjb6ZiZNYGM26r5jF2oAIrczKyIg+Ns46G+WgkKOr7ogMJzJMUTHbtB4FIugJjQwxEVVtwMsINifvZONDQzPqZ/OHDtN2ELMKzC1EcBJ0O54w6Mlzr6ZWIdgzOlG6fDFeez2yf5gD2IL/FP3yyjbwLWcqa6boDgkeZjNMbqPjNkkfzfwWyQAxiRn+zRlHjYGtBJEUQLW3tDyro7KzxzNjf76PCgX/v0RJlvi8Zma+SCjbbuxRbwmC5Pyk8typVcQt6g==
From: Jason Gunthorpe <jgg@nvidia.com>
Date: Fri,  3 Nov 2023 13:44:59 -0300
Message-ID: <14-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Acpica-devel] [PATCH RFC 14/17] iommu: Remove pointless
	iommu_fwspec_free()
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

These days the core code will free the fwspec if probe fails, no reason
for any driver to call this on a probe failure path.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 14 +++++---------
 drivers/iommu/tegra-smmu.c            |  1 -
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index d6d1a2a55cc069..854efcb1b84ddf 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1348,6 +1348,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 
 	if (using_legacy_binding) {
 		ret = arm_smmu_register_legacy_master(dev, &smmu);
+		if (ret)
+			return ERR_PTR(ret);
 
 		/*
 		 * If dev->iommu_fwspec is initally NULL, arm_smmu_register_legacy_master()
@@ -1355,15 +1357,12 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 		 * later use.
 		 */
 		fwspec = dev_iommu_fwspec_get(dev);
-		if (ret)
-			goto out_free;
 	} else if (fwspec && fwspec->ops == &arm_smmu_ops) {
 		smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
 	} else {
 		return ERR_PTR(-ENODEV);
 	}
 
-	ret = -EINVAL;
 	for (i = 0; i < fwspec->num_ids; i++) {
 		u16 sid = FIELD_GET(ARM_SMMU_SMR_ID, fwspec->ids[i]);
 		u16 mask = FIELD_GET(ARM_SMMU_SMR_MASK, fwspec->ids[i]);
@@ -1371,20 +1370,19 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 		if (sid & ~smmu->streamid_mask) {
 			dev_err(dev, "stream ID 0x%x out of range for SMMU (0x%x)\n",
 				sid, smmu->streamid_mask);
-			goto out_free;
+			return ERR_PTR(-EINVAL);
 		}
 		if (mask & ~smmu->smr_mask_mask) {
 			dev_err(dev, "SMR mask 0x%x out of range for SMMU (0x%x)\n",
 				mask, smmu->smr_mask_mask);
-			goto out_free;
+			return ERR_PTR(-EINVAL);
 		}
 	}
 
-	ret = -ENOMEM;
 	cfg = kzalloc(offsetof(struct arm_smmu_master_cfg, smendx[i]),
 		      GFP_KERNEL);
 	if (!cfg)
-		goto out_free;
+		return ERR_PTR(-ENOMEM);
 
 	cfg->smmu = smmu;
 	dev_iommu_priv_set(dev, cfg);
@@ -1408,8 +1406,6 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 
 out_cfg_free:
 	kfree(cfg);
-out_free:
-	iommu_fwspec_free(dev);
 	return ERR_PTR(ret);
 }
 
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 310871728ab4b6..e3101aa2f35689 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -844,7 +844,6 @@ static int tegra_smmu_configure(struct tegra_smmu *smmu, struct device *dev,
 	err = ops->of_xlate(dev, args);
 	if (err < 0) {
 		dev_err(dev, "failed to parse SW group ID: %d\n", err);
-		iommu_fwspec_free(dev);
 		return err;
 	}
 
-- 
2.42.0

