Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195279;
	b=dLguOQ3qU49gxXcRVQvBR9tjTv3Tw0SVT84sf8AyZ/r+v/b6MIAFAHn2+3anj0PJU6ya
	 rjdQpegZHRE2r+L+RsaPfVwLzBx0IMKvKGxCw9fFECMKQ0MUpKUvKTQGpSze5EeCxJ3DH
	 EZkoF2+gJdnjTo2RYjjLA+ZDVjetcO21/EPUkDTbsnwJQYUtTf8jpErBSBzecajBP7cSF
	 JMO83nfUJUo7c+Ggk/QmrirpcDL/dlSDfSKhda5/h4sG0x+HoxeucAoCpRiKyQxHxaKFA
	 fwQqKUxu/aAY5rj79Ff55NjxKrKnJgV3J1HPTiZruV/twH3KUzrO8ATvDOSKHMaJGwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195279;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7K5nxX3FlezkwqFtW/kW6wkPvCMFQLfgkiEhrQUHY38=;
	b=QfXwTGVnAZDdsHPHGpfAZrkmjxO9Y7L5iFFakW0EZpG75t5WWCeMwvhXfxaK4MS64AOs
	 74W0glQBWwX2DETfVsGo//ckO4KSc3b9UH/Cm72on5it45/r/6yReQ2TyGq+J3647m40x
	 sA4+bW52ai/22sMdjgaDMdoh1nVAnN18hz86qAv9qYA4XMO1wUAcChAQtSVpjQfusuU4n
	 7fGlVHeK03DSUfXuytQWKESnhlS7+pmV7C4mftRk1TR/wpaM7oF/Dgba+F4XX77x66daI
	 GzN5xzHa6d6RIzUsQy/j7GdbBihyNaD0WUjCvGZdCpfeH+NKtnNbTCNLSaZdUuZpkbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eFePXe1m;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7814F60A2619
	for <acpica-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7814F60A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eFePXe1m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195278; x=1826731278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yrVvADaO5jh01LLhSX88CpJZgaGk0zOQYGLqCfiNvFE=;
  b=eFePXe1mfU7v8hc1CJq2nBjUqph3Vr5TuvFxi1U21fBPgyf8HdzhsRhH
   MBz7HEj0pS1out+Zlx2/47rvC29Jk8j+GF0i8RNR4OzztJZLE0tF8fR6h
   ML6UpUH5rxyyOzkqMJifPpfb6m5gXYfcmiOaWHiI3ucHpoim0je6qI0N0
   oFwo7j8vYK5iPdBuRWo33Wck0o5pZ6wYEXL6FCIXGgcR8z7acls1pd8Gu
   A7cG7oToJgzWWS2G4eM/6nCxvPfTry2ei+HuM2mcYNbBrPP30i0BugYZk
   c0I1WBHwN3SXiIZmQquOV6nUf5cZlses/+c54pIXKjulNrKdC8rcT5qGd
   A==;
X-CSE-ConnectionGUID: TuADekHXSTmYvdM9WihtvQ==
X-CSE-MsgGUID: vNLdxUYWRmiSs2vGB29Ujg==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157466"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157466"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:17 -0800
X-CSE-ConnectionGUID: hXEiAFNzTGadOeuTuuGRQQ==
X-CSE-MsgGUID: n9vml5qdQdqczaSIH/XxHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868125"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:14 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: abhinavmir <atg271@gmail.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 24/42] ACPICA: iASL: Fix the truncated count of external control methods
Date: Fri, 20 Nov 2026 18:18:45 +0100
Message-ID: <b31935b7374f82590eaf14eca26e0a013bf0d0ba.1795194329.git.maciej.wieczor-retman@intel.com>
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

AcpiGbl_NumExternalMethods counts the external control methods that the
disassembler finds in a table. Its type is BOOLEAN, which is an unsigned
char, so the counter wraps at 256. A table with more than 255 external
control methods gets a wrong count.

The wrong count makes the disassembler print a bogus warning.
AcpiGbl_ResolvedExternalMethods is a UINT32 and keeps the correct value.
The two counts then differ, even when the disassembler resolves every
method. AcpiDmUnresolvedWarning() subtracts the counts to get the number
of unresolved methods. That unsigned subtraction wraps and gives a very
large number. A table with 300 externals, all of them resolved, reports
"There were 44 external control methods found during disassembly, but
only 300 were resolved (4294967040 unresolved)".

A count that is an exact multiple of 256 truncates to zero. In that case
AcpiDmUnresolvedWarning() returns early and prints no warning at all,
even when methods stay unresolved.

Change the type of AcpiGbl_NumExternalMethods to UINT32, which is the
type of AcpiGbl_ResolvedExternalMethods.

Link: https://github.com/acpica/acpica/commit/36a5217a09bd
Link: https://github.com/open-acpica/acpica/pull/1221
Originally-by: abhinavmir <atg271@gmail.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/acglobal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index b6e31517650e..9a2798896d48 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -287,7 +287,7 @@ ACPI_INIT_GLOBAL(ACPI_PARSE_OBJECT_LIST, *acpi_gbl_temp_list_head, NULL);
 
 ACPI_GLOBAL(u8, acpi_gbl_dm_opt_disasm);
 ACPI_GLOBAL(u8, acpi_gbl_dm_opt_listing);
-ACPI_GLOBAL(u8, acpi_gbl_num_external_methods);
+ACPI_GLOBAL(u32, acpi_gbl_num_external_methods);
 ACPI_GLOBAL(u32, acpi_gbl_resolved_external_methods);
 ACPI_GLOBAL(struct acpi_external_list *, acpi_gbl_external_list);
 ACPI_GLOBAL(struct acpi_external_file *, acpi_gbl_external_file_list);
-- 
2.56.0

