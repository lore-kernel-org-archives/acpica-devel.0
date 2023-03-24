Return-Path: <ukl@pengutronix.de>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D0D1040604
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CD08B400C7
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Message-Id: <20230324075854.458341-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1162;
 i=u.kleine-koenig@pengutronix.de; h=from:subject;
 bh=yff8pJaSr2OOYqnudyAyXa+Ae+DvLs0YIYVHJWEVNEY=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkHVg9+pNcCROv4lht0GMJvsBW8dN8DeisSpVHd
 hRZrRoE6wmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZB1YPQAKCRCPgPtYfRL+
 TiZbCAC6nqmRBRpIDbewDZx+i9jVtdSIsovIcGVys9Pz3HcVr+4q3uEN1I2J5LV1AO1tAXRXUCK
 VpcCprSBvEg88by6UjMk1QLyEN2MJYz8sMXNvoVSIqAmadm8u6fKFxPuhJs2BV1J9awB2IjJcZh
 MqKHCh/rhS2xa+LMI+cVzEtfm1K1NC0fBkvFrk2TNLjsblmHNYu3sI37gCwDdnXH357QH8WggS6
 5jF2nFI5Pf7Sbcy11ZlaMBXZpSpIPiMtbNlEFxvmArF92tGRpjSsHji5YqDqRIaToGAj6OcDx0b
 /gDtFEsmcMyCBV0brySpSwS2fGsqg6MK8ql8udzeedPqlIYQ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
Subject: [Acpica-devel] [PATCH] ACPICA: Make check to install handler more
	obviously correct
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Fri, 24 Mar 2023 08:01:04 -0000
To: Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, kernel@pengutronix.de, Len Brown <lenb@kernel.org>

The loop

	for (i = 0; i < ACPI_NUM_NOTIFY_TYPES; i++) {
		if (handler_type & (i + 1)) {
			...
		}
	}

looks strange. Only with knowing that ACPI_NUM_NOTIFY_TYPES == 2 you can
see that the two least significant bits are checked. Still replace

	i + 1

by

	1 << i

which shouldn't make a relevant difference to compiler and compiled
code, but is easier to understand for a human code reader.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/acpi/acpica/evxface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index 18219abba108..d1b3411d2449 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -170,7 +170,7 @@ acpi_install_notify_handler(acpi_handle device,
 	/* Install the handler at the list head(s) */
 
 	for (i = 0; i < ACPI_NUM_NOTIFY_TYPES; i++) {
-		if (handler_type & (i + 1)) {
+		if (handler_type & (1 << i)) {
 			handler_obj->notify.next[i] =
 			    obj_desc->common_notify.notify_list[i];
 

base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.39.2

