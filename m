Content-Type: multipart/mixed; boundary="===============4360443953803850564=="
MIME-Version: 1.0
From: Lv Zheng <lv.zheng at intel.com>
Subject: [Devel] [RFC PATCH 7/7] ACPICA: Tables: Change table comparison using
 table header for static load tables
Date: Wed, 15 Mar 2017 14:37:42 +0800
Message-ID: <a70b2cb791b0d5f7571b624279fc46ace35d920a.1489558845.git.lv.zheng@intel.com>
In-Reply-To: cover.1489558845.git.lv.zheng@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4360443953803850564==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For AML tables, checksum is available for us to detect a duplicate table,
so this patch removes byte-by-byte check for static load tables to improve
performance, and comparing header allows us to validate if
LEN/CSUM/OEM fields match. Suggested by Bob Moore, fixed by Lv Zheng.

Suggested-by: Bob Moore <robert.moore(a)intel.com>
Signed-off-by: Lv Zheng <lv.zheng(a)intel.com>
Cc: Hans de Goede <hdegoede(a)redhat.com>
---
 drivers/acpi/acpica/tbdata.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 180c7a3..09fab1d 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -52,10 +52,12 @@ ACPI_MODULE_NAME("tbdata")
 =

 /* Local prototypes */
 static u8
-acpi_tb_compare_tables(struct acpi_table_desc *table_desc, u32 table_index=
);
+acpi_tb_compare_tables(struct acpi_table_desc *table_desc,
+		       u8 reload, u32 table_index);
 =

 static acpi_status
 acpi_tb_validate_table_for_load(u32 *table_index,
+				u8 reload,
 				struct acpi_table_header **out_table);
 =

 /*************************************************************************=
******
@@ -782,6 +784,7 @@ void acpi_tb_set_table_loaded_flag(u32 table_index, u8 =
is_loaded)
  * FUNCTION:    acpi_tb_compare_tables
  *
  * PARAMETERS:  table_desc          - Table 1 descriptor to be compared
+ *              reload              - Whether reload should be performed
  *              table_index         - Index of table 2 to be compared
  *
  * RETURN:      TRUE if both tables are identical.
@@ -792,7 +795,8 @@ void acpi_tb_set_table_loaded_flag(u32 table_index, u8 =
is_loaded)
  *************************************************************************=
*****/
 =

 static u8
-acpi_tb_compare_tables(struct acpi_table_desc *table_desc, u32 table_index)
+acpi_tb_compare_tables(struct acpi_table_desc *table_desc,
+		       u8 reload, u32 table_index)
 {
 	acpi_status status =3D AE_OK;
 	u8 is_identical;
@@ -811,9 +815,16 @@ acpi_tb_compare_tables(struct acpi_table_desc *table_d=
esc, u32 table_index)
 	 * Check for a table match on the entire table length,
 	 * not just the header.
 	 */
-	is_identical =3D (u8)((table_desc->length !=3D table_length ||
-			     memcmp(table_desc->pointer, table, table_length)) ?
-			    FALSE : TRUE);
+	if (reload) {
+		is_identical =3D (u8)((table_desc->length !=3D table_length ||
+				     memcmp(table_desc->pointer, table,
+					    table_length)) ? FALSE : TRUE);
+	} else {
+		is_identical =3D
+		    (u8)(memcmp
+			 (table_desc->pointer, table,
+			  sizeof(struct acpi_table_header)) ? FALSE : TRUE);
+	}
 =

 	/* Release the acquired table */
 =

@@ -826,6 +837,7 @@ acpi_tb_compare_tables(struct acpi_table_desc *table_de=
sc, u32 table_index)
  * FUNCTION:    acpi_tb_validate_table_for_load
  *
  * PARAMETERS:  table_index         - Index of table
+ *              reload              - Whether reload should be performed
  *              out_table           - Validated table
  *
  * RETURN:      Status
@@ -838,7 +850,7 @@ acpi_tb_compare_tables(struct acpi_table_desc *table_de=
sc, u32 table_index)
 =

 static acpi_status
 acpi_tb_validate_table_for_load(u32 *table_index,
-				struct acpi_table_header **out_table)
+				u8 reload, struct acpi_table_header **out_table)
 {
 	u32 i;
 	struct acpi_table_desc *table_desc;
@@ -913,7 +925,7 @@ acpi_tb_validate_table_for_load(u32 *table_index,
 		 * Check for a table match on the entire table length, not just the
 		 * header.
 		 */
-		if (!acpi_tb_compare_tables(table_desc, i)) {
+		if (!acpi_tb_compare_tables(table_desc, reload, i)) {
 			continue;
 		}
 =

@@ -973,7 +985,7 @@ acpi_tb_load_table(u32 *table_index,
 =

 	/* Sanity checks */
 =

-	status =3D acpi_tb_validate_table_for_load(table_index, &table);
+	status =3D acpi_tb_validate_table_for_load(table_index, reload, &table);
 	if (ACPI_FAILURE(status)) {
 		if (status =3D=3D AE_ALREADY_EXISTS) {
 			/*
-- =

2.7.4


--===============4360443953803850564==--

