Content-Type: multipart/mixed; boundary="===============5120365100002830493=="
MIME-Version: 1.0
From: Dean Nelson <dnelson at redhat.com>
Subject: [Devel] [PATCH] eliminate use after free in AcpiOsGetNextFilename()
Date: Tue, 19 Nov 2013 11:41:06 -0500
Message-ID: <20131119164152.4957.33932.email-sent-by-dnelson@teal>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5120365100002830493==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

AcpiOsGetNextFilename() references temp_str in an unlikely error path, after
having freed the memory allocated for it.

Signed-off-by: Dean Nelson <dnelson(a)redhat.com>
---
 source/os_specific/service_layers/osunixdir.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/source/os_specific/service_layers/osunixdir.c b/source/os_spec=
ific/service_layers/osunixdir.c
index 02b347d..ef2a924 100644
--- a/source/os_specific/service_layers/osunixdir.c
+++ b/source/os_specific/service_layers/osunixdir.c
@@ -239,14 +239,15 @@ AcpiOsGetNextFilename (
             strcat (temp_str, dir_entry->d_name);
 =

             err =3D stat (temp_str, &temp_stat);
-            free (temp_str);
             if (err =3D=3D -1)
             {
                 fprintf (stderr,
                     "Cannot stat file (should not happen) - %s\n",
                     temp_str);
+                free (temp_str);
                 return (NULL);
             }
+            free (temp_str);
 =

             if ((S_ISDIR (temp_stat.st_mode)
                 && (ExternalInfo->RequestedFileType =3D=3D REQUEST_DIR_ONL=
Y))

--===============5120365100002830493==--

