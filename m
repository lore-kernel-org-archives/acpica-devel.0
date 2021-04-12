Content-Type: multipart/mixed; boundary="===============1757784154284229037=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] [PATCH v2 1/2] ACPI: utils: Document
 for_each_acpi_dev_match() macro
Date: Tue, 13 Apr 2021 02:20:51 +0300
Message-ID: <20210412232052.2162107-1-andy.shevchenko@gmail.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1757784154284229037==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The macro requires to call acpi_dev_put() on each iteration.
Due to this it doesn't tolerate sudden disappearence of the devices.

Document all these nuances to prevent users blindly call it without
understanding the possible issues.

While at it, add the note to the acpi_dev_get_next_match_dev() and
advertise acpi_dev_put() instead of put_device() in the whole family
of the helper functions.

Fixes: bf263f64e804 ("media: ACPI / bus: Add acpi_dev_get_next_match_dev() =
and helper macro")
Cc: Daniel Scally <djrscally(a)gmail.com>
Signed-off-by: Andy Shevchenko <andy.shevchenko(a)gmail.com>
---
v2:
  fixed grammar (Rafael)
  split unrelated fixes to a separate fix (Rafael)
  Add FIXME (for now let's document and fix in the next cycle)

 drivers/acpi/utils.c    |  8 ++++++--
 include/acpi/acpi_bus.h | 14 ++++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 29080177cd83..60e46efc1bc8 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -846,7 +846,11 @@ EXPORT_SYMBOL(acpi_dev_present);
  * Return the next match of ACPI device if another matching device was pre=
sent
  * at the moment of invocation, or NULL otherwise.
  *
- * The caller is responsible to call put_device() on the returned device.
+ * FIXME: The function does not tolerate the sudden disappearance of @adev=
, e.g.
+ * in the case of a hotplug event. That said, the caller should ensure that
+ * this will never happen.
+ *
+ * The caller is responsible for invoking acpi_dev_put() on the returned d=
evice.
  *
  * See additional information in acpi_dev_present() as well.
  */
@@ -875,7 +879,7 @@ EXPORT_SYMBOL(acpi_dev_get_next_match_dev);
  * Return the first match of ACPI device if a matching device was present
  * at the moment of invocation, or NULL otherwise.
  *
- * The caller is responsible to call put_device() on the returned device.
+ * The caller is responsible for invoking acpi_dev_put() on the returned d=
evice.
  *
  * See additional information in acpi_dev_present() as well.
  */
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index d2f5afb04a0b..3a82faac5767 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -690,6 +690,20 @@ acpi_dev_get_next_match_dev(struct acpi_device *adev, =
const char *hid, const cha
 struct acpi_device *
 acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv);
 =

+/**
+ * for_each_acpi_dev_match - iterate over ACPI devices that matching the c=
riteria
+ * @adev: pointer to the matching ACPI device, NULL at the end of the loop
+ * @hid: Hardware ID of the device.
+ * @uid: Unique ID of the device, pass NULL to not check _UID
+ * @hrv: Hardware Revision of the device, pass -1 to not check _HRV
+ *
+ * The caller is responsible for invoking acpi_dev_put() on the returned d=
evice.
+ *
+ * FIXME: Due to above requirement there is a window that may invalidate @=
adev
+ * and next iteration will use a dangling pointer, e.g. in the case of a
+ * hotplug event. That said, the caller should ensure that this will never
+ * happen.
+ */
 #define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
 	for (adev =3D acpi_dev_get_first_match_dev(hid, uid, hrv);	\
 	     adev;							\
-- =

2.31.1

--===============1757784154284229037==--

