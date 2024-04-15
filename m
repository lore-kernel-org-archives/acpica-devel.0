Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3BE127E31
	for <acpica-devel@lists.linux.dev>; Mon, 15 Apr 2024 17:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200573; cv=none; b=p2iUbf7ytqtinbfLLDw1PBA4X+fLLF4DOBRqDCGOxvrTRnZoSHTXEbOQnadmjQWNrnkPmZHs4at6fHvWeFPHGFhFx5+jJBKUivQPhbU12Rv8rQ08QbHMkOTVaF8z2+owSKq2lzKXsjCe3R7nyCoa4fWWJyKFwUnW4yw9W6lxNiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200573; c=relaxed/simple;
	bh=W+FH+0WMCw7p8CDy8q3yUpAykRF8ezI4H2CH+9Zt25Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L2QT0wZmTls3UHdP5qFza7y3RXLlz96cZgrHtuLhDBW6JXqCSKufbPvQHwDqR4mlSanyvMLoSWva8vJuy1C1FY7c66nMD7ISR0Qp9k84UEH6AUzwKm91XcVUbaGabwq1obuk0+SzM1FXcUNgMnnjuN6h/G9PV9fsaanSLyEzFQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=kbrJAy7V; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="kbrJAy7V"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ecf8ebff50so2273314b3a.1
        for <acpica-devel@lists.linux.dev>; Mon, 15 Apr 2024 10:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713200571; x=1713805371; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLDuZBMdOA5LsIhe/7seDXRfkc825n/BCOMnccmbKZw=;
        b=kbrJAy7VSwGSwe0AT8ambB4r7CKHyWccrFU1Zovrb9nsXYbLaJv87pNBGQjXDuLUyn
         WzlBKjFl9WyJrn0nh4mkYkArxF52amU6jcVBLwc8YUULftb0h5IUx8Sxuw4AxeR+emAx
         HfS+PjauO9skkU7ZqX3PySqFwGq9NNnLtw/Y40Dueyran1DBAtFQknf+sJ+OFEWiOGFn
         EahkU0tJkhDuuA4of1/weKUFvbgP3mFIb8yLpst4VY8l/BEByrlN7LjFH+MGBo4lGE+S
         LAfE0oL7Xng9bsl/AyWLbfrBWqul2t0dZLi8LdqJX3SPWLHts619j2kWgjTlubRiSuzM
         nD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200571; x=1713805371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLDuZBMdOA5LsIhe/7seDXRfkc825n/BCOMnccmbKZw=;
        b=smgIg9AizQG2KW8c5+PPN/QIQ4DvAlhtj3utKd7H+I7QiGrpNK6ohgYib7wxdcmClT
         Cvsw1a8KIrEl6wV3tTagN6xRn23XJ5IwHSQMmvbupGyyAyo1vl39V9DAizXcK6psxolG
         vooJBzspZ9HHdd8jlHNEchQe6dVmX8TIjRZT4LEQz/eYNpqFPcJGfLXBciXQzoR0T5bi
         1TspYvBRmKH1ayPu7sYW0qZUQQ+7tiV82cgDqqfDNwSwNZW4cTtLOi0Nt3lvp47cqS6b
         CrpbRWL26Q39HOYnZvF7fbD3xF9O7FGA5Oyl0J2+HWnNaES8jgq/wWxFpFOuweBKRzBK
         ey/g==
X-Forwarded-Encrypted: i=1; AJvYcCUBScEk+uFOGtSuYZ6aYI4PlwDlT+22p/NhnBS6U4V4q2zIRvLsxQMRs5qQM7EVoc+PQIrydXgWoQWQ2BD2GLFv3CwzmVmLSb/m4WVh
X-Gm-Message-State: AOJu0YwIXEhwQ2OEaY+rg7aJAaufuZY+cVa0LpB9NHzfOaTkJ4rt1B8L
	Iq+MLxaAZ4AL5qmVOTmpdfDaOyl/WCxobcqJ0gBBWAFVfhMm/wizRo7FZVZqykc=
X-Google-Smtp-Source: AGHT+IE0Br/sfLtBzDZxNra+WQQQj8UhdqDe5qbQkKbjYH9VavooVHUHBefLx4JOZPgJS4SQ5vD0ww==
X-Received: by 2002:a05:6a00:190e:b0:6ec:fa34:34ab with SMTP id y14-20020a056a00190e00b006ecfa3434abmr279743pfi.9.1713200571057;
        Mon, 15 Apr 2024 10:02:51 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm7433158pfm.25.2024.04.15.10.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:02:50 -0700 (PDT)
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
Subject: [RFC PATCH v4 13/20] ACPI/PNP: Initialize PNP devices skipped due to _DEP
Date: Mon, 15 Apr 2024 22:31:06 +0530
Message-Id: <20240415170113.662318-14-sunilvl@ventanamicro.com>
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

When PNP devices have _DEP, they will not be enumerated in
pnpacpi_init() unless the dependency is met. Hence, when such PNP
device's supplier device is probed, the PNP device need to be added to
the PNP data structures. So, introduce pnpacpi_init_2() for doing this
which gets called as part of clearing the dependency.

This is currently required for RISC-V. Hence, restricted the code with a
CONFIG option enabled for RISC-V.

Since pnpacpi_add_device() can be called now even after boot,
__init attribute is removed from pnpacpi_add_device() and its dependent
functions.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/scan.c            |  4 +++
 drivers/pnp/pnpacpi/core.c     | 24 ++++++++++---
 drivers/pnp/pnpacpi/rsparser.c | 63 +++++++++++++++++-----------------
 include/linux/pnp.h            |  7 ++++
 4 files changed, 62 insertions(+), 36 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 8e23b9508716..086ae040a5ad 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -19,6 +19,7 @@
 #include <linux/dma-map-ops.h>
 #include <linux/platform_data/x86/apple.h>
 #include <linux/pgtable.h>
+#include <linux/pnp.h>
 #include <linux/crc32.h>
 #include <linux/dma-direct.h>
 
@@ -2370,6 +2371,9 @@ static void acpi_scan_clear_dep_fn(struct work_struct *work)
 	acpi_bus_attach(cdw->adev, (void *)true);
 	acpi_scan_lock_release();
 
+	if (IS_ENABLED(CONFIG_ARCH_ACPI_DEFERRED_GSI) && IS_ENABLED(CONFIG_PNPACPI))
+		pnpacpi_init_2(cdw->adev);
+
 	acpi_dev_put(cdw->adev);
 	kfree(cdw);
 }
diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index a0927081a003..c81893fc1fb2 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -26,7 +26,7 @@ static int num;
 #define TEST_ALPHA(c) \
 	if (!('A' <= (c) && (c) <= 'Z')) \
 		return 0
-static int __init ispnpidacpi(const char *id)
+static int ispnpidacpi(const char *id)
 {
 	TEST_ALPHA(id[0]);
 	TEST_ALPHA(id[1]);
@@ -194,7 +194,7 @@ struct pnp_protocol pnpacpi_protocol = {
 };
 EXPORT_SYMBOL(pnpacpi_protocol);
 
-static const char *__init pnpacpi_get_id(struct acpi_device *device)
+static const char *pnpacpi_get_id(struct acpi_device *device)
 {
 	struct acpi_hardware_id *id;
 
@@ -206,7 +206,7 @@ static const char *__init pnpacpi_get_id(struct acpi_device *device)
 	return NULL;
 }
 
-static int __init pnpacpi_add_device(struct acpi_device *device)
+static int pnpacpi_add_device(struct acpi_device *device)
 {
 	struct pnp_dev *dev;
 	const char *pnpid;
@@ -283,6 +283,23 @@ static int __init pnpacpi_add_device(struct acpi_device *device)
 	return 0;
 }
 
+int pnpacpi_disabled;
+
+#ifdef CONFIG_ARCH_ACPI_DEFERRED_GSI
+void pnpacpi_init_2(struct acpi_device *adev)
+{
+	if (acpi_disabled || pnpacpi_disabled)
+		return;
+
+	if (!adev)
+		return;
+
+	if (acpi_is_pnp_device(adev) && acpi_dev_ready_for_enumeration(adev))
+		pnpacpi_add_device(adev);
+}
+
+#endif
+
 static acpi_status __init pnpacpi_add_device_handler(acpi_handle handle,
 						     u32 lvl, void *context,
 						     void **rv)
@@ -296,7 +313,6 @@ static acpi_status __init pnpacpi_add_device_handler(acpi_handle handle,
 	return AE_OK;
 }
 
-int pnpacpi_disabled __initdata;
 static int __init pnpacpi_init(void)
 {
 	if (acpi_disabled || pnpacpi_disabled) {
diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index c02ce0834c2c..1008599901a2 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -289,9 +289,9 @@ int pnpacpi_parse_allocated_resource(struct pnp_dev *dev)
 	return 0;
 }
 
-static __init void pnpacpi_parse_dma_option(struct pnp_dev *dev,
-					    unsigned int option_flags,
-					    struct acpi_resource_dma *p)
+static void pnpacpi_parse_dma_option(struct pnp_dev *dev,
+				     unsigned int option_flags,
+				     struct acpi_resource_dma *p)
 {
 	int i;
 	unsigned char map = 0, flags;
@@ -303,9 +303,9 @@ static __init void pnpacpi_parse_dma_option(struct pnp_dev *dev,
 	pnp_register_dma_resource(dev, option_flags, map, flags);
 }
 
-static __init void pnpacpi_parse_irq_option(struct pnp_dev *dev,
-					    unsigned int option_flags,
-					    struct acpi_resource_irq *p)
+static void pnpacpi_parse_irq_option(struct pnp_dev *dev,
+				     unsigned int option_flags,
+				     struct acpi_resource_irq *p)
 {
 	int i;
 	pnp_irq_mask_t map;
@@ -320,9 +320,9 @@ static __init void pnpacpi_parse_irq_option(struct pnp_dev *dev,
 	pnp_register_irq_resource(dev, option_flags, &map, flags);
 }
 
-static __init void pnpacpi_parse_ext_irq_option(struct pnp_dev *dev,
-					unsigned int option_flags,
-					struct acpi_resource_extended_irq *p)
+static void pnpacpi_parse_ext_irq_option(struct pnp_dev *dev,
+					 unsigned int option_flags,
+					 struct acpi_resource_extended_irq *p)
 {
 	int i;
 	pnp_irq_mask_t map;
@@ -344,9 +344,9 @@ static __init void pnpacpi_parse_ext_irq_option(struct pnp_dev *dev,
 	pnp_register_irq_resource(dev, option_flags, &map, flags);
 }
 
-static __init void pnpacpi_parse_port_option(struct pnp_dev *dev,
-					     unsigned int option_flags,
-					     struct acpi_resource_io *io)
+static void pnpacpi_parse_port_option(struct pnp_dev *dev,
+				      unsigned int option_flags,
+				      struct acpi_resource_io *io)
 {
 	unsigned char flags = 0;
 
@@ -357,16 +357,16 @@ static __init void pnpacpi_parse_port_option(struct pnp_dev *dev,
 }
 
 static __init void pnpacpi_parse_fixed_port_option(struct pnp_dev *dev,
-					unsigned int option_flags,
-					struct acpi_resource_fixed_io *io)
+						   unsigned int option_flags,
+						   struct acpi_resource_fixed_io *io)
 {
 	pnp_register_port_resource(dev, option_flags, io->address, io->address,
 				   0, io->address_length, IORESOURCE_IO_FIXED);
 }
 
-static __init void pnpacpi_parse_mem24_option(struct pnp_dev *dev,
-					      unsigned int option_flags,
-					      struct acpi_resource_memory24 *p)
+static void pnpacpi_parse_mem24_option(struct pnp_dev *dev,
+				       unsigned int option_flags,
+				       struct acpi_resource_memory24 *p)
 {
 	unsigned char flags = 0;
 
@@ -376,9 +376,9 @@ static __init void pnpacpi_parse_mem24_option(struct pnp_dev *dev,
 				  p->alignment, p->address_length, flags);
 }
 
-static __init void pnpacpi_parse_mem32_option(struct pnp_dev *dev,
-					      unsigned int option_flags,
-					      struct acpi_resource_memory32 *p)
+static void pnpacpi_parse_mem32_option(struct pnp_dev *dev,
+				       unsigned int option_flags,
+				       struct acpi_resource_memory32 *p)
 {
 	unsigned char flags = 0;
 
@@ -388,9 +388,9 @@ static __init void pnpacpi_parse_mem32_option(struct pnp_dev *dev,
 				  p->alignment, p->address_length, flags);
 }
 
-static __init void pnpacpi_parse_fixed_mem32_option(struct pnp_dev *dev,
-					unsigned int option_flags,
-					struct acpi_resource_fixed_memory32 *p)
+static void pnpacpi_parse_fixed_mem32_option(struct pnp_dev *dev,
+					     unsigned int option_flags,
+					     struct acpi_resource_fixed_memory32 *p)
 {
 	unsigned char flags = 0;
 
@@ -400,9 +400,9 @@ static __init void pnpacpi_parse_fixed_mem32_option(struct pnp_dev *dev,
 				  0, p->address_length, flags);
 }
 
-static __init void pnpacpi_parse_address_option(struct pnp_dev *dev,
-						unsigned int option_flags,
-						struct acpi_resource *r)
+static void pnpacpi_parse_address_option(struct pnp_dev *dev,
+					 unsigned int option_flags,
+					 struct acpi_resource *r)
 {
 	struct acpi_resource_address64 addr, *p = &addr;
 	acpi_status status;
@@ -427,9 +427,9 @@ static __init void pnpacpi_parse_address_option(struct pnp_dev *dev,
 					   IORESOURCE_IO_FIXED);
 }
 
-static __init void pnpacpi_parse_ext_address_option(struct pnp_dev *dev,
-						    unsigned int option_flags,
-						    struct acpi_resource *r)
+static void pnpacpi_parse_ext_address_option(struct pnp_dev *dev,
+					     unsigned int option_flags,
+					     struct acpi_resource *r)
 {
 	struct acpi_resource_extended_address64 *p = &r->data.ext_address64;
 	unsigned char flags = 0;
@@ -451,8 +451,7 @@ struct acpipnp_parse_option_s {
 	unsigned int option_flags;
 };
 
-static __init acpi_status pnpacpi_option_resource(struct acpi_resource *res,
-						  void *data)
+static acpi_status pnpacpi_option_resource(struct acpi_resource *res, void *data)
 {
 	int priority;
 	struct acpipnp_parse_option_s *parse_data = data;
@@ -547,7 +546,7 @@ static __init acpi_status pnpacpi_option_resource(struct acpi_resource *res,
 	return AE_OK;
 }
 
-int __init pnpacpi_parse_resource_option_data(struct pnp_dev *dev)
+int pnpacpi_parse_resource_option_data(struct pnp_dev *dev)
 {
 	struct acpi_device *acpi_dev = dev->data;
 	acpi_handle handle = acpi_dev->handle;
diff --git a/include/linux/pnp.h b/include/linux/pnp.h
index ddbe7c3ca4ce..440f8c268a29 100644
--- a/include/linux/pnp.h
+++ b/include/linux/pnp.h
@@ -347,6 +347,7 @@ static inline struct acpi_device *pnp_acpi_device(struct pnp_dev *dev)
 		return dev->data;
 	return NULL;
 }
+
 #else
 #define pnp_acpi_device(dev) 0
 #endif
@@ -514,4 +515,10 @@ static inline void pnp_unregister_driver(struct pnp_driver *drv) { }
 	module_driver(__pnp_driver, pnp_register_driver, \
 				    pnp_unregister_driver)
 
+#ifdef CONFIG_ARCH_ACPI_DEFERRED_GSI
+void pnpacpi_init_2(struct acpi_device *adev);
+#else
+static inline void pnpacpi_init_2(struct acpi_device *adev) { }
+#endif
+
 #endif /* _LINUX_PNP_H */
-- 
2.40.1

