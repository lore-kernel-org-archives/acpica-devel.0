Content-Type: multipart/mixed; boundary="===============9162137612427851925=="
MIME-Version: 1.0
From: Jeremy Linton <jeremy.linton at arm.com>
Subject: [Devel] [RFC  0/3] arm64: SPE ACPI enablement
Date: Fri, 08 Feb 2019 18:47:15 -0600
Message-ID: <20190209004718.3292087-1-jeremy.linton@arm.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============9162137612427851925==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series enables the Arm Statistical
Profiling Extension (SPE) on ACPI platforms.

This is possible because ACPI 6.3 uses a previously
reserved field in the MADT to store the SPE interrupt
number, similarly to how the normal PMU is
described. If a consistent valid interrupt exists
across all the cores in the system, a platform
device is registered. That then triggers the SPE module,
which runs as normal.

Jeremy Linton (3):
  ACPICA: ACPI 6.3: Add MADT/GICC/SPE extension.
  arm_pmu: acpi: spe: Add initial MADT/SPE probing
  perf: arm_spe: Enable ACPI/Platform automatic module loading

 arch/arm64/include/asm/acpi.h |  4 +++
 drivers/perf/arm_pmu_acpi.c   | 67 +++++++++++++++++++++++++++++++++++
 drivers/perf/arm_spe_pmu.c    | 11 ++++--
 include/acpi/actbl2.h         |  5 +--
 4 files changed, 83 insertions(+), 4 deletions(-)

-- =

2.17.2


--===============9162137612427851925==--

