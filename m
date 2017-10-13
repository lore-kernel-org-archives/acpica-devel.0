Content-Type: multipart/mixed; boundary="===============3596061681563828280=="
MIME-Version: 1.0
From: Will Deacon <will.deacon at arm.com>
Subject: Re: [Devel] [PATCH v9 4/4] PCI: hisi: blacklist hip06/hip07
 controllers behind SMMUv3
Date: Fri, 13 Oct 2017 20:22:10 +0100
Message-ID: <20171013192209.GH30572@arm.com>
In-Reply-To: 20171006140450.89652-5-shameerali.kolothum.thodi@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3596061681563828280==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2017 at 03:04:50PM +0100, Shameer Kolothum wrote:
> The HiSilicon erratum 161010801 describes the limitation of
> HiSilicon platforms hip06/hip07 to support the SMMUv3 mappings
> for MSI transactions.
> =

> PCIe controller on these platforms has to differentiate the MSI
> payload against other DMA payload and has to modify the MSI
> payload. This basically makes it difficult for this platforms to
> have a SMMU translation for MSI. In order to workaround this, ARM
> SMMUv3 driver requires a quirk to treat the MSI regions separately.
> Such a quirk is currently missing for DT based systems and therefore
> we need to blacklist the hip06/hip07 PCIe controllers.
> =

> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi(a)huawei.com>
> ---
>  drivers/pci/dwc/pcie-hisi.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> =

> diff --git a/drivers/pci/dwc/pcie-hisi.c b/drivers/pci/dwc/pcie-hisi.c
> index a201791..6800747 100644
> --- a/drivers/pci/dwc/pcie-hisi.c
> +++ b/drivers/pci/dwc/pcie-hisi.c
> @@ -270,6 +270,12 @@ static int hisi_pcie_probe(struct platform_device *p=
dev)
>  	struct resource *reg;
>  	int ret;
>  =

> +	if ((IS_BUILTIN(CONFIG_ARM_SMMU_V3)) &&
> +			of_property_read_bool(dev->of_node, "iommu-map")) {
> +		dev_warn(dev, "HiSilicon erratum 161010801: blacklisting PCIe controll=
ers behind SMMUv3\n");
> +		return -ENODEV;
> +	}
> +
>  	hisi_pcie =3D devm_kzalloc(dev, sizeof(*hisi_pcie), GFP_KERNEL);
>  	if (!hisi_pcie)
>  		return -ENOMEM;
> @@ -340,6 +346,12 @@ static int hisi_pcie_almost_ecam_probe(struct platfo=
rm_device *pdev)
>  	struct device *dev =3D &pdev->dev;
>  	struct pci_ecam_ops *ops;
>  =

> +	if ((IS_BUILTIN(CONFIG_ARM_SMMU_V3)) &&
> +			of_property_read_bool(dev->of_node, "iommu-map")) {
> +		dev_warn(dev, "HiSilicon erratum 161010801: blacklisting PCIe controll=
ers behind SMMUv3\n");
> +		return -ENODEV;
> +	}

This isn't the right way to solve this problem. I was really hoping you'd
come up with a solution for DT, and I know you've been trying, so I suppose
for now we'll just have to go with the ACPI workaround you have and leave DT
in the balance. I'm not at all happy with that, but I don't think this patch
really improves things.

What I think you should do is remove the relevant smmu/iommu-map entries
from the .dts files that are available for these platforms (i.e. comment
them out with a description as to why).

Will

--===============3596061681563828280==--

