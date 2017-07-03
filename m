Content-Type: multipart/mixed; boundary="===============4489350843719205585=="
MIME-Version: 1.0
From: Loc Ho <lho at apm.com>
Subject: [Devel] [PATCH v2 0/2] ACPI: SPCR: Use access width to determine mmio
 usage
Date: Mon, 03 Jul 2017 14:33:07 -0700
Message-ID: <1499117589-4829-1-git-send-email-lho@apm.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============4489350843719205585==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v2:
* Merged Jon Mason patch with APM X-Gene patch

Loc Ho (2):
  ACPI: SPCR: Use access width to determine mmio usage
  ACPI: SPCR: Workaround for APM X-Gene 8250 UART 32-alignment errata

 drivers/acpi/spcr.c     | 40 ++++++++++++++++++++++++++++++++++++++--
 include/acpi/acrestyp.h |  7 +++++++
 2 files changed, 45 insertions(+), 2 deletions(-)

-- =

1.8.3.1


--===============4489350843719205585==--

