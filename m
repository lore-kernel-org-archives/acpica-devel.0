Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195286;
	b=ngrKUb0O2WspcEDRZAGy9nNsCnBLjVQp3T6QLeUVM6DmvdlA4EXrITkQDL3dV2Mc08qV
	 /YrZh0p50q3lY5qfAK2R1wsDL2LimTJ4ZQ3i3usvjGIWL7xsLaWT7tKlky1YkZt5tSJvO
	 LPeg7gSGu8mxpVp46GHQJEPsy8qWrBsRe6G7tGszI6jjLRzqK3ezyE5bTT+wCChEPLdBH
	 HGkNmsbwPGpqI13k+QK+/bF+Jzv5oYUZUislFy9ROcFxieI+Zyn6wW1cra5ia0jU1xcCl
	 sNjX99SSHWNflO0kwY8G19+RLCwwMeFOxaLisI1AozfR4SAtUepNqfQ7KskVThm1Mqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195286;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uh0h/NWGZB0gU+Sbi2kIhBH4+D7ZPc0i9Ti7NLqxMvk=;
	b=waYtXLNgEWetZuuOqFDP2XSXAY9vPvgw4PFcilo8n9cIWTrotzMkxEEhsDTSE3lutmCc
	 tROk49H3Hjpdh1tG6Q6WB5Z1T746FPinH/P0uXqxTXZeTakZEL+XkA7jbuCj5NvjDTeUd
	 BD5U5Q2uAkkZqIWNlpXDhI2taDFlF2YPnuQiMq1COOPj7C3AIz2gyjzYvB3KwrNElQBiD
	 FdV74TnGzHGzcCq8FG0IdFdko5mVyQYnupudQgsx2x21UHwU7JgRw/GZkG1Eu+Op4+9k7
	 RJIXDHo+VjNEhwiLpCijJsUxbmBeRJ63PSlC7bqy2Vl50k4NTxDbxQsKQIj7eSuEFVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WzEb2hi3;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DAE606A77F
	for <acpica-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1DAE606A77F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WzEb2hi3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195285; x=1826731285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wt/0GyyCP/XOuyFnf358qLapGc12smKbmHr+dLhaH+c=;
  b=WzEb2hi3WDuXDW1cNcWNSziOaWcyjHucxLMnpQrGzrsE4xDnYnOW0jOt
   O75RXFcbQU1ogLuaNjxSfXEySOmKWFJHArdPs7fvEMv+For4m52fBH2OS
   72md9LrvmAp9mAAmJiz7bjPble+YN89KjVHcs02WPHVuaJozNTo/AAnF7
   O7LMcXUlWaNlgcnNU/7aO3GcuNe06cUZIcL2j/3GgvvK4k8HEuVO6v1DI
   ffz2VZ9vxM3P3i+cwYMvvOcg8BYPORFgNMGInc3zSa4E5qiihDSVFT+Y8
   2exdoyHZl2HJJMKOHtQpB76w9iHPKX/eTi0taegEwod54DN2u+Y7JXeOc
   Q==;
X-CSE-ConnectionGUID: 68eDMLM6TTy6Y1eeUl/gNg==
X-CSE-MsgGUID: EAzHBixTRAa/ImV82rX1/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157484"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157484"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:24 -0800
X-CSE-ConnectionGUID: HnNbQEwlRCK5akyr6REZAg==
X-CSE-MsgGUID: Mdg61pORTJuETMA7oVNI0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868156"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:20 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Cc: Andre Przywara <andre.przywara@arm.com>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v2 26/42] ACPICA: actbl2: MPAM: adapt to MPAM ACPI spec v3.1
Date: Fri, 20 Nov 2026 18:18:47 +0100
Message-ID: <28fcfb138c8630dd69e738306a79afb3dae29410.1795194329.git.maciej.wieczor-retman@intel.com>
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

From: Andre Przywara <andre.przywara@arm.com>

The latest edition of the "ACPI for MPAM Platform Design Document" (ARM
DEN0065C [1]) re-purposes the current Reserved2 field in the MPAM ACPI
table to hold an offset value for the MPAM Firmware backed interface.
Also the MSC structure gets abstracted a bit, which renames the Reserved
field to type, although it stays at 0, for the time being.

Rename and describe the new fields in the table struct definition.

[1] https://support.arm.com/documentation/den0065/latest

Link: https://github.com/acpica/acpica/commit/4f4a36a99c1d
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/arm64/mpam.c | 6 +++---
 include/acpi/actbl2.h     | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
index c57bd367922b..671ba501379a 100644
--- a/drivers/acpi/arm64/mpam.c
+++ b/drivers/acpi/arm64/mpam.c
@@ -331,14 +331,14 @@ static int __init acpi_mpam_parse(void)
 		table_offset += tbl_msc->length;
 
 		/*
-		 * If any of the reserved fields are set, make no attempt to
-		 * parse the MSC structure. This MSC will still be counted by
+		 * If the reserved1 field is set, make no attempt to parse the
+		 * MSC structure. This MSC will still be counted by
 		 * acpi_mpam_count_msc(), meaning the MPAM driver can't probe
 		 * against all MSC, and will never be enabled. There is no way
 		 * to enable it safely, because we cannot determine safe
 		 * system-wide partid and pmg ranges in this situation.
 		 */
-		if (tbl_msc->reserved || tbl_msc->reserved1 || tbl_msc->reserved2) {
+		if (tbl_msc->reserved1) {
 			pr_err_once("Unrecognised MSC, MPAM not usable\n");
 			pr_debug("MSC.%u: reserved field set\n", tbl_msc->identifier);
 			continue;
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 9af7c51d1297..8e0d5156e6d6 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -2004,7 +2004,7 @@ struct acpi_mpam_resource_node {
 struct acpi_mpam_msc_node {
 	u16 length;
 	u8 interface_type;
-	u8 reserved;
+	u8 type;
 	u32 identifier;
 	u64 base_address;
 	u32 mmio_size;
@@ -2014,7 +2014,7 @@ struct acpi_mpam_msc_node {
 	u32 overflow_interrupt_affinity;
 	u32 error_interrupt;
 	u32 error_interrupt_flags;
-	u32 reserved2;
+	u32 mpam_fb_offset;
 	u32 error_interrupt_affinity;
 	u32 max_nrdy_usec;
 	u64 hardware_id_linked_device;
-- 
2.56.0

