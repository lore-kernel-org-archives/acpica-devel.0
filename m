Content-Type: multipart/mixed; boundary="===============9102881387265995164=="
MIME-Version: 1.0
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi at huawei.com>
Subject: Re: [Devel] [PATCH v9 2/4] iommu/dma: Add a helper function to
 reserve HW MSI address regions for IOMMU drivers
Date: Mon, 16 Oct 2017 16:09:36 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83844672A@FRAEML521-MBX.china.huawei.com>
In-Reply-To: 20171013192350.GA32130@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============9102881387265995164==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Robin,

> -----Original Message-----
> From: Will Deacon [mailto:will.deacon(a)arm.com]
> Sent: Friday, October 13, 2017 8:24 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi(a)huawei.com>
> Cc: lorenzo.pieralisi(a)arm.com; marc.zyngier(a)arm.com;
> sudeep.holla(a)arm.com; robin.murphy(a)arm.com; joro(a)8bytes.org;
> bhelgaas(a)google.com; Gabriele Paoloni <gabriele.paoloni(a)huawei.com>;
> John Garry <john.garry(a)huawei.com>; iommu(a)lists.linux-foundation.org;
> linux-arm-kernel(a)lists.infradead.org; linux-acpi(a)vger.kernel.org; lin=
ux-
> pci(a)vger.kernel.org; devel(a)acpica.org; Linuxarm <linuxarm(a)huawei.co=
m>;
> Wangzhou (B) <wangzhou1(a)hisilicon.com>; Guohanjun (Hanjun Guo)
> <guohanjun(a)huawei.com>
> Subject: Re: [PATCH v9 2/4] iommu/dma: Add a helper function to reserve HW
> MSI address regions for IOMMU drivers
> =

> On Fri, Oct 06, 2017 at 03:04:48PM +0100, Shameer Kolothum wrote:
> > IOMMU drivers can use this to implement their .get_resv_regions callback
> > for HW MSI specific reservations(e.g. ARM GICv3 ITS MSI region).
> >
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi(a)huawei.com>
> > ---
> >  drivers/iommu/dma-iommu.c | 20 ++++++++++++++++++++
> >  include/linux/dma-iommu.h |  7 +++++++
> >  2 files changed, 27 insertions(+)
> =

> I'd like to see Robin's Ack on this, because this is his code and he had
> ideas on ways to solve this problem properly.

Please let us know if it is ok to go ahead with ACPI support for now.
It will help our customers to start using pass-through for PCIe.

Thanks,
Shameer

> =

> Will
> =

> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 9d1cebe..bae677e 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -19,6 +19,7 @@
> >   * along with this program.  If not, see <http://www.gnu.org/licenses/=
>.
> >   */
> >
> > +#include <linux/acpi_iort.h>
> >  #include <linux/device.h>
> >  #include <linux/dma-iommu.h>
> >  #include <linux/gfp.h>
> > @@ -27,6 +28,7 @@
> >  #include <linux/iova.h>
> >  #include <linux/irq.h>
> >  #include <linux/mm.h>
> > +#include <linux/of_iommu.h>
> >  #include <linux/pci.h>
> >  #include <linux/scatterlist.h>
> >  #include <linux/vmalloc.h>
> > @@ -198,6 +200,24 @@ void iommu_dma_get_resv_regions(struct device
> *dev, struct list_head *list)
> >  }
> >  EXPORT_SYMBOL(iommu_dma_get_resv_regions);
> >
> > +/**
> > + * iommu_dma_get_msi_resv_regions - Reserved region driver helper
> > + * @dev: Device from iommu_get_resv_regions()
> > + * @list: Reserved region list from iommu_get_resv_regions()
> > + *
> > + * IOMMU drivers can use this to implement their .get_resv_regions
> > + * callback for HW MSI specific reservations. For now, this only
> > + * covers ITS MSI region reservation using ACPI IORT helper function.
> > + */
> > +int iommu_dma_get_msi_resv_regions(struct device *dev, struct list_head
> *list)
> > +{
> > +	if (!is_of_node(dev->iommu_fwspec->iommu_fwnode))
> > +		return iort_iommu_msi_get_resv_regions(dev, list);
> > +
> > +	return -ENODEV;
> > +}
> > +EXPORT_SYMBOL(iommu_dma_get_msi_resv_regions);
> > +
> >  static int cookie_init_hw_msi_region(struct iommu_dma_cookie *cookie,
> >  		phys_addr_t start, phys_addr_t end)
> >  {
> > diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> > index 92f2083..6062ef0 100644
> > --- a/include/linux/dma-iommu.h
> > +++ b/include/linux/dma-iommu.h
> > @@ -74,6 +74,8 @@ void iommu_dma_unmap_resource(struct device *dev,
> dma_addr_t handle,
> >  void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
> >  void iommu_dma_get_resv_regions(struct device *dev, struct list_head
> *list);
> >
> > +int iommu_dma_get_msi_resv_regions(struct device *dev, struct list_head
> *list);
> > +
> >  #else
> >
> >  struct iommu_domain;
> > @@ -107,6 +109,11 @@ static inline void
> iommu_dma_get_resv_regions(struct device *dev, struct list_he
> >  {
> >  }
> >
> > +static inline int iommu_dma_get_msi_resv_regions(struct device *dev,
> struct list_head *list)
> > +{
> > +	return -ENODEV;
> > +}
> > +
> >  #endif	/* CONFIG_IOMMU_DMA */
> >  #endif	/* __KERNEL__ */
> >  #endif	/* __DMA_IOMMU_H */
> > --
> > 1.9.1
> >
> >

--===============9102881387265995164==--

