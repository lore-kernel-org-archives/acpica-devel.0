Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195299;
	b=Gt2WUfOke0M+hJpvRSCabkCymFdm/0rW4wn0VR6OE83plgFtJXcNo9J9mT6tv2O8hjz1
	 CpexvzG7HuqSwB3Q+pphCZnOjFKXnspXvaTD7H+9+xtpijORxmDMKHGAvRu4l72FnHRWg
	 nmu7J1IjmMyC9c5GtQjqU0HC54LW8iZHAt9Nood19zdgZ74EWgZcy43a8fbQjToZTCRB0
	 2Pq3yqmx1HtVoMIGE5HehTF2yPVWeOxqJLazwGXx71QP9ywxHwfZPKi4j7OX8lCosaEiq
	 +EX5fDQw2kfABtRrn9zKTOLJoWOgRntN1WlKeMCzoDgjy2YRgEw8m7HUaqL5rmYVAMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195299;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iihNXup8IlPIB4V5SFfb9U6MkhRvvtBpoc7hIxTxyLs=;
	b=wUh3wU96vqQl4TgVjAYc0pKEnk3vpEY2hFzT77ejxdPiFnA9WRf5hL6rgXduoLvWUW1X
	 oiNwEKFsp8fzrIL80ahSyykLWvLeXJN3+z/Jr/Jp2PoowS0N8F9XYgeDw33AeNty+1xpI
	 JNdpB2HXwDtEaL3N1b5zJLO/rMrVDqAWbYQmVo7PhEwgmVnO1tIEZRMrz0ju+d8BjRh1D
	 FaOTzS/IQXZlaFXMYih2Xn/yxY0jHXE7+qfB4UurmOQUdTeJUwvdfLg/y16K4cpfWH26P
	 syFdX7czD6xTk9/POz/NIL/VCZCwt0O0ThudRHoOmcI6O11dY+T6M0G8Kkfzik8MFPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cWUcQvHU;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B55606A331
	for <acpica-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7B55606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cWUcQvHU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195297; x=1826731297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zRKsj9qjLQE1R16y6fa6gI1uCzjr7ltYpbyr03ClsUY=;
  b=cWUcQvHUMxFvD2DfgmvFneYyBldcsobA67Ci4PTgd8phRGO5rQN28ZtD
   5rGUHVt2ctIw+HQRZv3uquNkcoS86KosSDb/kqdxKHuj0X+ZTEKY/QJNf
   7tWfOECC/DamNHyC7Pv6sXVSkv43u2xINhe2swlfqi/ZxFODKAmq8hAB8
   1J03ZzlxVZTDmeyKcVLEEWoHTwR/t3fyqyw2r5JTmqhD7PlFXs01lkulo
   lAmrGopYUvWM8t4d3AWyUYVdhDxt+0iA6kRJRlpeDrrfpbBuXsVt6tuBM
   IdJtUcIHD1zihpgi9408CZmyK3QqRMMJYljf7yNhGAcL4mcKyvj68XWfo
   Q==;
X-CSE-ConnectionGUID: 2mF/J4ycRaGvLeBK+I0uAQ==
X-CSE-MsgGUID: LozfsKzlRqK26r/0gwgl6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157518"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157518"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:36 -0800
X-CSE-ConnectionGUID: tLuHG5lLRdScAtdMcOwQ2Q==
X-CSE-MsgGUID: po9uJFSJSWqHhkM6vMnKoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868196"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:33 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Cc: Vidya Sagar <vidyas@nvidia.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 30/42] ACPICA: IORT: Add Root Complex PASID Flags field
Date: Fri, 20 Nov 2026 18:18:51 +0100
Message-ID: <ec91a97b1bcb1fc57c379943ab87a45d6666a8fc.1795194329.git.maciej.wieczor-retman@intel.com>
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

From: Vidya Sagar <vidyas@nvidia.com>

The IORT spec, Issue E.c (ARM DEN 0049E.c, January 2022), bumps the
Root Complex Node to revision 4 and adds two PASID descriptors:

  - PASID Capabilities at byte offset 33 (2 bytes), bits[4:0] of which
    report the Max PASID Width supported by the Root Complex.
  - Flags at byte offset 36 (4 bytes), bit 0 of which reports whether
    the Root Complex itself supports PASID. This is distinct from the
    existing ATS Attribute bit 2 (at offset 24) that only reports
    whether the RC forwards PASID information on translated
    transactions.

ACPI_IORT_ROOT_COMPLEX in source/include/actbl2.h was updated for the
E.c PASID Capabilities descriptor (offset 33) but stops short with a
trailing 'UINT8 Reserved[]' flexible array, so the new Flags field at
offset 36 is unreachable and the existing ACPI_IORT_PASID_*
definitions have no consumer.

Replace the trailing flexible array with a fixed 'UINT8 Reserved[1]'
followed by 'UINT32 Flags' so the struct fully covers RC node
revision 4, and add the ACPI_IORT_RC_PASID_SUPPORTED mask for bit 0
of the new field. With #pragma pack(1) in effect for actbl2.h, this
lands the new field at the spec-mandated absolute offset 36.

Link: https://github.com/acpica/acpica/commit/21e638b5d118
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Link: https://github.com/open-acpica/acpica/pull/1246
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 include/acpi/actbl2.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 8e0d5156e6d6..1dafb2a71368 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -750,7 +750,8 @@ struct acpi_iort_root_complex {
 	u32 pci_segment_number;
 	u8 memory_address_limit;	/* Memory address size limit */
 	u16 pasid_capabilities;	/* PASID Capabilities */
-	u8 reserved[];		/* Reserved, must be zero */
+	u8 reserved[1]; /* Reserved, must be zero */
+	u32 flags; /* Flags (IORT E.c, RC node revision >= 4) */
 };
 
 /* Masks for ats_attribute field above */
@@ -762,6 +763,9 @@ struct acpi_iort_root_complex {
 /* Masks for pasid_capabilities field above */
 #define ACPI_IORT_PASID_MAX_WIDTH       (0x1F)	/* Bits 0-4 */
 
+/* Masks for Flags field above */
+#define ACPI_IORT_RC_PASID_SUPPORTED (1) /* The root complex PASID support */
+
 struct acpi_iort_smmu {
 	u64 base_address;	/* SMMU base address */
 	u64 span;		/* Length of memory range */
-- 
2.56.0

