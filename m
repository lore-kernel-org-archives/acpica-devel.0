Content-Type: multipart/mixed; boundary="===============6338147626099974915=="
MIME-Version: 1.0
From: Shameer Kolothum <shameerali.kolothum.thodi at huawei.com>
Subject: [Devel] [PATCH v4 2/2] iommu/dma: Add HW MSI address regions
 reservation for IOMMU drivers
Date: Tue, 25 Jul 2017 12:17:32 +0100
Message-ID: <20170725111732.41792-3-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: 20170725111732.41792-1-shameerali.kolothum.thodi@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6338147626099974915==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Modified iommu_dma_get_resv_regions() to include HW MSI (ARM GICv3 ITS MSI)
specific reservations if available.

Suggested-by: Robin Murphy <robin.murphy(a)arm.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi(a)huawei.com>
---
 drivers/iommu/dma-iommu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9d1cebe..3b6fde7 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -19,6 +19,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 =

+#include <linux/acpi_iort.h>
 #include <linux/device.h>
 #include <linux/dma-iommu.h>
 #include <linux/gfp.h>
@@ -167,13 +168,18 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
  *
  * IOMMU drivers can use this to implement their .get_resv_regions callback
  * for general non-IOMMU-specific reservations. Currently, this covers host
- * bridge windows for PCI devices.
+ * bridge windows for PCI devices and HW MSI(ARM GICv3 ITS MSI) region
+ * reservations if avialable.
  */
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 {
 	struct pci_host_bridge *bridge;
 	struct resource_entry *window;
 =

+	if (!is_of_node(dev->iommu_fwspec->iommu_fwnode) &&
+		iort_iommu_its_get_resv_regions(dev, list) < 0)
+		return;
+
 	if (!dev_is_pci(dev))
 		return;
 =

-- =

1.9.1



--===============6338147626099974915==--

