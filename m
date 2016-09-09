Content-Type: multipart/mixed; boundary="===============4792341969290030159=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: Re: [Devel] [PATCH] ACPICA / Interpreter: Remove redundant newline
Date: Fri, 09 Sep 2016 18:45:23 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E4F34E9@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 94F2FBAB4432B54E8AACC7DFDE6C92E37E4F34B4@ORSMSX110.amr.corp.intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4792341969290030159==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Well, I never thought I would write a couple lines of code like this, but h=
ere is a solution that should make everyone happy.

diff --git a/source/components/tables/tbxfload.c b/source/components/tables=
/tbxfload.c
index 6a937b1..73ee1a2 100644
--- a/source/components/tables/tbxfload.c
+++ b/source/components/tables/tbxfload.c
@@ -334,7 +334,7 @@ AcpiTbLoadNamespace (
     if (!TablesFailed)
     {
         ACPI_INFO ((
-            "%u ACPI AML tables successfully acquired and loaded\n",
+            "%u ACPI AML tables successfully acquired and loaded",
             TablesLoaded));
     }
     else
@@ -348,6 +348,11 @@ AcpiTbLoadNamespace (
         Status =3D AE_CTRL_TERMINATE;
     }
 =

+#ifdef ACPI_APPLICATION
+    ACPI_DEBUG_PRINT_RAW ((ACPI_DB_INIT, "\n"));
+#endif
+
+
 UnlockAndExit:
     (void) AcpiUtReleaseMutex (ACPI_MTX_TABLES);
     return_ACPI_STATUS (Status);


--===============4792341969290030159==--

