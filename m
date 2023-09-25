Return-Path: <xueshuai@linux.alibaba.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E1D1640295
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9624E4029B
From: Shuai Xue <xueshuai@linux.alibaba.com>
Message-Id: <20230925074426.97856-8-xueshuai@linux.alibaba.com>
In-Reply-To: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
References: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Acpica-devel] [RFC PATCH v2 7/9] ACPI: APEI: ESRT: kick
	ghes_report_chain notifier to report serialized memory errors
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Mon, 25 Sep 2023 07:44:52 -0000
To: keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com, rafael@kernel.org, lenb@kernel.org, james.morse@arm.com, bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, ardb@kernel.org, robert.moore@intel.com
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-hardening@vger.kernel.org, baolin.wang@linux.alibaba.com, xueshuai@linux.alibaba.com, acpica-devel@lists.linuxfoundation.org, linux-edac@vger.kernel.org

Introduce a new pstore_record type, PSTORE_TYPE_CPER_MEM, so that
serialized memory errors can be retrieved and saved as a file in pstore
file system. While the serialized errors is retrieved from ERST
backend, kick ghes_report_chain notifier.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/erst.c | 5 +++++
 fs/pstore/platform.c     | 1 +
 include/linux/pstore.h   | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 82f57aaf89ad..786d46c767ee 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -26,6 +26,7 @@
 #include <linux/vmalloc.h>
 #include <linux/mm.h> /* kvfree() */
 #include <acpi/apei.h>
+#include <acpi/ghes.h>
 #ifdef CONFIG_X86_MCE
 /* only define CREATE_TRACE_POINTS once */
 #include <trace/events/mce.h>
@@ -1072,6 +1073,10 @@ static ssize_t erst_reader(struct pstore_record *record)
 		trace_mce_record((struct mce *)rcd->data);
 #endif
 		record->type = PSTORE_TYPE_MCE;
+	} else if (guid_equal(&rcd->sec_hdr.section_type, &CPER_SEC_PLATFORM_MEM)) {
+		record->type = PSTORE_TYPE_CPER_MEM;
+		arch_apei_report_mem_error(0x2, (struct cper_sec_mem_err *)rcd->data);
+		atomic_notifier_call_chain(&ghes_report_chain, 0x2, rcd->data);
 	}
 	else
 		record->type = PSTORE_TYPE_MAX;
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index e5bca9a004cc..4e63ac8be755 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -51,6 +51,7 @@ static const char * const pstore_type_names[] = {
 	"powerpc-common",
 	"pmsg",
 	"powerpc-opal",
+	"cper-mem",
 };
 
 static int pstore_new_entry;
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index ad44b3baf10e..d18ecaacd1b5 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -40,6 +40,9 @@ enum pstore_type_id {
 	PSTORE_TYPE_PMSG	= 7,
 	PSTORE_TYPE_PPC_OPAL	= 8,
 
+	/* APEI section */
+	PSTORE_TYPE_CPER_MEM		= 9,
+
 	/* End of the list */
 	PSTORE_TYPE_MAX
 };
-- 
2.41.0

