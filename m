Content-Type: multipart/mixed; boundary="===============6773729523793595109=="
MIME-Version: 1.0
From: trenn at suse.de
Subject: [Devel] [patch 4/6] --- source/include/platform/aclinux.h | 2 +- 1
 file changed, 1 insertion(+), 1 deletion(-)
Date: Wed, 19 Sep 2012 13:14:45 +0200
Message-ID: <20120919111905.500896570@ett.arch.suse.de>
In-Reply-To: 20120919111441.021908206@ett.arch.suse.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6773729523793595109==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Index: acpica-unix2-20120518/source/include/platform/aclinux.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- acpica-unix2-20120518.orig/source/include/platform/aclinux.h
+++ acpica-unix2-20120518/source/include/platform/aclinux.h
@@ -98,7 +98,7 @@
 #define COMPILER_DEPENDENT_INT64    long long
 #define COMPILER_DEPENDENT_UINT64   unsigned long long
 #define ACPI_USE_NATIVE_DIVIDE
-#define ACPI_CAST_PTHREAD_T(pthread) ((ACPI_THREAD_ID) (UINT32) (void *) (=
pthread))
+#define ACPI_CAST_PTHREAD_T(pthread) ((ACPI_THREAD_ID) (UINT32) (pthread))
 #endif
 =

 #ifndef __cdecl


--===============6773729523793595109==--

