Content-Type: multipart/mixed; boundary="===============3501562865918812637=="
MIME-Version: 1.0
From: Alex Hung <alex.hung at canonical.com>
Subject: [Devel] [PATCH] Tools: remove missing options in acpibin tool
Date: Wed, 02 May 2018 22:49:27 -0700
Message-ID: <1525326567-30528-1-git-send-email-alex.hung@canonical.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3501562865918812637==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The -e option is no longer avaiable in acpibin tool.

Signed-off-by: Alex Hung <alex.hung(a)canonical.com>
---
 source/tools/acpibin/abmain.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/source/tools/acpibin/abmain.c b/source/tools/acpibin/abmain.c
index 35e533c..1cf18c6 100644
--- a/source/tools/acpibin/abmain.c
+++ b/source/tools/acpibin/abmain.c
@@ -186,7 +186,6 @@ AbDisplayUsage (
     ACPI_OPTION ("-a <File1> <File2>",      "Compare two binary AML files,=
 dump all mismatches");
     ACPI_OPTION ("-c <File1> <File2>",      "Compare two binary AML files,=
 dump first 100 mismatches");
     ACPI_OPTION ("-d <In> <Out>",           "Dump AML binary to text file"=
);
-    ACPI_OPTION ("-e <Sig> <In> <Out>",     "Extract binary AML table from=
 acpidump file");
     ACPI_OPTION ("-o <Value>",              "Start comparison at this offs=
et into second file");
     ACPI_OPTION ("-h <File>",               "Display table header for bina=
ry AML file");
     ACPI_OPTION ("-s <File>",               "Update checksum for binary AM=
L file");
-- =

2.7.4


--===============3501562865918812637==--

