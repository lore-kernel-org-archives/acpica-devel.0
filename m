Return-Path: <xueshuai@linux.alibaba.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D8A334029C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6D6E740295
From: Shuai Xue <xueshuai@linux.alibaba.com>
Message-Id: <20230925074426.97856-10-xueshuai@linux.alibaba.com>
In-Reply-To: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
References: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Acpica-devel] [RFC PATCH v2 9/9] ACPI: APEI: ESRT: log ARM
	processor error
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Mon, 25 Sep 2023 07:44:56 -0000
To: keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com, rafael@kernel.org, lenb@kernel.org, james.morse@arm.com, bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, ardb@kernel.org, robert.moore@intel.com
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-hardening@vger.kernel.org, baolin.wang@linux.alibaba.com, xueshuai@linux.alibaba.com, acpica-devel@lists.linuxfoundation.org, linux-edac@vger.kernel.org

Introduce a new pstore_record type, PSTORE_TYPE_CPER_PROC_ARM, so that
serialized ARM processor errors can be retrieved and saved as a file in
pstore file system. While the serialized errors is retrieved from ERST
backend, log it.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/erst.c | 6 ++++++
 fs/pstore/platform.c     | 1 +
 include/linux/pstore.h   | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index e0c44ea46acc..2b99573d1d5d 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -29,6 +29,7 @@
 #include <acpi/ghes.h>
 #include <linux/aer.h>
 #include <linux/pci.h>
+#include <linux/ras.h>
 #ifdef CONFIG_X86_MCE
 /* only define CREATE_TRACE_POINTS once */
 #include <trace/events/mce.h>
@@ -1092,6 +1093,11 @@ static ssize_t erst_reader(struct pstore_record *record)
 		cper_print_aer(
 			pdev, AER_FATAL,
 			(struct aer_capability_regs *)pcie_err->aer_info);
+	} else if (guid_equal(&rcd->sec_hdr.section_type, &CPER_SEC_PROC_ARM)) {
+		struct cper_sec_proc_arm *err = (struct cper_sec_proc_arm *)rcd->data;
+
+		record->type = PSTORE_TYPE_CPER_PROC_ARM;
+		log_arm_hw_error(err);
 	}
 	else
 		record->type = PSTORE_TYPE_MAX;
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 40a062546fe4..48ad3202284c 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -53,6 +53,7 @@ static const char * const pstore_type_names[] = {
 	"powerpc-opal",
 	"cper-mem",
 	"cper-pcie",
+	"cper-proc-arm",
 };
 
 static int pstore_new_entry;
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index e63f51e9c22e..83edff5aab0b 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -43,6 +43,7 @@ enum pstore_type_id {
 	/* APEI section */
 	PSTORE_TYPE_CPER_MEM		= 9,
 	PSTORE_TYPE_CPER_PCIE		= 10,
+	PSTORE_TYPE_CPER_PROC_ARM	= 11,
 
 	/* End of the list */
 	PSTORE_TYPE_MAX
-- 
2.41.0

