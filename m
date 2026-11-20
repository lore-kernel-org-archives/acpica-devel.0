Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195318;
	b=r7VViNq+jPZwkMeXQdoDx2hrbjbq9GRMn2CLzAfC19uXFPJqT7wLwM6U86+o0kKDotSW
	 To3izElE99A+H8qMRFHVYpPhuqNF9425x0/XysPr1PLa8F5Tf7tOFOP7WeQC5EsQOGWF5
	 ufvDXdEZ5LRmZRj1xoOwlGMhbLiL797zNzfyTwbmAoYdj5DMHRz9EFQ/dBVoaZFDX5FoM
	 8Pk2aQbkh81ey4B6uFH8jvGCKlhN7lXZKyb7ok8UCzdq97S1YxFAC+38hdTDeXIWciYUE
	 1raMs7kwUAwWBlDpmH7/bss9G2g/HSHp3+tiTwnkzao5CllPHcFqAovYCC6RepWL4+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195318;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=e45Lmst2zVLRRgQuRR+OUKKJ4pLT6Oi0ahkMpBTiPW8=;
	b=AV5cylKQILOT0o4YXalqelg+ykVbX9vqeCokxWPGr6dh79rehUKVCazk1G5/dAZPOywH
	 hUxfB2zZ2AlixNROS7Tq3AbM6wEN8lHkvpe09VdjLxM2yeUd/RV3TcueYpajJRYHPmZaE
	 5t0gX+bPGUgg2x4lncc2nqhKmqPF2r5j/ad7bGYACA7gTdPbsag8X3/llIkNJfYgCAdsr
	 bHQ29QuWUzEHaRkeYu7fNFc2STXbpLuJaptOqgKOtAenVhIv/2bEl9KnP9nEp6Q7JAEHX
	 KJ8cs5bB5vbBOVgirx3/4SNx/51m6ckM6gsUg8PjsWez/tznYztC0bT0tTqwhzPfSAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HdurqOH4;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931DB60A6F4E
	for <acpica-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 931DB60A6F4E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HdurqOH4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195317; x=1826731317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pts6JG9+FGLpbzP21b9GAVZnO6zHcnXOWhbooQaGodI=;
  b=HdurqOH4evHAuxYPMs5gyEWKd0NERXIE3UJAK8Ak7eFegOccwnpOr59P
   pSzUkKVXVoUTU2TCoad9eldMfwRsDHsWZOj+g20laeVI6L98t/LQvEyFT
   FBiT6xrfMT2iITCbhSHRgAtYrJO3iO6P6lt6w3/gbWJprn0qIHyKns0z5
   K7NLhndF/nFMzYDejPno6G/Kg55KIyylMwX//yhTorkVQ/Psc3IMwlZrN
   u/1vV+r4LFXvVL/VrQpaPu9OyRGLY+IM6tj0LjdRdUzsiLr3vHjnNYThE
   rNVCf7+oZrmA1e6//SmRdW7Msl2ThoFQGxtPh5TxB0Ll71lcrgMt28IhX
   w==;
X-CSE-ConnectionGUID: r2aSEVpkT4iw7+GMBwVJHw==
X-CSE-MsgGUID: BQ0CRAn4Q42pjYFhxLWgOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157556"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157556"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:44 -0800
X-CSE-ConnectionGUID: OpGJwTTjTY6WT+59rdMD2Q==
X-CSE-MsgGUID: m+dFjAx6QEGe1KqDqWXNuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868222"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:42 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 33/42] ACPICA: events: Fix AcpiEvClearGpeDispatchByOwner handler type processing
Date: Fri, 20 Nov 2026 18:18:54 +0100
Message-ID: <36e3df265cf6a5e85d108268c28eb4d7c4e7ab38.1795194329.git.maciej.wieczor-retman@intel.com>
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

GPEs can have different callbacks tied to them - methods, notifies and
handlers. Handlers, usually being functions called from C drivers,
override methods, but they save the pointer to them and restore them
later when handlers are unloaded.

Check and clear the methods hidden under the handler.

Link: https://github.com/acpica/acpica/commit/578d52b5d1f4
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/evgpe.c | 103 +++++++++++++++++++++++++++++++++---
 1 file changed, 96 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 578651cde6f3..d45926ad3261 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -535,6 +535,67 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 }
 
 
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ev_dispatch_type_hidden_handler
+ *
+ * PARAMETERS:  gpe_event_info  - Struct where GPE dispatch type is stored
+ *              owner_id        - Table owner_id being unloaded that should match
+ *                                the gpe_event_info
+ *
+ * RETURN:      Return the dispatch type if it is either explicitly present or
+ *              hidden behind the handler saved method_node. The GPE has to also
+ *              match the table ID passed through owner_id to this function.
+ *              Return 0 if the above criteria aren't matched.
+ *
+ * DESCRIPTION: Check whether a passed GPE event info is of either DISPATCH,
+ *              NOTIFY or HANDLER type. Then verify it belongs to the table
+ *              ID passed as an argument and that it has a Method Node. Helper
+ *              is used for example with cleaning up after table unloading.
+ *
+ ******************************************************************************/
+static u8
+acpi_ev_dispatch_type_hidden_handler(struct acpi_gpe_event_info *gpe_event_info,
+				     acpi_owner_id owner_id)
+{
+	u8 gpe_dispatch_type = ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags);
+	struct acpi_gpe_handler_info *handler;
+
+	switch (gpe_dispatch_type) {
+	case ACPI_GPE_DISPATCH_METHOD:
+		if (!(gpe_event_info->dispatch.method_node) ||
+		    (gpe_event_info->dispatch.method_node->owner_id !=
+		     owner_id)) {
+			return 0;
+		}
+		break;
+
+	/* Method or Notify can be saved if the handler is present */
+	case ACPI_GPE_DISPATCH_HANDLER:
+	case ACPI_GPE_DISPATCH_RAW_HANDLER:
+		handler = gpe_event_info->dispatch.handler;
+		if (!(handler->method_node)) {
+			return 0;
+		}
+
+		switch (ACPI_GPE_DISPATCH_TYPE(handler->original_flags)) {
+		case ACPI_GPE_DISPATCH_METHOD:
+			if (handler->method_node->owner_id != owner_id) {
+				return 0;
+			}
+			break;
+		default:
+			return 0;
+		}
+
+		break;
+
+	default:
+		return 0;
+	}
+	return gpe_dispatch_type;
+}
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ev_clear_gpe_dispatch_by_owner
@@ -557,6 +618,8 @@ acpi_status acpi_ev_clear_gpe_dispatch_by_owner(acpi_owner_id owner_id)
 	u32 gpe_number;
 	acpi_cpu_flags flags;
 	acpi_status status = AE_OK;
+	u32 gpe_dispatch_type;
+	struct acpi_gpe_handler_info *handler;
 
 	ACPI_FUNCTION_TRACE_U32(ev_clear_gpe_dispatch_by_owner, owner_id);
 
@@ -584,13 +647,15 @@ acpi_status acpi_ev_clear_gpe_dispatch_by_owner(acpi_owner_id owner_id)
 				gpe_event_info =
 					&gpe_block->event_info[gpe_number];
 
-				if ((ACPI_GPE_DISPATCH_TYPE(
-					     gpe_event_info->flags) ==
-				     ACPI_GPE_DISPATCH_METHOD) &&
-				    (gpe_event_info->dispatch.method_node) &&
-				    (gpe_event_info->dispatch.method_node
-					     ->owner_id == owner_id)) {
-					/* GPE method belongs to table being unloaded */
+				gpe_dispatch_type =
+					acpi_ev_dispatch_type_hidden_handler(
+						gpe_event_info, owner_id);
+				switch (gpe_dispatch_type) {
+				case ACPI_GPE_DISPATCH_METHOD:
+					/*
+					 * GPE method belongs to table being unloaded. Clear
+					 * only the dispatch type, preserve other flags.
+					 */
 
 					if (gpe_event_info
 						    ->disable_for_dispatch) {
@@ -612,6 +677,30 @@ acpi_status acpi_ev_clear_gpe_dispatch_by_owner(acpi_owner_id owner_id)
 							gpe_event_info,
 							ACPI_GPE_DISABLE);
 					}
+					break;
+
+				case ACPI_GPE_DISPATCH_HANDLER:
+				case ACPI_GPE_DISPATCH_RAW_HANDLER:
+
+					handler =
+						gpe_event_info->dispatch.handler;
+					gpe_dispatch_type =
+						ACPI_GPE_DISPATCH_TYPE(
+							handler->original_flags);
+
+					/* Forget the hidden method so handler removal can't restore it */
+					if (gpe_dispatch_type ==
+					    ACPI_GPE_DISPATCH_METHOD) {
+						handler->method_node = NULL;
+						handler->original_flags &=
+							~ACPI_GPE_DISPATCH_MASK; /* -> NONE */
+						handler->originally_enabled =
+							FALSE;
+					}
+					break;
+
+				default:
+					break;
 				}
 			}
 
-- 
2.56.0

