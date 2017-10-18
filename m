Content-Type: multipart/mixed; boundary="===============8628500276815298703=="
MIME-Version: 1.0
From: Will Deacon <will.deacon at arm.com>
Subject: Re: [Devel] [PATCH v9 4/4] PCI: hisi: blacklist hip06/hip07
 controllers behind SMMUv3
Date: Wed, 18 Oct 2017 14:45:16 +0100
Message-ID: <20171018134515.GC21820@arm.com>
In-Reply-To: 5FC3163CFD30C246ABAA99954A238FA838448830@FRAEML521-MBX.china.huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8628500276815298703==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2017 at 12:25:09PM +0000, Shameerali Kolothum Thodi wrote:
> Hi Will,
> =

> > -----Original Message-----
> > From: Will Deacon [mailto:will.deacon(a)arm.com]
> > Sent: Wednesday, October 18, 2017 11:52 AM
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

> > On Sun, Oct 15, 2017 at 07:46:34AM +0000, Shameerali Kolothum Thodi wro=
te:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Will Deacon [mailto:will.deacon(a)arm.com]
> > > > Sent: Friday, October 13, 2017 8:22 PM
> > > > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi(a)huawei.c=
om>
> > > > Cc: lorenzo.pieralisi(a)arm.com; marc.zyngier(a)arm.com;
> > > > sudeep.holla(a)arm.com; robin.murphy(a)arm.com; joro(a)8bytes.org;
> > > > bhelgaas(a)google.com; Gabriele Paoloni <gabriele.paoloni(a)huawei.=
com>;
> > > > John Garry <john.garry(a)huawei.com>; iommu(a)lists.linux-foundatio=
n.org;
> > > > linux-arm-kernel(a)lists.infradead.org; linux-acpi(a)vger.kernel.or=
g; linux-
> > > > pci(a)vger.kernel.org; devel(a)acpica.org; Linuxarm
> > <linuxarm(a)huawei.com>;
> > > > Wangzhou (B) <wangzhou1(a)hisilicon.com>; Guohanjun (Hanjun Guo)
> > > > <guohanjun(a)huawei.com>
> > > > Subject: Re: [PATCH v9 4/4] PCI: hisi: blacklist hip06/hip07 contro=
llers
> > behind
> > > > SMMUv3
> > > >
> > > > On Fri, Oct 06, 2017 at 03:04:50PM +0100, Shameer Kolothum wrote:
> > > > > The HiSilicon erratum 161010801 describes the limitation of HiSil=
icon
> > > > > platforms hip06/hip07 to support the SMMUv3 mappings for MSI
> > > > > transactions.
> > > > >
> > > > > PCIe controller on these platforms has to differentiate the MSI
> > > > > payload against other DMA payload and has to modify the MSI paylo=
ad.
> > > > > This basically makes it difficult for this platforms to have a SM=
MU
> > > > > translation for MSI. In order to workaround this, ARM
> > > > > SMMUv3 driver requires a quirk to treat the MSI regions separatel=
y.
> > > > > Such a quirk is currently missing for DT based systems and theref=
ore
> > > > > we need to blacklist the hip06/hip07 PCIe controllers.
> > > > >
> > > > > Signed-off-by: Shameer Kolothum
> > > > <shameerali.kolothum.thodi(a)huawei.com>
> > > > > ---
> > > > >  drivers/pci/dwc/pcie-hisi.c | 12 ++++++++++++
> > > > >  1 file changed, 12 insertions(+)
> > > > >
> > > > > diff --git a/drivers/pci/dwc/pcie-hisi.c b/drivers/pci/dwc/pcie-h=
isi.c
> > > > > index a201791..6800747 100644
> > > > > --- a/drivers/pci/dwc/pcie-hisi.c
> > > > > +++ b/drivers/pci/dwc/pcie-hisi.c
> > > > > @@ -270,6 +270,12 @@ static int hisi_pcie_probe(struct platform_d=
evice
> > > > *pdev)
> > > > >  	struct resource *reg;
> > > > >  	int ret;
> > > > >
> > > > > +	if ((IS_BUILTIN(CONFIG_ARM_SMMU_V3)) &&
> > > > > +			of_property_read_bool(dev->of_node, "iommu-
> > > > map")) {
> > > > > +		dev_warn(dev, "HiSilicon erratum 161010801: blacklisting
> > > > PCIe controllers behind SMMUv3\n");
> > > > > +		return -ENODEV;
> > > > > +	}
> > > > > +
> > > > >  	hisi_pcie =3D devm_kzalloc(dev, sizeof(*hisi_pcie), GFP_KERNEL);
> > > > >  	if (!hisi_pcie)
> > > > >  		return -ENOMEM;
> > > > > @@ -340,6 +346,12 @@ static int hisi_pcie_almost_ecam_probe(struct
> > > > platform_device *pdev)
> > > > >  	struct device *dev =3D &pdev->dev;
> > > > >  	struct pci_ecam_ops *ops;
> > > > >
> > > > > +	if ((IS_BUILTIN(CONFIG_ARM_SMMU_V3)) &&
> > > > > +			of_property_read_bool(dev->of_node, "iommu-
> > > > map")) {
> > > > > +		dev_warn(dev, "HiSilicon erratum 161010801: blacklisting
> > > > PCIe controllers behind SMMUv3\n");
> > > > > +		return -ENODEV;
> > > > > +	}
> > > >
> > > > This isn't the right way to solve this problem. I was really hoping=
 you'd
> > come
> > > > up with a solution for DT, and I know you've been trying, so I supp=
ose for
> > > > now we'll just have to go with the ACPI workaround you have and lea=
ve DT
> > in
> > > > the balance. I'm not at all happy with that, but I don't think this=
 patch really
> > > > improves things.
> > >
> > > Yes Will, this is to get the ACPI support enabled for now.
> > >
> > > > What I think you should do is remove the relevant smmu/iommu-map
> > > > entries from the .dts files that are available for these platforms =
(i.e.
> > > > comment them out with a description as to why).
> > >
> > > We don't have any smmu/iommu-map entries for these platforms in the
> > > .dts files [1][2]. We are not aiming for any official DT support for =
these
> > platforms.
> > > This patch is to enforce the non-support.
> > =

> > Understood, but this has dragged on for a while and I don't think this =
patch
> > is the right way to enforce things. The best approach might actually be=
 to
> > add the SMMU to the DTs, but commented out with a comment explaining why
> > it's not a good idea to enable it.
> =

> Ok. Just to clarify, you would like to replace this patch with another =

> one with smmu entries in dts and commenting/disabling them with explanati=
on.
> Or you would like to have that in addition to this one?

Yes, I'm saying let's do that instead. My preference is still that we would
have all of this working for DT, but it's clear that isn't going to happen
and so I'm trying to unblock the ACPI bits whilst not having subtle breakage
with DT.

> +	/** HiSilicon erratum 161010801: Please make sure that
> +	 *  the smmu (pcie) node on hip06 is disabled as this will
> +	 *  break the PCIe functionality when iommu-map entry
> +	 *  is used along with the PCIe node.

It would be good to have a better description of what is broken and why,
along with a link to the mailing link discussion.

Will

--===============8628500276815298703==--

