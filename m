Content-Type: multipart/mixed; boundary="===============8454806351188397114=="
MIME-Version: 1.0
From: Lv Zheng <lv.zheng at intel.com>
Subject: [Devel] [PATCH 1/1] ACPICA: Cleanup ACPI_DEBUG_PRINT macros to fix
 potential build breakages.
Date: Thu, 10 Jan 2013 12:39:23 +0800
Message-ID: <7fe52be62b03ad486aa7550264d98a0aa1bb0f80.1357792644.git.lv.zheng@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8454806351188397114==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Bob Moore <robert.moore(a)intel.com>

Fix two issues with the ACPI_DEBUG_PRINT macros.
1) Add the ACPI_DO_WHILE macro to the main DEBUG_PRINT helper macro.
2) Rename ACPI_DEBUG macro to ACPI_DO_DEBUG_PRINT since ACPI_DEBUG
   is already commonly used by the various hosts.

Signed-off-by: Bob Moore <robert.moore(a)intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki(a)intel.com>
Signed-off-by: Lv Zheng <lv.zheng(a)intel.com>
---
 source/include/acoutput.h |   36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/source/include/acoutput.h b/source/include/acoutput.h
index b9d19e2..e1ad7d1 100644
--- a/source/include/acoutput.h
+++ b/source/include/acoutput.h
@@ -357,7 +357,16 @@
  * debug message outside of the print function itself. This improves overa=
ll
  * performance at a relatively small code cost. Implementation involves the
  * use of variadic macros supported by C99.
+ *
+ * Note: the ACPI_DO_WHILE0 macro is used to prevent some compilers from
+ * complaining about these constructs. On other compilers the do...while
+ * adds some extra code, so this feature is optional.
  */
+#ifdef ACPI_USE_DO_WHILE_0
+#define ACPI_DO_WHILE0(a)               do a while(0)
+#else
+#define ACPI_DO_WHILE0(a)               a
+#endif
 =

 /* DEBUG_PRINT functions */
 =

@@ -366,17 +375,21 @@
 =

 /* Helper macros for DEBUG_PRINT */
 =

-#define ACPI_DEBUG(Function, Level, Line, Filename, Modulename, Component,=
 ...) \
-    if (ACPI_IS_DEBUG_ENABLED (Level, Component)) \
-    { \
-        Function (Level, Line, Filename, Modulename, Component, __VA_ARGS_=
_); \
-    }
+#define ACPI_DO_DEBUG_PRINT(Function, Level, Line, Filename, Modulename, C=
omponent, ...) \
+    ACPI_DO_WHILE0 ({ \
+        if (ACPI_IS_DEBUG_ENABLED (Level, Component)) \
+        { \
+            Function (Level, Line, Filename, Modulename, Component, __VA_A=
RGS__); \
+        } \
+    })
 =

 #define ACPI_ACTUAL_DEBUG(Level, Line, Filename, Modulename, Component, ..=
.) \
-    ACPI_DEBUG (AcpiDebugPrint, Level, Line, Filename, Modulename, Compone=
nt, __VA_ARGS__)
+    ACPI_DO_DEBUG_PRINT (AcpiDebugPrint, Level, Line, \
+        Filename, Modulename, Component, __VA_ARGS__)
 =

 #define ACPI_ACTUAL_DEBUG_RAW(Level, Line, Filename, Modulename, Component=
, ...) \
-    ACPI_DEBUG (AcpiDebugPrintRaw, Level, Line, Filename, Modulename, Comp=
onent, __VA_ARGS__)
+    ACPI_DO_DEBUG_PRINT (AcpiDebugPrintRaw, Level, Line, \
+        Filename, Modulename, Component, __VA_ARGS__)
 =

 =

 /*
@@ -420,16 +433,7 @@
  *
  * One of the FUNCTION_TRACE macros above must be used in conjunction
  * with these macros so that "_AcpiFunctionName" is defined.
- *
- * Note: the DO_WHILE0 macro is used to prevent some compilers from
- * complaining about these constructs. On other compilers the do...while
- * adds some extra code, so this feature is optional.
  */
-#ifdef ACPI_USE_DO_WHILE_0
-#define ACPI_DO_WHILE0(a)               do a while(0)
-#else
-#define ACPI_DO_WHILE0(a)               a
-#endif
 =

 /* Exit trace helper macro */
 =

-- =

1.7.10


--===============8454806351188397114==--

