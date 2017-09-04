Content-Type: multipart/mixed; boundary="===============1997609760018538001=="
MIME-Version: 1.0
From: Lorenzo Pieralisi <lorenzo.pieralisi at arm.com>
Subject: Re: [Devel] [PATCH v6 3/3] iommu/arm-smmu-v3:Enable ACPI based
 HiSilicon erratum 161010801
Date: Mon, 04 Sep 2017 18:09:28 +0100
Message-ID: <20170904170928.GB20601@red-moon>
In-Reply-To: 47b8bf19-abad-3503-2e1c-b9d1304a157e@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1997609760018538001==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2017 at 09:46:00AM +0100, John Garry wrote:
> On 10/08/2017 18:27, Will Deacon wrote:
> >On Wed, Aug 09, 2017 at 11:07:15AM +0100, Shameer Kolothum wrote:
> >>The HiSilicon erratum 161010801 describes the limitation of HiSilicon
> >>platforms Hip06/Hip07 to support the SMMU mappings for MSI transactions.
> >>
> >>On these platforms GICv3 ITS translator is presented with the deviceID
> >>by extending the MSI payload data to 64 bits to include the deviceID.
> >>Hence, the PCIe controller on this platforms has to differentiate the
> >>MSI payload against other DMA payload and has to modify the MSI payload.
> >>This basically makes it difficult for this platforms to have a SMMU
> >>translation for MSI.
> >>
> >>This patch implements a ACPI table based quirk to reserve the hw msi
> >>regions in the smmu-v3 driver which means these address regions will
> >>not be translated and will be excluded from iova allocations.
> >>
> >>Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi(a)huawei.com>
> >>---
> >> drivers/iommu/arm-smmu-v3.c | 27 ++++++++++++++++++++++-----
> >> 1 file changed, 22 insertions(+), 5 deletions(-)
> >
> >Please can you also add a devicetree binding with corresponding
> >documentation to enable this workaround on non-ACPI based systems too? It
> >should be straightforward if you update the arm_smmu_options table.
> >
> =

> Hi Will, Lorenzo, Robin,
> =

> I have created the patch to add DT support for this erratum.
> However, currently I have only added support for pci-based devices.
> I'm a bit stumped on how to add platform device support, or if we
> should also add support at all. And I would rather ask before
> sending the patches.
> =

> The specific issue is that I know of no platform device with an ITS
> msi-parent which we would want reserve, i.e. do not translate msi.
> And, if there were, how to do it.
> =

> The only platform devices I know off with msi ITS parents are SMMUv3
> and mbigen. For mbigen, the msi are not translated. Actually, as I
> see under IORT solution, for mbigen we don't reserve the hw msi
> region as the SMMUv3 does not have an ID mapping. And we have no
> equivalent ID mapping property for DT SMMUv3, so cannot create an
> equivalent check.
> =

> So here is how the DT iommu get reserved region function with only
> pci device support looks:
> =

> /**
>  * of_iommu_its_get_resv_regions - Reserved region driver helper
>  * @dev: Device from iommu_get_resv_regions()
>  * @list: Reserved region list from iommu_get_resv_regions()
>  *
>  * Returns: Number of reserved regions on success(0 if no associated ITS),
>  *          appropriate error value otherwise.
>  */
> int of_iommu_its_get_resv_regions(struct device *dev, struct
> list_head *head)
> {
>     struct device_node *of_node =3D NULL;
>     struct device *parent_dev;
>     const __be32 *msi_map;
>     int num_mappings, i, err, len, resv =3D 0;
> =

>     /* walk up to find the parent with a msi-map property */
>     for (parent_dev =3D dev; parent_dev; parent_dev =3D parent_dev->paren=
t) {
>         if (!parent_dev->of_node)
>             continue;
> =

>         /*
>          * Current logic to reserve ITS regions for only PCI root
>          * complex.
>          */
>         msi_map =3D of_get_property(parent_dev->of_node, "msi-map", &len);
>         if (msi_map) {
>             of_node =3D parent_dev->of_node;
>             break;
>         }
>     }
> =

>     if (!of_node)
>         return 0;
> =

>     num_mappings =3D of_count_phandle_with_args(of_node, "msi-map",
> NULL) / 4;
> =

>     for (i =3D 0; i < num_mappings; i++) {
>         int prot =3D IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
>         struct iommu_resv_region *region;
>         struct device_node *msi_node;
>         struct resource resource;
>         u32 phandle;
> =

>         phandle =3D be32_to_cpup(msi_map + 1);
>         msi_node =3D of_find_node_by_phandle(phandle);
>         if (!msi_node)
>             return -ENODEV;
> =

>         /*
>          * There may be different types of msi-controller, so check
>          * for ITS.
>          */
>         if (!of_device_is_compatible(msi_node, "arm,gic-v3-its")) {
>             of_node_put(msi_node);
>             continue;
>         }
> =

>         err =3D of_address_to_resource(msi_node, 0, &resource);
> =

>         of_node_put(msi_node);
>         if (err)
>             return err;
> =

>         region =3D iommu_alloc_resv_region(resource.start, SZ_128K, prot,
>                          IOMMU_RESV_MSI);
>         if (region) {
>             list_add_tail(&region->list, head);
>             resv++;
>         }
>     }
> =

>     return (resv =3D=3D num_mappings) ? resv : -ENODEV;
> }
> =

> Any feedback is appreciated.

Hi John,

I appreciate it is not trivial to make the code generic, part of the
snippet above can be shared between ACPI/IORT and OF, the only sticking
point is probably the "compatible" string that has to be parameterized
since having this code in generic IOMMU layer is a bit horrible to
have it ITS specific (and it is a problem that was existing already
in the original patch with the hardcoded ITS node type or function
name).

To sum it up the hook:

- has to be called from SMMU driver in a firmware agnostic way
- somehow it has to ascertain which interrupt controller "compatible"
  (which in IORT is a node type) to match against so the hook has to
  take an id of sorts

I need to go back and have a look at the original patch to see how
we can accommodate both OF/ACPI - certainly the region reservations
code can and should be shared.

Lorenzo

--===============1997609760018538001==--

