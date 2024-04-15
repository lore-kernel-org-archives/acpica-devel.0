Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C168062B
	for <acpica-devel@lists.linux.dev>; Mon, 15 Apr 2024 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200519; cv=none; b=dBqQfYpgeO1PPXnIkesAO374zc5gJrPArtjgz9Fv3k5v2BWtU72O1a0I0W9PLFOmOGI1s+2rhRkPgkuJFL/xEbCTW7pR1qvVqKb7jejL4z5YK3QRWVfTykxfr164qtraDC9vmC9kJVY/EEwFTNwhXH9t7XUOiR5Eu9IWPxtvZHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200519; c=relaxed/simple;
	bh=nvDPc3L6oEQANMqW6TwMQT+97dhGLiqDQqjjsq7m6Sg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NRuIL/ovDfz+h8Oeack4m1fypS2nMrt+qosUn5NfRKkZAa8Aod0XX88UZYr5pai2Xb+96tJEz6J0n5DkARmBcMvzuDbMvs3qEnznslosoSjDDITmfrvWH+nzm07HzjfW+PrDZvIsVUHFQ8mXT/KV+K4uEl69fSAseOIFoN0tK1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=llAJbpvO; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="llAJbpvO"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ed054f282aso2406258b3a.0
        for <acpica-devel@lists.linux.dev>; Mon, 15 Apr 2024 10:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713200517; x=1713805317; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z52/1ZZYR1CvGL0V5chwJsk+UfCztWDiXCAoT+2GZNk=;
        b=llAJbpvO1FzL+9JDD7sxlZb7Cdg5WS6gk8OKQWW4jaDOKXW3PtDuYoe1k7Umh2GFUq
         aZlqx9kjfzcOZNog7e5Lzi2dDBSvUafuePab5oTn5ONaYZ315wHvEFNLuO/MWuYyB5oV
         3scRCUOvaoUMkqjxheP9Xx1THkVCmo+kDc1hqp7jVVm2G9ttaI56t/yOul9bkZ4x9G/V
         hA9X6Zo0B8MHwKc2YX3d3BpYQlpnsNJRCg1M36aG0XTqUKXBFxjkAxLkQTNspKyhqCBJ
         RW8dPb3cBKCczGExMex3oRX9IR5EAOTdFPd9CEzU3U6Rxf16B86pavNwzSpjPf40DqfA
         G//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200517; x=1713805317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z52/1ZZYR1CvGL0V5chwJsk+UfCztWDiXCAoT+2GZNk=;
        b=G/8gPUWeZ3/k74fYn/cYZlwj6FwH+srK4QekQS4bDvlC4gyzgMDUqtkM40Vk0Q/u6+
         4fKRS8TwP6z88467FHgHiksnAOGRUohcElcgQ3+3FSLZqjBF81JW/7NtIKsx+femv6Oq
         rV3aKdKFevEOmvaCw3LgLgoAcW7HouUNLBc1OkfA7SAm1jZojpKnq9XSNPoRzvFYaXRA
         9mTj9UDF3CZvsacaOUPWk+luD2pyIDYVIIajGsLTep2cXNVT3fVn5ialJAkjaWMnh4SH
         b8RnZfvgg1UGZN6e+wqFGkhBhQ1qCpJKuO/MO7BksQA72ohhao0F/N8ev7O+R7WDgwWJ
         WccQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5stz6QKeHNWuknUJGTzwa0+vg/NScAYO25Vaipf0rGkx73ZwvHRFaaeQf9ovjDVHDuPBbJIhW5UoUJGDHQVIcIQPfeYis8z4OkYK6
X-Gm-Message-State: AOJu0YyFu+MwL8gmkZ1RzQBQvHc3532ca5Mj4FSTRlPuYVyPsMqQqcCL
	s10iiEuMbTFYW4PEzTnjdyVqEGfpgg79P2WV0HSgZk58sa/sqmzjs6ZyB0J9wdI=
X-Google-Smtp-Source: AGHT+IF3pZ5kgHd0L+s0ETBbrzTu2eQzZocJwTnnUWv3+XrCVjsqR27b/As/nt3u7TcsRgOfwdwSGQ==
X-Received: by 2002:a05:6a00:986:b0:6ed:1c7:8c6b with SMTP id u6-20020a056a00098600b006ed01c78c6bmr10123074pfg.1.1713200516899;
        Mon, 15 Apr 2024 10:01:56 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm7433158pfm.25.2024.04.15.10.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:01:56 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
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
	Haibo1 Xu <haibo1.xu@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Marc Zyngier <maz@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v4 05/20] ACPI: RISC-V: Implement arch function to reorder irqchip probe entries
Date: Mon, 15 Apr 2024 22:30:58 +0530
Message-Id: <20240415170113.662318-6-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240415170113.662318-1-sunilvl@ventanamicro.com>
References: <20240415170113.662318-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACPI MADT entries for interrupt controllers don't have a way to describe
the hierarchy. However, the hierarchy is known to the architecture and
on RISC-V platforms, the MADT sub table types are ordered in the
incremental order from the root controller which is RINTC. So, add
architecture function for RISC-V to reorder the interrupt controller
probing as per the hierarchy as below.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/riscv/Makefile |  2 +-
 drivers/acpi/riscv/irq.c    | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/riscv/irq.c

diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
index 86b0925f612d..dceec808cfab 100644
--- a/drivers/acpi/riscv/Makefile
+++ b/drivers/acpi/riscv/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y					+= rhct.o
+obj-y					+= rhct.o irq.o
 obj-$(CONFIG_ACPI_PROCESSOR_IDLE)	+= cpuidle.o
 obj-$(CONFIG_ACPI_CPPC_LIB)		+= cppc.o
diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
new file mode 100644
index 000000000000..36e0525b3235
--- /dev/null
+++ b/drivers/acpi/riscv/irq.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023, Ventana Micro Systems Inc
+ *	Author: Sunil V L <sunilvl@ventanamicro.com>
+ *
+ */
+
+#include <linux/acpi.h>
+#include <linux/sort.h>
+
+static int irqchip_cmp_func(const void *in0, const void *in1)
+{
+	struct acpi_probe_entry *elem0 = (struct acpi_probe_entry *)in0;
+	struct acpi_probe_entry *elem1 = (struct acpi_probe_entry *)in1;
+
+	return (elem0->type > elem1->type) - (elem0->type < elem1->type);
+}
+
+/*
+ * RISC-V irqchips in MADT of ACPI spec are defined in the same order how
+ * they should be probed. Since IRQCHIP_ACPI_DECLARE doesn't define any
+ * order, this arch function will reorder the probe functions as per the
+ * required order for the architecture.
+ */
+void arch_sort_irqchip_probe(struct acpi_probe_entry *ap_head, int nr)
+{
+	struct acpi_probe_entry *ape = ap_head;
+
+	if (nr == 1 || !ACPI_COMPARE_NAMESEG(ACPI_SIG_MADT, ape->id))
+		return;
+	sort(ape, nr, sizeof(*ape), irqchip_cmp_func, NULL);
+}
-- 
2.40.1

