Content-Type: multipart/mixed; boundary="===============3015665123471477008=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: [Devel] [PATCH 1/2] ACPICA: Introduce acpi_os_phys_table_override
 function V2
Date: Fri, 04 Nov 2011 03:54:50 +0100
Message-ID: <1320375291-5622-2-git-send-email-trenn@suse.de>
In-Reply-To: 1320375291-5622-1-git-send-email-trenn@suse.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3015665123471477008==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently it's only possible to feed acpica with virtual
address for table overriding.
This patch introduces a function which allows the OS to
pass physical addresses for table overriding.

This is necessary to allow early table overridings of
arbitrary ACPI tables.

An extra flag like ACPI_TABLE_ORIGIN_OVERRIDE is not used,
because physical address overriding is rather transparent
(the same way acpica expects to get tables from reserved
memory BIOS regions which is the normal way).

V2: Includes a fix from Michael Chang:
Fix wrongly mapped acpi table header when overriding via initrd

Signed-off-by: Thomas Renninger <trenn(a)suse.de>
CC: devel(a)acpica.org
CC: lenb(a)kernel.org
CC: VoJcEK <vojcek(a)tlen.pl>
CC: Markus <dsdt(a)gaugusch.at>
CC: eric(a)gaugusch.at
CC: Michael Chang <mchang(a)suse.com>
CC: ming.m.lin(a)intel.com
---
 drivers/acpi/acpica/tbinstal.c |   15 +++++++++++++++
 drivers/acpi/acpica/tbutils.c  |   18 +++++++++++++++++-
 drivers/acpi/osl.c             |   11 +++++++++++
 include/acpi/acpiosxf.h        |    4 ++++
 4 files changed, 47 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 62365f6..b9b9d2a 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -242,6 +242,21 @@ acpi_tb_add_table(struct acpi_table_desc *table_desc, =
u32 *table_index)
 		table_desc->pointer =3D override_table;
 		table_desc->length =3D override_table->length;
 		table_desc->flags =3D ACPI_TABLE_ORIGIN_OVERRIDE;
+	} else {
+		acpi_physical_address address =3D 0;
+		u32 table_len =3D 0;
+		status =3D acpi_os_phys_table_override(table_desc->pointer,
+						     &address, &table_len);
+		if (ACPI_SUCCESS(status) && table_len && address) {
+			ACPI_INFO((AE_INFO, "%4.4s @ 0x%p "
+				   "Phys table override, replaced with:",
+				   table_desc->pointer->signature,
+				   ACPI_CAST_PTR(void, table_desc->address)));
+			table_desc->address =3D address;
+			table_desc->pointer =3D acpi_os_map_memory(address,
+								 table_len);
+			table_desc->length =3D table_len;
+		}
 	}
 =

 	/* Add the table to the global root table list */
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 0f2d395..2e797d9 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -499,8 +499,24 @@ acpi_tb_install_table(acpi_physical_address address,
 		table_to_install =3D override_table;
 		flags =3D ACPI_TABLE_ORIGIN_OVERRIDE;
 	} else {
-		table_to_install =3D mapped_table;
+		u32 table_len =3D 0;
+		acpi_physical_address tmp_addr =3D 0;
+
+		status =3D acpi_os_phys_table_override(mapped_table,
+						     &tmp_addr, &table_len);
+		if (ACPI_SUCCESS(status) && table_len && tmp_addr) {
+			ACPI_INFO((AE_INFO, "%4.4s @ 0x%p "
+				   "Phys table override, replaced with:",
+				   mapped_table->signature,
+				   ACPI_CAST_PTR(void, address)));
+			acpi_os_unmap_memory(mapped_table,
+					     sizeof(struct acpi_table_header));
+			address =3D tmp_addr;
+			mapped_table =3D acpi_os_map_memory(address,
+					  sizeof(struct acpi_table_header));
+		}
 		flags =3D ACPI_TABLE_ORIGIN_MAPPED;
+		table_to_install =3D mapped_table;
 	}
 =

 	/* Initialize the table entry */
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index f31c5c5..099a3a6 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -523,6 +523,17 @@ acpi_os_table_override(struct acpi_table_header * exis=
ting_table,
 	return AE_OK;
 }
 =

+acpi_status
+acpi_os_phys_table_override(struct acpi_table_header *existing_table,
+			    acpi_physical_address *address, u32 *table_length)
+{
+	if (!existing_table)
+		return AE_BAD_PARAMETER;
+
+	table_length =3D 0;
+	return AE_OK;
+}
+
 static irqreturn_t acpi_irq(int irq, void *dev_id)
 {
 	u32 handled;
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 83062ed..a56a811 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -95,6 +95,10 @@ acpi_status
 acpi_os_table_override(struct acpi_table_header *existing_table,
 		       struct acpi_table_header **new_table);
 =

+acpi_status
+acpi_os_phys_table_override(struct acpi_table_header *existing_table,
+			    acpi_physical_address *address, u32 *table_length);
+
 /*
  * Spinlock primitives
  */
-- =

1.7.6.1


--===============3015665123471477008==--

