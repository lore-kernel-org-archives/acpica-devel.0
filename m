Content-Type: multipart/mixed; boundary="===============6740593460289030130=="
MIME-Version: 1.0
From: Doc Holliday <doc4holliday at gmail.com>
Subject: [Devel] gcc 4.6 compatibility
Date: Mon, 12 Sep 2011 14:30:04 -0400
Message-ID: <CAFP2k92Q7m8zJ890FzwsmU3+A_jcShONhwmffL_CNy0Ch=dzPQ@mail.gmail.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6740593460289030130==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With gcc 4.6, I am getting following error:

i686-pc-linux-gnu-gcc -c -march=3Dcore2 -m32 -Os -pipe
-fomit-frame-pointer -D_LINUX -D_GNU_SOURCE -DACPI_ASL_COMPILER
-I../include -I../compiler -Wall -Werror -Wstrict-aliasing=3D0
-oaslcompilerlex.o aslcompilerlex.c
../compiler/aslcompiler.l: In function 'AslPopInputFileStack':
../compiler/aslcompiler.l:554:30: error: variable 'InputFile' set but
not used [-Werror=3Dunused-but-set-variable]

and

i686-pc-linux-gnu-gcc -c -march=3Dcore2 -m32 -Os -pipe
-fomit-frame-pointer -D_LINUX -D_GNU_SOURCE -DACPI_ASL_COMPILER
-I../include -I../compiler -ansi -Wall -Wbad-function-cast
-Wdeclaration-after-statement -Werror -Wformat=3D2
-Wmissing-declarations -Wmissing-prototypes -Wstrict-aliasing=3D0
-Wstrict-prototypes -Wswitch-default -Wpointer-arith -Wundef
-oosunixxf.o ../os_specific/service_layers/osunixxf.c
../os_specific/service_layers/osunixxf.c: In function 'AcpiOsVprintf':
../os_specific/service_layers/osunixxf.c:352:29: error: variable
'Count' set but not used [-Werror=3Dunused-but-set-variable]

Following patch fixes the problem, but I've only ran make inside
compiler dir, so there might be more:

--- acpica-unix-20110623/compiler/aslcompiler.l.orig	2011-09-12
13:44:26.130040812 -0400
+++ acpica-unix-20110623/compiler/aslcompiler.l	2011-09-12
13:46:36.116719238 -0400
@@ -550,7 +550,6 @@
     void)
 {
     ASL_FILE_NODE           *Fnode;
-    FILE                    *InputFile =3D NULL;


     Fnode =3D InputStack;
@@ -569,7 +568,6 @@
     /* Update the top-of-stack */

     InputStack =3D Fnode->Next;
-    InputFile =3D Fnode->File;

     /* Reset global line counter and filename */
--- acpica-unix-20110623/os_specific/service_layers/osunixxf.c.orig	2011-09=
-12
14:18:17.866891275 -0400
+++ acpica-unix-20110623/os_specific/service_layers/osunixxf.c	2011-09-12
14:19:46.230232603 -0400
@@ -349,7 +349,6 @@
     const char              *Fmt,
     va_list                 Args)
 {
-    INT32                   Count =3D 0;
     UINT8                   Flags;


@@ -362,7 +361,7 @@
         {
             /* Output file is open, send the output there */

-            Count =3D vfprintf (AcpiGbl_DebugFile, Fmt, Args);
+            vfprintf (AcpiGbl_DebugFile, Fmt, Args);
         }
         else
         {
@@ -374,7 +373,7 @@

     if (Flags & ACPI_DB_CONSOLE_OUTPUT)
     {
-        Count =3D vfprintf (AcpiGbl_OutputFile, Fmt, Args);
+        vfprintf (AcpiGbl_OutputFile, Fmt, Args);
     }
 }

--===============6740593460289030130==--

