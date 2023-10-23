Return-Path: <raag.jadav@intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EDC9640273
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 30BA240146
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698039387; x=1729575387;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=ozdZnaBJZ2vqKdOuWyOWr4NX6JLrJWxExqsMlsM/PrM=;
 b=OmdWhuBjXZMtXB4Xu8i5SrbCQdqF/gxDffg+OT2i7zn5l4+624JaGhIP
 znziLKOsC3ic65uI4gnA9eLCVNfEoT8C7dQkpL9SYs+jdU8JwAWVq9OY3
 7FgN2bbMUzlmbTx42TblXmKD3k7egpp2CTT5D5W2ce4qKODRX3rgsSrkm
 L52c1Xqt7ySa2Sb27yOnf1ejjCTZ6NJeCLCehDDHY63sJGLJ+qaGAYauC
 0K41QQcqa26hA1TJNV8rm+17ltsI5nTrHM7pmUNpw/GFdDfOibADnYwBd
 ETcL3OpIZA9f3F4s7kOn56dlruRW5PGzPrwFcfT7/lwEh3Z6H/eGHX8fV w==;
From: Raag Jadav <raag.jadav@intel.com>
Date: Mon, 23 Oct 2023 11:05:27 +0530
Message-Id: <20231023053530.5525-4-raag.jadav@intel.com>
In-Reply-To: <20231023053530.5525-1-raag.jadav@intel.com>
References: <20231023053530.5525-1-raag.jadav@intel.com>
Subject: [Acpica-devel] [PATCH v2 3/6] ACPI: utils: use acpi_dev_uid_match()
	for matching _UID
List-Id: "This is the central place for ACPICA developer discussions and
 issues." <acpica-devel.lists.linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/acpica-devel/>
List-Post: <mailto:acpica-devel@lists.linuxfoundation.org>
List-Help: <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/acpica-devel>, 
 <mailto:acpica-devel-request@lists.linuxfoundation.org?subject=subscribe>
To: rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com, mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, mark.rutland@arm.com, will@kernel.org, linux@roeck-us.net, Jonathan.Cameron@Huawei.com
Cc: linux-hwmon@vger.kernel.org, linux-gpio@vger.kernel.org, Raag Jadav <raag.jadav@intel.com>, mallikarjunappa.sangannavar@intel.com, linux-kernel@vger.kernel.org, bala.senthil@intel.com, linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, linux-arm-kernel@lists.infradead.org

Convert manual _UID references to use the standard ACPI helper.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/acpi/utils.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index be21b77059af..28c75242fca9 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -942,8 +942,7 @@ static int acpi_dev_match_cb(struct device *dev, const void *data)
 	if (acpi_match_device_ids(adev, match->hid))
 		return 0;
 
-	if (match->uid && (!adev->pnp.unique_id ||
-	    strcmp(adev->pnp.unique_id, match->uid)))
+	if (match->uid && !acpi_dev_uid_match(adev, match->uid))
 		return 0;
 
 	if (match->hrv == -1)
-- 
2.17.1

