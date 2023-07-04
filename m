Return-Path: <LeoLiu-oc@zhaoxin.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E8C7E81F96
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9BDEE81F0B
From: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Message-ID: <20230704120505.1322152-1-LeoLiu-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Acpica-devel] [PATCH v3 1/5] ACPI/APEI: Add apei_hest_parse_aer()
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Tue, 04 Jul 2023 12:16:39 -0000
To: lenb@kernel.org, james.morse@arm.com, tony.luck@intel.com, bp@alien8.de, bhelgaas@google.com, robert.moore@intel.com, leoliu-oc@zhaoxin.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, acpica-devel@lists.linuxfoundation.org

From: leoliu-oc <leoliu-oc@zhaoxin.com>

apei_hest_parse_aer() is used to parse and extract register values
from HEST PCIe AER structures.

Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
---
 drivers/acpi/apei/hest.c | 114 ++++++++++++++++++++++++++++++++++++++-
 include/acpi/actbl1.h    |  69 ++++++++++++++++++++++++
 include/acpi/apei.h      |   7 +++
 3 files changed, 189 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 6aef1ee5e1bdb..fb839a5c480ee 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -26,6 +26,7 @@
 #include <acpi/apei.h>
 #include <acpi/ghes.h>
 
+#include <linux/pci.h>
 #include "apei-internal.h"
 
 #define HEST_PFX "HEST: "
@@ -86,7 +87,50 @@ static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
 	return len;
 };
 
-typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
+static bool hest_source_is_pcie_aer(struct acpi_hest_header *hest_hdr)
+{
+	switch (hest_hdr->type) {
+	case ACPI_HEST_TYPE_AER_ROOT_PORT:
+	case ACPI_HEST_TYPE_AER_ENDPOINT:
+	case ACPI_HEST_TYPE_AER_BRIDGE:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool hest_match_type(struct acpi_hest_header *hest_hdr,
+				struct pci_dev *dev)
+{
+	u16 hest_type = hest_hdr->type;
+	u8 pcie_type = pci_pcie_type(dev);
+
+	if ((hest_type == ACPI_HEST_TYPE_AER_ROOT_PORT &&
+		pcie_type == PCI_EXP_TYPE_ROOT_PORT) ||
+		(hest_type == ACPI_HEST_TYPE_AER_ENDPOINT &&
+		pcie_type == PCI_EXP_TYPE_ENDPOINT) ||
+		(hest_type == ACPI_HEST_TYPE_AER_BRIDGE &&
+		(pcie_type == PCI_EXP_TYPE_PCI_BRIDGE || pcie_type == PCI_EXP_TYPE_PCIE_BRIDGE)))
+		return true;
+	return false;
+}
+
+static bool hest_match_pci_devfn(struct acpi_hest_aer_common *p,
+		struct pci_dev *pci)
+{
+	return	ACPI_HEST_SEGMENT(p->bus) == pci_domain_nr(pci->bus) &&
+			ACPI_HEST_BUS(p->bus)     == pci->bus->number &&
+			p->device                 == PCI_SLOT(pci->devfn) &&
+			p->function               == PCI_FUNC(pci->devfn);
+}
+
+static bool hest_match_pci(struct acpi_hest_header *hest_hdr,
+		struct acpi_hest_aer_common *p, struct pci_dev *pci)
+{
+	if (hest_match_type(hest_hdr, pci))
+		return hest_match_pci_devfn(p, pci);
+	return false;
+}
 
 static int apei_hest_parse(apei_hest_func_t func, void *data)
 {
@@ -124,6 +168,74 @@ static int apei_hest_parse(apei_hest_func_t func, void *data)
 	return 0;
 }
 
+/*
+ * apei_hest_parse_aer - Find the AER structure in the HEST and
+ * match it with the PCIe device.
+ *
+ * @hest_hdr: To save the ACPI AER error source in HEST
+ *
+ * Return 1 if the PCIe dev matched with the ACPI AER error source in
+ * HEST, else return 0.
+ */
+int apei_hest_parse_aer(struct acpi_hest_header *hest_hdr, void *data)
+{
+	struct acpi_hest_parse_aer_info *info = data;
+	struct acpi_hest_aer_endpoint *acpi_hest_aer_endpoint = NULL;
+	struct acpi_hest_aer_root_port *acpi_hest_aer_root_port = NULL;
+	struct acpi_hest_aer_for_bridge *acpi_hest_aer_for_bridge = NULL;
+
+	if (!hest_source_is_pcie_aer(hest_hdr))
+		return 0;
+
+	switch (hest_hdr->type) {
+	case ACPI_HEST_TYPE_AER_ROOT_PORT:
+		acpi_hest_aer_root_port = (struct acpi_hest_aer_root_port *)(hest_hdr + 1);
+		if (acpi_hest_aer_root_port->flags & ACPI_HEST_GLOBAL) {
+			if (hest_match_type(hest_hdr, info->pci_dev)) {
+				info->acpi_hest_aer_root_port = acpi_hest_aer_root_port;
+				info->hest_matched_with_dev = 1;
+			}
+		} else if (hest_match_pci(hest_hdr,
+					(struct acpi_hest_aer_common *)acpi_hest_aer_root_port,
+					info->pci_dev)) {
+			info->acpi_hest_aer_root_port = acpi_hest_aer_root_port;
+			info->hest_matched_with_dev = 1;
+		}
+		break;
+	case ACPI_HEST_TYPE_AER_ENDPOINT:
+		acpi_hest_aer_endpoint = (struct acpi_hest_aer_endpoint *)(hest_hdr + 1);
+		if (acpi_hest_aer_endpoint->flags & ACPI_HEST_GLOBAL) {
+			if (hest_match_type(hest_hdr, info->pci_dev)) {
+				info->acpi_hest_aer_endpoint = acpi_hest_aer_endpoint;
+				info->hest_matched_with_dev = 1;
+			}
+		} else if (hest_match_pci(hest_hdr,
+					(struct acpi_hest_aer_common *)acpi_hest_aer_endpoint,
+					info->pci_dev)) {
+				info->acpi_hest_aer_endpoint = acpi_hest_aer_endpoint;
+				info->hest_matched_with_dev = 1;
+		}
+		break;
+	case ACPI_HEST_TYPE_AER_BRIDGE:
+		acpi_hest_aer_for_bridge = (struct acpi_hest_aer_for_bridge *)(hest_hdr + 1);
+		if (acpi_hest_aer_for_bridge->flags & ACPI_HEST_GLOBAL) {
+			if (hest_match_type(hest_hdr, info->pci_dev)) {
+				info->acpi_hest_aer_for_bridge = acpi_hest_aer_for_bridge;
+				info->hest_matched_with_dev = 1;
+			}
+		} else if (hest_match_pci(hest_hdr,
+					(struct acpi_hest_aer_common *)acpi_hest_aer_for_bridge,
+					info->pci_dev)) {
+				info->acpi_hest_aer_for_bridge = acpi_hest_aer_for_bridge;
+				info->hest_matched_with_dev = 1;
+			}
+		break;
+	default:
+		break;
+	}
+	return info->hest_matched_with_dev;
+}
+
 /*
  * Check if firmware advertises firmware first mode. We need FF bit to be set
  * along with a set of MC banks which work in FF mode.
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 58b0490a2ad12..31abe06c6e792 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1583,6 +1583,75 @@ struct acpi_hest_aer_bridge {
 	u32 advanced_capabilities2;
 };
 
+struct acpi_hest_parse_aer_info {
+	struct pci_dev *pci_dev;
+	int hest_matched_with_dev;
+	struct acpi_hest_aer_endpoint *acpi_hest_aer_endpoint;
+	struct acpi_hest_aer_root_port *acpi_hest_aer_root_port;
+	struct acpi_hest_aer_for_bridge *acpi_hest_aer_for_bridge;
+};
+
+/* HEST Sub-structure for PCIe Root Port Structure (6) */
+
+struct acpi_hest_aer_root_port {
+	u16 reserved1;
+	u8 flags;
+	u8 enabled;
+	u32 records_to_preallocate;
+	u32 max_sections_per_record;
+	u32 bus;
+	u16 device;
+	u16 function;
+	u16 device_control;
+	u16 reserved2;
+	u32 uncorrectable_mask;
+	u32 uncorrectable_severity;
+	u32 correctable_mask;
+	u32 advanced_capabilities;
+	u32 root_error_command;
+};
+
+/* HEST Sub-structure for PCIe Endpoint Structure (7) */
+
+struct acpi_hest_aer_endpoint {
+	u16 reserved1;
+	u8 flags;
+	u8 enabled;
+	u32 records_to_preallocate;
+	u32 max_sections_per_record;
+	u32 bus;
+	u16 device;
+	u16 function;
+	u16 device_control;
+	u16 reserved2;
+	u32 uncorrectable_mask;
+	u32 uncorrectable_severity;
+	u32 correctable_mask;
+	u32 advanced_capabilities;
+};
+
+/* HEST Sub-structure for PCIe/PCI-X Bridge Structure (8) */
+
+struct acpi_hest_aer_for_bridge {
+	u16 reserved1;
+	u8 flags;
+	u8 enabled;
+	u32 records_to_preallocate;
+	u32 max_sections_per_record;
+	u32 bus;
+	u16 device;
+	u16 function;
+	u16 device_control;
+	u16 reserved2;
+	u32 uncorrectable_mask;
+	u32 uncorrectable_severity;
+	u32 correctable_mask;
+	u32 advanced_capabilities;
+	u32 uncorrectable_mask2;
+	u32 uncorrectable_severity2;
+	u32 advanced_capabilities2;
+};
+
 /* 9: Generic Hardware Error Source */
 
 struct acpi_hest_generic {
diff --git a/include/acpi/apei.h b/include/acpi/apei.h
index dc60f7db5524f..8a0b2b9edbafe 100644
--- a/include/acpi/apei.h
+++ b/include/acpi/apei.h
@@ -33,10 +33,17 @@ void __init acpi_ghes_init(void);
 static inline void acpi_ghes_init(void) { }
 #endif
 
+typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
+
 #ifdef CONFIG_ACPI_APEI
 void __init acpi_hest_init(void);
+int apei_hest_parse_aer(struct acpi_hest_header *hest_hdr, void *data);
 #else
 static inline void acpi_hest_init(void) { }
+static inline int apei_hest_parse_aer(struct acpi_hest_header *hest_hdr, void *data)
+{
+	return -EINVAL;
+}
 #endif
 
 int erst_write(const struct cper_record_header *record);
-- 
2.34.1

