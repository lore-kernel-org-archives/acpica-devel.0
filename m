Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9BD224CC
	for <acpica-devel@lists.linuxfoundation.org>; Thu, 23 Nov 2023 10:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fySHu95r"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D81F6813E3
	for <acpica-devel@lists.linuxfoundation.org>; Thu, 23 Nov 2023 10:07:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D81F6813E3
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fySHu95r
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZpWMQOfQa4Hy
	for <acpica-devel@lists.linuxfoundation.org>;
	Thu, 23 Nov 2023 10:07:31 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3996F8141F
	for <acpica-devel@lists.linuxfoundation.org>; Thu, 23 Nov 2023 10:07:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3996F8141F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700734051; x=1732270051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=eGrPJB71BQqPQgzBxdkMDsK/ebN3t2PqlY8XYy9ELos=;
  b=fySHu95rX65pKTF/wNvbOZ170G5WL0GKZQKbQWukKyWG2dbMqd8TxFPR
   gPQ2FtFwLy1Qmn0OkciwDjwcCQXBdpdZ7zofhQFLJSad9WvS+YdeG7IPp
   KCXTH7b32BSbiejOu2MQREjp9eLz+Q4yO7Gh0r7PtJdJT+LIhoPyYVWEQ
   8GVAb9Oiuuikd9Xcdye/JbXotxWItfhbhXPW9eVsQDmoDtxC6E632AiKg
   gnezJnIRBTrjhv58ASiAis4Gl95xGSOV71xgOdDaFmO772acVp1lGiVhN
   UttWsbHr3ls06V8NKSaIYrjCQtrid5/s9Qwuw1dzU5t/VvGuPieGSJG86
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="456576448"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="456576448"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 02:07:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="767160544"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="767160544"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga002.jf.intel.com with ESMTP; 23 Nov 2023 02:07:26 -0800
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
Subject: [PATCH v3 5/5] perf: arm_cspmu: drop redundant acpi_dev_uid_to_integer()
Date: Thu, 23 Nov 2023 15:36:17 +0530
Message-Id: <20231123100617.28020-6-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231123100617.28020-1-raag.jadav@intel.com>
References: <20231123100617.28020-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>

Now that we have _UID matching support for integer types, we can use
acpi_dev_hid_uid_match() for it.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Acked-by: Will Deacon <will@kernel.org>
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

