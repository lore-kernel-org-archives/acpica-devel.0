Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7F11420DC
	for <acpica-devel@lists.linux.dev>; Mon, 25 Mar 2024 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370096; cv=none; b=ZzJx/SmX5xMpBIUNidmwo155hPtUchhqtMJwqREAAprHXPdj3dc3+mAZAPlfgW23l+rC96+/+30r43SX/XdRTaeNd4qisCnBaxn1zh4VIFo2o/DF/Aiuf3mAqBuVN12Gb0s8SRdv2lT3iOVbNQQu9p5OqS6Xso4rgtEKlpxVkcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370096; c=relaxed/simple;
	bh=kOSHnnIN9sq3z7o0gS6aJTFnjb5+mMzfpmkgeSG5CvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ij+TNt6TyxHwnPUYgyDe8uy8ILIn0u8MpdYDVc9c1EANVKIM/1aAr4vk39PJcF6sqz4As9Wvzc62+tkLBpHZcWMQEHIbh+ikdrwtcOBpYvJsBYq/NG/kJdYQudZ7TikFvh8J5T6Fl1eWQOEVTnrxS06lCSR3C1gzAumwSG0aBRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GNN4L1Y1; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GNN4L1Y1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711370095; x=1742906095;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kOSHnnIN9sq3z7o0gS6aJTFnjb5+mMzfpmkgeSG5CvI=;
  b=GNN4L1Y1+xhLOZCOuW/ZITUfCgeeWf9m4KxFBZerkOvh4HkQUf8nLofj
   s6wKBinsAbW3jvqu9eF0OdZJ9YWqLSouFzh+FdNV2IpT8UgxzglX/tmlu
   JzQZaoAW3LwCXcL1gJUEyvttN65gpCG9fEuuIUPQxRhfEAQ+HFFk/20g6
   Os3mDZolVXbn3+Gmfql8YoV4ky+mCqGxVPWmU1jBRjOBJvqkMsHjEN5wD
   jxfuVfI6VCEMii+ku5vYYu4sEvqnTyerEyw4VL51jldlKuXU3vcFG1T+F
   VOJ7HuF5Dq8wtnzoDrG92fKiZyr50IyyeINp6I0N+Zavv6K/+4Go/erEI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6549687"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6549687"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 05:34:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="937070329"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="937070329"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 05:34:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9B8B2228; Mon, 25 Mar 2024 14:34:46 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>
Subject: [PATCH v1 0/7] ACPI: scan: A few ad-hoc cleanups
Date: Mon, 25 Mar 2024 14:32:56 +0200
Message-ID: <20240325123444.3031851-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While looking for something else in the scan.c I noticed the room
of improvement. Hence this series. Also bus.c patches, which some
how were related to my research, but I think are independent from
the scan.c improvements.

Andy Shevchenko (7):
  ACPI: bus: Make container_of() no-op where it makes sense
  ACPI: bus: Don't use "proxy" headers
  ACPI: scan: Replace infinite for-loop with finite while-loop
  ACPI: scan: Use list_first_entry_or_null() in acpi_device_hid()
  ACPI: scan: Move misleading comment to acpi_dma_configure_id()
  ACPI: scan: Use standard error checking pattern
  ACPI: scan: Introduce typedef:s for struct acpi_hotplug_context
    members

 drivers/acpi/dock.c     | 48 +++++++++++++++--------------------------
 drivers/acpi/scan.c     | 42 +++++++++++++++++-------------------
 include/acpi/acpi_bus.h | 28 +++++++++++++++---------
 3 files changed, 55 insertions(+), 63 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096

