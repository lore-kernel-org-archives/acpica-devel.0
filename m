Return-Path: <andriy.shevchenko@linux.intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 40B2740611
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 023E840550
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688386454; x=1719922454;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Z7bCMN6xKQi+ypGD5LL1aECtFx/TCb2DP0kRtZYvV10=;
 b=NgWm81nllrMuJmp/bRu/UKkw/UVojjh3HHK7yCFnShWqG/duNrkqWkgS
 CHgYchjvGjt+s2NGqsnMjDjjqOQrzUGn4zFXumNxx/nJhchWBXMeRtOrp
 efZY6DMhZw3cz+xW2Ly1+ftVY754CqoBtmjm/NZsbutC4gBQOYHzYf3cB
 sruHhESK3zosSYhn4/pjxMflqpSj5T7MXLytnlCfKF3E3a2hOJFBxK5v/
 E5p5jX3XaJ8MHnlPxBOldkk1SkdjtcKC7cBmEOx/duXd/U+pgloUKMpbK
 c2oolHZ5eAXsePF6oxXt1hG958l599byK6w8/GvCTQ3KsCmESOpsV9Mis Q==;
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-Id: <20230703121411.69606-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230703121411.69606-1-andriy.shevchenko@linux.intel.com>
References: <20230703121411.69606-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Acpica-devel] [PATCH v4 4/5] ACPI: scan: Use the
	acpi_match_acpi_device() helper
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
Date: Mon, 03 Jul 2023 12:14:16 -0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Wolfram Sang <wsa@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, acpica-devel@lists.linuxfoundation.org
Cc: Michael Walle <michael@walle.cc>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>

Instead of doing two pass parsing of the table, replace
acpi_match_device_ids() with acpi_match_acpi_device().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/scan.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index e75ed9123931..ec1c9bec8bae 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -928,26 +928,29 @@ static int acpi_bus_extract_wakeup_device_power_package(struct acpi_device *dev)
 	return err;
 }
 
+/* Do not use a button for S5 wakeup */
+#define ACPI_AVOID_WAKE_FROM_S5		BIT(0)
+
 static bool acpi_wakeup_gpe_init(struct acpi_device *device)
 {
 	static const struct acpi_device_id button_device_ids[] = {
-		{"PNP0C0C", 0},		/* Power button */
-		{"PNP0C0D", 0},		/* Lid */
-		{"PNP0C0E", 0},		/* Sleep button */
+		{"PNP0C0C", 0},				/* Power button */
+		{"PNP0C0D", ACPI_AVOID_WAKE_FROM_S5},	/* Lid */
+		{"PNP0C0E", ACPI_AVOID_WAKE_FROM_S5},	/* Sleep button */
 		{"", 0},
 	};
 	struct acpi_device_wakeup *wakeup = &device->wakeup;
+	const struct acpi_device_id *match;
 	acpi_status status;
 
 	wakeup->flags.notifier_present = 0;
 
 	/* Power button, Lid switch always enable wakeup */
-	if (!acpi_match_device_ids(device, button_device_ids)) {
-		if (!acpi_match_device_ids(device, &button_device_ids[1])) {
-			/* Do not use Lid/sleep button for S5 wakeup */
-			if (wakeup->sleep_state == ACPI_STATE_S5)
-				wakeup->sleep_state = ACPI_STATE_S4;
-		}
+	match = acpi_match_acpi_device(button_device_ids, device);
+	if (match) {
+		if ((match->driver_data & ACPI_AVOID_WAKE_FROM_S5) &&
+		    wakeup->sleep_state == ACPI_STATE_S5)
+			wakeup->sleep_state = ACPI_STATE_S4;
 		acpi_mark_gpe_for_wake(wakeup->gpe_device, wakeup->gpe_number);
 		device_set_wakeup_capable(&device->dev, true);
 		return true;
-- 
2.40.0.1.gaa8946217a0b

