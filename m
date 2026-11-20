Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195323;
	b=L/3lT8BHBzej3kp4migkOx9kSoxWurZFrNZjJQhcCMniUh3Jqh1Bsg/W+qgRLw/7Xlsd
	 n0M2+Obm1q39JZdKdu93HeoR2ejt5GXExgLu9QV2b1sjNMr+vpZuvg9V/raaoi1CApWp+
	 2VuoZq4qWJ4nBUc73fjQDNF4Ry86EeBa0whp+3vaqvabzbrK6JNuwBV3I8yjG+NkI8u6y
	 kGuvvKoCOobjWEQ5rHrdN38imPhbvW7RJ4e8HyIMFcvKB+eAqG8sQUawcDgK6v4zkfrpH
	 wmcskgCDn3+gj8DA9E5RUo/jnH43vAeyWyqkz4Oo4Q/Z2th2IeQQAYrFLbvgqnfhKuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195323;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0LKEXFrrcZbW1+QLpKx26etI8mlbufN440M5sguwo+w=;
	b=AZFsG+E3iflB6qw1fj8xZP6IgnQHcSfY3NBTEda28iqiQMBYm6AdtnqhvimusDkq00RA
	 /DdwpW6ZrWqNViDgzDIv1yrt0+UhHxL+UoBGO+22wt3gcVW7offO/jQ/h3dlukHOY0YVl
	 MWBSv4GHO4yhPAH9ywDPhETAYNVoPGxMmmhUpwTuXagcX63M15n92VX2C00s6m/05bY7H
	 5zFSwAe1Dk7s+4m8/Xqlc9AwORxiL787VYjxHwTHmbqXNkU1BVmhaMc/Q6TnH1cKtMQ/J
	 JKS8KrTp0T29MIyPleoWZLk+J1gTTw5dGGxyJ+xqKxcsEZOSUfh6PBXwxnhHXm7scWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EwgwsY63;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11641606B3F9
	for <acpica-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11641606B3F9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EwgwsY63
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195323; x=1826731323;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1+dMsLN5Kt4kDicrj1HTOeOb8hIYjWrACVK+Yeit25w=;
  b=EwgwsY63q6uV3uVwebWupj6j8g2RsDTouXs3xxElAPYvkbWEd5LFx/PX
   TlbAVBnW8MPue4C0Ey8f2geYdWqj68eGfMdqzavcOpqegNswltbAvJz+x
   +wzgQsJQkfwFgA1soWLFroR+3u7Esh9lnP3YShRJ5Zu7G40YhQuBZPYV+
   5U/aPZlLmyl1eUD+CPYTGFL+7z7k5wD49UtG3TUk4QG8z/kCNNP9vSw6+
   OnsehXUaJ1xql3GKh74uV7V0P7iGjgphGLO6pP3Z9XHYGUtyxgPMD9pwV
   hmqbE8WUG6311jkTV13F7xJpOv+wOl+TGSH86Ar68lB1FwEoe+h7dWVxi
   g==;
X-CSE-ConnectionGUID: CkhEIa8gSFGi4EmmbdIN4A==
X-CSE-MsgGUID: Bo9AqEYVT6+Mp+aePuM+Dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157597"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157597"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:22:02 -0800
X-CSE-ConnectionGUID: uSpSYkXmTLuuLmbG3SA/hA==
X-CSE-MsgGUID: X3+1Fwh5TXON5OvU+ODs/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868289"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:59 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>,
	Kyle Pelton <kyle.d.pelton@intel.com>,
	Bob Moore <robert.moore@intel.com>,
	Erik Kaneda <erik.kaneda@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 39/42] ACPICA: dispatcher: Fix zero size non-NULL PCC buffer pointer
Date: Fri, 20 Nov 2026 18:19:00 +0100
Message-ID: <2747c1067c076700bb55a4e9f76a30905ce400ed.1795194329.git.maciej.wieczor-retman@intel.com>
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

Zero sized PCC buffers still get allocated, so they pass the null checks
and can cause writes to unallocated memory.

Skip the allocation if the region length is zero or the
AOPOBJ_DATA_VALID flag is not set as otherwise the disassembler will
emit warnings on every PCC Field().

Link: https://github.com/acpica/acpica/commit/0f58983617c2
Fixes: aa6ec56b574d ("ACPICA: ACPI 6.3: add PCC operation region support for AML interpreter")
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/dsfield.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index 5d0dfe4ff8e8..d091453eea93 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -530,6 +530,18 @@ acpi_ds_create_field(union acpi_parse_object *op,
 	if (info.region_node->object->region.space_id ==
 	    ACPI_ADR_SPACE_PLATFORM_COMM &&
 	    !region_node->object->field.internal_pcc_buffer) {
+		/*
+	   * If AOPOBJ_DATA_VALID flag is not set the region operands is not
+	   * evaluated (e.g. disassembler), nothing to allocate.
+	   * Also avoid a zero-size allocation which may yield a non-NULL pointer
+	   */
+
+		if (!(info.region_node->object->common.flags &
+		      AOPOBJ_DATA_VALID) ||
+		    (!info.region_node->object->region.length)) {
+			return_ACPI_STATUS(AE_OK);
+		}
+
 		region_node->object->field.internal_pcc_buffer =
 		    ACPI_ALLOCATE_ZEROED(info.region_node->object->region.
 					 length);
-- 
2.56.0

