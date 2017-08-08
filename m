Content-Type: multipart/mixed; boundary="===============4753987378512991826=="
MIME-Version: 1.0
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi at huawei.com>
Subject: Re: [Devel] [PATCH v5 1/2] ACPI/IORT: Add ITS address regions
 reservation helper
Date: Tue, 08 Aug 2017 09:49:51 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8383C8FED@FRAEML521-MBX.china.huawei.com>
In-Reply-To: 20170807170921.GB27830@red-moon
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4753987378512991826==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi(a)arm.com]
> Sent: Monday, August 07, 2017 6:09 PM
> To: Shameerali Kolothum Thodi
> Cc: Robin Murphy; marc.zyngier(a)arm.com; sudeep.holla(a)arm.com;
> will.deacon(a)arm.com; hanjun.guo(a)linaro.org; Gabriele Paoloni; John Ga=
rry;
> Linuxarm; linux-acpi(a)vger.kernel.org; iommu(a)lists.linux-foundation.or=
g;
> Wangzhou (B); Guohanjun (Hanjun Guo); linux-arm-
> kernel(a)lists.infradead.org; devel(a)acpica.org
> Subject: Re: [PATCH v5 1/2] ACPI/IORT: Add ITS address regions reservation
> helper
> =

> On Mon, Aug 07, 2017 at 08:21:40AM +0000, Shameerali Kolothum Thodi
> wrote:
> >
> >
> > > -----Original Message-----
> > > From: Robin Murphy [mailto:robin.murphy(a)arm.com]
> > > Sent: Friday, August 04, 2017 5:57 PM
> > > To: Shameerali Kolothum Thodi; lorenzo.pieralisi(a)arm.com;
> > > marc.zyngier(a)arm.com; sudeep.holla(a)arm.com; will.deacon(a)arm.com;
> > > hanjun.guo(a)linaro.org
> > > Cc: Gabriele Paoloni; John Garry; iommu(a)lists.linux-foundation.org;
> linux-
> > > arm-kernel(a)lists.infradead.org; linux-acpi(a)vger.kernel.org;
> > > devel(a)acpica.org; Linuxarm; Wangzhou (B); Guohanjun (Hanjun Guo)
> > > Subject: Re: [PATCH v5 1/2] ACPI/IORT: Add ITS address regions
> reservation
> > > helper
> > >
> > > On 01/08/17 11:49, Shameer Kolothum wrote:
> > > > On some platforms ITS address regions have to be excluded from
> normal
> > > > IOVA allocation in that they are detected and decoded in a HW speci=
fic
> > > > way by system components and so they cannot be considered normal
> > > IOVA
> > > > address space.
> > > >
> > > > Add an helper function that retrieves ITS address regions through I=
ORT
> > > > device <-> ITS mappings and reserves it so that these regions will =
not
> > > > be translated by IOMMU and will be excluded from IOVA allocations.
> > >
> > > I've just realised that we no longer seem to have a check that ensures
> > > the regions are only reserved on platforms that need it - if not, then
> > > we're going to break everything else that does have an ITS behind SMMU
> > > translation as expected.
> >
> > Right. I had this doubt, but then my thinking was that we will have the
> SW_MSI
> > regions for those and will end up  using that. But that doesn=E2=80=99t=
 seems
> > to be the case now.
> >
> > > It feels like IORT should know enough to be able to make that decision
> > > internally, but if not (or if it would be hideous to do so), then I
> > > guess my idea for patch #2 was a bust and we probably do need to go
> back
> > > to calling directly from the SMMU driver based on the SMMU model.
> >
> > It might be possible to do that check inside iort code, but then we hav=
e to
> find
> > the  smmu node first and check the model number. I think it will be more
> > cleaner if SMMU driver makes that check and call the
> > iommu_dma_get_msi_resv_regions().
> =

> +1 on this one - we can do it in IORT but I think it is more logical
> to have a flag in the SMMU driver (keeping the DT/ACPI fwnode switch in
> generic IOMMU layer though).

Please find [1] for the generic iommu helper function which will be called
from SMMU driver based on the model.

> Side note I: AFAICS iommu_dma_get_resv_regions() is only used on ARM, if
> it is not patch 2 would break miserably on arches that do not select
> IORT - you should rework the return code on !CONFIG_ACPI_IORT configs.

Yes. But so far it is only used on ARM. In any way this function is not goi=
ng to be
changed and will introduce a new iommu_dma_get_msi_resv_regions() fn  as
proposed in [1].

Please take a look and let me know. I will submit the series again if this =
is fine.

Thanks,
Shameer

[1] This will replace patch 2 and will be followed by smmu driver patch to =
invoke
iommu_dma_get_msi_resv_regions() based on SMMU model.

-->8--
Subject: [PATCH] iommu/dma: Add a helper  function to reserve HW MSI addres=
s regions for IOMMU drivers

IOMMU drivers can use this to implement their .get_resv_regions callback
for HW MSI specific reservations(e.g. ARM GICv3 ITS MSI region).

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi(a)huawei.com>
---
 drivers/iommu/dma-iommu.c | 19 +++++++++++++++++++
 include/linux/dma-iommu.h |  7 +++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9d1cebe..952ecdd 100644
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
@@ -198,6 +199,24 @@ void iommu_dma_get_resv_regions(struct device *dev, st=
ruct list_head *list)
 }
 EXPORT_SYMBOL(iommu_dma_get_resv_regions);
 =

+/**
+ * iommu_dma_get_msi_resv_regions - Reserved region driver helper
+ * @dev: Device from iommu_get_resv_regions()
+ * @list: Reserved region list from iommu_get_resv_regions()
+ *
+ * IOMMU drivers can use this to implement their .get_resv_regions
+ * callback for HW MSI specific reservations. For now, this only
+ * covers ITS MSI region reservation using ACPI IORT helper function.
+ */
+int iommu_dma_get_msi_resv_regions(struct device *dev, struct list_head *l=
ist)
+{
+	if (!is_of_node(dev->iommu_fwspec->iommu_fwnode))
+		return iort_iommu_its_get_resv_regions(dev, list);
+
+	return -ENODEV;
+}
+EXPORT_SYMBOL(iommu_dma_get_msi_resv_regions);
+
 static int cookie_init_hw_msi_region(struct iommu_dma_cookie *cookie,
 		phys_addr_t start, phys_addr_t end)
 {
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 92f2083..6062ef0 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -74,6 +74,8 @@ void iommu_dma_unmap_resource(struct device *dev, dma_add=
r_t handle,
 void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list=
);
 =

+int iommu_dma_get_msi_resv_regions(struct device *dev, struct list_head *l=
ist);
+
 #else
 =

 struct iommu_domain;
@@ -107,6 +109,11 @@ static inline void iommu_dma_get_resv_regions(struct d=
evice *dev, struct list_he
 {
 }
 =

+static inline int iommu_dma_get_msi_resv_regions(struct device *dev, struc=
t list_head *list)
+{
+	return -ENODEV;
+}
+
 #endif	/* CONFIG_IOMMU_DMA */
 #endif	/* __KERNEL__ */
 #endif	/* __DMA_IOMMU_H */
-- =

1.9.1

--===============4753987378512991826==--

