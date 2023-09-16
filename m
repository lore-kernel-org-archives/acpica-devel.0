Return-Path: <xueshuai@linux.alibaba.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 76C46832B0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AF308822D2
From: Shuai Xue <xueshuai@linux.alibaba.com>
Message-Id: <20230916130316.65815-2-xueshuai@linux.alibaba.com>
In-Reply-To: <20230916130316.65815-1-xueshuai@linux.alibaba.com>
References: <20230916130316.65815-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Acpica-devel] [RFC PATCH 1/9] pstore: move pstore creator id,
	section type and record struct to common header
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Sat, 16 Sep 2023 13:03:30 -0000
To: keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com, rafael@kernel.org, lenb@kernel.org, james.morse@arm.com, bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, ardb@kernel.org, robert.moore@intel.com
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-hardening@vger.kernel.org, baolin.wang@linux.alibaba.com, xueshuai@linux.alibaba.com, acpica-devel@lists.linuxfoundation.org, linux-edac@vger.kernel.org

Move pstore creator id, section type and record struct to the common
header, so that it can be use by MCE and GHES driver.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/erst.c | 19 -------------------
 include/linux/pstore.h   | 24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 247989060e29..528ac5eb4871 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -997,25 +997,6 @@ static struct pstore_info erst_info = {
 	.erase		= erst_clearer
 };
 
-#define CPER_CREATOR_PSTORE						\
-	GUID_INIT(0x75a574e3, 0x5052, 0x4b29, 0x8a, 0x8e, 0xbe, 0x2c,	\
-		  0x64, 0x90, 0xb8, 0x9d)
-#define CPER_SECTION_TYPE_DMESG						\
-	GUID_INIT(0xc197e04e, 0xd545, 0x4a70, 0x9c, 0x17, 0xa5, 0x54,	\
-		  0x94, 0x19, 0xeb, 0x12)
-#define CPER_SECTION_TYPE_DMESG_Z					\
-	GUID_INIT(0x4f118707, 0x04dd, 0x4055, 0xb5, 0xdd, 0x95, 0x6d,	\
-		  0x34, 0xdd, 0xfa, 0xc6)
-#define CPER_SECTION_TYPE_MCE						\
-	GUID_INIT(0xfe08ffbe, 0x95e4, 0x4be7, 0xbc, 0x73, 0x40, 0x96,	\
-		  0x04, 0x4a, 0x38, 0xfc)
-
-struct cper_pstore_record {
-	struct cper_record_header hdr;
-	struct cper_section_descriptor sec_hdr;
-	char data[];
-} __packed;
-
 static int reader_pos;
 
 static int erst_open_pstore(struct pstore_info *psi)
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index 638507a3c8ff..ad44b3baf10e 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -17,6 +17,7 @@
 #include <linux/spinlock.h>
 #include <linux/time.h>
 #include <linux/types.h>
+#include <linux/cper.h>
 
 struct module;
 
@@ -210,6 +211,29 @@ struct pstore_info {
 extern int pstore_register(struct pstore_info *);
 extern void pstore_unregister(struct pstore_info *);
 
+#define CPER_CREATOR_PSTORE						\
+	GUID_INIT(0x75a574e3, 0x5052, 0x4b29, 0x8a, 0x8e, 0xbe, 0x2c,	\
+		  0x64, 0x90, 0xb8, 0x9d)
+#define CPER_SECTION_TYPE_DMESG						\
+	GUID_INIT(0xc197e04e, 0xd545, 0x4a70, 0x9c, 0x17, 0xa5, 0x54,	\
+		  0x94, 0x19, 0xeb, 0x12)
+#define CPER_SECTION_TYPE_DMESG_Z					\
+	GUID_INIT(0x4f118707, 0x04dd, 0x4055, 0xb5, 0xdd, 0x95, 0x6d,	\
+		  0x34, 0xdd, 0xfa, 0xc6)
+#define CPER_SECTION_TYPE_MCE						\
+	GUID_INIT(0xfe08ffbe, 0x95e4, 0x4be7, 0xbc, 0x73, 0x40, 0x96,	\
+		  0x04, 0x4a, 0x38, 0xfc)
+
+/*
+ * CPER specification (in UEFI specification 2.3 appendix N) requires
+ * byte-packed.
+ */
+struct cper_pstore_record {
+	struct cper_record_header hdr;
+	struct cper_section_descriptor sec_hdr;
+	char data[];
+} __packed;
+
 struct pstore_ftrace_record {
 	unsigned long ip;
 	unsigned long parent_ip;
-- 
2.41.0

