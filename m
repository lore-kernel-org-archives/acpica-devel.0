Content-Type: multipart/mixed; boundary="===============1586246037710409950=="
MIME-Version: 1.0
From: Jeremy Linton <jeremy.linton at arm.com>
Subject: [Devel] [PATCH v2 0/1] Disable FIE on machines with slow counters
Date: Thu, 28 Jul 2022 17:10:42 -0500
Message-ID: <20220728221043.4161903-1-jeremy.linton@arm.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1586246037710409950==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

FIE assumes the delivered/relative perf registers are fast to read so
it goes ahead and hits them quite frequently. On a couple Arm
platforms though they end up in PCC regions which require mailbox
handshaking with other parts of the platform.

This results in a lot of overhead in the cppc_fie task. As such lets
runtime disable FIE if we detect it enabled on one of those platforms.
Also allow the user to manually disable it via a module parameter.

v1->v2:
	Apply Rafael's review comments.
	Move the MODULE_PARAM into the ifdef
	Fix compiler warning when ACPI_CPPC_LIB is disabled.
	=

Jeremy Linton (1):
  ACPI: CPPC: Disable FIE if registers in PCC regions

 drivers/acpi/cppc_acpi.c       | 41 ++++++++++++++++++++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c | 19 ++++++++++++----
 include/acpi/cppc_acpi.h       |  5 +++++
 3 files changed, 61 insertions(+), 4 deletions(-)

-- =

2.35.3

--===============1586246037710409950==--

