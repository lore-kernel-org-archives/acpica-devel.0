Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8D1374C9
	for <acpica-devel@lists.linuxfoundation.org>; Tue, 21 Nov 2023 10:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SOk1wyIL"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E0F861007
	for <acpica-devel@lists.linuxfoundation.org>; Tue, 21 Nov 2023 10:39:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2E0F861007
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SOk1wyIL
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mq-sBCEy8VhA
	for <acpica-devel@lists.linuxfoundation.org>;
	Tue, 21 Nov 2023 10:39:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9328660FCC
	for <acpica-devel@lists.linuxfoundation.org>; Tue, 21 Nov 2023 10:39:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9328660FCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700563144; x=1732099144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Y6ds1jUN7LPSrZRrgey6FYqJOhCq9ZfRNZPabZ6KtHA=;
  b=SOk1wyILJxevpm2deom5LFTev6IpRjR95hY2MOBa9aNNPv1nCco3P1lf
   8fv1kY1sx26wWLkXwfz9TMkdpzrI+3ZHrOTeUxq2y9PamUh2wsF+njjdZ
   iKYicVrFuRdy5uJwekPYGv4zA1l48+yUclRNKoX5u7A23uK4zlvW0bHo6
   4K6fxuaNnINuiHKxpSepQwhnPkalAQcB0hRKrjlrNIG+4CekcsyJxjj1s
   WFTV1QMODH3XEM+20IRoZdW8AnpDsp+FMAAFhzeHINxj9LW+wuDB9fwZW
   1Y1/8Tf69FiHNePMVdRej/HFvXiC3Ai9B5X1Gk3KXxNJqNzWsyIo2jXne
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="371987050"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="371987050"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 02:39:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="14871962"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa001.fm.intel.com with ESMTP; 21 Nov 2023 02:39:00 -0800
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
Subject: [PATCH v2 6/6] perf: arm_cspmu: drop redundant acpi_dev_uid_to_integer()
Date: Tue, 21 Nov 2023 16:08:29 +0530
Message-Id: <20231121103829.10027-7-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231121103829.10027-1-raag.jadav@intel.com>
References: <20231121103829.10027-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>

Now that we have _UID matching support for integer types, we can use
acpi_dev_hid_uid_match() for it.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 2cc35dded007..50b89b989ce7 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -1108,7 +1108,6 @@ static int arm_cspmu_request_irq(struct arm_cspmu *cspmu)
 
 static inline int arm_cspmu_find_cpu_container(int cpu, u32 container_uid)
 {
-	u64 acpi_uid;
 	struct device *cpu_dev;
 	struct acpi_device *acpi_dev;
 
@@ -1118,8 +1117,7 @@ static inline int arm_cspmu_find_cpu_container(int cpu, u32 container_uid)
 
 	acpi_dev = ACPI_COMPANION(cpu_dev);
 	while (acpi_dev) {
-		if (acpi_dev_hid_uid_match(acpi_dev, ACPI_PROCESSOR_CONTAINER_HID, NULL) &&
-		    !acpi_dev_uid_to_integer(acpi_dev, &acpi_uid) && acpi_uid == container_uid)
+		if (acpi_dev_hid_uid_match(acpi_dev, ACPI_PROCESSOR_CONTAINER_HID, container_uid))
 			return 0;
 
 		acpi_dev = acpi_dev_parent(acpi_dev);
-- 
2.17.1

