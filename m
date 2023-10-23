Return-Path: <raag.jadav@intel.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A7D4B4020B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C86AC401C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698039385; x=1729575385;
 h=from:to:cc:subject:date:message-id:in-reply-to: references;
 bh=kUk0ItiaVjzsfP94oC1IH39uZvUKoEr3WDbUZtzQLOo=;
 b=TqfhDOaeFBtb4wF2pLDQkFapff1OAkEtVjJNTsX3TfrbdnoFsYJYmAa8
 gqVe4RlsGh68HSlQCwoq6SFufOIJ9j/SJvhb31u5iFfYMTjx0IPIy2nDA
 gr9rYul8G/OqFfkPZd3Qv6nIYC6FVi0T/SSOhc3hGagkcps+fyLEGPgq0
 3IGJIKwASfWkV8aQg6XQYy9CS68i2DjW2XscN/U7sj+MhZzfMgULAFAyW
 B08qaIKc4fTwIZYv175M2xBWwqikDlLgpdIf9mj75N2y+lQXsfELYeMfu
 2GVNb2N85LhHAmd2Thr+885T0LU/t9PdGCNOmY5iwfr4B4Ie2dZPHPlA6 w==;
From: Raag Jadav <raag.jadav@intel.com>
Date: Mon, 23 Oct 2023 11:05:26 +0530
Message-Id: <20231023053530.5525-3-raag.jadav@intel.com>
In-Reply-To: <20231023053530.5525-1-raag.jadav@intel.com>
References: <20231023053530.5525-1-raag.jadav@intel.com>
Subject: [Acpica-devel] [PATCH v2 2/6] pinctrl: intel: use
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

