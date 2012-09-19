Content-Type: multipart/mixed; boundary="===============3557998461523408936=="
MIME-Version: 1.0
From: trenn at suse.de
Subject: [Devel] [patch 5/6] acpica: Fix unused result warning
Date: Wed, 19 Sep 2012 13:14:46 +0200
Message-ID: <20120919111905.721940677@ett.arch.suse.de>
In-Reply-To: 20120919111441.021908206@ett.arch.suse.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3557998461523408936==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As this is the only place where this warning
happens:
'write', declared with attribute warn_unused_result [-Werror=3Dunused-resul=
t]
it might be worth fixing instead of ignoring.

Signed-off-by: Thomas Renninger <trenn(a)suse.de>
---
 source/tools/acpisrc/asfile.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: acpica-unix2-20120913/source/tools/acpisrc/asfile.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- acpica-unix2-20120913.orig/source/tools/acpisrc/asfile.c
+++ acpica-unix2-20120913/source/tools/acpisrc/asfile.c
@@ -805,7 +805,11 @@ AsPutFile (
     /* Write the buffer to the file */
 =

     FileSize =3D strlen (FileBuffer);
-    write (DestHandle, FileBuffer, FileSize);
+    if (write (DestHandle, FileBuffer, FileSize) < 0) {
+        perror ("Could not write to destination file");
+        close (DestHandle);
+        return -1;
+    }
 =

     close (DestHandle);
 =



--===============3557998461523408936==--

