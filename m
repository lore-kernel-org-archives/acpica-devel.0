Content-Type: multipart/mixed; boundary="===============3110021493190759534=="
MIME-Version: 1.0
From: Moore, Robert <robert.moore at intel.com>
Subject: [Devel] Re: [PATCH] ACPICA: fix if condition
Date: Fri, 09 Jul 2021 14:38:27 +0000
Message-ID: <BYAPR11MB32562B564676F3A00DAC5B1C87189@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: 20210703091218.650202-1-gushengxian507419@gmail.com
List-ID: <devel@acpica.org>
To: devel@acpica.org

--===============3110021493190759534==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Got it,
Thanks.


-----Original Message-----
From: gushengxian <gushengxian507419(a)gmail.com> =

Sent: Saturday, July 03, 2021 2:12 AM
To: Moore, Robert <robert.moore(a)intel.com>; erik.kaneda(a)intel.com; Wyso=
cki, Rafael J <rafael.j.wysocki(a)intel.com>; lenb(a)kernel.org
Cc: linux-acpi(a)vger.kernel.org; devel(a)acpica.org; linux-kernel(a)vger.k=
ernel.org; gushengxian <gushengxian(a)yulong.com>
Subject: [PATCH] ACPICA: fix if condition

From: gushengxian <gushengxian(a)yulong.com>

Fix if condition.

Signed-off-by: gushengxian <gushengxian(a)yulong.com>
---
 drivers/acpi/acpica/dswexec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c =
index 41ba7773fd10..c4cd61469e1f 100644
--- a/drivers/acpi/acpica/dswexec.c
+++ b/drivers/acpi/acpica/dswexec.c
@@ -561,8 +561,7 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state =
*walk_state)
 								op->common.
 								node->object,
 								NULL);
-				if ACPI_FAILURE
-					(status) {
+				if (ACPI_FAILURE(status)) {
 					ACPI_EXCEPTION((AE_INFO, status,
 							"While writing to buffer field"));
 					}
--
2.25.1

--===============3110021493190759534==--

