Content-Type: multipart/mixed; boundary="===============8228815076809433902=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Re: [PATCH] ACPICA: Use ARRAY_SIZE for 'fadt_info_table',
 'fadt_pm_info_table'
Date: Fri, 22 Nov 2019 21:49:05 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3B96B1A5A@ORSMSX110.amr.corp.intel.com>
In-Reply-To: 1574415183-19322-1-git-send-email-zhengbin13@huawei.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============8228815076809433902==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Where does "ARRAY_SIZE" come from? It's not a part of ACPICA.
Bob


-----Original Message-----
From: zhengbin <zhengbin13(a)huawei.com> =

Sent: Friday, November 22, 2019 1:33 AM
To: Moore, Robert <robert.moore(a)intel.com>; Schmauss, Erik <erik.schmauss=
(a)intel.com>; Wysocki, Rafael J <rafael.j.wysocki(a)intel.com>; lenb(a)ker=
nel.org; linux-acpi(a)vger.kernel.org; devel(a)acpica.org
Cc: zhengbin13(a)huawei.com
Subject: [PATCH] ACPICA: Use ARRAY_SIZE for 'fadt_info_table','fadt_pm_info=
_table'

Fixes coccicheck warning:

drivers/acpi/acpica/tbfadt.c:107:27-28: WARNING: Use ARRAY_SIZE
drivers/acpi/acpica/tbfadt.c:137:30-31: WARNING: Use ARRAY_SIZE

Reported-by: Hulk Robot <hulkci(a)huawei.com>
Signed-off-by: zhengbin <zhengbin13(a)huawei.com>
---
 drivers/acpi/acpica/tbfadt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c in=
dex 0041bfb..324a804 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -103,8 +103,7 @@ static struct acpi_fadt_info fadt_info_table[] =3D {
 	 ACPI_FADT_SEPARATE_LENGTH | ACPI_FADT_GPE_REGISTER}  };

-#define ACPI_FADT_INFO_ENTRIES \
-			(sizeof (fadt_info_table) / sizeof (struct acpi_fadt_info))
+#define ACPI_FADT_INFO_ENTRIES (ARRAY_SIZE(fadt_info_table))

 /* Table used to split Event Blocks into separate status/enable registers =
*/

@@ -133,8 +132,7 @@ static struct acpi_fadt_pm_info fadt_pm_info_table[] =
=3D {
 	 1}
 };

-#define ACPI_FADT_PM_INFO_ENTRIES \
-			(sizeof (fadt_pm_info_table) / sizeof (struct acpi_fadt_pm_info))
+#define ACPI_FADT_PM_INFO_ENTRIES (ARRAY_SIZE(fadt_pm_info_table))

 /*************************************************************************=
******
  *
--
2.7.4

--===============8228815076809433902==--

