Content-Type: multipart/mixed; boundary="===============8848689819406732346=="
MIME-Version: 1.0
From: Thomas Renninger <trenn at suse.de>
Subject: [Devel] [PATCH 4/4] ACPI: Add new table signatures that can be
 overridden/added.
Date: Tue, 18 Feb 2014 18:22:54 +0000
Message-ID: <1392747763-3384-5-git-send-email-trenn@suse.de>
In-Reply-To: 1392747763-3384-1-git-send-email-trenn@suse.de
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8848689819406732346==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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
 drivers/acpi/osl.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 07439b4..deba2f0 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -38,6 +38,7 @@
 #include <linux/delay.h>
 #include <linux/workqueue.h>
 #include <linux/nmi.h>
+# define ACPI_UNDEFINED_TABLES 1
 #include <linux/acpi.h>
 #include <linux/efi.h>
 #include <linux/ioport.h>
@@ -559,7 +560,8 @@ static const char * const table_sigs[] =3D {
 	ACPI_SIG_IBFT, ACPI_SIG_IVRS, ACPI_SIG_MCFG, ACPI_SIG_MCHI,
 	ACPI_SIG_SLIC, ACPI_SIG_SPCR, ACPI_SIG_SPMI, ACPI_SIG_TCPA,
 	ACPI_SIG_UEFI, ACPI_SIG_WAET, ACPI_SIG_WDAT, ACPI_SIG_WDDT,
-	ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT, ACPI_SIG_PSDT,
+	ACPI_SIG_WDRT, ACPI_SIG_BGRT, ACPI_SIG_ATKG, ACPI_SIG_GSCI,
+	ACPI_SIG_IEIT, ACPI_SIG_DSDT, ACPI_SIG_FADT, ACPI_SIG_PSDT,
 	ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT, NULL };
 =

 #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
-- =

1.7.6.1


--===============8848689819406732346==--

