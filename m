Content-Type: multipart/mixed; boundary="===============6517955330853695940=="
MIME-Version: 1.0
From: Naresh Bhat <naresh.bhat at linaro.org>
Subject: [Devel] [PATCH 2/2] Resolve problem where -Werror fails to build when
 compiling iasl
Date: Wed, 08 May 2013 19:23:36 +0530
Message-ID: <1368021217-19585-3-git-send-email-naresh.bhat@linaro.org>
In-Reply-To: 1368021217-19585-1-git-send-email-naresh.bhat@linaro.org
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6517955330853695940==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Naresh Bhat <naresh.bhat(a)linaro.org>
Signed-off-by: Al Stone <ahs3(a)redhat.com>

While compiling ACPI test suite on ARM architecture got the following error
.
..
...
mits -o obj32/dtio.o ../../../source/compiler/dtio.c
../../../source/compiler/dtio.c: In function 'DtGetNextLine':
../../../source/compiler/dtio.c:516:9: error: comparison is always false du=
e to limited range of data type [-Werror=3Dtype-limits]
cc1: all warnings being treated as errors
make[1]: *** [obj32/dtio.o] Error 1
...
....
This patch will resolve problem where -Werror fails to build when compiling=
 iasl
---
 source/compiler/dtio.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/source/compiler/dtio.c b/source/compiler/dtio.c
index 724115c..1593afb 100644
--- a/source/compiler/dtio.c
+++ b/source/compiler/dtio.c
@@ -498,7 +498,7 @@ DtGetNextLine (
     UINT32                  State =3D DT_NORMAL_TEXT;
     UINT32                  CurrentLineOffset;
     UINT32                  i;
-    char                    c;
+    int                     c;
 =

 =

     for (i =3D 0; ;)
@@ -512,7 +512,7 @@ DtGetNextLine (
             UtExpandLineBuffers ();
         }
 =

-        c =3D (char) getc (Handle);
+        c =3D getc (Handle);
         if (c =3D=3D EOF)
         {
             switch (State)
-- =

1.7.9.5


--===============6517955330853695940==--

