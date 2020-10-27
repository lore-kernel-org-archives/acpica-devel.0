Content-Type: multipart/mixed; boundary="===============0486186126165490217=="
MIME-Version: 1.0
From: Shameer Kolothum <shameerali.kolothum.thodi at huawei.com>
Subject: [Devel] [RFC PATCH 4/4] iommu/dma: Reserve any RMR regions associated
 with a dev
Date: Tue, 27 Oct 2020 11:26:46 +0000
Message-ID: <20201027112646.44680-5-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: 20201027112646.44680-1-shameerali.kolothum.thodi@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0486186126165490217==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Added support to get RMR regions associated with a dev
reserved so that there is a unity mapping for them in
SMMU.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi(a)huawei.com>
---
 drivers/iommu/dma-iommu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 0cbcd3fc3e7e..31eec16f2af8 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -153,15 +153,19 @@ EXPORT_SYMBOL(iommu_put_dma_cookie);
  * @list: Reserved region list from iommu_get_resv_regions()
  *
  * IOMMU drivers can use this to implement their .get_resv_regions callback
- * for general non-IOMMU-specific reservations. Currently, this covers GIC=
v3
- * ITS region reservation on ACPI based ARM platforms that may require HW =
MSI
- * reservation.
+ * for general non-IOMMU-specific reservations. Currently this covers,
+ *  - GICv3 ITS region reservation on ACPI based ARM platforms that may
+ *    require HW MSI reservation.
+ *  - ACPI IORT RMR memory range reservations that require a unity mapping
+ *    in the SMMU for a given endpoint device.
  */
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 {
 =

-	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
+	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode)) {
 		iort_iommu_msi_get_resv_regions(dev, list);
+		iort_dev_rmr_get_resv_regions(dev, list);
+	}
 =

 }
 EXPORT_SYMBOL(iommu_dma_get_resv_regions);
-- =

2.17.1

--===============0486186126165490217==--

