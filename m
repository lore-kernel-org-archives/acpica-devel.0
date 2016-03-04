Content-Type: multipart/mixed; boundary="===============9003212941862217917=="
MIME-Version: 1.0
From: Colin King <colin.king at canonical.com>
Subject: [Devel] [PATCH] compiler: trivial fix on indentation,
 missing white space
Date: Fri, 04 Mar 2016 00:12:40 +0000
Message-ID: <1457050360-26338-1-git-send-email-colin.king@canonical.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============9003212941862217917==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Colin Ian King <colin.king(a)canonical.com>

Add in an extra white space to correct the indentation. No
functional change.

Signed-off-by: Colin Ian King <colin.king(a)canonical.com>
---
 source/compiler/aslrestype2e.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/source/compiler/aslrestype2e.c b/source/compiler/aslrestype2e.c
index 1d91913..9288a95 100644
--- a/source/compiler/aslrestype2e.c
+++ b/source/compiler/aslrestype2e.c
@@ -215,7 +215,7 @@ RsDoExtendedIoDescriptor (
             RsCreateQwordField (InitializerOp, ACPI_RESTAG_GRANULARITY,
                 CurrentByteOffset + ASL_RESDESC_OFFSET (ExtAddress64.Granu=
larity));
             GranOp =3D InitializerOp;
-           break;
+            break;
 =

         case 6: /* Address Min */
 =

-- =

2.7.0


--===============9003212941862217917==--

