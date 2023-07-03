Return-Path: <andriy.shevchenko@linux.intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AD16381771
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DBEDC8186A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688386454; x=1719922454;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0+SSNItGZd8DaGAVZM/aUS3kbeqhy2m38fy5KVkHewA=;
 b=Bufym4wKLkAojUW+9/ruhnhVsertqDms+63Hauh1emr5Eka91GV4RvpG
 i7GQ6wCjjkkDED2xJacp5GhMYCPzh6Yrrn+jm8VGfqnECZyzlt6Lsn1B+
 DS7AhZ/SIafjms4+gYjzgqLmhrhUeLQY+GA7SWdcgMeHXr7yG/6qyfpsR
 jVWqxPK+U0wrmgk+u5P+SMX2BXqELEkLDcTR2/luzos892FkToj44fHq7
 ilEfFVN0H10tTYbddBIh8rrDp99Si3L1ChB1CYu37ji5aiZpcvAFE7V3D
 DM+EsvEsDpZmoGizuTQSQDG0q+IA8HHV+4YGnFmh0Q3Vi1qz3kVSOjQ6m A==;
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-Id: <20230703121411.69606-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230703121411.69606-1-andriy.shevchenko@linux.intel.com>
References: <20230703121411.69606-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Acpica-devel] [PATCH v4 2/5] ACPI: platform: Ignore SMB0001 only
	when it has resources
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Mon, 03 Jul 2023 12:14:17 -0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Wolfram Sang <wsa@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, acpica-devel@lists.linuxfoundation.org
Cc: Michael Walle <michael@walle.cc>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>

After switching i2c-scmi driver to be a platform one, it stopped
being enumerated on number of Kontron platforms, because it's
listed in the forbidden_id_list.

To resolve the situation, add a flag to driver data to allow devices
with no resources in _CRS to be enumerated via platform bus.

Fixes: 03d4287add6e ("i2c: scmi: Convert to be a platform driver")
Closes: https://lore.kernel.org/r/60c1756765b9a3f1eab0dcbd84f59f00fe1caf48.camel@kontron.com
Link: https://lore.kernel.org/r/20230621151652.79579-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
---
 drivers/acpi/acpi_platform.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index fe00a5783f53..c2ce558bd032 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
@@ -19,13 +20,16 @@
 
 #include "internal.h"
 
+/* Exclude devices that have no _CRS resources provided */
+#define ACPI_ALLOW_WO_RESOURCES		BIT(0)
+
 static const struct acpi_device_id forbidden_id_list[] = {
 	{"ACPI0009", 0},	/* IOxAPIC */
 	{"ACPI000A", 0},	/* IOAPIC */
 	{"PNP0000",  0},	/* PIC */
 	{"PNP0100",  0},	/* Timer */
 	{"PNP0200",  0},	/* AT DMA Controller */
-	{"SMB0001",  0},	/* ACPI SMBUS virtual device */
+	{"SMB0001",  ACPI_ALLOW_WO_RESOURCES},	/* ACPI SMBUS virtual device */
 	{ }
 };
 
@@ -83,6 +87,15 @@ static void acpi_platform_fill_resource(struct acpi_device *adev,
 		dest->parent = pci_find_resource(to_pci_dev(parent), dest);
 }
 
+static unsigned int acpi_platform_resource_count(struct acpi_resource *ares, void *data)
+{
+	bool *has_resources = data;
+
+	*has_resources = true;
+
+	return AE_CTRL_TERMINATE;
+}
+
 /**
  * acpi_create_platform_device - Create platform device for ACPI device node
  * @adev: ACPI device node to create a platform device for.
@@ -100,17 +113,28 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 	struct acpi_device *parent = acpi_dev_parent(adev);
 	struct platform_device *pdev = NULL;
 	struct platform_device_info pdevinfo;
+	const struct acpi_device_id *match;
 	struct resource_entry *rentry;
 	struct list_head resource_list;
 	struct resource *resources = NULL;
+	bool has_resources;
 	int count;
 
 	/* If the ACPI node already has a physical device attached, skip it. */
 	if (adev->physical_node_count)
 		return NULL;
 
-	if (!acpi_match_device_ids(adev, forbidden_id_list))
-		return ERR_PTR(-EINVAL);
+	match = acpi_match_acpi_device(forbidden_id_list, adev);
+	if (match) {
+		if (match->driver_data & ACPI_ALLOW_WO_RESOURCES) {
+			acpi_walk_resources(adev->handle, METHOD_NAME__CRS,
+					    acpi_platform_resource_count, &has_resources);
+			if (has_resources)
+				return ERR_PTR(-EINVAL);
+		} else {
+			return ERR_PTR(-EINVAL);
+		}
+	}
 
 	INIT_LIST_HEAD(&resource_list);
 	count = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
-- 
2.40.0.1.gaa8946217a0b

