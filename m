Content-Type: multipart/mixed; boundary="===============0494854742639436931=="
MIME-Version: 1.0
From: Colin King <colin.king at canonical.com>
Subject: [Devel] [PATCH] Core: trivial fix on indentation,
 remove extraneous white spaces
Date: Fri, 04 Mar 2016 00:24:34 +0000
Message-ID: <1457051074-26807-1-git-send-email-colin.king@canonical.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0494854742639436931==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Colin Ian King <colin.king(a)canonical.com>

Remove white spaces to correct the indentation. No functional change.

Signed-off-by: Colin Ian King <colin.king(a)canonical.com>
---
 source/components/namespace/nsload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/source/components/namespace/nsload.c b/source/components/names=
pace/nsload.c
index d33719f..70e0c11 100644
--- a/source/components/namespace/nsload.c
+++ b/source/components/namespace/nsload.c
@@ -212,7 +212,7 @@ AcpiNsLoadTable (
         (void) AcpiUtReleaseMutex (ACPI_MTX_NAMESPACE);
         AcpiNsDeleteNamespaceByOwner (
             AcpiGbl_RootTableList.Tables[TableIndex].OwnerId);
-            AcpiTbReleaseOwnerId (TableIndex);
+        AcpiTbReleaseOwnerId (TableIndex);
 =

         return_ACPI_STATUS (Status);
     }
-- =

2.7.0


--===============0494854742639436931==--

