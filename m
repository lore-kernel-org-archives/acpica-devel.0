Content-Type: multipart/mixed; boundary="===============1517305575664488590=="
MIME-Version: 1.0
From: naresh.bhat at linaro.org
Subject: [Devel] [PATCH 1/2] iASL: Fix Table Info handler for DBG2
Date: Wed, 16 Oct 2013 13:18:39 +0530
Message-ID: <1381909720-21314-2-git-send-email-naresh.bhat@linaro.org>
In-Reply-To: 1381909720-21314-1-git-send-email-naresh.bhat@linaro.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1517305575664488590==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Naresh Bhat <naresh.bhat(a)linaro.org>

Fix dbg2.asl compilation issue. The DBG2 table is not able to
compile because of "Table Info" handler call is missing.
The DBG2 compilation logs are as below

$ iasl dbg2.asl

Intel ACPI Component Architecture
ASL Optimizing Compiler version 20130927-64 [Oct 10 2013]
Copyright (c) 2000 - 2013 Intel Corporation

Error    6126 -  Could not compile input file

dbg2.asl     12: [0004]                        Info Offset : 00000044 [Firs=
t DDIS entry]
Error    6010 -                     Internal compiler error ^  (Missing tab=
le dispatch info)

Table Input:   dbg2.asl - 38 lines, 2383 bytes, 9 fields

Compilation complete. 2 Errors, 0 Warnings, 0 Remarks

Signed-off-by: Naresh Bhat <naresh.bhat(a)linaro.org>
---
 source/common/dmtable.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/source/common/dmtable.c b/source/common/dmtable.c
index fa7b300..12b8905 100644
--- a/source/common/dmtable.c
+++ b/source/common/dmtable.c
@@ -358,7 +358,7 @@ ACPI_DMTABLE_DATA    AcpiDmTableData[] =3D
     {ACPI_SIG_BOOT, AcpiDmTableInfoBoot,    NULL,           NULL,         =
  TemplateBoot,   "Simple Boot Flag Table"},
     {ACPI_SIG_CPEP, NULL,                   AcpiDmDumpCpep, DtCompileCpep,=
  TemplateCpep,   "Corrected Platform Error Polling table"},
     {ACPI_SIG_CSRT, NULL,                   AcpiDmDumpCsrt, DtCompileCsrt,=
  TemplateCsrt,   "Core System Resource Table"},
-    {ACPI_SIG_DBG2, NULL,                   AcpiDmDumpDbg2, NULL,         =
  NULL,           "Debug Port table type 2"},
+    {ACPI_SIG_DBG2, AcpiDmTableInfoDbg2,    AcpiDmDumpDbg2, NULL,         =
  NULL,           "Debug Port table type 2"},
     {ACPI_SIG_DBGP, AcpiDmTableInfoDbgp,    NULL,           NULL,         =
  TemplateDbgp,   "Debug Port table"},
     {ACPI_SIG_DMAR, NULL,                   AcpiDmDumpDmar, DtCompileDmar,=
  TemplateDmar,   "DMA Remapping table"},
     {ACPI_SIG_ECDT, AcpiDmTableInfoEcdt,    NULL,           NULL,         =
  TemplateEcdt,   "Embedded Controller Boot Resources Table"},
-- =

1.7.9.5


--===============1517305575664488590==--

