Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195223;
	b=LdjP0Ici+ymaH1yZ+69ZivGmXn6tjtYZbjwVjsBL6wq6YQ2M+RsBLYUWw0GkRCwJHlNH
	 MgwdCS/qkht4gIXXSwRAOv3kAkTqMF2l/BL/5RGxMLaj4bgfWtYR++0qvYk0ixugk5Jsa
	 Mog9nERw5ajlMzq7iDcveOMyG68NqXwT7xHuibXNix2aL4gYnG2vd8IWUHL4fz4vSHe9s
	 82p1W68OEPFE+CZtm7/1F8qbGARdqvO79ILpZBO2iCCfsQaOBqQ2uRwWQyFARqBhZ++V1
	 6gdynLBp3AVZXbxHof+sZW0h7AL/sdeNFxKipgIF9E8lZWHG08vcTsd14fJ9chJiDeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195223;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2SGcjlFCiyOnjLkwuMzABbqYCEOMPMNhND8POP+Mkec=;
	b=UheRmVIVi12z06P5iIJhTrA2pHOCWfuUD87+TJKMxKOo3uJQHhjX+5kHs6VTjKBaS/7V
	 bAAgrtWAjvg8197FmkXn9UR76CG28bb7peue9x6A0FOno72/mscwjeVDy11oM6yVrwqcX
	 7Cc5kT3TN3oflcCk3HB//aR8sqqbiBo8S8+NIx8XWYgUHSXAkUfeaPGZdO8V1IqjiBRF2
	 rbI6pjdwrsA2JJ+qVcp/doS0FTP4PMjsWf8lrvKav+EOJtIumLqRb2NGB96kaqcTIAkme
	 CCGlsaezZlcrDejDTrQNhLh+c6cRHVxlSlzDJevq+lPXNjtuwgF280A7Uh6iTj9nUNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BqmbnsGP;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8755260A2623
	for <acpica-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8755260A2623
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BqmbnsGP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195220; x=1826731220;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KrQrzEM4wkAJkpi4yxypXu0EhFHq5RHYGFq9C1k5hsE=;
  b=BqmbnsGPClDOQRRGzCvORHjLmxtdPqIQUmrtQzRGr98CkPT0S7g6hfFa
   p78kN+yRyM/R87+qnXeROXBK5NSJCat8jypVkBCNxu5lXLiUx39bQg9KK
   VVgNfB3mUSDw+dBiPhE0q4dU+YDz8oJbYWuY0khKJITdtJxPwGB51Ohmd
   31gwrPe60RAsU6an2gO/B8SRUE5KIOxdVbTUmSWJAtXY1CvxSp2k+ruUx
   juQbXkvlMK6JtKfEq8GiFCDIamf/DPo+6/iF2Pf4o+EoOduZcE2eDZewC
   NIvdETEx34GblbFBi2kU8xsR90PeIMz87u6MXRDu9W/Q1zKXUk/5aEBI0
   Q==;
X-CSE-ConnectionGUID: cLicp4PlR3GlxZCFSUcowg==
X-CSE-MsgGUID: Le1wpDWsRxub8zWMJMRmxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157273"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157273"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:20 -0800
X-CSE-ConnectionGUID: +2XXp8W3Tou/zh7ksQGkvA==
X-CSE-MsgGUID: 8/A4UCJyQl6SnnTkOLo1+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10867846"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:17 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: Maciej Strozek <mstrozek@opensource.cirrus.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/42] ACPICA: Utilities: Fix for AcpiUtVerifyChecksum warning display
Date: Fri, 20 Nov 2026 18:18:25 +0100
Message-ID: <b81de24dbc969539ad0b7b2b386ed4d26060def7.1795194329.git.maciej.wieczor-retman@intel.com>
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

From: Maciej Strozek <mstrozek@opensource.cirrus.com>

Remove redundant subtraction which is done already in
AcpiUtGenerateChecksum.
Looks like it is a leftover from a refactor [1] where
AcpiTbVerifyChecksum used to call AcpiTbChecksum which does not
do the substraction (like the Acpi(Dm\Ut)GenerateChecksum does).
Found by using iasl to generate checksum for SWFT tables.

[1]:
https://github.com/acpica/acpica/commit/8ac4e5116f59d6f9ba2fbeb9ce22ab58237a278f

Link: https://github.com/acpica/acpica/commit/9b2b1dd021a6
Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/utcksum.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/utcksum.c b/drivers/acpi/acpica/utcksum.c
index 040e34569ac7..1be8b5da055b 100644
--- a/drivers/acpi/acpica/utcksum.c
+++ b/drivers/acpi/acpica/utcksum.c
@@ -58,8 +58,7 @@ acpi_status acpi_ut_verify_checksum(struct acpi_table_header *table, u32 length)
 		ACPI_BIOS_WARNING((AE_INFO,
 				   "Incorrect checksum in table [%4.4s] - 0x%2.2X, "
 				   "should be 0x%2.2X",
-				   table->signature, table->checksum,
-				   table->checksum - checksum));
+				   table->signature, table->checksum, checksum));
 
 #if (ACPI_CHECKSUM_ABORT)
 		return (AE_BAD_CHECKSUM);
-- 
2.56.0

