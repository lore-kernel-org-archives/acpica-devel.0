Content-Type: multipart/mixed; boundary="===============0884610986949514244=="
MIME-Version: 1.0
From: Ganapatrao Kulkarni <ganapatrao.kulkarni at cavium.com>
Subject: [Devel]  [PATCH v2] iasl: Update to IORT SMMUv3 disassembling
Date: Fri, 16 Jun 2017 09:03:19 +0530
Message-ID: <1497583999-17020-1-git-send-email-ganapatrao.kulkarni@cavium.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0884610986949514244==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ARM IORT specification has provision to define Proximity domain
in SMMUv3 IORT table. Adding required changes to decode
Proximity domain of SMMUv3 IORT table.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni(a)cavium.com>

v2:
  - updated to decode reserved1 and reserved2 in IORT SMMUv3 table
  as suggested from Hanjun Guo.
  - Minor updates to variable name and description.

v1: first patch
---
 source/common/dmtbinfo.c | 4 ++++
 source/include/actbl2.h  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/source/common/dmtbinfo.c b/source/common/dmtbinfo.c
index 692763f..56dd553 100644
--- a/source/common/dmtbinfo.c
+++ b/source/common/dmtbinfo.c
@@ -1838,6 +1838,7 @@ ACPI_DMTABLE_INFO           AcpiDmTableInfoIort4[] =
=3D
     {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (Flags),                  "Flags=
 (decoded below)", 0},
     {ACPI_DMT_FLAG0,    ACPI_IORT4_FLAG_OFFSET (Flags, 0),          "COHAC=
C Override", 0},
     {ACPI_DMT_FLAG1,    ACPI_IORT4_FLAG_OFFSET (Flags, 0),          "HTTU =
Override", 0},
+    {ACPI_DMT_FLAG3,    ACPI_IORT4_FLAG_OFFSET (Flags, 0),          "Proxi=
mity Domain Valid", 0},
     {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (Reserved),               "Reser=
ved", 0},
     {ACPI_DMT_UINT64,   ACPI_IORT4_OFFSET (VatosAddress),           "VATOS=
 Address", 0},
     {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (Model),                  "Model=
", 0},
@@ -1845,6 +1846,9 @@ ACPI_DMTABLE_INFO           AcpiDmTableInfoIort4[] =
=3D
     {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (PriGsiv),                "PRI G=
SIV", 0},
     {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (GerrGsiv),               "GERR =
GSIV", 0},
     {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (SyncGsiv),               "Sync =
GSIV", 0},
+    {ACPI_DMT_UINT8,    ACPI_IORT4_OFFSET (Pxm),                    "Proxi=
mity Domain", 0},
+    {ACPI_DMT_UINT8,    ACPI_IORT4_OFFSET (Reserved1),              "Reser=
ved", 0},
+    {ACPI_DMT_UINT16,   ACPI_IORT4_OFFSET (Reserved2),              "Reser=
ved", 0},
     ACPI_DMT_TERMINATOR
 };
 =

diff --git a/source/include/actbl2.h b/source/include/actbl2.h
index 80495d8..8029a5a 100644
--- a/source/include/actbl2.h
+++ b/source/include/actbl2.h
@@ -1041,6 +1041,9 @@ typedef struct acpi_iort_smmu_v3
     UINT32                  PriGsiv;
     UINT32                  GerrGsiv;
     UINT32                  SyncGsiv;
+    UINT8                   Pxm;
+    UINT8                   Reserved1;
+    UINT16                  Reserved2;
 =

 } ACPI_IORT_SMMU_V3;
 =

@@ -1048,6 +1051,7 @@ typedef struct acpi_iort_smmu_v3
 =

 #define ACPI_IORT_SMMU_V3_COHACC_OVERRIDE   (1)
 #define ACPI_IORT_SMMU_V3_HTTU_OVERRIDE     (1<<1)
+#define ACPI_IORT_SMMU_V3_PXM_VALID         (1<<3)
 =

 =

 /*************************************************************************=
******
-- =

1.8.1.4


--===============0884610986949514244==--

