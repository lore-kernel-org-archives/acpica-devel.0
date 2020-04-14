Content-Type: multipart/mixed; boundary="===============3495796886349836955=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Re: [PATCH] ACPICA: Use ARRAY_SIZE instead of hardcoded siz
Date: Tue, 14 Apr 2020 20:22:40 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3C68A849E@ORSMSX108.amr.corp.intel.com>
In-Reply-To: 20200413143156.22633-1-yanaijie@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3495796886349836955==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I think we've discussed this in the past. ARRAY_SIZE is not standard, and w=
ill get in the way of portability:

On gcc v7.4.0:
../../../source/components/resources/rsdumpinfo.c:335:25: note: in expansio=
n of macro 'ACPI_RSD_TABLE_SIZE'
     {ACPI_RSD_TITLE,    ACPI_RSD_TABLE_SIZE (AcpiRsDumpGenericReg),       =
  "Generic Register",         NULL},

../../../source/components/resources/rsdumpinfo.c:166:37: error: initialize=
r element is not constant
 #define ACPI_RSD_TABLE_SIZE(name)   ARRAY_SIZE (name)


And, on MSVC 2017:
Severity	Code	Description	Project	File	Line	Suppression State
Warning	C4013	'ARRAY_SIZE' undefined; assuming extern returning int	AcpiExe=
c	c:\acpica\source\components\resources\rsdumpinfo.c	179	=

-----Original Message-----
From: Jason Yan <yanaijie(a)huawei.com> =

Sent: Monday, April 13, 2020 7:32 AM
To: Moore, Robert <robert.moore(a)intel.com>; Kaneda, Erik <erik.kaneda(a)i=
ntel.com>; Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>; lenb(a)kernel.=
org; linux-acpi(a)vger.kernel.org; devel(a)acpica.org; linux-kernel(a)vger.=
kernel.org
Cc: Jason Yan <yanaijie(a)huawei.com>
Subject: [PATCH] ACPICA: Use ARRAY_SIZE instead of hardcoded siz

Fix the following coccicheck warning:

./drivers/acpi/acpica/rsdumpinfo.c:18:48-49: WARNING: Use ARRAY_SIZE
./drivers/acpi/acpica/rsdumpinfo.c:18:48-49: WARNING: Use ARRAY_SIZE
./drivers/acpi/acpica/rsdumpinfo.c:18:48-49: WARNING: Use ARRAY_SIZE
./drivers/acpi/acpica/rsdumpinfo.c:18:48-49: WARNING: Use ARRAY_SIZE
./drivers/acpi/acpica/rsdumpinfo.c:18:48-49: WARNING: Use ARRAY_SIZE
./drivers/acpi/acpica/rsdumpinfo.c:18:48-49: WARNING: Use ARRAY_SIZE
./drivers/acpi/acpica/rsdumpinfo.c:18:48-49: WARNING: Use ARRAY_SIZE

Signed-off-by: Jason Yan <yanaijie(a)huawei.com>
---
 drivers/acpi/acpica/rsdumpinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/rsdumpinfo.c b/drivers/acpi/acpica/rsdumpi=
nfo.c
index cafa8134b4c6..f1ba4cd8080f 100644
--- a/drivers/acpi/acpica/rsdumpinfo.c
+++ b/drivers/acpi/acpica/rsdumpinfo.c
@@ -15,7 +15,7 @@ ACPI_MODULE_NAME("rsdumpinfo")  #if defined(ACPI_DEBUG_OU=
TPUT) || defined(ACPI_DISASSEMBLER) || defined(ACPI_DEBUGGER)
 #define ACPI_RSD_OFFSET(f)          (u8) ACPI_OFFSET (union acpi_resource_=
data,f)
 #define ACPI_PRT_OFFSET(f)          (u8) ACPI_OFFSET (struct acpi_pci_rout=
ing_table,f)
-#define ACPI_RSD_TABLE_SIZE(name)   (sizeof(name) / sizeof (struct acpi_rs=
dump_info))
+#define ACPI_RSD_TABLE_SIZE(name)   ARRAY_SIZE(name)
 /*************************************************************************=
******
  *
  * Resource Descriptor info tables
--
2.21.1

--===============3495796886349836955==--

