Return-Path: <Wyes.Karny@amd.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2381741CF5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0C5744020B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtXmwRgYr0kaXFCoj7uImWopg/xapK7mLzVlngMZRq0=;
 b=bFwhmyEz82I9+HmVsc/CfC5lUBlePrDfpMYcvFlPHMBVDa5VJeOfcbzxQMtuvpFOTOjDSdGLqCujg/Oo6MVkLmAKVfjp8cNKVgnUSNAdH1VF+T6kXb+Bgi/j3IRpQ3FfCi+0Di0H2NpVMUyhrxQuCX+wyLEAOYrVGSJudlAVv1I=
From: Wyes Karny <wyes.karny@amd.com>
Date: Tue, 23 May 2023 16:18:15 +0000
Message-ID: <20230523161815.3083-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Acpica-devel] [PATCH] acpi: Replace struct acpi_table_slit
	1-element array with flex-array
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com, keescook@chromium.org
Cc: linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, Wyes Karny <wyes.karny@amd.com>

struct acpi_table_slit is used for copying System Locality Information
Table data from ACPI tables. Here `entry` is a flex array but it was
using ancient 1-element fake flexible array, which has been deprecated.
Replace it with a C99 flexible array.

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 include/acpi/actbl3.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index f51c46f4e3e4..000764ab3985 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -86,7 +86,7 @@ struct acpi_table_slic {
 struct acpi_table_slit {
 	struct acpi_table_header header;	/* Common ACPI table header */
 	u64 locality_count;
-	u8 entry[1];		/* Real size = localities^2 */
+	u8 entry[];				/* Real size = localities^2 */
 };
 
 /*******************************************************************************
-- 
2.34.1

