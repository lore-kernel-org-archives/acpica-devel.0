Return-Path: <andriy.shevchenko@linux.intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2A2A6409BE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 351B0410AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687777222; x=1719313222;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bhqeMcnIeLHiERhCVntd9eCy5M/ovDNlECDlMUUEH0Y=;
 b=NiP4nfMehI4R9rIZLrlWfD4ULXH5ODWy2jTbwo0jw3cB3mFoisdu9ndt
 JFwqooKEkypb7UlnCw7clFVFzXQqiolwIBxUgeuXwQy2KD4tovc2UKxc8
 jK2oR1rb6YUz+aep9JLe8yshA+5sFIwTzljBT0op2UPc0DbJjP+dQo5wL
 C7L9SYDWQrD5e0hBqXV22e+E31VUtd/le6ROcLZgeZRtlF1fuvlx3FE5H
 vp4gIAKBPm4TTBZN57QegNzE9sgR2A5JKLzBLgglRyf9l/Kv82Bzs9j3j
 j3iMLaW5auFctjIKdli2uqS3SpnhnVdnC6Z66lpmxkngpBzs/Xd7o6x1w g==;
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-Id: <20230626110026.65825-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230626110026.65825-1-andriy.shevchenko@linux.intel.com>
References: <20230626110026.65825-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Acpica-devel] [PATCH v3 1/4] ACPI: bus: Constify
	acpi_companion_match() returned value
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Mon, 26 Jun 2023 11:00:25 -0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, acpica-devel@lists.linuxfoundation.org
Cc: Robert Moore <robert.moore@intel.com>, Michael Walle <michael@walle.cc>, Len Brown <lenb@kernel.org>, Andi Shyti <andi.shyti@kernel.org>

acpi_companion_match() doesn't alter the contents of the passed
parameter, so we don't expect that returned value can be altered
either. So constify it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/bus.c          | 6 +++---
 drivers/acpi/device_sysfs.c | 2 +-
 drivers/acpi/internal.h     | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index e3e0bd0c5a50..20cdfb37da79 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -682,7 +682,7 @@ bool acpi_device_is_first_physical_node(struct acpi_device *adev,
  * resources available from it but they will be matched normally using functions
  * provided by their bus types (and analogously for their modalias).
  */
-struct acpi_device *acpi_companion_match(const struct device *dev)
+const struct acpi_device *acpi_companion_match(const struct device *dev)
 {
 	struct acpi_device *adev;
 
@@ -706,7 +706,7 @@ struct acpi_device *acpi_companion_match(const struct device *dev)
  * identifiers and a _DSD object with the "compatible" property, use that
  * property to match against the given list of identifiers.
  */
-static bool acpi_of_match_device(struct acpi_device *adev,
+static bool acpi_of_match_device(const struct acpi_device *adev,
 				 const struct of_device_id *of_match_table,
 				 const struct of_device_id **of_id)
 {
@@ -808,7 +808,7 @@ static bool __acpi_match_device_cls(const struct acpi_device_id *id,
 	return true;
 }
 
-static bool __acpi_match_device(struct acpi_device *device,
+static bool __acpi_match_device(const struct acpi_device *device,
 				const struct acpi_device_id *acpi_ids,
 				const struct of_device_id *of_ids,
 				const struct acpi_device_id **acpi_id,
diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 0fbfbaa8d8e3..b9bbf0746199 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -283,7 +283,7 @@ int acpi_device_uevent_modalias(const struct device *dev, struct kobj_uevent_env
 }
 EXPORT_SYMBOL_GPL(acpi_device_uevent_modalias);
 
-static int __acpi_device_modalias(struct acpi_device *adev, char *buf, int size)
+static int __acpi_device_modalias(const struct acpi_device *adev, char *buf, int size)
 {
 	int len, count;
 
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 50dcb35c9965..f4148dc50b9c 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -121,7 +121,7 @@ int acpi_bus_register_early_device(int type);
 /* --------------------------------------------------------------------------
                      Device Matching and Notification
    -------------------------------------------------------------------------- */
-struct acpi_device *acpi_companion_match(const struct device *dev);
+const struct acpi_device *acpi_companion_match(const struct device *dev);
 int __acpi_device_uevent_modalias(const struct acpi_device *adev,
 				  struct kobj_uevent_env *env);
 
-- 
2.40.0.1.gaa8946217a0b

