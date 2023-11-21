Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC4D3C6A7
	for <acpica-devel@lists.linuxfoundation.org>; Tue, 21 Nov 2023 10:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="keJk8CZH"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 39CB061007
	for <acpica-devel@lists.linuxfoundation.org>; Tue, 21 Nov 2023 10:38:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 39CB061007
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=keJk8CZH
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WExxunR_NJvK
	for <acpica-devel@lists.linuxfoundation.org>;
	Tue, 21 Nov 2023 10:38:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7AD9660FCC
	for <acpica-devel@lists.linuxfoundation.org>; Tue, 21 Nov 2023 10:38:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7AD9660FCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700563118; x=1732099118;
  h=from:to:cc:subject:date:message-id;
  bh=bxtTVb3CSDkXZiM00Vj7mR/GNeU9U6TTLbrsPm7CyvU=;
  b=keJk8CZH/UyyV9yZOw8fMTttimCpo3jOTpoWfeHcfkge6K8cI3sXNh4g
   ykmuGpvYJH1cqoxGYuCp/A9mWcfN90Zpj3lMg3OOesQqIs1UkMLg8K6J+
   spYZX1p8J8dZRLoaeZFE3jY9HC/dDsMmP2Igvh5ujYPZeJ1EkCfZtdZ13
   9aI41aDMqlM7wt/4Amq1fKOxdfbuRA7GMXCLs/StITQWQlymhlbZOLRTp
   DLO6q95VzdXikYErobos0Go25Zl8kAZWFfRU2/u+m6un86Cr0aDdVDUAo
   rjKLYcPn/0ztdHBn2Y67oxMxQPwKqXvl4oh4Ae1xJbFjwy1dJkUmGUHsA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="371986845"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="371986845"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 02:38:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="14871909"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa001.fm.intel.com with ESMTP; 21 Nov 2023 02:38:33 -0800
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
Subject: [PATCH v2 0/6] Support _UID matching for integer types
Date: Tue, 21 Nov 2023 16:08:23 +0530
Message-Id: <20231121103829.10027-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>

This series updates the standard ACPI helpers to support _UID matching
for both integer and string types, and uses them in a couple of places.

Changes since v1:
- Fix build errors

Raag Jadav (6):
  compiler.h: Introduce helpers for identifying array and pointer types
  ACPI: bus: update acpi_dev_uid_match() to support multiple types
  ACPI: bus: update acpi_dev_hid_uid_match() to support multiple types
  ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
  efi: dev-path-parser: use acpi_dev_uid_match() for matching _UID
  perf: arm_cspmu: drop redundant acpi_dev_uid_to_integer()

 drivers/acpi/acpi_lpss.c               | 16 ++-----
 drivers/acpi/utils.c                   | 48 ---------------------
 drivers/firmware/efi/dev-path-parser.c |  7 +--
 drivers/perf/arm_cspmu/arm_cspmu.c     |  4 +-
 include/acpi/acpi_bus.h                | 59 +++++++++++++++++++++++++-
 include/linux/acpi.h                   | 15 ++-----
 include/linux/compiler.h               |  5 +++
 7 files changed, 73 insertions(+), 81 deletions(-)


base-commit: f437a8d1debff5412e36a1c9454adee193b31950
-- 
2.17.1

