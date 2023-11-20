Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396F818E12
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 20 Nov 2023 12:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JjM0SLb3"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5DBDA410AC
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 20 Nov 2023 12:09:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5DBDA410AC
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JjM0SLb3
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xmVszeexeR0w
	for <acpica-devel@lists.linuxfoundation.org>;
	Mon, 20 Nov 2023 12:09:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C9E66410A0
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 20 Nov 2023 12:09:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C9E66410A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700482145; x=1732018145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=grRMXiEtkBznUlyfaZprJCk2FG73YbohNhePpa+Muco=;
  b=JjM0SLb33GESpJsosUzf1zBude0RR+SWdxfSYzCMdeozd4uOIrk8bB29
   MdIp3PY6IvwcN4VQa+X14fELMxbHKfVKqgHTt7UGOi4DMqB1PpbqtCaQ8
   VAGaOHYny7zSMCN9tqjz8RgttbTyPQINGJSVGi9cHBVOH9rUZbBBOBuAj
   3gI1EywKxi0Zqk7wJGTPpWdb3Wn1ysk6e5aHSu0QUL7apqMFGEfJsghON
   5tP4HxazRIPFj8wAw2NDhx4T7CsyM+5PchlrJVkpDP0l5ve6oGQxbLamP
   IlFWW1IHoBBwy3VklsQjaUJ7MgdQkt/B/4RJcFy+FcyiinoRZ2Qh8dnjW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="394455707"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="394455707"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 04:09:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="769878637"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="769878637"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga007.fm.intel.com with ESMTP; 20 Nov 2023 04:09:00 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	rafael@kernel.org,
	lenb@kernel.org,
	robert.moore@intel.com,
	ardb@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org,
	linux-efi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	mallikarjunappa.sangannavar@intel.com,
	bala.senthil@intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 3/6] ACPI: bus: update acpi_dev_hid_uid_match() to support multiple types
Date: Mon, 20 Nov 2023 17:38:34 +0530
Message-Id: <20231120120837.3002-4-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231120120837.3002-1-raag.jadav@intel.com>
References: <20231120120837.3002-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>

Now that we have _UID matching support for both integer and string types,
we can support them into acpi_dev_hid_uid_match() helper as well.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/acpi/utils.c    | 29 -----------------------------
 include/acpi/acpi_bus.h | 23 ++++++++++++++++++++++-
 include/linux/acpi.h    |  7 +------
 3 files changed, 23 insertions(+), 36 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index fe7e850c6479..03f6de9a0807 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -824,35 +824,6 @@ bool acpi_check_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 funcs)
 }
 EXPORT_SYMBOL(acpi_check_dsm);
 
-/**
- * acpi_dev_hid_uid_match - Match device by supplied HID and UID
- * @adev: ACPI device to match.
- * @hid2: Hardware ID of the device.
- * @uid2: Unique ID of the device, pass NULL to not check _UID.
- *
- * Matches HID and UID in @adev with given @hid2 and @uid2. Absence of @uid2
- * will be treated as a match. If user wants to validate @uid2, it should be
- * done before calling this function.
- *
- * Returns:
- *  - %true if matches or @uid2 is NULL.
- *  - %false otherwise.
- */
-bool acpi_dev_hid_uid_match(struct acpi_device *adev,
-			    const char *hid2, const char *uid2)
-{
-	const char *hid1 = acpi_device_hid(adev);
-
-	if (strcmp(hid1, hid2))
-		return false;
-
-	if (!uid2)
-		return true;
-
-	return acpi_dev_uid_match(adev, uid2);
-}
-EXPORT_SYMBOL(acpi_dev_hid_uid_match);
-
 /**
  * acpi_dev_uid_to_integer - treat ACPI device _UID as integer
  * @adev: ACPI device to get _UID from
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 25b9fabf350f..979a60a512e5 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -857,9 +857,15 @@ static inline bool acpi_device_can_poweroff(struct acpi_device *adev)
 		adev->power.states[ACPI_STATE_D3_HOT].flags.explicit_set);
 }
 
-bool acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const char *uid2);
 int acpi_dev_uid_to_integer(struct acpi_device *adev, u64 *integer);
 
+static inline bool acpi_dev_hid_match(struct acpi_device *adev, const char *hid2)
+{
+	const char *hid1 = acpi_device_hid(adev);
+
+	return hid1 && hid2 && !strcmp(hid1, hid2);
+}
+
 static inline bool acpi_str_uid_match(struct acpi_device *adev, const char *uid2)
 {
 	const char *uid1 = acpi_device_uid(adev);
@@ -893,6 +899,21 @@ static inline bool acpi_int_uid_match(struct acpi_device *adev, u64 uid2)
 		 const char *: acpi_str_uid_match,				\
 		 u64: acpi_int_uid_match)(adev, uid2)
 
+/**
+ * acpi_dev_hid_uid_match - Match device by supplied HID and UID
+ * @adev: ACPI device to match.
+ * @hid2: Hardware ID of the device.
+ * @uid2: Unique ID of the device, pass 0 or NULL to not check _UID.
+ *
+ * Matches HID and UID in @adev with given @hid2 and @uid2. Absence of @uid2
+ * will be treated as a match. If user wants to validate @uid2, it should be
+ * done before calling this function.
+ *
+ * Returns: %true if matches or @uid2 is 0 or NULL, %false otherwise.
+ */
+#define acpi_dev_hid_uid_match(adev, hid2, uid2) \
+	(acpi_dev_hid_match(adev, hid2) && (!uid2 || acpi_dev_uid_match(adev, uid2)))
+
 void acpi_dev_clear_dependencies(struct acpi_device *supplier);
 bool acpi_dev_ready_for_enumeration(const struct acpi_device *device);
 struct acpi_device *acpi_dev_get_next_consumer_dev(struct acpi_device *supplier,
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 3d7ee8c0b86a..c43ae3bd238d 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -758,6 +758,7 @@ const char *acpi_get_subsystem_id(acpi_handle handle);
 
 /* Get rid of the -Wunused-variable for adev */
 #define acpi_dev_uid_match(adev, uid2)		(adev && false)
+#define acpi_dev_hid_uid_match(adev, uid2)	(adev && false)
 
 #include <acpi/acpi_numa.h>
 
@@ -775,12 +776,6 @@ static inline bool acpi_dev_present(const char *hid, const char *uid, s64 hrv)
 
 struct acpi_device;
 
-static inline bool
-acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const char *uid2)
-{
-	return false;
-}
-
 static inline int acpi_dev_uid_to_integer(struct acpi_device *adev, u64 *integer)
 {
 	return -ENODEV;
-- 
2.17.1

