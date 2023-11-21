Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8076834566
	for <acpica-devel@lists.linuxfoundation.org>; Tue, 21 Nov 2023 10:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N+6vK8AH"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0242761007
	for <acpica-devel@lists.linuxfoundation.org>; Tue, 21 Nov 2023 10:39:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0242761007
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N+6vK8AH
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9x6nYFIBvww9
	for <acpica-devel@lists.linuxfoundation.org>;
	Tue, 21 Nov 2023 10:39:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6CA7860FCC
	for <acpica-devel@lists.linuxfoundation.org>; Tue, 21 Nov 2023 10:39:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6CA7860FCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700563140; x=1732099140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=G01FEu7mgWj6wch0a4BuSRZSlujWtyeQmN3DyjCESFk=;
  b=N+6vK8AHJ7uIgo5uvrxayMWy6QFoS2h2XDKE14xu2aZfn7ineNfmr7bU
   jgInoLJrxFxKtRcjNKOzvQU10PhcGGRxgehr0OkWGFh1T0DrbMUzChUJj
   jlw/TyCJEx5a05p/q4cCj6lx1sAC8D07PQyWB1rrtrc0re7dOc9uE5VAr
   epIfQBoP2IYQkXqukZlpZZ1Xn+U36ai4DD0cie9ky46CfDwTpKsXm9uTD
   xjXXoOyDPu8xqDAkDPSPL5CxAmePszau+pC+swm5yGX5Fo6IOu7pC3dSa
   G6D1mfqEZKbFOROQZxtLbwHCuyRktVivbbcJLMF4SsNfi9ez/w4dQlkF6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="371987008"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="371987008"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 02:38:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="14871957"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa001.fm.intel.com with ESMTP; 21 Nov 2023 02:38:56 -0800
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
Subject: [PATCH v2 5/6] efi: dev-path-parser: use acpi_dev_uid_match() for matching _UID
Date: Tue, 21 Nov 2023 16:08:28 +0530
Message-Id: <20231121103829.10027-6-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231121103829.10027-1-raag.jadav@intel.com>
References: <20231121103829.10027-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>

Now that we have _UID matching support for integer types, we can use
acpi_dev_uid_match() for it.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/firmware/efi/dev-path-parser.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/dev-path-parser.c b/drivers/firmware/efi/dev-path-parser.c
index f80d87c199c3..937be269fee8 100644
--- a/drivers/firmware/efi/dev-path-parser.c
+++ b/drivers/firmware/efi/dev-path-parser.c
@@ -18,8 +18,6 @@ static long __init parse_acpi_path(const struct efi_dev_path *node,
 	struct acpi_device *adev;
 	struct device *phys_dev;
 	char hid[ACPI_ID_LEN];
-	u64 uid;
-	int ret;
 
 	if (node->header.length != 12)
 		return -EINVAL;
@@ -31,10 +29,9 @@ static long __init parse_acpi_path(const struct efi_dev_path *node,
 			node->acpi.hid >> 16);
 
 	for_each_acpi_dev_match(adev, hid, NULL, -1) {
-		ret = acpi_dev_uid_to_integer(adev, &uid);
-		if (ret == 0 && node->acpi.uid == uid)
+		if (acpi_dev_uid_match(adev, node->acpi.uid))
 			break;
-		if (ret == -ENODATA && node->acpi.uid == 0)
+		if (!acpi_device_uid(adev) && node->acpi.uid == 0)
 			break;
 	}
 	if (!adev)
-- 
2.17.1

