Content-Type: multipart/mixed; boundary="===============1997431254185015643=="
MIME-Version: 1.0
From: Colin King <colin.king at canonical.com>
Subject: [Devel] [PATCH] acpixtract: use %u format specifier on unsigned int
 Gbl_TableCount
Date: Wed, 20 Apr 2016 10:04:45 +0100
Message-ID: <1461143085-12932-1-git-send-email-colin.king@canonical.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1997431254185015643==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Colin Ian King <colin.king(a)canonical.com>

Minor issue, Gbl_TableCount is an unsigned int, so we should be using
a %u format specifier instead of %d.

Signed-off-by: Colin Ian King <colin.king(a)canonical.com>
---
 source/tools/acpixtract/acpixtract.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/source/tools/acpixtract/acpixtract.c b/source/tools/acpixtract=
/acpixtract.c
index 3da6637..bb937a9 100644
--- a/source/tools/acpixtract/acpixtract.c
+++ b/source/tools/acpixtract/acpixtract.c
@@ -311,7 +311,7 @@ CleanupAndExit:
 =

     if (Gbl_TableCount > 1)
     {
-        printf ("\n%d binary ACPI tables extracted\n",
+        printf ("\n%u binary ACPI tables extracted\n",
             Gbl_TableCount);
     }
 =

@@ -455,7 +455,7 @@ CleanupAndExit:
             ThisSignature, ThisTableBytesWritten, Gbl_OutputFilename);
     }
 =

-    printf ("\n%d binary ACPI tables extracted and written to %s (%u bytes=
)\n",
+    printf ("\n%u binary ACPI tables extracted and written to %s (%u bytes=
)\n",
         Gbl_TableCount, Gbl_OutputFilename, TotalBytesWritten);
 =

     fclose (InputFile);
-- =

2.7.4


--===============1997431254185015643==--

