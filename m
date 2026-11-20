Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195319;
	b=T1YWvrhKn95HWurT4T20CGICRR1Ayq86mOwkEysOWYUuDENSFX5QMrrRfLC14FEgsFdM
	 /feSMLtMCJLmE1LbomgdwBcD2dENxYh6XLIjrXchljRu+/+M22pVO8JEDD4/tIuJYWdRl
	 SPXssXuckriiUsrOhi7VnETbBCUNX+3eoSru4W6mNtpUbRVXDa1SWymnkej+blNiLSP+h
	 AYfL4uVGy7lsrGr6KNNzld7/isv8rwzkwz9VxrZ4Q2Q/D4FyUNvcmzoOBp4IHztOM2J+y
	 lv90codREUOh3xY0PLgLTVbi83nnVmAiLgPHCtcha4LH1fdoFHtN4XA7R9I0AG0MGiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195319;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kgSWJLv4kDxZkRHPxzXjqLjTOrzur6vRyUHL5kqxuIg=;
	b=yjWloPisO/QtQzWtHcdlRICsAXSQ4YLCmEPE+7FgyatozD3uIe0v+b+4BkupdkO+vd4z
	 ixdvP6m5+FufV1OJBtqnkDriQKl/LfMyjJDWNwYBGe2Pnckg0aE/1dA1OGqXe7fQE4esz
	 /RjNK+UKOon2n9jJ2SQqs0KvfvMnIZf88ypLd0jaSCJJEvXh1pAkxRzL3dWuk6d6EcoOt
	 8WgIDwkPsYdRBs2KPjc79iVN56qIAlxxHt1gw9dfUGExYc5GGwiyCWgU5Do0vfcuuqn+4
	 QB7oWKBSlDBoj0PJH9SIycNnOHb7uR1IBjAJgxkBs6SeCvA48vHLnegpXhEBKKY1AJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aYNJofyS;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B89B606B3CA
	for <acpica-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B89B606B3CA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aYNJofyS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195319; x=1826731319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TnrUJ0qQJO++y0gqtSjgrABuyMvnEmme270OYFGBSEw=;
  b=aYNJofySeSvykTnICDpNrLvdHWv9lqF9FeDXBNyFu4rNdTuYCK1PzpVK
   BDrJYauY3zGklcSjft9Ig/0QT8Cp9F/MliZUXHSevjIRbVo6Nl3rTV+BX
   i2O2D7OrUnVMFQNssPByyU5nmp7zYqtGvwRFowArADHDngXlq0QKzraQ8
   UKeVTZ34Mipme/XQ5UDN4prt3oEFbVLjaXdhDQZoK4CcEMKxI3qcjoirz
   Ct0Kp+XiXc7WZt059gEN/8sPl485KCIlJmbmqs7MAoBgqKdPPb/sgbFH/
   lrm+iSgByRw5yqR8HSGexT2OLCSs43jgfZRls2ZyZl9FroZo/0HLfgQbW
   Q==;
X-CSE-ConnectionGUID: Re9sE8RvTnOdF0ROE/FQ/A==
X-CSE-MsgGUID: b0bxiJ47RSKnwShDJYWQyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157576"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157576"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:55 -0800
X-CSE-ConnectionGUID: 1Lr35aWORxKdrCWgrQxTdQ==
X-CSE-MsgGUID: 46GAd8aNTIGn/HewCipKCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868272"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:53 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 37/42] ACPICA: tables: Fix global table read missing mutex
Date: Fri, 20 Nov 2026 18:18:58 +0100
Message-ID: <975f81fd5d85c44c41e289d2a7ce29497d98bdf1.1795194329.git.maciej.wieczor-retman@intel.com>
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

Reading AcpiGbl_RootTableList.Tables[].OwnerId without holding an
appropriate mutex can lead to races if anything modified the table after
the read.

Use a helper specifically dedicated to reading the OwnerId.

Link: https://github.com/acpica/acpica/commit/ef7cf3f3def2
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/tbdata.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 1cf0a46b3539..94ac355daae7 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -1059,6 +1059,7 @@ acpi_status acpi_tb_unload_table(u32 table_index)
 {
 	acpi_status status = AE_OK;
 	struct acpi_table_header *table;
+	acpi_owner_id ACPI_UNUSED_VAR owner_id;
 
 	ACPI_FUNCTION_TRACE(tb_unload_table);
 
@@ -1074,8 +1075,8 @@ acpi_status acpi_tb_unload_table(u32 table_index)
 	 * If any matching GPE is currently dispatching, AE_ABORT_METHOD is
 	 * returned and the unload cannot proceed.
 	 */
-	status = acpi_ev_clear_gpe_dispatch_by_owner(
-		acpi_gbl_root_table_list.tables[table_index].owner_id);
+	acpi_tb_get_owner_id(table_index, &owner_id);
+	status = acpi_ev_clear_gpe_dispatch_by_owner(owner_id);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
-- 
2.56.0

