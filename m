Content-Type: multipart/mixed; boundary="===============0020971533321004075=="
MIME-Version: 1.0
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi at huawei.com>
Subject: Re: [Devel] [PATCH v3 2/2] iommu/arm-smmu-v3:Enable ACPI based
 HiSilicon erratum 161010801
Date: Wed, 19 Jul 2017 10:48:15 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8383B9D5A@FRAEML521-MBX.china.huawei.com>
In-Reply-To: 20170714193322.GH26488@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0020971533321004075==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Will Deacon [mailto:will.deacon(a)arm.com]
> Sent: Friday, July 14, 2017 8:33 PM
> To: Shameerali Kolothum Thodi
> Cc: lorenzo.pieralisi(a)arm.com; marc.zyngier(a)arm.com;
> sudeep.holla(a)arm.com; robin.murphy(a)arm.com; hanjun.guo(a)linaro.org;
> Gabriele Paoloni; John Garry; Linuxarm; linux-acpi(a)vger.kernel.org;
> iommu(a)lists.linux-foundation.org; Wangzhou (B); Guohanjun (Hanjun Guo);
> linux-arm-kernel(a)lists.infradead.org; devel(a)acpica.org
> Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3:Enable ACPI based
> HiSilicon erratum 161010801
> =

[...]
> > > > -	list_add_tail(&region->list, head);
> > > > +	if ((smmu->options & ARM_SMMU_OPT_RESV_HW_MSI)) {
> > > > +
> > > > +		if (!is_of_node(smmu->dev->fwnode))
> > > > +			resv =3D iort_iommu_its_get_resv_regions(dev, head);
> > >
> > > How does this work when we're not using ACPI? Shouldn't of vs ACPI
> > > be abstracted from the driver?
> >
> > At present ARM_SMMU_OPT_RESV_HW_MSI is only set for ACPI and  DT
> > support for this is a low priority for us at the moment. Is the
> > suggestion is to have a common function outside the smmu driver for
> > _iommu_its_get_resv_regions() ? I am not sure what is the best way here.
> =

> Right, something like that. The driver shouldn't need to care whether or =
not
> it's using ACPI or DT when setting these options.

Below is what I have in mind for the common function for msi reserve.
But just wondering invoking iort_ functions from iommu code =

is acceptable or not . Could you please take a look and let me know.

Many thanks,
Shameer

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

--===============0020971533321004075==--

