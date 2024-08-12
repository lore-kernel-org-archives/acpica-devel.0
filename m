Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CBC1411C8
	for <acpica-devel@lists.linux.dev>; Mon, 12 Aug 2024 05:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723441625; cv=none; b=cyKAAbT6prgrkmq2zFR7DdlVho3aphQYP2nVm2wMKSlNL8xr9iXOxGgxcY+dOkJ58fNWc0Cvruy5ag3yJDbbosECLXO3ee+ZrfHLNc2j4hevq6U/f/LbFBk+U8cUMZ86E53ERHfqdMk/7HPMm71bu5dqdc/T7NM4lyn97U4wX+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723441625; c=relaxed/simple;
	bh=NKy8y2rPDfmCcLM96A5nesslmK+MJS0mwLn9gw5Nabg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=de3OTKZgqVZk3e/Hn46s61oHlL/2vLCBjy1C6QaB/Uv1mHTYdYwh6aVc40uQZm02ROM1t7PSBRddNOlV92zYwRDEtYWH3MAs9/M1WWtj8HMVvZh0NvGukHl3ZoCKI4MUAQed+WTbAKIqBz8tzSSP2x75ZsjIaEbimYgv54G3iPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NmtlebhO; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NmtlebhO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723441623; x=1754977623;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NKy8y2rPDfmCcLM96A5nesslmK+MJS0mwLn9gw5Nabg=;
  b=NmtlebhOptqOPpgDkF16Pun7RmoasXFy3PiAsmjJ6bWNf5M2Ujrevpvo
   pc9ed/X3cl4M/gCiGzbfAsPgHu5/iW3ElrYT7+W7rI9RKdi+LZqV8Nq5r
   ogWAiEQaxp1PN2kj6dPz3jXixo7zybOawNuu4OiHn3CPlhj1Lx5LRze0l
   fzcjdO//5dXJgeVXzjZosu5iHsZxCIWl9YP8xMtuOOAa3BpiaKigtPOI4
   2ssxUnnR0+IndT/lDO5ibQYwdN5Gbw6EI9wRfeTH/q62x3FRVexqChmoh
   XgQ1fY+0eAVWf5NpNdsBoKkfi+ybqs8XfnulZ65DFLHVXWrnUtwsVhYSo
   g==;
X-CSE-ConnectionGUID: JUG4/uG5RD+fTSifkAcgEQ==
X-CSE-MsgGUID: MV0CSSLjQ0Kd6YbiEUd0cA==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="32925980"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="32925980"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 22:47:03 -0700
X-CSE-ConnectionGUID: 1zlEE0ZDQ628VwOVkDgh6Q==
X-CSE-MsgGUID: sc8Z611tRKSS1+GBLYmMDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="57800732"
Received: from unknown (HELO jiaqingz-acrn-container.sh.intel.com) ([10.239.43.235])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 22:47:01 -0700
From: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
To: Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Subject: [PATCH v2 1/2] ACPICA: Detect FACS in reduced hardware build
Date: Mon, 12 Aug 2024 05:46:46 +0000
Message-ID: <20240812054647.1194716-2-jiaqing.zhao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812054647.1194716-1-jiaqing.zhao@linux.intel.com>
References: <20240812054647.1194716-1-jiaqing.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to Section 5.2.10 of ACPI Specification, FACS is optional
in reduced hardware model. Enable the detection for "Hardware-reduced
ACPI support only" build (CONFIG_ACPI_REDUCED_HARDWARE_ONLY=y) also.

Link: https://github.com/acpica/acpica/commit/ee53ed6b5452612bb44af542b68d605f8b2b1104
Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
---
 drivers/acpi/acpica/acglobal.h |  6 +-----
 drivers/acpi/acpica/tbutils.c  |  5 +----
 drivers/acpi/acpica/utxfinit.c | 24 ++++++++++++------------
 include/acpi/acconfig.h        |  1 -
 4 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index f4c90fc99be2..309ce8efb4f6 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -29,11 +29,7 @@ ACPI_INIT_GLOBAL(u32, acpi_gbl_dsdt_index, ACPI_INVALID_TABLE_INDEX);
 ACPI_INIT_GLOBAL(u32, acpi_gbl_facs_index, ACPI_INVALID_TABLE_INDEX);
 ACPI_INIT_GLOBAL(u32, acpi_gbl_xfacs_index, ACPI_INVALID_TABLE_INDEX);
 ACPI_INIT_GLOBAL(u32, acpi_gbl_fadt_index, ACPI_INVALID_TABLE_INDEX);
-
-#if (!ACPI_REDUCED_HARDWARE)
-ACPI_GLOBAL(struct acpi_table_facs *, acpi_gbl_FACS);
-
-#endif				/* !ACPI_REDUCED_HARDWARE */
+ACPI_INIT_GLOBAL(struct acpi_table_facs *, acpi_gbl_FACS, NULL);
 
 /* These addresses are calculated from the FADT Event Block addresses */
 
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 15fa68a5ea6e..356700349b45 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -18,7 +18,6 @@ ACPI_MODULE_NAME("tbutils")
 static acpi_physical_address
 acpi_tb_get_root_table_entry(u8 *table_entry, u32 table_entry_size);
 
-#if (!ACPI_REDUCED_HARDWARE)
 /*******************************************************************************
  *
  * FUNCTION:    acpi_tb_initialize_facs
@@ -37,8 +36,7 @@ acpi_status acpi_tb_initialize_facs(void)
 	struct acpi_table_facs *facs;
 
 	if (acpi_gbl_FADT.Xfacs &&
-		   (!acpi_gbl_FADT.facs
-		    || !acpi_gbl_use32_bit_facs_addresses)) {
+	    (!acpi_gbl_FADT.facs || !acpi_gbl_use32_bit_facs_addresses)) {
 		(void)acpi_get_table_by_index(acpi_gbl_xfacs_index,
 					      ACPI_CAST_INDIRECT_PTR(struct
 								     acpi_table_header,
@@ -56,7 +54,6 @@ acpi_status acpi_tb_initialize_facs(void)
 
 	return (AE_OK);
 }
-#endif				/* !ACPI_REDUCED_HARDWARE */
 
 /*******************************************************************************
  *
diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index 1915bec2b279..70ae0afa7939 100644
--- a/drivers/acpi/acpica/utxfinit.c
+++ b/drivers/acpi/acpica/utxfinit.c
@@ -120,6 +120,18 @@ acpi_status ACPI_INIT_FUNCTION acpi_enable_subsystem(u32 flags)
 	 */
 	acpi_gbl_early_initialization = FALSE;
 
+	/*
+	 * Obtain a permanent mapping for the FACS. This is required for the
+	 * Global Lock and the Firmware Waking Vector
+	 */
+	if (!(flags & ACPI_NO_FACS_INIT)) {
+		status = acpi_tb_initialize_facs();
+		if (ACPI_FAILURE(status)) {
+			ACPI_WARNING((AE_INFO, "Could not map the FACS table"));
+			return_ACPI_STATUS(status);
+		}
+	}
+
 #if (!ACPI_REDUCED_HARDWARE)
 
 	/* Enable ACPI mode */
@@ -137,18 +149,6 @@ acpi_status ACPI_INIT_FUNCTION acpi_enable_subsystem(u32 flags)
 		}
 	}
 
-	/*
-	 * Obtain a permanent mapping for the FACS. This is required for the
-	 * Global Lock and the Firmware Waking Vector
-	 */
-	if (!(flags & ACPI_NO_FACS_INIT)) {
-		status = acpi_tb_initialize_facs();
-		if (ACPI_FAILURE(status)) {
-			ACPI_WARNING((AE_INFO, "Could not map the FACS table"));
-			return_ACPI_STATUS(status);
-		}
-	}
-
 	/*
 	 * Initialize ACPI Event handling (Fixed and General Purpose)
 	 *
diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index d768d9c568cf..2da5f4a6e814 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -67,7 +67,6 @@
  *      General Purpose Events (GPEs)
  *      Global Lock
  *      ACPI PM timer
- *      FACS table (Waking vectors and Global Lock)
  */
 #ifndef ACPI_REDUCED_HARDWARE
 #define ACPI_REDUCED_HARDWARE           FALSE
-- 
2.43.0

