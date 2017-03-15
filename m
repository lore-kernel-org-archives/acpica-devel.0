Content-Type: multipart/mixed; boundary="===============6179999713783107533=="
MIME-Version: 1.0
From: Lv Zheng <lv.zheng at intel.com>
Subject: [Devel] [RFC PATCH 4/7] ACPICA: Tables: Fix an unwanted exception for
 table reloading
Date: Wed, 15 Mar 2017 14:37:17 +0800
Message-ID: <a1a830f0382819424a9a1dedb1f914f61d518999.1489558845.git.lv.zheng@intel.com>
In-Reply-To: cover.1489558845.git.lv.zheng@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6179999713783107533==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When Load/load_table opcode is called again for the same table, it is likely
that the table has already been loaded, so AE_ALREADY_EXISTS shouldn't be a
fatal error but a notice for the caller to skip acpi_ns_load_table(). Repor=
ted
by Hans de Goede, fixed by Lv Zheng.

Reported-by: Hans de Goede <hdegoede(a)redhat.com>
Signed-off-by: Lv Zheng <lv.zheng(a)intel.com>
Cc: Hans de Goede <hdegoede(a)redhat.com>
---
 drivers/acpi/acpica/tbdata.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index b7bff76..1a4371b 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -952,6 +952,13 @@ acpi_tb_load_table(u32 *table_index, struct acpi_names=
pace_node *parent_node)
 =

 	status =3D acpi_tb_validate_table_for_load(table_index, &table);
 	if (ACPI_FAILURE(status)) {
+		if (status =3D=3D AE_ALREADY_EXISTS) {
+			/*
+			 * Skip the table loading process but return the table index to
+			 * the caller with the exception muted.
+			 */
+			status =3D AE_OK;
+		}
 		return_ACPI_STATUS(status);
 	}
 =

-- =

2.7.4


--===============6179999713783107533==--

