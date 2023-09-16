Return-Path: <xueshuai@linux.alibaba.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D9895822D2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6C19F832BF
From: Shuai Xue <xueshuai@linux.alibaba.com>
Message-Id: <20230916130316.65815-6-xueshuai@linux.alibaba.com>
In-Reply-To: <20230916130316.65815-1-xueshuai@linux.alibaba.com>
References: <20230916130316.65815-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Acpica-devel] [RFC PATCH 5/9] ACPI: APEI: GHES: Use ERST to
	serialize APEI generic error before panic
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Sat, 16 Sep 2023 13:03:37 -0000
To: keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com, rafael@kernel.org, lenb@kernel.org, james.morse@arm.com, bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, ardb@kernel.org, robert.moore@intel.com
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-hardening@vger.kernel.org, baolin.wang@linux.alibaba.com, xueshuai@linux.alibaba.com, acpica-devel@lists.linuxfoundation.org, linux-edac@vger.kernel.org

In certain scenarios (ie. hosts/guests with root filesystems on
NFS/iSCSI where networking software and/or hardware fails, and thus
kdump fails), it is necessary to serialize hardware error information
available for post-mortem debugging.

Save the hardware error log into flash via ERST before go panic, the
hardware error log can be gotten from the flash after system boot
successful again, which is very useful in production.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/ghes.c | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d14e00751161..16701f889b73 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -41,6 +41,7 @@
 #include <linux/uuid.h>
 #include <linux/ras.h>
 #include <linux/task_work.h>
+#include <linux/pstore.h>
 
 #include <acpi/actbl1.h>
 #include <acpi/ghes.h>
@@ -636,6 +637,43 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
 	schedule_work(&entry->work);
 }
 
+static int ghes_serialize_estatus(struct acpi_hest_generic_data *gdata, u8 notify_type)
+{
+	void *err = acpi_hest_get_payload(gdata);
+	int data_len = gdata->error_data_length;
+	struct cper_pstore_record *rcd;
+	int record_len = data_len + sizeof(*rcd);
+
+	rcd = kmalloc(record_len, GFP_KERNEL);
+	memset(rcd, 0, sizeof(rcd));
+
+	memcpy(rcd->hdr.signature, CPER_SIG_RECORD, CPER_SIG_SIZE);
+	rcd->hdr.revision = CPER_RECORD_REV;
+	rcd->hdr.signature_end = CPER_SIG_END;
+	rcd->hdr.section_count = 1;
+	rcd->hdr.error_severity = CPER_SEV_FATAL;
+	/* timestamp, platform_id, partition_id are all invalid */
+	rcd->hdr.validation_bits = 0;
+	rcd->hdr.record_length = record_len;
+	rcd->hdr.creator_id = CPER_CREATOR_PSTORE;
+	rcd->hdr.notification_type = CPER_NOTIFY_MCE;
+	rcd->hdr.record_id = cper_next_record_id();
+	rcd->hdr.flags = CPER_HW_ERROR_FLAGS_PREVERR;
+
+	rcd->sec_hdr.section_offset = (void *)&rcd->data - (void *)&rcd;
+	rcd->sec_hdr.section_length = data_len;
+	rcd->sec_hdr.revision = CPER_SEC_REV;
+	/* ->ru_id and fru_text is invalid */
+	rcd->sec_hdr.validation_bits = 0;
+	rcd->sec_hdr.flags = CPER_SEC_PRIMARY;
+	rcd->sec_hdr.section_type = gdata->section_type;
+	rcd->sec_hdr.section_severity = gdata->error_severity;
+
+	memcpy(&rcd->data, err, data_len);
+
+	return erst_write(&rcd->hdr);
+}
+
 static bool ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
@@ -861,10 +899,16 @@ static void __ghes_panic(struct ghes *ghes,
 			 struct acpi_hest_generic_status *estatus,
 			 u64 buf_paddr, enum fixed_addresses fixmap_idx)
 {
+	struct acpi_hest_generic_data *gdata;
+	u8 notify_type = ghes->generic->notify.type;
+
 	__ghes_print_estatus(KERN_EMERG, ghes->generic, estatus);
 
 	ghes_clear_estatus(ghes, estatus, buf_paddr, fixmap_idx);
 
+	apei_estatus_for_each_section(estatus, gdata)
+		ghes_serialize_estatus(gdata, notify_type);
+
 	/* reboot to log the error! */
 	if (!panic_timeout)
 		panic_timeout = ghes_panic_timeout;
-- 
2.41.0

