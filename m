Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195289;
	b=D+UJ19/D3NYCfvBz74OCRfLncCx/Q7uBh0R15W2XBs9LLkvVgbPIhQoWRfYU2gcZk/hj
	 LnVWHRjv429QXvpaMzFkeKbqL/0JD+rdWPQon5Iq2kwzdVx8HeGxS8dbigCOveyEY9xyx
	 VVALlaRknh46Lk33x85DleHYiJfvJoeICe5/c2rSNrNMdBehM4hZAuvjv9gWE/YbmULLH
	 6lo2QSMNUcBao6zUn0En/y+TnaD4/63uiazVYTVikVvfsyTqL0opEh+pdY73MyAOWFrHZ
	 8WX2AjtPSuDbHG4oyhTWkMod6GAD15L3JyZL8T/Vf75NAiygpzMvI7OIbG4/x4VjOUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195289;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=P9xe+qRAP1Fr/k/dRI1syyzgdMwRtoISIeM7ZMGFR+s=;
	b=1kUrXiZ7mOicdFkIZRZkZaTcQFemAq9fwF3GeyzP84rqoSCLHlG0va67y6pOPYYgIYlO
	 ceWoymdis0RYzOvj4gsw+2FXz5+i7/haeiQYDKF1B1DwVpBnIK/6mu926+ILOYJ+CCIto
	 m9Wrfvpl3ke9n4o/rUAhlVvwjZ+mxPNbXopzA/wVK0Nxru+kxohRkHv3qaxQtw6tYj5M3
	 qqlLqPQ1XSYSNR1eYSrgGicJF0g3+27KYp9fs7aJZSHsC6JBIaftgLId61POm6MH0RdtK
	 g3rDJ9FPL9nCxLPqys5sCGgvd4sEhKJqx6CUBu8mpDlQqJ2vhIwY2shijQdiTqFZrsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Un5evVaK;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9843460A2624
	for <acpica-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9843460A2624
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Un5evVaK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195280; x=1826731280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k4nlYJftHwM2OZoA4odHyHDiCKslBzINrZFjScUTRGo=;
  b=Un5evVaKnAPWNynJBWRwmz3vhZAobwILCqaHXrnWz2VZwlg1V79RxOyY
   hqAUKI2M0Mpo/zNvFYVMWVcVzrvDaqtNNTlRAXYXTQy5barKulmvQxPYs
   L0hdpgX3fUGn0HEQ6BTvliswAoPw/iXKQWs34+zs8jPedCnuLr2+dZdJ+
   n+6IzyY01akoq6idGYpti9MCt0DHZ/zSwbeFMYotrgGSCx53XKR6sgAgA
   1K6bWz3zNIncF5iJI5mJfaDbOzgSlQB5hXiV1/nlnQKP/lMfSbw674WuT
   Jdpq/1BhAvm9ClxyrjsczTl1XlFAIwDGi6cNnsNerNjLXCefFhP3jZFOz
   g==;
X-CSE-ConnectionGUID: loIa8WHXTcGoROoE50j8dw==
X-CSE-MsgGUID: 6BuRiW63QV6bUVRlGzS/aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157476"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157476"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:20 -0800
X-CSE-ConnectionGUID: TWCHiv45S+qLKEA7mpCRHA==
X-CSE-MsgGUID: bb6Znja3TCGVghJVijj0GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868135"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:17 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 25/42] ACPICA: release: Update version to 20260930
Date: Fri, 20 Nov 2026 18:18:46 +0100
Message-ID: <4f02e8d38f5dc68d023630da0cf14f2bae45c7cf.1795194329.git.maciej.wieczor-retman@intel.com>
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

Write most relevant changes that happened since the last release. Move
the release notes to a markdown file for nice formatting compared to the
currently used txt file. Finally update the release number.

Link: https://github.com/acpica/acpica/commit/e85aa3bebaae
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 include/acpi/acpixf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 9557462e0be8..051ea76b7f5d 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -12,7 +12,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20260408
+#define ACPI_CA_VERSION                 0x20260930
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
2.56.0

