Content-Type: multipart/mixed; boundary="===============7399291259264543809=="
MIME-Version: 1.0
From: Shameer Kolothum <shameerali.kolothum.thodi at huawei.com>
Subject: [Devel] [PATCH v9 4/4] PCI: hisi: blacklist hip06/hip07 controllers
 behind SMMUv3
Date: Fri, 06 Oct 2017 15:04:50 +0100
Message-ID: <20171006140450.89652-5-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: 20171006140450.89652-1-shameerali.kolothum.thodi@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7399291259264543809==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The HiSilicon erratum 161010801 describes the limitation of
HiSilicon platforms hip06/hip07 to support the SMMUv3 mappings
for MSI transactions.

PCIe controller on these platforms has to differentiate the MSI
payload against other DMA payload and has to modify the MSI
payload. This basically makes it difficult for this platforms to
have a SMMU translation for MSI. In order to workaround this, ARM
SMMUv3 driver requires a quirk to treat the MSI regions separately.
Such a quirk is currently missing for DT based systems and therefore
we need to blacklist the hip06/hip07 PCIe controllers.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi(a)huawei.com>
---
 drivers/pci/dwc/pcie-hisi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/dwc/pcie-hisi.c b/drivers/pci/dwc/pcie-hisi.c
index a201791..6800747 100644
--- a/drivers/pci/dwc/pcie-hisi.c
+++ b/drivers/pci/dwc/pcie-hisi.c
@@ -270,6 +270,12 @@ static int hisi_pcie_probe(struct platform_device *pde=
v)
 	struct resource *reg;
 	int ret;
 =

+	if ((IS_BUILTIN(CONFIG_ARM_SMMU_V3)) &&
+			of_property_read_bool(dev->of_node, "iommu-map")) {
+		dev_warn(dev, "HiSilicon erratum 161010801: blacklisting PCIe controller=
s behind SMMUv3\n");
+		return -ENODEV;
+	}
+
 	hisi_pcie =3D devm_kzalloc(dev, sizeof(*hisi_pcie), GFP_KERNEL);
 	if (!hisi_pcie)
 		return -ENOMEM;
@@ -340,6 +346,12 @@ static int hisi_pcie_almost_ecam_probe(struct platform=
_device *pdev)
 	struct device *dev =3D &pdev->dev;
 	struct pci_ecam_ops *ops;
 =

+	if ((IS_BUILTIN(CONFIG_ARM_SMMU_V3)) &&
+			of_property_read_bool(dev->of_node, "iommu-map")) {
+		dev_warn(dev, "HiSilicon erratum 161010801: blacklisting PCIe controller=
s behind SMMUv3\n");
+		return -ENODEV;
+	}
+
 	ops =3D (struct pci_ecam_ops *)of_device_get_match_data(dev);
 	return pci_host_common_probe(pdev, ops);
 }
-- =

1.9.1



--===============7399291259264543809==--

