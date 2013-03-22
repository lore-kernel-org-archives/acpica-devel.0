Content-Type: multipart/mixed; boundary="===============6628739392389427909=="
MIME-Version: 1.0
From: Al Stone <ahs3 at redhat.com>
Subject: [Devel] [PATCH] faulty name compares on big-endian machines
Date: Thu, 21 Mar 2013 19:02:28 -0600
Message-ID: <514BADA4.5070901@redhat.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6628739392389427909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When iasl is checking for GPE name conflicts on big-endian machines,
the comparisons will fail when they should succeed.

The failure is due to the name bytes being in the wrong order.  The
bytes are in the wrong order because the name is being treated as a
32-bit integer and not as a string.

This patch causes the name to be used as a string and works properly
on big- and little-endian machines running iasl.

This was found by running tests/misc/badcode.asl through iasl on a
big-endian machine (PPC and s390) and noting that it would not catch
the error at line 184 in badcode.asl that was being caught elsewhere.


Signed-off-by: Al Stone <ahs3(a)redhat.com>
--
source/compiler/aslanalyze.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/source/compiler/aslanalyze.c b/source/compiler/aslanalyze.c
index 99b17e6..bd6272a 100644
--- a/source/compiler/aslanalyze.c
+++ b/source/compiler/aslanalyze.c
@@ -516,7 +516,7 @@ ApCheckForGpeNameConflict (

      /* Need a null-terminated string version of NameSeg */

-    ACPI_MOVE_32_TO_32 (Name, &Op->Asl.NameSeg);
+    ACPI_MOVE_NAME (Name, &Op->Asl.NameSeg);
      Name[ACPI_NAME_SIZE] =3D 0;

      /*
@@ -543,7 +543,7 @@ ApCheckForGpeNameConflict (
       * We are now sure we have an _Lxx or _Exx.
       * Create the target name that would cause collision (Flip E/L)
       */
-    ACPI_MOVE_32_TO_32 (Target, Name);
+    ACPI_MOVE_NAME (Target, Name);

      /* Inject opposite letter ("L" versus "E") */

-- =

ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3(a)redhat.com
-----------------------------------

--===============6628739392389427909==--

