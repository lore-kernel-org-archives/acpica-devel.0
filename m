Return-Path: <LeoLiu-oc@zhaoxin.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AEA09402D4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D7B9040017
From: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Message-ID: <20230704120530.1322257-1-LeoLiu-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Acpica-devel] [PATCH v3 3/5] PCI: Add PCIe to PCI/PCI-X Bridge AER
	fields
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Tue, 04 Jul 2023 12:16:41 -0000
To: lenb@kernel.org, james.morse@arm.com, tony.luck@intel.com, bp@alien8.de, bhelgaas@google.com, robert.moore@intel.com, leoliu-oc@zhaoxin.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, acpica-devel@lists.linuxfoundation.org

From: leoliu-oc <leoliu-oc@zhaoxin.com>

Define Secondary Uncorrectable Error Mask Register, Secondary
Uncorrectable Error Severity Register and Secondary Error Capabilities and
Control Register bits in AER capability for PCIe to PCI/PCI-X Bridge.
Please refer to PCIe to PCI/PCI-X Bridge Specification, sec 5.2.3.2,
5.2.3.3 and 5.2.3.4.

Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
---
 include/uapi/linux/pci_regs.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index e5f558d964939..28e20c4d0afc3 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -800,6 +800,9 @@
 #define  PCI_ERR_ROOT_FATAL_RCV		0x00000040 /* Fatal Received */
 #define  PCI_ERR_ROOT_AER_IRQ		0xf8000000 /* Advanced Error Interrupt Message Number */
 #define PCI_ERR_ROOT_ERR_SRC	0x34	/* Error Source Identification */
+#define PCI_ERR_UNCOR_MASK2		0x30	/* PCIe to PCI/PCI-X Bridge */
+#define PCI_ERR_UNCOR_SEVER2	0x34	/* PCIe to PCI/PCI-X Bridge */
+#define PCI_ERR_CAP2			0x38	/* PCIe to PCI/PCI-X Bridge */
 
 /* Virtual Channel */
 #define PCI_VC_PORT_CAP1	0x04
-- 
2.34.1

