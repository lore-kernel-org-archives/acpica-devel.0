Content-Type: multipart/mixed; boundary="===============7154678714820284269=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Re: [PATCH] ACPICA: macros should not use a trailing semicolon
Date: Tue, 13 Jul 2021 16:05:16 +0000
Message-ID: <BYAPR11MB3256BFA3E0749F609239FF4587149@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: 20210711064552.59735-1-denghuilong@cdjrlc.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============7154678714820284269==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Got it, thanks.
Bob


-----Original Message-----
From: Huilong Deng <denghuilong(a)cdjrlc.com> =

Sent: Saturday, July 10, 2021 11:46 PM
To: Moore, Robert <robert.moore(a)intel.com>; erik.kaneda(a)intel.com; Wyso=
cki, Rafael J <rafael.j.wysocki(a)intel.com>; lenb(a)kernel.org
Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org; linux-kernel(a)vger.k=
ernel.org; Huilong Deng <denghuilong(a)cdjrlc.com>
Subject: [PATCH] ACPICA: macros should not use a trailing semicolon

Macros should not use a trailing semicolon.

Signed-off-by: Huilong Deng <denghuilong(a)cdjrlc.com>
---
 include/acpi/acoutput.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h index 1b4c45=
815695..5a3875744678 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -415,7 +415,7 @@
 /* Conditional execution */
 =

 #define ACPI_DEBUG_EXEC(a)              a
-#define ACPI_DEBUG_ONLY_MEMBERS(a)      a;
+#define ACPI_DEBUG_ONLY_MEMBERS(a)      a
 #define _VERBOSE_STRUCTURES
 =

 /* Various object display routines for debug */
--
2.32.0



--===============7154678714820284269==--

