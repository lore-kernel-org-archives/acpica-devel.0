Content-Type: multipart/mixed; boundary="===============8028801987810181741=="
MIME-Version: 1.0
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi at huawei.com>
Subject: Re: [Devel] [PATCH v9 0/4] iommu/smmu-v3: Workaround for hisilicon
 161010801 erratum(reserve HW MSI)
Date: Wed, 11 Oct 2017 11:34:18 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8384228BC@FRAEML521-MBX.china.huawei.com>
In-Reply-To: 20171006140450.89652-1-shameerali.kolothum.thodi@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8028801987810181741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Will,

Any further comments on this series, please? =


We do have the ack from all relevant people for the "[PATCH v9 4/4] PCI: hi=
si: blacklist
hip06/hip07 controllers behind SMMUv3" now. =


Really appreciate if you can take a look and let us know.

Many thanks,
Shameer

> -----Original Message-----
> From: Shameerali Kolothum Thodi
> Sent: Friday, October 06, 2017 3:05 PM
> To: lorenzo.pieralisi(a)arm.com; marc.zyngier(a)arm.com;
> sudeep.holla(a)arm.com; will.deacon(a)arm.com; robin.murphy(a)arm.com;
> joro(a)8bytes.org; bhelgaas(a)google.com; Gabriele Paoloni
> <gabriele.paoloni(a)huawei.com>
> Cc: John Garry <john.garry(a)huawei.com>; iommu(a)lists.linux-
> foundation.org; linux-arm-kernel(a)lists.infradead.org; linux-
> acpi(a)vger.kernel.org; linux-pci(a)vger.kernel.org; devel(a)acpica.org;
> Linuxarm <linuxarm(a)huawei.com>; Wangzhou (B)
> <wangzhou1(a)hisilicon.com>; Guohanjun (Hanjun Guo)
> <guohanjun(a)huawei.com>; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi(a)huawei.com>
> Subject: [PATCH v9 0/4] iommu/smmu-v3: Workaround for hisilicon
> 161010801 erratum(reserve HW MSI)
> =

> On certain HiSilicon platforms (hip06/hip07) the GIC ITS and PCIe RC
> deviates from the standard implementation and this breaks PCIe MSI
> functionality when SMMU is enabled.
> =

> The HiSilicon erratum 161010801 describes this limitation of certain
> HiSilicon platforms to support the SMMU mappings for MSI transactions.
> On these platforms GICv3 ITS translator is presented with the deviceID
> by extending the MSI payload data to 64 bits to include the deviceID.
> Hence, the PCIe controller on this platforms has to differentiate the MSI
> payload against other DMA payload and has to modify the MSI payload.
> This basically makes it difficult for this platforms to have a SMMU
> translation for MSI.
> =

> This patch implements an ACPI and DT based quirk to reserve the hw msi
> regions in the smmu-v3 driver which means these address regions will
> not be translated and will be excluded from iova allocations.
> =

> To implement this quirk, the following changes are incorporated:
> 1. Added a generic helper function to IORT code to retrieve the
>    associated ITS base address from a device IORT node.
> 2. Added a generic helper function to of iommu code to retrieve the
>    associated msi controller base address from for a PCI RC
>    msi-mapping and also platform device msi-parent.
> 3. Blacklisted HiSilicon PCIe controllers on DT based hip06/hip07
>    platforms when SMMUv3 is enabled as there is no DT based solution
>    for this as of now.
> =

> Changelog:
> =

> v8 --> v9
> -Thanks to Marc, fixed IORT helper function to reserve the ITS
>  translater region only.
> -Removed the DT support for MSI reservation and blacklisted
>  HiSilicon PCIe controllers on DT based systems when SMMUv3 is
>  enabled.
> =

> v7 --> v8
> Addressed comments from Rob and Lorenzo:
>  -Modified to use DT compatible string for errata.
>  -Changed logic to retrieve the msi-parent for DT case.
> =

> v6 --> v7
> Addressed request from Will to add DT support for the erratum:
>  - added bt binding
>  - add of_iommu_msi_get_resv_regions()
> New arm64 silicon errata entry
> Rename iort_iommu_{its->msi}_get_resv_regions
> =

> v5 --> v6
> Addressed comments from Robin and Lorenzo:
> -No change to patch#1 .
> -Reverted v5 patch#2 as this might break the platforms where this quirk
>   is not applicable. Provided a generic function in iommu code and added
>   back the quirk implementation in SMMU v3 driver(patch#3)
> =

> v4 --> v5
> Addressed comments from Robin and Lorenzo:
> -Added a comment to make it clear that, for now, only straightforward
>   HW topologies are handled while reserving ITS regions(patch #1).
> =

> v3 --> v4
> Rebased on 4.13-rc1.
> Addressed comments from Robin, Will and Lorenzo:
> -As suggested by Robin, moved the ITS msi reservation into
>   iommu_dma_get_resv_regions().
> -Added its_count !=3D resv region failure case(patch #1).
> =

> v2 --> v3
> Addressed comments from Lorenzo and Robin:
> -Removed dev_is_pci() check in smmuV3 driver.
> -Don't treat device not having an ITS mapping as an error in
>   iort helper function.
> =

> v1 --> v2
> -patch 2/2: Invoke iort helper fn based on fwnode type(acpi).
> =

> RFCv2 -->PATCH
> -Incorporated Lorenzo's review comments.
> =

> RFC v1 --> RFC v2
> Based on Robin's review comments,
> -Removed  the generic erratum framework.
> -Using IORT/MADT tables to retrieve the ITS base addr instead  of vendor
> specific CSRT table.
> =

> =

> Shameer Kolothum (4):
>   ACPI/IORT: Add msi address regions reservation helper
>   iommu/dma: Add a helper function to reserve HW MSI address regions for
>     IOMMU drivers
>   iommu/arm-smmu-v3:Enable ACPI based HiSilicon erratum 161010801
>   PCI: hisi: blacklist hip06/hip07 controllers behind SMMUv3
> =

>  drivers/acpi/arm64/iort.c        | 97
> ++++++++++++++++++++++++++++++++++++++--
>  drivers/iommu/arm-smmu-v3.c      | 27 ++++++++---
>  drivers/iommu/dma-iommu.c        | 20 +++++++++
>  drivers/irqchip/irq-gic-v3-its.c |  3 +-
>  drivers/pci/dwc/pcie-hisi.c      | 12 +++++
>  include/linux/acpi_iort.h        |  7 ++-
>  include/linux/dma-iommu.h        |  7 +++
>  7 files changed, 163 insertions(+), 10 deletions(-)
> =

> --
> 1.9.1
> =



--===============8028801987810181741==--

