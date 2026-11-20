Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195294;
	b=DJ+RT14E5lzo90iiaXjR9LWHltNVaQ495Tp9vknDvPWH80y/8qZPR8OIEV3XsjQeRezl
	 oq4v6Ksh7Uek7YfFj5/pav3ByGs6Si4GU5GxFxqeJnKaCC7bwjOGwvhixwroE+J3YDYPG
	 nwrzGWlBY1PZPjn1o1/ylHn1PkY1Gg9eW67k1UfHjNqAQDywEjJC1jK5stSaSoFu6IiLw
	 kVQUk2B+jhW3L+x6OHd+9481bxOG9Hd+y9Vn297qNlTS4SELAWqWDUlj5AWRE1Weg+HcY
	 fnRIcsOXzSLhllCKmlJNhsAIzhp92R2tN5MVdKa1zaeZr9CV9N5HPa031aScpHTuweg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195294;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=t1iSABh24B4vqNjNqk/PuMVMp4ndrA9W0AbohqmlAnE=;
	b=K8IYqustqfopFeIniUZ3vHb0/Gy52yzmBAOgRm9p7srMm0Li6bctpH4kyQ1s9yNzZXih
	 GUXtx1CQ5q64mGS52o0hw8n2eTYmxua6ny0WT0325MXvEVPHR2pzYDwzR6lLAvpD7Mdgs
	 EAlNTORaUn8mPmykGIZWW+ojuttquAPt8dsvNOkr5MqERY7RKLpuP+4JwWNKgsXIvKEwX
	 /NTRlPh5+F+vFCjWbkdGqNaYdRjV+MvZ0LZiZosI2XQqqANmHYrhNfHka+8Q9RZQv18OB
	 JMM8pWQobBaPOI8bucWE0aULRCRBEflhrX4z9hK1WX9e77ruBdCVw6BiJ/lZM6o04Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DxZazAJ8;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFC6606A77B
	for <acpica-devel@lists.linux.dev>; Fri, 20 Nov 2026 17:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBFC6606A77B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DxZazAJ8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195294; x=1826731294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/qaIxDahUGh/hHepfq5P8ilVmN9LUSnnLNKjIkPQggI=;
  b=DxZazAJ8s25DyKrn9QBwpZpYqm7rfmEJJKEMie9I6w5taC/nBa/zd7UN
   HuLjM7/xz2qAyj7aIeEL4/daTP2O8mjAiXXqNZkp+H6lXHHPgL3XdyLyK
   B/N3tAJJPmR5s7WKHPhD8rnC1t0wlr9zHtnKh5jwqsoHv52AfmLHmRoB1
   HyMyc5YD8Go80OvTnyRjSX45tjvF0KMka0IeIH0mq6/v3+HbBHZv2qyOV
   //96MHEA+nGYzo+WAexW5NCzkAyNGOg44ix+CN1iwhDFEWyJJ9p1kN0Hp
   kFHr8sZFwjgeoX/V6F/z6CxK0u25YUtPRYmaQuZiKvkmHgSyMYYJEyDa1
   Q==;
X-CSE-ConnectionGUID: wL3jUEY9SGuLRdE22Kv/zg==
X-CSE-MsgGUID: Btx/creMQnavzuWkn2yp0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157509"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157509"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:33 -0800
X-CSE-ConnectionGUID: /W3H3v2STMiMRhbvCw36lw==
X-CSE-MsgGUID: b+eXtxC1TZ6+hdGoVfGSrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868189"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:30 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: Iurii Trukhin <yuri@trukhin.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 29/42] ACPICA: parser: Fix parse tree memory leak on AML execution error unwind
Date: Fri, 20 Nov 2026 18:18:50 +0100
Message-ID: <37d308175937846fedd3d81d786831906e746dbd.1795194329.git.maciej.wieczor-retman@intel.com>
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

From: Iurii Trukhin <yuri@trukhin.com>

AcpiPsCompleteThisOp() checks WalkState->OpInfo->Class when deciding
whether to defer deletion of an AML_CLASS_ARGUMENT parse object to its
parent. During error unwind, however, WalkState->OpInfo can still refer
to the child that failed while Op refers to an enclosing scope.

If that child is an AML_INT_NAMEPATH_OP, the enclosing parse subtrees
are skipped as well. A nested control method has RootOp = NULL, so an
unattached top-level If subtree can leak on every failed evaluation.

Look up the opcode class of Op directly and only defer argument-object
deletion when Op has a parent. Preserve WalkState->Opcode, which the
parser still uses when skipping failed module-level scopes. Remove the
extra region-error AcpiPsDeleteParseTree() call now that completion owns
that deletion, and return discarded control states through
AcpiUtDeleteGenericState() instead of freeing cached objects directly.

Tested with native iASL and acpiexec using a nested _GPE._L6F method
whose If predicate calls a missing external _STA method. The unpatched
interpreter leaves 64 parse objects after 32 evaluations; the patched
interpreter leaves none. Both retain the expected AE_NOT_FOUND result.
Normal If/Return evaluations continue to return 0 and 42.

Link: https://github.com/acpica/acpica/commit/2627fccee606
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221241
Link: https://lore.kernel.org/all/CAOx7e9+Vv8Pdyks=AbE5XG0ZyDgtKToKyBLTnt+H5RPn6VymVg@mail.gmail.com/
Signed-off-by: Iurii Trukhin <yuri@trukhin.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/psloop.c   |  5 +++--
 drivers/acpi/acpica/psobject.c |  1 -
 drivers/acpi/acpica/psparse.c  | 16 ++++++++++++----
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index 24a57f971c96..f67bc2f3dc42 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -464,8 +464,9 @@ acpi_status acpi_ps_parse_loop(struct acpi_walk_state *walk_state)
 						walk_state->aml =
 						    parser_state->aml;
 					}
-					ACPI_FREE(acpi_ut_pop_generic_state
-						  (&walk_state->control_state));
+					acpi_ut_delete_generic_state(
+						acpi_ut_pop_generic_state(
+							&walk_state->control_state));
 				}
 				op = NULL;
 				continue;
diff --git a/drivers/acpi/acpica/psobject.c b/drivers/acpi/acpica/psobject.c
index 629cafab1930..f1425b98087b 100644
--- a/drivers/acpi/acpica/psobject.c
+++ b/drivers/acpi/acpica/psobject.c
@@ -559,7 +559,6 @@ acpi_ps_complete_op(struct acpi_walk_state *walk_state,
 								node);
 					acpi_ns_remove_node((*op)->common.node);
 					(*op)->common.node = NULL;
-					acpi_ps_delete_parse_tree(*op);
 				}
 
 				status2 =
diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
index 42ec8abef626..aa89bad57647 100644
--- a/drivers/acpi/acpica/psparse.c
+++ b/drivers/acpi/acpica/psparse.c
@@ -108,6 +108,7 @@ acpi_ps_complete_this_op(struct acpi_walk_state *walk_state,
 {
 	union acpi_parse_object *prev;
 	union acpi_parse_object *next;
+	const struct acpi_opcode_info *op_info;
 	const struct acpi_opcode_info *parent_info;
 	union acpi_parse_object *replacement_op = NULL;
 	acpi_status status = AE_OK;
@@ -122,11 +123,18 @@ acpi_ps_complete_this_op(struct acpi_walk_state *walk_state,
 
 	acpi_ex_stop_trace_opcode(op, walk_state);
 
-	/* Delete this op and the subtree below it if asked to */
-
+	/*
+	 * Delete this op and the subtree below it if asked to
+	 *
+	 * Derive op_info from Op instead of using walk_state->op_info. While they are
+	 * often synonymous it is different during error unwind (in acpi_ps_complete_op).
+	 * Then the latter can describe a failed child object instead of the enclosing
+	 * operation that we want to handle here.
+	 */
+	op_info = acpi_ps_get_opcode_info(op->common.aml_opcode);
 	if (((walk_state->parse_flags & ACPI_PARSE_TREE_MASK) !=
-	     ACPI_PARSE_DELETE_TREE)
-	    || (walk_state->op_info->class == AML_CLASS_ARGUMENT)) {
+	     ACPI_PARSE_DELETE_TREE) ||
+	    ((op_info->class == AML_CLASS_ARGUMENT) && op->common.parent)) {
 		return_ACPI_STATUS(AE_OK);
 	}
 
-- 
2.56.0

