Return-Path: <andriy.shevchenko@linux.intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 33B7B4094E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D9E714187B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687278940; x=1718814940;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=JK3tVYgPO813k37yyUcq4KAbO6r53M5gA1CD/W9gXN8=;
 b=V3dHlwtj4cpx3B45KrYKdr5YF2sXNnNkRXkUuWnz/qdfQHbC9FVj2j3l
 xYpV9A8nHuo1nQHyKUYkn78x21IqBB5D2S4F31CQc0a7Zu9TE1yfv7pf8
 bkZGeVQT1C7ftWAgf451bRE83V7mRNaQqZR842qgI/i0u3bh7fVE4JKrT
 Mv5Cj76YliYIX+uqelVnxaEDNMvdseUr+ViC+fxQhMVvxDQ4CqJB7Wtgx
 PSQYttGj2KPr/pNeURLhcND81Bo/aFujSyllXfkYBXBlkS2YVsSSRF2cX
 WXH0l6UDF3Gj96PPQScyfTwlHavSk9yt2jeJ3FLcEusz81Hu3EPOmorXK g==;
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-Id: <20230620163534.1042-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Acpica-devel] [PATCH v1 1/2] ACPI: platform: Ignore SMB0001 only
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
Date: Tue, 20 Jun 2023 16:35:42 -0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Wolfram Sang <wsa@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, acpica-devel@lists.linuxfoundation.org
Cc: Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, Michael Brunner <michael.brunner@kontron.com>

After switchind i2c-scmi driver to be a plaform one it stopped
being enumerated on number of Kontron platformsm, because it's
listed in the forbidden_id_list.

To resolve the situation, split the list to generic one and
another that holds devices that has to be skiped if and only if
they have bogus resources attached (_CRS method returns some).

Fixes: 03d4287add6e ("i2c: scmi: Convert to be a platform driver")
Closes: https://lore.kernel.org/r/60c1756765b9a3f1eab0dcbd84f59f00fe1caf48.camel@kontron.com
Reported-by: Michael Brunner <michael.brunner@kontron.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_platform.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index fe00a5783f53..089a98bd18bf 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -19,13 +19,17 @@
 
 #include "internal.h"
 
+static const struct acpi_device_id forbidden_id_with_resourses[] = {
+	{"SMB0001",  0},	/* ACPI SMBUS virtual device */
+	{ }
+};
+
 static const struct acpi_device_id forbidden_id_list[] = {
 	{"ACPI0009", 0},	/* IOxAPIC */
 	{"ACPI000A", 0},	/* IOAPIC */
 	{"PNP0000",  0},	/* PIC */
 	{"PNP0100",  0},	/* Timer */
 	{"PNP0200",  0},	/* AT DMA Controller */
-	{"SMB0001",  0},	/* ACPI SMBUS virtual device */
 	{ }
 };
 
@@ -83,6 +87,15 @@ static void acpi_platform_fill_resource(struct acpi_device *adev,
 		dest->parent = pci_find_resource(to_pci_dev(parent), dest);
 }
 
+static int acpi_platform_resource_count(struct acpi_resource *ares, void *data)
+{
+	int *count = data;
+
+	*count = *count + 1;
+
+	return 1;
+}
+
 /**
  * acpi_create_platform_device - Create platform device for ACPI device node
  * @adev: ACPI device node to create a platform device for.
@@ -103,7 +116,8 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 	struct resource_entry *rentry;
 	struct list_head resource_list;
 	struct resource *resources = NULL;
-	int count;
+	int count = 0;
+	int ret;
 
 	/* If the ACPI node already has a physical device attached, skip it. */
 	if (adev->physical_node_count)
@@ -113,6 +127,15 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 		return ERR_PTR(-EINVAL);
 
 	INIT_LIST_HEAD(&resource_list);
+	ret = acpi_dev_get_resources(adev, &resource_list, acpi_platform_resource_count, &count);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	acpi_dev_free_resource_list(&resource_list);
+
+	if (count > 0 && !acpi_match_device_ids(adev, forbidden_id_with_resourses))
+		return ERR_PTR(-EINVAL);
+
 	count = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
 	if (count < 0)
 		return NULL;
-- 
2.40.0.1.gaa8946217a0b

