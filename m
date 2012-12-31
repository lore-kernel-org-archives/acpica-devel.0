Content-Type: multipart/mixed; boundary="===============6866888644212804777=="
MIME-Version: 1.0
From: Lv Zheng <lv.zheng at intel.com>
Subject: [Devel] [PATCH 1/3] ACPICA: Cleanup PM_TIMER_FREQUENCY definition.
Date: Mon, 31 Dec 2012 08:25:42 +0800
Message-ID: <086d3d8b003a7c43cdacfd4efdd08253c0c3aa4d.1356871667.git.lv.zheng@intel.com>
In-Reply-To: cover.1356871667.git.lv.zheng@intel.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============6866888644212804777==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a cosmetic patch only. Comparison of the resulting binary showed
only line number differences.

This patch does not affect the generation of the Linux binary.
This patch decreases 13 lines of 20121114 divergence.diff.

There is updates in ACPICA for PM_TIMER_FREQUENCY macro, this patch cleans
up the usage of this macro in Linux. This patch can also reduce the source
code diff between Linux and ACPICA.

Signed-off-by: Lv Zheng <lv.zheng(a)intel.com>
---
Binary comparision result:
  Changes can be found are caused by the line folding:
  -c153f6f9:	68 e6 04 00 00       	push   $0x4e6
  +c153f6f9:	68 e7 04 00 00       	push   $0x4e7
  drivers/acpi/processor_idle.c(1255-1): acpi_processor_power_init
  ACPI_EXCEPTION -> AE_INFO -> __LINE__
---
Divergences fixing result:
  Before applying: 1976 Lines, 70.5 Kbytes
  After applying: 1963 Lines, 70.0 Kbytes
---
 drivers/acpi/processor_idle.c |    5 +++--
 include/acpi/actypes.h        |    4 ----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index e8086c7..2b4ce29 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -64,10 +64,11 @@
 #define ACPI_PROCESSOR_CLASS            "processor"
 #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_idle");
-#define PM_TIMER_TICK_NS		(1000000000ULL/PM_TIMER_FREQUENCY)
+#define PM_TIMER_TICK_NS		(1000000000ULL/ACPI_PM_TIMER_FREQUENCY)
 #define C2_OVERHEAD			1	/* 1us */
 #define C3_OVERHEAD			1	/* 1us */
-#define PM_TIMER_TICKS_TO_US(p)		(((p) * 1000)/(PM_TIMER_FREQUENCY/1000))
+#define PM_TIMER_TICKS_TO_US(p)		\
+	(((p) * 1000)/(ACPI_PM_TIMER_FREQUENCY/1000))
 =

 static unsigned int max_cstate __read_mostly =3D ACPI_PROCESSOR_MAX_POWER;
 module_param(max_cstate, uint, 0000);
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 796a63e..cd89810 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -405,10 +405,6 @@ typedef u8 acpi_owner_id;
 #define ACPI_MAX16_DECIMAL_DIGITS        5
 #define ACPI_MAX8_DECIMAL_DIGITS         3
 =

-/* PM Timer ticks per second (HZ) */
-
-#define PM_TIMER_FREQUENCY  3579545
-
 /*
  * Constants with special meanings
  */
-- =

1.7.10


--===============6866888644212804777==--

