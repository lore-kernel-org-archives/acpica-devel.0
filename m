Content-Type: multipart/mixed; boundary="===============6303159835953925886=="
MIME-Version: 1.0
From: Lv Zheng <lv.zheng at intel.com>
Subject: [Devel] [RFC PATCH] ACPI: Add boot option to disable auto return
 object repair
Date: Wed, 23 Jan 2013 15:29:02 +0800
Message-ID: <59ec303219ed43c247fd5afc75de35553b9a52d5.1358954645.git.lv.zheng@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6303159835953925886==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is automatic return object repair mechanism implemented in
ACPICA which can not handle all of the issues exposed by BIOS
currently. This patch allow a kernel boots up without such
workarounds enabled. A better choice should refine the repair
mechanism to allow more robust evaluation result.

Signed-off-by: Lv Zheng <lv.zheng(a)intel.com>
---
 drivers/acpi/bus.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 01708a1..e33577f 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -805,6 +805,18 @@ static int __init acpi_bus_init(void)
 struct kobject *acpi_kobj;
 EXPORT_SYMBOL_GPL(acpi_kobj);
 =

+static int __init acpi_disable_repair(char *s)
+{
+        printk(KERN_NOTICE PREFIX
+	       "ACPI: Predefined names repair disabled\n");
+
+        acpi_gbl_disable_auto_repair =3D TRUE;
+
+        return 1;
+}
+
+__setup("acpi_no_repair", acpi_disable_repair);
+
 static int __init acpi_init(void)
 {
 	int result;
-- =

1.7.10.4


--===============6303159835953925886==--

