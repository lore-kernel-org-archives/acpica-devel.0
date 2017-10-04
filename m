Content-Type: multipart/mixed; boundary="===============2748031234400022804=="
MIME-Version: 1.0
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi at huawei.com>
Subject: Re: [Devel] [PATCH v8 3/5] iommu/of: Add msi address regions
 reservation helper
Date: Wed, 04 Oct 2017 17:07:15 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83841C809@FRAEML521-MBX.china.huawei.com>
In-Reply-To: f3146f49-6004-7a15-866b-653e3ea54856@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2748031234400022804==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Marc Zyngier [mailto:marc.zyngier(a)arm.com]
> Sent: Wednesday, October 04, 2017 12:22 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi(a)huawei.com>;
> lorenzo.pieralisi(a)arm.com; sudeep.holla(a)arm.com; will.deacon(a)arm.co=
m;
> robin.murphy(a)arm.com; joro(a)8bytes.org; mark.rutland(a)arm.com;
> robh(a)kernel.org
> Cc: Gabriele Paoloni <gabriele.paoloni(a)huawei.com>; John Garry
> <john.garry(a)huawei.com>; iommu(a)lists.linux-foundation.org; linux-arm-
> kernel(a)lists.infradead.org; linux-acpi(a)vger.kernel.org;
> devicetree(a)vger.kernel.org; devel(a)acpica.org; Linuxarm
> <linuxarm(a)huawei.com>; Wangzhou (B) <wangzhou1(a)hisilicon.com>;
> Guohanjun (Hanjun Guo) <guohanjun(a)huawei.com>
> Subject: Re: [PATCH v8 3/5] iommu/of: Add msi address regions reservation
> helper
> =

> On 27/09/17 14:32, Shameer Kolothum wrote:
> > From: John Garry <john.garry(a)huawei.com>
> >
> > On some platforms msi-controller address regions have to be excluded
> > from normal IOVA allocation in that they are detected and decoded in a
> > HW specific way by system components and so they cannot be considered
> > normal IOVA address space.
> >
> > Add a helper function that retrieves msi address regions through
> > device tree msi mapping, so that these regions will not be translated
> > by IOMMU and will be excluded from IOVA allocations.
> >
> > Signed-off-by: John Garry <john.garry(a)huawei.com>
> > [Shameer: Modified msi-parent retrieval logic]
> > Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi(a)huawei.com>
> > ---
> >  drivers/iommu/of_iommu.c | 95
> > ++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/of_iommu.h | 10 +++++
> >  2 files changed, 105 insertions(+)
> >
> > diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index
> > e60e3db..ffd7fb7 100644
> > --- a/drivers/iommu/of_iommu.c
> > +++ b/drivers/iommu/of_iommu.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/iommu.h>
> >  #include <linux/limits.h>
> >  #include <linux/of.h>
> > +#include <linux/of_address.h>
> >  #include <linux/of_iommu.h>
> >  #include <linux/of_pci.h>
> >  #include <linux/slab.h>
> > @@ -138,6 +139,14 @@ static int of_iommu_xlate(struct device *dev,
> >  	return ops->of_xlate(dev, iommu_spec);  }
> >
> > +static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
> > +{
> > +	u32 *rid =3D data;
> > +
> > +	*rid =3D alias;
> > +	return 0;
> > +}
> > +
> >  struct of_pci_iommu_alias_info {
> >  	struct device *dev;
> >  	struct device_node *np;
> > @@ -163,6 +172,73 @@ static int of_pci_iommu_init(struct pci_dev *pdev,
> u16 alias, void *data)
> >  	return info->np =3D=3D pdev->bus->dev.of_node;  }
> >
> > +static int of_iommu_alloc_resv_region(struct device_node *np,
> > +				      struct list_head *head)
> > +{
> > +	int prot =3D IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> > +	struct iommu_resv_region *region;
> > +	struct resource res;
> > +	int err;
> > +
> > +	err =3D of_address_to_resource(np, 0, &res);
> =

> What is the rational for registering the first region only? Surely you ca=
n have
> more than one region in an MSI controller (yes, your particular case is t=
he ITS
> which has only one, but we're trying to do something generic here).

Ok. =


> Another issue I have with this code is that it inserts all of the ITS MMI=
O in the
> RESV_MSI range. As long as we don't generate any page tables for this, we=
're
> fine. But if we ever change this, we'll end-up with the ITS programming
> interface being exposed to a device, which wouldn't be acceptable.

I understand the concern of reserving the whole of ITS MMIO region. Sorry, =

but just being curious, how this will be exposed to a  device ? You mean a =
device
can  be configured to access the ITS MMIO region and it will fail because t=
here is
no SMMU mapping for that?
 =

> Why can't we have some generic property instead, that would describe the
> actual ranges that cannot be translated? That way, no random insertion of=
 a
> random range, and relatively future proof.
> =

> I'm not sure where to declare it (PCIe node? IOMMU node?), but it'd feel =
like
> a much nicer and simpler solution to this problem.

I am not sure that will be seen as legitimizing the untranslated regions or=
 not.
We had this discussion to include the regions specified in IORT spec and the
answer was that, it will in a way legitimize this and encourage future
implementations.

How about making the _msi_get_resv_regions() function be very specific to G=
IC
ITS like _its_msi_get_resv_regions() ? Is that something we can consider?
(In fact we had a checking for "arm, gic-v3-its" in a previous version of t=
his series).

Thanks,
Shameer



--===============2748031234400022804==--

