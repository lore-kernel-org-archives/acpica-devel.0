Content-Type: multipart/mixed; boundary="===============6767710890680015167=="
MIME-Version: 1.0
From: Lv Zheng <lv.zheng at intel.com>
Subject: [Devel] [PATCH 1/2] Fix build breakage issue with ACPI_DEBUG_PRINT
 macro.
Date: Mon, 14 Jan 2013 08:35:56 +0800
Message-ID: <efc33fe27ba2398819893582c358b8d203fe5ae9.1358122823.git.lv.zheng@intel.com>
In-Reply-To: cover.1358122823.git.lv.zheng@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6767710890680015167==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Enhanced ACPI_DEBUG_PRINT macro will break ACPICA compilation on
platforms using compilers other than GCC. This patch fix this
build breakage issue.

Signed-off-by: Lv Zheng <lv.zheng(a)intel.com>
---
 source/include/acoutput.h       |   17 +++++++++++++----
 source/include/platform/acgcc.h |    5 +++++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/source/include/acoutput.h b/source/include/acoutput.h
index e1ad7d1..dd472c9 100644
--- a/source/include/acoutput.h
+++ b/source/include/acoutput.h
@@ -368,10 +368,7 @@
 #define ACPI_DO_WHILE0(a)               a
 #endif
 =

-/* DEBUG_PRINT functions */
-
-#define ACPI_DEBUG_PRINT(plist)         ACPI_ACTUAL_DEBUG plist
-#define ACPI_DEBUG_PRINT_RAW(plist)     ACPI_ACTUAL_DEBUG_RAW plist
+#ifdef ACPI_CC_HAS_MACRO_VA_ARGS
 =

 /* Helper macros for DEBUG_PRINT */
 =

@@ -391,6 +388,18 @@
     ACPI_DO_DEBUG_PRINT (AcpiDebugPrintRaw, Level, Line, \
         Filename, Modulename, Component, __VA_ARGS__)
 =

+/* DEBUG_PRINT functions */
+
+#define ACPI_DEBUG_PRINT(plist)         ACPI_ACTUAL_DEBUG plist
+#define ACPI_DEBUG_PRINT_RAW(plist)     ACPI_ACTUAL_DEBUG_RAW plist
+
+#else
+
+#define ACPI_DEBUG_PRINT(plist)         AcpiDebugPrint plist
+#define ACPI_DEBUG_PRINT_RAW(plist)     AcpiDebugPrintRaw plist
+
+#endif
+
 =

 /*
  * Function entry tracing
diff --git a/source/include/platform/acgcc.h b/source/include/platform/acgc=
c.h
index 6ff7743..45729da 100644
--- a/source/include/platform/acgcc.h
+++ b/source/include/platform/acgcc.h
@@ -136,4 +136,9 @@
  */
 #define ACPI_UNUSED_VAR __attribute__ ((unused))
 =

+/*
+ * Some compilers support va_arg in macro definitions while others not.
+ */
+#define ACPI_CC_HAS_MACRO_VA_ARGS      1
+
 #endif /* __ACGCC_H__ */
-- =

1.7.10


--===============6767710890680015167==--

