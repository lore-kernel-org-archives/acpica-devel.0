Return-Path: <LeoLiu-oc@zhaoxin.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5FDC2408E4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E3EDC408EB
From: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Message-ID: <20230704120544.1322315-1-LeoLiu-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Acpica-devel] [PATCH v3 4/5] ACPI/PCI: Add
	pci_acpi_program_hest_aer_params()
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Tue, 04 Jul 2023 12:20:43 -0000
To: lenb@kernel.org, james.morse@arm.com, tony.luck@intel.com, bp@alien8.de, bhelgaas@google.com, robert.moore@intel.com, leoliu-oc@zhaoxin.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, acpica-devel@lists.linuxfoundation.org

From: leoliu-oc <leoliu-oc@zhaoxin.com>

The extracted register values from HEST PCI Express AER structures are
written to AER Capabilities.

Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
---
 drivers/pci/pci-acpi.c | 92 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h      |  5 +++
 2 files changed, 97 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index a05350a4e49cb..cff54410e2427 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -18,6 +18,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/pm_qos.h>
 #include <linux/rwsem.h>
+#include <acpi/apei.h>
 #include "pci.h"
 
 /*
@@ -783,6 +784,97 @@ int pci_acpi_program_hp_params(struct pci_dev *dev)
 	return -ENODEV;
 }
 
+/*
+ * program_aer_structure_to_aer_registers - Write the AER structure to
+ * the corresponding dev's AER registers.
+ *
+ * @info - the AER structure information
+ *
+ */
+static void program_aer_structure_to_aer_registers(struct acpi_hest_parse_aer_info info)
+{
+	u32 uncorrectable_mask;
+	u32 uncorrectable_severity;
+	u32 correctable_mask;
+	u32 advanced_capabilities;
+	u32 root_error_command;
+	u32 uncorrectable_mask2;
+	u32 uncorrectable_severity2;
+	u32 advanced_capabilities2;
+	int port_type;
+	int pos;
+	struct pci_dev *dev;
+
+	dev = info.pci_dev;
+	port_type = pci_pcie_type(dev);
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+	if (!pos)
+		return;
+
+	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
+		uncorrectable_mask = info.acpi_hest_aer_root_port->uncorrectable_mask;
+		uncorrectable_severity = info.acpi_hest_aer_root_port->uncorrectable_severity;
+		correctable_mask = info.acpi_hest_aer_root_port->correctable_mask;
+		advanced_capabilities = info.acpi_hest_aer_root_port->advanced_capabilities;
+		root_error_command = info.acpi_hest_aer_root_port->root_error_command;
+
+		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, uncorrectable_mask);
+		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, uncorrectable_severity);
+		pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, correctable_mask);
+		pci_write_config_dword(dev, pos + PCI_ERR_CAP, advanced_capabilities);
+		pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, root_error_command);
+	} else if (port_type == PCI_EXP_TYPE_ENDPOINT) {
+		uncorrectable_mask = info.acpi_hest_aer_endpoint->uncorrectable_mask;
+		uncorrectable_severity = info.acpi_hest_aer_endpoint->uncorrectable_severity;
+		correctable_mask = info.acpi_hest_aer_endpoint->correctable_mask;
+		advanced_capabilities = info.acpi_hest_aer_endpoint->advanced_capabilities;
+
+		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, uncorrectable_mask);
+		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, uncorrectable_severity);
+		pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, correctable_mask);
+		pci_write_config_dword(dev, pos + PCI_ERR_CAP, advanced_capabilities);
+	} else if ((pci_pcie_type(dev) == PCI_EXP_TYPE_PCI_BRIDGE) ||
+				(pci_pcie_type(dev) == PCI_EXP_TYPE_PCIE_BRIDGE)) {
+		uncorrectable_mask = info.acpi_hest_aer_for_bridge->uncorrectable_mask;
+		uncorrectable_severity = info.acpi_hest_aer_for_bridge->uncorrectable_severity;
+		correctable_mask = info.acpi_hest_aer_for_bridge->correctable_mask;
+		advanced_capabilities = info.acpi_hest_aer_for_bridge->advanced_capabilities;
+		uncorrectable_mask2 = info.acpi_hest_aer_for_bridge->uncorrectable_mask2;
+		uncorrectable_severity2 = info.acpi_hest_aer_for_bridge->uncorrectable_severity2;
+		advanced_capabilities2 = info.acpi_hest_aer_for_bridge->advanced_capabilities2;
+
+		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, uncorrectable_mask);
+		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, uncorrectable_severity);
+		pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, correctable_mask);
+		pci_write_config_dword(dev, pos + PCI_ERR_CAP, advanced_capabilities);
+		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK2, uncorrectable_mask2);
+		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER2, uncorrectable_severity2);
+		pci_write_config_dword(dev, pos + PCI_ERR_CAP2, advanced_capabilities2);
+	}
+}
+
+int pci_acpi_program_hest_aer_params(struct pci_dev *dev)
+{
+	struct acpi_hest_parse_aer_info info = {
+		.pci_dev	= dev,
+		.hest_matched_with_dev	= 0,
+		.acpi_hest_aer_endpoint = NULL,
+		.acpi_hest_aer_root_port = NULL,
+		.acpi_hest_aer_for_bridge = NULL,
+	};
+
+	if (!pci_is_pcie(dev))
+		return -ENODEV;
+
+	apei_hest_parse(apei_hest_parse_aer, &info);
+	if (info.hest_matched_with_dev == 1)
+		program_aer_structure_to_aer_registers(info);
+	else
+		return -ENODEV;
+	return 0;
+}
+
 /**
  * pciehp_is_native - Check whether a hotplug port is handled by the OS
  * @bridge: Hotplug port to check
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a4c3974340576..37aa4a33eeed2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -713,6 +713,7 @@ void acpi_pci_refresh_power_state(struct pci_dev *dev);
 int acpi_pci_wakeup(struct pci_dev *dev, bool enable);
 bool acpi_pci_need_resume(struct pci_dev *dev);
 pci_power_t acpi_pci_choose_state(struct pci_dev *pdev);
+int pci_acpi_program_hest_aer_params(struct pci_dev *dev);
 #else
 static inline int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
 {
@@ -752,6 +753,10 @@ static inline pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
 {
 	return PCI_POWER_ERROR;
 }
+static inline int pci_acpi_program_hest_aer_params(struct pci_dev *dev)
+{
+	return -ENODEV;
+}
 #endif
 
 #ifdef CONFIG_PCIEASPM
-- 
2.34.1

