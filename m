Return-Path: <xueshuai@linux.alibaba.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A618860A64
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9016760F6F
From: Shuai Xue <xueshuai@linux.alibaba.com>
Message-Id: <20230925074426.97856-9-xueshuai@linux.alibaba.com>
In-Reply-To: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
References: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Acpica-devel] [RFC PATCH v2 8/9] ACPI: APEI: ESRT: print AER to
	report serialized PCIe errors
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Mon, 25 Sep 2023 07:44:54 -0000
To: keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com, rafael@kernel.org, lenb@kernel.org, james.morse@arm.com, bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, ardb@kernel.org, robert.moore@intel.com
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-hardening@vger.kernel.org, baolin.wang@linux.alibaba.com, xueshuai@linux.alibaba.com, acpica-devel@lists.linuxfoundation.org, linux-edac@vger.kernel.org

Introduce a new pstore_record type, PSTORE_TYPE_CPER_PCIE, so that
serialized PCIe errors can be restrived and saved as a file in pstore file
system. While the serialized PCIe errors is retrieved from ERST backend,
print AER information.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/erst.c | 15 +++++++++++++++
 fs/pstore/platform.c     |  1 +
 include/linux/pstore.h   |  1 +
 3 files changed, 17 insertions(+)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 786d46c767ee..e0c44ea46acc 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -27,6 +27,8 @@
 #include <linux/mm.h> /* kvfree() */
 #include <acpi/apei.h>
 #include <acpi/ghes.h>
+#include <linux/aer.h>
+#include <linux/pci.h>
 #ifdef CONFIG_X86_MCE
 /* only define CREATE_TRACE_POINTS once */
 #include <trace/events/mce.h>
@@ -1077,6 +1079,19 @@ static ssize_t erst_reader(struct pstore_record *record)
 		record->type = PSTORE_TYPE_CPER_MEM;
 		arch_apei_report_mem_error(0x2, (struct cper_sec_mem_err *)rcd->data);
 		atomic_notifier_call_chain(&ghes_report_chain, 0x2, rcd->data);
+	} else if (guid_equal(&rcd->sec_hdr.section_type, &CPER_SEC_PCIE)) {
+
+		struct cper_sec_pcie *pcie_err = (struct cper_sec_pcie *)rcd->data;
+		unsigned int devfn = PCI_DEVFN(pcie_err->device_id.device,
+				  pcie_err->device_id.function);
+		struct pci_dev *pdev = pci_get_domain_bus_and_slot(
+			pcie_err->device_id.segment, pcie_err->device_id.bus,
+			devfn);
+
+		record->type = PSTORE_TYPE_CPER_PCIE;
+		cper_print_aer(
+			pdev, AER_FATAL,
+			(struct aer_capability_regs *)pcie_err->aer_info);
 	}
 	else
 		record->type = PSTORE_TYPE_MAX;
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 4e63ac8be755..40a062546fe4 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -52,6 +52,7 @@ static const char * const pstore_type_names[] = {
 	"pmsg",
 	"powerpc-opal",
 	"cper-mem",
+	"cper-pcie",
 };
 
 static int pstore_new_entry;
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index d18ecaacd1b5..e63f51e9c22e 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -42,6 +42,7 @@ enum pstore_type_id {
 
 	/* APEI section */
 	PSTORE_TYPE_CPER_MEM		= 9,
+	PSTORE_TYPE_CPER_PCIE		= 10,
 
 	/* End of the list */
 	PSTORE_TYPE_MAX
-- 
2.41.0

