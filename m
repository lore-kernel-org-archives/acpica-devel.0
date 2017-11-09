Content-Type: multipart/mixed; boundary="===============0653915179517953352=="
MIME-Version: 1.0
From: Jeremy Linton <jeremy.linton at arm.com>
Subject: [Devel] [PATCH v4 4/9] ACPI: Enable PPTT support on ARM64
Date: Thu, 09 Nov 2017 15:03:06 -0600
Message-ID: <20171109210311.25655-5-jeremy.linton@arm.com>
In-Reply-To: 20171109210311.25655-1-jeremy.linton@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0653915179517953352==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now that we have a PPTT parser, in preparation for its use
on arm64, lets build it.

Signed-off-by: Jeremy Linton <jeremy.linton(a)arm.com>
---
 arch/arm64/Kconfig    | 1 +
 drivers/acpi/Kconfig  | 3 +++
 drivers/acpi/Makefile | 1 +
 3 files changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0df64a6a56d4..68c9d1289735 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -7,6 +7,7 @@ config ARM64
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ACPI_MCFG if ACPI
 	select ACPI_SPCR_TABLE if ACPI
+	select ACPI_PPTT if ACPI
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 1ce52f84dc23..fa8a7aeaaed9 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -533,6 +533,9 @@ config ACPI_CONFIGFS
 =

 if ARM64
 source "drivers/acpi/arm64/Kconfig"
+
+config ACPI_PPTT
+	bool
 endif
 =

 endif	# ACPI
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 90265ab4437a..c92a0c937551 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -85,6 +85,7 @@ obj-$(CONFIG_ACPI_BGRT)		+=3D bgrt.o
 obj-$(CONFIG_ACPI_CPPC_LIB)	+=3D cppc_acpi.o
 obj-$(CONFIG_ACPI_SPCR_TABLE)	+=3D spcr.o
 obj-$(CONFIG_ACPI_DEBUGGER_USER) +=3D acpi_dbg.o
+obj-$(CONFIG_ACPI_PPTT) 	+=3D pptt.o
 =

 # processor has its own "processor." module_param namespace
 processor-y			:=3D processor_driver.o
-- =

2.13.5


--===============0653915179517953352==--

