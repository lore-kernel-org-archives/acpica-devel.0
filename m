Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195319;
	b=A4u0UOShkF3tJM7H8b8rt7u2ZOJIBNE9iyiwhZHPoZEuUVmorQ9kXkUl7/x3Hssa0Eeu
	 YW+J7oCJ5sx9vMULAnEdH46eESkc42o/7DTW4zGzgf5qFSLXl0Xai0U6LN03Kr0v5CKzB
	 rG5gTPo+Og58OSnsXrb5lTXM3MegDrPWuRvGt0qi3HQXvcfaSBpPHmv5Zd8JxjFGrsPlQ
	 KAWFo861REckeQFxT69076y68VRGwCvWxpX2QDh5HtNFXlYuh4PLLmb9wDGkwbqEkWlrQ
	 53ZEm3rkeSsh0n12+jeujVUvlE71Ez2XCqi7g0YkR1KfZPj+nn2QO4Gd5/WdBTR5DYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195319;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ULNCz3K5x39o/iXWWWSLq1RONMQ/QPX3aOJwUIOILM4=;
	b=jNOTorlwbDjP1tTGGo12jtFXD0Qi3mEs3vMf+uzR2+rqXSuc8ZxmUfQWINvhYBKIhZxZ
	 uunl9DMs5MLFVSTPbzg6NwUC+JbsvXEnR2q90IZQ8Uy56h+xeTCkF/4EHIpd4utcye+9y
	 qk7gT0ZY1W1va4QRBcRlBOWlT/Lze3A+R9KI0Qly6VkbkKa+eeS9txhTjyxmxvGe/hZ9Q
	 OB9q9wUW+TcgaTLJWXtEQaClpai0Sd43Vxqr2dMH7vxCG63Io0wcUAfZc6ADaXSfD4VBh
	 G+ullOJIJ7VTavfp21VB6xlKwHDVg6Y1kxtpMWjG+IuAWZ+jwVtpp1OehGA1NwrEUMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N6msx8Et;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA8E606B3C0
	for <acpica-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFA8E606B3C0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N6msx8Et
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195319; x=1826731319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ocUGYQ4pgxB7p0sDnaBJ4+L2WyFktecEWDhLSinhDSw=;
  b=N6msx8EtF2l7u3b/04xIVShs+ktVOFGYM7oRen/15CQPRP8P2JCjtNcW
   A0Om3x2AvfouCj1CMvdmpu60goiHuXZZ0RYyUTy9Sq79mV1b2yLzD0mWG
   ZA3qr4RfvA9dw1ipaY41BvGIFXQDwl6p8U0sh9sJBL4s5br0arptS5mel
   zff/cupa6X17JnvO6mjOvsp0kAI8TqtEFmll+77J9kyeZTlL0jPYWeAq4
   Q9OkAaXdd22ZDuypmBoiJFt3+THkrJNOQ8u49LSJ+I3Bwd/wxULLaDZk4
   4f1FEqivUCPmrXeC/C+JGg/apg+qDEiX76v/zzyqlxKqpZ7S9SvmW7PJi
   g==;
X-CSE-ConnectionGUID: 1/eAU1apRxWanjGVXKiGlQ==
X-CSE-MsgGUID: qmCNHWF0RNa1eyd1nQGjVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157572"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157572"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:52 -0800
X-CSE-ConnectionGUID: 6Q7UuOOFSM625LnwQEPcpw==
X-CSE-MsgGUID: kpPhtlaaS5a584tkEgenNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868256"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:50 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 36/42] ACPICA: tables: Fix wrong table unload and notify call order
Date: Fri, 20 Nov 2026 18:18:57 +0100
Message-ID: <9a12259c1955e0d1bbf864ba179366dee0e40eb3.1795194329.git.maciej.wieczor-retman@intel.com>
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

Newly added cleanup - AcpiEvClearGpeDispatchByOwner() - was ordered in
such a manner that if the clear gpe dispatch call failed it would leave
GPEs still enabled but the host would get notified that the table is
unloaded already.

Simply reorder the code blocks so that notifying the host happens last,
after the GPE dispatch cleanup.

Link: https://github.com/acpica/acpica/commit/b97317a4ef0c
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/tbdata.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index c756d34eeb44..1cf0a46b3539 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -1068,13 +1068,6 @@ acpi_status acpi_tb_unload_table(u32 table_index)
 		return_ACPI_STATUS(AE_NOT_EXIST);
 	}
 
-	/* Invoke table handler */
-
-	status = acpi_get_table_by_index(table_index, &table);
-	if (ACPI_SUCCESS(status)) {
-		acpi_tb_notify_table(ACPI_TABLE_EVENT_UNLOAD, table);
-	}
-
 #if (!ACPI_REDUCED_HARDWARE)
 	/*
 	 * Clear GPE dispatch for methods owned by the table being unloaded.
@@ -1088,6 +1081,13 @@ acpi_status acpi_tb_unload_table(u32 table_index)
 	}
 #endif /* !ACPI_REDUCED_HARDWARE */
 
+	/* Invoke table handler */
+
+	status = acpi_get_table_by_index(table_index, &table);
+	if (ACPI_SUCCESS(status)) {
+		acpi_tb_notify_table(ACPI_TABLE_EVENT_UNLOAD, table);
+	}
+
 	/* Delete the portion of the namespace owned by this table */
 
 	status = acpi_tb_delete_namespace_by_owner(table_index);
-- 
2.56.0

