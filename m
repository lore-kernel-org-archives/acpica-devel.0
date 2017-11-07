Content-Type: multipart/mixed; boundary="===============6680869222410442831=="
MIME-Version: 1.0
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi at huawei.com>
Subject: Re: [Devel] [PATCH v9 2/4] iommu/dma: Add a helper function to
 reserve HW MSI address regions for IOMMU drivers
Date: Tue, 07 Nov 2017 09:37:35 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83845828E@FRAEML521-MBX.china.huawei.com>
In-Reply-To: 20171103113503.GB29434@red-moon
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6680869222410442831==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi(a)arm.com]
> Sent: Friday, November 03, 2017 11:35 AM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi(a)huawei.com>
> Cc: Robin Murphy <robin.murphy(a)arm.com>; Will Deacon
> <will.deacon(a)arm.com>; Gabriele Paoloni <gabriele.paoloni(a)huawei.com>;
> marc.zyngier(a)arm.com; linux-pci(a)vger.kernel.org; joro(a)8bytes.org; J=
ohn
> Garry <john.garry(a)huawei.com>; Guohanjun (Hanjun Guo)
> <guohanjun(a)huawei.com>; Linuxarm <linuxarm(a)huawei.com>; linux-
> acpi(a)vger.kernel.org; iommu(a)lists.linux-foundation.org; Wangzhou (B)
> <wangzhou1(a)hisilicon.com>; sudeep.holla(a)arm.com; bhelgaas(a)google.co=
m;
> linux-arm-kernel(a)lists.infradead.org; devel(a)acpica.org
> Subject: Re: [PATCH v9 2/4] iommu/dma: Add a helper function to reserve HW
> MSI address regions for IOMMU drivers
> =

> On Thu, Oct 26, 2017 at 10:11:58AM +0000, Shameerali Kolothum Thodi wrote:
> =

[..]

> >
> > As we still don=E2=80=99t have a clear resolution on how to invoke the
> > iort_iommu_msi_get_resv_regions(), I have gone back and attempted to
> > move the smmu model check inside the iort code. This means the
> > function will selectively apply HW MSI reservation based on the
> > platform and also the function can be invoked from the
> iommu_dma_get_resv_regions() directly.
> >
> > Could you please take a look at the below snippet and let me know your
> feedback.
> > Hope we can make some progress on this series.
> >
> > Thanks,
> > Shameer
> >
> > -->8--
> > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > index 876c0e1..a27233d 100644
> > --- a/drivers/acpi/arm64/iort.c
> > +++ b/drivers/acpi/arm64/iort.c
> > @@ -619,6 +619,39 @@ static int __maybe_unused __get_pci_rid(struct
> pci_dev *pdev, u16 alias,
> >  	return 0;
> >  }
> >
> > +static bool __maybe_unused iort_hw_msi_resv_enable(struct device *dev,
> > +					struct acpi_iort_node *node)
> > +{
> > +	struct acpi_iort_node *iommu =3D NULL;
> > +	int i;
> > +
> > +	if (dev_is_pci(dev)) {
> > +		u32 rid;
> > +
> > +		pci_for_each_dma_alias(to_pci_dev(dev), __get_pci_rid, &rid);
> > +		iommu =3D iort_node_map_id(node, rid, NULL,
> IORT_IOMMU_TYPE);
> > +	} else {
> > +		for (i =3D 0; i < node->mapping_count; i++) {
> > +			iommu =3D iort_node_map_platform_id(node, NULL,
> > +							IORT_IOMMU_TYPE,
> i);
> > +			if (iommu)
> > +				break;
> > +		}
> > +	}
> =

> You do not need (and I do not want this code) to do the mapping again.
> =

> You have the fwnode (ie dev->iommu_fwspec) corresponding to the IOMMU,
> you can retrieve the SMMU IORT node by a simple look-up and carry out the
> check below.

Ok. Understood. I will rework this part then.

> It would be simpler to set an option in the SMMUv3 driver but then you go=
 back
> to square one with DT/ACPI SMMUv3 driver awareness so, if, with the change
> above this can make the generic approach work (ie Robin is happy with it)=
 I am
> fine with this IORT update as well.

Thanks Lorenzo. I will rebase on top of rc1 and prepare v10 with these chan=
ges
and sent it out.

Shameer =


> > +
> > +	if (iommu && (iommu->type =3D=3D ACPI_IORT_NODE_SMMU_V3)) {
> > +		struct acpi_iort_smmu_v3 *smmu;
> > +
> > +		smmu =3D (struct acpi_iort_smmu_v3 *)iommu->node_data;
> > +		if (smmu->model =3D=3D
> ACPI_IORT_SMMU_V3_HISILICON_HI161X) {
> > +			dev_notice(dev, "Enabling HiSilicon erratum
> 161010801\n");
> > +			return true;
> > +		}
> > +	}
> > +
> > +	return false;
> > +}
> > +
> >  static int arm_smmu_iort_xlate(struct device *dev, u32 streamid,
> >  			       struct fwnode_handle *fwnode,
> >  			       const struct iommu_ops *ops) @@ -682,6 +715,9
> @@ int
> > iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head
> *head)
> >  	if (!node)
> >  		return -ENODEV;
> >
> > +	if (!iort_hw_msi_resv_enable(dev, node))
> > +		return 0;
> > +
> >  	/*
> >  	 * Current logic to reserve ITS regions relies on HW topologies
> >  	 * where a given PCI or named component maps its IDs to only one
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 9d1cebe..67c6e30 100644
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
> > @@ -174,6 +175,10 @@ void iommu_dma_get_resv_regions(struct device
> *dev, struct list_head *list)
> >  	struct pci_host_bridge *bridge;
> >  	struct resource_entry *window;
> >
> > +	if (!is_of_node(dev->iommu_fwspec->iommu_fwnode) &&
> > +		iort_iommu_msi_get_resv_regions(dev, list) < 0)
> > +		return;
> > +
> >  	if (!dev_is_pci(dev))
> >  		return;
> >
> > diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> > index 182a577..88f17c9 100644
> > --- a/include/linux/acpi_iort.h
> > +++ b/include/linux/acpi_iort.h
> > @@ -56,7 +56,7 @@ const struct iommu_ops *iort_iommu_configure(struct
> > device *dev)  { return NULL; }  static inline  int
> > iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head
> > *head) -{ return -ENODEV; }
> > +{ return 0; }
> >  #endif
> >
> >  #endif /* __ACPI_IORT_H__ */
> >
> > -->8--
> >
> >
> >

--===============6680869222410442831==--

