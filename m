Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195292;
	b=Zr0VMzk+K1Vm21D/T8sBbWluR9z0bGJSRKU3xuVPX27K223eGSGYDfGvjcHHA76f9LUp
	 XQHGXhxW5BbRVm/yiNw1ruBN9geU8OzFzcUCMCKGk/uodYIHtpnIni6dr0MX+x+89Rg9y
	 5mgLeJPbxQFTS+7mK1QHhFj1nHIk/bo/nendbewCxFkoFYrv/MnUgLJHk1GOZtHQx5pON
	 QkrCDxTR12l+lSrTcKkRzsCn6ZjwGG/rZcnMO4EsgByAV0tcHCD3i47LGtui46Um2x0ef
	 rJi0CAqBBrfrKB0ZWMak7sUjQ2ZNvhC6xy9fhZBXrB5D00gTqzkL3QLFqK+1nIY+kng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195292;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hKo9oQqUcBiElmRMU75xxTtQbMqGR9T0DnABQus5l9A=;
	b=O4rRcrvEE07R3CDgNh4fW/711/VzGWYxH6WcggcARBek62Q2J8sdXz9eqOEOsKrKC7tQ
	 S4Hd3tLNFpIsy4FTC4gS93c5/aT+uFNXTc4JJVQtRzgLKcGC8J9iTuj7vMAa7oBIQxF9M
	 4Du0I7xIeOWos7jEgvLZiX9D+rpkuYopv6cg0CY7mqzZKDWdT9+IHLeoavnsmekc5bwWe
	 NQCOqx2w1PQpnfWr2DXCcg4q7iZKHZ5yLzZIAvqetqD0RuGAbxFgoTvdkcQG/uxaoXGT3
	 Oxfhq2TQAQTphcAFAGQxk2+/pMnFDlaRWGgKhL2eQG1dNA8tfddRNX+oZf47V05AWSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=US4uL3jx;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87478606A778
	for <acpica-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87478606A778
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=US4uL3jx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195287; x=1826731287;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/r2n44oTBiyBypS7ziJQCY2efDXhtPhcvXbxJ6KD4sU=;
  b=US4uL3jxMA4HTGWdWUY5eaBZ8Sb478M+lW7BXnaF1cQToiBgeaPEdKaV
   WMUgqbFnMk+KXlas46kIrpljQooZIQ1nBx4mTwCJBNdZlT/Cv49MRevFK
   ZEisTVcpTQ3XLERC65KPxyNmBGTHpzazI36pnpCW4zVmfTfMCKyEusiXl
   NoE2kG1pELf7chmnwSJqatlVdQrGPAcLmXBXkoXk+nDtxFfmefkr5VLIq
   w4S1LU17G0uQQ2yaplUTXZ3vswZlApw+dhp3AzuAX+Uu9NrCAnYTsuQzw
   lLjy9C8iOXk+FUNio13uJc6cmYq9oLjsimTt1SErb/9ht932aZ5GWfiJ8
   g==;
X-CSE-ConnectionGUID: t0cX6EpKQiG9j14fn9NF/w==
X-CSE-MsgGUID: zfybDuajQQWOqJ5+VPnU9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157495"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157495"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:27 -0800
X-CSE-ConnectionGUID: tqTPscSfTX2Naix5qLPZYg==
X-CSE-MsgGUID: XwArdKxZTqiYlHidIJJrWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868165"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:24 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: Leonard Lausen <leonard@lausen.nl>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 27/42] ACPICA: Executer: Resolve package index references used as integer operands
Date: Fri, 20 Nov 2026 18:18:48 +0100
Message-ID: <1874837cbfb6cf86ad54b4f64fab3a3255521a7e.1795194329.git.maciej.wieczor-retman@intel.com>
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

From: Leonard Lausen <leonard@lausen.nl>

Resolving a Local or Arg retrieves its stored object but does not resolve
an Index reference stored there to the referenced package element. When
that reference is used as an integer operand, implicit conversion rejects
it with AE_AML_OPERAND_TYPE.

This prevents FAN0._FST on the Samsung Galaxy Book 930XDB from returning
status whenever the fan is running. The method stores an Index reference
into its fan-speed table in Local1 and then uses Add (Local1, 10, Local1).

Resolve a remaining package Index reference before integer conversion.
Release the replaced reference inside AcpiExResolveObjectToValue() - it
seems to be missing there with even a comment mentioning the
non-existant reference removal. Limit this to integer operands so Store,
CopyObject and method calls continue to preserve references. Leave
Increment and Decrement's synthetic operand resolution unchanged; their
reference-target handling requires a separate fix.

Add a standalone ASL regression covering local and argument inputs,
integer conversion, reference preservation, target replacement and invalid
operands. The extracted fan method also returns the expected status for
all defined fan states with this change.

Link: https://github.com/acpica/acpica/commit/aaa58f4b62a9
Link: https://github.com/open-acpica/acpica/issues/908
Signed-off-by: Leonard Lausen <leonard@lausen.nl>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/exresop.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/acpi/acpica/exresop.c b/drivers/acpi/acpica/exresop.c
index 8127d4046d0b..87d04b74e13e 100644
--- a/drivers/acpi/acpica/exresop.c
+++ b/drivers/acpi/acpica/exresop.c
@@ -375,6 +375,32 @@ acpi_ex_resolve_operands(u16 opcode,
 			 */
 		case ARGI_INTEGER:
 
+			/*
+			 * Resolving an Arg or Local can leave an Index reference to a
+			 * package element. Resolve that element before integer conversion,
+			 * without changing reference-preserving operands such as Store.
+			 * Leave the synthetic operand resolution used by Increment and
+			 * Decrement unchanged; those operators also need reference-target
+			 * handling when writing their result.
+			 */
+			if ((walk_state->opcode != AML_INCREMENT_OP) &&
+			    (walk_state->opcode != AML_DECREMENT_OP) &&
+			    (obj_desc->common.type ==
+			     ACPI_TYPE_LOCAL_REFERENCE) &&
+			    (obj_desc->reference.class ==
+			     ACPI_REFCLASS_INDEX) &&
+			    (obj_desc->reference.target_type ==
+			     ACPI_TYPE_PACKAGE)) {
+				status = acpi_ex_resolve_to_value(stack_ptr,
+								  walk_state);
+				if (ACPI_FAILURE(status)) {
+					return_ACPI_STATUS(status);
+				}
+
+				acpi_ut_remove_reference(obj_desc);
+				obj_desc = *stack_ptr;
+			}
+
 			/*
 			 * Need an operand of type ACPI_TYPE_INTEGER, but we can
 			 * implicitly convert from a STRING or BUFFER.
-- 
2.56.0

