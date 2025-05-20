Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078FA25F965;
	Tue, 20 May 2025 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747759730; cv=none; b=QqXavZt0czadLhAmNKwkgEn7n9MT2UZ2if7L6UBrF6+zztBhk2xCRZ1rc1hVMBZyfe8A6ZLnQgAKYq1hCKAz8Vs4Ic5TJprp3DCua65Thl4jbxAyXQ+mdKnWh2iw3MBiXiuEVGTSQ2yfF8z5XhS7kvIE/pfMCNzEzeU6fMmZCck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747759730; c=relaxed/simple;
	bh=DXtNUfWvj2BEdRTkqaOsp53rwbRczpAnjfVf3cndUS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lmJMl/cdVt9WB1+zD1Q4pzDeKGsTW6jx3mB5krN/TJXQ3YWgfZCz0PKEWF6GELbm6j7wYEmLJdYyZX/KqlZOhsJynwcO9gwhSgxp6BnC9AR8xjMqdFUEY9Rz1d4F03/JV49Ypx7OBDMw3Kh9o6KSSSuFGzaVKrz1HHNxhYnCSJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpM1s+Xt; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpM1s+Xt"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a365a6804eso2118630f8f.3;
        Tue, 20 May 2025 09:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747759727; x=1748364527; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RX/xTTJv673giKzShX4ULe6HYBzR7J67EwT0wiQt9tc=;
        b=BpM1s+XtZdVDJb6glJl/g0TgriJDtFI3vgnuAlAo+hv7/3hOOQnVSdWUKAIVJFTZED
         ArMBuH3nKTrWnp03Lzc+g/3C+y3mpGYgzSbAV7NGQSvt/Nv7SOyUksRDIw4c/orikeRN
         HgbTqiXv9BHWRwDZcRFm8NdANK0Q1OJ1SU/jTxKgu9MTRvY3l71qdQJPQLYseY0/Lrnj
         WhBGFmYhXSRDTisIc59YW4Cl0TNDEDJ1zhxhloP/6XEEmcWbu5w7dvKvLKeRRypvpvcT
         u9ndYevWoALgqKK2K6T6ZOQKYkM2DS4d6mV1MC/7fyqz7unjR6QvAnQ/wsYHUAxF9Jby
         NfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747759727; x=1748364527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RX/xTTJv673giKzShX4ULe6HYBzR7J67EwT0wiQt9tc=;
        b=COdPgvocIzDtUdd/iV6CHyLStG4jIqpMkq9OT3WzVLGKnvfrsyZS6nVC8lwzm3E3uZ
         bDk/xX/wH6qRo+Drxm2SfG5oabhEuHZAt29ozWAaOeVJFrPDaoblzgIGH0E+zIwcfGAq
         b/xVrTBW7fA2lZi3AI0UFyFtrRwuBrD8De75K1xy5WsOfSdQfqDCbsQmzOWzlDUGmgGT
         fTaQlmnHqXr97B7pMzff7Jj9FpjJhdfycy3Jpzgm/voBSmWv1jP2g1FISH2NCxKclGxB
         TtZclfoXzbfpYu6Vb0WYbPIhfVwdjqGUE9zPAD3hjFkU0ArhONPj7su3LfCIGXITLs1T
         s/Og==
X-Forwarded-Encrypted: i=1; AJvYcCWRfg1LWRs/GzT33hBtJNvL86fXl3mjPzUejk+YqJ02PQbo6iLkAwt7GdjeBGmCFdtkEgRIyYk=@lists.linux.dev
X-Gm-Message-State: AOJu0YyoV+Ed6hKh1xJu7DzIgZSWK1BkHHNxFmNBYeudJf1g8XfUXECm
	+i+41JKNTgqVjvtpzI59D21zvcVDITNBznxB9+Ps2/qgy30mL/hkzxiR
X-Gm-Gg: ASbGncsXV+c3FMvT6I70ABarLaK+W/3l5t20B+Oo6ECdw0yGugjSD/WvzOi4kyg7lSk
	PRNMfrmaJEHguph+UYoAuSuNEojnJemL+dLObfw+tYH68Pp/f3AOnF2owY1O9pbifC0Tfo0e++X
	qfPfQefI72htA4aL+hJitOyVrGaixpBTaItylPeJjWPCg6+tgJ0AjHVv61sShOOW2HAUqjlauGm
	5l4k47ytpvdLgxN6u4pbZeAG1TOCs1A/FLefJdbBtd53erNZ7nwXsZOsCVhqCgBjDrf7aE/d/dB
	lNdgkTLHYu25ZrU4hU063JPR7wt3NS4xxMPh3pn0Lo0/1J+BBnTWQyuI0+L1fHU=
X-Google-Smtp-Source: AGHT+IHDT70S1ARAbUv6HAp7abwv12dONID6pWotK54QvtsjTevUA/NG27tOXymDxylQzVHpQdworQ==
X-Received: by 2002:a05:6000:184d:b0:3a0:b308:8427 with SMTP id ffacd0b85a97d-3a35c84bda9mr14099902f8f.37.1747759727073;
        Tue, 20 May 2025 09:48:47 -0700 (PDT)
Received: from localhost.localdomain ([78.172.0.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a364d2636bsm14306852f8f.99.2025.05.20.09.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 09:48:46 -0700 (PDT)
From: Baris Can Goral <goralbaris@gmail.com>
To: goralbaris@gmail.com
Cc: acpica-devel@lists.linux.dev,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	lkp@intel.com,
	oe-lkp@lists.linux.dev,
	oliver.sang@intel.com,
	rafael.j.wysocki@intel.com,
	robert.moore@intel.com,
	skhan@linuxfoundation.org
Subject: [PATCH v2] acpi: convert strncpy into strscpy
Date: Tue, 20 May 2025 19:48:13 +0300
Message-Id: <20250520164812.7689-1-goralbaris@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250520163540.6893-1-goralbaris@gmail.com>
References: <20250520163540.6893-1-goralbaris@gmail.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The strncpy() function is actively dangerous to use since it may not
NULL-terminate the destination string, resulting in potential memory
content exposures, unbounded reads, or crashes.
Link: https://github.com/KSPP/linux/issues/90

Signed-off-by: Baris Can Goral <goralbaris@gmail.com>
---
 v2: naming issue solved
 
 drivers/acpi/acpica/tbfind.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
index 1c1b2e284bd9..5536d1755188 100644
--- a/drivers/acpi/acpica/tbfind.c
+++ b/drivers/acpi/acpica/tbfind.c
@@ -57,8 +57,8 @@ acpi_tb_find_table(char *signature,
 
 	memset(&header, 0, sizeof(struct acpi_table_header));
 	ACPI_COPY_NAMESEG(header.signature, signature);
-	strncpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
-	strncpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
+	strscpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
+	strscpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
 
 	/* Search for the table */
 
-- 
2.34.1

