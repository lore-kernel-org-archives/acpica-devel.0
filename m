Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CD583CA2
	for <acpica-devel@lists.linux.dev>; Mon, 15 Apr 2024 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200526; cv=none; b=dHT6ta3E0Kw2O4F1Emc46NI1SNP8j9mZxqwsc1ef2bZnMN7IP7gLA3FyF100BO9H7CWtB9X3agB/fk96/k7StOF/we2YCvmQhGno5HIrMM06a1prMuQEwJ/Mov90h7BekGpYTG2OLnfUoLEkPJFcXij8kejvDRRI4ER9JN4Yktk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200526; c=relaxed/simple;
	bh=6c1KPNfbsnJq9DUvTTQzdZQPzyBy24eoF7S1WvCF6y8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C7R0GRZE9QX8jHk1Ifyg1r2bnew7Y77oBXG5cScck5jcRqDjoEPBSGN1A1ClUVnTcuWUoQ/QkSLAXWiIgqmkE0BIwOKeEYUhaByat+F2shOjZAwqjCb1NdHR1VC8z0qKmH8N4KqiTN1GRqzbijuGsJ+fJF4sl+zYZssbb49O9Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Oahg8qD9; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Oahg8qD9"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6eff2be3b33so1194283b3a.2
        for <acpica-devel@lists.linux.dev>; Mon, 15 Apr 2024 10:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713200523; x=1713805323; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=teU93TtwDbXbcibIb7AXZv+o/BW+BbmtaOdYSVoKyTI=;
        b=Oahg8qD9d+yLZovtQFaTYhAGuN8JZxNaZJRYU4kdiodvy3uzCGem8zua9LaRGgbwab
         qNazMtz7eJ5Ivtw0Gbh+ffFKXo0uzjhRfb6G7l4rWOFnYZn/LiAI+PAmslxuiQzJgCgQ
         XqgZc80bDSRJpZgR1/T3ZazQq9obDek2ytln6Zs1A4sTXJiScBZuFmwRwx0B4fHCIP88
         cuuxjfvI5PjTtO//T+sNIEgtyyRTNtn00RpFQsDFkjHQXPIZjEmXG99zri9+8VQGgEkE
         INjmnkZq1eXVLovPtP3lBCwjBg2QKakhFg2lNXx3l0v2YBNFawF1j02iNpGyztBUnZYi
         D7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200523; x=1713805323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=teU93TtwDbXbcibIb7AXZv+o/BW+BbmtaOdYSVoKyTI=;
        b=tkdz+kyqTIZKBgHqfssF2VHZgNhdCgoINoow6KCsAE+aaHRRONLtmSIo9o38FcQDmj
         Jw6lqbrh4n/B/Il2VU7fR8dY6o7mUfA9u0GLSLtH5TI4uXU/UPZXhtbx3i+Gm7oovwpP
         OCfq6wmw3h06dQodKj6nO5ZL10QBsBoGeOau+QiWF+Kzz6dj/v71wsDmXBADOz/NiOf4
         /o1tfiVuEvha/LXfwGiGd5CuVGudr0dh3ZOJ8Cof7uem49tx816unYfst8bAq+sFLS68
         1+DGM1zAuU0fqgb6vJ+Dnbz1z2O6IaPFZfsEoMV++QilWr1+DubWPrQd6ojIa4m+1q1y
         0Vog==
X-Forwarded-Encrypted: i=1; AJvYcCUnxGaAWCX3ZfCKmvpkpFb8wX/2n7r023CQVnPH2aBq+ECJtk2Ck7Xc5QikfdBtgl2v9OhksUhc7xgppWwUkzuqIehsUo6ChflfgtrB
X-Gm-Message-State: AOJu0YxvVZ0fQHs8a2pDuIxnEIOsRKmEhDuLMP8cSF+hMDDnimf8yLPp
	tFJMdFWm4TJGHZuCnanBInLL1vOp7r9Ncj49MAPDECSje01pTKW+JPKifQZ5ZlA=
X-Google-Smtp-Source: AGHT+IHIdjpEtA26gjeeDnuLKQpBt+rlByzg0zdHDQS2GYQedk9D3DuzAQNVqthcjh2+Xm9tW86rPQ==
X-Received: by 2002:a05:6a00:3985:b0:6ea:e31e:dc75 with SMTP id fi5-20020a056a00398500b006eae31edc75mr12713019pfb.5.1713200523442;
        Mon, 15 Apr 2024 10:02:03 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm7433158pfm.25.2024.04.15.10.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:02:03 -0700 (PDT)
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
Subject: [RFC PATCH v4 06/20] ACPI: bus: Add acpi_riscv_init function
Date: Mon, 15 Apr 2024 22:30:59 +0530
Message-Id: <20240415170113.662318-7-sunilvl@ventanamicro.com>
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

Add a new function for RISC-V to do any architecture specific
initialization. This function will be used to create platform devices
like APLIC, PLIC, RISC-V IOMMU etc. This is similar to acpi_arm_init().

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/bus.c          |  1 +
 drivers/acpi/riscv/Makefile |  2 +-
 drivers/acpi/riscv/init.c   | 12 ++++++++++++
 include/linux/acpi.h        |  6 ++++++
 4 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/riscv/init.c

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 844c46447914..17ee483c3bf4 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1446,6 +1446,7 @@ static int __init acpi_init(void)
 	acpi_hest_init();
 	acpi_ghes_init();
 	acpi_arm_init();
+	acpi_riscv_init();
 	acpi_scan_init();
 	acpi_ec_init();
 	acpi_debugfs_init();
diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
index dceec808cfab..42d351859aeb 100644
--- a/drivers/acpi/riscv/Makefile
+++ b/drivers/acpi/riscv/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y					+= rhct.o irq.o
+obj-y					+= rhct.o irq.o init.o
 obj-$(CONFIG_ACPI_PROCESSOR_IDLE)	+= cpuidle.o
 obj-$(CONFIG_ACPI_CPPC_LIB)		+= cppc.o
diff --git a/drivers/acpi/riscv/init.c b/drivers/acpi/riscv/init.c
new file mode 100644
index 000000000000..b5807bbdb171
--- /dev/null
+++ b/drivers/acpi/riscv/init.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023, Ventana Micro Systems Inc
+ *	Author: Sunil V L <sunilvl@ventanamicro.com>
+ *
+ */
+
+#include <linux/acpi.h>
+
+void __init acpi_riscv_init(void)
+{
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 914ecd22ba64..f8f92aaf97ad 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1525,6 +1525,12 @@ void acpi_arm_init(void);
 static inline void acpi_arm_init(void) { }
 #endif
 
+#ifdef CONFIG_RISCV
+void acpi_riscv_init(void);
+#else
+static inline void acpi_riscv_init(void) { }
+#endif
+
 #ifdef CONFIG_ACPI_PCC
 void acpi_init_pcc(void);
 #else
-- 
2.40.1

