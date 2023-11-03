Return-Path: <jgg@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3273640108
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EDB6540132
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdsjErMszebnmFtTb6/WTM+XmGNFE0IR3PzOJuy1VLM=;
 b=PWEkU7cBfCPLNRnK1t8TIeVVszN78B+1/T2c8D2S8TMSqYm/xDqeSvCuUImJ+GxGD/Ru08XM3LTkwtrh16+fjXNZ3uSJb+eoCeGJd6c+s6KXiCALJ8zLJhEQ8Qgoz0BzIKO7JbqI6mTcxJl28uyoJruZLT27o7Ba2aOcTsEDsS98DggVKzdDZWphA3K8eFl93iLqZHg3WBBM9w5+SX9cY2f7ZJP+YXYfk8PN7OBDclGaJOyIOVUakhEau604I32TrPUyec1ZqqXu1GkyCufkToIsoK9ofC+3cQDRW2HXNxRA6VHVhXwQLQx4XwZlJIL+Q9zyJ0jUASmQsIawWiqM5Q==
From: Jason Gunthorpe <jgg@nvidia.com>
Date: Fri,  3 Nov 2023 13:44:48 -0300
Message-ID: <3-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Acpica-devel] [PATCH RFC 03/17] of: Use -ENODEV consistently in
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

Instead of returning 1 and trying to handle positive error codes just
stick to the convention of returning -ENODEV. Remove references to ops
from of_iommu_configure(), a NULL ops will already generate an error code.

There is no reason to check dev->bus, if err=0 at this point then the
called configure functions thought there was an iommu and we should try to
probe it. Remove it.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/of_iommu.c | 42 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index e2fa29c16dd758..4f77495a2543ea 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -17,7 +17,7 @@
 #include <linux/slab.h>
 #include <linux/fsl/mc.h>
 
-#define NO_IOMMU	1
+#define NO_IOMMU	-ENODEV
 
 static int of_iommu_xlate(struct device *dev,
 			  struct of_phandle_args *iommu_spec)
@@ -117,9 +117,8 @@ static int of_iommu_configure_device(struct device_node *master_np,
 int of_iommu_configure(struct device *dev, struct device_node *master_np,
 		       const u32 *id)
 {
-	const struct iommu_ops *ops = NULL;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	int err = NO_IOMMU;
+	int err;
 
 	if (!master_np)
 		return -ENODEV;
@@ -150,34 +149,19 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 		err = of_iommu_configure_device(master_np, dev, id);
 	}
 
-	/*
-	 * Two success conditions can be represented by non-negative err here:
-	 * >0 : there is no IOMMU, or one was unavailable for non-fatal reasons
-	 *  0 : we found an IOMMU, and dev->fwspec is initialised appropriately
-	 * <0 : any actual error
-	 */
-	if (!err) {
-		/* The fwspec pointer changed, read it again */
-		fwspec = dev_iommu_fwspec_get(dev);
-		ops    = fwspec->ops;
-	}
-	/*
-	 * If we have reason to believe the IOMMU driver missed the initial
-	 * probe for dev, replay it to get things in order.
-	 */
-	if (!err && dev->bus)
-		err = iommu_probe_device(dev);
+	if (err == -ENODEV || err == -EPROBE_DEFER)
+		return err;
+	if (err)
+		goto err_log;
 
-	/* Ignore all other errors apart from EPROBE_DEFER */
-	if (err < 0) {
-		if (err == -EPROBE_DEFER)
-			return err;
-		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
-		return -ENODEV;
-	}
-	if (!ops)
-		return -ENODEV;
+	err = iommu_probe_device(dev);
+	if (err)
+		goto err_log;
 	return 0;
+
+err_log:
+	dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
+	return err;
 }
 
 static enum iommu_resv_type __maybe_unused
-- 
2.42.0

