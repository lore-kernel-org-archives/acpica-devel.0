Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD011BE4F
	for <acpica-devel@lists.linux.dev>; Mon, 12 Aug 2024 00:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723424396; cv=none; b=U5hP4L1hXvV73R5E9yb8vE4ek6bDBU64YfTD3PxGhW8MAPgTX02UtRLFR+o9eMwQYctS+nW+r2kw89ROPzi4esjeGjqYjYzrDz/GQ8DQi56iaiA9ZALb3xPwroCjyfGmRIKy7TPj3W13c+njyKBEfe4yJoaFNPpX0HJmMc6adco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723424396; c=relaxed/simple;
	bh=nknKRePYpstHJXNT0D7LVZ4HEWBMbMCFh+6ycmonEIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dzw5dh2jLEL09OBNM5KQjmk07eRsp/+mxAv3OaOsx1j+iaXkq19ff2o5uD5yXQmQ2qK/8bIIR9nX2/OTckXxXezd7cOxOTimGrROqAaBkgR1+DYkFL07QwcQf/fzHjZaJf3M0i3CEmsmQEZhxlDYz/s9pX/x3+l5WkUXlpl9gfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=TKHQ3VER; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="TKHQ3VER"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3dab336717fso2632238b6e.0
        for <acpica-devel@lists.linux.dev>; Sun, 11 Aug 2024 17:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723424394; x=1724029194; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDiQZULOrmkIQ76w8p/0qXlEheAvD+F8k2bdCW40Dj8=;
        b=TKHQ3VERhR43/A1fBVCf2sEaZHtNJ67TpW2p8c2SzOZ3c9cmUrAto98kpaWHWXGl8p
         3F9la7IhJ4V5h2gbMtSb2VjF6d7Fghz89g4LfBi7EEgvUAKHrDb9Z9MIM836QxmOBVoe
         nbuWAzY83bR2EahCruLLRV7n0HLiVt6a6tyluYj72ZW0pYjbRQbikdlnhnZJVFfUXaef
         tbuV+ekgV9Pucm8lmcSUH6ww7w7Y55ZOjDeO849KgHIYIj0RqbPPdS/DKuk43UMCdNLP
         cSUoBqSHcfvJmRlFj6kMKTIJ1np0FNR0N8qgVgz9OLf2VL63+1VnxbY3OjGegW1GX/Ku
         pHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723424394; x=1724029194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDiQZULOrmkIQ76w8p/0qXlEheAvD+F8k2bdCW40Dj8=;
        b=jpYakkpURnjIn8/6qxkOJyH4wjG7v14ajbd78PLcNxjWvsxSXic7eJ4dOklOg3mF/9
         y2UwMnvArIxog05T+rFm9SotGND4i4JNHiDsheNkFk+SxdlD7diJxcehoHc4tlFoVY5a
         zAzgSWwIzelPtbnJnyDyu755BQZzGX+rAW/U+R/8vkkV5h/sySZa8FyktWtiMAYZK4mU
         7NFjW5vWX2q7uK94LFbA2g7HHHYT7oUdR7Q+T+vhENifRN+/rRj27rIKZFeVE28cpT0Q
         BEafEttI5N1oDLWnORqL5DNV+N1Xmp0Zk97kCuuw346dESAAJYekDczNCfLLtCxSfC91
         HMDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIITjd/iWuf7NexG8349xVsQX8pU7l8JGvAFiexGpZCj+MJRkYxunaV8YFcxJ5rxYFSQKyCBfv78kHs4ydlm6QaLvUqVdJH7nlhqmB
X-Gm-Message-State: AOJu0Yy9b9FEdglqPJDVaOIBOjLM1E0JWMYu4+C4zevLXr0WoEHjTCx3
	Xq64DvCbE5sdvFF/Kq6St27DqVC6P5myMKDjA7s88KvLvPtxwRprcDFB9OmZB3g=
X-Google-Smtp-Source: AGHT+IFZ+1tDJ3142HVFsLE4ya3SPYZxnEcsV+61Xh8a+xb4OPG7zVmGoKf++d88AMIRm4sWlhcOOQ==
X-Received: by 2002:a05:6808:2185:b0:3db:fe8:f744 with SMTP id 5614622812f47-3dc4168aac0mr9047447b6e.24.1723424393786;
        Sun, 11 Aug 2024 17:59:53 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe8cbdcsm3074062a12.61.2024.08.11.17.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 17:59:53 -0700 (PDT)
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
Subject: [PATCH v8 02/17] ACPI: scan: Add a weak arch_sort_irqchip_probe() to order the IRQCHIP probe
Date: Mon, 12 Aug 2024 06:29:14 +0530
Message-ID: <20240812005929.113499-3-sunilvl@ventanamicro.com>
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

Unlike OF framework, the irqchip probe using IRQCHIP_ACPI_DECLARE has no
order defined. Depending on the Makefile is not a good idea. So,
usually it is worked around by mandating only root interrupt controller
probed using IRQCHIP_ACPI_DECLARE and other interrupt controllers are
probed via cascade mechanism.

However, this is also not a clean solution because if there are multiple
root controllers (ex: RINTC in RISC-V which is per CPU) which need to be
probed first, then the cascade will happen for every root controller.
So, introduce an architecture specific weak function
arch_sort_irqchip_probe() to order the probing of the interrupt
controllers which can be implemented by different architectures as per
their interrupt controller hierarchy.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
---
 drivers/acpi/scan.c  | 3 +++
 include/linux/acpi.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 59771412686b..52a9dfc8e18c 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2755,6 +2755,8 @@ static int __init acpi_match_madt(union acpi_subtable_headers *header,
 	return 0;
 }
 
+void __weak arch_sort_irqchip_probe(struct acpi_probe_entry *ap_head, int nr) { }
+
 int __init __acpi_probe_device_table(struct acpi_probe_entry *ap_head, int nr)
 {
 	int count = 0;
@@ -2763,6 +2765,7 @@ int __init __acpi_probe_device_table(struct acpi_probe_entry *ap_head, int nr)
 		return 0;
 
 	mutex_lock(&acpi_probe_mutex);
+	arch_sort_irqchip_probe(ap_head, nr);
 	for (ape = ap_head; nr; ape++, nr--) {
 		if (ACPI_COMPARE_NAMESEG(ACPI_SIG_MADT, ape->id)) {
 			acpi_probe_count = 0;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 0687a442fec7..3fff86f95c2f 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1343,6 +1343,8 @@ struct acpi_probe_entry {
 	kernel_ulong_t driver_data;
 };
 
+void arch_sort_irqchip_probe(struct acpi_probe_entry *ap_head, int nr);
+
 #define ACPI_DECLARE_PROBE_ENTRY(table, name, table_id, subtable,	\
 				 valid, data, fn)			\
 	static const struct acpi_probe_entry __acpi_probe_##name	\
-- 
2.43.0

