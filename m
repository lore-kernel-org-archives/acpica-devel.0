Return-Path: <raag.jadav@intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 13D6A43271
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 41FCF40122
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697791701; x=1729327701;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=VTxu+ilZT0ByPxEPyTKRaS8c0W/p+nQekrV/1V+4jQc=;
 b=OJJrz6hApE3sw6lDZqb8SB4GEC11s7v/9R+obMP2aEzczlg9uNzAIPSH
 H3pMB+a0CrRfIQL1lA4DqROiojZnyGBB4bZ33HYgdW/JKK3/scW0GJthy
 6KJ/qeyPyziR8NZ4pULcMwT9E0ila2iHvm1NHEEH9wsEXJ6HgP3B6vjMv
 5Tu7T20Z+XagQo7xp4D7PtmfPpvry9lCVmkWNKjkr5y1PRkyj2iFinB5W
 YKzs4HEV961WbhAI2nq2fMFsjNDMDQHI82ZQ9drhNAtWtUObSWzjEPSO/
 xnCiUi7LWmkJXe+EjeEHfK6QgjaOW0ryJ4xByqY+9SYtuk7+uCMmtJf12 A==;
From: Raag Jadav <raag.jadav@intel.com>
Date: Fri, 20 Oct 2023 14:17:31 +0530
Message-Id: <20231020084732.17130-8-raag.jadav@intel.com>
In-Reply-To: <20231020084732.17130-1-raag.jadav@intel.com>
References: <20231020084732.17130-1-raag.jadav@intel.com>
Subject: [Acpica-devel] [PATCH v1 7/8] hwmon: nct6775: use
	acpi_dev_hid_uid_match() for matching _HID and _UID
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
 drivers/hwmon/nct6775-platform.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
index 81bf03dad6bb..0adeeab7ee03 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -1465,10 +1465,8 @@ static const char * const asus_msi_boards[] = {
 static int nct6775_asuswmi_device_match(struct device *dev, void *data)
 {
 	struct acpi_device *adev = to_acpi_device(dev);
-	const char *uid = acpi_device_uid(adev);
-	const char *hid = acpi_device_hid(adev);
 
-	if (hid && !strcmp(hid, ASUSWMI_DEVICE_HID) && uid && !strcmp(uid, data)) {
+	if (acpi_dev_hid_uid_match(adev, ASUSWMI_DEVICE_HID, data)) {
 		asus_acpi_dev = adev;
 		return 1;
 	}
-- 
2.17.1

