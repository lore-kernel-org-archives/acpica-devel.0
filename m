Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195216;
	b=u3Lc+K5+pf9JxgGrXmi3HhZLDhTjlRfqPcKKoGO1hAgLhli59gkdO+23qQmoh7+dOA0B
	 8/EHrM/xACBZ+zYoWQYGaDuuGtJU6FJomunpnjP6eblQm7NPbFM8cmkxpMbeJEvQVTz/o
	 NxNloS+A4Vl6WS5tjEXYGW76u8eTXKZaFxinmXqKpRhpbU60E5cM7YNhAFBD3fyvVnVxm
	 vBefB3+EQTg/gNJGKQlC8e3Km33IvaXCfY/BvFK2iKDhHKZou/zUOtoWCubK4FGKZf5+5
	 OwV63+l+QH+YzU+uM/7VeNXDUOWzwL4F1BKy7Ql0r0kiXukJJmXxEGCt71Os36+MKsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195216;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0QiMn17000NUsvX8qXHyNIaeY7PijLjgpeFv+SzE69A=;
	b=kQpf/IJImLxj+TCuMcfwJxl/yLCtp9F5BzxDBWLTUvafXTBxWZMklif61svwUHhSjLsN
	 iaIUckciX1LKehTsFIOr3Dm4xpgfjbikM5/hxRyaba/BXt39eB4uuoLNcgNlW2nV03F20
	 gZRln0AfpFbGeYm8R7R5dSwi6FOM5zywimEl11MewiQuhs9p+dtV09BiKpbV0ZsNXSxin
	 MPAzjrWKg8IQQ2r9Iieh9flkd/jjZ1upuzcffpUZt4oUfkQmmIqlVD0qeGDzoD49I8seI
	 jdUMpWdiheubZ3DtQtIIfejHDmkq8SSCiYhjoVefDLNFqh/Udb4I9U+8zK8bTW5EVqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="aUK/mwCl";
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904ED606A33F
	for <acpica-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 904ED606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aUK/mwCl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195214; x=1826731214;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=guMUblll8HZ9eKegKEyAFptDY7C3KDn0qgsAg8B2Qgs=;
  b=aUK/mwClKx+32Qj+fHwkji7eEHNhuZIn29HqtaW6GNMRUxS8GPzLWYBF
   zHeFQbBGk547TMcjJmgZDgWtve1AEwORGyOvPuTY0STQCHbQn7n5aZiHW
   aAvM8wsi3meO0JteRrgrMpf6ZfNe8Kszmw0hk+u1l3akY0y/r7kDR3gji
   igwijk75cLpw1S30e2A6/V770eL1Xh/PJFkiEQ9z2mUgUjObIKFMaX4Ba
   crpdxhJfk2qfmFiQiV1GK2xqdKSumXzoURxg+n/aNePwtZfK4UdBmjIGX
   hf1EX0FtNn4jwJLL6E6e3JQKSirKZkmklcar6gfm+GPk477S6Iun86T53
   g==;
X-CSE-ConnectionGUID: 4AMdPaCzRsi9ZoI+uy28yw==
X-CSE-MsgGUID: ulwzm1PBSgGUD9DOabuUJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157256"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157256"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:14 -0800
X-CSE-ConnectionGUID: WosbMIUbQo+Bii2GjtS9aA==
X-CSE-MsgGUID: 0DvPZiY7S+eVMnxEimDHkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10867814"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:12 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: Colin Ian King <colin.i.king@gmail.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/42] ACPICA: components: Fix typo: "numer" -> "number"
Date: Fri, 20 Nov 2026 18:18:23 +0100
Message-ID: <c47bf6dd3586e8a447a22545ae740e90debf27df.1795194329.git.maciej.wieczor-retman@intel.com>
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

From: Colin Ian King <colin.i.king@gmail.com>

There is a typo in a comment. Fix it.

Link: https://github.com/acpica/acpica/commit/5c8d1e7129f0
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/extrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/extrace.c b/drivers/acpi/acpica/extrace.c
index 4a6c7fb147d7..27a8e81e4157 100644
--- a/drivers/acpi/acpica/extrace.c
+++ b/drivers/acpi/acpica/extrace.c
@@ -152,7 +152,7 @@ acpi_ex_trace_point(acpi_trace_event_type type,
  * FUNCTION:    acpi_ex_trace_args
  *
  * PARAMETERS:  params            - AML method arguments
- *              count             - numer of method arguments
+ *              count             - number of method arguments
  *
  * RETURN:      None
  *
-- 
2.56.0

