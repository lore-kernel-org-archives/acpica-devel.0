Return-Path: <raag.jadav@intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D05687044C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F09460F3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697791692; x=1729327692;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=1P08c+02XrBKccGcreruYeIgD28f7+s17ZZyX78daGc=;
 b=CMEDCpUPJOswyAe6+vH3IfTQrD2FzFchFXSwCa591iFEzTBXlR3CDcem
 2a6ljM4MO4+iNwOAJVNZgrPWUKZQlDL+a04uWR7DL0EYYvlPvKIcy8m6z
 bw5hW1HVBfTv5WlpgFa2Gg2RB2k1d4l8shW5WYSM42djjm+5prUOyT7hx
 WxuH4NZnMUaK8iZwVQAAaJcc1taPBNWSi36wQrJnnzHiVHPBccfsQZBB0
 WDT4Q8vb8aBEwY7TrDBf3KIZkJLHjLXCQi5U05fgoIE9EDxK4iiSS75Bn
 U8+Kebjg6SA0yahw20UnMj6VPzJEQ3/LuoiHp7nkUNQw9lx+1PAsrr8th g==;
From: Raag Jadav <raag.jadav@intel.com>
Date: Fri, 20 Oct 2023 14:17:27 +0530
Message-Id: <20231020084732.17130-4-raag.jadav@intel.com>
In-Reply-To: <20231020084732.17130-1-raag.jadav@intel.com>
References: <20231020084732.17130-1-raag.jadav@intel.com>
Subject: [Acpica-devel] [PATCH v1 3/8] ACPI: sysfs: use acpi_device_uid()
	for fetching _UID
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com, mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, mark.rutland@arm.com, will@kernel.org, linux@roeck-us.net
Cc: linux-hwmon@vger.kernel.org, linux-gpio@vger.kernel.org, Raag Jadav <raag.jadav@intel.com>, mallikarjunappa.sangannavar@intel.com, linux-kernel@vger.kernel.org, bala.senthil@intel.com, linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, linux-arm-kernel@lists.infradead.org

Convert manual _UID references to use standard ACPI helpers.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/acpi/device_sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index b9bbf0746199..9d8e90744cb5 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -410,7 +410,7 @@ static ssize_t uid_show(struct device *dev,
 {
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 
-	return sprintf(buf, "%s\n", acpi_dev->pnp.unique_id);
+	return sprintf(buf, "%s\n", acpi_device_uid(acpi_dev));
 }
 static DEVICE_ATTR_RO(uid);
 
@@ -554,7 +554,7 @@ int acpi_device_setup_files(struct acpi_device *dev)
 
 	if (dev->pnp.type.bus_address)
 		result = device_create_file(&dev->dev, &dev_attr_adr);
-	if (dev->pnp.unique_id)
+	if (acpi_device_uid(dev))
 		result = device_create_file(&dev->dev, &dev_attr_uid);
 
 	if (acpi_has_method(dev->handle, "_SUN")) {
@@ -635,7 +635,7 @@ void acpi_device_remove_files(struct acpi_device *dev)
 	if (acpi_has_method(dev->handle, "_HRV"))
 		device_remove_file(&dev->dev, &dev_attr_hrv);
 
-	if (dev->pnp.unique_id)
+	if (acpi_device_uid(dev))
 		device_remove_file(&dev->dev, &dev_attr_uid);
 	if (dev->pnp.type.bus_address)
 		device_remove_file(&dev->dev, &dev_attr_adr);
-- 
2.17.1

