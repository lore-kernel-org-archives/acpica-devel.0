Content-Type: multipart/mixed; boundary="===============3596316960106748131=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA: make acpi_load_table() return table index
Date: Thu, 12 Sep 2019 14:19:40 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B9679CE8@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 20190912080742.24642-1-nikolaus.voss@loewensteinmedical.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3596316960106748131==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Nikolaus,
The ability to unload an ACPI table (especially AML tables such as SSDTs) i=
s in the process of being deprecated in ACPICA -- since it is also deprecat=
ed in the current ACPI specification. This is being done because of the dif=
ficulty of deleting the namespace entries for the table.  FYI, Windows does=
 not properly support this function either.

Bob


-----Original Message-----
From: Nikolaus Voss [mailto:nikolaus.voss(a)loewensteinmedical.de] =

Sent: Thursday, September 12, 2019 1:08 AM
To: Shevchenko, Andriy <andriy.shevchenko(a)intel.com>; Schmauss, Erik <eri=
k.schmauss(a)intel.com>; Rafael J. Wysocki <rjw(a)rjwysocki.net>; Moore, Ro=
bert <robert.moore(a)intel.com>
Cc: Len Brown <lenb(a)kernel.org>; Jacek Anaszewski <jacek.anaszewski(a)gma=
il.com>; Pavel Machek <pavel(a)ucw.cz>; Dan Murphy <dmurphy(a)ti.com>; linu=
x-acpi(a)vger.kernel.org; devel(a)acpica.org; linux-kernel(a)vger.kernel.or=
g; nv(a)vosn.de; Nikolaus Voss <nikolaus.voss(a)loewensteinmedical.de>
Subject: [PATCH] ACPICA: make acpi_load_table() return table index

For unloading an ACPI table, it is necessary to provide the index of the ta=
ble. The method intended for dynamically loading or hotplug addition of tab=
les, acpi_load_table(), should provide this information via an optional poi=
nter to the loaded table index.

This patch fixes the table unload function of acpi_configfs.

Reported-by: Andy Shevchenko <andriy.shevchenko(a)linux.intel.com>
Fixes: d06c47e3dd07f ("ACPI: configfs: Resolve objects on host-directed tab=
le loads")
Signed-off-by: Nikolaus Voss <nikolaus.voss(a)loewensteinmedical.de>
---
 drivers/acpi/acpi_configfs.c   | 2 +-
 drivers/acpi/acpica/dbfileio.c | 2 +-
 drivers/acpi/acpica/tbxfload.c | 8 ++++++--
 drivers/firmware/efi/efi.c     | 2 +-
 include/acpi/acpixf.h          | 3 ++-
 5 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_configfs.c b/drivers/acpi/acpi_configfs.c in=
dex 57d9d574d4dde..77f81242a28e6 100644
--- a/drivers/acpi/acpi_configfs.c
+++ b/drivers/acpi/acpi_configfs.c
@@ -53,7 +53,7 @@ static ssize_t acpi_table_aml_write(struct config_item *c=
fg,
 	if (!table->header)
 		return -ENOMEM;
 =

-	ret =3D acpi_load_table(table->header);
+	ret =3D acpi_load_table(table->header, &table->index);
 	if (ret) {
 		kfree(table->header);
 		table->header =3D NULL;
diff --git a/drivers/acpi/acpica/dbfileio.c b/drivers/acpi/acpica/dbfileio.=
c index c6e25734dc5cd..e1b6e54a96ac1 100644
--- a/drivers/acpi/acpica/dbfileio.c
+++ b/drivers/acpi/acpica/dbfileio.c
@@ -93,7 +93,7 @@ acpi_status acpi_db_load_tables(struct acpi_new_table_des=
c *list_head)
 	while (table_list_head) {
 		table =3D table_list_head->table;
 =

-		status =3D acpi_load_table(table);
+		status =3D acpi_load_table(table, NULL);
 		if (ACPI_FAILURE(status)) {
 			if (status =3D=3D AE_ALREADY_EXISTS) {
 				acpi_os_printf
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.=
c index 86f1693f6d29a..d08cd8ffcbdb6 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -268,7 +268,8 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_install_table)
  *
  * PARAMETERS:  table               - Pointer to a buffer containing the A=
CPI
  *                                    table to be loaded.
- *
+ *              table_idx           - Pointer to a u32 for storing the tab=
le
+ *                                    index, might be NULL
  * RETURN:      Status
  *
  * DESCRIPTION: Dynamically load an ACPI table from the caller's buffer. M=
ust @@ -278,7 +279,7 @@ ACPI_EXPORT_SYMBOL_INIT(acpi_install_table)
  *              to ensure that the table is not deleted or unmapped.
  *
  *************************************************************************=
*****/
-acpi_status acpi_load_table(struct acpi_table_header *table)
+acpi_status acpi_load_table(struct acpi_table_header *table, u32 =

+*table_idx)
 {
 	acpi_status status;
 	u32 table_index;
@@ -297,6 +298,9 @@ acpi_status acpi_load_table(struct acpi_table_header *t=
able)
 	status =3D acpi_tb_install_and_load_table(ACPI_PTR_TO_PHYSADDR(table),
 						ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL,
 						FALSE, &table_index);
+	if (table_idx)
+		*table_idx =3D table_index;
+
 	if (ACPI_SUCCESS(status)) {
 =

 		/* Complete the initialization/resolution of new objects */ diff --git a=
/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c index ad3b1f4866b3=
5..9773e4212baef 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -308,7 +308,7 @@ static __init int efivar_ssdt_load(void)
 			goto free_data;
 		}
 =

-		ret =3D acpi_load_table(data);
+		ret =3D acpi_load_table(data, NULL);
 		if (ret) {
 			pr_err("failed to load table: %d\n", ret);
 			goto free_data;
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h index 3845c8fcc9=
4e5..c90bbdc4146a6 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -452,7 +452,8 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status ACPI_INIT_FUNCT=
ION
 					       u8 physical))
 =

 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
-			    acpi_load_table(struct acpi_table_header *table))
+			    acpi_load_table(struct acpi_table_header *table,
+					    u32 *table_idx))
 =

 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			    acpi_unload_parent_table(acpi_handle object))
--
2.17.1


--===============3596316960106748131==--

