Return-Path: <raag.jadav@intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4AF4440146
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 425CD401C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698039384; x=1729575384;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=8Pmv3DZWM/2dbRrEDbbreAnJn6Hwwne5SAiYAHhbnP4=;
 b=RbrLhWumLqNBeINKT6dIjlbHg/BdSt1vYZ4DWu4WcaTmA9VvdEdgAuLx
 2EuLFgR8ygKo04BonKL3mjdRvsJub0zE+6RKQ4HJa8ryiYs+H7ltD7lMK
 A1K5ydILuOPNF3syF4Zy1yTY+ruC1w1BsWZtFXXAIwKWp8YVaGNR8Tkuo
 uv+eeA77ABi4l9JE5aFKGinBmG22cbOTX0ER+5pArLOQ+Y28xrxo4MNrl
 9MAk59AGRgyDnJCOaTRzLUw0jpbyWGR2+pH0wMiLx3DqZ1fj7s7xd+LVi
 c6JEIkbSpKctI6f/1hPKKxDE9pPmWbQDeEpXO7eSWv8p1Q9w8lywceXhA w==;
From: Raag Jadav <raag.jadav@intel.com>
Date: Mon, 23 Oct 2023 11:05:25 +0530
Message-Id: <20231023053530.5525-2-raag.jadav@intel.com>
In-Reply-To: <20231023053530.5525-1-raag.jadav@intel.com>
References: <20231023053530.5525-1-raag.jadav@intel.com>
Subject: [Acpica-devel] [PATCH v2 1/6] ACPI: utils: Introduce
	acpi_dev_uid_match() for matching _UID
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

Introduce acpi_dev_uid_match() helper that matches the device with
supplied _UID string.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/acpi/utils.c    | 31 +++++++++++++++++++++++++++----
 include/acpi/acpi_bus.h |  1 +
 include/linux/acpi.h    |  5 +++++
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 79915d4a0031..be21b77059af 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -824,20 +824,43 @@ bool acpi_check_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 funcs)
 }
 EXPORT_SYMBOL(acpi_check_dsm);
 
+/**
+ * acpi_dev_uid_match - Match device by supplied UID
+ * @adev: ACPI device to match.
+ * @uid2: Unique ID of the device.
+ *
+ * Matches UID in @adev with given @uid2.
+ *
+ * Returns:
+ *  - %true if matches.
+ *  - %false otherwise.
+ */
+bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2)
+{
+	const char *uid1 = acpi_device_uid(adev);
+
+	return uid1 && uid2 && !strcmp(uid1, uid2);
+}
+EXPORT_SYMBOL_GPL(acpi_dev_uid_match);
+
 /**
  * acpi_dev_hid_uid_match - Match device by supplied HID and UID
  * @adev: ACPI device to match.
  * @hid2: Hardware ID of the device.
  * @uid2: Unique ID of the device, pass NULL to not check _UID.
  *
- * Matches HID and UID in @adev with given @hid2 and @uid2.
- * Returns true if matches.
+ * Matches HID and UID in @adev with given @hid2 and @uid2. Absence of @uid2
+ * will be treated as a match. If user wants to validate @uid2, it should be
+ * done before calling this function.
+ *
+ * Returns:
+ *  - %true if matches or @uid2 is NULL.
+ *  - %false otherwise.
  */
 bool acpi_dev_hid_uid_match(struct acpi_device *adev,
 			    const char *hid2, const char *uid2)
 {
 	const char *hid1 = acpi_device_hid(adev);
-	const char *uid1 = acpi_device_uid(adev);
 
 	if (strcmp(hid1, hid2))
 		return false;
@@ -845,7 +868,7 @@ bool acpi_dev_hid_uid_match(struct acpi_device *adev,
 	if (!uid2)
 		return true;
 
-	return uid1 && !strcmp(uid1, uid2);
+	return acpi_dev_uid_match(adev, uid2);
 }
 EXPORT_SYMBOL(acpi_dev_hid_uid_match);
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 756b3f3c2c45..afeed6e72049 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -763,6 +763,7 @@ static inline bool acpi_device_can_poweroff(struct acpi_device *adev)
 		adev->power.states[ACPI_STATE_D3_HOT].flags.explicit_set);
 }
 
+bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2);
 bool acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const char *uid2);
 int acpi_dev_uid_to_integer(struct acpi_device *adev, u64 *integer);
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index afd94c9b8b8a..db3a33e19c97 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -787,6 +787,11 @@ static inline bool acpi_dev_present(const char *hid, const char *uid, s64 hrv)
 
 struct acpi_device;
 
+static inline bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2)
+{
+	return false;
+}
+
 static inline bool
 acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const char *uid2)
 {
-- 
2.17.1

