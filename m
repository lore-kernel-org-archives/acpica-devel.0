Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D070346AE3
	for <acpica-devel@lists.linux.dev>; Sun, 22 Mar 2026 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774193780; cv=none; b=Im3ny6oDa99S9GZZcLayROoqxEvjHrVVoxuncH4Pz7kjXHagcxjoSQxOZ+WAqaOz5WpaiXLhKYq453fy982rGWh0gYle4YfL7dJ4lKBBdySTyPpqY3gTbTDpAmHGLFOZl8gB0/5N7wyZLFavoq7hog8g4dqcH2d90ff0c5vOZgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774193780; c=relaxed/simple;
	bh=yOhi6aKiUR4eoyYlcX4c+fiyhV6dey/Bi2f/oYdMhDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cW5kMJimz1DsHdCCxb+ogunkMBBVrskOVtnnU0ygsP+6h9nq5O0ZFyzDgckBeGI3cftpDikdY5EhyrLmXSBphYh0HBh3wY+CYQ63/z0qMPMJMwUbpBWNjdoTU4Nn+8hIx3dkbWls7lzhJzU7HdQgpX4Y1bc+0hbT4bBDca/KuK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SiTgRFzk; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiTgRFzk"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35ba749f441so3057666a91.1
        for <acpica-devel@lists.linux.dev>; Sun, 22 Mar 2026 08:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774193779; x=1774798579; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5WiiyveVbIeJMUarYCtN7n9x1v7YYVzdYgWfcDHMQmg=;
        b=SiTgRFzklxK0rFHE9g+tm+D989v/hGpIhCrbyMnSOhcUnA/TunSozTQALwUpyoecT4
         hktMRYp8q8xrqnslrOccuzknn4ystkC6tFn+qTSMms4Ym3+u1MbhwBOBm96F6PKStwfs
         fItwpEeXh3PioViIJw7EOd1Qn7ZN+KPMNkRwchYsT9D87UmXgRBrH+i2IN69O/0qfuVy
         rNfdMblFgbkyWNnBVTParj1vQezQkPYrDUde+kmd9sRYHLnNicwEC6RzJE8dKmvDt/Bv
         Z0583XPDMEftCPAevQpDmmtdvx7b1RaiVVVRA6cfzbKtC5k7pUGLKNyyynkeKaDET5XV
         QP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774193779; x=1774798579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WiiyveVbIeJMUarYCtN7n9x1v7YYVzdYgWfcDHMQmg=;
        b=D4IHeoOp1Dhgbctr+kV0L1nDmbwlD76LTuHtLR3BwEYAN7GAV7Myh9GL4SomnhFtRQ
         wm0/sq9rrEG/+ppsn9q06C9YoGE59761yaNnMNBJkLvHAAKEGJlhR16U8W19z1EMHyIE
         spqxuZKwYvRc4D0SqrnIAd0N6tItr3CkANbg+4S7Y/iObGf3iVkhb+aVEa/8ncaYJqDV
         +h8WERVkYdgAWw6rPuRvBnvFoSl6TVR+4rTMn52a4K3uwp2Yx8YajQr1xQ54q8tFjFId
         sd/AGXNQo931N6h0flDZkCg4ZMfsIOWvRMEFLcH1WeNXtwejpOO57z07ABkDWX/Nz8Wq
         t05A==
X-Forwarded-Encrypted: i=1; AJvYcCXqrgOELfHbQDfttUIIsKqLU/lMXHiac9/B7fgAfYhaZGdrOMo7YYgmJbASiYnbuaR83+Ycsg6xFKbbAm4=@lists.linux.dev
X-Gm-Message-State: AOJu0YwqpVfMHJOxdUJ3oY5jIbTJKKs6q1SupAMe8XdJ8M/rFUY/hFkj
	OPQded9yyOcgvp040SdOkb8tTS0lu5PizbbIVLeSgl24lWXEISJs0Sg1
X-Gm-Gg: ATEYQzzyup+otS9x1hGWBKCv/WSDKERau+OkR/VLhJxXWJwwUdybnY7SG2yJa6YqXjO
	FVCJ+ZjeK9UQEU1EaEMbVUPZKnLEqQWEysOxvidPcplDTnPg2EM3wvUAyWwDqZgez4sqrE6+qHX
	DIjjRq9NlgD13qalQCctmHtjee2xn1ft2sBWt8a9gbu9d7GtKXVeEhoVmDCjYEOFtbKD5qWjw1E
	QSGAsczt2oSp3cbvFKSoO84FJ7qWjXRs+onfTWw24tpyhme1fVmpvlIlGCjKe0EYwCKJTGhSlsO
	ZfZ0aX216JuKsgt4076fgaDNpoKv1poQYDKxzIDtIeLlG0/jGwJHd9+Zb4YJOSd/5oL4+qNztYS
	GTqQzijV8Knc0cLUQuN3KgBOFcukYedvhv7DSWsv86lRCUMnpYqOyb/bYU+303jwbGT0EyZ9n6r
	RAhecG4MNJOwoCGUQ+Jg1SVvdjVOa9tstOhX6YOC2U0haz932v1uva04uhBpA6v56zCgW+7kvNc
	YvEjKN8edo=
X-Received: by 2002:a17:90b:380c:b0:35b:b537:b03b with SMTP id 98e67ed59e1d1-35bd2bd57c7mr7961148a91.2.1774193778922;
        Sun, 22 Mar 2026 08:36:18 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd2665e2bsm3166405a91.2.2026.03.22.08.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 08:36:18 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH] ACPICA: fix NULL pointer dereference in acpi_ns_custom_package()
Date: Sun, 22 Mar 2026 23:35:31 +0800
Message-ID: <20260322153529.3325784-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acpi_ns_custom_package() unconditionally dereferences the first element
of the package to read the _BIX version number, without checking for
NULL:

  if ((*elements)->common.type != ACPI_TYPE_INTEGER)

When firmware returns a _BIX package whose first element is an
unresolvable reference, ACPICA evaluates that entry to NULL.
acpi_ns_remove_null_elements() does not strip NULL entries for
ACPI_PTYPE_CUSTOM packages (fixed-position format would break if
elements were shifted), so acpi_ns_custom_package() sees the NULL
and panics.

 general protection fault, probably for non-canonical address
 0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI
 KASAN: null-ptr-deref in range
 [0x0000000000000008-0x000000000000000f]
 RIP: acpi_ns_check_package
 (drivers/acpi/acpica/nsprepkg.c:634
  drivers/acpi/acpica/nsprepkg.c:110)
 Call Trace:
  <TASK>
  acpi_ns_check_return_value (nspredef.c:136)
  acpi_ns_evaluate (nseval.c:266)
  acpi_evaluate_object (nsxfeval.c:360)
  acpi_battery_get_info (battery.c:537)
  acpi_battery_update (battery.c:1007)
  acpi_battery_add (battery.c:1237)
  acpi_device_probe (bus.c:1076)
  really_probe (dd.c:659)
  </TASK>

Add a NULL check for the first element (version field) before
dereferencing it. The battery probe then fails gracefully with
AE_AML_OPERAND_TYPE instead of crashing the kernel.

Required CONFIG: CONFIG_ACPI_BATTERY=y

Fixes: 7952d40240855932 ("ACPICA: ACPI 6.0: Update _BIX support for new package element")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/acpi/acpica/nsprepkg.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/acpica/nsprepkg.c b/drivers/acpi/acpica/nsprepkg.c
index ca137ce5674f..c32770570120 100644
--- a/drivers/acpi/acpica/nsprepkg.c
+++ b/drivers/acpi/acpica/nsprepkg.c
@@ -631,6 +631,13 @@ acpi_ns_custom_package(struct acpi_evaluate_info *info,
 
 	/* Get version number, must be Integer */
 
+	if (!(*elements)) {
+		ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
+				      info->node_flags,
+				      "Return Package has a NULL version element"));
+		return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
+	}
+
 	if ((*elements)->common.type != ACPI_TYPE_INTEGER) {
 		ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
 				      info->node_flags,
-- 
2.43.0

