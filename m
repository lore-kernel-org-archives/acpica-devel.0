Content-Type: multipart/mixed; boundary="===============5716032475478457410=="
MIME-Version: 1.0
From: Neel Natu <neelnatu at gmail.com>
Subject: [Devel] Patch to override "Creator ID" and "Creator Revision"
Date: Mon, 11 Aug 2014 14:11:54 -0700
Message-ID: <CAFgRE9H3XFWaWROKhpiX8LCcOU0jSH5duEzzMrU2G=ACypJ0uA@mail.gmail.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5716032475478457410==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

The following patch allows the "Creator ID" and "Creator Revision" to
be overridden at compile time.

At the moment the "Creator Revision" is a stand-in for the compiler
version which implies that the tables change every time the compiler
version changes. This patch decouples "Creator Revision" from the
compiler version.

It would be great if this could be committed.

best
Neel

diff --git a/source/compiler/asldefine.h b/source/compiler/asldefine.h
index b05bd7f..6a15bf1 100644
--- a/source/compiler/asldefine.h
+++ b/source/compiler/asldefine.h
@@ -125,7 +125,9 @@
 #define ASL_COMPILER_NAME           "ASL Optimizing Compiler"
 #define AML_DISASSEMBLER_NAME       "AML Disassembler"
 #define ASL_INVOCATION_NAME         "iasl"
+#ifndef ASL_CREATOR_ID
 #define ASL_CREATOR_ID              "INTL"
+#endif

 #define ASL_COMPLIANCE              "Supports ACPI Specification Revision =
5.1"

diff --git a/source/include/acpixf.h b/source/include/acpixf.h
index cafc37b..005325c 100644
--- a/source/include/acpixf.h
+++ b/source/include/acpixf.h
@@ -118,7 +118,9 @@

 /* Current ACPICA subsystem version in YYYYMMDD format */

+#ifndef ACPI_CA_VERSION
 #define ACPI_CA_VERSION                 0x20140724
+#endif

 #include "acconfig.h"
 #include "actypes.h"

--===============5716032475478457410==--

