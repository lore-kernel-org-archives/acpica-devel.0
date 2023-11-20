Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315FA18E1D
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 20 Nov 2023 12:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MRphucpO"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BEA9760BC1
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 20 Nov 2023 12:09:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BEA9760BC1
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MRphucpO
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2dK_k5SUsh23
	for <acpica-devel@lists.linuxfoundation.org>;
	Mon, 20 Nov 2023 12:09:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 090E960BC0
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 20 Nov 2023 12:09:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 090E960BC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700482155; x=1732018155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=/nqR+KlYfg0C+OhOQjsmRZyDysf3qyPk8ALUmLhgcv0=;
  b=MRphucpOX8WSjVG8vrObVM/EQHTTnpomAAIxIZ0f9fKBSv4GmOb/i3JJ
   ZR8tehJTGjKiz3CEVbQxB6lH3Q6amHsR16uUMzRtBt3Df9IG5VkVVJFDo
   9OlqI4oVeAG5NGhLUCMY0Vm2y3UI1Pc0H9SgteTT0kb9MGbLTR/KLw5F+
   liY+C9kp1Q7457dVU8NFmxaAinS0kE4pU9PW/nVUBZjb8/JjLTP2nDzZK
   bjp4P97+jF3YqZUHmZt+S5ToLQgnwK1EQYyhhKNbTVEH1YGhRXS+qwdYu
   f9xUTB9q96gCBL7VdynH7Awv7O0yyIGdnoQ8xkksJE0t9VlLmiOk2Wwe0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="394455744"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="394455744"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 04:09:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="769878654"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="769878654"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga007.fm.intel.com with ESMTP; 20 Nov 2023 04:09:04 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	rafael@kernel.org,
	lenb@kernel.org,
	robert.moore@intel.com,
	ardb@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org,
	linux-efi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	mallikarjunappa.sangannavar@intel.com,
	bala.senthil@intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 4/6] ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
Date: Mon, 20 Nov 2023 17:38:35 +0530
Message-Id: <20231120120837.3002-5-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231120120837.3002-1-raag.jadav@intel.com>
References: <20231120120837.3002-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>

Now that we have _UID matching support for integer types, we can use
acpi_dev_uid_match() for it.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/acpi/acpi_lpss.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 875de44961bf..8b80ef7da21f 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -167,10 +167,8 @@ static struct pwm_lookup byt_pwm_lookup[] = {
 
 static void byt_pwm_setup(struct lpss_private_data *pdata)
 {
-	u64 uid;
-
 	/* Only call pwm_add_table for the first PWM controller */
-	if (acpi_dev_uid_to_integer(pdata->adev, &uid) || uid != 1)
+	if (!acpi_dev_uid_match(pdata->adev, 1))
 		return;
 
 	pwm_add_table(byt_pwm_lookup, ARRAY_SIZE(byt_pwm_lookup));
@@ -218,10 +216,8 @@ static struct pwm_lookup bsw_pwm_lookup[] = {
 
 static void bsw_pwm_setup(struct lpss_private_data *pdata)
 {
-	u64 uid;
-
 	/* Only call pwm_add_table for the first PWM controller */
-	if (acpi_dev_uid_to_integer(pdata->adev, &uid) || uid != 1)
+	if (!acpi_dev_uid_match(pdata->adev, 1))
 		return;
 
 	pwm_add_table(bsw_pwm_lookup, ARRAY_SIZE(bsw_pwm_lookup));
-- 
2.17.1

