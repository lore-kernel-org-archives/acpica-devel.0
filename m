Content-Type: multipart/mixed; boundary="===============7108185839370239387=="
MIME-Version: 1.0
From: Colin King <colin.king at canonical.com>
Subject: [Devel] [PATCH] iASL: Predefine names: make argument errors more
 understandable
Date: Tue, 24 Jan 2017 12:58:54 +0000
Message-ID: <20170124125854.5349-1-colin.king@canonical.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7108185839370239387==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Colin Ian King <colin.king(a)canonical.com>

The current errors print out the number of arguments but is not clear
what these values mean. Clarify the error messages by specifically
mentioning that these refer to the number of arguments.  I took the
liberty to replace the %u and 0 with the text 'zero' to match the
style found in other similar error messages.

Signed-off-by: Colin Ian King <colin.king(a)canonical.com>
---
 source/compiler/aslpredef.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/source/compiler/aslpredef.c b/source/compiler/aslpredef.c
index 1218401..9dcc757 100644
--- a/source/compiler/aslpredef.c
+++ b/source/compiler/aslpredef.c
@@ -186,7 +186,7 @@ ApCheckForPredefinedMethod (
 =

         if (MethodInfo->NumArguments !=3D 0)
         {
-            sprintf (MsgBuffer, "%s requires %u", Op->Asl.ExternalName, 0);
+            sprintf (MsgBuffer, "%s requires zero arguments", Op->Asl.Exte=
rnalName);
 =

             AslError (ASL_WARNING, ASL_MSG_RESERVED_ARG_COUNT_HI, Op,
                 MsgBuffer);
@@ -208,7 +208,7 @@ ApCheckForPredefinedMethod (
 =

         if (MethodInfo->NumArguments !=3D RequiredArgCount)
         {
-            sprintf (MsgBuffer, "%4.4s requires %u",
+            sprintf (MsgBuffer, "%4.4s requires %u arguments",
                 ThisName->Info.Name, RequiredArgCount);
 =

             if (MethodInfo->NumArguments < RequiredArgCount)
-- =

2.10.2


--===============7108185839370239387==--

