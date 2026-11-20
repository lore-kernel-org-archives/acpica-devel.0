Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195243;
	b=5Yf2q/OnLOS4mqS4UzsVVGuP2wXiI2xDwF0uiv0RdMwbQCoaUhT49RZkOdFw6hQ5xWKq
	 Kc6Jp5EAQFfN/84SVYja3Nkt4SO1dvOBBus4OaJTTbIr4hrUzrMHDAH4RGFZDEHDKIybV
	 xtiq6wXVPx+QkcACHnBuhi9PgIa5PqA8F1R0sYZjGL284pT5o2byOnH8V4lXDXgOeMBrz
	 xuKVlW0K6ZAjxryCRmu9670m+Sj6vxkxQ+y8wI1AnzdZvWhPayLodK45RGWb0/XVfCPR9
	 cnSJeLgdgBeXni9HkuYqExCzfgJnv/4bJ4HkK3SA0noWMaBLTlNE33aXmQpT7bXy2vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195243;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fxVJmrU9ZBUXIPtHmB8DcRC6H8qadtEcDwa2Z4bykpY=;
	b=m5TpV9ypndQmjMYVRbZukk0a+MgYAvXO1/2Rrd0xJQN/sfyed24/0Q4Y7CZvdBJI2Wp4
	 Nz82dEG79iSxMrIyNRU6fxwIudJTl4JjQa2+ap8zRWzbs6LXojbxlDs59As/vXnFPMXCU
	 mJy7x4DP5uTucD9oPAzzcZKeSKswkcDvMbWUMthTkBNHa43wlkkunQeQsQPoV/HNoo8b5
	 6I8aax2M0vZTedmptnoSOzagCgyejVZsz5aE1H9yw05FbGdoE6pGFwmBLqHLlt3bT3RpO
	 wFeMJacxyxwa+7TiVNiymmGDwPEyXNmiyaJXWJAMBXE7E37hoKKWkZVzst0chL+LYog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PxKS3a9y;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C8E60A3815
	for <acpica-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3C8E60A3815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PxKS3a9y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195240; x=1826731240;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QZEggnyGKzBGzEvjAW3d4cpip03eUHBMMxsS2puPKms=;
  b=PxKS3a9ydjqSj7tJ3vQj0KXrdyg23/5R+JWaMyCigCD7rrGvw/zZE+Dt
   chikgbJAniaeEKkoTKwY9So51TfO6Szze5DGyFuJmfZD4BNysh5/TnTkD
   3oXC9zbWYujQaK+zjP5/F5QPipGsQlXSPJqJzCrtVueRWQHX9bAVFCzVS
   tMhH53EwBrf91EE/Tdk1ZNhNJNzPVLSJIfvHof0TtuAikNsjPgqDfPJKL
   VtuookOH4+69zXVhmIJhAEGDJ7cyMquaywYSSKNCKYxlvpiT2pXgU55x1
   zBfiikuuIZRKeQyeze7gDz+as0zod/YuQMfR4NFZqzj+7FRrftvvJMi8h
   w==;
X-CSE-ConnectionGUID: 7r/jq4IKT6aiA8trkIs2wQ==
X-CSE-MsgGUID: fQkByAJvTQu5n40DjFKooQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157353"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157353"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:40 -0800
X-CSE-ConnectionGUID: cz0c2BFlTjWe0c3MQavm0w==
X-CSE-MsgGUID: oOD8R/GtSK6aMp8Tk7c4nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10867956"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:20:38 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: ikaros <void0red@gmail.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/42] ACPICA: executer: Add bounds checking for PCC field write access
Date: Fri, 20 Nov 2026 18:18:32 +0100
Message-ID: <75a5752bc41966592499a5e206b0ea919abf806c.1795194329.git.maciej.wieczor-retman@intel.com>
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

Add validation in AcpiExWriteDataToField to ensure that PCC field
writes do not exceed the bounds of the InternalPccBuffer. Check for
a NULL buffer pointer and verify that BaseByteOffset + field byte
length does not exceed Region.Length.

Link: https://github.com/acpica/acpica/commit/1cba59bce8e0
Closes: https://github.com/open-acpica/acpica/issues/1175
Signed-off-by: ikaros <void0red@gmail.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/exfield.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index 6e86759162df..632fc8693f23 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -347,10 +347,28 @@ acpi_ex_write_data_to_field(union acpi_operand_object *source_desc,
 		 * implementation will use the offsets specified rather than the name
 		 * of the field. This is considered safer because some firmware tools
 		 * are known to obfiscate named objects.
+		 *
+		 * Ensure the field access does not exceed the bounds of the
+		 * internal_pcc_buffer.
 		 */
 		data_length =
 		    (acpi_size)ACPI_ROUND_BITS_UP_TO_BYTES(obj_desc->field.
 							   bit_length);
+
+		if (!obj_desc->field.region_obj->field.internal_pcc_buffer) {
+			return_ACPI_STATUS(AE_AML_NO_OPERAND);
+		}
+
+		if (obj_desc->field.base_byte_offset + data_length >
+		    obj_desc->field.region_obj->region.length) {
+			ACPI_ERROR((
+				AE_INFO,
+				"PCC field at offset %u length %u exceeds region size %u",
+				obj_desc->field.base_byte_offset, data_length,
+				obj_desc->field.region_obj->region.length));
+			return_ACPI_STATUS(AE_AML_BUFFER_LIMIT);
+		}
+
 		memcpy(obj_desc->field.region_obj->field.internal_pcc_buffer +
 		       obj_desc->field.base_byte_offset,
 		       source_desc->buffer.pointer, data_length);
-- 
2.56.0

