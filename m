Return-Path: <LeoLiu-oc@zhaoxin.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BC8D4402D4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5B23C40017
From: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Message-ID: <20230704120517.1322195-1-LeoLiu-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Acpica-devel] [PATCH v3 2/5] ACPI/APEI: Remove static from
	apei_hest_parse()
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

Each dev with AER capability needs to call the apei_hest_parse function to
match and extract register values from HEST PCIe AER structures.
Therefore, remove static from apei_hest_parse() so that it can be called
in another file.

Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
---
 drivers/acpi/apei/hest.c | 2 +-
 include/acpi/apei.h      | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index fb839a5c480ee..fd40c035c9b2e 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -132,7 +132,7 @@ static bool hest_match_pci(struct acpi_hest_header *hest_hdr,
 	return false;
 }
 
-static int apei_hest_parse(apei_hest_func_t func, void *data)
+int apei_hest_parse(apei_hest_func_t func, void *data)
 {
 	struct acpi_hest_header *hest_hdr;
 	int i, rc, len;
diff --git a/include/acpi/apei.h b/include/acpi/apei.h
index 8a0b2b9edbafe..f975e4fe78fcb 100644
--- a/include/acpi/apei.h
+++ b/include/acpi/apei.h
@@ -37,9 +37,14 @@ typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
 
 #ifdef CONFIG_ACPI_APEI
 void __init acpi_hest_init(void);
+int apei_hest_parse(apei_hest_func_t func, void *data);
 int apei_hest_parse_aer(struct acpi_hest_header *hest_hdr, void *data);
 #else
 static inline void acpi_hest_init(void) { }
+static inline int apei_hest_parse(apei_hest_func_t func, void *data)
+{
+	return -EINVAL;
+}
 static inline int apei_hest_parse_aer(struct acpi_hest_header *hest_hdr, void *data)
 {
 	return -EINVAL;
-- 
2.34.1

