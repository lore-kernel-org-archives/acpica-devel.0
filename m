Content-Type: multipart/mixed; boundary="===============3915790917844610174=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Re: [PATCH] [ACPICA] IORT: Fix HTTU Override mask for the
 SMMUv3 subtable
Date: Thu, 25 Feb 2021 20:45:54 +0000
Message-ID: <BYAPR11MB3256E28FD567C5FEB0EDCA94879E9@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: 20210225112620.1827-1-yuzenghui@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3915790917844610174==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the field is two bits, I think the ACPI_DMT_* symbol should be ACPI_DMT_=
FLAGS2, not ACPI_DMT_FLAGS1

-----Original Message-----
From: Zenghui Yu <yuzenghui(a)huawei.com> =

Sent: Thursday, February 25, 2021 3:26 AM
To: devel(a)acpica.org; linux-acpi(a)vger.kernel.org
Cc: Moore, Robert <robert.moore(a)intel.com>; Kaneda, Erik <erik.kaneda(a)i=
ntel.com>; robin.murphy(a)arm.com; Wysocki, Rafael J <rafael.j.wysocki(a)in=
tel.com>; guohanjun(a)huawei.com; wanghaibin.wang(a)huawei.com; Zenghui Yu =
<yuzenghui(a)huawei.com>; Kunkun Jiang <jiangkunkun(a)huawei.com>
Subject: [PATCH] [ACPICA] IORT: Fix HTTU Override mask for the SMMUv3 subta=
ble

As per the IORT spec, this field overrides the value in SMMU_IRD0.HTTU whic=
h should always have been 2 bits.

Fixes: 9f7c3e148f44 ("IORT: Add in support for the SMMUv3 subtable")
Reported-by: Kunkun Jiang <jiangkunkun(a)huawei.com>
Signed-off-by: Zenghui Yu <yuzenghui(a)huawei.com>
---
 source/common/dmtbinfo2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/source/common/dmtbinfo2.c b/source/common/dmtbinfo2.c index 17=
a80ba21..321f106fa 100644
--- a/source/common/dmtbinfo2.c
+++ b/source/common/dmtbinfo2.c
@@ -343,7 +343,7 @@ ACPI_DMTABLE_INFO           AcpiDmTableInfoIort4[] =3D
     {ACPI_DMT_UINT64,   ACPI_IORT4_OFFSET (BaseAddress),            "Base =
Address", 0},
     {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (Flags),                  "Flags=
 (decoded below)", 0},
     {ACPI_DMT_FLAG0,    ACPI_IORT4_FLAG_OFFSET (Flags, 0),          "COHAC=
C Override", 0},
-    {ACPI_DMT_FLAG1,    ACPI_IORT4_FLAG_OFFSET (Flags, 0),          "HTTU =
Override", 0},
+    {ACPI_DMT_FLAGS1,   ACPI_IORT4_FLAG_OFFSET (Flags, 0),          "HTTU =
Override", 0},
     {ACPI_DMT_FLAG3,    ACPI_IORT4_FLAG_OFFSET (Flags, 0),          "Proxi=
mity Domain Valid", 0},
     {ACPI_DMT_UINT32,   ACPI_IORT4_OFFSET (Reserved),               "Reser=
ved", 0},
     {ACPI_DMT_UINT64,   ACPI_IORT4_OFFSET (VatosAddress),           "VATOS=
 Address", 0},
--
2.19.1

--===============3915790917844610174==--

