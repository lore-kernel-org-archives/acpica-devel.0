Content-Type: multipart/mixed; boundary="===============4645346502092693621=="
MIME-Version: 1.0
From: Besar Wicaksono <bwicaksono at nvidia.com>
Subject: [Devel] [PATCH 0/2] ACPI: ARM CoreSight Performance Monitoring Unit
Date: Tue, 19 Apr 2022 15:54:30 -0500
Message-ID: <20220419205432.46021-1-bwicaksono@nvidia.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4645346502092693621==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patchset adds support for ARM CoreSight PMU device.
Specifications for ARM Performance Monitoring Unit table (APMT) and
ARM CoreSight PMU:
 * APMT: https://developer.arm.com/documentation/den0117/latest
 * ARM Coresight PMU:
        https://developer.arm.com/documentation/ihi0091/latest

The patchset applies on top of
  git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

Besar Wicaksono (2):
  ACPICA: Add support for ARM Performance Monitoring Unit Table.
  ACPI: ARM Performance Monitoring Unit Table (APMT) initial support

 arch/arm64/Kconfig          |   1 +
 drivers/acpi/arm64/Kconfig  |   3 +
 drivers/acpi/arm64/Makefile |   1 +
 drivers/acpi/arm64/apmt.c   | 176 ++++++++++++++++++++++++++++++++++++
 drivers/acpi/bus.c          |   2 +
 include/acpi/actbl2.h       |  81 +++++++++++++++++
 include/linux/acpi_apmt.h   |  19 ++++
 7 files changed, 283 insertions(+)
 create mode 100644 drivers/acpi/arm64/apmt.c
 create mode 100644 include/linux/acpi_apmt.h

-- =

2.17.1

--===============4645346502092693621==--

