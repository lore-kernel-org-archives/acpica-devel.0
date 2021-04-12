Content-Type: multipart/mixed; boundary="===============1001622371587513431=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] [PATCH v2 1/1] ACPI: bus: Introduce acpi_dev_get() and reuse
 it in ACPI code
Date: Tue, 13 Apr 2021 01:23:58 +0300
Message-ID: <20210412222358.2078782-1-andy.shevchenko@gmail.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1001622371587513431==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Introduce acpi_dev_get() to have a symmetrical API with acpi_dev_put()
and reuse both in ACPI code under drivers/acpi folder.

While at it, use acpi_bus_put_acpi_device() in one place rather than above.

Signed-off-by: Andy Shevchenko <andy.shevchenko(a)gmail.com>
---
v2: made acpi_dev_get() to return pointer as get_device() does (Rafael)
 drivers/acpi/device_sysfs.c | 4 ++--
 drivers/acpi/glue.c         | 8 ++++----
 drivers/acpi/scan.c         | 9 ++++-----
 include/acpi/acpi_bus.h     | 5 +++++
 4 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index a07d4ade5835..fa2c1c93072c 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -377,12 +377,12 @@ eject_store(struct device *d, struct device_attribute=
 *attr,
 	if (ACPI_FAILURE(status) || !acpi_device->flags.ejectable)
 		return -ENODEV;
 =

-	get_device(&acpi_device->dev);
+	acpi_dev_get(acpi_device);
 	status =3D acpi_hotplug_schedule(acpi_device, ACPI_OST_EC_OSPM_EJECT);
 	if (ACPI_SUCCESS(status))
 		return count;
 =

-	put_device(&acpi_device->dev);
+	acpi_dev_put(acpi_device);
 	acpi_evaluate_ost(acpi_device->handle, ACPI_OST_EC_OSPM_EJECT,
 			  ACPI_OST_SC_NON_SPECIFIC_FAILURE, NULL);
 	return status =3D=3D AE_NO_MEMORY ? -ENOMEM : -EAGAIN;
diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 36b24b0658cb..0715e3be99a0 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -190,7 +190,7 @@ int acpi_bind_one(struct device *dev, struct acpi_devic=
e *acpi_dev)
 	if (!acpi_dev)
 		return -EINVAL;
 =

-	get_device(&acpi_dev->dev);
+	acpi_dev_get(acpi_dev);
 	get_device(dev);
 	physical_node =3D kzalloc(sizeof(*physical_node), GFP_KERNEL);
 	if (!physical_node) {
@@ -217,7 +217,7 @@ int acpi_bind_one(struct device *dev, struct acpi_devic=
e *acpi_dev)
 				goto err;
 =

 			put_device(dev);
-			put_device(&acpi_dev->dev);
+			acpi_dev_put(acpi_dev);
 			return 0;
 		}
 		if (pn->node_id =3D=3D node_id) {
@@ -257,7 +257,7 @@ int acpi_bind_one(struct device *dev, struct acpi_devic=
e *acpi_dev)
  err:
 	ACPI_COMPANION_SET(dev, NULL);
 	put_device(dev);
-	put_device(&acpi_dev->dev);
+	acpi_dev_put(acpi_dev);
 	return retval;
 }
 EXPORT_SYMBOL_GPL(acpi_bind_one);
@@ -285,7 +285,7 @@ int acpi_unbind_one(struct device *dev)
 			ACPI_COMPANION_SET(dev, NULL);
 			/* Drop references taken by acpi_bind_one(). */
 			put_device(dev);
-			put_device(&acpi_dev->dev);
+			acpi_dev_put(acpi_dev);
 			kfree(entry);
 			break;
 		}
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index d9e024fc6e70..bc973fbd70b2 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -530,7 +530,7 @@ static void acpi_device_del_work_fn(struct work_struct =
*work_not_used)
 		 * used by the device.
 		 */
 		acpi_power_transition(adev, ACPI_STATE_D3_COLD);
-		put_device(&adev->dev);
+		acpi_dev_put(adev);
 	}
 }
 =

@@ -604,8 +604,7 @@ EXPORT_SYMBOL(acpi_bus_get_device);
 =

 static void get_acpi_device(void *dev)
 {
-	if (dev)
-		get_device(&((struct acpi_device *)dev)->dev);
+	acpi_dev_get(dev);
 }
 =

 struct acpi_device *acpi_bus_get_acpi_device(acpi_handle handle)
@@ -615,7 +614,7 @@ struct acpi_device *acpi_bus_get_acpi_device(acpi_handl=
e handle)
 =

 void acpi_bus_put_acpi_device(struct acpi_device *adev)
 {
-	put_device(&adev->dev);
+	acpi_dev_put(adev);
 }
 =

 static struct acpi_device_bus_id *acpi_device_bus_id_match(const char *dev=
_id)
@@ -2355,7 +2354,7 @@ int __init acpi_scan_init(void)
 			acpi_detach_data(acpi_root->handle,
 					 acpi_scan_drop_device);
 			acpi_device_del(acpi_root);
-			put_device(&acpi_root->dev);
+			acpi_bus_put_acpi_device(acpi_root);
 			goto out;
 		}
 	}
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index d631cb52283e..d2f5afb04a0b 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -695,6 +695,11 @@ acpi_dev_get_first_match_dev(const char *hid, const ch=
ar *uid, s64 hrv);
 	     adev;							\
 	     adev =3D acpi_dev_get_next_match_dev(adev, hid, uid, hrv))
 =

+static inline struct acpi_device *acpi_dev_get(struct acpi_device *adev)
+{
+	return adev ? to_acpi_device(get_device(&adev->dev)) : NULL;
+}
+
 static inline void acpi_dev_put(struct acpi_device *adev)
 {
 	put_device(&adev->dev);
-- =

2.31.1

--===============1001622371587513431==--

