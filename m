Content-Type: multipart/mixed; boundary="===============7937990857838146427=="
MIME-Version: 1.0
From: Al Stone <ahs3 at redhat.com>
Subject: [Devel] [PATCH] IORT: Add in support for the SMMUv3 subtable
Date: Wed, 24 Feb 2016 18:34:20 -0700
Message-ID: <56CE5A1C.8040901@redhat.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7937990857838146427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The most recent version of the IORT specification adds in a definition
for a subtable to describe SMMUv3 devices; there is already a subtable
for SMMUv1/v2 devices.

Add in the definition of the subtable, add in the code to compile it,
and add in a template for it.

Signed-off-by: Al Stone <ahs3(a)redhat.com>
---
 source/common/dmtbdump.c     |  6 ++++++
 source/common/dmtbinfo.c     | 19 +++++++++++++++++++
 source/compiler/dttable1.c   | 17 +++++++++++++++--
 source/compiler/dttemplate.h | 15 +++++++++++----
 source/include/acdisasm.h    |  1 +
 source/include/actbl2.h      | 25 +++++++++++++++++++++++--
 6 files changed, 75 insertions(+), 8 deletions(-)

diff --git a/source/common/dmtbdump.c b/source/common/dmtbdump.c
index ce3b45b..bf09e58 100644
--- a/source/common/dmtbdump.c
+++ b/source/common/dmtbdump.c
@@ -1845,6 +1845,12 @@ AcpiDmDumpIort (
             IortSmmu =3D ACPI_ADD_PTR (ACPI_IORT_SMMU, IortNode, NodeOffse=
t);
             break;

+        case ACPI_IORT_NODE_SMMU_V3:
+
+            InfoTable =3D AcpiDmTableInfoIort4;
+            Length =3D IortNode->Length - NodeOffset;
+            break;
+
         default:

             AcpiOsPrintf ("\n**** Unknown IORT node type 0x%X\n",
diff --git a/source/common/dmtbinfo.c b/source/common/dmtbinfo.c
index be95f92..5edb8d4 100644
--- a/source/common/dmtbinfo.c
+++ b/source/common/dmtbinfo.c
@@ -242,6 +242,7 @@
 #define ACPI_IORT1_OFFSET(f)            (UINT16) ACPI_OFFSET
(ACPI_IORT_NAMED_COMPONENT,f)
 #define ACPI_IORT2_OFFSET(f)            (UINT16) ACPI_OFFSET
(ACPI_IORT_ROOT_COMPLEX,f)
 #define ACPI_IORT3_OFFSET(f)            (UINT16) ACPI_OFFSET (ACPI_IORT_SM=
MU,f)
+#define ACPI_IORT4_OFFSET(f)            (UINT16) ACPI_OFFSET (ACPI_IORT_SM=
MU_V3,f)
 #define ACPI_IORTA_OFFSET(f)            (UINT16) ACPI_OFFSET
(ACPI_IORT_MEMORY_ACCESS,f)
 #define ACPI_IORTH_OFFSET(f)            (UINT16) ACPI_OFFSET (ACPI_IORT_NO=
DE,f)
 #define ACPI_IORTM_OFFSET(f)            (UINT16) ACPI_OFFSET
(ACPI_IORT_ID_MAPPING,f)
@@ -328,6 +329,7 @@
 #define ACPI_GTDT0a_FLAG_OFFSET(f,o)    ACPI_FLAG_OFFSET
(ACPI_GTDT_TIMER_ENTRY,f,o)
 #define ACPI_GTDT1_FLAG_OFFSET(f,o)     ACPI_FLAG_OFFSET (ACPI_GTDT_WATCHD=
OG,f,o)
 #define ACPI_IORT3_FLAG_OFFSET(f,o)     ACPI_FLAG_OFFSET (ACPI_IORT_SMMU,f=
,o)
+#define ACPI_IORT4_FLAG_OFFSET(f,o)     ACPI_FLAG_OFFSET (ACPI_IORT_SMMU_V=
3,f,o)
 #define ACPI_IORTA_FLAG_OFFSET(f,o)     ACPI_FLAG_OFFSET
(ACPI_IORT_MEMORY_ACCESS,f,o)
 #define ACPI_IORTM_FLAG_OFFSET(f,o)     ACPI_FLAG_OFFSET (ACPI_IORT_ID_MAP=
PING,f,o)
 #define ACPI_LPITH_FLAG_OFFSET(f,o)     ACPI_FLAG_OFFSET (ACPI_LPIT_HEADER=
,f,o)
@@ -1633,6 +1635,23 @@ ACPI_DMTABLE_INFO           AcpiDmTableInfoIort3c[] =
=3D
     ACPI_DMT_TERMINATOR
 };

+/* 0x04: SMMUv3 */
+
+ACPI_DMTABLE_INFO           AcpiDmTableInfoIort4[] =3D
+{
+    {ACPI_DMT_UINT64,   ACPI_IORT4_OFFSET (BaseAddress),            "Base
Address", 0},
+    {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (Flags),                  "Flags
(decoded below)", 0},
+    {ACPI_DMT_FLAG0,    ACPI_IORT4_FLAG_OFFSET (Flags, 0),          "COHACC
Override", 0},
+    {ACPI_DMT_FLAG1,    ACPI_IORT4_FLAG_OFFSET (Flags, 0),          "HTTU
Override", 0},
+    {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (Reserved),               "Reser=
ved", 0},
+    {ACPI_DMT_UINT64,   ACPI_IORT4_OFFSET (VatosAddress),           "VATOS
Address", 0},
+    {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (Model),                  "Model=
", 0},
+    {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (EventGsiv),              "Event
GSIV", 0},
+    {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (PriGsiv),                "PRI G=
SIV", 0},
+    {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (GerrGsiv),               "GERR
GSIV", 0},
+    {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (SyncGsiv),               "Sync
GSIV", 0},
+    ACPI_DMT_TERMINATOR
+};

 /*************************************************************************=
******
  *
diff --git a/source/compiler/dttable1.c b/source/compiler/dttable1.c
index ada7fca..cacd9de 100644
--- a/source/compiler/dttable1.c
+++ b/source/compiler/dttable1.c
@@ -1315,8 +1315,8 @@ DtCompileIort (
     DtInsertSubtable (ParentTable, Subtable);

     /*
-     * Using ACPI_SUB_PTR, We needn't define a seperate structure. Care
-     * should be taken to avoid accessing ACPI_TABLE_HADER fields.
+     * Using ACPI_SUB_PTR, We needn't define a separate structure. Care
+     * should be taken to avoid accessing ACPI_TABLE_HEADER fields.
      */
     Iort =3D ACPI_SUB_PTR (ACPI_TABLE_IORT,
         Subtable->Buffer, sizeof (ACPI_TABLE_HEADER));
@@ -1547,6 +1547,19 @@ DtCompileIort (
             IortSmmu->PmuInterruptCount =3D PmuIrptNumber;
             break;

+        case ACPI_IORT_NODE_SMMU_V3:
+
+            Status =3D DtCompileTable (PFieldList, AcpiDmTableInfoIort4,
+                &Subtable, TRUE);
+            if (ACPI_FAILURE (Status))
+            {
+                return (Status);
+            }
+
+            DtInsertSubtable (ParentTable, Subtable);
+            NodeLength +=3D Subtable->Length;
+            break;
+
         default:

             DtFatal (ASL_MSG_UNKNOWN_SUBTABLE, SubtableStart, "IORT");
diff --git a/source/compiler/dttemplate.h b/source/compiler/dttemplate.h
index f27a77a..71f0041 100644
--- a/source/compiler/dttemplate.h
+++ b/source/compiler/dttemplate.h
@@ -615,11 +615,11 @@ const unsigned char TemplateHpet[] =3D

 const unsigned char TemplateIort[] =3D
 {
-    0x49,0x4F,0x52,0x54,0x0C,0x01,0x00,0x00,  /* 00000000    "IORT...." */
-    0x00,0xBC,0x49,0x4E,0x54,0x45,0x4C,0x20,  /* 00000008    "..INTEL " */
+    0x49,0x4F,0x52,0x54,0x48,0x01,0x00,0x00,  /* 00000000    "IORTH..." */
+    0x00,0x02,0x49,0x4E,0x54,0x45,0x4C,0x20,  /* 00000008    "..INTEL " */
     0x54,0x45,0x4D,0x50,0x4C,0x41,0x54,0x45,  /* 00000010    "TEMPLATE" */
     0x00,0x00,0x00,0x00,0x49,0x4E,0x54,0x4C,  /* 00000018    "....INTL" */
-    0x10,0x04,0x15,0x20,0x04,0x00,0x00,0x00,  /* 00000020    "... ...." */
+    0x12,0x02,0x16,0x20,0x05,0x00,0x00,0x00,  /* 00000020    "... ...." */
     0x34,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000028    "4......." */
     0x00,0x00,0x00,0x00,0x00,0x2C,0x00,0x00,  /* 00000030    ".....,.." */
     0x00,0x00,0x00,0x00,0x01,0x00,0x00,0x00,  /* 00000038    "........" */
@@ -648,7 +648,14 @@ const unsigned char TemplateIort[] =3D
     0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 000000F0    "........" */
     0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 000000F8    "........" */
     0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000100    "........" */
-    0x00,0x00,0x00,0x00                       /* 00000108    "...."     */
+    0x00,0x00,0x00,0x00,0x04,0x3C,0x00,0x00,  /* 00000108    ".....<.." */
+    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000110    "........" */
+    0x3C,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000118    "<......." */
+    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000120    "........" */
+    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000128    "........" */
+    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000130    "........" */
+    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,  /* 00000138    "........" */
+    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00   /* 00000140    "........" */
 };

 const unsigned char TemplateIvrs[] =3D
diff --git a/source/include/acdisasm.h b/source/include/acdisasm.h
index f949a8b..f962370 100644
--- a/source/include/acdisasm.h
+++ b/source/include/acdisasm.h
@@ -391,6 +391,7 @@ extern ACPI_DMTABLE_INFO        AcpiDmTableInfoIort3[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoIort3a[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoIort3b[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoIort3c[];
+extern ACPI_DMTABLE_INFO        AcpiDmTableInfoIort4[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoIortAcc[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoIortHdr[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoIortMap[];
diff --git a/source/include/actbl2.h b/source/include/actbl2.h
index 1cac3dc..8311e7f 100644
--- a/source/include/actbl2.h
+++ b/source/include/actbl2.h
@@ -834,7 +834,7 @@ typedef struct acpi_ibft_target
  * IORT - IO Remapping Table
  *
  * Conforms to "IO Remapping Table System Software on ARM Platforms",
- * Document number: ARM DEN 0049A, 2015
+ * Document number: ARM DEN 0049B, October 2015
  *
  *************************************************************************=
*****/

@@ -870,7 +870,8 @@ enum AcpiIortNodeType
     ACPI_IORT_NODE_ITS_GROUP            =3D 0x00,
     ACPI_IORT_NODE_NAMED_COMPONENT      =3D 0x01,
     ACPI_IORT_NODE_PCI_ROOT_COMPLEX     =3D 0x02,
-    ACPI_IORT_NODE_SMMU                 =3D 0x03
+    ACPI_IORT_NODE_SMMU                 =3D 0x03,
+    ACPI_IORT_NODE_SMMU_V3              =3D 0x04
 };


@@ -979,6 +980,26 @@ typedef struct acpi_iort_smmu
 #define ACPI_IORT_SMMU_COHERENT_WALK    (1<<1)


+typedef struct acpi_iort_smmu_v3
+{
+    UINT64                  BaseAddress;            /* SMMUv3 base address=
 */
+    UINT32                  Flags;
+    UINT32                  Reserved;
+    UINT64                  VatosAddress;
+    UINT32                  Model;                 /* O: generic SMMUv3 */
+    UINT32                  EventGsiv;
+    UINT32                  PriGsiv;
+    UINT32                  GerrGsiv;
+    UINT32                  SyncGsiv;
+
+} ACPI_IORT_SMMU_V3;
+
+/* Masks for Flags field above */
+
+#define ACPI_IORT_SMMU_V3_COHACC_OVERRIDE   (1)
+#define ACPI_IORT_SMMU_V3_HTTU_OVERRIDE     (1<<1)
+
+
 /*************************************************************************=
******
  *
  * IVRS - I/O Virtualization Reporting Structure
-- =

2.5.0


-- =

ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3(a)redhat.com
-----------------------------------

--===============7937990857838146427==--

