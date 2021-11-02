Content-Type: multipart/mixed; boundary="===============3474322630338823293=="
MIME-Version: 1.0
From: Sudeep Holla <sudeep.holla at arm.com>
Subject: [Devel] [PATCH 2/3] ACPICA: Add support for PCC Opregion special
 context data
Date: Tue, 02 Nov 2021 18:25:41 +0000
Message-ID: <20211102182542.3460787-3-sudeep.holla@arm.com>
In-Reply-To: 20211102182542.3460787-1-sudeep.holla@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3474322630338823293==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

PCC Opregion added in ACPIC 6.3 requires special context data similar
to GPIO and Generic Serial Bus as it needs to know the internal PCC
buffer and its length as well as the PCC channel index when the opregion
handler is being executed by the OSPM.

Lets add support for the special context data needed by PCC Opregion.

Signed-off-by: Sudeep Holla <sudeep.holla(a)arm.com>
---
 drivers/acpi/acpica/evregion.c | 11 +++++++++++
 include/acpi/actypes.h         |  8 ++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 4ef43c8ef5e7..963cdf83372a 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -162,6 +162,17 @@ acpi_ev_address_space_dispatch(union acpi_operand_obje=
ct *region_obj,
 			return_ACPI_STATUS(AE_NOT_EXIST);
 		}
 =

+		if (region_obj->region.space_id =3D=3D
+						ACPI_ADR_SPACE_PLATFORM_COMM) {
+			struct acpi_pcc_info *ctx =3D
+					handler_desc->address_space.context;
+
+			ctx->internal_buffer =3D
+					field_obj->field.internal_pcc_buffer;
+			ctx->length =3D region_obj->region.length;
+			ctx->subspace_id =3D region_obj->region.address;
+		}
+
 		/*
 		 * We must exit the interpreter because the region setup will
 		 * potentially execute control methods (for example, the _REG method
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 92c71dfce0d5..ac2eb334f61b 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1098,6 +1098,14 @@ struct acpi_connection_info {
 	u8 access_length;
 };
 =

+/* Special Context data for PCC Opregion (ACPI 6.3) */
+
+struct acpi_pcc_info {
+	u8 subspace_id;
+	u16 length;
+	u8 *internal_buffer;
+};
+
 typedef
 acpi_status (*acpi_adr_space_setup) (acpi_handle region_handle,
 				     u32 function,
-- =

2.25.1

--===============3474322630338823293==--

