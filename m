Content-Type: multipart/mixed; boundary="===============4759486568256240276=="
MIME-Version: 1.0
From: Sudeep Holla <sudeep.holla at arm.com>
Subject: [Devel] [PATCH 0/3] ACPI: Add support for PCC Operation Region
Date: Tue, 02 Nov 2021 18:25:39 +0000
Message-ID: <20211102182542.3460787-1-sudeep.holla@arm.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4759486568256240276==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This series adds support for ACPI PCC OpRegion added in ACPI 6.3
I understand that the ACPICA changes need to go via different route,
but I am posting it together to give complete narative/picture for
the review/discussion.

Regards,
Sudeep

Sudeep Holla (3):
  ACPICA: Fix wrong interpretation of PCC address
  ACPICA: Add support for PCC Opregion special context data
  ACPI: PCC: Implement OperationRegion handler for the PCC Type 3 subtype

 drivers/acpi/Kconfig           |   5 ++
 drivers/acpi/Makefile          |   1 +
 drivers/acpi/acpica/evregion.c |  11 ++++
 drivers/acpi/acpica/exfield.c  |   7 +--
 drivers/acpi/bus.c             |   1 +
 drivers/acpi/pcc_opregion.c    | 111 +++++++++++++++++++++++++++++++++
 include/acpi/actypes.h         |   8 +++
 include/linux/acpi.h           |   6 ++
 8 files changed, 144 insertions(+), 6 deletions(-)
 create mode 100644 drivers/acpi/pcc_opregion.c

--
2.25.1

--===============4759486568256240276==--

