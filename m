Content-Type: multipart/mixed; boundary="===============6860040309192357285=="
MIME-Version: 1.0
From: malattia at linux.it
Subject: [Devel] [patch 5/5] Fix building on GNU/Hurd
Date: Mon, 05 Jul 2010 21:03:29 +0900
Message-ID: <20100705120818.535578966@linux.it>
In-Reply-To: 20100705120324.581857151@linux.it
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6860040309192357285==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

gcc on GNU/Hurd defines __GNU__, use the same includes as __linux__ as afte=
r all
it runs with the same userspace.

Signed-off-by: Mattia Dongili <malattia(a)linux.it>
---
 include/platform/acenv.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/include/platform/acenv.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/platform/acenv.h	2010-07-04 11:18:17.506017933 +0900
+++ b/include/platform/acenv.h	2010-07-04 11:18:24.686018064 +0900
@@ -193,7 +193,7 @@
  *
  *************************************************************************=
****/
 =

-#if defined(_LINUX) || defined(__linux__)
+#if defined(_LINUX) || defined(__linux__) || defined(__GNU__)
 #include "aclinux.h"
 =

 #elif defined(__FreeBSD__) || defined(__FreeBSD_kernel__)


--===============6860040309192357285==--

