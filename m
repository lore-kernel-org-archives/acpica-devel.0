Content-Type: multipart/mixed; boundary="===============5740468152956945531=="
MIME-Version: 1.0
From: Jeremy Linton <jeremy.linton at arm.com>
Subject: [Devel] [PATCH v5 0/1] Disable FIE on machines with slow counters
Date: Mon, 12 Sep 2022 15:37:21 -0500
Message-ID: <20220912203722.205185-1-jeremy.linton@arm.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============5740468152956945531==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

FIE assumes the delivered/relative perf registers are fast to read so
it goes ahead and hits them quite frequently. On a couple of Arm
platforms though they end up in PCC regions which require mailbox
handshaking with other parts of the platform.

This results in a lot of overhead in the cppc_fie task. As such lets
runtime disable FIE if we detect it enabled on one of those platforms.
Lastly, allow the user to override this decision via a module parameter.

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

v4->v5:
	Minor whitespace, comment wording, if/case conversion
	Drop the ACPI_CPPC_CPUFREQ_FIE disable config change added in v3

Jeremy Linton (1):
  ACPI: CPPC: Disable FIE if registers in PCC regions

 drivers/acpi/cppc_acpi.c       | 42 ++++++++++++++++++++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c | 25 ++++++++++++++++----
 include/acpi/cppc_acpi.h       |  5 ++++
 3 files changed, 68 insertions(+), 4 deletions(-)

-- =

2.37.1

--===============5740468152956945531==--

