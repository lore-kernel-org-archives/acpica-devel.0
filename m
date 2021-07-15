Content-Type: multipart/mixed; boundary="===============2409870846524423270=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Re: [PATCH 1/2] ACPICA: Add new DBG2 Serial Port Subtypes
Date: Thu, 15 Jul 2021 14:07:28 +0000
Message-ID: <BYAPR11MB3256CACCFB4A08B5D450D3A087129@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: 20210714214346.1397942-2-mw@semihalf.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2409870846524423270==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This was already reported (with a patch that we've already merged) by semih=
alf-wojtas-marcin

-----Original Message-----
From: Marcin Wojtas <mw(a)semihalf.com> =

Sent: Wednesday, July 14, 2021 2:44 PM
To: linux-kernel(a)vger.kernel.org; linux-acpi(a)vger.kernel.org; devel(a)a=
cpica.org
Cc: jaz(a)semihalf.com; gjb(a)semihalf.com; upstream(a)semihalf.com; Samer.=
El-Haj-Mahmoud(a)arm.com; jon(a)solid-run.com; tn(a)semihalf.com; rjw(a)rjw=
ysocki.net; lenb(a)kernel.org; Moore, Robert <robert.moore(a)intel.com>; Ma=
rcin Wojtas <mw(a)semihalf.com>
Subject: [PATCH 1/2] ACPICA: Add new DBG2 Serial Port Subtypes

ACPICA commit d95c7d206b5836c7770e8e9cd613859887fded8f

The Microsoft Debug Port Table 2 (DBG2) specification revision September 21=
, 2020 comprises additional Serial Port Subtypes [1].
Reflect that in the actbl1.h header file.

[1] https://docs.microsoft.com/en-us/windows-hardware/drivers/bringup/acpi-=
debug-port-table

Link: https://github.com/acpica/acpica/commit/d95c7d20
Signed-off-by: Marcin Wojtas <mw(a)semihalf.com>
---
 include/acpi/actbl1.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h index ef2872dea0=
1c..7bbb3e2bd33f 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -482,7 +482,7 @@ struct acpi_csrt_descriptor {
  * DBG2 - Debug Port Table 2
  *        Version 0 (Both main table and subtables)
  *
- * Conforms to "Microsoft Debug Port Table 2 (DBG2)", December 10, 2015
+ * Conforms to "Microsoft Debug Port Table 2 (DBG2)", September 21, =

+ 2020
  *
  *************************************************************************=
*****/
 =

@@ -532,11 +532,24 @@ struct acpi_dbg2_device {
 =

 #define ACPI_DBG2_16550_COMPATIBLE  0x0000
 #define ACPI_DBG2_16550_SUBSET      0x0001
+#define ACPI_DBG2_MAX311XE_SPI      0x0002
 #define ACPI_DBG2_ARM_PL011         0x0003
+#define ACPI_DBG2_MSM8X60           0x0004
+#define ACPI_DBG2_16550_NVIDIA      0x0005
+#define ACPI_DBG2_TI_OMAP           0x0006
+#define ACPI_DBG2_APM88XXXX         0x0008
+#define ACPI_DBG2_MSM8974           0x0009
+#define ACPI_DBG2_SAM5250           0x000A
+#define ACPI_DBG2_INTEL_USIF        0x000B
+#define ACPI_DBG2_IMX6              0x000C
 #define ACPI_DBG2_ARM_SBSA_32BIT    0x000D
 #define ACPI_DBG2_ARM_SBSA_GENERIC  0x000E
 #define ACPI_DBG2_ARM_DCC           0x000F
 #define ACPI_DBG2_BCM2835           0x0010
+#define ACPI_DBG2_SDM845_1_8432MHZ  0x0011
+#define ACPI_DBG2_16550_WITH_GAS    0x0012
+#define ACPI_DBG2_SDM845_7_372MHZ   0x0013
+#define ACPI_DBG2_INTEL_LPSS        0x0014
 =

 #define ACPI_DBG2_1394_STANDARD     0x0000
 =

--
2.29.0

--===============2409870846524423270==--

