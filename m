Content-Type: multipart/mixed; boundary="===============0766775572140961417=="
MIME-Version: 1.0
From: Loc Ho <lho at apm.com>
Subject: [Devel] [PATCH v2 1/2] ACPI: SPCR: Use access width to determine mmio
 usage
Date: Mon, 03 Jul 2017 14:33:08 -0700
Message-ID: <1499117589-4829-2-git-send-email-lho@apm.com>
In-Reply-To: 1499117589-4829-1-git-send-email-lho@apm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0766775572140961417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The current SPCR code does not check the access width of the mmio, and
uses a default of 8bit register accesses.  This prevents devices that
only do 16 or 32bit register accesses from working.  By simply checking
this field and setting the mmio string appropriately, this issue can be
corrected.  To prevent any legacy issues, the code will default to 8bit
accesses if the value is anything but 16 or 32.

Signed-off-by: Loc Ho <lho(a)apm.com>
[Re-send as single patch set]
Signed-off-by: Jon Mason <jon.mason(a)broadcom.com>
---
 drivers/acpi/spcr.c     | 18 ++++++++++++++++--
 include/acpi/acrestyp.h |  7 +++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 3afa8c1..2905063 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -74,8 +74,22 @@ int __init parse_spcr(bool earlycon)
 		goto done;
 	}
 =

-	iotype =3D table->serial_port.space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_MEMOR=
Y ?
-			"mmio" : "io";
+	if (table->serial_port.space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+		switch (table->serial_port.access_width) {
+		default:
+			pr_err("Unexpected SPCR Access Width.  Defaulting to byte size\n");
+		case ACPI_ACCESS_SIZE_BYTE:
+			iotype =3D "mmio";
+			break;
+		case ACPI_ACCESS_SIZE_WORD:
+			iotype =3D "mmio16";
+			break;
+		case ACPI_ACCESS_SIZE_DWORD:
+			iotype =3D "mmio32";
+			break;
+		}
+	} else
+		iotype =3D "io";
 =

 	switch (table->interface_type) {
 	case ACPI_DBG2_ARM_SBSA_32BIT:
diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
index f0f7403..781cb55 100644
--- a/include/acpi/acrestyp.h
+++ b/include/acpi/acrestyp.h
@@ -372,6 +372,13 @@ struct acpi_resource_generic_register {
 	u64 address;
 };
 =

+/* Generic Address Space Access Sizes */
+#define ACPI_ACCESS_SIZE_UNDEFINED		0
+#define ACPI_ACCESS_SIZE_BYTE			1
+#define ACPI_ACCESS_SIZE_WORD			2
+#define ACPI_ACCESS_SIZE_DWORD			3
+#define ACPI_ACCESS_SIZE_QWORD			4
+
 struct acpi_resource_gpio {
 	u8 revision_id;
 	u8 connection_type;
-- =

1.8.3.1


--===============0766775572140961417==--

