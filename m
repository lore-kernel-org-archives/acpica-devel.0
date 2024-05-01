Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8AE12AAF7
	for <acpica-devel@lists.linux.dev>; Wed,  1 May 2024 12:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714565979; cv=none; b=FiV9apmwKaVEGC6COilis3weSgzLkrI4AJ8lYdcf9wY4spJlbJQ8eZ59ef2cS00Ya1jMkESu8/YPtqTwire0DOfZKTB4GByoB/oPVweSjHkRJzQDFavuWk5GZ105+I1/rdgK9sIlLHKCh4FafrGBZjjs4ubu/fd4YgrE30fo/hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714565979; c=relaxed/simple;
	bh=qhqCGi8o9IAINNxfLRxMEmmSPodYgvrNH462+zJ18l4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r3/wnCmiNoK71aCujBGKBY8Iy0hkp/N8k0Q5+eiY6BarV7X0jkuGBcfoigghmtnkWCx0Z5Qz0Z0tUxxu70lBGqvBjT7lfA2w0Yjy8Ry1J84T5Hwlt8p0UJQIjuSiMJyc+Cm33lvPfEb/mN5kx6uhD2u1MpQ8mEdlGiMP3KDp0q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=kf+t3etg; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="kf+t3etg"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1eab699fcddso52724465ad.0
        for <acpica-devel@lists.linux.dev>; Wed, 01 May 2024 05:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714565977; x=1715170777; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BG93T+gcNC0mbkbP77au2VNz1Cnxnueu2TjA3uMrqLg=;
        b=kf+t3etgTGLM6YUv23PKos1cayNq6X7e5z1M/dIspXUCsxlGpdy9l9xwP0acboHnaA
         QkD8/SRWJOl/7E1rkhkNb62MGeGiViLXEo5qFq7VFCnifp8z+9ZNHvSRChbO9G+SsXm2
         wTe87LFO4ZkfcAhsZd92qq1Tnk2eJeO4UML5J7HdOtENzh5HUWDEvAJT9u3TW+ruoqbQ
         OGMH7hi7jQEw/oANk3ZltruSR+XMTyZ6+ZTd12l4hbmr0IO1dj5knwy5bMOv/jGpULoH
         kJmDAEUPipUBCWZXvImtOacFU0fPnaXgxC1eaE++FKWZH/GJAq5MVwZubb3Nkyf2knrX
         Z+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714565977; x=1715170777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BG93T+gcNC0mbkbP77au2VNz1Cnxnueu2TjA3uMrqLg=;
        b=Z8GRpZ0H7GM3NKX1MPm1tYl6CbVqyTDNCMqxWRGZ07uHCCEnZpRLfT8X6+V9U3qdJ4
         F2gpsee9+3yi6wLWxendlNx4KndfN97+Mz1/1AFSuQgLS2V5aiRfA5xQC2GGCkHaQd4U
         OZgBHBmpKZhJb4W4nYMw/30N3pFI4IMCLzWMJIlqkeul9CRiw5VnT/Si/agvvCYWLEdr
         8z82KFqIDknxsRea7KAhN+yMxZO5g54lR1d3xjNHX08o7/XgmtO71aah4sNDQJO31/oB
         gdKNePyEanVirERL4SCZdkeZs5o2xU7KK+hp5dvIrKOULYfuxHcsffhzwB9o6SuEw4RA
         q2zw==
X-Forwarded-Encrypted: i=1; AJvYcCVktJOwvZmIx5/Hu1JeAEgrAnHaLI2daF4DMiM3HUWP0ALaMPB3OUJOkcYCiWONNogxsuhGkKIx7y+oeV4jTgUd6SEaauAP6lqGm0M8
X-Gm-Message-State: AOJu0YwAF+KrZY5998B74/CdkJ14VDtSni/8fZRzdYEzsKxE6wjoHwmY
	uTLOwMsr4v0vG3yKkiaVnubDV/OhnVZDeq3Ohibi+8D6KhlkTsIwx7gRWFEaeB8=
X-Google-Smtp-Source: AGHT+IGLOIZZtL2TIDSeb766WeGWfcN19Dx07RhHbWbDtJL/7Xyje2/Url/yzqxWmbrfaaNC2lVwOw==
X-Received: by 2002:a17:902:eecc:b0:1eb:2988:549d with SMTP id h12-20020a170902eecc00b001eb2988549dmr2035967plb.40.1714565977219;
        Wed, 01 May 2024 05:19:37 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.106])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001ec8888b22esm1336900plb.65.2024.05.01.05.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 05:19:36 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v5 12/17] ACPI: RISC-V: Implement function to add implicit dependencies
Date: Wed,  1 May 2024 17:47:37 +0530
Message-Id: <20240501121742.1215792-13-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V interrupt controllers for wired interrupts are platform devices
and hence their driver will be probed late. Also, APLIC which is one
such interrupt controller can not be probed early since it needs MSI
services. This needs a probing order between the interrupt controller
driver and the device drivers.

_DEP is typically used to indicate such dependencies. However, the
dependency may be already available like GSI mapping. Hence, instead of
an explicit _DEP, architecture can find the implicit dependencies and
add to the dependency list.

For RISC-V, add the dependencies for below use cases.

1) For devices which has IRQ resource, find out the interrupt controller
using GSI number map and add the dependency.

2) For PCI host bridges:
        a) If _PRT indicate PCI link devices, add dependency on the link
           device.
        b) If _PRT indicates GSI, find out the interrupt controller
           using GSI number map and add the dependency.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/riscv/irq.c | 155 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
index 0473428e8d1e..2878ae48131f 100644
--- a/drivers/acpi/riscv/irq.c
+++ b/drivers/acpi/riscv/irq.c
@@ -21,6 +21,12 @@ struct riscv_ext_intc_list {
 	struct list_head list;
 };
 
+struct acpi_irq_dep_ctx {
+	int rc;
+	unsigned int index;
+	acpi_handle handle;
+};
+
 LIST_HEAD(ext_intc_list);
 
 static int irqchip_cmp_func(const void *in0, const void *in1)
@@ -62,6 +68,21 @@ static void riscv_acpi_update_gsi_handle(u32 gsi_base, acpi_handle handle)
 	acpi_handle_err(handle, "failed to find the GSI mapping entry\n");
 }
 
+static acpi_handle riscv_acpi_get_gsi_handle(u32 gsi)
+{
+	struct riscv_ext_intc_list *ext_intc_element;
+	struct list_head *i, *tmp;
+
+	list_for_each_safe(i, tmp, &ext_intc_list) {
+		ext_intc_element = list_entry(i, struct riscv_ext_intc_list, list);
+		if (gsi >= ext_intc_element->gsi_base &&
+		    gsi < (ext_intc_element->gsi_base + ext_intc_element->nr_irqs))
+			return ext_intc_element->handle;
+	}
+
+	return NULL;
+}
+
 int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, u32 *gsi_base,
 			    u32 *id, u32 *nr_irqs, u32 *nr_idcs)
 {
@@ -172,3 +193,137 @@ void __init riscv_acpi_init_gsi_mapping(void)
 	if (acpi_table_parse_madt(ACPI_MADT_TYPE_APLIC, riscv_acpi_aplic_parse_madt, 0) > 0)
 		acpi_get_devices("RSCV0002", riscv_acpi_create_gsi_map, NULL, NULL);
 }
+
+static acpi_status riscv_acpi_irq_get_parent(struct acpi_resource *ares, void *context)
+{
+	struct acpi_irq_dep_ctx *ctx = context;
+	struct acpi_resource_irq *irq;
+	struct acpi_resource_extended_irq *eirq;
+
+	switch (ares->type) {
+	case ACPI_RESOURCE_TYPE_IRQ:
+		irq = &ares->data.irq;
+		if (ctx->index >= irq->interrupt_count) {
+			ctx->index -= irq->interrupt_count;
+			return AE_OK;
+		}
+		ctx->handle = riscv_acpi_get_gsi_handle(irq->interrupts[ctx->index]);
+		return AE_CTRL_TERMINATE;
+	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
+		eirq = &ares->data.extended_irq;
+		if (eirq->producer_consumer == ACPI_PRODUCER)
+			return AE_OK;
+
+		if (ctx->index >= eirq->interrupt_count) {
+			ctx->index -= eirq->interrupt_count;
+			return AE_OK;
+		}
+
+		/* Support GSIs only */
+		if (eirq->resource_source.string_length)
+			return AE_OK;
+
+		ctx->handle = riscv_acpi_get_gsi_handle(eirq->interrupts[ctx->index]);
+		return AE_CTRL_TERMINATE;
+	}
+
+	return AE_OK;
+}
+
+static int riscv_acpi_irq_get_dep(acpi_handle handle, unsigned int index, acpi_handle *gsi_handle)
+{
+	struct acpi_irq_dep_ctx ctx = {-EINVAL, index, NULL};
+
+	if (!gsi_handle)
+		return 0;
+
+	acpi_walk_resources(handle, METHOD_NAME__CRS, riscv_acpi_irq_get_parent, &ctx);
+	*gsi_handle = ctx.handle;
+	if (*gsi_handle)
+		return 1;
+
+	return 0;
+}
+
+static u32 riscv_acpi_add_prt_dep(acpi_handle handle)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_pci_routing_table *entry;
+	struct acpi_handle_list dep_devices;
+	acpi_handle gsi_handle;
+	acpi_handle link_handle;
+	acpi_status status;
+	u32 count = 0;
+
+	status = acpi_get_irq_routing_table(handle, &buffer);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_err(handle, "failed to get IRQ routing table\n");
+		kfree(buffer.pointer);
+		return 0;
+	}
+
+	entry = buffer.pointer;
+	while (entry && (entry->length > 0)) {
+		if (entry->source[0]) {
+			acpi_get_handle(handle, entry->source, &link_handle);
+			dep_devices.count = 1;
+			dep_devices.handles = kcalloc(1, sizeof(*dep_devices.handles), GFP_KERNEL);
+			if (!dep_devices.handles) {
+				acpi_handle_err(handle, "failed to allocate memory\n");
+				continue;
+			}
+
+			dep_devices.handles[0] = link_handle;
+			count += acpi_scan_add_dep(handle, &dep_devices);
+		} else {
+			gsi_handle = riscv_acpi_get_gsi_handle(entry->source_index);
+			dep_devices.count = 1;
+			dep_devices.handles = kcalloc(1, sizeof(*dep_devices.handles), GFP_KERNEL);
+			if (!dep_devices.handles) {
+				acpi_handle_err(handle, "failed to allocate memory\n");
+				continue;
+			}
+
+			dep_devices.handles[0] = gsi_handle;
+			count += acpi_scan_add_dep(handle, &dep_devices);
+		}
+
+		entry = (struct acpi_pci_routing_table *)
+			((unsigned long)entry + entry->length);
+	}
+
+	kfree(buffer.pointer);
+	return count;
+}
+
+static u32 riscv_acpi_add_irq_dep(acpi_handle handle)
+{
+	struct acpi_handle_list dep_devices;
+	acpi_handle gsi_handle;
+	u32 count = 0;
+	int i;
+
+	for (i = 0;
+	     riscv_acpi_irq_get_dep(handle, i, &gsi_handle);
+	     i++) {
+		dep_devices.count = 1;
+		dep_devices.handles = kcalloc(1, sizeof(*dep_devices.handles), GFP_KERNEL);
+		if (!dep_devices.handles) {
+			acpi_handle_err(handle, "failed to allocate memory\n");
+			continue;
+		}
+
+		dep_devices.handles[0] = gsi_handle;
+		count += acpi_scan_add_dep(handle, &dep_devices);
+	}
+
+	return count;
+}
+
+u32 arch_acpi_add_auto_dep(acpi_handle handle)
+{
+	if (acpi_has_method(handle, "_PRT"))
+		return riscv_acpi_add_prt_dep(handle);
+
+	return riscv_acpi_add_irq_dep(handle);
+}
-- 
2.40.1

