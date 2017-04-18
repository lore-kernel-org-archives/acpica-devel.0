Content-Type: multipart/mixed; boundary="===============5047371621483287054=="
MIME-Version: 1.0
From: Colin King <colin.king at canonical.com>
Subject: [Devel] [PATCH] Remove redundant assignment to ObjectType
Date: Tue, 18 Apr 2017 22:13:13 +0100
Message-ID: <20170418211313.11343-1-colin.king@canonical.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5047371621483287054==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Colin Ian King <colin.king(a)canonical.com>

There are several occurrances of ObjectType being assigned
twice successively and the first assignment is clearly
unncessary and can hence be removed.  Remove the redundant
assignments.

Signed-off-by: Colin Ian King <colin.king(a)canonical.com>
---
 source/common/adwalk.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/source/common/adwalk.c b/source/common/adwalk.c
index 22fbfe416..1841772a7 100644
--- a/source/common/adwalk.c
+++ b/source/common/adwalk.c
@@ -747,7 +747,6 @@ AcpiDmLoadDescendingOp (
 =

     WalkState =3D Info->WalkState;
     OpInfo =3D AcpiPsGetOpcodeInfo (Op->Common.AmlOpcode);
-    ObjectType =3D OpInfo->ObjectType;
     ObjectType =3D AslMapNamedOpcodeToDataType (Op->Asl.AmlOpcode);
 =

     /* Only interested in operators that create new names */
@@ -885,7 +884,6 @@ AcpiDmXrefDescendingOp (
 =

     WalkState =3D Info->WalkState;
     OpInfo =3D AcpiPsGetOpcodeInfo (Op->Common.AmlOpcode);
-    ObjectType =3D OpInfo->ObjectType;
     ObjectType =3D AslMapNamedOpcodeToDataType (Op->Asl.AmlOpcode);
 =

     if ((!(OpInfo->Flags & AML_NAMED)) &&
@@ -1189,7 +1187,6 @@ AcpiDmCommonAscendingOp (
     /* Close scope if necessary */
 =

     OpInfo =3D AcpiPsGetOpcodeInfo (Op->Common.AmlOpcode);
-    ObjectType =3D OpInfo->ObjectType;
     ObjectType =3D AslMapNamedOpcodeToDataType (Op->Asl.AmlOpcode);
 =

     if (AcpiNsOpensScope (ObjectType))
-- =

2.11.0


--===============5047371621483287054==--

