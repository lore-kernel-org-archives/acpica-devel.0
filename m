Content-Type: multipart/mixed; boundary="===============4271618359107566943=="
MIME-Version: 1.0
From: naresh.bhat at linaro.org
Subject: [Devel] [PATCH] ACPICA:enable 64bit build for aarch64 architecture
Date: Wed, 14 Aug 2013 13:15:09 +0530
Message-ID: <1376466309-14710-1-git-send-email-naresh.bhat@linaro.org>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4271618359107566943==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Naresh Bhat <naresh.bhat(a)linaro.org>

Signed-off-by: Naresh Bhat <naresh.bhat(a)linaro.org>

Enable 64 bit build for aarch64 architecture in ACPICA Linux
platform specific defines.
---
 source/include/platform/aclinux.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/source/include/platform/aclinux.h b/source/include/platform/ac=
linux.h
index e561292..6b8b1ab 100644
--- a/source/include/platform/aclinux.h
+++ b/source/include/platform/aclinux.h
@@ -159,7 +159,7 @@
 #define ACPI_FLUSH_CPU_CACHE()
 #define ACPI_CAST_PTHREAD_T(pthread) ((ACPI_THREAD_ID) (pthread))
 =

-#if defined(__ia64__) || defined(__x86_64__)
+#if defined(__ia64__) || defined(__x86_64__) || (__aarch64__)
 #define ACPI_MACHINE_WIDTH          64
 #define COMPILER_DEPENDENT_INT64    long
 #define COMPILER_DEPENDENT_UINT64   unsigned long
-- =

1.7.9.5


--===============4271618359107566943==--

