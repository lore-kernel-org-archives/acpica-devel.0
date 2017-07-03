Content-Type: multipart/mixed; boundary="===============3678112122841079778=="
MIME-Version: 1.0
From: Loc Ho <lho at apm.com>
Subject: [Devel] [PATCH v2 2/2] ACPI: SPCR: Workaround for APM X-Gene 8250
 UART 32-alignment errata
Date: Mon, 03 Jul 2017 14:33:09 -0700
Message-ID: <1499117589-4829-3-git-send-email-lho@apm.com>
In-Reply-To: 1499117589-4829-1-git-send-email-lho@apm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3678112122841079778==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

APM X-Gene verion 1 and 2 have an 8250 UART with its register
aligned to 32-bit. In addition, the latest released BIOS
encodes the access field as 8-bit access instead 32-bit access.
This causes no console with ACPI boot as the console
will not match X-Gene UART port due to the lack of mmio32
option.

Signed-off-by: Loc Ho <lho(a)apm.com>
---
 drivers/acpi/spcr.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 2905063..4ac3e06 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -36,6 +36,26 @@ static bool qdf2400_erratum_44_present(struct acpi_table=
_header *h)
 	return false;
 }
 =

+/*
+ * APM X-Gene v1 and v2 UART hardware is an 16550 like device but has its
+ * register aligned to 32-bit. In addition, the BIOS also encoded the
+ * access width to be 8 bits. This function detects this errata condition.
+ */
+static bool xgene_8250_erratum_present(struct acpi_table_spcr *tb)
+{
+	if (tb->interface_type !=3D ACPI_DBG2_16550_COMPATIBLE)
+		return false;
+
+	if (memcmp(tb->header.oem_id, "APMC0D", ACPI_OEM_ID_SIZE))
+		return false;
+
+	if (!memcmp(tb->header.oem_table_id, "XGENESPC",
+	    ACPI_OEM_TABLE_ID_SIZE) && tb->header.oem_revision =3D=3D 0)
+		return true;
+
+	return false;
+}
+
 /**
  * parse_spcr() - parse ACPI SPCR table and add preferred console
  *
@@ -129,6 +149,8 @@ int __init parse_spcr(bool earlycon)
 =

 	if (qdf2400_erratum_44_present(&table->header))
 		uart =3D "qdf2400_e44";
+	if (xgene_8250_erratum_present(table))
+		iotype =3D "mmio32";
 =

 	snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d", uart, iotype,
 		 table->serial_port.address, baud_rate);
-- =

1.8.3.1


--===============3678112122841079778==--

