Content-Type: multipart/mixed; boundary="===============3584704515216883829=="
MIME-Version: 1.0
From: malattia at linux.it
Subject: [Devel] [patch 2/5] Small tweak to define uintptr_t and successfully
 build on debian/kfreebsd
Date: Mon, 05 Jul 2010 21:03:26 +0900
Message-ID: <20100705120817.782844519@linux.it>
In-Reply-To: 20100705120324.581857151@linux.it
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3584704515216883829==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is required to build on a FreeBSD kernel running with the GNU userspace
toolchain.

Signed-off-by: Mattia Dongili <malattia(a)linux.it>
---
 include/platform/acenv.h |    3 +++
 1 file changed, 3 insertions(+)

Index: b/include/platform/acenv.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/platform/acenv.h	2010-07-02 21:42:26.785349387 +0900
+++ b/include/platform/acenv.h	2010-07-04 11:18:37.250028892 +0900
@@ -182,6 +182,9 @@
 =

 =

 /*! [Begin] no source code translation */
+#if defined(__GLIBC__)
+#include <stdint.h>
+#endif
 =

 /*************************************************************************=
*****
  *


--===============3584704515216883829==--

