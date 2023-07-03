Return-Path: <andriy.shevchenko@linux.intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C9BD8188D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B9667817D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688386454; x=1719922454;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tcBflnra7gCALSSSxjriqj/Y8FpJYDW+EY6Pd4pNPvY=;
 b=m0+VtHtTC98PYJH+/ZS3/VhNpVotMRPrfKP0en2aLPL5CKa9buWDL4ja
 hG3Bn+a4j/EGmFzzsx1N7NGJH/ifOliSk1zFeyzR+T+pUNPbaefjNrFXr
 I4Af4pPcnu5JfgUk8+rnpgqWis8MoTQPJsw+/PbYClLxkKl5mJcTbEQSi
 EY2b9ceml+6ynUUO/PsJcSDuMBaWAia1dV5istWwVB9ToQq4LBUWUoxfs
 6whsyvYCbFV3B4QbvSxPyCdjNw8KChyVkJOBO0oWvtNQRUKefIpmtSrME
 TIBIxQuuT6OKtczy4TmpKQzmTCEEL553DnL30YqFNEw3sNlaK2/4lE1eW g==;
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-Id: <20230703121411.69606-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230703121411.69606-1-andriy.shevchenko@linux.intel.com>
References: <20230703121411.69606-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Acpica-devel] [PATCH v4 1/5] ACPI: bus: Introduce
	acpi_match_acpi_device() helper
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Mon, 03 Jul 2023 12:14:16 -0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Wolfram Sang <wsa@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, acpica-devel@lists.linuxfoundation.org
Cc: Michael Walle <michael@walle.cc>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>

Match the ACPI device against a given list of ACPI IDs.
This may be helpful in different cases.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/bus.c   | 25 +++++++++++++++++++++----
 include/linux/acpi.h |  9 +++++++++
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 20cdfb37da79..2fc2b43a4ed3 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -850,6 +850,26 @@ static bool __acpi_match_device(const struct acpi_device *device,
 	return true;
 }
 
+/**
+ * acpi_match_acpi_device - Match an ACPI device against a given list of ACPI IDs
+ * @ids: Array of struct acpi_device_id objects to match against.
+ * @adev: The ACPI device pointer to match.
+ *
+ * Match the ACPI device @adev against a given list of ACPI IDs @ids.
+ *
+ * Return:
+ * a pointer to the first matching ACPI ID on success or %NULL on failure.
+ */
+const struct acpi_device_id *acpi_match_acpi_device(const struct acpi_device_id *ids,
+						    const struct acpi_device *adev)
+{
+	const struct acpi_device_id *id = NULL;
+
+	__acpi_match_device(adev, ids, NULL, &id, NULL);
+	return id;
+}
+EXPORT_SYMBOL_GPL(acpi_match_acpi_device);
+
 /**
  * acpi_match_device - Match a struct device against a given list of ACPI IDs
  * @ids: Array of struct acpi_device_id object to match against.
@@ -864,10 +884,7 @@ static bool __acpi_match_device(const struct acpi_device *device,
 const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
 					       const struct device *dev)
 {
-	const struct acpi_device_id *id = NULL;
-
-	__acpi_match_device(acpi_companion_match(dev), ids, NULL, &id, NULL);
-	return id;
+	return acpi_match_acpi_device(ids, acpi_companion_match(dev));
 }
 EXPORT_SYMBOL_GPL(acpi_match_device);
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 640f1c07c894..641dc4843987 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -707,6 +707,9 @@ extern int acpi_nvs_register(__u64 start, __u64 size);
 extern int acpi_nvs_for_each_region(int (*func)(__u64, __u64, void *),
 				    void *data);
 
+const struct acpi_device_id *acpi_match_acpi_device(const struct acpi_device_id *ids,
+						    const struct acpi_device *adev);
+
 const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
 					       const struct device *dev);
 
@@ -922,6 +925,12 @@ static inline int acpi_nvs_for_each_region(int (*func)(__u64, __u64, void *),
 
 struct acpi_device_id;
 
+static inline const struct acpi_device_id *acpi_match_acpi_device(
+	const struct acpi_device_id *ids, const struct acpi_device *adev)
+{
+	return NULL;
+}
+
 static inline const struct acpi_device_id *acpi_match_device(
 	const struct acpi_device_id *ids, const struct device *dev)
 {
-- 
2.40.0.1.gaa8946217a0b

