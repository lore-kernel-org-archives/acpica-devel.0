Content-Type: multipart/mixed; boundary="===============7109538748604995493=="
MIME-Version: 1.0
From: Colin King <colin.king at canonical.com>
Subject: [Devel] [PATCH] Linux-specific header: Add support for s390x
 compilation.
Date: Wed, 30 Nov 2016 13:16:27 +0000
Message-ID: <20161130131627.25030-2-colin.king@canonical.com>
In-Reply-To: 20161130131627.25030-1-colin.king@canonical.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7109538748604995493==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Colin Ian King <colin.king(a)canonical.com>

Adds s390x as a 64-bit architecture.

Signed-off-by: Colin Ian King <colin.king(a)canonical.com>
---
 source/include/platform/aclinux.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/source/include/platform/aclinux.h b/source/include/platform/ac=
linux.h
index 6f7c577..9d0927b 100644
--- a/source/include/platform/aclinux.h
+++ b/source/include/platform/aclinux.h
@@ -265,7 +265,8 @@
 #define ACPI_CAST_PTHREAD_T(Pthread) ((ACPI_THREAD_ID) (Pthread))
 =

 #if defined(__ia64__)    || defined(__x86_64__) ||\
-    defined(__aarch64__) || defined(__PPC64__)
+    defined(__aarch64__) || defined(__PPC64__) ||\
+    defined(__s390x__)
 #define ACPI_MACHINE_WIDTH          64
 #define COMPILER_DEPENDENT_INT64    long
 #define COMPILER_DEPENDENT_UINT64   unsigned long
-- =

2.10.2


--===============7109538748604995493==--

