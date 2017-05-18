Content-Type: multipart/mixed; boundary="===============5534023343657561322=="
MIME-Version: 1.0
From: Lv Zheng <lv.zheng at intel.com>
Subject: [Devel] [RFC PATCH v3 5/5] ACPICA: Tables: Add deferred table
 verification support
Date: Thu, 18 May 2017 17:57:52 +0800
Message-ID: <c7fbf5acbbbd55fc96f5215bc57aedf069a9f808.1495100623.git.lv.zheng@intel.com>
In-Reply-To: cover.1495100623.git.lv.zheng@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5534023343657561322==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch allows tables not verified in early stage verfied in
acpi_reallocate_root_table(). This is useful for OSPMs like linux where tab=
les
cannot be verified in early stage due to early ioremp limitations on some
architectures. Reported by Hans de Geode, fixed by Lv Zheng.

Reported-by: Hans de Goede <hdegoede(a)redhat.com>
Signed-off-by: Lv Zheng <lv.zheng(a)intel.com>
---
 drivers/acpi/acpica/tbdata.c  | 32 ++++++++++++++++++++++++++------
 drivers/acpi/acpica/tbxface.c | 25 +++++++++++++++++++++----
 include/acpi/actbl.h          |  1 +
 3 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 659d362..abe1052 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -432,6 +432,15 @@ acpi_tb_check_duplication(struct acpi_table_desc *tabl=
e_desc, u32 *table_index)
 	/* Check if table is already registered */
 =

 	for (i =3D 0; i < acpi_gbl_root_table_list.current_table_count; ++i) {
+
+		/* Do not compare with unverified tables */
+
+		if (!
+		    (acpi_gbl_root_table_list.tables[i].
+		     flags & ACPI_TABLE_IS_VERIFIED)) {
+			continue;
+		}
+
 		/*
 		 * Check for a table match on the entire table length,
 		 * not just the header.
@@ -554,6 +563,8 @@ acpi_tb_verify_temp_table(struct acpi_table_desc *table=
_desc,
 				goto invalidate_and_exit;
 			}
 		}
+
+		table_desc->flags |=3D ACPI_TABLE_IS_VERIFIED;
 	}
 =

 	return_ACPI_STATUS(status);
@@ -579,6 +590,8 @@ acpi_status acpi_tb_resize_root_table_list(void)
 {
 	struct acpi_table_desc *tables;
 	u32 table_count;
+	u32 current_table_count, max_table_count;
+	u32 i;
 =

 	ACPI_FUNCTION_TRACE(tb_resize_root_table_list);
 =

@@ -598,8 +611,8 @@ acpi_status acpi_tb_resize_root_table_list(void)
 		table_count =3D acpi_gbl_root_table_list.current_table_count;
 	}
 =

-	tables =3D ACPI_ALLOCATE_ZEROED(((acpi_size)table_count +
-				       ACPI_ROOT_TABLE_SIZE_INCREMENT) *
+	max_table_count =3D table_count + ACPI_ROOT_TABLE_SIZE_INCREMENT;
+	tables =3D ACPI_ALLOCATE_ZEROED(((acpi_size)max_table_count) *
 				      sizeof(struct acpi_table_desc));
 	if (!tables) {
 		ACPI_ERROR((AE_INFO,
@@ -609,9 +622,16 @@ acpi_status acpi_tb_resize_root_table_list(void)
 =

 	/* Copy and free the previous table array */
 =

+	current_table_count =3D 0;
 	if (acpi_gbl_root_table_list.tables) {
-		memcpy(tables, acpi_gbl_root_table_list.tables,
-		       (acpi_size)table_count * sizeof(struct acpi_table_desc));
+		for (i =3D 0; i < table_count; i++) {
+			if (acpi_gbl_root_table_list.tables[i].address) {
+				memcpy(tables + current_table_count,
+				       acpi_gbl_root_table_list.tables + i,
+				       sizeof(struct acpi_table_desc));
+				current_table_count++;
+			}
+		}
 =

 		if (acpi_gbl_root_table_list.flags & ACPI_ROOT_ORIGIN_ALLOCATED) {
 			ACPI_FREE(acpi_gbl_root_table_list.tables);
@@ -619,8 +639,8 @@ acpi_status acpi_tb_resize_root_table_list(void)
 	}
 =

 	acpi_gbl_root_table_list.tables =3D tables;
-	acpi_gbl_root_table_list.max_table_count =3D
-	    table_count + ACPI_ROOT_TABLE_SIZE_INCREMENT;
+	acpi_gbl_root_table_list.max_table_count =3D max_table_count;
+	acpi_gbl_root_table_list.current_table_count =3D current_table_count;
 	acpi_gbl_root_table_list.flags |=3D ACPI_ROOT_ORIGIN_ALLOCATED;
 =

 	return_ACPI_STATUS(AE_OK);
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index b0dc841..70cd581 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -167,6 +167,7 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_initialize_tables)
 acpi_status ACPI_INIT_FUNCTION acpi_reallocate_root_table(void)
 {
 	acpi_status status;
+	struct acpi_table_desc *table_desc;
 	u32 i;
 =

 	ACPI_FUNCTION_TRACE(acpi_reallocate_root_table);
@@ -179,6 +180,8 @@ acpi_status ACPI_INIT_FUNCTION acpi_reallocate_root_tab=
le(void)
 		return_ACPI_STATUS(AE_SUPPORT);
 	}
 =

+	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
+
 	/*
 	 * Ensure OS early boot logic, which is required by some hosts. If the
 	 * table state is reported to be wrong, developers should fix the
@@ -186,11 +189,11 @@ acpi_status ACPI_INIT_FUNCTION acpi_reallocate_root_t=
able(void)
 	 * early stage.
 	 */
 	for (i =3D 0; i < acpi_gbl_root_table_list.current_table_count; ++i) {
-		if (acpi_gbl_root_table_list.tables[i].pointer) {
+		table_desc =3D &acpi_gbl_root_table_list.tables[i];
+		if (table_desc->pointer) {
 			ACPI_ERROR((AE_INFO,
 				    "Table [%4.4s] is not invalidated during early boot stage",
-				    acpi_gbl_root_table_list.tables[i].
-				    signature.ascii));
+				    table_desc->signature.ascii));
 		}
 	}
 =

@@ -200,11 +203,25 @@ acpi_status ACPI_INIT_FUNCTION acpi_reallocate_root_t=
able(void)
 		 * table initilization here once the flag is set.
 		 */
 		acpi_gbl_enable_table_validation =3D TRUE;
+		for (i =3D 0; i < acpi_gbl_root_table_list.current_table_count;
+		     ++i) {
+			table_desc =3D &acpi_gbl_root_table_list.tables[i];
+			if (!(table_desc->flags & ACPI_TABLE_IS_VERIFIED)) {
+				status =3D
+				    acpi_tb_verify_temp_table(table_desc, NULL,
+							      NULL);
+				if (ACPI_FAILURE(status)) {
+					acpi_tb_uninstall_table(table_desc);
+				}
+			}
+		}
 	}
 =

 	acpi_gbl_root_table_list.flags |=3D ACPI_ROOT_ALLOW_RESIZE;
-
 	status =3D acpi_tb_resize_root_table_list();
+	acpi_gbl_root_table_list.flags |=3D ACPI_ROOT_ORIGIN_ALLOCATED;
+
+	(void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
 	return_ACPI_STATUS(status);
 }
 =

diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index d92543f..d10a172 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -380,6 +380,7 @@ struct acpi_table_desc {
 #define ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL (1)	/* Physical address, inter=
nally mapped */
 #define ACPI_TABLE_ORIGIN_INTERNAL_VIRTUAL  (2)	/* Virtual address, intern=
allly allocated */
 #define ACPI_TABLE_ORIGIN_MASK              (3)
+#define ACPI_TABLE_IS_VERIFIED              (4)
 #define ACPI_TABLE_IS_LOADED                (8)
 =

 /*
-- =

2.7.4


--===============5534023343657561322==--

