Content-Type: multipart/mixed; boundary="===============6938239709876155862=="
MIME-Version: 1.0
From: Jeremy Linton <jeremy.linton at arm.com>
Subject: [Devel] [RFC 1/3] ACPICA: ACPI 6.3: Add MADT/GICC/SPE extension.
Date: Fri, 08 Feb 2019 18:47:16 -0600
Message-ID: <20190209004718.3292087-2-jeremy.linton@arm.com>
In-Reply-To: 20190209004718.3292087-1-jeremy.linton@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6938239709876155862==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[Placeholder patch for upstream ACPICA commit]

Add just ACPI 6.3 changes associated with the arm64 SPE.

Signed-off-by: Jeremy Linton <jeremy.linton(a)arm.com>
---
 include/acpi/actbl2.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index c50ef7e6b942..4b58eb6cf64e 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -623,7 +623,7 @@ struct acpi_madt_local_x2apic_nmi {
 	u8 reserved[3];		/* reserved - must be zero */
 };
 =

-/* 11: Generic Interrupt (ACPI 5.0 + ACPI 6.0 changes) */
+/* 11: Generic Interrupt (ACPI 5.0 + 6.0 + 6.3 changes) */
 =

 struct acpi_madt_generic_interrupt {
 	struct acpi_subtable_header header;
@@ -641,7 +641,8 @@ struct acpi_madt_generic_interrupt {
 	u64 gicr_base_address;
 	u64 arm_mpidr;
 	u8 efficiency_class;
-	u8 reserved2[3];
+	u8 reserved2;
+	u16 spe_overflow_interrupt;
 };
 =

 /* Masks for Flags field above */
-- =

2.17.2


--===============6938239709876155862==--

