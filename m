Content-Type: multipart/mixed; boundary="===============2751609002302882989=="
MIME-Version: 1.0
From: Will Deacon <will.deacon at arm.com>
Subject: Re: [Devel] [PATCH v9 4/4] PCI: hisi: blacklist hip06/hip07
 controllers behind SMMUv3
Date: Wed, 18 Oct 2017 11:51:45 +0100
Message-ID: <20171018105145.GC11669@arm.com>
In-Reply-To: 5FC3163CFD30C246ABAA99954A238FA838437676@FRAEML521-MBS.china.huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2751609002302882989==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 15, 2017 at 07:46:34AM +0000, Shameerali Kolothum Thodi wrote:
> =

> =

> > -----Original Message-----
> > From: Will Deacon [mailto:will.deacon(a)arm.com]
> > Sent: Friday, October 13, 2017 8:22 PM
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi(a)huawei.com>
> > Cc: lorenzo.pieralisi(a)arm.com; marc.zyngier(a)arm.com;
> > sudeep.holla(a)arm.com; robin.murphy(a)arm.com; joro(a)8bytes.org;
> > bhelgaas(a)google.com; Gabriele Paoloni <gabriele.paoloni(a)huawei.com>;
> > John Garry <john.garry(a)huawei.com>; iommu(a)lists.linux-foundation.or=
g;
> > linux-arm-kernel(a)lists.infradead.org; linux-acpi(a)vger.kernel.org; l=
inux-
> > pci(a)vger.kernel.org; devel(a)acpica.org; Linuxarm <linuxarm(a)huawei.=
com>;
> > Wangzhou (B) <wangzhou1(a)hisilicon.com>; Guohanjun (Hanjun Guo)
> > <guohanjun(a)huawei.com>
> > Subject: Re: [PATCH v9 4/4] PCI: hisi: blacklist hip06/hip07 controller=
s behind
> > SMMUv3
> > =

> > On Fri, Oct 06, 2017 at 03:04:50PM +0100, Shameer Kolothum wrote:
> > > The HiSilicon erratum 161010801 describes the limitation of HiSilicon
> > > platforms hip06/hip07 to support the SMMUv3 mappings for MSI
> > > transactions.
> > >
> > > PCIe controller on these platforms has to differentiate the MSI
> > > payload against other DMA payload and has to modify the MSI payload.
> > > This basically makes it difficult for this platforms to have a SMMU
> > > translation for MSI. In order to workaround this, ARM
> > > SMMUv3 driver requires a quirk to treat the MSI regions separately.
> > > Such a quirk is currently missing for DT based systems and therefore
> > > we need to blacklist the hip06/hip07 PCIe controllers.
> > >
> > > Signed-off-by: Shameer Kolothum
> > <shameerali.kolothum.thodi(a)huawei.com>
> > > ---
> > >  drivers/pci/dwc/pcie-hisi.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/drivers/pci/dwc/pcie-hisi.c b/drivers/pci/dwc/pcie-hisi.c
> > > index a201791..6800747 100644
> > > --- a/drivers/pci/dwc/pcie-hisi.c
> > > +++ b/drivers/pci/dwc/pcie-hisi.c
> > > @@ -270,6 +270,12 @@ static int hisi_pcie_probe(struct platform_device
> > *pdev)
> > >  	struct resource *reg;
> > >  	int ret;
> > >
> > > +	if ((IS_BUILTIN(CONFIG_ARM_SMMU_V3)) &&
> > > +			of_property_read_bool(dev->of_node, "iommu-
> > map")) {
> > > +		dev_warn(dev, "HiSilicon erratum 161010801: blacklisting
> > PCIe controllers behind SMMUv3\n");
> > > +		return -ENODEV;
> > > +	}
> > > +
> > >  	hisi_pcie =3D devm_kzalloc(dev, sizeof(*hisi_pcie), GFP_KERNEL);
> > >  	if (!hisi_pcie)
> > >  		return -ENOMEM;
> > > @@ -340,6 +346,12 @@ static int hisi_pcie_almost_ecam_probe(struct
> > platform_device *pdev)
> > >  	struct device *dev =3D &pdev->dev;
> > >  	struct pci_ecam_ops *ops;
> > >
> > > +	if ((IS_BUILTIN(CONFIG_ARM_SMMU_V3)) &&
> > > +			of_property_read_bool(dev->of_node, "iommu-
> > map")) {
> > > +		dev_warn(dev, "HiSilicon erratum 161010801: blacklisting
> > PCIe controllers behind SMMUv3\n");
> > > +		return -ENODEV;
> > > +	}
> > =

> > This isn't the right way to solve this problem. I was really hoping you=
'd come
> > up with a solution for DT, and I know you've been trying, so I suppose =
for
> > now we'll just have to go with the ACPI workaround you have and leave D=
T in
> > the balance. I'm not at all happy with that, but I don't think this pat=
ch really
> > improves things.
> =

> Yes Will, this is to get the ACPI support enabled for now. =

> =

> > What I think you should do is remove the relevant smmu/iommu-map
> > entries from the .dts files that are available for these platforms (i.e.
> > comment them out with a description as to why).
> =

> We don't have any smmu/iommu-map entries for these platforms in the =

> .dts files [1][2]. We are not aiming for any official DT support for thes=
e platforms.
> This patch is to enforce the non-support.

Understood, but this has dragged on for a while and I don't think this patch
is the right way to enforce things. The best approach might actually be to
add the SMMU to the DTs, but commented out with a comment explaining why
it's not a good idea to enable it.

Will

--===============2751609002302882989==--

