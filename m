Content-Type: multipart/mixed; boundary="===============0950345649757647346=="
MIME-Version: 1.0
From: Colin King <colin.king at canonical.com>
Subject: [Devel] [PATCH] acpisrc: trivial fix to misaligned code indentation
Date: Tue, 06 Sep 2016 11:05:07 +0100
Message-ID: <20160906100507.2718-1-colin.king@canonical.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0950345649757647346==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Colin Ian King <colin.king(a)canonical.com>

Insert missing space to correct indentation

Signed-off-by: Colin Ian King <colin.king(a)canonical.com>
---
 source/tools/acpisrc/asfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/source/tools/acpisrc/asfile.c b/source/tools/acpisrc/asfile.c
index 51d1c69..07830c0 100644
--- a/source/tools/acpisrc/asfile.c
+++ b/source/tools/acpisrc/asfile.c
@@ -393,7 +393,7 @@ AsConvertFile (
         ConditionalTable    =3D ConversionTable->SourceConditionalTable;
         StructTable         =3D ConversionTable->SourceStructTable;
         SpecialMacroTable   =3D ConversionTable->SourceSpecialMacroTable;
-       break;
+        break;
 =

     case FILE_TYPE_HEADER:
 =

-- =

2.9.3


--===============0950345649757647346==--

