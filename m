Return-Path: <raag.jadav@intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 13B7F424C9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3F7AA400FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698128448; x=1729664448;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=Dcfv80fwqkTrnHzYXDt90mV7PVNibcyla57Py1ydYHw=;
 b=Vxd+YW4YYoyLbIPGwjMbe1OPfhqR7J4u4/ILAxGiwyOtIHbwbGdPszrS
 mdY4V/TblWwIfMKeGxQzA+hMIy65bOrac06w+n5BsUWLouNPTlKv0oXgU
 XiW+JYE7lGZXnXga1nT2Q8OzZvlcswXXnSvinWWzsSg0Czqi2gTbmsxl0
 np9ekBAqZi0D7DKGRt5x+EtSaC466aeUT4Dx7jl1Yycze6ifFuvpCAwAc
 8tEUkQQUCWmEqpLozFPSdfdRbV3XENyZM/VS1u14iTnxzxN7nM9vEZ1+O
 /9FEpDiP0MScx5RbppE/cSJ6KSq0M+uSRoHrSQfpFNWN2qD5TckSGGBuF Q==;
From: Raag Jadav <raag.jadav@intel.com>
Date: Tue, 24 Oct 2023 11:50:14 +0530
Message-Id: <20231024062018.23839-3-raag.jadav@intel.com>
In-Reply-To: <20231024062018.23839-1-raag.jadav@intel.com>
References: <20231024062018.23839-1-raag.jadav@intel.com>
Subject: [Acpica-devel] [PATCH v3 2/6] pinctrl: intel: use
	acpi_dev_uid_match() for matching _UID
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
 drivers/pinctrl/intel/pinctrl-intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 3be04ab760d3..999f453344d2 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1694,7 +1694,7 @@ const struct intel_pinctrl_soc_data *intel_pinctrl_get_soc_data(struct platform_
 		unsigned int i;
 
 		for (i = 0; table[i]; i++) {
-			if (!strcmp(adev->pnp.unique_id, table[i]->uid)) {
+			if (acpi_dev_uid_match(adev, table[i]->uid)) {
 				data = table[i];
 				break;
 			}
-- 
2.17.1

