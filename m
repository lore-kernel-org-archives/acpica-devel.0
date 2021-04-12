Content-Type: multipart/mixed; boundary="===============8752178714286369323=="
MIME-Version: 1.0
From: Andy Shevchenko <andy.shevchenko at gmail.com>
Subject: [Devel] [PATCH v2 2/2] ACPI: utils: Capitalize abbreviations in the
 comments
Date: Tue, 13 Apr 2021 02:20:52 +0300
Message-ID: <20210412232052.2162107-2-andy.shevchenko@gmail.com>
In-Reply-To: 20210412232052.2162107-1-andy.shevchenko@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8752178714286369323==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The DSDT and ACPI should be capitalized.

Signed-off-by: Andy Shevchenko <andy.shevchenko(a)gmail.com>
---
v2: split from patch 1 as per Rafael's request
 drivers/acpi/utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 60e46efc1bc8..3b54b8fd7396 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -811,7 +811,7 @@ static int acpi_dev_match_cb(struct device *dev, const =
void *data)
  * Note that if the device is pluggable, it may since have disappeared.
  *
  * Note that unlike acpi_dev_found() this function checks the status
- * of the device. So for devices which are present in the dsdt, but
+ * of the device. So for devices which are present in the DSDT, but
  * which are disabled (their _STA callback returns 0) this function
  * will return false.
  *
@@ -838,7 +838,7 @@ EXPORT_SYMBOL(acpi_dev_present);
 =

 /**
  * acpi_dev_get_next_match_dev - Return the next match of ACPI device
- * @adev: Pointer to the previous acpi_device matching this @hid, @uid and=
 @hrv
+ * @adev: Pointer to the previous ACPI device matching this @hid, @uid and=
 @hrv
  * @hid: Hardware ID of the device.
  * @uid: Unique ID of the device, pass NULL to not check _UID
  * @hrv: Hardware Revision of the device, pass -1 to not check _HRV
-- =

2.31.1

--===============8752178714286369323==--

