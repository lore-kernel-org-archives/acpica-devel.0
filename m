Content-Type: multipart/mixed; boundary="===============0707396722381171324=="
MIME-Version: 1.0
From: Lv Zheng <lv.zheng at intel.com>
Subject: [Devel] [PATCH] acpiexec: Move an acpiexec specific purposed new line
 to acpiexec specific file
Date: Fri, 23 Sep 2016 06:49:59 +0000
Message-ID: <1474613366-23043-1-git-send-email-lv.zheng@intel.com>
In-Reply-To: 20160919101234.r2zfor37m7eq6k6p@pd.tnic
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0707396722381171324==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> No need, Robert did it already:
> =

> 1d435008fd9e ("Update an info message during table load phase.")

Not exactly what I meant. I meant the following on top of the above
mentioned commit. As the newline is an acpiexec specific logic, it should
be kept in acpiexec, shouldn't be left polluting a common file. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng(a)intel.com>
--
Index: acpica/source/components/tables/tbxfload.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- acpica.orig/source/components/tables/tbxfload.c
+++ acpica/source/components/tables/tbxfload.c
@@ -348,11 +348,6 @@ AcpiTbLoadNamespace (
         Status =3D AE_CTRL_TERMINATE;
     }
 =

-#ifdef ACPI_APPLICATION
-    ACPI_DEBUG_PRINT_RAW ((ACPI_DB_INIT, "\n"));
-#endif
-
-
 UnlockAndExit:
     (void) AcpiUtReleaseMutex (ACPI_MTX_TABLES);
     return_ACPI_STATUS (Status);
Index: acpica/source/tools/acpiexec/aetables.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- acpica.orig/source/tools/acpiexec/aetables.c
+++ acpica/source/tools/acpiexec/aetables.c
@@ -625,6 +625,7 @@ AeLoadTables (
 =

     Status =3D AcpiLoadTables ();
     ACPI_CHECK_OK (AcpiLoadTables, Status);
+    ACPI_DEBUG_PRINT_RAW ((ACPI_DB_INIT, "\n"));
 =

     /*
      * Test run-time control method installation. Do it twice to test code

--===============0707396722381171324==--

