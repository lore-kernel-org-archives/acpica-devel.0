Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCB71534EA
	for <acpica-devel@lists.linux.dev>; Sat,  1 Jun 2024 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717254328; cv=none; b=mjeZ84y0SOs47khUvUKKuxbd6a86eH6O3fgMqe7eeVphnETGtTOw4AJOCcyrvJQE3wlsx2wNNP55orjA7d8vw2t2eD1j7ZWZ80MZmpchl9GUtrq940FqW9CNslANNpNwE80bATRTm1adWKxmb8BVppH+DcytzoMsyPSgvNTzAYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717254328; c=relaxed/simple;
	bh=+0+8uWNJ2E+sjIHYLQXKU2enWqx4IjoPosf2UhC3Spk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b/BmcER46M6rk2kFRnqKHZcp9qhLJ94ougxub09jxE2CFO7TQ0JEEhRy+XSqPEBMWI4sZ155d4o04BW4DafZHvnCxIDxM4wcevpeXt7N7C8qt8Cx+Axn0sQRBkRjkDTCU+pf+2kSqM+wfo/8eXriPAsSvGL3BVcHn1sehVGYpC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=djjERtIx; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="djjERtIx"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36ddf683ad7so12232765ab.2
        for <acpica-devel@lists.linux.dev>; Sat, 01 Jun 2024 08:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717254325; x=1717859125; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFsOtJr39QOitF1KwZRd+YQFJB+PCc/GRrrdZlZj/hE=;
        b=djjERtIxnryD9np9V4MmzIhKz9+6QQi274qXv2AOKsEZbp4p0EJK8F7T74ntdYOQ3O
         /PV8051YIVP9ESalC826JXLJ9Zi9Q3U9AI3rJXcfHjsEQH6N3XhE8zy7gg2rzHNLLgGu
         k8lmTivJfOIpgtGfMbBQWIdzsCinBzKPQhlnPlaGkIhsu3eavYT0HA2KB4kCL4m1VIz2
         OW9v3wVJRSqlyZhR8R6QpEJGXfEMGYNVFp9NoYqUZB/gog87EjwcfpZ2bsh6Msx3Nw23
         Pv/Sg97SM0zyRrr/H1+HenovRmx+keIJqrIaLP6c+JvmU8/Wt1dWQ8sBlUIW2U3qTI3Z
         ZAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717254325; x=1717859125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFsOtJr39QOitF1KwZRd+YQFJB+PCc/GRrrdZlZj/hE=;
        b=Nz0ROXeNf2RDLZmmvDR25MecHF3/rfcySrI9rK4rOsd24LKtwaZe58T8FuvQHdhWlt
         Blbfkom0KzICi4XgkpcpJMANv0a7wYFVNnlL8GfkqdVjDeWUGmiENW8EqpkbVop7qW8+
         uy9jzJbXn0S1+Fiyz+KsbuVQPfEsjo9SWI+dOhXecbT8hLuNYg2GicfVS4BzUNIaZ0Xf
         sL5jZaVKOAH4hfHRjMU/uJzPpOz1+7LQ7njqgpLov6mGWOexMc9eiF/5YYf0GsvUMp0D
         ipQnPIx7AuE/KiGHAFU9Mz/nnP1khb6/eTQSf1kP9GSjAgYxCJPDqeUu9zdrtCz8pK9C
         coCw==
X-Forwarded-Encrypted: i=1; AJvYcCUiCGSo5AHqSmI4e7aN1nv8nCqnaUqN+cQ2YEcXBCLXn+hR4lkuSzQUglGoEiTxUA0exfdV2kU3V/SxDvoA/kFpMfMsYvEq6ZCrrkJF
X-Gm-Message-State: AOJu0YwUlIbipPeGnVabp4SE2XPrCch0GMJIAflWs+3LGh1dUljHpqxT
	tzK4+3AywOYSuoLcPye3MLeCkkYBEVNGRwLV70Wxl7jRbMsYMSJQzRB9GM++TRM=
X-Google-Smtp-Source: AGHT+IEJRIuFWfACl4C/2OdIIJGx8aK6TxTUuoEk2JLfaDxuwQLQymMr8D5iU52VLgMZ5cmUpvU7ag==
X-Received: by 2002:a05:6e02:1d0b:b0:374:593f:913e with SMTP id e9e14a558f8ab-3748b98e53dmr55865925ab.14.1717254325230;
        Sat, 01 Jun 2024 08:05:25 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35a4ba741sm2559410a12.85.2024.06.01.08.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 08:05:24 -0700 (PDT)
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
Subject: [PATCH v6 09/17] ACPI: RISC-V: Implement PCI related functionality
Date: Sat,  1 Jun 2024 20:34:03 +0530
Message-Id: <20240601150411.1929783-10-sunilvl@ventanamicro.com>
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

Replace the dummy implementation for PCI related functions with actual
implementation. This needs ECAM and MCFG CONFIG options to be enabled
for RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/Kconfig       |  2 ++
 arch/riscv/kernel/acpi.c | 33 +++++++++++++++------------------
 drivers/pci/pci-acpi.c   |  2 +-
 3 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index b94176e25be1..f143fbeea572 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -13,6 +13,7 @@ config 32BIT
 config RISCV
 	def_bool y
 	select ACPI_GENERIC_GSI if ACPI
+	select ACPI_MCFG if (ACPI && PCI)
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
@@ -181,6 +182,7 @@ config RISCV
 	select OF_EARLY_FLATTREE
 	select OF_IRQ
 	select PCI_DOMAINS_GENERIC if PCI
+	select PCI_ECAM if (ACPI && PCI)
 	select PCI_MSI if PCI
 	select RISCV_ALTERNATIVE if !XIP_KERNEL
 	select RISCV_APLIC
diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index e619edc8b0cc..41aa77c8484b 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -306,29 +306,26 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
 #ifdef CONFIG_PCI
 
 /*
- * These interfaces are defined just to enable building ACPI core.
- * TODO: Update it with actual implementation when external interrupt
- * controller support is added in RISC-V ACPI.
+ * raw_pci_read/write - Platform-specific PCI config space access.
  */
-int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
-		 int reg, int len, u32 *val)
+int raw_pci_read(unsigned int domain, unsigned int bus,
+		 unsigned int devfn, int reg, int len, u32 *val)
 {
-	return PCIBIOS_DEVICE_NOT_FOUND;
+	struct pci_bus *b = pci_find_bus(domain, bus);
+
+	if (!b)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	return b->ops->read(b, devfn, reg, len, val);
 }
 
-int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
-		  int reg, int len, u32 val)
+int raw_pci_write(unsigned int domain, unsigned int bus,
+		  unsigned int devfn, int reg, int len, u32 val)
 {
-	return PCIBIOS_DEVICE_NOT_FOUND;
+	struct pci_bus *b = pci_find_bus(domain, bus);
+
+	if (!b)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	return b->ops->write(b, devfn, reg, len, val);
 }
 
-int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
-{
-	return -1;
-}
-
-struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
-{
-	return NULL;
-}
 #endif	/* CONFIG_PCI */
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index e8d84fa435da..b5892d0fa68c 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1521,7 +1521,7 @@ static int __init acpi_pci_init(void)
 }
 arch_initcall(acpi_pci_init);
 
-#if defined(CONFIG_ARM64)
+#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
 
 /*
  * Try to assign the IRQ number when probing a new device
-- 
2.40.1

