Return-Path: <suhui@nfschina.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 200A8813FE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 57E13813FD
From: Su Hui <suhui@nfschina.com>
Message-Id: <20230831073432.1712904-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Acpica-devel] [PATCH 1/2] ACPICA: Use strscpy to replace strncpy
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Thu, 31 Aug 2023 07:41:39 -0000
To: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Su Hui <suhui@nfschina.com>

With gcc and W=1 option to compile kernel, warning happens:

inlined from ‘acpi_tb_find_table’ at drivers/acpi/acpica/tbfind.c:60:2:
include/linux/fortify-string.h:68:30: error: ‘__builtin_strncpy’ specified
bound 6 equals destination size [-Werror=stringop-truncation]

Use strscpy to avoid this warning and is safer.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/acpi/acpica/tbfind.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
index 1c1b2e284bd9..5536d1755188 100644
--- a/drivers/acpi/acpica/tbfind.c
+++ b/drivers/acpi/acpica/tbfind.c
@@ -57,8 +57,8 @@ acpi_tb_find_table(char *signature,
 
 	memset(&header, 0, sizeof(struct acpi_table_header));
 	ACPI_COPY_NAMESEG(header.signature, signature);
-	strncpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
-	strncpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
+	strscpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
+	strscpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
 
 	/* Search for the table */
 
-- 
2.30.2

