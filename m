Content-Type: multipart/mixed; boundary="===============0427495873067363737=="
MIME-Version: 1.0
From: Jeremy Linton <jeremy.linton at arm.com>
Subject: [Devel] [PATCH v4 2/2] cpufreq: CPPC: Change FIE default
Date: Fri, 19 Aug 2022 11:25:47 -0500
Message-ID: <20220819162547.141333-3-jeremy.linton@arm.com>
In-Reply-To: 20220819162547.141333-1-jeremy.linton@arm.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============0427495873067363737==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

FIE is mostly implemented as PCC mailboxes on arm machines.  This was
enabled by default without any data suggesting that it does anything
but hurt system performance. Lets change the default to 'n' until
hardware appears which clearly benefits.

Signed-off-by: Jeremy Linton <jeremy.linton(a)arm.com>
---
 drivers/cpufreq/Kconfig.arm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 954749afb5fe..ad66d8f15db0 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -22,7 +22,7 @@ config ACPI_CPPC_CPUFREQ
 config ACPI_CPPC_CPUFREQ_FIE
 	bool "Frequency Invariance support for CPPC cpufreq driver"
 	depends on ACPI_CPPC_CPUFREQ && GENERIC_ARCH_TOPOLOGY
-	default y
+	default n
 	help
 	  This extends frequency invariance support in the CPPC cpufreq driver,
 	  by using CPPC delivered and reference performance counters.
-- =

2.37.1

--===============0427495873067363737==--

