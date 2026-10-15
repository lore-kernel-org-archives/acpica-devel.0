Received: from mail-oo2-f11.google.com (mail-oo2-f11.google.com [74.125.231.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9AC30DECE
	for <acpica-devel@lists.linux.dev>; Thu, 15 Oct 2026 01:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792027737; cv=pass; b=BnDgLw2lgd3lFgp37CcEyAWjOVtPuhMcrb59ZgzYnnRbFqOtisZIH3Y/Vd4IoGUbXBx5jmXCI9MSljywMoiitqJjJvw4nLZ0UWpJrHzT4OplPQVs4/8eGQPeA1zqcxoYGRfFejkFj5j4WQQun4LB1YvsyYGKz/IU8DAK5kt3+RQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792027737; c=relaxed/simple;
	bh=dnx6g/9ixM5NFJDISuWjAeW3ycDShCzXPusFIgWOxcs=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=WMWyvzK/acMZpSqQbBzvHh1MTY8j4xQwiWN7Tc5Wcf4pfNHcOm8Ro6esuWkrjsLEZDHpdRMXw78KEuARSKENDqx9mhC7T5PLUSoo0WsrrcsBvi+tZIRvyUnyu4YmgBSAn+pifbWniuSvvdfIBX8iDltGW3f2KT7QCCUAMlimSwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trukhin.com; spf=pass smtp.mailfrom=trukhin.com; dkim=fail (0-bit key) header.d=trukhin.com header.i=@trukhin.com header.b=cQx+jTGd reason="key not found in DNS"; arc=pass smtp.client-ip=74.125.231.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trukhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trukhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=trukhin.com header.i=@trukhin.com header.b="cQx+jTGd"
Received: by mail-oo2-f11.google.com with SMTP id 46e09a7af769-8262eba3e93so887182a34.0
        for <acpica-devel@lists.linux.dev>; Wed, 14 Oct 2026 18:28:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792027734; cv=none;
        d=google.com; s=arc-20260327;
        b=YhcRKoPNEjGnspyFkkL14lDLidHl8Q1cxHWedrH88GCS3IzC4zMEO5A8wj0msIECDL
         BUcqCBPTlJ3GtxVZOJUdqX5E0Oo58EX3ZxvomIrXrkUaf99xKwoivzOt7HRf2XF3LgFe
         cJZVLUwEi/zFSvZOPUDfaRfVEFkC1seuOKGYL49+dg4ZmAdipO/T4f1xDvU0F5jPbtcF
         A7P/0s1Oeo8rqpGswT1RStSWauHJAITovw8u5pS6+pDTMUUfsaSK5E8WcPwkUIjeTAY1
         xkIWXPrpqrc0DShI7dA5eVdaVun02/TUBmAePSSC3Mdcsp9w1sgzvAYZ/EsK/R0cwtYH
         jdJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=Q5uVuvTWXajEdN6wZPxpoBw0tWfNu44FcU1kEUeI9h8=;
        fh=DaXZZkgP3Zb10wCEj/vxKfCbHxDL3/5gkk8Mj2CparA=;
        b=M6IoBl4LwIhvO5TFDs6iEwW1j4TbBdM9iWEShmwt7IdwroKbTX9bpqEtK35ebZShJn
         DefFYznPKBvV6bIHNNW4Buc3jzXM5uGLSHltm9W0Ej7kZ8r97OiKw1HNXGBIqnZxVdxx
         cmXVQ1iu4dH+1ZAEZMYS2/6BFQpJWYT7aaoKEXfqVD0IbIyR0kQHf/oj3NimOC92RbJw
         bx2C/N0SiHhdS6MgL7Rg0TuhZKDaUHpcYamaRjRIrk3w9DqeaFW/dfYyexIrjmwnoCU7
         cItP+nNE1i1W6Sd4HIqkR2TOWR1ZXiPrJro8y3oxaqdZHeb8pyNRgggKOavqd0/qZEHw
         Zh/A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trukhin.com; s=google; t=1792027734; x=1792632534; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q5uVuvTWXajEdN6wZPxpoBw0tWfNu44FcU1kEUeI9h8=;
        b=cQx+jTGdwli8bYrhj59XA9U/KjP4n3LNOT1UrwPJ7xUDf9L/2pZTrB23Fg9h7yUpK0
         l7fbU5HOm2otJHAdtdLybu3JB40rlv+48k/iUXLgOmcy6Uw2XH5GGwOGyT9UMSGjN2fN
         TwVeIyayamZgecv6cgZlE5+4HQKR4BEs10WduF7i1Wl3N8eqhQ9E02P/dzXmOwzdhBfi
         nHxq8muoYE55RbASUO1bPdfUNf50W0PIqUVTxkZAw8wn/77wpnniBgoiRNFOH1mb7RQR
         8olxDp2c8uUqbtOukbQeXDAKwiZho3WHUXNyEy9TDjpKf63DlyLadhTCyuBu995ElvaA
         UMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792027734; x=1792632534;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Q5uVuvTWXajEdN6wZPxpoBw0tWfNu44FcU1kEUeI9h8=;
        b=Jsg9W5N8XZZgMC1oCh7Ch/LcDoqjBPiBrgknXZToor+7bf//GpXXs7AF7V06aEFS5v
         PF0/LzqPtUym+PdiTbCxRd9egOfxI/7M71F8fN+XYrwNfgRtMa2chiPduLngF7cMNmlq
         FGAprs+HcyMVy5YwaX9SoSpi/UojP9pN/AdqIbFbd/B0QJXdb9ovoKyDM6DqibFDCjo7
         xa7Tld3cxhiHFrH3InpJC8OTVtvt1e7Zb3RQkLqWMTVsn9SJHrm/r1fLnevvOBkDhlpw
         NpIMDK+pa/oktrfmPfJjg4Lvy4+XMWPH07/kApmhN8bsGZYRw+6/EuY5ZgXOjUw+nBU9
         LZKQ==
X-Forwarded-Encrypted: i=1; AKwUvBzYnBHrHu4593pxklm4GRqO6xat/YwOb2ekjLjNB/EcjLGZh9oYLwDbOtSQueJ62XjebByBYuAGs/Eddbo=@lists.linux.dev
X-Gm-Message-State: AFq9FYL6Z3XEGU268pcUW2A/yRvjQBuOqNk7EnCs80Gf3FMJGMtGg93P
	Bfw5bWHtbMBhhaTqqzIjtcgNSDcChj6MXdL2SMqp+JBVQYlI0fQCAOIkwhuTzlHNXWRJRlA1j60
	HgyFS92uH11R5R0uWElSJAL9BkMjHL9SOsSqP6cV1Lg==
X-Gm-Gg: AYBFou3yZ/loz59/30WAHQZzQowETqiHr+nsAHkuu+eVcnvN4uwrAxvRZwWoKWsSqMt
	0fhfsvmxUpGPMwk1BFqsAYRfZx1ctPu/LIuiBowJ37syBHiOF3kugAM38Wx3CR8KvvdJI16hxCI
	ZNevJxPVAfqUVnbfSqf2usT51m/2Q1E+eV8v6ayz58dCorY5kb7phbvZaOf9ZhpBiFxOqI42NEj
	EwonAJughQWG1IidRpRmDfKVdZ399XWGhDFYH3HMadJ1O1xH89a+ay2OyzR0oV8I8pLy6zZkC3d
	NYnASKQoaqgantjrRh1iLtjBIIVpsms6kA/ojz73Y17itbI3vh/MffvUoJS3G8MMJRYkDE2vpnO
	SiYu/2QFxUj0b/Bo9pnRzvyQ=
X-Received: by 2002:a05:6808:148f:b0:4d5:27da:a494 with SMTP id
 5614622812f47-50c54d0702fmr16047927b6e.46.1792027733598; Wed, 14 Oct 2026
 18:28:53 -0700 (PDT)
Received: from 121308794542 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 14 Oct 2026 21:28:53 -0400
Received: from 121308794542 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 14 Oct 2026 21:28:53 -0400
From: Iurii Trukhin <yuri@trukhin.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 14 Oct 2026 21:28:53 -0400
X-Gm-Features: AclHuK-P7Ehq46s_2_6B_7t-fPVdAN2KoxDEtkusBHHCqXfchF4D5I86ViwzGGU
Message-ID: <CAOx7e9+Vv8Pdyks=AbE5XG0ZyDgtKToKyBLTnt+H5RPn6VymVg@mail.gmail.com>
Subject: [PATCH] ACPICA: Fix parse tree memory leak on AML execution error unwind
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: Robert Moore <robert.moore@intel.com>, Erik Kaneda <erik.kaneda@intel.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, 
	Pawel Chmielewski <pawel.chmielewski@intel.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Iurii Trukhin <yuri@trukhin.com>
Content-Type: text/plain; charset="UTF-8"

acpi_ps_complete_this_op() decides whether to defer deletion of an
AML_CLASS_ARGUMENT parse object to its enclosing parent by checking
walk_state->op_info->class instead of the opcode class of the op being
completed.

When acpi_ps_complete_op() or acpi_ps_complete_final_op() unwinds open
parser scopes on AE_CTRL_TERMINATE or an execution error (such as
AE_NOT_FOUND when resolving a missing symbol inside a control method),
it pops each enclosing parent op and passes it to
acpi_ps_complete_this_op() while walk_state->op_info still points to the
last child op that failed. If that failing child op was of class
AML_CLASS_ARGUMENT (for example, AML_INT_NAMEPATH_OP when
acpi_ps_get_arguments() fails to resolve a method call or predicate
operand), acpi_ps_complete_this_op() sees AML_CLASS_ARGUMENT for every
popped parent op and returns AE_OK early without deleting any of the
enclosing parent subtrees.

For nested control methods invoked via acpi_ds_call_control_method(),
the walk state is initialized with root_op = NULL, so top-level ops in
the called method (such as AML_IF_OP) have op->common.parent == NULL
and are never attached to a root scope op. Skipping
acpi_ps_delete_parse_tree() during error unwind leaks the entire parse
subtree (both Acpi-ParseExt and Acpi-Parse objects, the latter merged
by SLUB into the 80-byte Acpi-State kmem_cache on 64-bit kernels) on
every failed GPE or method evaluation.

Look up the opcode info of op->common.aml_opcode directly in
acpi_ps_complete_this_op() and only defer deletion of
AML_CLASS_ARGUMENT ops when op->common.parent is non-NULL, without
mutating walk_state->opcode during error unwind (which acpi_ps_parse_loop()
still inspects when skipping failed module-level scopes). Remove the
now-redundant acpi_ps_delete_parse_tree(*op) inside the AML_REGION_OP /
AML_DATA_REGION_OP error block in acpi_ps_complete_op(), which previously
worked around this bug only for region ops and caused a double-free when
region creation failed on a non-argument child op. Also use
acpi_ut_delete_generic_state() instead of ACPI_FREE() when draining
walk_state->control_state in acpi_ps_parse_loop().

Fixes: 5088814a6e93 ("ACPICA: AML parser: attempt to continue loading
table after error")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221241
Signed-off-by: Iurii Trukhin <yuri@trukhin.com>
---
 drivers/acpi/acpica/psloop.c   | 5 +++--
 drivers/acpi/acpica/psobject.c | 1 -
 drivers/acpi/acpica/psparse.c  | 7 +++++--
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index 24a57f971c96..0b672a531907 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -464,8 +464,9 @@ acpi_status acpi_ps_parse_loop(struct
acpi_walk_state *walk_state)
 						walk_state->aml =
 						    parser_state->aml;
 					}
-					ACPI_FREE(acpi_ut_pop_generic_state
-						  (&walk_state->control_state));
+					acpi_ut_delete_generic_state
+					    (acpi_ut_pop_generic_state
+					     (&walk_state->control_state));
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
index 42ec8abef626..b5110d43ab7a 100644
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
@@ -124,9 +125,11 @@ acpi_ps_complete_this_op(struct acpi_walk_state
*walk_state,

 	/* Delete this op and the subtree below it if asked to */

+	op_info = acpi_ps_get_opcode_info(op->common.aml_opcode);
 	if (((walk_state->parse_flags & ACPI_PARSE_TREE_MASK) !=
-	     ACPI_PARSE_DELETE_TREE)
-	    || (walk_state->op_info->class == AML_CLASS_ARGUMENT)) {
+	     ACPI_PARSE_DELETE_TREE) ||
+	    ((op_info->class == AML_CLASS_ARGUMENT) &&
+	     op->common.parent)) {
 		return_ACPI_STATUS(AE_OK);
 	}

-- 
2.56.0
