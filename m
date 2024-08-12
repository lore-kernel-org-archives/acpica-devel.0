Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EB717552
	for <acpica-devel@lists.linux.dev>; Mon, 12 Aug 2024 01:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723424414; cv=none; b=in/xf5BMsHDh/Doxr/OsaFqrHW/LlyP8h3gp7Wnu4jqTrF1UT7DmnJpdfn316YxuDIY5+sHB5NYxBCzatMX13MYGcD275qtP2iNPv2oOWORxSGbLKgK8TSc4xr5D8YSQTC7tNWx0TT40sM7s9sWQZt9uWueUMlT8U82qcPJujsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723424414; c=relaxed/simple;
	bh=Vcq+n8JQdTk3vmf6hqmLO7PiXIRS5Btk4ojcnv75rJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZ+abVJbx7kg26O1vlXtEPf6chhsefnzt+ox3yYo5vT2ZY2Aw7QIL68cY9SbxYWwZTgDIeKwixwUtWK8dac70+J/m0zsxLD9yyKuUKdVnlbb4j40Qf6eymTIXsSUOaAssBsXQoJEz00lr1uXdpyGyDpM3V1ny1k5Tjxvrj63+zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=e5eI5d8R; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="e5eI5d8R"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7c3e0a3c444so627308a12.1
        for <acpica-devel@lists.linux.dev>; Sun, 11 Aug 2024 18:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723424413; x=1724029213; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJwTiJ9RwivJpxYHWXKjwIEWKuv7B7ooXczAECPccKA=;
        b=e5eI5d8R3w1zl9+0qGPb8+BuOTYke2WsAJnw2AhyA2P5+ICmfeS7kyXl/xJlE0yjL1
         EmGL3qqHGdoseyMLThM8KRoeWIHRisRHaqJBOtk5Av018FAuAexzbogAskW7AjVRWkRp
         24Apc6sT0W1A+3PRbVgDOM0XxYs5z2fBihRa7sJ+WZwKUzDWxi8BYqnbYTd9rszzjHUM
         vvNi4f5I4fKdIgTa423C2PJNSPNJTbAdbkkD0CUcmlLLq74pI70foXm9DR0OjwExUwjj
         8d8+yBNZm4Hend+m4cAZYlCCePSLyw3ZEt98Kz51VHE4A4gtAInstVexbVj5uB1KATL9
         jLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723424413; x=1724029213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJwTiJ9RwivJpxYHWXKjwIEWKuv7B7ooXczAECPccKA=;
        b=X/QIw1twIYlYfLwraNwy3lQTa43td5LQqSsyJsmtOiJIx3TQciUMpFxoNmAF9Iqsu6
         Tu05xy1I7Hi9prs/KMh6gsx7PHPDls/uy+PhS1raaxoHYIAB/QcgQhPRKUL6D8H4Zx/a
         vCw1e4Vaf0SowQdecElqa3fNnLDxnmtY/QHhr01wHbZBzD6hO5eQKMWw8OMbJrSAQ7bL
         3r5QuilsXu0cjHgvxsqvTrKj+y++ND8Nxi4I0USjPrAOx4VPi7xdE4KUGjLeROkVMJM6
         CoA45p4FYMO3RNFOM8h1594ZjnWQXySpgMWSqMKLOSv8CJTw4AS6OPb/5mr0BEx8+qSR
         gX1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWc6RMte8SAQVbRdYBqX5MmIqD+mG2q7l0RMY5c/STbCQKE1c+HfsgjSqF4FvYBR+E8bXN50VcwLK6fZnlaHRsiXBAoZpZI+9HpxFxi
X-Gm-Message-State: AOJu0YxQewBrHtLgOfiMr43+pkDVyg8I1okyjZE1CBEDQDtxJNgxqHpy
	77c8lwyVZMtqoT43a34FQNpOky0BfTb7cIdXoPKVUYVmE6mSkSxzgbwa7QSu9qE=
X-Google-Smtp-Source: AGHT+IEe5Qz6cd7b/1zBihHx5AlfGtYBeT8sDhSQ+DFn35gv+sWFK8VgaNh+IQbBrU4whiezDiQL7g==
X-Received: by 2002:a17:902:e5c2:b0:1fd:8f7b:1e88 with SMTP id d9443c01a7336-2009681bff6mr206131935ad.12.1723424412492;
        Sun, 11 Aug 2024 18:00:12 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe8cbdcsm3074062a12.61.2024.08.11.18.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 18:00:12 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH v8 05/17] ACPI: scan: Add RISC-V interrupt controllers to honor list
Date: Mon, 12 Aug 2024 06:29:17 +0530
Message-ID: <20240812005929.113499-6-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812005929.113499-1-sunilvl@ventanamicro.com>
References: <20240812005929.113499-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=cp1252
Content-Transfer-Encoding: 8bit

RISC-V PLIC and APLIC will have dependency from devices using GSI. So, add
these devices to the honor list.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
---
 drivers/acpi/scan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 374cae4aef78..39b3ccae9f79 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -861,6 +861,8 @@ static const char * const acpi_honor_dep_ids[] = {
 	"INTC1095", /* IVSC (ADL) driver must be loaded to allow i2c access to camera sensors */
 	"INTC100A", /* IVSC (RPL) driver must be loaded to allow i2c access to camera sensors */
 	"INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c access to camera sensors */
+	"RSCV0001", /* RISC-V PLIC */
+	"RSCV0002", /* RISC-V APLIC */
 	NULL
 };
 
-- 
2.43.0

