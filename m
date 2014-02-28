Content-Type: multipart/mixed; boundary="===============1635885783576966643=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: [Devel] [PATCH 3/4] ACPICA: Add BGRT signature to known signatures
Date: Fri, 28 Feb 2014 17:23:44 +0000
Message-ID: <1393608241-31037-4-git-send-email-trenn@suse.de>
In-Reply-To: 1393608241-31037-1-git-send-email-trenn@suse.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1635885783576966643==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In Linux there even exists a driver already making use of this table:
drivers/acpi/bgrt.c:MODULE_DESCRIPTION("BGRT boot graphic support");

Signed-off-by: Thomas Renninger <trenn(a)suse.de>
CC: hpa(a)zytor.com
CC: tglx(a)linutronix.de
CC: ck(a)conrad-kostecki.de
CC: linux-kernel(a)vger.kernel.org
CC: x86(a)kernel.org
CC: mingo(a)redhat.com
CC: rjw(a)rjwysocki.net
CC: devel(a)acpica.org
---
 include/acpi/actbl2.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 094a906..9ed1c20 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -83,6 +83,7 @@
 #define ACPI_SIG_WDAT           "WDAT"	/* Watchdog Action Table */
 #define ACPI_SIG_WDDT           "WDDT"	/* Watchdog Timer Description Table=
 */
 #define ACPI_SIG_WDRT           "WDRT"	/* Watchdog Resource Table */
+#define ACPI_SIG_BGRT           "BGRT"  /* Boot Graphic Support */
 =

 #ifdef ACPI_UNDEFINED_TABLES
 /*
-- =

1.7.6.1


--===============1635885783576966643==--

