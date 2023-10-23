Return-Path: <raag.jadav@intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9130340146
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E90364026E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698039388; x=1729575388;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=iUljf5QPUJwxYR0tI8SM3GVeSDgYpl24Lk1AfcVvgFI=;
 b=WW5AUmWHA4vx7eEQ49U8UbBCXG0wXttb7P0IHBXPAVOtce8/KkrTINwe
 RngMPvUZ8zcZ89d4+eWTiie2nM/XxFOJ62U98ppc6elhrFnvUoGmFzVsw
 RB8Xu+dpzGVGTUw5n2l6YTFZRCgD0hbTe2POzEQcKnaIEMhDAxTlqu4Nu
 bV/EPEaO67DC23Y/ezZRebyl5/SnWIlBqrG/HY4tyAc80Z6Sbtxta35Gm
 jk2/2U3afVQ86OflZzKY5aBZB9zRjUmoWH+ns6XFpt8f9LR3eVAw3Wz2Y
 FMIq0VBc7X68WDn9yURJGTKvFr25M7eCYTqkw5IGeKYfH+c3WSBjhHwMk A==;
From: Raag Jadav <raag.jadav@intel.com>
Date: Mon, 23 Oct 2023 11:05:29 +0530
Message-Id: <20231023053530.5525-6-raag.jadav@intel.com>
In-Reply-To: <20231023053530.5525-1-raag.jadav@intel.com>
References: <20231023053530.5525-1-raag.jadav@intel.com>
Subject: [Acpica-devel] [PATCH v2 5/6] hwmon: nct6775: use
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
To: rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com, mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, mark.rutland@arm.com, will@kernel.org, linux@roeck-us.net, Jonathan.Cameron@Huawei.com
Cc: linux-hwmon@vger.kernel.org, linux-gpio@vger.kernel.org, Raag Jadav <raag.jadav@intel.com>, mallikarjunappa.sangannavar@intel.com, linux-kernel@vger.kernel.org, bala.senthil@intel.com, linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, linux-arm-kernel@lists.infradead.org

Convert manual _UID references to use the standard ACPI helper.

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

