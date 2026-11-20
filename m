Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195316;
	b=gHtVGxV3dTc/FphNh0NA1EYrXrxpRt4WrfStVKPh0PQMsozNHEK3EeN+KOrfEgx/kqFj
	 uyViFTkfNJR0YGgI8YL9Yxoqiv+0NMbfUQnSvDCNszwia/kgyMb5L/c7w1YAGnz4OSVD5
	 77CsKmG6zNqPwdRSuCBM7UawE2UXfHN3cwzfC8hKIe40sfu/EAdr24GdHtyciVvgC/joB
	 OeVA+1IIe2EymFDtue0+YlmQbo9M1SZx9ANyPuMUWgXNscQlpSiMJ/9rUsk1ZAehXPJ/W
	 sTSf52Fy3mfxfWYAxsLcjmJ73XqcelvOB5ukUybnT+EOXEIVxwGsmcww9SESZdJf4rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195316;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iy1u3+dFMDrnkVzbbtDqodu2N36DjRx9VOyWE7tzxzQ=;
	b=r3xGmQzoD7PUW2G/w/NWfSiS5Y1JjhX05+si6GxxdNmiJowwqFgZ0qp4IdpQygCRQhN2
	 zcq3uuOmKGq5ixsCSRGir20rtAMM7fY/rM7ouLYRLVQI+73sLpH12dIZfVokRzNePXS6z
	 ox8S8eNxSG2Ra5MvH1BNUauDojO6J3SuPK/nq4nkiPJQ94YoltQQLoGr4LUN60pLdy0MK
	 EVpZab0wfu49b3A8GV+u1O/oy3Kfhk12ZNy6sfSCI6ME0w3n9ZW0yqpuc6Ro85u2UFfYQ
	 v7AlypWTY2qBRAChswMfkdOM7uqmV/BjwBeZUDKYfND0dgb1NSg53r06cg83HJdqjIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S9ALcKJl;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1A560A3813
	for <acpica-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F1A560A3813
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S9ALcKJl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195316; x=1826731316;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TZxOBlqrtvgnSWz8BF2TTAMtMNewr0wAgGpPCzAn9vM=;
  b=S9ALcKJlc7zrqeIcY43/53UReAzO+IQKp0lxG0V4K7LbL1ntAmCHsfbS
   YPV0lcmzMC5i3CBjkwet/DrhwvFNk3E4HApn+LPhPTb6AAuCm0hTI7nXy
   xUFrtqGFQ+ylxw4zPVq0R9HGWO+C7KMzrvb49xJSvcg3kPjuMj1cnWXYN
   Wm9WqobmbutW2FRPG2Q9s5KFXVTLB6u6zncnWIHXQsS2VDL0/n0917jxp
   a/iZBIU02ZkAlf6qZL+mPqyPXs8lsXv6SOhxenppSsSAyXYIAzyqjh3C4
   G79Tk5mpZUZC7lm3pRIY6KxecN6V82aLL/MMFS8rxD8bAWAcVKEtADcYY
   g==;
X-CSE-ConnectionGUID: +JC7ugqSQuusojc4cZjkdA==
X-CSE-MsgGUID: IK0xd9o/Q4GHb0kRKHxADg==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157562"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157562"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:47 -0800
X-CSE-ConnectionGUID: GVbYbIGhTE249mfcXBGrHw==
X-CSE-MsgGUID: Ey5tk66sR9STlGXy5G7bZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868235"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:45 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 34/42] ACPICA: events: Fix GPE cleanup return after changing program state
Date: Fri, 20 Nov 2026 18:18:55 +0100
Message-ID: <d6f41b8bc2c8cd92f93af27bce2634d07270bc8b.1795194329.git.maciej.wieczor-retman@intel.com>
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

If a GPE dispatch method or notify is currently getting executed or is
set to polling etc. its table can't be freed. However the original
commit ("ACPICA: Events: Clear GPE dispatch by owner during table
unload") that tried to fix this problem would check this condition while
some GPE methods already got disabled.

First parse all the GPE blocks and look if at least one element is
blocked from being freed. If so abort the cleanup operation.

Link: https://github.com/acpica/acpica/commit/97f12aaf72cc
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/evgpe.c | 49 +++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index d45926ad3261..5c283a2faaf0 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -636,6 +636,43 @@ acpi_status acpi_ev_clear_gpe_dispatch_by_owner(acpi_owner_id owner_id)
 
 	/* Walk all GPE interrupt blocks */
 
+	gpe_xrupt_info = acpi_gbl_gpe_xrupt_list_head;
+	while (gpe_xrupt_info) {
+		gpe_block = gpe_xrupt_info->gpe_block_list_head;
+		while (gpe_block) {
+			/*
+			 * Walk all GPEs in this block to make sure none are blocked from
+			 * getting cleared with disable_for_dispatch
+			 */
+
+			for (gpe_number = 0; gpe_number < gpe_block->gpe_count;
+			     gpe_number++) {
+				gpe_event_info =
+					&gpe_block->event_info[gpe_number];
+				gpe_dispatch_type =
+					acpi_ev_dispatch_type_hidden_handler(
+						gpe_event_info, owner_id);
+				if ((gpe_dispatch_type ==
+					     ACPI_GPE_DISPATCH_METHOD ||
+				     gpe_dispatch_type ==
+					     ACPI_GPE_DISPATCH_NOTIFY) &&
+				    gpe_event_info->disable_for_dispatch) {
+					/* At least one handler is polling or executing, cannot clear */
+					status = AE_ABORT_METHOD;
+					acpi_os_release_lock(acpi_gbl_gpe_lock,
+							     flags);
+					(void)acpi_ut_release_mutex(
+						ACPI_MTX_EVENTS);
+					return_ACPI_STATUS(status);
+				}
+			}
+
+			gpe_block = gpe_block->next;
+		}
+
+		gpe_xrupt_info = gpe_xrupt_info->next;
+	}
+
 	gpe_xrupt_info = acpi_gbl_gpe_xrupt_list_head;
 	while (gpe_xrupt_info) {
 		gpe_block = gpe_xrupt_info->gpe_block_list_head;
@@ -656,17 +693,10 @@ acpi_status acpi_ev_clear_gpe_dispatch_by_owner(acpi_owner_id owner_id)
 					 * GPE method belongs to table being unloaded. Clear
 					 * only the dispatch type, preserve other flags.
 					 */
-
-					if (gpe_event_info
-						    ->disable_for_dispatch) {
-						/* Handler is executing, cannot clear */
-						status = AE_ABORT_METHOD;
-					} else {
-						/* Clear only the dispatch type, preserve other flags */
 						gpe_event_info->flags &=
 							~ACPI_GPE_DISPATCH_MASK;
-						gpe_event_info->dispatch
-							.method_node = NULL;
+					gpe_event_info->dispatch.method_node =
+						NULL;
 
 						/*
 						 * Hardware-disable the GPE so a late interrupt
@@ -676,7 +706,6 @@ acpi_status acpi_ev_clear_gpe_dispatch_by_owner(acpi_owner_id owner_id)
 						(void)acpi_hw_low_set_gpe(
 							gpe_event_info,
 							ACPI_GPE_DISABLE);
-					}
 					break;
 
 				case ACPI_GPE_DISPATCH_HANDLER:
-- 
2.56.0

