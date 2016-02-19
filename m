Content-Type: multipart/mixed; boundary="===============3396183862270952420=="
MIME-Version: 1.0
From: Colin King <colin.king at canonical.com>
Subject: [Devel] [PATCH] iASL/Disassembler: nullify AcpiGbl_ParseOpRoot after
 deleting parse tree
Date: Fri, 19 Feb 2016 14:52:51 +0000
Message-ID: <1455893571-1795-1-git-send-email-colin.king@canonical.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3396183862270952420==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Colin Ian King <colin.king(a)canonical.com>

On i386 platforms with glibc 2.21 and gcc 6.0 I'm getting double
frees on the heap when disassembling with iASL using multiple
external tables.  The current code deletes the parse tree from the
AcpiGbl_ParseOpRoot and not NULLifying it afterwards, causing
subsequent tree parsing to re-add existing heap objects back onto
this root node causing subsequent parse tree deletes to trip the
double free.

Interestingly, this seems to only happen in some configurations so
I believe it works on 64 bit x86 and not 32 bit because of heap
differences in the libc allocator.

Signed-off-by: Colin Ian King <colin.king(a)canonical.com>
---
 source/common/adisasm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/source/common/adisasm.c b/source/common/adisasm.c
index 3dabe3b..520863c 100644
--- a/source/common/adisasm.c
+++ b/source/common/adisasm.c
@@ -700,6 +700,7 @@ AdDoExternalFileList (
             AcpiDmFinishNamespaceLoad (AcpiGbl_ParseOpRoot,
                 AcpiGbl_RootNode, OwnerId);
             AcpiPsDeleteParseTree (AcpiGbl_ParseOpRoot);
+            AcpiGbl_ParseOpRoot =3D NULL;
 =

             ExternalListHead =3D ExternalListHead->Next;
         }
-- =

2.7.0


--===============3396183862270952420==--

