Content-Type: multipart/mixed; boundary="===============4555122112842684712=="
MIME-Version: 1.0
From: Jeremy Linton <jeremy.linton at arm.com>
Subject: [Devel] [PATCH v4 0/2] Disable FIE on machines with slow counters
Date: Fri, 19 Aug 2022 11:25:45 -0500
Message-ID: <20220819162547.141333-1-jeremy.linton@arm.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4555122112842684712==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

FIE assumes the delivered/relative perf registers are fast to read so
it goes ahead and hits them quite frequently. On a couple Arm
platforms though they end up in PCC regions which require mailbox
handshaking with other parts of the platform.

This results in a lot of overhead in the cppc_fie task. As such lets
runtime disable FIE if we detect it enabled on one of those platforms.
Also allow the user to manually enable/disable it via a module parameter.

v1->v2:
	Apply Rafael's review comments.
	Move the MODULE_PARAM into the ifdef
	Fix compiler warning when ACPI_CPPC_LIB is disabled.
v2->v3:
	Tristate the module param so FIE can be forced on/off
	Bump pr_debug to pr_info if FIE is disabled due to PCC regions
	Switch ACPI_CPPC_CPUFREQ_FIE off by default
v3->v4:
	No functional change, resend due to email addr issues

Jeremy Linton (2):
  ACPI: CPPC: Disable FIE if registers in PCC regions
  cpufreq: CPPC: Change FIE default

 drivers/acpi/cppc_acpi.c       | 41 ++++++++++++++++++++++++++++++++++
 drivers/cpufreq/Kconfig.arm    |  2 +-
 drivers/cpufreq/cppc_cpufreq.c | 31 +++++++++++++++++++++----
 include/acpi/cppc_acpi.h       |  5 +++++
 4 files changed, 74 insertions(+), 5 deletions(-)

-- =

2.37.1

--===============4555122112842684712==--

