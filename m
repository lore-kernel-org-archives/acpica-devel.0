Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B4513F44C
	for <acpica-devel@lists.linux.dev>; Mon, 25 Mar 2024 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370094; cv=none; b=XPJgFcl/hXJsekG/cSBQGGdrXbdr2Kz3Q1Vczf4Gp/WP1o7MBg6r95rXTShQis54Lsj4b4yD5iOwthHGxQ3qFWZWwj9C8YM4AQ5JOF7u8mLqqTCIMB3vL3SsGHIcO2g9IopicFwRETR1gH2G9MsRQZNARL4GvEO91vdVgV2DVlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370094; c=relaxed/simple;
	bh=biGNLvjZxsnLB/YZsxsoQQ4aRn4EP/9IpoXiUDXO3iE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYtv/HycZIHoWjhSJqno3nUyiaZLwmRHrdnAc3B1r0kVOivxqTzj74iTpbPPuq5lVemqgYVCyWVKZ4uPoEKpbG2Gb/6rN8ypPFx4iD2ISG0QHrwNxJr1WmvoR4J5Yw4N1KyGGU0andy1Yh7Q8yCg0PEbjVzvJ22FARigua+XNFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ln0Hav4Y; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ln0Hav4Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711370093; x=1742906093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=biGNLvjZxsnLB/YZsxsoQQ4aRn4EP/9IpoXiUDXO3iE=;
  b=Ln0Hav4YEBaxUg76FuOCe6QGIS7pC9dgL5q4U5Ie+TNuj9/FrsTEXmYJ
   1noeErngfgzRLLFWnPiMBZxSFE4Y7mpPwXgoRym4zlyk7C5s+I7nLu+ef
   qo8qXv3U+h7fBew+Q95VQZsUknRgzF7yPQfGOdCA0a/9wLxIM0hWw3zu8
   SOHZ6VbQOLa9y2bPCMxT5Gk2JKNenDzvJspFHdsUh/3zTXO4XPn06K39C
   Rsj10wqUTmQz2+BsNPaFjUVcrF0k83Lrxc7qlCAlx3EGdaiOyBBn8NcIw
   RAfvXscKaTmodsqUDysO2bfH/JcG9UUoo6BOm8bUWouuJjjs8qKRBrqSH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6549693"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6549693"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 05:34:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="937070333"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="937070333"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 05:34:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BD3852CA; Mon, 25 Mar 2024 14:34:46 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>
Subject: [PATCH v1 2/7] ACPI: bus: Don't use "proxy" headers
Date: Mon, 25 Mar 2024 14:32:58 +0200
Message-ID: <20240325123444.3031851-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240325123444.3031851-1-andriy.shevchenko@linux.intel.com>
References: <20240325123444.3031851-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/acpi/acpi_bus.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index cdee38ef9ba5..acb62d1d3306 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -9,8 +9,13 @@
 #ifndef __ACPI_BUS_H__
 #define __ACPI_BUS_H__
 
+#include <linux/completion.h>
+#include <linux/container_of.h>
 #include <linux/device.h>
+#include <linux/kobject.h>
+#include <linux/mutex.h>
 #include <linux/property.h>
+#include <linux/types.h>
 
 struct acpi_handle_list {
 	u32 count;
-- 
2.43.0.rc1.1.gbec44491f096

