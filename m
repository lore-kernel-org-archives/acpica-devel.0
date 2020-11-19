Content-Type: multipart/mixed; boundary="===============7248562015724131753=="
MIME-Version: 1.0
From: Shameer Kolothum <shameerali.kolothum.thodi at huawei.com>
Subject: [Devel] [RFC PATCH v2 1/8] ACPICA: IORT: Update for revision E
Date: Thu, 19 Nov 2020 12:11:43 +0000
Message-ID: <20201119121150.3316-2-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: 20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7248562015724131753==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

IORT revision E contains a few additions like,
=C2=A0 =C2=A0 -Added an identifier field in the node descriptors to aid tab=
le
=C2=A0 =C2=A0 =C2=A0cross-referencing.
=C2=A0 =C2=A0 -Introduced the Reserved Memory Range(RMR) node. This is used
 =C2=A0 =C2=A0 to describe memory ranges that are used by endpoints and req=
uires
 =C2=A0 =C2=A0 a unity mapping in SMMU.
    -Introduced a flag in the RC node to express support for PRI.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi(a)huawei.com>
---
 include/acpi/actbl2.h | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index ec66779cb193..274fce7b5c01 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -68,7 +68,7 @@
  * IORT - IO Remapping Table
  *
  * Conforms to "IO Remapping Table System Software on ARM Platforms",
- * Document number: ARM DEN 0049D, March 2018
+ * Document number: ARM DEN 0049E, June 2020
  *
  *************************************************************************=
*****/
 =

@@ -86,7 +86,8 @@ struct acpi_iort_node {
 	u8 type;
 	u16 length;
 	u8 revision;
-	u32 reserved;
+	u16 reserved;
+	u16 identifier;
 	u32 mapping_count;
 	u32 mapping_offset;
 	char node_data[1];
@@ -100,7 +101,8 @@ enum acpi_iort_node_type {
 	ACPI_IORT_NODE_PCI_ROOT_COMPLEX =3D 0x02,
 	ACPI_IORT_NODE_SMMU =3D 0x03,
 	ACPI_IORT_NODE_SMMU_V3 =3D 0x04,
-	ACPI_IORT_NODE_PMCG =3D 0x05
+	ACPI_IORT_NODE_PMCG =3D 0x05,
+	ACPI_IORT_NODE_RMR =3D 0x06,
 };
 =

 struct acpi_iort_id_mapping {
@@ -167,10 +169,10 @@ struct acpi_iort_root_complex {
 	u8 reserved[3];		/* Reserved, must be zero */
 };
 =

-/* Values for ats_attribute field above */
+/* Masks for ats_attribute field above */
 =

-#define ACPI_IORT_ATS_SUPPORTED         0x00000001	/* The root complex sup=
ports ATS */
-#define ACPI_IORT_ATS_UNSUPPORTED       0x00000000	/* The root complex doe=
sn't support ATS */
+#define ACPI_IORT_ATS_SUPPORTED         (1)	/* The root complex supports A=
TS */
+#define ACPI_IORT_PRI_SUPPORTED         (1<<1)	/* The root complex support=
s PRI */
 =

 struct acpi_iort_smmu {
 	u64 base_address;	/* SMMU base address */
@@ -241,6 +243,17 @@ struct acpi_iort_pmcg {
 	u64 page1_base_address;
 };
 =

+struct acpi_iort_rmr {
+	u32 rmr_count;
+	u32 rmr_offset;
+};
+
+struct acpi_iort_rmr_desc {
+	u64 base_address;
+	u64 length;
+	u32 reserved;
+};
+
 /*************************************************************************=
******
  *
  * IVRS - I/O Virtualization Reporting Structure
-- =

2.17.1

--===============7248562015724131753==--

