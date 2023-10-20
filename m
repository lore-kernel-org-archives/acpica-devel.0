Return-Path: <raag.jadav@intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 55C8160EE4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C030C60F1A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697791692; x=1729327692;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=t9Y0MIXw9ZdOFW0YKzuaiyfbehmFMxDrJh2lVaVPw5k=;
 b=mOZ36Q1+YGENDTBQjNSpdmduQeytmjowVsBLgjvVu+A0AUojPd9Og4X5
 415oYVXimmiJHuEEIl7ovfN2vdy2pqNG21sTiuJVBLZwNzOL/rO1pKgYU
 6Di3dhSdEUlWnVPLucF6i6ibS7qMOSqpM6np/av04sg8c2EBGHbsmmKsw
 x1ZNh99DOG/eF72DlKBb2oB+PqTZFYfFcEu8FIF2/nsZF5J3cBuN2xeSu
 w/jM2VEXRTub22lt07VnukENNL8VcE0p5YE9wE1T8E7YesB9aDhnDjrrQ
 VES8X8MzMiGagt9rpd0J8WL6AfwpCz+0TLS7zJliD6553R7QxME8o0zRv A==;
From: Raag Jadav <raag.jadav@intel.com>
Date: Fri, 20 Oct 2023 14:17:29 +0530
Message-Id: <20231020084732.17130-6-raag.jadav@intel.com>
In-Reply-To: <20231020084732.17130-1-raag.jadav@intel.com>
References: <20231020084732.17130-1-raag.jadav@intel.com>
Subject: [Acpica-devel] [PATCH v1 5/8] ACPI: x86: use acpi_dev_uid_match()
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
 drivers/acpi/x86/utils.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 63d834dd3811..bc65ebfcdf76 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -184,8 +184,7 @@ bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *s
 			if (acpi_match_device_ids(adev, override_status_ids[i].hid))
 				continue;
 
-			if (!adev->pnp.unique_id ||
-			    strcmp(adev->pnp.unique_id, override_status_ids[i].uid))
+			if (!acpi_dev_uid_match(adev, override_status_ids[i].uid))
 				continue;
 		}
 
-- 
2.17.1

