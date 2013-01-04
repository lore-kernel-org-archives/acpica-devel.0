Content-Type: multipart/mixed; boundary="===============9130731915870550691=="
MIME-Version: 1.0
From: Lv Zheng <lv.zheng at intel.com>
Subject: [Devel] [PATCH 1/1] ACPICA: Table: Add VRTC table support.
Date: Fri, 04 Jan 2013 13:39:53 +0800
Message-ID: <9dce16ee5a6821f10e419c5b286fb0c287200758.1357277898.git.lv.zheng@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============9130731915870550691==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

VRTC is used in Intel MID platforms as a replacement of the traditional
x86 RTC. VRTC table can be found in the recent ACPI BIOS enabled MID
platforms. The format of this table has been defined in the "Simple
Firmware Interface Specification".
This patch introduces VRTC table support into ACPICA.

Signed-off-by: Lv Zheng <lv.zheng(a)intel.com>
---
 source/common/dmtable.c      |    2 ++
 source/common/dmtbdump.c     |   52 ++++++++++++++++++++++++++++++++++++++=
++++
 source/common/dmtbinfo.c     |   22 ++++++++++++++++++
 source/compiler/dtcompiler.h |    5 ++++
 source/compiler/dttable.c    |   25 ++++++++++++++++++++
 source/compiler/dttemplate.h |   11 +++++++++
 source/include/acdisasm.h    |    6 +++++
 source/include/actbl2.h      |   27 ++++++++++++++++++++++
 8 files changed, 150 insertions(+)

diff --git a/source/common/dmtable.c b/source/common/dmtable.c
index 6c2fbdf..7f4696f 100644
--- a/source/common/dmtable.c
+++ b/source/common/dmtable.c
@@ -384,6 +384,8 @@ ACPI_DMTABLE_DATA    AcpiDmTableData[] =3D
     {ACPI_SIG_TCPA, AcpiDmTableInfoTcpa,    NULL,           NULL,         =
  TemplateTcpa,   "Trusted Computing Platform Alliance table"},
     {ACPI_SIG_TPM2, AcpiDmTableInfoTpm2,    NULL,           NULL,         =
  TemplateTpm2,   "Trusted Platform Module hardware interface table"},
     {ACPI_SIG_UEFI, AcpiDmTableInfoUefi,    NULL,           DtCompileUefi,=
  TemplateUefi,   "UEFI Boot Optimization Table"},
+    {ACPI_SIG_VRTC, AcpiDmTableInfoVrtc,    AcpiDmDumpVrtc, DtCompileVrtc,=
  TemplateVrtc,   "SFI - Virutal Real Time Clock Table"},
+    {ACPI_SIG_WAET, AcpiDmTableInfoWaet,    NULL,           NULL,         =
  TemplateWaet,   "Windows ACPI Emulated Devices Table"},
     {ACPI_SIG_WAET, AcpiDmTableInfoWaet,    NULL,           NULL,         =
  TemplateWaet,   "Windows ACPI Emulated Devices Table"},
     {ACPI_SIG_WDAT, NULL,                   AcpiDmDumpWdat, DtCompileWdat,=
  TemplateWdat,   "Watchdog Action Table"},
     {ACPI_SIG_WDDT, AcpiDmTableInfoWddt,    NULL,           NULL,         =
  TemplateWddt,   "Watchdog Description Table"},
diff --git a/source/common/dmtbdump.c b/source/common/dmtbdump.c
index d4b67b0..0c2bd53 100644
--- a/source/common/dmtbdump.c
+++ b/source/common/dmtbdump.c
@@ -2450,6 +2450,58 @@ NextSubTable:
 =

 /*************************************************************************=
******
  *
+ * FUNCTION:    AcpiDmDumpVrtc
+ *
+ * PARAMETERS:  Table               - A VRTC table
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Format the contents of a VRTC
+ *
+ *************************************************************************=
*****/
+
+void
+AcpiDmDumpVrtc (
+    ACPI_TABLE_HEADER       *Table)
+{
+    ACPI_STATUS             Status;
+    UINT32                  Offset =3D sizeof (ACPI_TABLE_VRTC);
+    ACPI_VRTC_ENTRY         *SubTable;
+
+
+    /* Main table */
+
+    Status =3D AcpiDmDumpTable (Table->Length, 0, Table, 0, AcpiDmTableInf=
oVrtc);
+    if (ACPI_FAILURE (Status))
+    {
+        return;
+    }
+
+    /* Sub-tables */
+
+    SubTable =3D ACPI_ADD_PTR (ACPI_VRTC_ENTRY, Table, Offset);
+    while (Offset < Table->Length)
+    {
+        /* Common sub-table header */
+
+        AcpiOsPrintf ("\n");
+        Status =3D AcpiDmDumpTable (Table->Length, Offset, SubTable,
+                    sizeof (ACPI_VRTC_ENTRY), AcpiDmTableInfoVrtc0);
+        if (ACPI_FAILURE (Status))
+        {
+            return;
+        }
+
+        /* Point to next sub-table */
+
+        Offset +=3D sizeof (ACPI_VRTC_ENTRY);
+        SubTable =3D ACPI_ADD_PTR (ACPI_VRTC_ENTRY, SubTable, sizeof (ACPI=
_VRTC_ENTRY));
+    }
+}
+
+
+/*************************************************************************=
******
+ *
  * FUNCTION:    AcpiDmDumpWdat
  *
  * PARAMETERS:  Table               - A WDAT table
diff --git a/source/common/dmtbinfo.c b/source/common/dmtbinfo.c
index e2790f3..05cc2f1 100644
--- a/source/common/dmtbinfo.c
+++ b/source/common/dmtbinfo.c
@@ -267,6 +267,7 @@
 #define ACPI_SRAT0_OFFSET(f)            (UINT16) ACPI_OFFSET (ACPI_SRAT_CP=
U_AFFINITY,f)
 #define ACPI_SRAT1_OFFSET(f)            (UINT16) ACPI_OFFSET (ACPI_SRAT_ME=
M_AFFINITY,f)
 #define ACPI_SRAT2_OFFSET(f)            (UINT16) ACPI_OFFSET (ACPI_SRAT_X2=
APIC_CPU_AFFINITY,f)
+#define ACPI_VRTC0_OFFSET(f)            (UINT16) ACPI_OFFSET (ACPI_VRTC_EN=
TRY,f)
 #define ACPI_WDAT0_OFFSET(f)            (UINT16) ACPI_OFFSET (ACPI_WDAT_EN=
TRY,f)
 =

 /*
@@ -2107,6 +2108,27 @@ ACPI_DMTABLE_INFO           AcpiDmTableInfoUefi[] =
=3D
 =

 /*************************************************************************=
******
  *
+ * VRTC - Virtual Real Time Clock Table
+ *
+ *************************************************************************=
*****/
+
+ACPI_DMTABLE_INFO           AcpiDmTableInfoVrtc[] =3D
+{
+    ACPI_DMT_TERMINATOR
+};
+
+/* VRTC Subtables - VRTC Entry */
+
+ACPI_DMTABLE_INFO           AcpiDmTableInfoVrtc0[] =3D
+{
+    {ACPI_DMT_GAS,      ACPI_VRTC0_OFFSET (PhysicalAddress),        "Physi=
calAddress", 0},
+    {ACPI_DMT_UINT32,   ACPI_VRTC0_OFFSET (Irq),                    "IRQ",=
 0},
+    ACPI_DMT_TERMINATOR
+};
+
+
+/*************************************************************************=
******
+ *
  * WAET - Windows ACPI Emulated devices Table
  *
  *************************************************************************=
*****/
diff --git a/source/compiler/dtcompiler.h b/source/compiler/dtcompiler.h
index 9bf4889..c878a4a 100644
--- a/source/compiler/dtcompiler.h
+++ b/source/compiler/dtcompiler.h
@@ -544,6 +544,10 @@ DtCompileUefi (
     void                    **PFieldList);
 =

 ACPI_STATUS
+DtCompileVrtc (
+    void                    **PFieldList);
+
+ACPI_STATUS
 DtCompileWdat (
     void                    **PFieldList);
 =

@@ -595,6 +599,7 @@ extern const unsigned char  TemplateSrat[];
 extern const unsigned char  TemplateTcpa[];
 extern const unsigned char  TemplateTpm2[];
 extern const unsigned char  TemplateUefi[];
+extern const unsigned char  TemplateVrtc[];
 extern const unsigned char  TemplateWaet[];
 extern const unsigned char  TemplateWdat[];
 extern const unsigned char  TemplateWddt[];
diff --git a/source/compiler/dttable.c b/source/compiler/dttable.c
index a02b633..7029d26 100644
--- a/source/compiler/dttable.c
+++ b/source/compiler/dttable.c
@@ -2046,6 +2046,31 @@ DtCompileUefi (
 =

 /*************************************************************************=
*****
  *
+ * FUNCTION:    DtCompileVrtc
+ *
+ * PARAMETERS:  List                - Current field list pointer
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Compile VRTC.
+ *
+ *************************************************************************=
****/
+
+ACPI_STATUS
+DtCompileVrtc (
+    void                    **List)
+{
+    ACPI_STATUS             Status;
+
+
+    Status =3D DtCompileTwoSubtables (List,
+                 AcpiDmTableInfoVrtc, AcpiDmTableInfoVrtc0);
+    return (Status);
+}
+
+
+/*************************************************************************=
*****
+ *
  * FUNCTION:    DtCompileWdat
  *
  * PARAMETERS:  List                - Current field list pointer
diff --git a/source/compiler/dttemplate.h b/source/compiler/dttemplate.h
index 573e073..fd00adc 100644
--- a/source/compiler/dttemplate.h
+++ b/source/compiler/dttemplate.h
@@ -965,6 +965,17 @@ const unsigned char TemplateUefi[] =3D
     0x0C,0x0D,0x0E,0x0F,0x00,0x00             /* 00000030    "......"   */
 };
 =

+const unsigned char TemplateVrtc[] =3D
+{
+    0x56,0x52,0x54,0x43,0x34,0x00,0x00,0x00,  /* 00000000    "VRTC4..." */
+    0x01,0xB0,0x49,0x4E,0x54,0x45,0x4C,0x20,  /* 00000008    "..INTEL " */
+    0x4C,0x41,0x4E,0x46,0x4F,0x52,0x44,0x43,  /* 00000010    "LANFORDC" */
+    0x03,0x00,0x00,0x00,0x4D,0x53,0x46,0x54,  /* 00000018    "....MSFT" */
+    0x0D,0x00,0x00,0x01,0x00,0x08,0x00,0x00,  /* 00000020    "........" */
+    0x00,0x8C,0x10,0xFF,0x00,0x00,0x00,0x00,  /* 00000028    "........" */
+    0x09,0x00,0x00,0x00                       /* 00000030    "...."     */
+};
+
 const unsigned char TemplateWaet[] =3D
 {
     0x57,0x41,0x45,0x54,0x28,0x00,0x00,0x00,  /* 00000000    "WAET(..." */
diff --git a/source/include/acdisasm.h b/source/include/acdisasm.h
index 229cda7..7d2869d 100644
--- a/source/include/acdisasm.h
+++ b/source/include/acdisasm.h
@@ -415,6 +415,8 @@ extern ACPI_DMTABLE_INFO        AcpiDmTableInfoSrat2[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoTcpa[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoTpm2[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoUefi[];
+extern ACPI_DMTABLE_INFO        AcpiDmTableInfoVrtc[];
+extern ACPI_DMTABLE_INFO        AcpiDmTableInfoVrtc0[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoWaet[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoWdat[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoWdat0[];
@@ -561,6 +563,10 @@ AcpiDmDumpSrat (
     ACPI_TABLE_HEADER       *Table);
 =

 void
+AcpiDmDumpVrtc (
+    ACPI_TABLE_HEADER       *Table);
+
+void
 AcpiDmDumpWdat (
     ACPI_TABLE_HEADER       *Table);
 =

diff --git a/source/include/actbl2.h b/source/include/actbl2.h
index 378b39b..7c0adcb 100644
--- a/source/include/actbl2.h
+++ b/source/include/actbl2.h
@@ -151,6 +151,7 @@
 #define ACPI_SIG_SPMI           "SPMI"      /* Server Platform Management =
Interface table */
 #define ACPI_SIG_TCPA           "TCPA"      /* Trusted Computing Platform =
Alliance table */
 #define ACPI_SIG_UEFI           "UEFI"      /* Uefi Boot Optimization Tabl=
e */
+#define ACPI_SIG_VRTC           "VRTC"      /* Virtual Real Time Clock Tab=
le */
 #define ACPI_SIG_WAET           "WAET"      /* Windows ACPI Emulated devic=
es Table */
 #define ACPI_SIG_WDAT           "WDAT"      /* Watchdog Action Table */
 #define ACPI_SIG_WDDT           "WDDT"      /* Watchdog Timer Description =
Table */
@@ -1254,6 +1255,32 @@ typedef struct acpi_table_uefi
 =

 /*************************************************************************=
******
  *
+ * VRTC - Virtual Real Time Clock Table
+ *        Version 1
+ *
+ * Conforms to "Simple Firmware Interface Specification",
+ * Draft 0.8.2, Oct 19, 2010
+ * NOTE: ACPI VRTC is equivalent to SFI MRTC table.
+ *
+ *************************************************************************=
*****/
+
+typedef struct acpi_table_vrtc
+{
+    ACPI_TABLE_HEADER       Header;             /* Common ACPI table heade=
r */
+
+} ACPI_TABLE_VRTC;
+
+/* VRTC entry */
+
+typedef struct acpi_vrtc_entry
+{
+    ACPI_GENERIC_ADDRESS    PhysicalAddress;
+    UINT32                  Irq;
+} ACPI_VRTC_ENTRY;
+
+
+/*************************************************************************=
******
+ *
  * WAET - Windows ACPI Emulated devices Table
  *        Version 1
  *
-- =

1.7.10


--===============9130731915870550691==--

