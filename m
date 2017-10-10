Content-Type: multipart/mixed; boundary="===============4381233676222056777=="
MIME-Version: 1.0
From: Lorenzo Pieralisi <lorenzo.pieralisi at arm.com>
Subject: Re: [Devel] [PATCH v9 4/4] PCI: hisi: blacklist hip06/hip07
 controllers behind SMMUv3
Date: Tue, 10 Oct 2017 11:06:30 +0100
Message-ID: <20171010100630.GA764@red-moon>
In-Reply-To: 5FC3163CFD30C246ABAA99954A238FA838421875@FRAEML521-MBX.china.huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4381233676222056777==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2017 at 09:42:30AM +0000, Shameerali Kolothum Thodi wrote:

[...]

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
> > =

> > Does the presence of "iommu-map" tell you this is an SMMUv3?  Could it
> > have a different type of IOMMU?  I can't tell from reading
> > Documentation/devicetree/bindings/pci/pci-iommu.txt.
> =

> Only if the SMMUv3 driver is loaded and iommu-map binding property presen=
t,
> the pcie devices will use SMMU translated iova for MSI doorbell addresses.

And the iommu-map property _actually_ points at an OF node with an
SMMUv3 compatible string - the sheer fact that the SMMUv3 driver
is compiled in is not sufficient IIUC.

Lorenzo

> > Why do you care whether CONFIG_ARM_SMMU_V3 is set?  Does MSI work
> > correctly if SMMUv3 is present but not used?
> =

> Yes. MSI will work if no SMMUv3 is used.
> =

> > Is it really necessary to ignore the PCIe controller completely?
> > Could you use the devices below it as long as you disable MSI for them?=
  I
> > know there are probably devices that require MSI, so maybe it's easier =
to
> > just ignore everything than to respond to reports of "my device doesn't=
 work
> > because it requires MSI."
> =

> We are blacklisting MSI for PCIe only if the kernel is using DT and is co=
nfigured
> to use SMMUv3. Otherwise it is fine. And as I said above DT is not offici=
ally
> supported on these platforms.
> =

> Thanks,
> Shameer
> =

> 1. [PATCH v6 3/3] iommu/arm-smmu-v3:Enable ACPI based HiSilicon erratum 1=
61010801
> https://www.spinics.net/lists/arm-kernel/msg602873.html
> 2. [PATCH v8 3/5] iommu/of: Add msi address regions reservation helper
> https://www.spinics.net/lists/arm-kernel/msg609431.html
> =

> =

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel(a)lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4381233676222056777==--

