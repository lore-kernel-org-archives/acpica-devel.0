Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195303;
	b=FWOqb7wpLsyC4gIgVk9vGfqtJr5axLTC+jar+H9ZSNPotNUV8mXIhPTTjKkVKq4JMPw5
	 lG3hqMBSNnsOeROKgLneOmdKm7VwkMBpifHNWdxfTYzAqoXb8MXP1dWvhre5rW8EKRecc
	 lvcGSZArbo2EUCVbqyMdOUCsQB00Ta2yVSUGNYqegrd7PAE3jF3/MEsvM33fQhtC9EhYK
	 rq6FzSjelBdydfo1uwlnmuFEyXRMqcduf0SqaSa0zO143WcFEpPXDcmXGxnJ8/Uvz+9wG
	 pwJ76zehI0PfwjtxeY8F1CpdGmo3PK7tOS4YDomEJvTbNBJF+IYTTqYZNyFnILmYpMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195303;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6iXYH4zgRiCKj6TFFGT8b8gjNXrkc/FF/5cTssJWbTk=;
	b=BGu8YQ6cEqrLgMEIYgnuzsQ9zmCLpAMv6k4yUyT4iGB7SqJ4mPn3gOOKnXKuQ/j99CfH
	 3XS0glHGt7VcBm7hRuX7y/D5HyOq5aTVOxi2wMEIC5NkMISLJ7c2b5Hwr0HHdsnkhhdNC
	 xgZgGZrt0MC76qtlBUPgfHI0BLDDqS9zT+es69peCSY4fT5HiDMda3mf85r/iqb9tRGnA
	 AGBHYpV5Dg4ApTMyt8zy4h/i+c7NkHwWcawPW15t4+xvhzEYl2qhymtPRdGE0D8G9FgXh
	 k+mTQ/UrITCWVr3IXQMi1ppBk/dqunU7UK55J6RQqS6k23SnwjELzQQFU4P3WPYxEEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="lgfO+/Sq";
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BCB60A3821
	for <acpica-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02BCB60A3821
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lgfO+/Sq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195302; x=1826731302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YbTf5trDopxe02aOZT+b3VJbn+3UJdoGzNpd2Ze/ER0=;
  b=lgfO+/SqjrMA5bB2+uusSDzd1PUZedVbHFTQTVGGrkPj9qJAkTrAU5wW
   0oWDACnz26r3hnMwWCSkrAQazQBhVUxswU4rtZimObFtSuYmfNLBxUrmL
   FZQeApX8ixVYVjJSBxqEKpIlc1jkAcCYfKHkgHgskJ1ba1Ew3Kk6kjcG7
   Ygm3ikFOYE6xxO06EMDuHGyEfttFMg0GTFVec2ofT+KoGFYIJMl9dnVwA
   ZeVWnxOklSchLr6DVMQYGO3DLa7p4rNi07AFLrr5BjhUWy5NdfiEb+yCW
   cZr3tPOLnepRWVcb04/bC2HDzQmRZ3f1X7yFfbjCy3wR5x3kPkewA5bEB
   w==;
X-CSE-ConnectionGUID: KNuj/GAxT2ih9KoQcJPU2Q==
X-CSE-MsgGUID: +W7LmW7WRwW2VdCYT+xQfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157541"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157541"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:42 -0800
X-CSE-ConnectionGUID: Zn/RYkVbSwmQ5+rr9+/FNw==
X-CSE-MsgGUID: Ws7EdMu/Tv+1IHlAX0hiWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868216"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:39 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 32/42] ACPICA: events: Remove redundant code
Date: Fri, 20 Nov 2026 18:18:53 +0100
Message-ID: <5071a5286e570bc87844df41525ece3738601784.1795194329.git.maciej.wieczor-retman@intel.com>
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

This snippet happens inside the case part of a switch/case statement. It
only checks whether the switch and case value match which makes no sense
since they will always match. Remove the check.

Link: https://github.com/acpica/acpica/commit/a7f8f92b0422
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/evgpe.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index f74805507529..578651cde6f3 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -489,18 +489,6 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 
 	case ACPI_GPE_DISPATCH_METHOD:
 
-		/*
-		 * Re-check dispatch type. The table may have been unloaded
-		 * and its GPE dispatch cleared while we were waiting.
-		 */
-		if (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) !=
-		    ACPI_GPE_DISPATCH_METHOD) {
-			ACPI_DEBUG_PRINT(
-				(ACPI_DB_EVENTS,
-				 "GPE method dispatch cleared during wait\n"));
-			goto error_exit;
-		}
-
 		/* Allocate the evaluation information block */
 
 		info = ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_evaluate_info));
-- 
2.56.0

