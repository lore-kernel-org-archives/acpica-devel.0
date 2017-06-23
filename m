Content-Type: multipart/mixed; boundary="===============7434673540088662379=="
MIME-Version: 1.0
From: shameer <shameerali.kolothum.thodi at huawei.com>
Subject: [Devel] [PATCH v3 2/2] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
 erratum 161010801
Date: Fri, 23 Jun 2017 15:58:01 +0100
Message-ID: <20170623145801.325244-3-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: 20170623145801.325244-1-shameerali.kolothum.thodi@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7434673540088662379==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The HiSilicon erratum 161010801 describes the limitation of HiSilicon
platforms Hip06/Hip07 to support the SMMU mappings for MSI transactions.

On these platforms GICv3 ITS translator is presented with the deviceID
by extending the MSI payload data to 64 bits to include the deviceID.
Hence, the PCIe controller on this platforms has to differentiate the
MSI payload against other DMA payload and has to modify the MSI payload.
This basically makes it difficult for this platforms to have a SMMU
translation for MSI.

This patch implements a ACPI table based quirk to reserve the hw msi
regions in the smmu-v3 driver which means these address regions will
not be translated and will be excluded from iova allocations.

Signed-off-by: shameer <shameerali.kolothum.thodi(a)huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index abe4b88..c9346f2 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -597,6 +597,7 @@ struct arm_smmu_device {
 	u32				features;
 =

 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
+#define ARM_SMMU_OPT_RESV_HW_MSI	(1 << 1)
 	u32				options;
 =

 	struct arm_smmu_cmdq		cmdq;
@@ -1904,14 +1905,34 @@ static void arm_smmu_get_resv_regions(struct device=
 *dev,
 				      struct list_head *head)
 {
 	struct iommu_resv_region *region;
+	struct arm_smmu_device *smmu;
+	struct iommu_fwspec *fwspec =3D dev->iommu_fwspec;
 	int prot =3D IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
+	int resv =3D 0;
 =

-	region =3D iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
-					 prot, IOMMU_RESV_SW_MSI);
-	if (!region)
+	smmu =3D arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
+	if (WARN_ON(!smmu))
 		return;
 =

-	list_add_tail(&region->list, head);
+	if ((smmu->options & ARM_SMMU_OPT_RESV_HW_MSI)) {
+
+		if (!is_of_node(smmu->dev->fwnode))
+			resv =3D iort_iommu_its_get_resv_regions(dev, head);
+
+		if (resv < 0) {
+			dev_warn(dev, "HW MSI region resv failed: %d\n", resv);
+			return;
+		}
+	}
+
+	if (!resv) {
+		region =3D iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
+						 prot, IOMMU_RESV_SW_MSI);
+		if (!region)
+			return;
+
+		list_add_tail(&region->list, head);
+	}
 =

 	iommu_dma_get_resv_regions(dev, head);
 }
@@ -2611,6 +2632,7 @@ static void parse_driver_acpi_options(struct acpi_ior=
t_smmu_v3 *iort_smmu,
 	switch (iort_smmu->model) {
 	case ACPI_IORT_SMMU_HISILICON_HI161X:
 		smmu->options |=3D ARM_SMMU_OPT_SKIP_PREFETCH;
+		smmu->options |=3D ARM_SMMU_OPT_RESV_HW_MSI;
 		break;
 	default:
 		break;
-- =

1.9.1



--===============7434673540088662379==--

