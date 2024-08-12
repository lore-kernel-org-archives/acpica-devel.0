Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781256FA8
	for <acpica-devel@lists.linux.dev>; Mon, 12 Aug 2024 00:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723424390; cv=none; b=TnJCUxpdllZvlIRhxYFvC0f/fD6cgS/TNZH7Qk3wqIWvRvbL9qa5QFCtWbRv3d6wYSIJk8Dp4s9o3s3/DBlTYSY0snQcyWGteBg4eLdeU/wdi1wThZu3PRsD/hUxXfb+XDjt8cM10tqEQrysQrOdUvtVWCE8pZKM0Mi/UC+oqJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723424390; c=relaxed/simple;
	bh=C+i0U6VGde+1v9kIi2tE1b1sf1jRuHcxIrWnNcHIpqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YDMqT6y9qovDrWdMTX18WhOJIo56CTgmO7yZU4IQ3rtfRhnlf9o0H9fgX7DOkrzEi2kycU/R9Km0f34zqPCXGTXPWbULLFXBR+d7VOHiZqAeHuxvqkrpMUugarSXELoLLAFzLROiOaJGj88jxay+IS+1zEKDgroDiyGsMl9g5gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=DC1z8xs9; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="DC1z8xs9"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-39728bbf949so14888235ab.3
        for <acpica-devel@lists.linux.dev>; Sun, 11 Aug 2024 17:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723424387; x=1724029187; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jeK3ESAUl7YxTE1Iy3jfhVYgTpS15SSq0iPGR06s9c=;
        b=DC1z8xs9hOFarISXDrq0j4TMx5Va8YISqwtpvUh/S3eNood0lv43L6kWwxocuJguM/
         IWH7Pq7OCxbg8ZVxGDoLnx4RyOL8CW1WKspg59b9MZCgPIdM+2aUkueCXLkdCYIyFKvp
         Ft4I0gzqJZpxnhGn1XeHWfFYSMyr4kFkQXzpYs/o/6yWwDDB1ACp+EcXtuocNFzbJPcA
         xKU1RDdYnmbvJXY5XXFkIlLzuL+n7fXveECwwOMd+2giEgyBWGcXkhPPqGaPSxNKlv6i
         oRZqUzrPNnnsEqlOCfvnR5LBkem1iu6x3JXjLAQZZYfqodJnWC21SL8/A7swIclEwFHQ
         cb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723424387; x=1724029187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jeK3ESAUl7YxTE1Iy3jfhVYgTpS15SSq0iPGR06s9c=;
        b=TbY2eRJW6h+qwkwHp0kaP+D4C6fAx5IrNaGK9sB6xqaV5o5plqJwepOZSZnX5zbQlM
         FpPMLzW+wLTRy/AM18fVc7JxpbTDS4BGtGhB401COr4o8ynhkSW5rscbJvMM+yrkiJVJ
         Dep5OW0Yv62yvZZNeTBJeCV4Hhu4R8nO3T3hGjBz9URnq1n5pq1gW3CSHgh+XKVMwbex
         zjhIY8NdhDQ+7QB4y0GcJPCjY59SAx4YtFHz74ue81oUy+OG6TWRYj5Cj23P0GscbTzp
         ZZ1QsNQEq1KtSkwTDFGJ64SpW2Z/Mc5WXpx0P+K8FnI9s8HotIAaTu2d+z9HrMyaK/Rh
         /toA==
X-Forwarded-Encrypted: i=1; AJvYcCWfKcbPrSic8wu+NBqpRVRBIwgjvENvSG1cPjgOR9CUpCMM9NoQqtJ8TFDkdWLTC5CPfNb+24IJ7Mejd5/jhcgQ1olxEDGBFG3UA2vW
X-Gm-Message-State: AOJu0YxIY9bgE2xxXwHV0+tSAPS03wjf36pftS+fZhcICPHMJDuyE7OI
	K4APs2LR/AbXsA/kHM4l5qGsb9W/o6kbBgef/XTPjh8u2oagdaNPV2/HKCvnjZc=
X-Google-Smtp-Source: AGHT+IFIiqNGjgTEsTyA01AhWlCd5/qrU642pe+8j8qsMImF8/xohIsj9BzQ1yvF+gyWEF8FJGTC6A==
X-Received: by 2002:a05:6e02:1a29:b0:398:81e9:3f9e with SMTP id e9e14a558f8ab-39b813345abmr101145885ab.12.1723424387549;
        Sun, 11 Aug 2024 17:59:47 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe8cbdcsm3074062a12.61.2024.08.11.17.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 17:59:47 -0700 (PDT)
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
Subject: [PATCH v8 01/17] arm64: PCI: Migrate ACPI related functions to pci-acpi.c
Date: Mon, 12 Aug 2024 06:29:13 +0530
Message-ID: <20240812005929.113499-2-sunilvl@ventanamicro.com>
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

The functions defined in arm64 for ACPI support are required
for RISC-V also. To avoid duplication, move these functions
to common location.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Will Deacon <will@kernel.org>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/arm64/kernel/pci.c | 191 ----------------------------------------
 drivers/pci/pci-acpi.c  | 182 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 182 insertions(+), 191 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index f872c57e9909..fd9a7bed83ce 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -6,28 +6,7 @@
  * Copyright (C) 2014 ARM Ltd.
  */
 
-#include <linux/acpi.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
 #include <linux/pci.h>
-#include <linux/pci-acpi.h>
-#include <linux/pci-ecam.h>
-#include <linux/slab.h>
-
-#ifdef CONFIG_ACPI
-/*
- * Try to assign the IRQ number when probing a new device
- */
-int pcibios_alloc_irq(struct pci_dev *dev)
-{
-	if (!acpi_disabled)
-		acpi_pci_irq_enable(dev);
-
-	return 0;
-}
-#endif
 
 /*
  * raw_pci_read/write - Platform-specific PCI config space access.
@@ -61,173 +40,3 @@ int pcibus_to_node(struct pci_bus *bus)
 EXPORT_SYMBOL(pcibus_to_node);
 
 #endif
-
-#ifdef CONFIG_ACPI
-
-struct acpi_pci_generic_root_info {
-	struct acpi_pci_root_info	common;
-	struct pci_config_window	*cfg;	/* config space mapping */
-};
-
-int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
-{
-	struct pci_config_window *cfg = bus->sysdata;
-	struct acpi_device *adev = to_acpi_device(cfg->parent);
-	struct acpi_pci_root *root = acpi_driver_data(adev);
-
-	return root->segment;
-}
-
-int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
-{
-	struct pci_config_window *cfg;
-	struct acpi_device *adev;
-	struct device *bus_dev;
-
-	if (acpi_disabled)
-		return 0;
-
-	cfg = bridge->bus->sysdata;
-
-	/*
-	 * On Hyper-V there is no corresponding ACPI device for a root bridge,
-	 * therefore ->parent is set as NULL by the driver. And set 'adev' as
-	 * NULL in this case because there is no proper ACPI device.
-	 */
-	if (!cfg->parent)
-		adev = NULL;
-	else
-		adev = to_acpi_device(cfg->parent);
-
-	bus_dev = &bridge->bus->dev;
-
-	ACPI_COMPANION_SET(&bridge->dev, adev);
-	set_dev_node(bus_dev, acpi_get_node(acpi_device_handle(adev)));
-
-	return 0;
-}
-
-static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
-{
-	struct resource_entry *entry, *tmp;
-	int status;
-
-	status = acpi_pci_probe_root_resources(ci);
-	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
-		if (!(entry->res->flags & IORESOURCE_WINDOW))
-			resource_list_destroy_entry(entry);
-	}
-	return status;
-}
-
-/*
- * Lookup the bus range for the domain in MCFG, and set up config space
- * mapping.
- */
-static struct pci_config_window *
-pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
-{
-	struct device *dev = &root->device->dev;
-	struct resource *bus_res = &root->secondary;
-	u16 seg = root->segment;
-	const struct pci_ecam_ops *ecam_ops;
-	struct resource cfgres;
-	struct acpi_device *adev;
-	struct pci_config_window *cfg;
-	int ret;
-
-	ret = pci_mcfg_lookup(root, &cfgres, &ecam_ops);
-	if (ret) {
-		dev_err(dev, "%04x:%pR ECAM region not found\n", seg, bus_res);
-		return NULL;
-	}
-
-	adev = acpi_resource_consumer(&cfgres);
-	if (adev)
-		dev_info(dev, "ECAM area %pR reserved by %s\n", &cfgres,
-			 dev_name(&adev->dev));
-	else
-		dev_warn(dev, FW_BUG "ECAM area %pR not reserved in ACPI namespace\n",
-			 &cfgres);
-
-	cfg = pci_ecam_create(dev, &cfgres, bus_res, ecam_ops);
-	if (IS_ERR(cfg)) {
-		dev_err(dev, "%04x:%pR error %ld mapping ECAM\n", seg, bus_res,
-			PTR_ERR(cfg));
-		return NULL;
-	}
-
-	return cfg;
-}
-
-/* release_info: free resources allocated by init_info */
-static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)
-{
-	struct acpi_pci_generic_root_info *ri;
-
-	ri = container_of(ci, struct acpi_pci_generic_root_info, common);
-	pci_ecam_free(ri->cfg);
-	kfree(ci->ops);
-	kfree(ri);
-}
-
-/* Interface called from ACPI code to setup PCI host controller */
-struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
-{
-	struct acpi_pci_generic_root_info *ri;
-	struct pci_bus *bus, *child;
-	struct acpi_pci_root_ops *root_ops;
-	struct pci_host_bridge *host;
-
-	ri = kzalloc(sizeof(*ri), GFP_KERNEL);
-	if (!ri)
-		return NULL;
-
-	root_ops = kzalloc(sizeof(*root_ops), GFP_KERNEL);
-	if (!root_ops) {
-		kfree(ri);
-		return NULL;
-	}
-
-	ri->cfg = pci_acpi_setup_ecam_mapping(root);
-	if (!ri->cfg) {
-		kfree(ri);
-		kfree(root_ops);
-		return NULL;
-	}
-
-	root_ops->release_info = pci_acpi_generic_release_info;
-	root_ops->prepare_resources = pci_acpi_root_prepare_resources;
-	root_ops->pci_ops = (struct pci_ops *)&ri->cfg->ops->pci_ops;
-	bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
-	if (!bus)
-		return NULL;
-
-	/* If we must preserve the resource configuration, claim now */
-	host = pci_find_host_bridge(bus);
-	if (host->preserve_config)
-		pci_bus_claim_resources(bus);
-
-	/*
-	 * Assign whatever was left unassigned. If we didn't claim above,
-	 * this will reassign everything.
-	 */
-	pci_assign_unassigned_root_bus_resources(bus);
-
-	list_for_each_entry(child, &bus->children, node)
-		pcie_bus_configure_settings(child);
-
-	return bus;
-}
-
-void pcibios_add_bus(struct pci_bus *bus)
-{
-	acpi_pci_add_bus(bus);
-}
-
-void pcibios_remove_bus(struct pci_bus *bus)
-{
-	acpi_pci_remove_bus(bus);
-}
-
-#endif
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 9cc447da9475..8ed81a373bd7 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -15,6 +15,7 @@
 #include <linux/pci_hotplug.h>
 #include <linux/module.h>
 #include <linux/pci-acpi.h>
+#include <linux/pci-ecam.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_qos.h>
 #include <linux/rwsem.h>
@@ -1541,3 +1542,184 @@ static int __init acpi_pci_init(void)
 	return 0;
 }
 arch_initcall(acpi_pci_init);
+
+#if defined(CONFIG_ARM64)
+
+/*
+ * Try to assign the IRQ number when probing a new device
+ */
+int pcibios_alloc_irq(struct pci_dev *dev)
+{
+	if (!acpi_disabled)
+		acpi_pci_irq_enable(dev);
+
+	return 0;
+}
+
+struct acpi_pci_generic_root_info {
+	struct acpi_pci_root_info	common;
+	struct pci_config_window	*cfg;	/* config space mapping */
+};
+
+int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+	struct acpi_device *adev = to_acpi_device(cfg->parent);
+	struct acpi_pci_root *root = acpi_driver_data(adev);
+
+	return root->segment;
+}
+
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	struct pci_config_window *cfg;
+	struct acpi_device *adev;
+	struct device *bus_dev;
+
+	if (acpi_disabled)
+		return 0;
+
+	cfg = bridge->bus->sysdata;
+
+	/*
+	 * On Hyper-V there is no corresponding ACPI device for a root bridge,
+	 * therefore ->parent is set as NULL by the driver. And set 'adev' as
+	 * NULL in this case because there is no proper ACPI device.
+	 */
+	if (!cfg->parent)
+		adev = NULL;
+	else
+		adev = to_acpi_device(cfg->parent);
+
+	bus_dev = &bridge->bus->dev;
+
+	ACPI_COMPANION_SET(&bridge->dev, adev);
+	set_dev_node(bus_dev, acpi_get_node(acpi_device_handle(adev)));
+
+	return 0;
+}
+
+static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
+{
+	struct resource_entry *entry, *tmp;
+	int status;
+
+	status = acpi_pci_probe_root_resources(ci);
+	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
+		if (!(entry->res->flags & IORESOURCE_WINDOW))
+			resource_list_destroy_entry(entry);
+	}
+	return status;
+}
+
+/*
+ * Lookup the bus range for the domain in MCFG, and set up config space
+ * mapping.
+ */
+static struct pci_config_window *
+pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
+{
+	struct device *dev = &root->device->dev;
+	struct resource *bus_res = &root->secondary;
+	u16 seg = root->segment;
+	const struct pci_ecam_ops *ecam_ops;
+	struct resource cfgres;
+	struct acpi_device *adev;
+	struct pci_config_window *cfg;
+	int ret;
+
+	ret = pci_mcfg_lookup(root, &cfgres, &ecam_ops);
+	if (ret) {
+		dev_err(dev, "%04x:%pR ECAM region not found\n", seg, bus_res);
+		return NULL;
+	}
+
+	adev = acpi_resource_consumer(&cfgres);
+	if (adev)
+		dev_info(dev, "ECAM area %pR reserved by %s\n", &cfgres,
+			 dev_name(&adev->dev));
+	else
+		dev_warn(dev, FW_BUG "ECAM area %pR not reserved in ACPI namespace\n",
+			 &cfgres);
+
+	cfg = pci_ecam_create(dev, &cfgres, bus_res, ecam_ops);
+	if (IS_ERR(cfg)) {
+		dev_err(dev, "%04x:%pR error %ld mapping ECAM\n", seg, bus_res,
+			PTR_ERR(cfg));
+		return NULL;
+	}
+
+	return cfg;
+}
+
+/* release_info: free resources allocated by init_info */
+static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)
+{
+	struct acpi_pci_generic_root_info *ri;
+
+	ri = container_of(ci, struct acpi_pci_generic_root_info, common);
+	pci_ecam_free(ri->cfg);
+	kfree(ci->ops);
+	kfree(ri);
+}
+
+/* Interface called from ACPI code to setup PCI host controller */
+struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
+{
+	struct acpi_pci_generic_root_info *ri;
+	struct pci_bus *bus, *child;
+	struct acpi_pci_root_ops *root_ops;
+	struct pci_host_bridge *host;
+
+	ri = kzalloc(sizeof(*ri), GFP_KERNEL);
+	if (!ri)
+		return NULL;
+
+	root_ops = kzalloc(sizeof(*root_ops), GFP_KERNEL);
+	if (!root_ops) {
+		kfree(ri);
+		return NULL;
+	}
+
+	ri->cfg = pci_acpi_setup_ecam_mapping(root);
+	if (!ri->cfg) {
+		kfree(ri);
+		kfree(root_ops);
+		return NULL;
+	}
+
+	root_ops->release_info = pci_acpi_generic_release_info;
+	root_ops->prepare_resources = pci_acpi_root_prepare_resources;
+	root_ops->pci_ops = (struct pci_ops *)&ri->cfg->ops->pci_ops;
+	bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
+	if (!bus)
+		return NULL;
+
+	/* If we must preserve the resource configuration, claim now */
+	host = pci_find_host_bridge(bus);
+	if (host->preserve_config)
+		pci_bus_claim_resources(bus);
+
+	/*
+	 * Assign whatever was left unassigned. If we didn't claim above,
+	 * this will reassign everything.
+	 */
+	pci_assign_unassigned_root_bus_resources(bus);
+
+	list_for_each_entry(child, &bus->children, node)
+		pcie_bus_configure_settings(child);
+
+	return bus;
+}
+
+void pcibios_add_bus(struct pci_bus *bus)
+{
+	acpi_pci_add_bus(bus);
+}
+
+void pcibios_remove_bus(struct pci_bus *bus)
+{
+	acpi_pci_remove_bus(bus);
+}
+
+#endif
-- 
2.43.0

