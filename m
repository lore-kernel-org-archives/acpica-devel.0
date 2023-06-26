Return-Path: <andriy.shevchenko@linux.intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5990481E21
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9377E81D68
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687777220; x=1719313220;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cfkHmvhL16siboX9Cx9flRIYjtdn8/awF8GL0BpfHpU=;
 b=QW8LRpbZwgh3kd/uGMO7bsV14f87Jc0YdxR+yOr65slFLp1Uyyd+t3XT
 4kiicMrN1dDG5nJZ9diclvIEtCjwjP0Xv2qYi4bdf/HiHDI729fMrSERK
 ncXXoMm70WzAKoUf27adEMTMvdEmjJTlo8X5Lysm7R9LF19uTDyFW6+mg
 PfP5H5KV6N+3VsVvR/LVqC192OC6WNneayD7R0uU+lNgZ+W+/tbJuHZfs
 iu/LNQR2sYoTie0cctUL9QcLM+ZZfJEISSUu6d1nuOgwahz92pWmf49du
 ndIiUO8CAYpZhxFlvPrStoXX8T7YJEEPtiBDeEa5PSYX7fuZUaQ//iPav A==;
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-Id: <20230626110026.65825-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230626110026.65825-1-andriy.shevchenko@linux.intel.com>
References: <20230626110026.65825-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Acpica-devel] [PATCH v3 2/4] ACPI: bus: Introduce
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
Date: Mon, 26 Jun 2023 11:00:22 -0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, acpica-devel@lists.linuxfoundation.org
Cc: Robert Moore <robert.moore@intel.com>, Michael Walle <michael@walle.cc>, Len Brown <lenb@kernel.org>, Andi Shyti <andi.shyti@kernel.org>

In some cases we can't have a physical node associated with
the ACPI device. Yet we want to match it against ID table and
get respective driver data. Introduce the helper for that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/bus.c   | 15 +++++++++++----
 include/linux/acpi.h |  9 +++++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 20cdfb37da79..ee88bfb60ac2 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -850,6 +850,16 @@ static bool __acpi_match_device(const struct acpi_device *device,
 	return true;
 }
 
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
@@ -864,10 +874,7 @@ static bool __acpi_match_device(const struct acpi_device *device,
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

