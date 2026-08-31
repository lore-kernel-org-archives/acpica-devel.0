Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9BD75809
	for <acpica-devel@lists.linux.dev>; Mon, 31 Aug 2026 04:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788150474; cv=pass; b=iXJO2UhznJkTBTBg2xd2oMK3Gr4Yp0wA9/s8NsuLySyf3LpdRs56qboF1sBpMlRskG9+pPYcTHoLoeTMzaoMbFg8d0UuUr7vm1BAoXufZKDEh59+VGMw37NkC4WXD/0kQd/m9sNzATj6ur6X87EbPiAsm9+AR4I8lT97KperpDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788150474; c=relaxed/simple;
	bh=FAxZP1r6MFSpLsu8CHrIlBjZa/TvAcgjBjWfXeKm0U4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=eqpIYkuNqd2nR2CzF34PAbcLXWpEZINozADcvVI+DYHYo0O5lVXKSXBG0LPsHdLug4am2vVd0IHKdSXkylmaJp1aCV1ukV4SAtYo8/U3w7BBviVETMt4STiLftwkAqeROQy4h81GXwX2/aPL0GOORIT7aUu1Z+ydTbo5+zhbKzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=szPkfb+h; arc=pass smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="szPkfb+h"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4a46a53abc9so2736518b6e.3
        for <acpica-devel@lists.linux.dev>; Sun, 30 Aug 2026 21:27:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788150472; cv=none;
        d=google.com; s=arc-20260327;
        b=GlwNc0q4zgq7rQW4P620Au9jIAOdtEkMvBelkuEgTHGw9TgLm/vGQzsgBmhgMbifC8
         d2TpTYkQp7XlHrdDVc4axi7KGZ8NL4Chsb2X6l+gkkSqXCi0u7FJP66iE4LUEVhpcfOj
         Z6WHSJPn9yemyNHHfkNJ3MuWncrwhXGZlRg5i3Nvqb5Bmlte7/BvtWEP59QR5/2t1qf9
         txtFu+BkN7VLXOQCTsRHG22+5dQ8GtI7q/q4ZMf6Coss3VAK64Vj4XbWYEk2RyA4WMOA
         LwmMBOf+R/KmZ+xltv1+KZUqb7NkKB21VStKh8QODh7k8AQpt4efWrudLTM2tzcthdnx
         bkmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=w6cfHFWajG2mUYJ/SeqqbFWYHvEkw7VlhhOfJ39ntMs=;
        fh=RZ5zH9/kJCuxNnlBK1naQoLjTL/QQ5bmY8KxIzqZg2g=;
        b=QI2bJlG+HIAx+9LZcDtctz+0aXV0hUBf5wUdOEHFP0U2P4ysLY2mZH7qkzN0qXq+tc
         gotgWRdJoriCNlpJ76nTG0kZ05YylbNeYzClyK249sca1zmgsDaCLBigflOVjRDf1Pig
         YZiePoeWysJDA2uhA+ZvQpQCpsfjAb6KsUAk/uiPgHR4Vs2DRpG47dP8a/eyVPGfYd63
         t47j25TpF1nEs6Uvp7Rt2EF9n6NKs5U9lFRF6QrIboL0jRE/G+r/rBqrlFBUoohthPHm
         GQYAPkPE+aZYNJ9Q+MOE0CxSLgfE9UBVd1V+DkvdP9ltstLEVFdE3AuybUlp4XHjrSdy
         568w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788150472; x=1788755272; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w6cfHFWajG2mUYJ/SeqqbFWYHvEkw7VlhhOfJ39ntMs=;
        b=szPkfb+hE835GZLLESOet045Uw6Cv1pdvDUrLkrUBKObpR6PwovXGnkNhX0uunTkTr
         I3qyaoQXGvLbwM/yMoO7EGu+UlxbD3DrzLG2FA/m+2wjnxtw9bV27guNallX/az29zwY
         of9jQdlGHJlqRi2Iry8wU4OEnDqoLXemnkfi7JkaakdqvyMkm37+jf4nkAzTupDZtw9/
         1mkUFq1Gy6aIrulSNKotn4TXE/mDSBJnB305Zwo854eGZ+6u4jMDytYAZWoROw6sgLJh
         /DQ1JZ6I0dgWzeq6R6dBjJQ+LzJFFbkFoit3Y8ZLH6xakMORFeNibNNwVL341XKjCBfG
         n2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788150472; x=1788755272;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=w6cfHFWajG2mUYJ/SeqqbFWYHvEkw7VlhhOfJ39ntMs=;
        b=jOEzZKr4wWjer3nggMcP50Vr13FqL8fREsmi6v4k6CHsalLwxeEm9aygA7Bi2dzUI1
         58bVqOVsTS9XWnOpihjx304BAERRgD7Ob8on0kbYuf/lcaC8gM9scVYpw/6awBbFY1bR
         +tNDQd/Qcayi2AuuGE2VSrRaY+XkZtSMnNRMpyBoq+f6/kfdzeQHt9K5GiZ8wjTNn6N4
         Fc/9pACHZ6J2EnTq0w49D9B1bia+JGejbIaZp2V/+xZs+rJzfYbedgDkwdG1/pcD3X6V
         s5/BDylu87A0f6Y6byzLSn6Fmg3uaK2ZT1IoIlS7AZd68kkAaDD6i3/CopxK1c6sLD0V
         ArDA==
X-Gm-Message-State: AFuF++mKDTq2xMZ5GHHEvEtMmqMlcTEGZeHt2gzT6kIZ6OLe73BXSwXG
	3uPemnKEiDx44DZ+WfV7kcMmQroqvBypUMZIlS8bnkaxPXw5pOO1e7azzug8+t4k9Jq02RsZJPA
	ucs4pC05yjGv9XTx6meXwKaMRhEnqL98=
X-Gm-Gg: AR+sD11zh7rsdwmNAyvGGMMMu05azwHeM2E9QUya6lUgGIIDxqCCvKQDwBVKDxkYbLb
	4TcMm39xEFJqqUOABscJZEJhPapCtx7YTSVrjCFWXALp9RGyoZCp4zr52E07ra8pTnMNHokmlLp
	d41MiBVP/ycyQ7tEPfAJ5XYc20LcnEMb2V0n+nuoZLQ+VVMpJZxSiMKtV3yhvsLoQ2WbVFsr/dv
	/l02DB18LnedcE47VzE9XMLx613lHnU6E39ZiPW+sq1IjDajRKR1xj+T+myVyrS+A5UWi0zQFQj
	6YQQCD4UChBJV3IlA1Nrb9RnS+LH5UqAJ8tk9H8UUmCwP/OhdOIjJRqDwJmx1koeRg8sslpvgxB
	XXxjPBV8rLgzi
X-Received: by 2002:a05:6808:538f:b0:4aa:cad:cb4c with SMTP id
 5614622812f47-4b398037d1emr29237479b6e.1.1788150471810; Sun, 30 Aug 2026
 21:27:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Vlatko Kosturjak <vlatko.kosturjak@gmail.com>
Date: Mon, 31 Aug 2026 06:27:39 +0200
X-Gm-Features: AcwNN1WWlRQQDc_CVWJFU7tdu_Z7mCSVr31qkPoeVGpqgtO5des00QYjtXXtn44
Message-ID: <CAPAw8HGxmd2V5GgjL191f3pwOnbuGp4cfDaxCWiR57EquLOecw@mail.gmail.com>
Subject: [PATCH] ACPICA: Parser: do not set the AML pointer to a NULL AmlLastWhile
To: linux-acpi@vger.kernel.org
Cc: acpica-devel@lists.linux.dev, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Saket Dumbre <saket.dumbre@intel.com>
Content-Type: text/plain; charset="UTF-8"

AcpiPsNextParseState() can set ParserState->Aml to NULL, after which the parse
loop dereferences it in AcpiPsPeekOpcode(). A malformed ACPI table supplied by
firmware therefore panics the kernel in PID 1 during acpi_init(), before
userspace exists - the machine does not boot.

This is the largest of a set of related findings: it accounts for 110 of 189
malformed SSDTs that leave a stock x86_64_defconfig kernel unbootable
(tested on pristine Linux 7.2.2 - tag: v7.2.2). The smallest trigger
is a 46-byte table containing no While, Break or Continue at all.

WalkState->AmlLastWhile is only ever assigned in AcpiDsExecEndOp() while
handling a While loop, so outside a loop it is still NULL from the zeroed walk
state. AcpiPsNextParseState() assigns it to ParserState->Aml for AE_CTRL_BREAK,
AE_CTRL_CONTINUE and AE_CTRL_PENDING.

The first two are guarded at their source; AE_CTRL_PENDING is not, and it is not
a loop-only status. AcpiExNameSegment() returns it for any name segment that
starts with a digit or a non-alpha character - entirely controlled by the AML
being parsed, with no loop involved. AcpiPsPeekOpcode()'s bounds check does not
help, because NULL < AmlEnd passes.

In Linux this is reached from AcpiTbLoadNamespace() during acpi_init(), so a
table supplied by firmware faults in PID 1 inside do_one_initcall() and
panics the kernel before userspace exists:

  BUG: kernel NULL pointer dereference at 0000000000000000
  RIP: 0010:acpi_ps_peek_opcode+0x16/0x40
   acpi_ps_get_next_arg / acpi_ps_parse_loop / acpi_ps_parse_aml
   acpi_ns_load_table / acpi_tb_load_namespace / acpi_init
  Kernel panic - not syncing: Attempted to kill init!

Refuse to take the branch when AmlLastWhile is NULL and fail the parse with
AE_AML_NO_WHILE, whose existing text is "Break or Continue without a While".
Also NULL-check WalkState->ControlState on the two paths that dereference it;
the AE_CTRL_FALSE comment already says "a predicate (if any)".

One detail worth keeping if you rework the patch: it also sets
ParserState->Aml = ParserState->AmlEnd on the error paths. That is required, not
cosmetic. During a table load AcpiPsParseLoop() deliberately converts AML
exceptions back to AE_OK ("keep trying to load the table"), so an error return
that does not advance the AML pointer re-parses the same position forever. An
earlier version of this patch omitted it and turned one table's panic into a
hang.

Why this matters beyond "bad firmware breaks your machine": under confidential
computing the host is untrusted by design and supplies the guest's ACPI tables.
Documentation/security/snp-tdx-threat-model.rst lists "Malformed runtime input"
from a misbehaving host in its guest threat matrix. That is the model in which
these are security bugs rather than robustness bugs.

Reproducer, evidence and step-by-step instructions can be found at the
issue reported here:
https://github.com/open-acpica/acpica/issues/1226

Sending this to the public list rather than security@kernel.org: the attacker
must already control the platform firmware, no control over the faulting
pointer was demonstrated, and the fix is small with nothing to coordinate.
Say so explicitly if you would rather it had gone elsewhere.

Signed-off-by: Vlatko Kosturjak <vlatko.kosturjak@gmail.com>
---
diff --git a/source/components/parser/psparse.c
b/source/components/parser/psparse.c
index 1aacc0c..7fb28dc 100644
--- a/source/components/parser/psparse.c
+++ b/source/components/parser/psparse.c
@@ -338,6 +338,15 @@ AcpiPsNextParseState (

     case AE_CTRL_BREAK:

+        if (!WalkState->AmlLastWhile || !WalkState->ControlState)
+        {
+            ACPI_ERROR ((AE_INFO,
+                "Break without a valid enclosing While"));
+            ParserState->Aml = ParserState->AmlEnd;
+            Status = AE_AML_NO_WHILE;
+            break;
+        }
+
         ParserState->Aml = WalkState->AmlLastWhile;
         WalkState->ControlState->Common.Value = FALSE;
         Status = AE_CTRL_BREAK;
@@ -345,12 +354,30 @@ AcpiPsNextParseState (

     case AE_CTRL_CONTINUE:

+        if (!WalkState->AmlLastWhile)
+        {
+            ACPI_ERROR ((AE_INFO,
+                "Continue without a valid enclosing While"));
+            ParserState->Aml = ParserState->AmlEnd;
+            Status = AE_AML_NO_WHILE;
+            break;
+        }
+
         ParserState->Aml = WalkState->AmlLastWhile;
         Status = AE_CTRL_CONTINUE;
         break;

     case AE_CTRL_PENDING:

+        if (!WalkState->AmlLastWhile)
+        {
+            ACPI_ERROR ((AE_INFO,
+                "Pending control state without a valid enclosing While"));
+            ParserState->Aml = ParserState->AmlEnd;
+            Status = AE_AML_NO_WHILE;
+            break;
+        }
+
         ParserState->Aml = WalkState->AmlLastWhile;
         break;

@@ -391,7 +418,10 @@ AcpiPsNextParseState (

         /* In the case of a BREAK, just force a predicate (if any) to FALSE */

-        WalkState->ControlState->Common.Value = FALSE;
+        if (WalkState->ControlState)
+        {
+            WalkState->ControlState->Common.Value = FALSE;
+        }
         Status = AE_CTRL_END;
         break;
