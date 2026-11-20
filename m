Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195255;
	b=PzSnHuBMQIWSwYGgwHk2+y7UV65vAphpJ8itZx3wzzwa7Z3r6DdUxFrfjWQO04HcXbcJ
	 gcwrTpr3SSECF7xYM/2hS8qr+QfS+U4flsYxFSplIBZYygGgX+eBI9VYO38/Gs6tLNypS
	 i/pvDoIfWa2JWX9YEqxV85C6/MJdgVGLAoBCRR6DuIS1tPNj7SuFcQjHeCTJ5FGc1O3CV
	 IwE/Tl4HUiVzC9Wr85Fi6qwmX0nMZohawMKYMhYnEkjS5J4sk8bL9aJvothAUt5FsqaZb
	 13hY+UV+gKUTP6g1y3tDTxhpfWA12gFL9HRXy6+KHR0zO1B29wYJy+11nHdeoWQnLhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195255;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qJPHQhYfedjCOJYrgLzd0ECOSbf8JTv2hZq1jKTSmrI=;
	b=RB1p+yR23+IdE0OwsR3JYsTdcJNpSZv37mHVQ1QgGWteqgBYd1Pgn/AEPeFRYgfY9ldG
	 8MZLl8SHIvWptBaa2X4E2T+uStIQudFwPQhPd1KAoshMnGNfBjgkcsFEn4u9mJY8ayQgK
	 UOoTNnDUbhfyc2hyIlIIt60rDM54hyhSlM5t4xZpCycEEe/d8grzKgyvTrI2HWuH81ujJ
	 52a80/Kmrq8e17nriXC9jz+4FXtvj53mLp8wOTW6gAjEKDeIeuXyvMRhXK+Z7IWQsHT2a
	 aD1CwNH8WeEIEcFQ6ofYd82aAD2hZ5yasXWyuL0wfDB+UGWEODu6O8hxBYIUQaYOsJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FX6HROF0;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2038460A5BC7
	for <acpica-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2038460A5BC7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FX6HROF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195255; x=1826731255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ultTTMBLv2vDOVju1DP16lSpu87uKSHH9VOkiMbZsK0=;
  b=FX6HROF0BXDNEuvG4+P319sq/I94THtVwcoluvido80lMlmmBP1sx3AE
   p+ISTaQ0JVC50+RSGhe7mKDhDAX6KrtLm0eQPvo2gKe+r5euLq4/weguf
   o5f4LneWONbkF4d/I09W/PN3C0Dl80i05OYTp4Th/+k/E4zHhdAzSETci
   CxZTcXLChAZx5WB7+HOBpFm8UiBHAp6yGhf+NEscmc8uEPG6I5y1Aaqn2
   4hBEtd3CszG94kbddeezvqJv1CVZpu0E6ayo+F8+TVuFPeJoKH3I2iirn
   xw60BcUH+GqCQTZ4JFCWcibB8/Sy/XO6otJx2NMHF2iuyRT3yAAj+4MQh
   Q==;
X-CSE-ConnectionGUID: jJc5SL0CQAql6ERvxIlL0Q==
X-CSE-MsgGUID: 58ud6KYlQ22iO/R3CHk41g==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157404"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157404"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:55 -0800
X-CSE-ConnectionGUID: iw8AZoajSvC0GCTfN3JU/g==
X-CSE-MsgGUID: X3200TdbSyOFihYGkQAB7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868005"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:52 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: Rong Zhang <i@rong.moe>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/42] ACPICA: parser: Set AML length for bytelist
Date: Fri, 20 Nov 2026 18:18:37 +0100
Message-ID: <d32f3fdc439e5aa8153a14f5ea979465b3ee87c4.1795194329.git.maciej.wieczor-retman@intel.com>
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

From: Rong Zhang <i@rong.moe>

The sanity check introduced in [1] leads to failures for
resource templates. AcpiDmIsResourceTemplate compares the Length
variable to BufferLength - the problem being that Length was never
set. This causes the decompiler to decompile valid resource
templates as plain buffers.

Fix it by setting the AML length properly.

[1] https://github.com/open-acpica/acpica/commit/3ce09021b677

Link: https://github.com/acpica/acpica/commit/bb546a65fa3e
Signed-off-by: Rong Zhang <i@rong.moe>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/psargs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 4643c839df7f..b0f5a11f9696 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -760,6 +760,8 @@ static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
 
 				ASL_CV_CAPTURE_COMMENTS_ONLY(parser_state);
 				arg->named.value.size = buffer_length;
+				arg->named.length = (u32)ACPI_PTR_DIFF(
+					pkg_end, parser_state->aml);
 				arg->named.data = parser_state->aml;
 			}
 
@@ -933,9 +935,9 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_state,
 
 			/* Fill in bytelist data */
 
-			arg->common.value.size = (u32)
-			    ACPI_PTR_DIFF(parser_state->pkg_end,
-					  parser_state->aml);
+			arg->common.value.size = arg->named.length =
+				(u32)ACPI_PTR_DIFF(parser_state->pkg_end,
+						   parser_state->aml);
 			arg->named.data = parser_state->aml;
 
 			/* Skip to End of byte data */
-- 
2.56.0

