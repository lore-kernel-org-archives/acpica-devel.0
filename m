Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195250;
	b=lPttZSXspF0Ka3bzU329IYD7mrAsmeHNy86tdGJZom+XlmOhp5qoCsZtp42pYCAWKd6r
	 e/FOvKyQvU+yfCiXni7gS4mkJ+tA5aOS/xvGOiGuKZHKQewuebZ5NiJWXnSZ2dB7o0A3F
	 48fcfdQ7IgGXLH9hjH5T6ZUjhRe1stT1ZfQ80+EL13vtCJ+/NQ4WPmLXlqZHLfO5FGnIF
	 9jaIoEzxQMTHWf2dOlmJAPq6IsxYH8eKDOmJhVCd4l3BH/gpdmC3TUv0KcyJDNKBr/1Nk
	 Wrk6TZpZKdcx75PqqHMgl4JCAM7sAvFJgbPAgbWQxzJmH/uXnDvJAFqQ0njtwHuEcFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195250;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oOh9H0/c8hsj/I+I302a/jEJ9kV8SAYVGrQZ4bYLoqI=;
	b=Dg4qYWXNw72R+H2EUfoZU035H/EWIc02O8taCrT3yw0x2adpBEnz/vrJ31iqjCiyv3+l
	 CKpka5z0qgQlXEKJiOxAN+ZUIe5QtZl2SECsKKTV+4SNVCLnCIM6pfpeKmbrP/I5H3xkD
	 nAen3AVs7w2PQjk7thAn9qX6tCV0BR7AAKQXonHZnG9fBfWxQu8Etw2ZxVa+XlD54u089
	 i6QNxwtpAzknxQ/TF/g7hHPiVu3NGq7FplJ6v7qFArwPWCClav6bYPEO3C1pqApdm3PYC
	 pVihyOSyqVVLfdfkYPpNaq+km0atc2ljLQxSNmz2jz//Dhzb3co8io811f7mxZWjRwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KQa7wJAO;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5424F60A3820
	for <acpica-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5424F60A3820
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KQa7wJAO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195249; x=1826731249;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YI2YiP7Gc0Z796p8cHpT8tVtuftszu8DJ9edeKPvNCI=;
  b=KQa7wJAOd4G53nksuJvW3jII6FLOAsG4+OEBAWbXBPNtA9zcadh8k59+
   /jl9rRFl1HsygG4F5Il6q+HvEF+I6buV+7bBLDMYcrj6wmvZMtiTE1or4
   fDcCIfkcsB6r/lc82/pBPCUuswzrg6D7ZmykNtkh4vEdCREXIaX7mdd7G
   amnxIGmzKOZB3u0F3l5s0pG5sJ8CJE9tAY/6RS8veliSl6BpU2SEqq3Um
   +FRmS4zbP/OpWrEIuEiDopiChlWDF6JzbiRcy4XeuOoUrDZLfTzfUndwj
   xL1UrrIRBP5L9K10l7r4lSlP6U6By1QLmuli1qyo36Yw8qO7Zgcj5ut5c
   g==;
X-CSE-ConnectionGUID: LFVtOMdYRfGrVNx4CXNNIg==
X-CSE-MsgGUID: RqGGQGgWRCiphXBDhJXzCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157386"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157386"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:49 -0800
X-CSE-ConnectionGUID: 3Sb2MOILTWmGnByICKwKUw==
X-CSE-MsgGUID: 8KmtUxA/RpGsnAZy+bXm4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10867983"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:46 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: ikaros <void0red@gmail.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/42] ACPICA: namespace: Recognize alias node types in detach
Date: Fri, 20 Nov 2026 18:18:35 +0100
Message-ID: <a3d0315945d71c93ae9dca5c77faec95519e30c8.1795194329.git.maciej.wieczor-retman@intel.com>
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

From: ikaros <void0red@gmail.com>

Link: https://github.com/acpica/acpica/commit/1ee856f62d40
Closes: https://github.com/open-acpica/acpica/issues/1183
Signed-off-by: ikaros <void0red@gmail.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/nsobject.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/nsobject.c b/drivers/acpi/acpica/nsobject.c
index a4ccacecca53..49d9d917fa73 100644
--- a/drivers/acpi/acpica/nsobject.c
+++ b/drivers/acpi/acpica/nsobject.c
@@ -174,7 +174,9 @@ void acpi_ns_detach_object(struct acpi_namespace_node *node)
 	obj_desc = node->object;
 
 	/* Alias nodes point directly to other namespace nodes; skip teardown */
-	if (node->flags & ANOBJ_IS_ALIAS) {
+	if ((node->type == ACPI_TYPE_LOCAL_ALIAS) ||
+	    (node->type == ACPI_TYPE_LOCAL_METHOD_ALIAS) ||
+	    (node->flags & ANOBJ_IS_ALIAS)) {
 		node->object = NULL;
 		return_VOID;
 	}
-- 
2.56.0

