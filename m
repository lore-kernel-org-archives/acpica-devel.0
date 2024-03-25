Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692EC1420DC
	for <acpica-devel@lists.linux.dev>; Mon, 25 Mar 2024 12:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370097; cv=none; b=VFON+AQIIL7D6kBp/mocPKcRZGHEYfTqNjmSCek81ngzLjeU13nFGEFKM+bu+QvtMOC9sOFXSHLsjFl5pSwQeyH7lUmntdiCQEpMgG5+h5YxA/0nF732eFz5pw8bGDoXCIJ90NsSAh9yjEJYYklwQ2K+AHY2b2xIIrFVkv4ltwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370097; c=relaxed/simple;
	bh=kYaSqMOPeljRP3bQrvr/dBmRA0QEYgsB0ELeJUX3x+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thdFkKmXIiZS593OalDuSJJ7PNRrckbq7ZtiIr3CnK7q1Rw6ux+Y83jJfhk0B2pr5lUN+2ebATth/UurSCGPfFj9dpcL0J1EhwTa3WZ7V0Ip5SELGCW6REeFpNjemZjA6tmKnkADZ59s6aA+8fpswBuAG1iNN0X+5HN19I0plyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZtXSjOjJ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZtXSjOjJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711370096; x=1742906096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kYaSqMOPeljRP3bQrvr/dBmRA0QEYgsB0ELeJUX3x+g=;
  b=ZtXSjOjJKAzax9rURvdv1RD81//8aHiSb2MrbN0aeq5XA0VcpdJ+zfJB
   kiKOzzrU6Pos5I93kXe/IPyalcnqqBndaR2jMw7tXvJKTKV4RLfT8NLsZ
   chWpFUTihA4vVvwqBG4DpGDK/recfO3pQfB6EaTG5729A0hUAoAIb32Tw
   1e/ThVwNEWac8AMrbAIlaUVTsHk/gFbroX1LbS30rsPAuAV9l24lRCqoy
   cAW2Mk/rUTQDOb7okns59RHX4ACAODyImt28UVmpeMIZQzRjdZvosRq2Z
   nQDrdJnPP3hwbuw0Ui4pSF3S1QuE8FeE+0v1DzBdp61Q9VxAttxwgaL+H
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6549705"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6549705"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 05:34:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="937070340"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="937070340"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 05:34:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DCC693C5; Mon, 25 Mar 2024 14:34:46 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>
Subject: [PATCH v1 5/7] ACPI: scan: Move misleading comment to acpi_dma_configure_id()
Date: Mon, 25 Mar 2024 14:33:01 +0200
Message-ID: <20240325123444.3031851-6-andriy.shevchenko@linux.intel.com>
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

The acpi_iommu_configure_id() implementation has a misleading comment
since after it the flow does something different to what it states.
Move the commit to the caller and with that unshadow the error code
inside acpi_iommu_configure_id().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/scan.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index f5581d3701f1..b2785a036a68 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1623,12 +1623,11 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 	if (!err && dev->bus)
 		err = iommu_probe_device(dev);
 
-	/* Ignore all other errors apart from EPROBE_DEFER */
-	if (err == -EPROBE_DEFER) {
+	if (err == -EPROBE_DEFER)
 		return err;
-	} else if (err) {
+	if (err) {
 		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
-		return -ENODEV;
+		return err;
 	}
 	if (!acpi_iommu_fwspec_ops(dev))
 		return -ENODEV;
@@ -1669,13 +1668,14 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
 
 	acpi_arch_dma_setup(dev);
 
+	/* Ignore all other errors apart from EPROBE_DEFER */
 	ret = acpi_iommu_configure_id(dev, input_id);
 	if (ret == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 
 	/*
 	 * Historically this routine doesn't fail driver probing due to errors
-	 * in acpi_iommu_configure_id()
+	 * in acpi_iommu_configure_id().
 	 */
 
 	arch_setup_dma_ops(dev, 0, U64_MAX, attr == DEV_DMA_COHERENT);
-- 
2.43.0.rc1.1.gbec44491f096

