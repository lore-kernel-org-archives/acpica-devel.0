Return-Path: <xueshuai@linux.alibaba.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5BA8181256
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CCA5C81253
From: Shuai Xue <xueshuai@linux.alibaba.com>
Message-Id: <20230925074426.97856-5-xueshuai@linux.alibaba.com>
In-Reply-To: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
References: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Acpica-devel] [RFC PATCH v2 4/9] ACPI: tables: change section_type
	of generic error data as guid_t
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Mon, 25 Sep 2023 07:44:47 -0000
To: keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com, rafael@kernel.org, lenb@kernel.org, james.morse@arm.com, bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, ardb@kernel.org, robert.moore@intel.com
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-hardening@vger.kernel.org, baolin.wang@linux.alibaba.com, xueshuai@linux.alibaba.com, acpica-devel@lists.linuxfoundation.org, linux-edac@vger.kernel.org

The section_type of generic error data is now an array of u8. It is a
burden to perform explicit type casting from u8[] to guid_t, and to copy
the guid_t values to u8[] using memcpy.

To alleviate this issue, change the section_type from an array to the
type guid_t, which is also consistent with the cper_section_descriptor.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/acpi_extlog.c  | 2 +-
 drivers/acpi/apei/ghes.c    | 2 +-
 drivers/firmware/efi/cper.c | 2 +-
 include/acpi/actbl1.h       | 5 +++--
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index e120a96e1eae..d46435792d64 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -170,7 +170,7 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 			fru_text = gdata->fru_text;
 		else
 			fru_text = "";
-		sec_type = (guid_t *)gdata->section_type;
+		sec_type = &gdata->section_type;
 		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
 			struct cper_sec_mem_err *mem = acpi_hest_get_payload(gdata);
 
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index ef59d6ea16da..d14e00751161 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -648,7 +648,7 @@ static bool ghes_do_proc(struct ghes *ghes,
 
 	sev = ghes_severity(estatus->error_severity);
 	apei_estatus_for_each_section(estatus, gdata) {
-		sec_type = (guid_t *)gdata->section_type;
+		sec_type = &gdata->section_type;
 		sec_sev = ghes_severity(gdata->error_severity);
 		if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
 			fru_id = (guid_t *)gdata->fru_id;
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 35c37f667781..a2ba70aa928f 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -527,7 +527,7 @@ static void
 cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata,
 			   int sec_no)
 {
-	guid_t *sec_type = (guid_t *)gdata->section_type;
+	guid_t *sec_type = &gdata->section_type;
 	__u16 severity;
 	char newpfx[64];
 
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 8d5572ad48cb..ab25a8495a43 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -19,6 +19,7 @@
  *
  ******************************************************************************/
 
+#include <linux/uuid.h>
 /*
  * Values for description table header signatures for tables defined in this
  * file. Useful because they make it more difficult to inadvertently type in
@@ -1637,7 +1638,7 @@ struct acpi_hest_generic_status {
 /* Generic Error Data entry */
 
 struct acpi_hest_generic_data {
-	u8 section_type[16];
+	guid_t section_type;
 	u32 error_severity;
 	u16 revision;
 	u8 validation_bits;
@@ -1650,7 +1651,7 @@ struct acpi_hest_generic_data {
 /* Extension for revision 0x0300 */
 
 struct acpi_hest_generic_data_v300 {
-	u8 section_type[16];
+	guid_t section_type;
 	u32 error_severity;
 	u16 revision;
 	u8 validation_bits;
-- 
2.41.0

