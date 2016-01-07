Content-Type: multipart/mixed; boundary="===============7490088588507006346=="
MIME-Version: 1.0
From: Colin King <colin.king at canonical.com>
Subject: [Devel] [PATCH] compiler: remove unnecessary zero check on Length
 before zero'ing it
Date: Thu, 07 Jan 2016 10:21:17 +0000
Message-ID: <1452162077-12119-1-git-send-email-colin.king@canonical.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7490088588507006346==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Colin Ian King <colin.king(a)canonical.com>

Length is being checked to see if the contents is non-zero before
setting it to zero. It would be simpler to just set this to zero
without doing the non-zero check as it saves a load and a jmp
(~14 bytes in x86 object code). This also fixes a static analysis
warning in DtCompileIort:

CID 1298707 (#1 of 1): Uninitialized scalar variable (UNINIT).
  uninit_use_in_call: Using uninitialized value PaddingLength
  when calling DtCompileGeneric.

..since the length is not being intitialized in this code before
calling DtCompileGeneric.

Signed-off-by: Colin Ian King <colin.king(a)canonical.com>
---
 source/compiler/dttable2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/source/compiler/dttable2.c b/source/compiler/dttable2.c
index b281b5c..1add6f7 100644
--- a/source/compiler/dttable2.c
+++ b/source/compiler/dttable2.c
@@ -1707,7 +1707,7 @@ DtCompileGeneric (
 =

     /* Now we can actually compile the parse tree */
 =

-    if (Length && *Length)
+    if (Length)
     {
         *Length =3D 0;
     }
-- =

2.7.0.rc3


--===============7490088588507006346==--

