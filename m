Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1684214BF8E
	for <acpica-devel@lists.linux.dev>; Mon, 25 Mar 2024 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370098; cv=none; b=H35L58S7hrg2D8xsZRdgB5CYOzaYorB0KcA1jsBfNgPCBt/N3/8XhsztuW6QbFBaJlTVjuyqQS4DQEPB58S1xW1FCW6Cjm6CKhOuWYyfMWSB8oQXF1xS+Frx+mrrX6KTOQWwaOBNNe8b8B4lFa2tRTuzGrQcNVw6baFxwD8/Erc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370098; c=relaxed/simple;
	bh=90eQ8H9NeVyKRfnXGj9oSY32Oak16lSvywalPic9hkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYByKMqC6XE+ppbg84JQB0b532SGVUyHDK5ct9zgB09f2a9pN9ZSD9d47ZXG9KKpUf01M+mRZ2QbPuwUij9Q8crLOrXOISoqxAuPrVH1juyPXJUv8TSldmyrzsV5AylVT+L2lNn79oxexamH7O9shb3uL5S1AdJGkM8rlrxet+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dThJY9QE; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dThJY9QE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711370097; x=1742906097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=90eQ8H9NeVyKRfnXGj9oSY32Oak16lSvywalPic9hkA=;
  b=dThJY9QEVc0EuRTYBox2Nt05pZO1dwzHjCpQvUBN8+VCRg+ed7ARiRTo
   Bz6fw+grwoapUEHAAFy/9pkLHPtGIkeOQhmhKvgsBl4ybiLWewyGDXpN8
   0NL6alVj7UQgf7EC7AuFb6/IAUMNv1esp2hzK0x3zs309eDN5oqD+TGsM
   XzUhH2Mo2XevgzVAiDZUaiy2/TJXKLRQ6IezjHiqZqoSqDAPoj6/O6zqw
   7xpXG2KQqgi/6jfWJrHPGGnf4ZINvenorbtBrIckjKsJ2f0pOVjdXB/40
   GNfM/G6Bn3MoesSXhZ+KTCVTh7EvF4n4dh1GeTtXFLZ6ZtjhSHniMSB+o
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6549706"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6549706"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 05:34:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="937070342"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="937070342"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 05:34:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id F1090524; Mon, 25 Mar 2024 14:34:46 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>
Subject: [PATCH v1 6/7] ACPI: scan: Use standard error checking pattern
Date: Mon, 25 Mar 2024 14:33:02 +0200
Message-ID: <20240325123444.3031851-7-andriy.shevchenko@linux.intel.com>
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

Check for an error and return it as it's the usual way to handle this.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/scan.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index b2785a036a68..45f7ec3b6548 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1579,12 +1579,13 @@ int acpi_iommu_fwspec_init(struct device *dev, u32 id,
 			   struct fwnode_handle *fwnode,
 			   const struct iommu_ops *ops)
 {
-	int ret = iommu_fwspec_init(dev, fwnode, ops);
+	int ret;
 
-	if (!ret)
-		ret = iommu_fwspec_add_ids(dev, &id, 1);
+	ret = iommu_fwspec_init(dev, fwnode, ops);
+	if (ret)
+		return ret;
 
-	return ret;
+	return iommu_fwspec_add_ids(dev, &id, 1);
 }
 
 static inline const struct iommu_ops *acpi_iommu_fwspec_ops(struct device *dev)
-- 
2.43.0.rc1.1.gbec44491f096

