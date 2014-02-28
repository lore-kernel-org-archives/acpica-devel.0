Content-Type: multipart/mixed; boundary="===============6598552163781493935=="
MIME-Version: 1.0
From: Al Stone <ahs3 at redhat.com>
Subject: [Devel] [PATCH] minor correction for big endian machines
Date: Fri, 28 Feb 2014 09:05:31 -0700
Message-ID: <5310B3CB.8060906@redhat.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6598552163781493935==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When using the ASL files in the misc tests directory, I found a
case where a warning message printed out the table signature in
the wrong order on big endian machines.  The patch below fixes
the message so it works on little- or big-endian.

Signed-off-by: Al Stone <ahs3(a)redhat.com>


diff -urN acpica-unix2-20140214/source/compiler/asllookup.c =

acpica-unix2-20140214-patch/source/compiler/asllookup.c
--- acpica-unix2-20140214/source/compiler/asllookup.c	2014-02-14 =

16:23:33.000000000 -0700
+++ acpica-unix2-20140214-patch/source/compiler/asllookup.c	2014-02-27 =

11:50:52.168659866 -0700
@@ -120,6 +120,7 @@
  {
      ACPI_NAMESPACE_NODE     *Node =3D ACPI_CAST_PTR =

(ACPI_NAMESPACE_NODE, ObjHandle);
      ACPI_NAMESPACE_NODE     *Next;
+    ACPI_NAME_UNION         tmp;


      /* Referenced flag is set during the namespace xref */
@@ -163,8 +164,9 @@
               * Issue a remark even if it is a reserved name (starts
               * with an underscore).
               */
+            ACPI_MOVE_32_TO_32(&tmp.Ascii, Next->Name.Ascii);
              sprintf (MsgBuffer, "Name is within method [%4.4s]",
-                Next->Name.Ascii);
+                tmp.Ascii);
              AslError (ASL_REMARK, ASL_MSG_NOT_REFERENCED,
                  LkGetNameOp (Node->Op), MsgBuffer);
              return (AE_OK);
-- =

ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3(a)redhat.com
-----------------------------------

--===============6598552163781493935==--

