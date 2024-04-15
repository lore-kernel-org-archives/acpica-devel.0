Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0D212839E
	for <acpica-devel@lists.linux.dev>; Mon, 15 Apr 2024 17:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200579; cv=none; b=T8CY07MT3TtmWfBpNlAm2ejLVc35DfGCT+4IW4HFx+il4eM9c0KoeO04Qy7vq/fcIz4fzKtGVYUhJibJ5xaOGgNBEY0wNLugD98yRS7p9kQq+zGXinE6DqYE19Nrmb2LDojTizzBx2fe4sOl2Sk+MHI36jRBYtH+H42lFMgYx/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200579; c=relaxed/simple;
	bh=VKC1k90N2jxwUCKVmE1XZOYw+oqHJYrFO5SRt4yp4n8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TFl7SRXphyEaoNoUFuwaMkCnO6RrzAKK8u8d91mIfJ+LO30vHxgFLRIRV5HYt5eS30Dm1oEYDhEssw5toMCld8eVUYoAQKI38OoiUmmgJ/8Rjhccguf5M4Wg6G3Ae8RxGzOfdedtOGBIgLBJ4fuMQCEtFmZmQH5kF/+9dGVlaWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=BzbjilH2; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="BzbjilH2"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ee12766586so2244354b3a.0
        for <acpica-devel@lists.linux.dev>; Mon, 15 Apr 2024 10:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713200577; x=1713805377; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tESHp1nipL9G+lPho1WiqoKvdd8aCfbVHrPrMY3qcLM=;
        b=BzbjilH27njh5jXPzNiCYnNay+r/MJz2lfev3hRG9lmkyx4vnYr8lmWD2hovFVRibl
         myTamry2ASI9nhCw/r4egK3ANuVQ8SSwTJdCg01Rj4+EvtXKg8P2Y7Ta1g/2HRoaiXdy
         Km5MQMRVpSBH9RX0D9yrRbRm+q9NCznPWa3hYwLtuBFVURIAmn55q2ZLLOMkbKWLHD3t
         m263EdqZv6dFT0uV/1f57TZRuA2lb3KH9X+RAXkEiW03tc8EGXMonTQXnX6d5bK7St8s
         84DGFMZyn3rJ4RqMXX4B/ePNHaF+RSCrPTsEfszd+C1TQhXhwwS2Z2lfSmLeufm1eaJT
         dJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200577; x=1713805377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tESHp1nipL9G+lPho1WiqoKvdd8aCfbVHrPrMY3qcLM=;
        b=E27dccaSTznU7tIWyJDBSMf3iXoH96+86t6WTqN69Ae4LzE/6U6uOC6yM5N+zZCgPV
         9T16olU2uIKspL4Og8uVLQ7unk6DUFOYAbASGZeaGpg8e36as74riwYvkbosfspdcMcm
         YOwSB4Pxv7efCoeIeAd9F+XiZ4+2H4tvHQlJRMtAzgBBWgCv3JTbeTZZ8AkY8YdEaLSd
         0ffRrq8DhgibOX0u7oaRv6JPM74dUKQRgfJt3a5VfIXnC53CXy9N0PuahWw21i1xL608
         iL8GlGT/u57+pIMl60YWGt3QO5HoRigmDw63+Qkd2eM2/qD7sQFBLo5iUSFPLP9BW21Z
         qsQA==
X-Forwarded-Encrypted: i=1; AJvYcCVZomBmI0xsGjkbgVK7o1aMRt1pBTbjd76XbtKTXig2pag+PcmFwqvrGI9Q/hgjdsU6MKRhaeH8gKQNeyHhl21qVCaQtN9FGV8vPrEB
X-Gm-Message-State: AOJu0Yyjc10Sp18BWOktP1dTiFaSlotskJcnWrTp/hwYKyG7njnNH34K
	YIEYXMM1cH/UFWdqEfu3aCBG/BmfW2NuCAC0+RQ6koAIPxuY3KTMSo6glHRtabE=
X-Google-Smtp-Source: AGHT+IGv/kllMgrVV78cn82AbUpzbO7/wD1E9hz7AVE67lzYg6zXQKt3/FnejYjVAq0dkP07wI6buA==
X-Received: by 2002:a05:6a00:4611:b0:6ea:f3fb:26fe with SMTP id ko17-20020a056a00461100b006eaf3fb26femr305695pfb.12.1713200577636;
        Mon, 15 Apr 2024 10:02:57 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm7433158pfm.25.2024.04.15.10.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:02:57 -0700 (PDT)
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
Subject: [RFC PATCH v4 14/20] irqchip: riscv-intc: Add ACPI support for AIA
Date: Mon, 15 Apr 2024 22:31:07 +0530
Message-Id: <20240415170113.662318-15-sunilvl@ventanamicro.com>
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

The RINTC subtype structure in MADT also has information about other
interrupt controllers. Save this information and provide interfaces to
retrieve them when required by corresponding drivers.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/include/asm/irq.h     | 35 ++++++++++++
 drivers/irqchip/irq-riscv-intc.c | 97 +++++++++++++++++++++++++++++++-
 2 files changed, 130 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index 44a0b128c602..6bd578b1ffc9 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -25,9 +25,22 @@ enum riscv_irqchip_type {
 	ACPI_RISCV_IRQCHIP_APLIC	= 0x03,
 };
 
+/*
+ * The ext_intc_id format is as follows:
+ * Bits [31:24] APLIC/PLIC ID
+ * Bits [15:0] APLIC IDC ID / PLIC S-Mode Context ID for this hart
+ */
+#define APLIC_PLIC_ID(x) ((x) >> 24)
+#define IDC_CONTEXT_ID(x) ((x) & 0x0000ffff)
+
 int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, u32 *gsi_base,
 			    u32 *id, u32 *nr_irqs, u32 *nr_idcs);
 struct fwnode_handle *riscv_acpi_get_gsi_domain_id(u32 gsi);
+int __init acpi_get_intc_index_hartid(u32 index, unsigned long *hartid);
+int acpi_get_ext_intc_parent_hartid(u8 id, u32 idx, unsigned long *hartid);
+void acpi_get_plic_nr_contexts(u8 id, int *nr_contexts);
+int acpi_get_plic_context(u8 id, u32 idx, int *context_id);
+int __init acpi_get_imsic_mmio_info(u32 index, struct resource *res);
 
 #else
 static inline int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, u32 *gsi_base,
@@ -36,6 +49,28 @@ static inline int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, u32 *gsi
 	return 0;
 }
 
+static inline int __init acpi_get_intc_index_hartid(u32 index, unsigned long *hartid)
+{
+	return -EINVAL;
+}
+
+static inline int acpi_get_ext_intc_parent_hartid(u8 id, u32 idx, unsigned long *hartid)
+{
+	return -EINVAL;
+}
+
+static inline void acpi_get_plic_nr_contexts(u8 id, int *nr_contexts) { }
+
+static inline int acpi_get_plic_context(u8 id, u32 idx, int *context_id)
+{
+	return -EINVAL;
+}
+
+static inline int __init acpi_get_imsic_mmio_info(u32 index, struct resource *res)
+{
+	return 0;
+}
+
 #endif /* CONFIG_ACPI */
 
 #endif /* _ASM_RISCV_IRQ_H */
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 9e71c4428814..b20272151aed 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -249,14 +249,101 @@ IRQCHIP_DECLARE(riscv, "riscv,cpu-intc", riscv_intc_init);
 IRQCHIP_DECLARE(andes, "andestech,cpu-intc", riscv_intc_init);
 
 #ifdef CONFIG_ACPI
+struct rintc_data {
+	u32 ext_intc_id;
+	unsigned long hart_id;
+	u64 imsic_addr;
+	u32 imsic_size;
+};
+
+static u32 nr_rintc;
+static struct rintc_data *rintc_acpi_data[NR_CPUS];
+
+int acpi_get_intc_index_hartid(u32 index, unsigned long *hartid)
+{
+	if (index >= nr_rintc)
+		return -1;
+
+	*hartid = rintc_acpi_data[index]->hart_id;
+	return 0;
+}
+
+int acpi_get_ext_intc_parent_hartid(u8 id, u32 idx, unsigned long *hartid)
+{
+	int i, j = 0;
+
+	for (i = 0; i < nr_rintc; i++) {
+		if (APLIC_PLIC_ID(rintc_acpi_data[i]->ext_intc_id) == id) {
+			if (idx == j) {
+				*hartid = rintc_acpi_data[i]->hart_id;
+				return 0;
+			}
+			j++;
+		}
+	}
+
+	return -1;
+}
+
+void acpi_get_plic_nr_contexts(u8 id, int *nr_contexts)
+{
+	int i, j = 0;
+
+	for (i = 0; i < nr_rintc; i++) {
+		if (APLIC_PLIC_ID(rintc_acpi_data[i]->ext_intc_id) == id)
+			j++;
+	}
+
+	*nr_contexts = j;
+}
+
+int acpi_get_plic_context(u8 id, u32 idx, int *context_id)
+{
+	int i, j = 0;
+
+	for (i = 0; i < nr_rintc; i++) {
+		if (APLIC_PLIC_ID(rintc_acpi_data[i]->ext_intc_id) == id) {
+			if (idx == j) {
+				*context_id = IDC_CONTEXT_ID(rintc_acpi_data[i]->ext_intc_id);
+				return 0;
+			}
+
+			j++;
+		}
+	}
+
+	return -1;
+}
+
+int acpi_get_imsic_mmio_info(u32 index, struct resource *res)
+{
+	if (index >= nr_rintc)
+		return -1;
+
+	res->start = rintc_acpi_data[index]->imsic_addr;
+	res->end = res->start + rintc_acpi_data[index]->imsic_size - 1;
+	res->flags = IORESOURCE_MEM;
+	return 0;
+}
+
 
 static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 				       const unsigned long end)
 {
-	struct fwnode_handle *fn;
 	struct acpi_madt_rintc *rintc;
+	struct fwnode_handle *fn;
+	int rc;
 
 	rintc = (struct acpi_madt_rintc *)header;
+	rintc_acpi_data[nr_rintc] = kzalloc(sizeof(*rintc_acpi_data[0]), GFP_KERNEL);
+	if (!rintc_acpi_data[nr_rintc])
+		return -ENOMEM;
+
+	rintc_acpi_data[nr_rintc]->ext_intc_id = rintc->ext_intc_id;
+	rintc_acpi_data[nr_rintc]->hart_id = rintc->hart_id;
+	rintc_acpi_data[nr_rintc]->imsic_addr = rintc->imsic_addr;
+	rintc_acpi_data[nr_rintc]->imsic_size = rintc->imsic_size;
+	nr_rintc++;
 
 	/*
 	 * The ACPI MADT will have one INTC for each CPU (or HART)
@@ -273,7 +360,13 @@ static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 		return -ENOMEM;
 	}
 
-	return riscv_intc_init_common(fn, &riscv_intc_chip);
+	rc = riscv_intc_init_common(fn, &riscv_intc_chip);
+	if (rc) {
+		irq_domain_free_fwnode(fn);
+		return rc;
+	}
+
+	return 0;
 }
 
 IRQCHIP_ACPI_DECLARE(riscv_intc, ACPI_MADT_TYPE_RINTC, NULL,
-- 
2.40.1

