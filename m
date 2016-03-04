Content-Type: multipart/mixed; boundary="===============2150397264211164890=="
MIME-Version: 1.0
From: Colin King <colin.king at canonical.com>
Subject: [Devel] [PATCH] Core: trivial fix on indentation,
 remove extraneous white space
Date: Fri, 04 Mar 2016 00:26:55 +0000
Message-ID: <1457051215-26878-1-git-send-email-colin.king@canonical.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2150397264211164890==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Colin Ian King <colin.king(a)canonical.com>

Remove white space to correct the indentation. No functional change.

Signed-off-by: Colin Ian King <colin.king(a)canonical.com>
---
 source/components/namespace/nsprepkg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/source/components/namespace/nsprepkg.c b/source/components/nam=
espace/nsprepkg.c
index aad9de0..f83b1c7 100644
--- a/source/components/namespace/nsprepkg.c
+++ b/source/components/namespace/nsprepkg.c
@@ -438,8 +438,8 @@ AcpiNsCheckPackage (
 =

             Elements +=3D 2;
             Count -=3D 2;
-         }
-         break;
+        }
+        break;
 =

     default:
 =

-- =

2.7.0


--===============2150397264211164890==--

