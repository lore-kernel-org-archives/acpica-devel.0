Content-Type: multipart/mixed; boundary="===============5246830177942613306=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: [Devel] [PATCH 2/4] ACPICA: Introduce new acpi_os_physical_table_add
 OS callback
Date: Tue, 18 Feb 2014 18:22:54 +0000
Message-ID: <1392747763-3384-3-git-send-email-trenn@suse.de>
In-Reply-To: 1392747763-3384-1-git-send-email-trenn@suse.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5246830177942613306==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This one allows OS to add arbitrary ACPI tables.

ToDo: It should get checked whether a table with the same signature already
exists and if this is the case, adding should not happen.

Signed-off-by: Thomas Renninger <trenn(a)suse.de>
CC: hpa(a)zytor.com
CC: tglx(a)linutronix.de
CC: ck(a)conrad-kostecki.de
CC: linux-kernel(a)vger.kernel.org
CC: x86(a)kernel.org
CC: mingo(a)redhat.com
CC: rjw(a)rjwysocki.net
CC: devel(a)acpica.org
---
 drivers/acpi/acpica/tbutils.c |   24 ++++++++++++++++++++++++
 include/acpi/acpiosxf.h       |    6 ++++++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 6412d3c..c763816 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -453,6 +453,8 @@ static acpi_status acpi_tb_validate_xsdt(acpi_physical_=
address xsdt_address)
  *
  *************************************************************************=
*****/
 =

+#define ACPI_MAX_TABLE_ADD 64
+
 acpi_status __init acpi_tb_parse_root_table(acpi_physical_address rsdp_add=
ress)
 {
 	struct acpi_table_rsdp *rsdp;
@@ -623,5 +625,27 @@ acpi_status __init acpi_tb_parse_root_table(acpi_physi=
cal_address rsdp_address)
 		}
 	}
 =

+	/*
+	 * ACPI Table Add:
+	 * Allow the OS to add additional tables to the global root table list
+	 */
+	for (i =3D 0; i < ACPI_MAX_TABLE_ADD; i++) {
+		int tmp;
+		table_entry_size =3D 0;
+		address =3D 0;
+		status =3D acpi_os_physical_table_add(&address,
+						    &table_entry_size);
+		if (status =3D=3D AE_OK && table_entry_size && address) {
+			table =3D acpi_os_map_memory(address, table_entry_size);
+			ACPI_INFO((AE_INFO, "Add OS provided table:"));
+			acpi_tb_print_table_header(address, table);
+			status =3D acpi_tb_store_table(address,
+						     table,
+						     table_entry_size,
+						     ACPI_TABLE_ORIGIN_MAPPED,
+						     &tmp);
+		} else
+			break;
+	}
 	return_ACPI_STATUS(AE_OK);
 }
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 01e6c6d..70c00ed 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -111,6 +111,12 @@ acpi_os_physical_table_override(struct acpi_table_head=
er *existing_table,
 				u32 *new_table_length);
 #endif
 =

+#ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_physical_table_add
+acpi_status
+acpi_os_physical_table_add(acpi_physical_address * new_address,
+			   u32 *new_table_length);
+#endif
+
 /*
  * Spinlock primitives
  */
-- =

1.7.6.1


--===============5246830177942613306==--

