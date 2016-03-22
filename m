Content-Type: multipart/mixed; boundary="===============1915376729860843635=="
MIME-Version: 1.0
From: Colin King <colin.king at canonical.com>
Subject: [Devel] [PATCH] Check for failed string allocation and set Status
 accordingly
Date: Tue, 22 Mar 2016 22:16:32 +0000
Message-ID: <1458684992-10395-1-git-send-email-colin.king@canonical.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1915376729860843635==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Colin Ian King <colin.king(a)canonical.com>

It is possible that AcpiUtCreateStringObject fails to allocate a
string object, so check for this condition and set Status to
AE_NO_MEMORY to indicate a memory allocation failure.

Signed-off-by: Colin Ian King <colin.king(a)canonical.com>
---
 source/components/dispatcher/dsutils.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/source/components/dispatcher/dsutils.c b/source/components/dis=
patcher/dsutils.c
index 52e9ca8..124dc67 100644
--- a/source/components/dispatcher/dsutils.c
+++ b/source/components/dispatcher/dsutils.c
@@ -678,9 +678,15 @@ AcpiDsCreateOperand (
                     /* TBD: May only be temporary */
 =

                     ObjDesc =3D AcpiUtCreateStringObject ((ACPI_SIZE) Name=
Length);
-
-                    strncpy (ObjDesc->String.Pointer, NameString, NameLeng=
th);
-                    Status =3D AE_OK;
+                    if (!ObjDesc)
+                    {
+                        Status =3D AE_NO_MEMORY;
+                    }
+                    else
+                    {
+                        strncpy (ObjDesc->String.Pointer, NameString, Name=
Length);
+                        Status =3D AE_OK;
+                    }
                 }
                 else
                 {
-- =

2.7.3


--===============1915376729860843635==--

