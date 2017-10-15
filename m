Content-Type: multipart/mixed; boundary="===============1511222786309951451=="
MIME-Version: 1.0
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi at huawei.com>
Subject: Re: [Devel] [PATCH v9 4/4] PCI: hisi: blacklist hip06/hip07
 controllers behind SMMUv3
Date: Sun, 15 Oct 2017 07:46:34 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838437676@FRAEML521-MBS.china.huawei.com>
In-Reply-To: 20171013192209.GH30572@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1511222786309951451==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Will Deacon [mailto:will.deacon(a)arm.com]
> Sent: Friday, October 13, 2017 8:22 PM
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
> Subject: Re: [PATCH v9 4/4] PCI: hisi: blacklist hip06/hip07 controllers =
behind
> SMMUv3
> =

> On Fri, Oct 06, 2017 at 03:04:50PM +0100, Shameer Kolothum wrote:
> > The HiSilicon erratum 161010801 describes the limitation of HiSilicon
> > platforms hip06/hip07 to support the SMMUv3 mappings for MSI
> > transactions.
> >
> > PCIe controller on these platforms has to differentiate the MSI
> > payload against other DMA payload and has to modify the MSI payload.
> > This basically makes it difficult for this platforms to have a SMMU
> > translation for MSI. In order to workaround this, ARM
> > SMMUv3 driver requires a quirk to treat the MSI regions separately.
> > Such a quirk is currently missing for DT based systems and therefore
> > we need to blacklist the hip06/hip07 PCIe controllers.
> >
> > Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi(a)huawei.com>
> > ---
> >  drivers/pci/dwc/pcie-hisi.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/pci/dwc/pcie-hisi.c b/drivers/pci/dwc/pcie-hisi.c
> > index a201791..6800747 100644
> > --- a/drivers/pci/dwc/pcie-hisi.c
> > +++ b/drivers/pci/dwc/pcie-hisi.c
> > @@ -270,6 +270,12 @@ static int hisi_pcie_probe(struct platform_device
> *pdev)
> >  	struct resource *reg;
> >  	int ret;
> >
> > +	if ((IS_BUILTIN(CONFIG_ARM_SMMU_V3)) &&
> > +			of_property_read_bool(dev->of_node, "iommu-
> map")) {
> > +		dev_warn(dev, "HiSilicon erratum 161010801: blacklisting
> PCIe controllers behind SMMUv3\n");
> > +		return -ENODEV;
> > +	}
> > +
> >  	hisi_pcie =3D devm_kzalloc(dev, sizeof(*hisi_pcie), GFP_KERNEL);
> >  	if (!hisi_pcie)
> >  		return -ENOMEM;
> > @@ -340,6 +346,12 @@ static int hisi_pcie_almost_ecam_probe(struct
> platform_device *pdev)
> >  	struct device *dev =3D &pdev->dev;
> >  	struct pci_ecam_ops *ops;
> >
> > +	if ((IS_BUILTIN(CONFIG_ARM_SMMU_V3)) &&
> > +			of_property_read_bool(dev->of_node, "iommu-
> map")) {
> > +		dev_warn(dev, "HiSilicon erratum 161010801: blacklisting
> PCIe controllers behind SMMUv3\n");
> > +		return -ENODEV;
> > +	}
> =

> This isn't the right way to solve this problem. I was really hoping you'd=
 come
> up with a solution for DT, and I know you've been trying, so I suppose for
> now we'll just have to go with the ACPI workaround you have and leave DT =
in
> the balance. I'm not at all happy with that, but I don't think this patch=
 really
> improves things.

Yes Will, this is to get the ACPI support enabled for now. =


> What I think you should do is remove the relevant smmu/iommu-map
> entries from the .dts files that are available for these platforms (i.e.
> comment them out with a description as to why).

We don't have any smmu/iommu-map entries for these platforms in the =

.dts files [1][2]. We are not aiming for any official DT support for these =
platforms.
This patch is to enforce the non-support.

Thanks,
Shameer

1. http://elixir.free-electrons.com/linux/v4.14-rc4/source/arch/arm64/boot/=
dts/hisilicon/hip07.dtsi
2. http://elixir.free-electrons.com/linux/v4.14-rc4/source/arch/arm64/boot/=
dts/hisilicon/hip06.dtsi





--===============1511222786309951451==--

