Content-Type: multipart/mixed; boundary="===============1370664600305852127=="
MIME-Version: 1.0
From: malattia at linux.it
Subject: [Devel] [patch 4/5] Fix aligment issues
Date: Mon, 05 Jul 2010 21:03:28 +0900
Message-ID: <20100705120818.293314314@linux.it>
In-Reply-To: 20100705120324.581857151@linux.it
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1370664600305852127==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add more platforms to the list of the ones requiring aligned memory access.=
 Also
fix callsites where wrong assumptions where made in terms of aligment.

Signed-off-by: Mattia Dongili <malattia(a)linux.it>
---
 compiler/asltree.c  |   15 ++++++++++-----
 executer/exoparg2.c |   12 +++++++++---
 include/actypes.h   |   26 +++++++++++++-------------
 3 files changed, 32 insertions(+), 21 deletions(-)

Index: b/include/actypes.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/actypes.h	2010-07-02 21:42:26.465350281 +0900
+++ b/include/actypes.h	2010-07-04 11:18:22.506529460 +0900
@@ -205,6 +205,19 @@
 =

 /*! [End] no source code translation !*/
 =

+/*
+ * In the case of the Itanium Processor Family (IPF), the hardware does not
+ * support misaligned memory transfers. Set the MISALIGNMENT_NOT_SUPPORTED=
 flag
+ * to indicate that special precautions must be taken to avoid alignment f=
aults.
+ * (IA64 or ia64 is currently used by existing compilers to indicate IPF.)
+ *
+ * Note: EM64T and other X86-64 processors support misaligned transfers,
+ * so there is no need to define this flag.
+ */
+#if defined (__IA64__) || defined (__ia64__) | defined(__alpha__) || defin=
ed(__sparc__) || defined(__hppa__) || defined(__arm__)
+#define ACPI_MISALIGNMENT_NOT_SUPPORTED
+#endif
+
 =

 /*************************************************************************=
******
  *
@@ -231,19 +244,6 @@
 #define ACPI_SIZE_MAX                   ACPI_UINT64_MAX
 #define ACPI_USE_NATIVE_DIVIDE          /* Has native 64-bit integer suppo=
rt */
 =

-/*
- * In the case of the Itanium Processor Family (IPF), the hardware does not
- * support misaligned memory transfers. Set the MISALIGNMENT_NOT_SUPPORTED=
 flag
- * to indicate that special precautions must be taken to avoid alignment f=
aults.
- * (IA64 or ia64 is currently used by existing compilers to indicate IPF.)
- *
- * Note: EM64T and other X86-64 processors support misaligned transfers,
- * so there is no need to define this flag.
- */
-#if defined (__IA64__) || defined (__ia64__)
-#define ACPI_MISALIGNMENT_NOT_SUPPORTED
-#endif
-
 =

 /*************************************************************************=
******
  *
Index: b/executer/exoparg2.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/executer/exoparg2.c	2010-07-02 21:42:26.477349196 +0900
+++ b/executer/exoparg2.c	2010-07-04 11:18:22.506529460 +0900
@@ -248,6 +248,8 @@
     ACPI_OPERAND_OBJECT     **Operand =3D &WalkState->Operands[0];
     ACPI_OPERAND_OBJECT     *ReturnDesc1 =3D NULL;
     ACPI_OPERAND_OBJECT     *ReturnDesc2 =3D NULL;
+    UINT64                  ReturnValue1 =3D 0;
+    UINT64                  ReturnValue2 =3D 0;
     ACPI_STATUS             Status;
 =

 =

@@ -281,8 +283,10 @@
 =

         Status =3D AcpiUtDivide (Operand[0]->Integer.Value,
                                Operand[1]->Integer.Value,
-                               &ReturnDesc1->Integer.Value,
-                               &ReturnDesc2->Integer.Value);
+                               &ReturnValue1, &ReturnValue2);
+        ReturnDesc1->Integer.Value =3D ReturnValue1;
+        ReturnDesc2->Integer.Value =3D ReturnValue2;
+
         if (ACPI_FAILURE (Status))
         {
             goto Cleanup;
@@ -357,6 +361,7 @@
     ACPI_OPERAND_OBJECT     **Operand =3D &WalkState->Operands[0];
     ACPI_OPERAND_OBJECT     *ReturnDesc =3D NULL;
     UINT64                  Index;
+    UINT64                  ReturnValue =3D 0;
     ACPI_STATUS             Status =3D AE_OK;
     ACPI_SIZE               Length;
 =

@@ -400,7 +405,8 @@
         Status =3D AcpiUtDivide (Operand[0]->Integer.Value,
                                Operand[1]->Integer.Value,
                                NULL,
-                               &ReturnDesc->Integer.Value);
+                               &ReturnValue);
+        ReturnDesc->Integer.Value =3D ReturnValue;
         break;
 =

 =

Index: b/compiler/asltree.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/compiler/asltree.c	2010-07-02 21:42:26.529349893 +0900
+++ b/compiler/asltree.c	2010-07-04 11:18:22.510539385 +0900
@@ -501,24 +501,27 @@
         "\nCreateValuedLeafNode  Ln/Col %u/%u NewNode %p  Op %s  Value %8.=
8X%8.8X  ",
         Op->Asl.LineNumber, Op->Asl.Column, Op, UtGetOpName(ParseOpcode),
         ACPI_FORMAT_UINT64 (Value));
-    Op->Asl.Value.Integer =3D Value;
 =

     switch (ParseOpcode)
     {
     case PARSEOP_STRING_LITERAL:
-        DbgPrint (ASL_PARSE_OUTPUT, "STRING->%s", Value);
+        Op->Asl.Value.String =3D (ACPI_STRING) Value;
+        DbgPrint (ASL_PARSE_OUTPUT, "STRING->%s", (ACPI_STRING) Value);
         break;
 =

     case PARSEOP_NAMESEG:
-        DbgPrint (ASL_PARSE_OUTPUT, "NAMESEG->%s", Value);
+        Op->Asl.Value.String =3D (ACPI_STRING) Value;
+        DbgPrint (ASL_PARSE_OUTPUT, "NAMESEG->%s", (ACPI_STRING) Value);
         break;
 =

     case PARSEOP_NAMESTRING:
-        DbgPrint (ASL_PARSE_OUTPUT, "NAMESTRING->%s", Value);
+        Op->Asl.Value.String =3D (ACPI_STRING) Value;
+        DbgPrint (ASL_PARSE_OUTPUT, "NAMESTRING->%s", (ACPI_STRING) Value);
         break;
 =

     case PARSEOP_EISAID:
-        DbgPrint (ASL_PARSE_OUTPUT, "EISAID->%s", Value);
+        Op->Asl.Value.String =3D (ACPI_STRING) Value;
+        DbgPrint (ASL_PARSE_OUTPUT, "EISAID->%s", (ACPI_STRING) Value);
         break;
 =

     case PARSEOP_METHOD:
@@ -526,10 +529,12 @@
         break;
 =

     case PARSEOP_INTEGER:
+        Op->Asl.Value.Integer =3D Value;
         DbgPrint (ASL_PARSE_OUTPUT, "INTEGER");
         break;
 =

     default:
+        Op->Asl.Value.Integer =3D Value;
         break;
     }
 =



--===============1370664600305852127==--

