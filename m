Return-Path: <raag.jadav@intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 497C860F1A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8F33661001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697791692; x=1729327692;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=ycYM//IBzYahr1OT+k/0SqcANs76449DXAt6/AuLX9M=;
 b=ARdQrFqB//2vOjdjXoHaG25KE4d1fN4NWe4Bfw2V9U1T2gubBCVjE+nd
 +YifldAit/ST1RwovqbwXqRU/V1hpiLb0zbThFhku15FdjUMLdsELqwYm
 KOrfzyyj0L2RswUUhfzIZaCP6IxZ0eUr10f4SgAOE0tuFWCz9Z0162xnY
 D5v6PZ2gRCMK6gJ2kr65p6xGYaNjBJK5zbAJJc7E/A0EGp+oCBeUt3Lcx
 P4BM6nDGYJ51zVLa1r6mrGHXRvdJI2QJXVEHOWPZHnjg5uI78nE3C4Zad
 PeuV6Zzcf1KKyxtCDIEVFErW/ZwIwDM5Lq3MqI3ZjI1SkoPi8L+eFqYch g==;
From: Raag Jadav <raag.jadav@intel.com>
Date: Fri, 20 Oct 2023 14:17:28 +0530
Message-Id: <20231020084732.17130-5-raag.jadav@intel.com>
In-Reply-To: <20231020084732.17130-1-raag.jadav@intel.com>
References: <20231020084732.17130-1-raag.jadav@intel.com>
Subject: [Acpica-devel] [PATCH v1 4/8] ACPI: utils: use acpi_dev_uid_match()
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
To: rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com, mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, mark.rutland@arm.com, will@kernel.org, linux@roeck-us.net
Cc: linux-hwmon@vger.kernel.org, linux-gpio@vger.kernel.org, Raag Jadav <raag.jadav@intel.com>, mallikarjunappa.sangannavar@intel.com, linux-kernel@vger.kernel.org, bala.senthil@intel.com, linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, linux-arm-kernel@lists.infradead.org

Convert manual _UID references to use standard ACPI helpers.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/acpi/utils.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 664b9890b625..e3ba835e6590 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -889,8 +889,7 @@ static int acpi_dev_match_cb(struct device *dev, const void *data)
 	if (acpi_match_device_ids(adev, match->hid))
 		return 0;
 
-	if (match->uid && (!adev->pnp.unique_id ||
-	    strcmp(adev->pnp.unique_id, match->uid)))
+	if (!acpi_dev_uid_match(adev, match->uid))
 		return 0;
 
 	if (match->hrv == -1)
-- 
2.17.1

