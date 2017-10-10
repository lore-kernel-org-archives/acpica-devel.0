Content-Type: multipart/mixed; boundary="===============8878469780119742314=="
MIME-Version: 1.0
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi at huawei.com>
Subject: Re: [Devel] [PATCH v9 4/4] PCI: hisi: blacklist hip06/hip07
 controllers behind SMMUv3
Date: Tue, 10 Oct 2017 09:42:30 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838421875@FRAEML521-MBX.china.huawei.com>
In-Reply-To: 20171009235452.GP25517@bhelgaas-glaptop.roam.corp.google.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8878469780119742314==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

HI Bjorn,

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas(a)kernel.org]
> Sent: Tuesday, October 10, 2017 12:55 AM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi(a)huawei.com>
> Cc: lorenzo.pieralisi(a)arm.com; marc.zyngier(a)arm.com;
> sudeep.holla(a)arm.com; will.deacon(a)arm.com; robin.murphy(a)arm.com;
> joro(a)8bytes.org; bhelgaas(a)google.com; Gabriele Paoloni
> <gabriele.paoloni(a)huawei.com>; John Garry <john.garry(a)huawei.com>;
> iommu(a)lists.linux-foundation.org; linux-arm-kernel(a)lists.infradead.or=
g;
> linux-acpi(a)vger.kernel.org; linux-pci(a)vger.kernel.org; devel(a)acpica=
.org;
> Linuxarm <linuxarm(a)huawei.com>; Wangzhou (B)
> <wangzhou1(a)hisilicon.com>; Guohanjun (Hanjun Guo)
> <guohanjun(a)huawei.com>
> Subject: Re: [PATCH v9 4/4] PCI: hisi: blacklist hip06/hip07 controllers =
behind
> SMMUv3
> =

> Please change subject line:
> =

> -  PCI: hisi: blacklist hip06/hip07 controllers behind SMMUv3
> +  PCI: hisi: Blacklist hip06/hip07 controllers behind SMMUv3

Ok.

> On Fri, Oct 06, 2017 at 03:04:50PM +0100, Shameer Kolothum wrote:
> > The HiSilicon erratum 161010801 describes the limitation of HiSilicon
> > platforms hip06/hip07 to support the SMMUv3 mappings for MSI
> > transactions.
> =

> I don't suppose there's a URL for this erratum, is there?

We don't have anything public at the moment. This is part of the internal
documentation at the moment.

> > PCIe controller on these platforms has to differentiate the MSI
> > payload against other DMA payload and has to modify the MSI payload.
> > This basically makes it difficult for this platforms to have a SMMU
> > translation for MSI. In order to workaround this, ARM
> > SMMUv3 driver requires a quirk to treat the MSI regions separately.
> > Such a quirk is currently missing for DT based systems and therefore
> > we need to blacklist the hip06/hip07 PCIe controllers.
> =

> I don't understand the DT connection here.  If this is a hardware erratum=
, I
> assume the a quirk would be required whether the system uses DT, ACPI,
> etc.

Yes, this is a hardware erratum and we are almost there to add the ACPI
quirk into the SMMUv3 driver for this.  But we got the feedback that =

either we have to have the DT support or we should blacklist the affected
devices so that from the SMMUv3 driver point of view it will not run into t=
he
quirk unnecessarily[1].

We attempted to provide a DT solution, but it looks like DT requires more
discussions and a more generic approach than ACPI[2]. Hence we are blacklis=
ting
the PCIe for now so that we can have the ACPI support goes through. (Also w=
e =

don't have the DT binding in the mainline which support SMMU on these =

platforms and also DT is not officially supported for these platforms).

> > Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi(a)huawei.com>
> =

> I assume this will go via some non-PCI tree.  If I were applying this, I =
would
> look for an ack from Zhou or Gabriele in addition to mine.
> =

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
> =

> Does the presence of "iommu-map" tell you this is an SMMUv3?  Could it
> have a different type of IOMMU?  I can't tell from reading
> Documentation/devicetree/bindings/pci/pci-iommu.txt.

Only if the SMMUv3 driver is loaded and iommu-map binding property present,
the pcie devices will use SMMU translated iova for MSI doorbell addresses.

> Why do you care whether CONFIG_ARM_SMMU_V3 is set?  Does MSI work
> correctly if SMMUv3 is present but not used?

Yes. MSI will work if no SMMUv3 is used.

> Is it really necessary to ignore the PCIe controller completely?
> Could you use the devices below it as long as you disable MSI for them?  I
> know there are probably devices that require MSI, so maybe it's easier to
> just ignore everything than to respond to reports of "my device doesn't w=
ork
> because it requires MSI."

We are blacklisting MSI for PCIe only if the kernel is using DT and is conf=
igured
to use SMMUv3. Otherwise it is fine. And as I said above DT is not official=
ly
supported on these platforms.

Thanks,
Shameer

1. [PATCH v6 3/3] iommu/arm-smmu-v3:Enable ACPI based HiSilicon erratum 161=
010801
https://www.spinics.net/lists/arm-kernel/msg602873.html
2. [PATCH v8 3/5] iommu/of: Add msi address regions reservation helper
https://www.spinics.net/lists/arm-kernel/msg609431.html


--===============8878469780119742314==--

