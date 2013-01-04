Content-Type: multipart/mixed; boundary="===============6824634008443510936=="
MIME-Version: 1.0
From: Lv Zheng <lv.zheng at intel.com>
Subject: [Devel] [PATCH v3 1/2] ACPICA: iASL: Add MTMR table support.
Date: Fri, 04 Jan 2013 14:37:48 +0800
Message-ID: <cf3022d63ec60486602ad9f4aa6fb788244a0b90.1357281212.git.lv.zheng@intel.com>
In-Reply-To: cover.1357281212.git.lv.zheng@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6824634008443510936==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

MTMR table is used in the recent ACPI BIOS enabled Intel MID platforms.
The format of this table has been defined in the "Simple Firmware
Interface Specification".
This patch introduces MTMR table support into ACPICA.

Signed-off-by: Lv Zheng <lv.zheng(a)intel.com>
---
 source/common/dmtable.c      |    1 +
 source/common/dmtbdump.c     |   52 ++++++++++++++++++++++++++++++++++++++=
++++
 source/common/dmtbinfo.c     |   23 +++++++++++++++++++
 source/compiler/dtcompiler.h |    5 ++++
 source/compiler/dttable.c    |   25 ++++++++++++++++++++
 source/compiler/dttemplate.h |   14 ++++++++++++
 source/include/acdisasm.h    |    6 +++++
 source/include/actbl2.h      |   29 +++++++++++++++++++++++
 8 files changed, 155 insertions(+)

diff --git a/source/common/dmtable.c b/source/common/dmtable.c
index 6c2fbdf..0ec5770 100644
--- a/source/common/dmtable.c
+++ b/source/common/dmtable.c
@@ -371,6 +371,7 @@ ACPI_DMTABLE_DATA    AcpiDmTableData[] =3D
     {ACPI_SIG_MCHI, AcpiDmTableInfoMchi,    NULL,           NULL,         =
  TemplateMchi,   "Management Controller Host Interface table"},
     {ACPI_SIG_MPST, AcpiDmTableInfoMpst,    AcpiDmDumpMpst, DtCompileMpst,=
  TemplateMpst,   "Memory Power State Table"},
     {ACPI_SIG_MSCT, NULL,                   AcpiDmDumpMsct, DtCompileMsct,=
  TemplateMsct,   "Maximum System Characteristics Table"},
+    {ACPI_SIG_MTMR, NULL,                   AcpiDmDumpMtmr, DtCompileMtmr,=
  TemplateMtmr,   "SFI - MID Timer Table"},
     {ACPI_SIG_PCCT, NULL,                   AcpiDmDumpPcct, NULL,         =
  NULL,           "Platform Communications Channel Table"},
     {ACPI_SIG_PMTT, NULL,                   AcpiDmDumpPmtt, DtCompilePmtt,=
  TemplatePmtt,   "Platform Memory Topology Table"},
     {ACPI_SIG_RSDT, NULL,                   AcpiDmDumpRsdt, DtCompileRsdt,=
  TemplateRsdt,   "Root System Description Table"},
diff --git a/source/common/dmtbdump.c b/source/common/dmtbdump.c
index d4b67b0..337445e 100644
--- a/source/common/dmtbdump.c
+++ b/source/common/dmtbdump.c
@@ -1868,6 +1868,58 @@ AcpiDmDumpMsct (
 =

 /*************************************************************************=
******
  *
+ * FUNCTION:    AcpiDmDumpMtmr
+ *
+ * PARAMETERS:  Table               - A MTMR table
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Format the contents of a MTMR
+ *
+ *************************************************************************=
*****/
+
+void
+AcpiDmDumpMtmr (
+    ACPI_TABLE_HEADER       *Table)
+{
+    ACPI_STATUS             Status;
+    UINT32                  Offset =3D sizeof (ACPI_TABLE_MTMR);
+    ACPI_MTMR_ENTRY         *SubTable;
+
+
+    /* Main table */
+
+    Status =3D AcpiDmDumpTable (Table->Length, 0, Table, 0, AcpiDmTableInf=
oMtmr);
+    if (ACPI_FAILURE (Status))
+    {
+        return;
+    }
+
+    /* Sub-tables */
+
+    SubTable =3D ACPI_ADD_PTR (ACPI_MTMR_ENTRY, Table, Offset);
+    while (Offset < Table->Length)
+    {
+        /* Common sub-table header */
+
+        AcpiOsPrintf ("\n");
+        Status =3D AcpiDmDumpTable (Table->Length, Offset, SubTable,
+                    sizeof (ACPI_MTMR_ENTRY), AcpiDmTableInfoMtmr0);
+        if (ACPI_FAILURE (Status))
+        {
+            return;
+        }
+
+        /* Point to next sub-table */
+
+        Offset +=3D sizeof (ACPI_MTMR_ENTRY);
+        SubTable =3D ACPI_ADD_PTR (ACPI_MTMR_ENTRY, SubTable, sizeof (ACPI=
_MTMR_ENTRY));
+    }
+}
+
+
+/*************************************************************************=
******
+ *
  * FUNCTION:    AcpiDmDumpPcct
  *
  * PARAMETERS:  Table               - A PCCT table
diff --git a/source/common/dmtbinfo.c b/source/common/dmtbinfo.c
index e2790f3..1c72da9 100644
--- a/source/common/dmtbinfo.c
+++ b/source/common/dmtbinfo.c
@@ -251,6 +251,7 @@
 #define ACPI_MPST1_OFFSET(f)            (UINT16) ACPI_OFFSET (ACPI_MPST_DA=
TA_HDR,f)
 #define ACPI_MPST2_OFFSET(f)            (UINT16) ACPI_OFFSET (ACPI_MPST_PO=
WER_DATA,f)
 #define ACPI_MSCT0_OFFSET(f)            (UINT16) ACPI_OFFSET (ACPI_MSCT_PR=
OXIMITY,f)
+#define ACPI_MTMR0_OFFSET(f)            (UINT16) ACPI_OFFSET (ACPI_MTMR_EN=
TRY,f)
 #define ACPI_PCCT0_OFFSET(f)            (UINT16) ACPI_OFFSET (ACPI_PCCT_SU=
BSPACE,f)
 #define ACPI_PMTT0_OFFSET(f)            (UINT16) ACPI_OFFSET (ACPI_PMTT_SO=
CKET,f)
 #define ACPI_PMTT1_OFFSET(f)            (UINT16) ACPI_OFFSET (ACPI_PMTT_CO=
NTROLLER,f)
@@ -1716,6 +1717,28 @@ ACPI_DMTABLE_INFO           AcpiDmTableInfoMsct0[] =
=3D
 =

 /*************************************************************************=
******
  *
+ * MTMR - MID Timer Table
+ *
+ *************************************************************************=
*****/
+
+ACPI_DMTABLE_INFO           AcpiDmTableInfoMtmr[] =3D
+{
+    ACPI_DMT_TERMINATOR
+};
+
+/* MTMR Subtables - MTMR Entry */
+
+ACPI_DMTABLE_INFO           AcpiDmTableInfoMtmr0[] =3D
+{
+    {ACPI_DMT_GAS,      ACPI_MTMR0_OFFSET (PhysicalAddress),        "Physi=
calAddress", 0},
+    {ACPI_DMT_UINT32,   ACPI_MTMR0_OFFSET (Frequency),              "Frequ=
ency", 0},
+    {ACPI_DMT_UINT32,   ACPI_MTMR0_OFFSET (Irq),                    "IRQ",=
 0},
+    ACPI_DMT_TERMINATOR
+};
+
+
+/*************************************************************************=
******
+ *
  * PCCT - Platform Communications Channel Table (ACPI 5.0)
  *
  *************************************************************************=
*****/
diff --git a/source/compiler/dtcompiler.h b/source/compiler/dtcompiler.h
index 9bf4889..d99927f 100644
--- a/source/compiler/dtcompiler.h
+++ b/source/compiler/dtcompiler.h
@@ -516,6 +516,10 @@ DtCompileMsct (
     void                    **PFieldList);
 =

 ACPI_STATUS
+DtCompileMtmr (
+    void                    **PFieldList);
+
+ACPI_STATUS
 DtCompilePmtt (
     void                    **PFieldList);
 =

@@ -583,6 +587,7 @@ extern const unsigned char  TemplateMcfg[];
 extern const unsigned char  TemplateMchi[];
 extern const unsigned char  TemplateMpst[];
 extern const unsigned char  TemplateMsct[];
+extern const unsigned char  TemplateMtmr[];
 extern const unsigned char  TemplatePmtt[];
 extern const unsigned char  TemplateRsdt[];
 extern const unsigned char  TemplateS3pt[];
diff --git a/source/compiler/dttable.c b/source/compiler/dttable.c
index a02b633..5c4f036 100644
--- a/source/compiler/dttable.c
+++ b/source/compiler/dttable.c
@@ -1484,6 +1484,31 @@ DtCompileMsct (
 =

 /*************************************************************************=
*****
  *
+ * FUNCTION:    DtCompileMtmr
+ *
+ * PARAMETERS:  List                - Current field list pointer
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Compile MTMR.
+ *
+ *************************************************************************=
****/
+
+ACPI_STATUS
+DtCompileMtmr (
+    void                    **List)
+{
+    ACPI_STATUS             Status;
+
+
+    Status =3D DtCompileTwoSubtables (List,
+                 AcpiDmTableInfoMtmr, AcpiDmTableInfoMtmr0);
+    return (Status);
+}
+
+
+/*************************************************************************=
*****
+ *
  * FUNCTION:    DtCompilePmtt
  *
  * PARAMETERS:  List                - Current field list pointer
diff --git a/source/compiler/dttemplate.h b/source/compiler/dttemplate.h
index 573e073..bd45446 100644
--- a/source/compiler/dttemplate.h
+++ b/source/compiler/dttemplate.h
@@ -704,6 +704,20 @@ const unsigned char TemplateMsct[] =3D
     0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00   /* 00000088    "........" */
 };
 =

+const unsigned char TemplateMtmr[] =3D
+{
+    0x4D,0x54,0x4D,0x52,0x4C,0x00,0x00,0x00,  /* 00000000    "MTMRL..." */
+    0x01,0xA0,0x49,0x4E,0x54,0x45,0x4C,0x20,  /* 00000008    "..INTEL " */
+    0x4C,0x41,0x4E,0x46,0x4F,0x52,0x44,0x43,  /* 00000010    "LANFORDC" */
+    0x03,0x00,0x00,0x00,0x4D,0x53,0x46,0x54,  /* 00000018    "....MSFT" */
+    0x0D,0x00,0x00,0x01,0x00,0x20,0x00,0x03,  /* 00000020    "..... .." */
+    0x00,0xB8,0x11,0xFF,0x00,0x00,0x00,0x00,  /* 00000028    "........" */
+    0x85,0xBA,0x1A,0x03,0x00,0x00,0x00,0x00,  /* 00000030    "........" */
+    0x00,0x20,0x00,0x03,0x14,0xB8,0x11,0xFF,  /* 00000038    ". ......" */
+    0x00,0x00,0x00,0x00,0x85,0xBA,0x1A,0x03,  /* 00000040    "........" */
+    0x01,0x00,0x00,0x00                       /* 00000048    "...."     */
+};
+
 const unsigned char TemplatePmtt[] =3D
 {
     0x50,0x4D,0x54,0x54,0xB4,0x00,0x00,0x00,  /* 00000000    "PMTT...." */
diff --git a/source/include/acdisasm.h b/source/include/acdisasm.h
index 229cda7..7c26bc6 100644
--- a/source/include/acdisasm.h
+++ b/source/include/acdisasm.h
@@ -386,6 +386,8 @@ extern ACPI_DMTABLE_INFO        AcpiDmTableInfoMpst1[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoMpst2[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoMsct[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoMsct0[];
+extern ACPI_DMTABLE_INFO        AcpiDmTableInfoMtmr[];
+extern ACPI_DMTABLE_INFO        AcpiDmTableInfoMtmr0[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoPmtt[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoPmtt0[];
 extern ACPI_DMTABLE_INFO        AcpiDmTableInfoPmtt1[];
@@ -529,6 +531,10 @@ AcpiDmDumpMsct (
     ACPI_TABLE_HEADER       *Table);
 =

 void
+AcpiDmDumpMtmr (
+    ACPI_TABLE_HEADER       *Table);
+
+void
 AcpiDmDumpPcct (
     ACPI_TABLE_HEADER       *Table);
 =

diff --git a/source/include/actbl2.h b/source/include/actbl2.h
index 378b39b..1e0556f 100644
--- a/source/include/actbl2.h
+++ b/source/include/actbl2.h
@@ -146,6 +146,7 @@
 #define ACPI_SIG_IVRS           "IVRS"      /* I/O Virtualization Reportin=
g Structure */
 #define ACPI_SIG_MCFG           "MCFG"      /* PCI Memory Mapped Configura=
tion table */
 #define ACPI_SIG_MCHI           "MCHI"      /* Management Controller Host =
Interface table */
+#define ACPI_SIG_MTMR           "MTMR"      /* MID Timer table */
 #define ACPI_SIG_SLIC           "SLIC"      /* Software Licensing Descript=
ion Table */
 #define ACPI_SIG_SPCR           "SPCR"      /* Serial Port Console Redirec=
tion table */
 #define ACPI_SIG_SPMI           "SPMI"      /* Server Platform Management =
Interface table */
@@ -1055,6 +1056,34 @@ typedef struct acpi_table_mchi
 =

 /*************************************************************************=
******
  *
+ * MTMR - MID Timer Table
+ *        Version 1
+ *
+ * Conforms to "Simple Firmware Interface Specification",
+ * Draft 0.8.2, Oct 19, 2010
+ * NOTE: ACPI MTMR is equivalent to SFI MTMR table.
+ *
+ *************************************************************************=
*****/
+
+typedef struct acpi_table_mtmr
+{
+    ACPI_TABLE_HEADER       Header;             /* Common ACPI table heade=
r */
+
+} ACPI_TABLE_MTMR;
+
+/* MTMR entry */
+
+typedef struct acpi_mtmr_entry
+{
+    ACPI_GENERIC_ADDRESS    PhysicalAddress;
+    UINT32                  Frequency;
+    UINT32                  Irq;
+
+} ACPI_MTMR_ENTRY;
+
+
+/*************************************************************************=
******
+ *
  * SLIC - Software Licensing Description Table
  *        Version 1
  *
-- =

1.7.10


--===============6824634008443510936==--

