Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E168335094
	for <acpica-devel@lists.linux.dev>; Wed, 29 Oct 2025 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737252; cv=none; b=uQEFjmHJq0k+HRj8lNkg/SIV9rExS9gRgPGhW6hrpyPP9Z2Sem8Ve8dAh/ua+l1T2M9PUoRj50sXWgFNaVOz+XYknHd4736kHRfC2ZW4Ua8APuUtRjVt8/WlO1V31o0+14/gUBtnyoGTwBRPvPdgOTVZjGH28CMDloKD3t0HQrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737252; c=relaxed/simple;
	bh=TSz747FjNEhM7uf1XzqCJ/IKzP85Xywzfa1M0ZRoX+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzhIlRrfDESpqlJZxVWHBQVwKjT4s4dgbrs6YLbidJSEHiGp3L3ir0iTsTfO/1nVltKC4whIj6cP8f0YT5FkhuQuGSpdG23y0uHeCH1uLLb/zyW+mZ5c6Pd1hrLsBglAgUluLITOGQ2OuAiNxsUzVgffa2zl1yuNAiajnJ8m5Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=JGswSGlZ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="JGswSGlZ"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-780fc3b181aso4531514b3a.2
        for <acpica-devel@lists.linux.dev>; Wed, 29 Oct 2025 04:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761737249; x=1762342049; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hiwSqBhR1Qws96GQdbU4nAKreYqDyRXg+IAoSlhXoM=;
        b=JGswSGlZyHn9G1AdJlO5lf9pA6bKDTaQ90Pgk+pkixwWp3fWOIXS8Q+oamd8j2JGXV
         S+7LDTB3TIDn/wBX1maBfYrW28KD/Th2B5BN3P54Tr8za+LR1NYJuCndLkoCj/cB/yHZ
         M/HGI2gwtQw5cu272E+yAxRTMgAtptddsq692zx8898MAdpVmBzCsXdt/KI3lmaiRanj
         8omzvUVneJuqlr/KX3FKKlIQ/Vepp7gJ5OoY1nK3Jwf9biyUouOSmYOq38pLiwSkBLV4
         JjObYfL2bnMzROWdQ7160ZaECqwH05Q1+XSOpCHWcQmJkWp1xc1SxrMGNNfjJ8Dzfi1C
         fNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737249; x=1762342049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hiwSqBhR1Qws96GQdbU4nAKreYqDyRXg+IAoSlhXoM=;
        b=PKyRZkYSr+MmWiBGJWBGN4I94D2kDt2XQLMXT0uiPBWr1emXFG2HS3Oba48Vvf8MAF
         76SgOiotcU3femuFVukyBCex5xt8J6b4JlXGQTIIS7k6JDXMr/Cx4QNBhu2svGJ51vtf
         7qCZQrRAByy9vY1HyNQwN7FDq6ktKs8uag7HKzzKzNHerHQIb9fNnPj6MFx7zkiI5eC2
         O3+aURd5q59C+GfrKJwWzALUCSF2VfcKpu3xJqfgkqZZapFMR0gBWgeBTNfeHbyUodt6
         6AMaq+bCRX+9yqhlUCllYiHWVigsZWeA0U+CCK6FgDmEfWO6t3ExqlSNxd7PGAyEjRdZ
         agcw==
X-Forwarded-Encrypted: i=1; AJvYcCWI+sJELrGVLLfw06EIaOXj09f+DjjOGHoOuTX9ek2EH3p6SAAYzGkv0R3NBF1rJmABEMyw1TGy6qWqrn4=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx6ov+mo9J1husI+xI1f0iWPuJP/ghxDeJCUUrx/sSUVnMbTgZP
	WTj+Ns1CxzX5wVZM6HGI/y79Ai5i9Clx+bH/i1s6fivzjXYrjNY98/a0+C4Uvbg2Yo/ZE7TkCPF
	dI/snbAbXRA==
X-Gm-Gg: ASbGncsDNZ6Q60E/KDvLbUYCv4bMs9981kkuVMQutg4hj12HkqKDkF0tWjHN12UIJEn
	P0LyfEHXsUZg/tnNMMhl3dZOBb3dMVGEDu5bmP0Xz5hMdRnalVv5S7gmZeeoQY6URUGnn2UA1fo
	mvYDLPd6wxvFMes/2D+i7HpefqRYHZyFNPNXWZdKOjEpMjjPJu3OeNqgbv3QR8ZrfBm8JIwUKy1
	4qk7FxWXlXqs0Q0K+n2JgZ/oymCwlLP+ksSHk2bQlw+XFwVkGAtT5brme3NHBzV8g1v7XqhECJc
	utuHLm1+LEhe7dTksAJ2FVV/Pt8AK87PckxEMtAPKOUtH0eU5UYIdk7XjNrPTIeo19LbdJYu7ZD
	O09Zwo2a4brcVEP7GsCTOJsOdP/H9zKGB9mBI6jP6AKYoxbgGV0MoHBvCSKmDpoUXHSd6zuJ1BL
	uLTeBt3/QJnfD674X7SHqGKkFxLjg+
X-Google-Smtp-Source: AGHT+IHs9/yah7+LL8dEcqJhQQLW+XK5ngSWHXrirtA5CcwyDvBqFPLqGRdj2uDT9wLcliFabWN9TQ==
X-Received: by 2002:a05:6a20:4328:b0:341:ea4:b977 with SMTP id adf61e73a8af0-3465381d8f4mr2997177637.44.1761737249215;
        Wed, 29 Oct 2025 04:27:29 -0700 (PDT)
Received: from ventana-desktop.localhost ([2405:201:d019:c0ce:f7f5:7789:48e5:c03f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm15316918a91.16.2025.10.29.04.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:27:28 -0700 (PDT)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-efi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	ardb@kernel.org,
	conor@kernel.org,
	cleger@rivosinc.com,
	robert.moore@intel.com,
	sunilvl@ventanamicro.com,
	apatel@ventanamicro.com,
	Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [RFC PATCH v2 05/10] riscv: conditionally compile GHES NMI spool function
Date: Wed, 29 Oct 2025 16:56:43 +0530
Message-ID: <20251029112649.3811657-6-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
References: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compile ghes_in_nmi_spool_from_list only when NMI and SEA
is enabled. Otherwise compilation fails with "defined but
not used" error.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 drivers/acpi/apei/ghes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 97ee19f2cae0..f2cbd7414faf 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1356,6 +1356,7 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
 	return rc;
 }
 
+#if defined(CONFIG_HAVE_ACPI_APEI_NMI) || defined(CONFIG_ACPI_APEI_SEA)
 static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
 				       enum fixed_addresses fixmap_idx)
 {
@@ -1374,6 +1375,7 @@ static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
 
 	return ret;
 }
+#endif
 
 #ifdef CONFIG_ACPI_APEI_SEA
 static LIST_HEAD(ghes_sea);
-- 
2.43.0

