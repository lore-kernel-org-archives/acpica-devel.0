Return-Path: <jgg@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E8C7B4012A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 98530400AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnoHHRW9wGxYObBfp5jd7EnMs8P21nURFY58S4rMak0=;
 b=fgFyWL8y2hhCPeRB3QREn7Uuh58Tup5xgeQRI1TAYRqqv27pTe6tsY9S0SQc6yUa9BaQx/XIqo1k/RqOXF/+AkiFVPZSVYIfhdiDmnAsXFx81d2o5yCRGZ0a6eBPF8TqDMWkjqXR2m5GKehRjHva6egvNif895ewxMZ6rSmeSQfsj7TE67zwPQbQwJpD09DbSQNXLviiCBZOyBkzQYCuZ+O8TQXBG9Sf3FLGLauPLm7JLs5qbxF3RcIC+lmPk9MDwu0ZT6HhksJLU25EywFBSKDUL633ZfBYTLUkaZNI3Rm/tw2w8VkA7P4ibnDKT0koO6zlJrj0B+YCKVpj2JMqEA==
From: Jason Gunthorpe <jgg@nvidia.com>
Date: Fri,  3 Nov 2023 13:44:49 -0300
Message-ID: <4-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
In-Reply-To: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
Subject: [Acpica-devel] [PATCH RFC 04/17] acpi: Do not return struct
	iommu_ops from acpi_iommu_configure_id()
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
 drivers/acpi/scan.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index a6891ad0ceee2c..fbabde001a23a2 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1562,8 +1562,7 @@ static inline const struct iommu_ops *acpi_iommu_fwspec_ops(struct device *dev)
 	return fwspec ? fwspec->ops : NULL;
 }
 
-static const struct iommu_ops *acpi_iommu_configure_id(struct device *dev,
-						       const u32 *id_in)
+static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 {
 	int err;
 	const struct iommu_ops *ops;
@@ -1574,7 +1573,7 @@ static const struct iommu_ops *acpi_iommu_configure_id(struct device *dev,
 	 */
 	ops = acpi_iommu_fwspec_ops(dev);
 	if (ops)
-		return ops;
+		return 0;
 
 	err = iort_iommu_configure_id(dev, id_in);
 	if (err && err != -EPROBE_DEFER)
@@ -1589,12 +1588,14 @@ static const struct iommu_ops *acpi_iommu_configure_id(struct device *dev,
 
 	/* Ignore all other errors apart from EPROBE_DEFER */
 	if (err == -EPROBE_DEFER) {
-		return ERR_PTR(err);
+		return err;
 	} else if (err) {
 		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
-		return NULL;
+		return -ENODEV;
 	}
-	return acpi_iommu_fwspec_ops(dev);
+	if (!acpi_iommu_fwspec_ops(dev))
+		return -ENODEV;
+	return 0;
 }
 
 #else /* !CONFIG_IOMMU_API */
@@ -1623,7 +1624,7 @@ static const struct iommu_ops *acpi_iommu_configure_id(struct device *dev,
 int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
 			  const u32 *input_id)
 {
-	const struct iommu_ops *iommu;
+	int ret;
 
 	if (attr == DEV_DMA_NOT_SUPPORTED) {
 		set_dma_ops(dev, &dma_dummy_ops);
@@ -1632,10 +1633,15 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
 
 	acpi_arch_dma_setup(dev);
 
-	iommu = acpi_iommu_configure_id(dev, input_id);
-	if (PTR_ERR(iommu) == -EPROBE_DEFER)
+	ret = acpi_iommu_configure_id(dev, input_id);
+	if (ret == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 
+	/*
+	 * Historically this routine doesn't fail driver probing due to errors
+	 * in acpi_iommu_configure()
+	 */
+
 	arch_setup_dma_ops(dev, 0, U64_MAX, attr == DEV_DMA_COHERENT);
 
 	return 0;
-- 
2.42.0

