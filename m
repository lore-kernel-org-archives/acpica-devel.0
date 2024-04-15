Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A930129E8D
	for <acpica-devel@lists.linux.dev>; Mon, 15 Apr 2024 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200599; cv=none; b=lu1tP8wsYdelBQmbsroAfYCz4AoiNaXXuiol/+KUN+SCFoYuSPcPWuIEZIkyB8c13zeRiBP6co23Zg7l9knbYGQTE/+rzI2yQMEjQazDGJJ49BC2N0lqT0mJcn7Ef7f59YYDiJPVLXJw3WHWtE3Lou1ZfSdZmv29EgawNv0/ot0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200599; c=relaxed/simple;
	bh=1ZQDs7+ZHziGzcARzxbD4/Mg73gTUDQb9qq/sbtrJ1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M7ekldctxOzuqXto1Nj7GZ9fVLSsmGKSRvRPnMDO6a2YgVIehhv1qxfqgI7EaoituNHBPm5WX1EUZP6RW+M7OAYZe4e240HhZApF3WA4VxVReTY2EVrG1caW/T09RwVU4Uyj01lzoGc/yam2tZjCxK1DUNP+KqPdOkhTUBUlG8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=WHQdoP/z; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="WHQdoP/z"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6eddff25e4eso2893451b3a.3
        for <acpica-devel@lists.linux.dev>; Mon, 15 Apr 2024 10:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713200598; x=1713805398; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ThUaZ42acH6gIoHt/Xyyai1xsGISjU0BkoEw/XHj/Ns=;
        b=WHQdoP/zutPXd8Eg1Lwrcbo7y5aWN6YyQXGxRXiQLYy6qq9WiWN7MvUoVz6h94NduB
         S71sK1O1WbcYxG4n5PvwQRIQ6rsjAMxm11Wc+lHevpqAR1BJzkclCxSUavX+g/MKKpUc
         lyaFxFrNxknoxXagjVlGrPcz53iHpwpzr/PkBmzHRn8r5DpXVvhCkLT/kp5yhyOkIQGe
         z01XmJyNHCp0YIljQ8ih6JMbX+gllyl+kTqC3eBkpaiC9eIw0CQORnxwpMDbkXqpXlWP
         B88GrK6pyoUKjwdEqaQ3cABIxY7c/uPhrxgIFB+lQ27vgPyD5xnLH+w+THrqLmbAu0vq
         Y4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200598; x=1713805398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThUaZ42acH6gIoHt/Xyyai1xsGISjU0BkoEw/XHj/Ns=;
        b=kvpM4CixUww3ESaUcffUXsU2Lq21uvV4SL/ScrUhXrQiXEhrxRNta4S+UXnhrilT0N
         sRjT7tOMnOcO+y2NsNu06zd4U71YaJBx6sx0egqqpu+Sp+9ba2yiMgtNIjARZFDA75aK
         IquYYdXIVDomP5yOIixcJ6z4w92n2xe0oXuxubV5wtowrqDStz3aIny5qagHJMYc9kJP
         NBzbdQMDBv7xQ60OT574mg0TKQGm34jmyDKgjs/TXaAnS3ZQhbSGr0+OO0MVtBhIiFD9
         SfOkSkPqxbftNscOoGWoV+r6JjbG3Xm88L7A5FDR9+khOmTFG2CaGDnKwUL0zIr0wWqu
         t/kw==
X-Forwarded-Encrypted: i=1; AJvYcCUM8dPdpJ+6P3t149OzD1I/wz2ryR3l02Tbg2zIHPjzEHHbz8IMqYI7Ve/CXmb2n+8AF5RkgYYLq1JWvggh7gc9M7SnEl2alQ7jf4pA
X-Gm-Message-State: AOJu0YzNGDj2iK5w7/OBaowLIj859FU5XSq70BorZg+Y7QbB5ugsb3CS
	UZQf6U4Eo0NlHNjcDgtC38xh/2Xq083gCArnlJFBtnnQbRN4HARSlszGl3o1rBo=
X-Google-Smtp-Source: AGHT+IHhuE17NgEEPGD23nh5CnQ5veXRbEyfj/0HGrVBsvBO1xoLfPY+OSt88142jHvtos+eqeLYfg==
X-Received: by 2002:a05:6a00:391c:b0:6ec:f5d2:f6be with SMTP id fh28-20020a056a00391c00b006ecf5d2f6bemr10232711pfb.1.1713200597605;
        Mon, 15 Apr 2024 10:03:17 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm7433158pfm.25.2024.04.15.10.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:03:17 -0700 (PDT)
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
Subject: [RFC PATCH v4 17/20] irqchip: irq-sifive-plic: Add ACPI support
Date: Mon, 15 Apr 2024 22:31:10 +0530
Message-Id: <20240415170113.662318-18-sunilvl@ventanamicro.com>
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

Add ACPI support in PLIC driver. Use the mapping created early during
boot to get details about the PLIC.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Co-developed-by: Haibo Xu <haibo1.xu@intel.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 drivers/irqchip/irq-sifive-plic.c | 89 +++++++++++++++++++++++--------
 1 file changed, 68 insertions(+), 21 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index f3d4cb9e34f7..5fa45701ea24 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2017 SiFive
  * Copyright (C) 2018 Christoph Hellwig
  */
+#include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -70,6 +71,8 @@ struct plic_priv {
 	unsigned long plic_quirks;
 	unsigned int nr_irqs;
 	unsigned long *prio_save;
+	u32 gsi_base;
+	int id;
 };
 
 struct plic_handler {
@@ -327,6 +330,10 @@ static int plic_irq_domain_translate(struct irq_domain *d,
 {
 	struct plic_priv *priv = d->host_data;
 
+	/* For DT, gsi_base is always zero. */
+	if (fwspec->param[0] >= priv->gsi_base)
+		fwspec->param[0] = fwspec->param[0] - priv->gsi_base;
+
 	if (test_bit(PLIC_QUIRK_EDGE_INTERRUPT, &priv->plic_quirks))
 		return irq_domain_translate_twocell(d, fwspec, hwirq, type);
 
@@ -427,18 +434,32 @@ static const struct of_device_id plic_match[] = {
 	{}
 };
 
+#ifdef CONFIG_ACPI
+
+static const struct acpi_device_id plic_acpi_match[] = {
+	{ "RSCV0001", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, plic_acpi_match);
+
+#endif
 static int plic_parse_nr_irqs_and_contexts(struct platform_device *pdev,
-					   u32 *nr_irqs, u32 *nr_contexts)
+					   u32 *nr_irqs, u32 *nr_contexts,
+					   u32 *gsi_base, u32 *id)
 {
 	struct device *dev = &pdev->dev;
 	int rc;
 
-	/*
-	 * Currently, only OF fwnode is supported so extend this
-	 * function for ACPI support.
-	 */
-	if (!is_of_node(dev->fwnode))
-		return -EINVAL;
+	if (!is_of_node(dev->fwnode)) {
+		riscv_acpi_get_gsi_info(dev->fwnode, gsi_base, id, nr_irqs, NULL);
+		acpi_get_plic_nr_contexts(*id, nr_contexts);
+		if (WARN_ON(!*nr_contexts)) {
+			dev_err(dev, "no PLIC context available\n");
+			return -EINVAL;
+		}
+
+		return 0;
+	}
 
 	rc = of_property_read_u32(to_of_node(dev->fwnode), "riscv,ndev", nr_irqs);
 	if (rc) {
@@ -452,23 +473,29 @@ static int plic_parse_nr_irqs_and_contexts(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
+	*gsi_base = 0;
+	*id = 0;
+
 	return 0;
 }
 
 static int plic_parse_context_parent(struct platform_device *pdev, u32 context,
-				     u32 *parent_hwirq, int *parent_cpu)
+				     u32 *parent_hwirq, int *parent_cpu, u32 id)
 {
 	struct device *dev = &pdev->dev;
 	struct of_phandle_args parent;
 	unsigned long hartid;
 	int rc;
 
-	/*
-	 * Currently, only OF fwnode is supported so extend this
-	 * function for ACPI support.
-	 */
-	if (!is_of_node(dev->fwnode))
-		return -EINVAL;
+	if (!is_of_node(dev->fwnode)) {
+		rc = acpi_get_ext_intc_parent_hartid(id, context, &hartid);
+		if (rc)
+			return rc;
+
+		*parent_cpu = riscv_hartid_to_cpuid(hartid);
+		*parent_hwirq = RV_IRQ_EXT;
+		return 0;
+	}
 
 	rc = of_irq_parse_one(to_of_node(dev->fwnode), context, &parent);
 	if (rc)
@@ -493,7 +520,9 @@ static int plic_probe(struct platform_device *pdev)
 	struct irq_domain *domain;
 	struct plic_priv *priv;
 	irq_hw_number_t hwirq;
+	int id, context_id;
 	bool cpuhp_setup;
+	u32 gsi_base;
 
 	if (is_of_node(dev->fwnode)) {
 		const struct of_device_id *id;
@@ -503,7 +532,7 @@ static int plic_probe(struct platform_device *pdev)
 			plic_quirks = (unsigned long)id->data;
 	}
 
-	error = plic_parse_nr_irqs_and_contexts(pdev, &nr_irqs, &nr_contexts);
+	error = plic_parse_nr_irqs_and_contexts(pdev, &nr_irqs, &nr_contexts, &gsi_base, &id);
 	if (error)
 		return error;
 
@@ -514,6 +543,8 @@ static int plic_probe(struct platform_device *pdev)
 	priv->dev = dev;
 	priv->plic_quirks = plic_quirks;
 	priv->nr_irqs = nr_irqs;
+	priv->gsi_base = gsi_base;
+	priv->id = id;
 
 	priv->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (WARN_ON(!priv->regs))
@@ -524,12 +555,22 @@ static int plic_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	for (i = 0; i < nr_contexts; i++) {
-		error = plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu);
+		error = plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu, priv->id);
 		if (error) {
 			dev_warn(dev, "hwirq for context%d not found\n", i);
 			continue;
 		}
 
+		if (is_of_node(dev->fwnode)) {
+			context_id = i;
+		} else {
+			error = acpi_get_plic_context(priv->id, i, &context_id);
+			if (error) {
+				dev_warn(dev, "invalid context id for context%d\n", i);
+				continue;
+			}
+		}
+
 		/*
 		 * Skip contexts other than external interrupts for our
 		 * privilege level.
@@ -575,10 +616,10 @@ static int plic_probe(struct platform_device *pdev)
 		cpumask_set_cpu(cpu, &priv->lmask);
 		handler->present = true;
 		handler->hart_base = priv->regs + CONTEXT_BASE +
-			i * CONTEXT_SIZE;
+			context_id * CONTEXT_SIZE;
 		raw_spin_lock_init(&handler->enable_lock);
 		handler->enable_base = priv->regs + CONTEXT_ENABLE_BASE +
-			i * CONTEXT_ENABLE_SIZE;
+			context_id * CONTEXT_ENABLE_SIZE;
 		handler->priv = priv;
 
 		handler->enable_save = devm_kcalloc(dev, DIV_ROUND_UP(nr_irqs, 32),
@@ -594,8 +635,8 @@ static int plic_probe(struct platform_device *pdev)
 		nr_handlers++;
 	}
 
-	priv->irqdomain = irq_domain_add_linear(to_of_node(dev->fwnode), nr_irqs + 1,
-						&plic_irqdomain_ops, priv);
+	priv->irqdomain = irq_domain_create_linear(dev->fwnode, nr_irqs + 1,
+						   &plic_irqdomain_ops, priv);
 	if (WARN_ON(!priv->irqdomain))
 		goto fail_cleanup_contexts;
 
@@ -622,13 +663,18 @@ static int plic_probe(struct platform_device *pdev)
 		}
 	}
 
+#ifdef CONFIG_ACPI
+	if (!acpi_disabled)
+		acpi_dev_clear_dependencies(ACPI_COMPANION(dev));
+#endif
+
 	dev_info(dev, "mapped %d interrupts with %d handlers for %d contexts.\n",
 		 nr_irqs, nr_handlers, nr_contexts);
 	return 0;
 
 fail_cleanup_contexts:
 	for (i = 0; i < nr_contexts; i++) {
-		if (plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu))
+		if (plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu, priv->id))
 			continue;
 		if (parent_hwirq != RV_IRQ_EXT || cpu < 0)
 			continue;
@@ -647,6 +693,7 @@ static struct platform_driver plic_driver = {
 	.driver = {
 		.name		= "riscv-plic",
 		.of_match_table	= plic_match,
+		.acpi_match_table = ACPI_PTR(plic_acpi_match),
 	},
 	.probe = plic_probe,
 };
-- 
2.40.1

