Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5955015253F
	for <acpica-devel@lists.linux.dev>; Sat,  1 Jun 2024 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717254286; cv=none; b=sno0VHL2FUknegdfiLKi3w+CFyG+Qzsyh94NYTfzLMF+f3mF93sSQV+v54aqTogLwM+7RYg/N+BzN8TkXczVWlnHQJPqibgxbar4s5XTDPcQRCJfTTrU4+RW8Cd7TYzPBwBtrm22yG1T384Bt/D2NvbDvFCVwbdbqtnP4yiMJ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717254286; c=relaxed/simple;
	bh=E/skCHGNmdvJjDbFpcdffugM/MM2UFUg2zxVjQ3qBJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EkqI8N5RJtwPQ0ujYaZ8kSg/CrzdmqakRMi+Onz+OkwjgCFUm7GpBHtoxnPTa4HkJ1bLv11gAQyXTUQRforDjdvfMmU6utjSw+M3U9Lw6suHM+lx5CGc/GnNJeXyEJvojSGRwqDhC9aMbsxHfbVkfUTKmZP7opC/n/xq2SI+Lu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Lf118Igl; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Lf118Igl"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-702447766fdso1901445b3a.1
        for <acpica-devel@lists.linux.dev>; Sat, 01 Jun 2024 08:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717254283; x=1717859083; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XPxdT6K3q9avtvxcOF9k8RyQ+CxCpXPedgopG0VTh8=;
        b=Lf118Igl7Ve+Ji9VJzfojai9QOEI4DZWrjpBZVQ/IjqJqIcJaRwIYsD4saL9KtMXgm
         lw3bdSIQFZG9CEBwy+dWuZ2r/clctnuaoZY7D8qG2Ce337jv5CosZsSzsKeDjiat8Tpn
         zWUjP+pMLYiEs+qA6WQVs/YBCsk06iNfrT966Jn8XZ+7L7S06cvlT2hW3Nk/Zm12o6mk
         MyOY6IkKVA3MKVoMUF8GmLsIFibSudiw+GFiHbRfRva+K6KKuutkjTf7chY2PI9NOS1V
         pm6C/zMlKmZdZopIZPJ/mUht6Acj2oZ/Aay9QI30JwqkFrkSTx5pyNsJxyxvKk1U0MPA
         +aVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717254283; x=1717859083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XPxdT6K3q9avtvxcOF9k8RyQ+CxCpXPedgopG0VTh8=;
        b=cgf8rjNgoagjVlQUZolfibGv7+Tg+zr5grCw6n23qSaScGqs8KwB5hn3Xkl3JTMjZo
         /FtGy6teo5Dgx8DNwRjYPiYhiVzqm8jmsoo8ssDll9NNzogGHwY1Y9UK/uNPi8kq5kWc
         9ptojZ/Q59Jm8ecfRzDBVg5m0MNGASFr6mTYE982KZo7KpcN5O8Sa38ogRyv0lrvuS/m
         m5SmcA5pe2V9Z2bePfPWUNouz6revENuP1Be5m3znz38OILDLsUbhYCcTfAZcK3g8za8
         1zCHFKrbtuMwrP+WUzrVgCPwDH1EonhwTVJ3wP6hv5iBXNTcTm/vKKRCc0cnFKDsypYV
         XN/w==
X-Forwarded-Encrypted: i=1; AJvYcCWeMLQdg4mjifC0kK398+bV1I3aGNzmfv/ijDzCP23+ss+s2P2RaH12xMV+HCuED0vCkEyVGwbdkv7jTmajm8l1IkgOaPx8Y3FSRopf
X-Gm-Message-State: AOJu0YygUgY+Lct+SfbcqfmrQqu7qH0YRxGZXxC9b834oVdHuR8hBQwO
	LyOCnPdDzA3fL93eQ1hezcofkFDW8+aP764KNJJL9cGbzZ5j21LOc5a2MxSCcb8=
X-Google-Smtp-Source: AGHT+IHSPHHuLlxYdhrhdQ1SLxLogYrmPMkhydYeNGjzqhZ539L1iLkZwGvrDzW2O9+TbFzfxEzXhQ==
X-Received: by 2002:a05:6a20:3946:b0:1af:e3f1:9af7 with SMTP id adf61e73a8af0-1b26f204cfemr5557418637.36.1717254282646;
        Sat, 01 Jun 2024 08:04:42 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35a4ba741sm2559410a12.85.2024.06.01.08.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 08:04:42 -0700 (PDT)
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
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v6 03/17] ACPI: bus: Add acpi_riscv_init function
Date: Sat,  1 Jun 2024 20:33:57 +0530
Message-Id: <20240601150411.1929783-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240601150411.1929783-1-sunilvl@ventanamicro.com>
References: <20240601150411.1929783-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new function for RISC-V to do architecture specific initialization
similar to acpi_arm_init(). Some of the ACPI tables are architecture
specific and there is no reason trying to find them on other
architectures.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/bus.c          |  1 +
 drivers/acpi/riscv/Makefile |  2 +-
 drivers/acpi/riscv/init.c   | 12 ++++++++++++
 include/linux/acpi.h        |  6 ++++++
 4 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/riscv/init.c

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 787eca838410..8d0710ade8c6 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1457,6 +1457,7 @@ static int __init acpi_init(void)
 	acpi_hest_init();
 	acpi_ghes_init();
 	acpi_arm_init();
+	acpi_riscv_init();
 	acpi_scan_init();
 	acpi_ec_init();
 	acpi_debugfs_init();
diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
index 86b0925f612d..877de00d1b50 100644
--- a/drivers/acpi/riscv/Makefile
+++ b/drivers/acpi/riscv/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y					+= rhct.o
+obj-y					+= rhct.o init.o
 obj-$(CONFIG_ACPI_PROCESSOR_IDLE)	+= cpuidle.o
 obj-$(CONFIG_ACPI_CPPC_LIB)		+= cppc.o
diff --git a/drivers/acpi/riscv/init.c b/drivers/acpi/riscv/init.c
new file mode 100644
index 000000000000..5f7571143245
--- /dev/null
+++ b/drivers/acpi/riscv/init.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023-2024, Ventana Micro Systems Inc
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
index ab3f2880d209..0c6d9539f737 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1520,6 +1520,12 @@ void acpi_arm_init(void);
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

