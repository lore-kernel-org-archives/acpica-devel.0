Return-Path: <andriy.shevchenko@linux.intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DC56C41E8A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D4C0341DC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687360614; x=1718896614;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BZCM5lLaApqKK/yTbVaJKND0T8mjA20qNjOsA8/s5nU=;
 b=T7mYsaEuNsTo7mahOrwSqZ00fGTViTfqKN4RXrPaLtKQ23Q7bSzf0wj7
 WBkT5vIJaVQ4V5JJsK67XXTOc+Sv4gkuXgKNhAU7U+MBRnEBbfsxn7PKM
 wSg0R1DzHXqjGYoZ1nl7NoZd56P+Xh9FEt8K51CJmDBd2s2HMeLeV7s7q
 LgvLsaH8Ltm5yFtFxlbNGwfFjNH2RDR6ltGV/rEbF77PccMXwVUsrRw4V
 DDo9fYEiOqYZ0jA27Wb4cFQEju7JP5PJdpSX39PAFy1z5OpejF+rgMYSE
 cJQLfCwkU9S89rb/qMtilkuF31y3W1Wzxel6GuvfquniIp98Nb2cTvVRu g==;
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Wed, 21 Jun 2023 18:16:52 +0300
Message-Id: <20230621151652.79579-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230621151652.79579-1-andriy.shevchenko@linux.intel.com>
References: <20230621151652.79579-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Acpica-devel] [PATCH v2 2/2] ACPI: platform: Move SMB0001 HID to
	the header and reuse
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, acpica-devel@lists.linuxfoundation.org
Cc: Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, Andi Shyti <andi.shyti@kernel.org>

There are at least two places in the kernel that are using
the SMB0001 HID. Make it to be available via acpi_drivers.h
header file. While at it, replace hard coded one with a
definition.

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20230620163534.1042-2-andriy.shevchenko@linux.intel.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: added tag (Andi)
 drivers/acpi/acpi_platform.c  | 2 +-
 drivers/i2c/busses/i2c-scmi.c | 3 ---
 include/acpi/acpi_drivers.h   | 2 ++
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 089a98bd18bf..e86f76ee3473 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -20,7 +20,7 @@
 #include "internal.h"
 
 static const struct acpi_device_id forbidden_id_with_resourses[] = {
-	{"SMB0001",  0},	/* ACPI SMBUS virtual device */
+	{ACPI_SMBUS_MS_HID,  0},	/* ACPI SMBUS virtual device */
 	{ }
 };
 
diff --git a/drivers/i2c/busses/i2c-scmi.c b/drivers/i2c/busses/i2c-scmi.c
index 104570292241..421735acfa14 100644
--- a/drivers/i2c/busses/i2c-scmi.c
+++ b/drivers/i2c/busses/i2c-scmi.c
@@ -13,9 +13,6 @@
 #include <linux/i2c.h>
 #include <linux/acpi.h>
 
-/* SMBUS HID definition as supported by Microsoft Windows */
-#define ACPI_SMBUS_MS_HID		"SMB0001"
-
 struct smbus_methods_t {
 	char *mt_info;
 	char *mt_sbr;
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index 8372b0e7fd15..b14d165632e7 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -27,6 +27,8 @@
 #define ACPI_BAY_HID			"LNXIOBAY"
 #define ACPI_DOCK_HID			"LNXDOCK"
 #define ACPI_ECDT_HID			"LNXEC"
+/* SMBUS HID definition as supported by Microsoft Windows */
+#define ACPI_SMBUS_MS_HID		"SMB0001"
 /* Quirk for broken IBM BIOSes */
 #define ACPI_SMBUS_IBM_HID		"SMBUSIBM"
 
-- 
2.40.0.1.gaa8946217a0b

