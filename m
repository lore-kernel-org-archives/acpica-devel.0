Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195304;
	b=5eMVYVkQMBC4P0t+9Kw3QRkrn1u4WxtEc0NFBXSRQ1I1l5bIBKYcYYr/JuujHW7HdRPc
	 lub6IZDl8uv1ZMo8QjOaJOwQtWDXnDVsZRyly86FP1hnJbInQYIknSDY0r2I3xiLpIHqC
	 vKlnh2fBPtY+5XnLVbddzs81riw4gT+VF71E57hzYLu4fZkSjosOfeqGaYAcG7aibN5v3
	 s3q+MHIs1TVPbnwUv9kS8R3h8fZv8wuAI8hm/FjThEpmjlX5SM1PhBldrgj7V9ABHJFZl
	 4Xn+h5A0wxgTEI4ocDXuNgTChjy4YkRiak8HPbjYLR6V3bZKtaeODzABKWC7EHgJn7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195304;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+LDM4HvgTQ8zLPS5TGTJFL1xTOJg0NIQcpVpHembXYc=;
	b=bgvMgSvYYj4ZO0Q1ksvA7pKVLGOXfMPPII6DuiJ3lO/PjXqBrmmPT7TZxffD5bZw7+TY
	 l4PvM94ksTRvQjtX8mE03zf+L6gxDKQ863/zYuao9vr9NVayJYh8jFXfaIl3ZMvrHvo4V
	 Anxk9OD4ON+FRSXwHI1zYYuLSqa0xOaT7M6VNpGU+K3vcX3ocuiShVIzOr9+u1IwAAMQs
	 ok32SAOIjoQ+9OLdDzCW/46YadIfCwJETIcsAvEOwM/5vsYM4tuNbYIcHi0HfcsGP5wyT
	 FyQZ+9nP+XRbXzS+5RrIikPL2KSQBXMl+94NN0sz1xQHHbeaUeY4AUMLY27ZsYTvx8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eJHV9uWt;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0BB60A382F
	for <acpica-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A0BB60A382F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eJHV9uWt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195299; x=1826731299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dsO4iylP5qjl86UgafHuRFeXwcuNunbBkQmoKM17W98=;
  b=eJHV9uWtX6cdjwKr+RvW/7yQEoTwICgjEoqC6LQ482WAWBKvFV2GdNJE
   gzkVMk695QLFTViWCB7NPxqXkbVkAf4OpBUK/sMbc2oL8DPfuftFWV6fv
   sRCFyNdjs/qzddj4UwVZ+v0D/nlkjVNn941nocpIXerQUI3G+1bmbXA4r
   mk3yC0kI7YIzyuna61cJALXPjuv7Y3C3jFQnL5ackPiONrkim+1As/8Xp
   /bobyIrArlpwYJAj/AF34qcTLFO8YOv4IgC4zmbvfACSxh7zZVkHztmEQ
   wWshIp77MS5sg0Kzj2umjrk3zmDH8uXPD8v9QxNXatpunQ2O2/xJwtGpX
   g==;
X-CSE-ConnectionGUID: G3217Iq/TZCkP3qB0QmxDg==
X-CSE-MsgGUID: yUtZdmNXRqqVuTeoHJfNnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157533"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157533"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:39 -0800
X-CSE-ConnectionGUID: uHEVtNpuSlST8y/88Qlkyg==
X-CSE-MsgGUID: 8GJ93UBUT3ae940o0Ype4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868205"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:37 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 31/42] ACPICA: events: Add missing event mutex to AcpiEvClearGpeDispatchByOwner()
Date: Fri, 20 Nov 2026 18:18:52 +0100
Message-ID: <8fa96a3a40ac4e7f19679ace75ab3ccde1517bfe.1795194329.git.maciej.wieczor-retman@intel.com>
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

While AcpiEvClearGpeDispatchByOwner() holds the global spinlock there
are other GPE related functions that work on GPE blocks and they acquire
the ACPI_MTX_EVENTS mutex.

Acquire the same mutex around handling GPE blocks to avoid any races
between the different functions.

Link: https://github.com/acpica/acpica/commit/fa543fc1bab6
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/evgpe.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 93e205c0709e..f74805507529 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -576,6 +576,11 @@ acpi_status acpi_ev_clear_gpe_dispatch_by_owner(acpi_owner_id owner_id)
 		return_ACPI_STATUS(AE_OK);
 	}
 
+	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
 	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
 
 	/* Walk all GPE interrupt blocks */
@@ -629,6 +634,7 @@ acpi_status acpi_ev_clear_gpe_dispatch_by_owner(acpi_owner_id owner_id)
 	}
 
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
 	return_ACPI_STATUS(status);
 }
 
-- 
2.56.0

