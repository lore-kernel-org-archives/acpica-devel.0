Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195328;
	b=W+L1/wOW8wjieOKueXuDAikbgUXr1cWG5+WT/FHJru8DrSWLx+HcoAzrHpIiqUO/uRCx
	 qOmqwSASOndUCpbAuK93bqdwChH4A+4dA5SyAineFOMdwwXatAIirYk9OMftLnZ5lNyPZ
	 qwohi80arKuuhxsvbg5SVTi4S/kCKfWFJSInt535o5P6o7gQlNMkiriz0wQsHMWLyDbvg
	 AUyWpPxnQRY0kEhVECGzewioIKV9WEoStkn+4akG9ZuuROq+ABfUorWg1KVNIrCNAlfIY
	 F5NTSqCruI8e9W9GDG+hPy+IUMqohJVVZDPap4+xp0CY7+/z+Ljv7COyaClk8Dj0EZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195328;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FxF0gWJg1/mc3UmsBUpHKNHcirNZbLQT4wHXPvy0m1Q=;
	b=ZjbVJXZncu0jQzsBBXWP36LMZUTwr4xxWJpLNjLxDNn1MkzTK98e5RyVOVwLhYyUQ5fo
	 an/DXy0ATn7vvz32mu7OoQxPDmCzHEiQy7I1ydoCFS2gZsTbI/LKYEK0ZXD+uMvigvwn4
	 Kyl8nz40O3wMUaUQSiGQHiaVzn5Cc6ldh5CMhylszNKPWNhPS5LzwPndYKe8nQuKskxS5
	 6JwarGG+ECBeZ9ng7NoCCyp1VNpAP7+4+qH/SnDrHUl5vOnZHnn54MpJZoX2eDh42/wmi
	 erz8oPHmLcRWAMgri7S8SqLyB7MI5ZwB3gChKxaFmda69ihhJmyex+3nPjrvXLN384A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H1Cph8bW;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44013606C293
	for <acpica-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44013606C293
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H1Cph8bW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195328; x=1826731328;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1hHe5UA6gRj04Yam/2Su93QsRWygdL2zZOg7Mw9c1V8=;
  b=H1Cph8bWpSRNxS5lH6TSxbwtm4rq3jsM+sdW3D28nhCDAzZkUCS8ZoaJ
   YC3F+pc8dvUuyk88wUQGBxK9QwvNzp4ebDnPX+Zvx+8Zwgcd8NGbqXS1J
   uM38HJhLEUgGLuuW1Xe83ygVx/GWbuD4eBhdN61mE9ddsElLLl/KkVtqe
   6NvbgP1+v7XZ/Y9X+dL7OOVdZ9sccu203PTfZNVsxvltXMbHRuIElC9eO
   sebyv/iZoYoi+vZOM8oCC4V0wquQW/H5AX7IjCfS2k+VZ5OfLMJ4zH4+M
   hzbEnIA17+zXMlLFPB9u1UsJPmQs+R1ymuewM9TWo8yeRYghAlfzWunj1
   w==;
X-CSE-ConnectionGUID: RP2fSIaQT/CvFZxF4n6jDg==
X-CSE-MsgGUID: AFUvdnRmRNG3YM6i4Slg0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157622"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157622"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:22:08 -0800
X-CSE-ConnectionGUID: hsHVH6rzSViQquCmjFiyBw==
X-CSE-MsgGUID: WTd/tQo9QuG4VHtMfZz5Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868301"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:22:05 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>,
	ikaros <void0red@gmail.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 41/42] ACPICA: namespace: Fix memory leak around compiler alias flag
Date: Fri, 20 Nov 2026 18:19:02 +0100
Message-ID: <d6c2659bc726818faad879203b1703801154125d.1795194329.git.maciej.wieczor-retman@intel.com>
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

ANOBJ_IS_ALIAS is an iASL only flag that shares the bit position with
ANOBJ_ALLOCATED_BUFFER, which is a flag used for runtime installing
methods. Due to the bits matching a memory leak happens everytime a
method is loaded in acpiexec (using AcpiInstallMethod()).

Check the compiler related flag only when the code is ran by the
compiler.

Link: https://github.com/acpica/acpica/commit/b01f4e055910
Fixes: 8d7987340301 ("ACPICA: Add alias node support in namespace handling")
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/nsobject.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/nsobject.c b/drivers/acpi/acpica/nsobject.c
index 49d9d917fa73..6eb278b9d714 100644
--- a/drivers/acpi/acpica/nsobject.c
+++ b/drivers/acpi/acpica/nsobject.c
@@ -175,8 +175,11 @@ void acpi_ns_detach_object(struct acpi_namespace_node *node)
 
 	/* Alias nodes point directly to other namespace nodes; skip teardown */
 	if ((node->type == ACPI_TYPE_LOCAL_ALIAS) ||
-	    (node->type == ACPI_TYPE_LOCAL_METHOD_ALIAS) ||
-	    (node->flags & ANOBJ_IS_ALIAS)) {
+	    (node->type == ACPI_TYPE_LOCAL_METHOD_ALIAS)
+#if defined ACPI_ASL_COMPILER
+	    || (node->flags & ANOBJ_IS_ALIAS)
+#endif
+	) {
 		node->object = NULL;
 		return_VOID;
 	}
-- 
2.56.0

