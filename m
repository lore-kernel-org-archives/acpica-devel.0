Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42848224C3
	for <acpica-devel@lists.linuxfoundation.org>; Thu, 23 Nov 2023 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N3FyX600"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C140160C13
	for <acpica-devel@lists.linuxfoundation.org>; Thu, 23 Nov 2023 10:07:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C140160C13
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N3FyX600
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Re15Dbyi6TRF
	for <acpica-devel@lists.linuxfoundation.org>;
	Thu, 23 Nov 2023 10:07:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 91A0D60BFD
	for <acpica-devel@lists.linuxfoundation.org>; Thu, 23 Nov 2023 10:07:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 91A0D60BFD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700734029; x=1732270029;
  h=from:to:cc:subject:date:message-id;
  bh=E/GNlBnsRoIGgHD6OlYnLt2vW4tbci5Zhdk7KhH8jlc=;
  b=N3FyX600cRXgPFFwXdhej0UdpBKsTt7vA0BUJ/iFm2mckcxwUsh/LxN8
   SIyYvVXEdo3nwHXoGCA3GbDs2HiES46G6CGs1FOM7xqB3ELWu3UcOXhJh
   c+2OnjWeyyB+TksYTfmHdEJdkE4gNb0l+9iusG/m1YUuw731OLVVVyBNd
   vH/3ydjxZQTz7OUi+IV3yAbxtPewm+Y27dOEFAJwre5+MjUSfpyOmIn3e
   SuIOjbp0c9+lEG4ui05xem/GaZLAeWOFivd4ttODQjxM9XIkyWS4NbR4k
   BrgLuElZ8smm+J2Cvk/RAcm3samPhAoacfFTDX1UaF+kwIuOp/54+4yWA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="456576373"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="456576373"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 02:07:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="767160407"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="767160407"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga002.jf.intel.com with ESMTP; 23 Nov 2023 02:07:02 -0800
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
Subject: [PATCH v3 0/5] Support _UID matching for integer types
Date: Thu, 23 Nov 2023 15:36:12 +0530
Message-Id: <20231123100617.28020-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>

This series updates the standard ACPI helpers to support _UID matching
for both integer and string types, and uses them in a couple of places.

Changes since v2:
- Drop __builtin functions to reduce complexity (Rafael)
- Update tags

Changes since v1:
- Fix build errors

Raag Jadav (5):
  ACPI: bus: update acpi_dev_uid_match() to support multiple types
  ACPI: bus: update acpi_dev_hid_uid_match() to support multiple types
  ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
  efi: dev-path-parser: use acpi_dev_uid_match() for matching _UID
  perf: arm_cspmu: drop redundant acpi_dev_uid_to_integer()

 drivers/acpi/acpi_lpss.c               | 16 ++-----
 drivers/acpi/utils.c                   | 48 -------------------
 drivers/firmware/efi/dev-path-parser.c |  7 +--
 drivers/perf/arm_cspmu/arm_cspmu.c     |  4 +-
 include/acpi/acpi_bus.h                | 65 +++++++++++++++++++++++++-
 include/linux/acpi.h                   | 15 ++----
 6 files changed, 74 insertions(+), 81 deletions(-)


base-commit: accf6bb711d6819cce89a122ccde4811c58c160e
-- 
2.17.1

