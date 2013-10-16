Content-Type: multipart/mixed; boundary="===============6564702609953916931=="
MIME-Version: 1.0
From: naresh.bhat at linaro.org
Subject: [Devel] [PATCH 2/2] iASL: Add template support for dbg2
Date: Wed, 16 Oct 2013 13:18:40 +0530
Message-ID: <1381909720-21314-3-git-send-email-naresh.bhat@linaro.org>
In-Reply-To: 1381909720-21314-1-git-send-email-naresh.bhat@linaro.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6564702609953916931==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Naresh Bhat <naresh.bhat(a)linaro.org>

This patch will add the template support for dbg2.
$ iasl -T DBG2
DBG2: No template available

Signed-off-by: Naresh Bhat <naresh.bhat(a)linaro.org>
---
 source/common/dmtable.c      |    2 +-
 source/compiler/dtcompiler.h |    1 +
 source/compiler/dttemplate.h |   10 ++++++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/source/common/dmtable.c b/source/common/dmtable.c
index 12b8905..5552553 100644
--- a/source/common/dmtable.c
+++ b/source/common/dmtable.c
@@ -358,7 +358,7 @@ ACPI_DMTABLE_DATA    AcpiDmTableData[] =3D
     {ACPI_SIG_BOOT, AcpiDmTableInfoBoot,    NULL,           NULL,         =
  TemplateBoot,   "Simple Boot Flag Table"},
     {ACPI_SIG_CPEP, NULL,                   AcpiDmDumpCpep, DtCompileCpep,=
  TemplateCpep,   "Corrected Platform Error Polling table"},
     {ACPI_SIG_CSRT, NULL,                   AcpiDmDumpCsrt, DtCompileCsrt,=
  TemplateCsrt,   "Core System Resource Table"},
-    {ACPI_SIG_DBG2, AcpiDmTableInfoDbg2,    AcpiDmDumpDbg2, NULL,         =
  NULL,           "Debug Port table type 2"},
+    {ACPI_SIG_DBG2, AcpiDmTableInfoDbg2,    AcpiDmDumpDbg2, NULL,         =
  TemplateDbg2,   "Debug Port table type 2"},
     {ACPI_SIG_DBGP, AcpiDmTableInfoDbgp,    NULL,           NULL,         =
  TemplateDbgp,   "Debug Port table"},
     {ACPI_SIG_DMAR, NULL,                   AcpiDmDumpDmar, DtCompileDmar,=
  TemplateDmar,   "DMA Remapping table"},
     {ACPI_SIG_ECDT, AcpiDmTableInfoEcdt,    NULL,           NULL,         =
  TemplateEcdt,   "Embedded Controller Boot Resources Table"},
diff --git a/source/compiler/dtcompiler.h b/source/compiler/dtcompiler.h
index 9868662..96ece50 100644
--- a/source/compiler/dtcompiler.h
+++ b/source/compiler/dtcompiler.h
@@ -575,6 +575,7 @@ extern const unsigned char  TemplateBert[];
 extern const unsigned char  TemplateBgrt[];
 extern const unsigned char  TemplateCpep[];
 extern const unsigned char  TemplateCsrt[];
+extern const unsigned char  TemplateDbg2[];
 extern const unsigned char  TemplateDbgp[];
 extern const unsigned char  TemplateDmar[];
 extern const unsigned char  TemplateEcdt[];
diff --git a/source/compiler/dttemplate.h b/source/compiler/dttemplate.h
index f131b62..816c87e 100644
--- a/source/compiler/dttemplate.h
+++ b/source/compiler/dttemplate.h
@@ -246,6 +246,16 @@ const unsigned char TemplateCsrt[] =3D
     0x43,0x48,0x41,0x37                       /* 00000148    "CHA7"     */
 };
 =

+const unsigned char TemplateDbg2[] =3D
+{
+    0x44,0x42,0x47,0x32,0x2C,0x00,0x00,0x00,  /* 00000000    "DBG2,..." */
+    0x01,0xD3,0x4C,0x49,0x4E,0x41,0x52,0x4F,  /* 00000008    "..LINARO" */
+    0x54,0x45,0x4D,0x50,0x4C,0x41,0x54,0x45,  /* 00000010    "TEMPLATE" */
+    0x01,0x00,0x00,0x00,0x49,0x4E,0x54,0x4C,  /* 00000018    "....INTL" */
+    0x27,0x09,0x13,0x20,0x44,0x00,0x00,0x00,  /* 00000020    "'.. D..." */
+    0x01,0x00,0x00,0x00                       /* 00000028    "...."     */
+};
+
 const unsigned char TemplateDbgp[] =3D
 {
     0x44,0x42,0x47,0x50,0x34,0x00,0x00,0x00,  /* 00000000    "DBGP4..." */
-- =

1.7.9.5


--===============6564702609953916931==--

