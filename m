Content-Type: multipart/mixed; boundary="===============3746978632594901867=="
MIME-Version: 1.0
From: Lv Zheng <lv.zheng at intel.com>
Subject: [Devel] [RFC PATCH 5/7] ACPICA: Tables: Enable acpi_ut_is_aml_table()
 for all ACPICA modules
Date: Wed, 15 Mar 2017 14:37:29 +0800
Message-ID: <aebe450e81b34015bf32aee74a73144df5fecce4.1489558845.git.lv.zheng@intel.com>
In-Reply-To: cover.1489558845.git.lv.zheng@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3746978632594901867==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch enables acpi_ut_is_aml_table() for all ACPICA modules so that it=
 can
be used by Linux kernel. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng(a)intel.com>
Cc: Hans de Goede <hdegoede(a)redhat.com>
---
 drivers/acpi/acpica/acutils.h  |  4 +---
 drivers/acpi/acpica/tbdata.c   | 17 +++--------------
 drivers/acpi/acpica/tbxfload.c | 10 +++-------
 drivers/acpi/acpica/utmisc.c   | 27 +++++++++++++++++----------
 4 files changed, 24 insertions(+), 34 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 6f28cfa..c0b697f 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -545,9 +545,7 @@ const struct acpi_exception_info *acpi_ut_validate_exce=
ption(acpi_status
 =

 u8 acpi_ut_is_pci_root_bridge(char *id);
 =

-#if (defined ACPI_ASL_COMPILER || defined ACPI_EXEC_APP || defined ACPI_NA=
MES_APP)
-u8 acpi_ut_is_aml_table(struct acpi_table_header *table);
-#endif
+u8 acpi_ut_is_aml_table(char *signature);
 =

 acpi_status
 acpi_ut_walk_package_tree(union acpi_operand_object *source_object,
diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 1a4371b..1e1222d 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -859,20 +859,9 @@ acpi_tb_validate_table_for_load(u32 *table_index,
 		goto unlock_and_exit;
 	}
 =

-	/*
-	 * Validate the incoming table signature.
-	 *
-	 * 1) Originally, we checked the table signature for "SSDT" or "PSDT".
-	 * 2) We added support for OEMx tables, signature "OEM".
-	 * 3) Valid tables were encountered with a null signature, so we just
-	 *    gave up on validating the signature, (05/2008).
-	 * 4) We encountered non-AML tables such as the MADT, which caused
-	 *    interpreter errors and kernel faults. So now, we once again allow
-	 *    only "SSDT", "OEMx", and now, also a null signature. (05/2011).
-	 */
-	if ((table_desc->signature.ascii[0] !=3D 0x00) &&
-	    (!ACPI_COMPARE_NAME(&table_desc->signature, ACPI_SIG_SSDT)) &&
-	    (strncmp(table_desc->signature.ascii, "OEM", 3))) {
+	/* Validate the incoming table signature */
+
+	if (!acpi_ut_is_aml_table(table_desc->signature.ascii)) {
 		ACPI_BIOS_ERROR((AE_INFO,
 				 "Table has invalid signature [%4.4s] (0x%8.8X), "
 				 "must be SSDT or OEMx",
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index b71ce3b..9753176 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -206,13 +206,9 @@ acpi_status acpi_tb_load_namespace(void)
 	for (i =3D 0; i < acpi_gbl_root_table_list.current_table_count; ++i) {
 		table =3D &acpi_gbl_root_table_list.tables[i];
 =

-		if (!acpi_gbl_root_table_list.tables[i].address ||
-		    (!ACPI_COMPARE_NAME(table->signature.ascii, ACPI_SIG_SSDT)
-		     && !ACPI_COMPARE_NAME(table->signature.ascii,
-					   ACPI_SIG_PSDT)
-		     && !ACPI_COMPARE_NAME(table->signature.ascii,
-					   ACPI_SIG_OSDT))
-		    || ACPI_FAILURE(acpi_tb_validate_table(table))) {
+		if (!table->address || i =3D=3D acpi_gbl_dsdt_index ||
+		    !acpi_ut_is_aml_table(table->signature.ascii) ||
+		    ACPI_FAILURE(acpi_tb_validate_table(table))) {
 			continue;
 		}
 =

diff --git a/drivers/acpi/acpica/utmisc.c b/drivers/acpi/acpica/utmisc.c
index 443ffad..e5074d8 100644
--- a/drivers/acpi/acpica/utmisc.c
+++ b/drivers/acpi/acpica/utmisc.c
@@ -75,7 +75,6 @@ u8 acpi_ut_is_pci_root_bridge(char *id)
 	return (FALSE);
 }
 =

-#if (defined ACPI_ASL_COMPILER || defined ACPI_EXEC_APP || defined ACPI_NA=
MES_APP)
 /*************************************************************************=
******
  *
  * FUNCTION:    acpi_ut_is_aml_table
@@ -90,21 +89,29 @@ u8 acpi_ut_is_pci_root_bridge(char *id)
  *
  *************************************************************************=
*****/
 =

-u8 acpi_ut_is_aml_table(struct acpi_table_header *table)
+u8 acpi_ut_is_aml_table(char *signature)
 {
-
-	/* These are the only tables that contain executable AML */
-
-	if (ACPI_COMPARE_NAME(table->signature, ACPI_SIG_DSDT) ||
-	    ACPI_COMPARE_NAME(table->signature, ACPI_SIG_PSDT) ||
-	    ACPI_COMPARE_NAME(table->signature, ACPI_SIG_SSDT) ||
-	    ACPI_COMPARE_NAME(table->signature, ACPI_SIG_OSDT)) {
+	/*
+	 * These are the only tables that contain executable AML
+	 * 1) Originally, we checked the table signature for "SSDT" or "PSDT".
+	 * 2) We added support for OEMx tables, signature "OEM".
+	 * 3) Valid tables were encountered with a null signature, so we just
+	 *    gave up on validating the signature, (05/2008).
+	 * 4) We encountered non-AML tables such as the MADT, which caused
+	 *    interpreter errors and kernel faults. So now, we once again allow
+	 *    only "SSDT", "OEMx", and now, also a null signature. (05/2011).
+	 */
+	if (signature[0] =3D=3D 0x00 ||
+	    ACPI_COMPARE_NAME(signature, ACPI_SIG_DSDT) ||
+	    ACPI_COMPARE_NAME(signature, ACPI_SIG_PSDT) ||
+	    ACPI_COMPARE_NAME(signature, ACPI_SIG_SSDT) ||
+	    ACPI_COMPARE_NAME(signature, ACPI_SIG_OSDT) ||
+	    strncmp(signature, "OEM", 3) =3D=3D 0) {
 		return (TRUE);
 	}
 =

 	return (FALSE);
 }
-#endif
 =

 /*************************************************************************=
******
  *
-- =

2.7.4


--===============3746978632594901867==--

