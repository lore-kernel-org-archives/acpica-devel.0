Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195226;
	b=w9IpxeWLLNALs7z3H5QiISEWHSvspvmW1T0hCiMQNOw6C4T2oXyBIlY4KTSu5S/3G0KR
	 QIL75hG7DXP7tndhglHimXfbQPoQHnFic3uCBpT5WA6Fym65G03CfHSW4in2FgwhE2yod
	 UFvxmxtDk8/4Fn2Xuf/AmMMeW7biSJtN4xySu3PmSBKiTCop6l6m2e3bFTmODnv7ZWRdv
	 T45LNRUx1oVbdB4hTCnscwtCktonSCdyTSDGRZmD4b9HalzI1cVvbIkC6IEYOt35VssLk
	 qyiugdGWxS1ylF49xj1V5iqniX2/ESgb9d2R1eaWihveu+q3QRpH3HFYOixdfi7dasQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195226;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5Q5P/onJTcUW81xkdYnrJMMsfvaW1X71Cpq5f5F6Drg=;
	b=yUrz22pdxjUL9ZgIHuskQUdGQc+c29M0JTJRUSjrTB1rYri6lZVBEeUV44DRK8sWxeO1
	 qOtUryr6UTKb3axX4LG3wjZ5T6l1Bmm1j1K7FXpIjPJz/WU5gSWI13nhwGw+LUkuZq7QL
	 pBCncdKOwxNuTclh8GR9N3KlvaCoKcrcW3554FjU8UXfkNDomq9tFH/nDS3D7+eOtvJRI
	 go/8fNmsQK2UZ3ry57WP/7KWzDQPLFFYY6wqghJpwrc08x2B79Bbn56TQJB0eVrI0T2K8
	 I5LvQbEqEH0KB/c8UvD2iiZNzZfEuhHXD+KFz0PLN5/aDEXhiOOSVpxs3Fy81+sHKyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CcnlMBfm;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D26260A262B
	for <acpica-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D26260A262B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CcnlMBfm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195224; x=1826731224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7z9Bas6WEyT7Cowz8cSJBJ4gbIfztcmfm6g/6W7XHTo=;
  b=CcnlMBfmuBnaAJDqjLUx+vqrEytcXDVGaw0s6TSZQqCXTR9b/Lukl08i
   FrZrMggdMeDfQ1QCGr9dRUlmFxGhfBX3uFGukGPSiX7I48Al8rwBpRm6E
   OMBupi02RZ4MRl8JFIvtGZR1oG+HfFitRnzoGUpMsR8YLLyxgfLrKBh8S
   V5LHxW5ipMvex+7xt4Fpq/8uRGeoI61e2IxRbY7lXa/duTrg62RnEXmcm
   lez4bn1E7mZWEgBiTZIUWqNJxiPrjJs08U3rN6ry3xZp2/qG6pTrMXmfa
   89CrvDF/HxR2TA7wJHAey/kg2AzT6RDeu+8pjyIxaKVGsgPKRS/9H6D8s
   A==;
X-CSE-ConnectionGUID: p2tXzCq2QEi3ilSRFGX8zw==
X-CSE-MsgGUID: QzSJ5SGaT5OgeuCPY1yI7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157293"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157293"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:23 -0800
X-CSE-ConnectionGUID: XWaC8FlMRa6GEX/ZZxkAXg==
X-CSE-MsgGUID: wPOGs+GTSg+P78z9P8k3Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10867855"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:20 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: Dave Jiang <dave.jiang@intel.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/42] ACPICA: CEDT: RDPAS: Add missing reserved field in RDPAS structure
Date: Fri, 20 Nov 2026 18:18:26 +0100
Message-ID: <fa4dcd0bbc16ff6e9d7470c38d68f968bfb91004.1795194329.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1795194329.git.maciej.wieczor-retman@intel.com>
References: <cover.1795194329.git.maciej.wieczor-retman@intel.com>
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Jiang <dave.jiang@intel.com>

Add the missing 3 reserved bytes at the end of the RDPAS structure.

Link: https://github.com/acpica/acpica/commit/88d82d3ae53e
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 include/acpi/actbl1.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 73ebc089e96d..5b4207af046a 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -590,6 +590,7 @@ struct acpi_cedt_rdpas {
 	u16 bdf;
 	u8 protocol;
 	u64 address;
+	u8 reserved[3];
 };
 
 /* Masks for bdf field above */
-- 
2.56.0

