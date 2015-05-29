Content-Type: multipart/mixed; boundary="===============7629467130494121660=="
MIME-Version: 1.0
From: Hanjun Guo <hanjun.guo at linaro.org>
Subject: [Devel] [PATCH] ACPICA: Add MADT generic distributor version values
 for ACPI 6.0
Date: Fri, 29 May 2015 15:46:07 +0800
Message-ID: <1432885567-5924-1-git-send-email-hanjun.guo@linaro.org>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7629467130494121660==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ACPI 6.0 specified MADT generic distributor version values, but
the detail definition is missing in ACPICA version 20150515, add
its support in this patch.

Signed-off-by: Hanjun Guo <hanjun.guo(a)linaro.org>
---

This is the linux version of GIC version patch, please
help to handle it, thanks!

 include/acpi/actbl1.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 06b61f0..a53530d1 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -835,6 +835,17 @@ struct acpi_madt_generic_distributor {
 	u8 reserved2[3];	/* reserved - must be zero */
 };
 =

+/* Values for version in Generic Distributor  (ACPI 6.0) */
+
+enum acpi_madt_gic_version_type {
+	ACPI_MADT_GIC_VER_UNKNOWN	=3D 0,
+	ACPI_MADT_GIC_VER_V1		=3D 1,
+	ACPI_MADT_GIC_VER_V2		=3D 2,
+	ACPI_MADT_GIC_VER_V3		=3D 3,
+	ACPI_MADT_GIC_VER_V4		=3D 4,
+	ACPI_MADT_GIC_VER_RESERVED	=3D 5	/* 5 and greater are reserved */
+};
+
 /* 13: Generic MSI Frame (ACPI 5.1) */
 =

 struct acpi_madt_generic_msi_frame {
-- =

1.9.1


--===============7629467130494121660==--

