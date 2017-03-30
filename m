Content-Type: multipart/mixed; boundary="===============0686753285650103837=="
MIME-Version: 1.0
From: Al Stone <ahs3 at redhat.com>
Subject: [Devel] [PATCH] ACPICA: enable compilation for embedded Linux systems
Date: Thu, 30 Mar 2017 16:29:27 -0600
Message-ID: <efb72bc8-9d20-b587-21ec-d477a0e73d2a@redhat.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0686753285650103837==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The ACPICA subsystem of the ACPI driver sets up a compilation environment
for itself, adding in multiple typedefs unique to ACPICA that depend on
where ACPICA will be used.

The vast majority of such environments (Linux, QNX, ...) have an environment
defined in the acenv.h header file.  When using a Linaro compiler [1]
specifically built to be used in an embedded environment where perhaps a
kernel and an init process are the only things running, there is no
environment defined for ACPICA so the typedefs it needs are not set up
properly, causing compilation to fail unless ACPI is completely disabled.
Since ACPI is enabled in the default config for the kernel, the compilation
failure becomes fairly obvious [2].

Since building _for_ embedded Linux systems is slightly different than
building _in_ a Linux environment, define a new environment header
called acembed.h.  Compilers for these systems may not have the normal
defines a compiler for a Linux environment might, but they are very
close.  Then, we fix acenv.h so that when we are using GCC without GLIBC,
we select the embedded environment of acembed.h.

[1]
https://releases.linaro.org/components/toolchain/binaries/latest/aarch64-el=
ff/gcc-linaro-6.1.1-2016-08-x86_64_aarch64-elf.tar.xz
[2] This error was originally discovered by Will Deacon

Signed-off-by: Al Stone <ahs3(a)redhat.com>
Cc: Will Deacon <will.deacon(a)arm.com>
Cc: Rafael J. Wysocki <rjw(a)rjwysocki.net>
Cc: Len Brown <lenb(a)kernel.org>
Cc: Robert Moore <robert.moore(a)intel.com>
Cc: Lv Zheng <lv.zheng(a)intel.com>
---
 source/include/platform/acembed.h | 57 +++++++++++++++++++++++++++++++++++=
++++
 source/include/platform/acenv.h   | 11 ++++++++
 2 files changed, 68 insertions(+)
 create mode 100644 source/include/platform/acembed.h

diff --git a/source/include/platform/acembed.h b/source/include/platform/ac=
embed.h
new file mode 100644
index 0000000..e741f8d
--- /dev/null
+++ b/source/include/platform/acembed.h
@@ -0,0 +1,57 @@
+/*************************************************************************=
*****
+ *
+ * Name: acembed.h - OS specific defines, etc. for embedded Linux systems
+ *
+ *************************************************************************=
****/
+
+/*
+ * Copyright (C) 2017, Red Hat, Inc.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products deriv=
ed
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENT=
IAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#ifndef __ACEMBED_H__
+#define __ACEMBED_H__
+
+#if !defined(_LINUX)
+#define _LINUX
+#endif
+
+#if !defined(__linux__)
+#define __linux__
+#endif
+
+#include <acpi/platform/aclinux.h>
+
+#endif				/* __ACEMBED_H__ */
diff --git a/source/include/platform/acenv.h b/source/include/platform/acen=
v.h
index 5bec576..b300afa 100644
--- a/source/include/platform/acenv.h
+++ b/source/include/platform/acenv.h
@@ -343,6 +343,17 @@
 #elif defined(_AED_EFI) || defined(_GNU_EFI) || defined(_EDK2_EFI)
 #include "acefi.h"

+/*
+ * There are systems that run just a minimal Linux kernel; they have
+ * no user space and often extremely pared down configurations -- e.g.,
+ * a small embedded Linux system in a light bulb or other IoT device.
+ * In those cases, we're mostly a Linux system, but the compilers used
+ * may not be aware of that, so create an evironment specific to their
+ * needs.
+ */
+#elif defined(__GNUC__) && !defined(__INTEL_COMPILER) && !defined(__GLIBC_=
_)
+#include <acpi/platform/acembed.h>
+
 #else

 /* Unknown environment */
-- =

2.9.3


-- =

ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3(a)redhat.com
-----------------------------------

--===============0686753285650103837==--

