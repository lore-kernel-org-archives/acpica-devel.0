Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195239;
	b=z9hUTIFbAGDBF7IIJnpVrcs8GP+iEqA08z60QITPbI9red1VjF9eT+ztSFZGe/Z/er89
	 PhJyYbejc0dMIm0EDj2h5doQ/XjH6zuG6Chuqvzuj9L25twAEptlO3DiNlRNJT9jzv6mm
	 mhcjz7dA2bfHLz5j+6U0YRHzUMFmXFqntr9dlwpoM11YI4UA9Rm4o41ycNHJep9Lu3AGI
	 R7O3NJi7NrBguroxRblDpFt14kopPZqicjbeERyGehRfwrNxZBJFMfQpFQEuhrR2LXDCu
	 0rEKUc0GlXQNNqOl8MQTDpkf6PEcOeQQwtZPu/G8aiCmnyIiTBugh8SYRvMfn4UQbHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195239;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IeCXDprFyH5s45OWxjJG3Hanu/8nlK0/HKzWLbRakec=;
	b=mh96GPc1hkxlqHmUJ9zmE79GY1gDsUCpnD42HqWbwfGidVSl2u8Vjeh5Nh92Qiy+N9HD
	 wHj7pKmw6uRhdrq643KabdObF5+q6IcM7vnm+kyEySb45ffJGttsyr/kvIHIX8c7ZYrIh
	 s+8fWVk5eK7bsQUWPvPiTswtU8SXROvt0xXty/iZw+EHcQtIbvqv5giBeLjGiwbmVWHbK
	 UcQJ9KcvEdSifVhFIVkDtqn4T79UdpVNQQQe869s39enEYFlb6aYYcEXVXqO5OmTXs9tN
	 Iapqpeo5cpqzs97NTLcu90AhqcysIzbv7Mg8M5ZiqB/zcSg6cdK0PRFlf8dAG5bVqYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LwKWl20z;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2781860A5BE0
	for <acpica-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2781860A5BE0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LwKWl20z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195238; x=1826731238;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SDknnmLXoItsImkNW8av9K4oM1xbiGisQ6orGWmcM14=;
  b=LwKWl20zDTIH4L83kjRvYQjrtiJNHOIcnunHqun/f4W+EIKjBfcFzBU5
   asiQXSytvuI6sgyKs/iuHTvdzA0Cg2BbZ9M2nRoodVBLXh234Sh7Hl9XW
   baNijr6ckvAbGvLYxBwNCKrE6tGGv4oG1nJjfm/JXBQQWtW98rVGZumCf
   w+wOjUSdy/a3XlwWjC7Xpwo2MvVeEruob+5ERGdX0tkXVPb3rRkbJF3Jg
   jv7IBjfDEc2Y8mGuNn6zGHEsVtcWnLNTvfcYc66wAVNhU0RcnYLUdhIjm
   iNZqSKk5D75uhRd4MHxxFkjOp5jngbkDOlMy8DT2F8jysyI5x5ihy6GQf
   w==;
X-CSE-ConnectionGUID: ftVTDGSzRzK8y7AEOQ1Rhw==
X-CSE-MsgGUID: KEq/TwsDSPWg6SMdkmvJpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157345"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157345"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:37 -0800
X-CSE-ConnectionGUID: 0jhknMreQMOaUs3qyzqaUw==
X-CSE-MsgGUID: sdmmzOhPTp2BaWD/nd02KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10867945"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:35 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: ikaros <void0red@gmail.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/42] ACPICA: Improve error handling in table loading process
Date: Fri, 20 Nov 2026 18:18:31 +0100
Message-ID: <90c95493e67bb2379dd26cb3dfad8e72ee36788a.1795194329.git.maciej.wieczor-retman@intel.com>
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

The AML Load operator can install a table that acpi_tb_load_table()
then fails to load. In that case acpi_tb_install_and_load_table()
returns an error but leaves the table descriptor in
acpi_gbl_root_table_list. acpi_ex_load_op() then frees the table
buffer, so the descriptor still points to freed memory. Later users of
the table list access the freed table. For example,
acpi_tb_terminate() does when it uninstalls all tables.

When loading fails, uninstall the table in
acpi_tb_install_and_load_table(). For internally allocated tables this
also frees the table buffer, so acpi_ex_load_op() must stop freeing it.

Link: https://github.com/acpica/acpica/commit/d243755c4750
Closes: https://github.com/open-acpica/acpica/issues/1173
Signed-off-by: ikaros <void0red@gmail.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/exconfig.c | 9 ++++++---
 drivers/acpi/acpica/tbdata.c   | 6 ++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index da39d578595b..cb2eed531c67 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -461,9 +461,12 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 	acpi_ex_enter_interpreter();
 	if (ACPI_FAILURE(status)) {
 
-		/* Delete allocated table buffer */
-
-		ACPI_FREE(table);
+		/*
+		 * Table buffer is already freed by acpi_tb_uninstall_table
+		 * in acpi_tb_install_and_load_table if installation succeeded,
+		 * or by acpi_tb_uninstall_table in acpi_tb_install_standard_table
+		 * if verification failed after partial setup.
+		 */
 		return_ACPI_STATUS(status);
 	}
 
diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 144f15011eff..8185c6f7ce23 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -1019,6 +1019,12 @@ acpi_tb_install_and_load_table(acpi_physical_address address,
 	}
 
 	status = acpi_tb_load_table(i, acpi_gbl_root_node);
+	if (ACPI_FAILURE(status)) {
+		/* Table was installed but not loaded, uninstall to clean up */
+
+		acpi_tb_uninstall_table(&acpi_gbl_root_table_list.tables[i]);
+		goto exit;
+	}
 
 exit:
 	*table_index = i;
-- 
2.56.0

