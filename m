Content-Type: multipart/mixed; boundary="===============4279759769949767659=="
MIME-Version: 1.0
From: Colin King <colin.king at canonical.com>
Subject: [Devel] [PATCH] Debugger: free Pathname on error return path to fix
 memory leak
Date: Tue, 13 Sep 2016 13:54:02 +0100
Message-ID: <20160913125402.9970-1-colin.king@canonical.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4279759769949767659==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Colin Ian King <colin.king(a)canonical.com>

On the error return path when AcpiGetObjectInfo fails the allocated
pathname is not free'd leading to a memory leak.  Free pathname
to fix this.

Signed-off-by: Colin Ian King <colin.king(a)canonical.com>
---
 source/components/debugger/dbmethod.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/source/components/debugger/dbmethod.c b/source/components/debu=
gger/dbmethod.c
index 5756ecb..22a66d1 100644
--- a/source/components/debugger/dbmethod.c
+++ b/source/components/debugger/dbmethod.c
@@ -551,6 +551,7 @@ AcpiDbWalkForExecute (
     Status =3D AcpiGetObjectInfo (ObjHandle, &ObjInfo);
     if (ACPI_FAILURE (Status))
     {
+        ACPI_FREE(Pathname);
         return (Status);
     }
 =

-- =

2.9.3


--===============4279759769949767659==--

