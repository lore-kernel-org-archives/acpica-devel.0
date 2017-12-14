Content-Type: multipart/mixed; boundary="===============0506665950026634990=="
MIME-Version: 1.0
From: Ross Zwisler <ross.zwisler at linux.intel.com>
Subject: [Devel] [PATCH v3 1/3] acpi: HMAT support in
 acpi_parse_entries_array()
Date: Wed, 13 Dec 2017 19:10:17 -0700
Message-ID: <20171214021019.13579-2-ross.zwisler@linux.intel.com>
In-Reply-To: 20171214021019.13579-1-ross.zwisler@linux.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0506665950026634990==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The current implementation of acpi_parse_entries_array() assumes that each
subtable has a standard ACPI subtable entry of type struct
acpi_subtable_header.  This standard subtable header has a one byte length
followed by a one byte type.

The HMAT subtables have to allow for a longer length so they have subtable
headers of type struct acpi_hmat_structure which has a 2 byte type and a 4
byte length.

Enhance the subtable parsing in acpi_parse_entries_array() so that it can
handle these new HMAT subtables.

Signed-off-by: Ross Zwisler <ross.zwisler(a)linux.intel.com>
---
 drivers/acpi/tables.c | 52 ++++++++++++++++++++++++++++++++++++++++-------=
----
 1 file changed, 41 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 80ce2a7d224b..f777b94c234a 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -218,6 +218,33 @@ void acpi_table_print_madt_entry(struct acpi_subtable_=
header *header)
 	}
 }
 =

+static unsigned long __init
+acpi_get_entry_type(char *id, void *entry)
+{
+	if (strncmp(id, ACPI_SIG_HMAT, 4) =3D=3D 0)
+		return ((struct acpi_hmat_structure *)entry)->type;
+	else
+		return ((struct acpi_subtable_header *)entry)->type;
+}
+
+static unsigned long __init
+acpi_get_entry_length(char *id, void *entry)
+{
+	if (strncmp(id, ACPI_SIG_HMAT, 4) =3D=3D 0)
+		return ((struct acpi_hmat_structure *)entry)->length;
+	else
+		return ((struct acpi_subtable_header *)entry)->length;
+}
+
+static unsigned long __init
+acpi_get_subtable_header_length(char *id)
+{
+	if (strncmp(id, ACPI_SIG_HMAT, 4) =3D=3D 0)
+		return sizeof(struct acpi_hmat_structure);
+	else
+		return sizeof(struct acpi_subtable_header);
+}
+
 /**
  * acpi_parse_entries_array - for each proc_num find a suitable subtable
  *
@@ -242,10 +269,10 @@ acpi_parse_entries_array(char *id, unsigned long tabl=
e_size,
 		struct acpi_subtable_proc *proc, int proc_num,
 		unsigned int max_entries)
 {
-	struct acpi_subtable_header *entry;
-	unsigned long table_end;
+	unsigned long table_end, subtable_header_length;
 	int count =3D 0;
 	int errs =3D 0;
+	void *entry;
 	int i;
 =

 	if (acpi_disabled)
@@ -263,19 +290,23 @@ acpi_parse_entries_array(char *id, unsigned long tabl=
e_size,
 	}
 =

 	table_end =3D (unsigned long)table_header + table_header->length;
+	subtable_header_length =3D acpi_get_subtable_header_length(id);
 =

 	/* Parse all entries looking for a match. */
 =

-	entry =3D (struct acpi_subtable_header *)
-	    ((unsigned long)table_header + table_size);
+	entry =3D (void *)table_header + table_size;
+
+	while (((unsigned long)entry) + subtable_header_length  < table_end) {
+		unsigned long entry_type, entry_length;
 =

-	while (((unsigned long)entry) + sizeof(struct acpi_subtable_header) <
-	       table_end) {
 		if (max_entries && count >=3D max_entries)
 			break;
 =

+		entry_type =3D acpi_get_entry_type(id, entry);
+		entry_length =3D acpi_get_entry_length(id, entry);
+
 		for (i =3D 0; i < proc_num; i++) {
-			if (entry->type !=3D proc[i].id)
+			if (entry_type !=3D proc[i].id)
 				continue;
 			if (!proc[i].handler ||
 			     (!errs && proc[i].handler(entry, table_end))) {
@@ -290,16 +321,15 @@ acpi_parse_entries_array(char *id, unsigned long tabl=
e_size,
 			count++;
 =

 		/*
-		 * If entry->length is 0, break from this loop to avoid
+		 * If entry_length is 0, break from this loop to avoid
 		 * infinite loop.
 		 */
-		if (entry->length =3D=3D 0) {
+		if (entry_length =3D=3D 0) {
 			pr_err("[%4.4s:0x%02x] Invalid zero length\n", id, proc->id);
 			return -EINVAL;
 		}
 =

-		entry =3D (struct acpi_subtable_header *)
-		    ((unsigned long)entry + entry->length);
+		entry +=3D entry_length;
 	}
 =

 	if (max_entries && count > max_entries) {
-- =

2.14.3


--===============0506665950026634990==--

