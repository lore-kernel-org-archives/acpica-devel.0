Content-Type: multipart/mixed; boundary="===============5956783738874527313=="
MIME-Version: 1.0
From: Colin King <colin.king at canonical.com>
Subject: [Devel] [PATCH] Core: trivial fix on indentation, missing white space
Date: Fri, 04 Mar 2016 00:18:52 +0000
Message-ID: <1457050732-26641-1-git-send-email-colin.king@canonical.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5956783738874527313==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Colin Ian King <colin.king(a)canonical.com>

Add in an extra white space to correct the indentation. No
functional change.

Signed-off-by: Colin Ian King <colin.king(a)canonical.com>
---
 source/components/executer/exsystem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/source/components/executer/exsystem.c b/source/components/exec=
uter/exsystem.c
index b8fbdd7..ef64344 100644
--- a/source/components/executer/exsystem.c
+++ b/source/components/executer/exsystem.c
@@ -166,7 +166,7 @@ AcpiExSystemWaitSemaphore (
 =

         /* Reacquire the interpreter */
 =

-       AcpiExEnterInterpreter ();
+        AcpiExEnterInterpreter ();
     }
 =

     return_ACPI_STATUS (Status);
-- =

2.7.0


--===============5956783738874527313==--

