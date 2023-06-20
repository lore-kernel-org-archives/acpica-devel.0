Return-Path: <andriy.shevchenko@linux.intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 158DE4187B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0D1004094E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687278944; x=1718814944;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MU6h0bQC0vAge5es6R0v/1fr1IoAPMvkrNIAnaSKRwM=;
 b=OWDeK3t688m5Vu25OHOVjthdpTd0X3o0WHWZ791OfI1mwaedOXOWuBJI
 ac7LW/rNlK3nkUzyt5/IF6mX2cN0z9okQ2nZPuBAEfr7Zcf2mld0az3jS
 AyoRvh8vgEsr7CwBhT9QWUFh6cGyi7HnhpqyU9Jk5Wapehz3OUq0/9GXs
 G2C0fScAA5DnlXtrZWIdOOz8KOjrXwMNs6nFaYe6XURh0yJo7UCi1mPfK
 0L5xafC1bFpX5ZLU9lqTmRP0qNGntKVdR0pjxyB1yRwhLTTL/h1gJwLok
 +ZEWKu5Pt5LpLL5P6iBQI5UnIDRZNP07QZ43cnEYbZn/pC5liOVtQ/91S g==;
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-Id: <20230620163534.1042-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230620163534.1042-1-andriy.shevchenko@linux.intel.com>
References: <20230620163534.1042-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Acpica-devel] [PATCH v1 2/2] ACPI: platform: Move SMB0001 HID to
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
Date: Tue, 20 Jun 2023 16:35:45 -0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Wolfram Sang <wsa@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, acpica-devel@lists.linuxfoundation.org
Cc: Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, Andi Shyti <andi.shyti@kernel.org>

There are at least two places in the kernel that are using
the SMB0001 HID. Make it to be available via acpi_drivers.h
header file. While at it, replace hard coded one with a
definition.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
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

