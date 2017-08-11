Content-Type: multipart/mixed; boundary="===============1174548880789216877=="
MIME-Version: 1.0
From: Lv Zheng <lv.zheng at intel.com>
Subject: [Devel] [PATCH 0/2] ACPICA: Events: Fix GPE enabling issues related
 to edge-triggered GPEs
Date: Fri, 11 Aug 2017 13:57:23 +0800
Message-ID: <cover.1502430636.git.lv.zheng@intel.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============1174548880789216877==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There are 2 issues related to the enabling of GPEs:
1. Currently, our code clears GPE before enabling it. In case of edge
   triggered GPEs, doing this risks GPE losses.
2. For edge-triggered GPEs, enabling it is not sufficiently to trigger an
   already triggered GPE, we need to poll the GPE once it is enabled.
This patchset fixes these 2 problems.

Lv Zheng (2):
  ACPICA: Events: Stop unconditionally clearing ACPI IRQs during
    suspend/resume
  ACPICA: Events: Dispatch GPEs after enabling for the first time

 drivers/acpi/acpica/evgpe.c     |  7 -------
 drivers/acpi/acpica/evxfgpe.c   | 22 ++++++++++++++++++++++
 drivers/acpi/acpica/hwgpe.c     |  1 -
 drivers/acpi/acpica/hwsleep.c   | 11 ++---------
 drivers/acpi/acpica/hwxfsleep.c |  2 +-
 5 files changed, 25 insertions(+), 18 deletions(-)

-- =

2.7.4


--===============1174548880789216877==--

