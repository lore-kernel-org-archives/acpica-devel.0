Content-Type: multipart/mixed; boundary="===============6677804569156182402=="
MIME-Version: 1.0
From: Lv Zheng <lv.zheng at intel.com>
Subject: [Devel] [RFC PATCH v2 3/5] ACPICA: Tables: Change table duplication
 check to be related to acpi_gbl_verify_table_checksum
Date: Tue, 16 May 2017 15:13:39 +0800
Message-ID: <579de00f5d54e128b04bba5ae627afd0f132c528.1494916766.git.lv.zheng@intel.com>
In-Reply-To: cover.1494916766.git.lv.zheng@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6677804569156182402==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

acpi_gbl_verify_table_checksum is used to avoid validating (mapping) an ent=
ire
table in OS boot stage. 2nd "Reload" check in acpi_tb_install_standard_tabl=
e()
is prepared for the same purpose. So this patch combines them together
using a renamed acpi_gbl_enable_table_validation flag. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng(a)intel.com>
---
 drivers/acpi/acpica/tbdata.c   |  4 ++--
 drivers/acpi/acpica/tbinstal.c |  2 +-
 drivers/acpi/acpica/tbxface.c  |  8 ++++++++
 drivers/acpi/bus.c             |  2 +-
 drivers/acpi/tables.c          |  4 ++--
 include/acpi/acpixf.h          | 15 ++++++++-------
 6 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 42ea044..e81355b 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -338,7 +338,7 @@ void acpi_tb_invalidate_table(struct acpi_table_desc *t=
able_desc)
 acpi_status acpi_tb_validate_temp_table(struct acpi_table_desc *table_desc)
 {
 =

-	if (!table_desc->pointer && !acpi_gbl_verify_table_checksum) {
+	if (!table_desc->pointer && !acpi_gbl_enable_table_validation) {
 		/*
 		 * Only validates the header of the table.
 		 * Note that Length contains the size of the mapping after invoking
@@ -394,7 +394,7 @@ acpi_tb_verify_temp_table(struct acpi_table_desc *table=
_desc, char *signature)
 =

 	/* Verify the checksum */
 =

-	if (acpi_gbl_verify_table_checksum) {
+	if (acpi_gbl_enable_table_validation) {
 		status =3D
 		    acpi_tb_verify_checksum(table_desc->pointer,
 					    table_desc->length);
diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 9d21296..f7bc362 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -221,7 +221,7 @@ acpi_tb_install_standard_table(acpi_physical_address ad=
dress,
 =

 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 =

-	if (reload) {
+	if (acpi_gbl_enable_table_validation) {
 =

 		/* Check if table is already registered */
 =

diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index 010b1c43..b0dc841 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -194,6 +194,14 @@ acpi_status ACPI_INIT_FUNCTION acpi_reallocate_root_ta=
ble(void)
 		}
 	}
 =

+	if (!acpi_gbl_enable_table_validation) {
+		/*
+		 * Now it's safe to do full table validation. We can do deferred
+		 * table initilization here once the flag is set.
+		 */
+		acpi_gbl_enable_table_validation =3D TRUE;
+	}
+
 	acpi_gbl_root_table_list.flags |=3D ACPI_ROOT_ALLOW_RESIZE;
 =

 	status =3D acpi_tb_resize_root_table_list();
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 34fbe02..c26342f 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1010,7 +1010,7 @@ void __init acpi_early_init(void)
 	printk(KERN_INFO PREFIX "Core revision %08x\n", ACPI_CA_VERSION);
 =

 	/* It's safe to verify table checksums during late stage */
-	acpi_gbl_verify_table_checksum =3D TRUE;
+	acpi_gbl_enable_table_validation =3D TRUE;
 =

 	/* enable workarounds, unless strict ACPI spec. compliance */
 	if (!acpi_strict)
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 0dae722..b5cc09c 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -740,10 +740,10 @@ int __init acpi_table_init(void)
 =

 	if (acpi_verify_table_checksum) {
 		pr_info("Early table checksum verification enabled\n");
-		acpi_gbl_verify_table_checksum =3D TRUE;
+		acpi_gbl_enable_table_validation =3D TRUE;
 	} else {
 		pr_info("Early table checksum verification disabled\n");
-		acpi_gbl_verify_table_checksum =3D FALSE;
+		acpi_gbl_enable_table_validation =3D FALSE;
 	}
 =

 	status =3D acpi_initialize_tables(initial_tables, ACPI_MAX_TABLES, 0);
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 15c86ce..88a1de8 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -160,13 +160,14 @@ ACPI_INIT_GLOBAL(u8, acpi_gbl_create_osi_method, TRUE=
);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_use_default_register_widths, TRUE);
 =

 /*
- * Whether or not to verify the table checksum before installation. Set
- * this to TRUE to verify the table checksum before install it to the table
- * manager. Note that enabling this option causes errors to happen in some
- * OSPMs during early initialization stages. Default behavior is to do such
- * verification.
- */
-ACPI_INIT_GLOBAL(u8, acpi_gbl_verify_table_checksum, TRUE);
+ * Whether or not to validate (map) an entire table to verify
+ * checksum/duplication in early stage before install. Set this to TRUE to
+ * allow early table validation before install it to the table manager.
+ * Note that enabling this option causes errors to happen in some OSPMs
+ * during early initialization stages. Default behavior is to allow such
+ * validation.
+ */
+ACPI_INIT_GLOBAL(u8, acpi_gbl_enable_table_validation, TRUE);
 =

 /*
  * Optionally enable output from the AML Debug Object.
-- =

2.7.4


--===============6677804569156182402==--

