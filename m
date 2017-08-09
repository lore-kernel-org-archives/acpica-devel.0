Content-Type: multipart/mixed; boundary="===============2247321622378607016=="
MIME-Version: 1.0
From: Hanjun Guo <guohanjun at huawei.com>
Subject: [Devel] [PATCH] iasl: Add SMMUv3 device ID mapping index support
Date: Wed, 09 Aug 2017 19:11:57 +0800
Message-ID: <1502277117-64211-1-git-send-email-guohanjun@huawei.com>
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============2247321622378607016==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Hanjun Guo <hanjun.guo(a)linaro.org>

SMMUv3 device ID mapping index is used for SMMUv3
MSI, add its support for iasl.

Signed-off-by: Hanjun Guo <hanjun.guo(a)linaro.org>
---
 source/common/dmtbinfo.c | 1 +
 source/include/actbl2.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/source/common/dmtbinfo.c b/source/common/dmtbinfo.c
index 4b902b9..4a403e4 100644
--- a/source/common/dmtbinfo.c
+++ b/source/common/dmtbinfo.c
@@ -1850,6 +1850,7 @@ ACPI_DMTABLE_INFO           AcpiDmTableInfoIort4[] =
=3D
     {ACPI_DMT_UINT8,    ACPI_IORT4_OFFSET (Pxm),                    "Proxi=
mity Domain", 0},
     {ACPI_DMT_UINT8,    ACPI_IORT4_OFFSET (Reserved1),              "Reser=
ved", 0},
     {ACPI_DMT_UINT16,   ACPI_IORT4_OFFSET (Reserved2),              "Reser=
ved", 0},
+    {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (DevIdMappingIndex),      "Devic=
eID mapping index", 0},
     ACPI_DMT_TERMINATOR
 };
 =

diff --git a/source/include/actbl2.h b/source/include/actbl2.h
index 18cfdd4..1a8c1a2 100644
--- a/source/include/actbl2.h
+++ b/source/include/actbl2.h
@@ -1047,6 +1047,7 @@ typedef struct acpi_iort_smmu_v3
     UINT8                   Pxm;
     UINT8                   Reserved1;
     UINT16                  Reserved2;
+    UINT32                  DevIdMappingIndex;
 =

 } ACPI_IORT_SMMU_V3;
 =

-- =

1.7.12.4


--===============2247321622378607016==--

