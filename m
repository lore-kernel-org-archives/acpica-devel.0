Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E14FB64E
	for <acpica-devel@lists.linux.dev>; Mon, 12 Aug 2024 01:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723424452; cv=none; b=iIRDzjeVNNLMFoVxHsvysywdydn+k+djBWtzkKvd/E8FX8I2wpF5CgLhV6iSQyrdgwtDq5Uj/PxMXpeZg561L26RoXTpG37dtjvdcWbt6+e5Fbge43KbdKGrVUEny4NE64B3Ecp4afxhVDyXzN+r7SPCk4+paDvIMD1ONivjXD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723424452; c=relaxed/simple;
	bh=xZxlyDcMOh+rhR2esklH3kbgHbWDV2ZIJQfnY0eZOqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lS/Dy9egSFUqoH7EmdNaQpiasgwbwBY0Ci1NFlQfkw5Y4JrxmtRvEZ8nTSHKyF6n9o+jsZGf5oWt7hFhP/jfNw93+jeRbPTUd25m/Xtu48N2PPg5vAeW+z0IdOUunESPA30+pbft4MxzUlglLSEx8W+5nrrz7FjaVUShb62v2FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=R+gJrra2; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="R+gJrra2"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7105043330aso3053843b3a.0
        for <acpica-devel@lists.linux.dev>; Sun, 11 Aug 2024 18:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723424450; x=1724029250; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGfeskz8g19r+OqajKxPNYjNNE+F0wltIvoajFyWVok=;
        b=R+gJrra2l1CE+bOwqK7YQIJbgBMst8XnkLffknyUjlrz/ZtvIDaPNz/bw5R4dtOtfY
         Ig00sBHz99AenoXHvL+/siq2an8rN/cpchH8nh1bo0N9vqn/t0Gqm8C3lc2RrI1Az3sH
         B9Bl/l7E0nZaGIxrkw1W1oqAz9WQD9AdVoW2LaBhR1W1uEDuwm6u4jngEZyGC2WEtK+y
         1tYYUZDGhyTOi0MDClv71KcoXYk7Ks83h7qp04I2ADkNq0NNC+58vDyjmTEKynwxKsYZ
         o9L7pamBXJJD1NY4DpOkpw+BXlUB9+RpKa99H0vTnXCxJPrzyelBUIBrMWeUKup4U7Br
         1FMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723424450; x=1724029250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGfeskz8g19r+OqajKxPNYjNNE+F0wltIvoajFyWVok=;
        b=sXuFFso6uV9DyMoqTuWGHA9TIqmDI6epkQjbbX1RXnSSm7QmQsnF3eLX8+NfSt8GIf
         +BNOGIgRrHR4MNbgLw/Q4F52gxlofPJ5NpPb1HUxVQp1ECud62dvdAdFlc8pOQU/NuRP
         x2PVnZpQz9FU1HkS5oOvp3U8eDn6YZ3Erj9A7+yOxHhhR2PPdK904dXuBbgs60r9bD+j
         05/Xo39hsXG/jxWRQB7VI01NcmjthydsE/exl20cBVO32zflBeNlT7IxZCfQFO/0G5Gh
         y5EDBXScr+fi7/aRq6uEdokOjUsUDQy9jGDBbeHSs3u00Wxl8bR6Vv4a7ZovM+p94EvV
         5G4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWzq2Oo/dMZqReHJWMRkhk+jZ9MI6M9WwAuPH/3wlROhrYWu1if0I3nZpBrI7bNmT/mhH7S1MHf3qiZIJJ+fzCq2PIoiynBIm4ORnxU
X-Gm-Message-State: AOJu0YxVy9mHFSA7hfNsCjk2/5o0HJdp6yRAmgxAWOAW1+Q2WnxOrP+D
	ukOFzmgxt0iC+dazSi4p5IsjqCG6vJS7HLajlcA3ARGg/4d+GWVaEmzSRBhLUYQ=
X-Google-Smtp-Source: AGHT+IE3q8lKgHgWLAwxE/0Wiss9V/UMieO99InX6OgVwr4G4I59tEn3alleuzimlu24LFWs915ICg==
X-Received: by 2002:a05:6a00:2da1:b0:710:7efe:a870 with SMTP id d2e1a72fcca58-710dcaeb509mr5600452b3a.19.1723424450430;
        Sun, 11 Aug 2024 18:00:50 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe8cbdcsm3074062a12.61.2024.08.11.18.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 18:00:49 -0700 (PDT)
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
Subject: [PATCH v8 11/17] ACPI: RISC-V: Initialize GSI mapping structures
Date: Mon, 12 Aug 2024 06:29:23 +0530
Message-ID: <20240812005929.113499-12-sunilvl@ventanamicro.com>
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

RISC-V has PLIC and APLIC in MADT as well as namespace devices.
Initialize the list of those structures using MADT and namespace devices
to create mapping between the ACPI handle and the GSI ranges. This will
be used later to add dependencies.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/include/asm/irq.h |  22 ++++++
 drivers/acpi/riscv/init.c    |   2 +
 drivers/acpi/riscv/init.h    |   4 +
 drivers/acpi/riscv/irq.c     | 147 +++++++++++++++++++++++++++++++++++
 4 files changed, 175 insertions(+)
 create mode 100644 drivers/acpi/riscv/init.h

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index 8e10a94430a2..44a0b128c602 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -16,4 +16,26 @@ void riscv_set_intc_hwnode_fn(struct fwnode_handle *(*fn)(void));
 
 struct fwnode_handle *riscv_get_intc_hwnode(void);
 
+#ifdef CONFIG_ACPI
+
+enum riscv_irqchip_type {
+	ACPI_RISCV_IRQCHIP_INTC		= 0x00,
+	ACPI_RISCV_IRQCHIP_IMSIC	= 0x01,
+	ACPI_RISCV_IRQCHIP_PLIC		= 0x02,
+	ACPI_RISCV_IRQCHIP_APLIC	= 0x03,
+};
+
+int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, u32 *gsi_base,
+			    u32 *id, u32 *nr_irqs, u32 *nr_idcs);
+struct fwnode_handle *riscv_acpi_get_gsi_domain_id(u32 gsi);
+
+#else
+static inline int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, u32 *gsi_base,
+					  u32 *id, u32 *nr_irqs, u32 *nr_idcs)
+{
+	return 0;
+}
+
+#endif /* CONFIG_ACPI */
+
 #endif /* _ASM_RISCV_IRQ_H */
diff --git a/drivers/acpi/riscv/init.c b/drivers/acpi/riscv/init.c
index a875a76aa44c..5ef97905a727 100644
--- a/drivers/acpi/riscv/init.c
+++ b/drivers/acpi/riscv/init.c
@@ -5,7 +5,9 @@
  */
 
 #include <linux/acpi.h>
+#include "init.h"
 
 void __init acpi_riscv_init(void)
 {
+	riscv_acpi_init_gsi_mapping();
 }
diff --git a/drivers/acpi/riscv/init.h b/drivers/acpi/riscv/init.h
new file mode 100644
index 000000000000..0b9a07e4031f
--- /dev/null
+++ b/drivers/acpi/riscv/init.h
@@ -0,0 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#include <linux/init.h>
+
+void __init riscv_acpi_init_gsi_mapping(void);
diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
index 835eb6eccd53..9028787c73a7 100644
--- a/drivers/acpi/riscv/irq.c
+++ b/drivers/acpi/riscv/irq.c
@@ -6,6 +6,21 @@
 
 #include <linux/acpi.h>
 #include <linux/sort.h>
+#include <linux/irq.h>
+
+#include "init.h"
+
+struct riscv_ext_intc_list {
+	acpi_handle		handle;
+	u32			gsi_base;
+	u32			nr_irqs;
+	u32			nr_idcs;
+	u32			id;
+	u32			type;
+	struct list_head	list;
+};
+
+LIST_HEAD(ext_intc_list);
 
 static int irqchip_cmp_func(const void *in0, const void *in1)
 {
@@ -31,3 +46,135 @@ void arch_sort_irqchip_probe(struct acpi_probe_entry *ap_head, int nr)
 		return;
 	sort(ape, nr, sizeof(*ape), irqchip_cmp_func, NULL);
 }
+
+static acpi_status riscv_acpi_update_gsi_handle(u32 gsi_base, acpi_handle handle)
+{
+	struct riscv_ext_intc_list *ext_intc_element;
+	struct list_head *i, *tmp;
+
+	list_for_each_safe(i, tmp, &ext_intc_list) {
+		ext_intc_element = list_entry(i, struct riscv_ext_intc_list, list);
+		if (gsi_base == ext_intc_element->gsi_base) {
+			ext_intc_element->handle = handle;
+			return AE_OK;
+		}
+	}
+
+	return AE_NOT_FOUND;
+}
+
+int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, u32 *gsi_base,
+			    u32 *id, u32 *nr_irqs, u32 *nr_idcs)
+{
+	struct riscv_ext_intc_list *ext_intc_element;
+	struct list_head *i;
+
+	list_for_each(i, &ext_intc_list) {
+		ext_intc_element = list_entry(i, struct riscv_ext_intc_list, list);
+		if (ext_intc_element->handle == ACPI_HANDLE_FWNODE(fwnode)) {
+			*gsi_base = ext_intc_element->gsi_base;
+			*id = ext_intc_element->id;
+			*nr_irqs = ext_intc_element->nr_irqs;
+			if (nr_idcs)
+				*nr_idcs = ext_intc_element->nr_idcs;
+
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
+struct fwnode_handle *riscv_acpi_get_gsi_domain_id(u32 gsi)
+{
+	struct riscv_ext_intc_list *ext_intc_element;
+	struct acpi_device *adev;
+	struct list_head *i;
+
+	list_for_each(i, &ext_intc_list) {
+		ext_intc_element = list_entry(i, struct riscv_ext_intc_list, list);
+		if (gsi >= ext_intc_element->gsi_base &&
+		    gsi < (ext_intc_element->gsi_base + ext_intc_element->nr_irqs)) {
+			adev = acpi_fetch_acpi_dev(ext_intc_element->handle);
+			if (!adev)
+				return NULL;
+
+			return acpi_fwnode_handle(adev);
+		}
+	}
+
+	return NULL;
+}
+
+static int __init riscv_acpi_register_ext_intc(u32 gsi_base, u32 nr_irqs, u32 nr_idcs,
+					       u32 id, u32 type)
+{
+	struct riscv_ext_intc_list *ext_intc_element;
+
+	ext_intc_element = kzalloc(sizeof(*ext_intc_element), GFP_KERNEL);
+	if (!ext_intc_element)
+		return -ENOMEM;
+
+	ext_intc_element->gsi_base = gsi_base;
+	ext_intc_element->nr_irqs = nr_irqs;
+	ext_intc_element->nr_idcs = nr_idcs;
+	ext_intc_element->id = id;
+	list_add_tail(&ext_intc_element->list, &ext_intc_list);
+	return 0;
+}
+
+static acpi_status __init riscv_acpi_create_gsi_map(acpi_handle handle, u32 level,
+						    void *context, void **return_value)
+{
+	acpi_status status;
+	u64 gbase;
+
+	if (!acpi_has_method(handle, "_GSB")) {
+		acpi_handle_err(handle, "_GSB method not found\n");
+		return AE_ERROR;
+	}
+
+	status = acpi_evaluate_integer(handle, "_GSB", NULL, &gbase);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_err(handle, "failed to evaluate _GSB method\n");
+		return status;
+	}
+
+	status = riscv_acpi_update_gsi_handle((u32)gbase, handle);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_err(handle, "failed to find the GSI mapping entry\n");
+		return status;
+	}
+
+	return AE_OK;
+}
+
+static int __init riscv_acpi_aplic_parse_madt(union acpi_subtable_headers *header,
+					      const unsigned long end)
+{
+	struct acpi_madt_aplic *aplic = (struct acpi_madt_aplic *)header;
+
+	return riscv_acpi_register_ext_intc(aplic->gsi_base, aplic->num_sources, aplic->num_idcs,
+					    aplic->id, ACPI_RISCV_IRQCHIP_APLIC);
+}
+
+static int __init riscv_acpi_plic_parse_madt(union acpi_subtable_headers *header,
+					     const unsigned long end)
+{
+	struct acpi_madt_plic *plic = (struct acpi_madt_plic *)header;
+
+	return riscv_acpi_register_ext_intc(plic->gsi_base, plic->num_irqs, 0,
+					    plic->id, ACPI_RISCV_IRQCHIP_PLIC);
+}
+
+void __init riscv_acpi_init_gsi_mapping(void)
+{
+	/* There can be either PLIC or APLIC */
+	if (acpi_table_parse_madt(ACPI_MADT_TYPE_PLIC, riscv_acpi_plic_parse_madt, 0) > 0) {
+		acpi_get_devices("RSCV0001", riscv_acpi_create_gsi_map, NULL, NULL);
+		return;
+	}
+
+	if (acpi_table_parse_madt(ACPI_MADT_TYPE_APLIC, riscv_acpi_aplic_parse_madt, 0) > 0)
+		acpi_get_devices("RSCV0002", riscv_acpi_create_gsi_map, NULL, NULL);
+}
-- 
2.43.0

