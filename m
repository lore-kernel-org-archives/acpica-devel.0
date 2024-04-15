Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2737183CBA
	for <acpica-devel@lists.linux.dev>; Mon, 15 Apr 2024 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200500; cv=none; b=Qqu6YxnC/X5NRhkDeKBxWC2VEWfywd57uOsOl7tZqh1oom9vC79aK0IvG8eCwv97bLUDudDXB1qZjR4mo9blTsOWSWzIvJqQyNhoIK8zSCyx6OMBgW+PJ3BPv9/sKSlhLhvht1Tf3KkWr88n8vnqgCrmMxUFcoIsNOg8+ZRqoTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200500; c=relaxed/simple;
	bh=d//fcv46H4LzOYIR8kFfFqlYP6RASRxKKzQCgxhHvNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kYfMxv0FlqS77eQqg+r/FQCfzZnk0zqbU1XcUnUwQNyCellOZKgpNEK4mxDK4kXzquRK+BgvXZNg6tdPgyv98pjrIXeanWdzZP4sWkTIjYhfMagmPGMA1bv+x3F756FsWQ7N0a3Iu4/YKdMSeiMFMV09fRHm/xusbghARrsRYU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Xk1Zv2Af; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Xk1Zv2Af"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ed11782727so2926445b3a.1
        for <acpica-devel@lists.linux.dev>; Mon, 15 Apr 2024 10:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713200497; x=1713805297; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFAtcNyUPfmOo+WuzK4Rac+GFz0TbHOwinmWYmcFrxc=;
        b=Xk1Zv2AfpJwkPNgFqYjJfVE4e7EpTCd5kOCaNZSj1bBDkJ3St1ClDd//mQlJzPcCMU
         x0RYz6VpFCYepOi46KiJUe+DfGw88Il4aoWGSuAQAA7coP88TrWkwgMgp7MmFSr1u1UO
         CbBwVAHpZLhOt7VQO0tPIxBfLRMKGg5q0oPnDewWwZAxZB/zGulPls6UR66hceg/nR3l
         x+Yg0jKthmh7h9mH0HRmVmGVnsx34j8mOw8B9CzIcGs2wcYSv/91t/jR63PRF4CkYD0L
         ugXf4oPk/IhJRI1m9b4yH4SUaUWpLgwVwf6a23u8cGcmnVPgkXZF4mvACBEv3aB7ZKUy
         QG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200497; x=1713805297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFAtcNyUPfmOo+WuzK4Rac+GFz0TbHOwinmWYmcFrxc=;
        b=SEESUB6djwBLdBRSd+xLaQMG2j/aITb25c7veo3+7BG8LJbnqeqDrN8iVuB8g6AR2i
         Xofq9xtG91ShIpnSKujqG+NJ4Arb4JiQdM8lXqiTeLbkbiA7jaxHD61Bok4Ev+nfUpxh
         K6Ma7RNU5x/Afo2zUQxSc+XgJp/tiH/53a5y1y3A0rFKruFjp9oq+OFoucFFJ0JRJ9Gx
         ASDIjbdBhRwlt3gPKFCS5iRs6WbL/8lnpDQqFAG0ij7XHF06Qg3IMqdjI1iYN2XsylVC
         9RgP5LxK50yOpL4iw+5OQCI8PocI5Ot2aEWs4xrEOoLf+KdQgmz75eu6q97XaEoOBhsZ
         XgZA==
X-Forwarded-Encrypted: i=1; AJvYcCUQbiaCmnywaZKWajoiFzI1etGyD6kSqPO2jRw5+Uv+toXW0vGp/+fjXj2gFcZtEXdylDnzKHtvWU/4UX5/jwAvNUtFDsdcB1PLJo4s
X-Gm-Message-State: AOJu0YyeyATQ7TzJK9OjqGbUSX4pNjXHyz+DvyS3JwsbsqpHPGT4/XzU
	c9waqNj6GGa8+KqPOoDMugqquXL8o163jH8iQ+D5BpN1lNZ6yT7iQ86LaNP9/c8=
X-Google-Smtp-Source: AGHT+IGqYjIa76YfWohzDrF4RGeNhNZq2I7mTi99zpcmd5VEKjXE94y5JlYL9p7qJRGZUYYL3web8A==
X-Received: by 2002:a05:6a00:22cf:b0:6eb:2b:43b4 with SMTP id f15-20020a056a0022cf00b006eb002b43b4mr11021959pfj.27.1713200496609;
        Mon, 15 Apr 2024 10:01:36 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm7433158pfm.25.2024.04.15.10.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:01:36 -0700 (PDT)
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
Subject: [RFC PATCH v4 02/20] RISC-V: ACPI: Implement PCI related functionality
Date: Mon, 15 Apr 2024 22:30:55 +0530
Message-Id: <20240415170113.662318-3-sunilvl@ventanamicro.com>
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

Replace the dummy implementation for PCI related functions with actual
implementation. This needs ECAM and MCFG CONFIG options to be enabled
for RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/Kconfig       |  2 ++
 arch/riscv/kernel/acpi.c | 31 ++++++++++++++-----------------
 drivers/pci/pci-acpi.c   |  2 +-
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6d64888134ba..69cc0509a19a 100644
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
@@ -173,6 +174,7 @@ config RISCV
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
-}
+	struct pci_bus *b = pci_find_bus(domain, bus);
 
-int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
-		  int reg, int len, u32 val)
-{
-	return PCIBIOS_DEVICE_NOT_FOUND;
+	if (!b)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	return b->ops->read(b, devfn, reg, len, val);
 }
 
-int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
+int raw_pci_write(unsigned int domain, unsigned int bus,
+		  unsigned int devfn, int reg, int len, u32 val)
 {
-	return -1;
-}
+	struct pci_bus *b = pci_find_bus(domain, bus);
 
-struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
-{
-	return NULL;
+	if (!b)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	return b->ops->write(b, devfn, reg, len, val);
 }
+
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

