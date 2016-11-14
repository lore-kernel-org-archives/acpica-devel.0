Content-Type: multipart/mixed; boundary="===============4623963644297633186=="
MIME-Version: 1.0
From: Al Stone <ahs3 at redhat.com>
Subject: [Devel] [PATCH] ACPI: allow compilation with bare metal compilers
Date: Mon, 14 Nov 2016 16:08:46 -0700
Message-ID: <1479164926-1733-1-git-send-email-ahs3@redhat.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4623963644297633186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The ACPICA subsystem of the ACPI driver sets up a compilation environment
for itself, adding in multiple typedefs unique to ACPICA that depend on
where ACPICA will be used.

The vast majority of such environments (Linux, QNX, ...) have an environment
defined by the acenv.h header file.  When using a Linaro compiler [1]
specifically built to be used in an embedded environment with perhaps a
kernel and an init process as the only things running, there is no
environment defined for ACPICA so the typedefs it needs are not set up,
causing compilation to fail badly unless ACPI is completely disabled.
Since ACPI is enabled in the default config for the kernel, the compilation
failure is fairly obvious.

This may not be the optimal solution, but add in to the ACPI header file
include/acpi/platform/acenv.h a default so that if GCC is being used, and
all else fails, assume that we are going to be in a Linux-like environment
and re-use the environment definition for Linux.  This allows us to build
a kernel using this compiler [1] with or without ACPI.

[1] https://releases.linaro.org/components/toolchain/binaries/latest/aarch6=
4-elff/gcc-linaro-6.1.1-2016-08-x86_64_aarch64-elf.tar.xz

Signed-off-by: Al Stone <ahs3(a)redhat.com>
Cc: Rafael J. Wysocki <rjw(a)rjwysocki.net>
Cc: Len Brown <lenb(a)kernel.org>
Cc: Robert Moore <robert.moore(a)intel.com>
Cc: Lv Zheng <lv.zheng(a)intel.com>
---
 include/acpi/platform/acenv.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index 34cce72..cdd1cd6 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -234,6 +234,21 @@
 #elif defined(_AED_EFI) || defined(_GNU_EFI) || defined(_EDK2_EFI)
 #include "acefi.h"
 =

+/*
+ * Up to this point, we've been looking for specific environments.  In
+ * some cases, there is no environment, and we're just working on bare
+ * metal.  However, since we're compiling the Linux kernel, let's just
+ * pretend we're in a Linux environment.
+ */
+#elif defined(__GNUC__) && !defined(__INTEL_COMPILER)
+#if !defined(_LINUX)
+#define _LINUX
+#endif
+#if !defined(__linux__)
+#define __linux__
+#endif
+#include <acpi/platform/aclinux.h>
+
 #else
 =

 /* Unknown environment */
-- =

2.10.2


--===============4623963644297633186==--

