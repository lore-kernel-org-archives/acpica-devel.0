Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0530A1FBCB0
	for <acpica-devel@lists.linux.dev>; Wed, 14 May 2025 05:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747202277; cv=none; b=kRX2e9LJQph5DuKzJmY1YBNVRIx1WWjQSgsOMr0Mu0VTXPgrBhphWWNYn/hembkZ0okl8dCngCuO/nILRykyjKfjcHgA17HZHHf+dDE8pIaZGtXhCokyOnRgNifW55HGGrdC2PDpVfmZM5EcH40+ChFBSKj51ta2vxD5w8M/nyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747202277; c=relaxed/simple;
	bh=Tr1XOcL/8BhgssUXkqbsbVw45YsiIW9Uliv4Chah6tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cI/RPKtbwEdSswQsJrfxkMWmTbs7/iGqg7hNBoND6eGaVJsdjZi5dvZttHioknRZl7Y6hBHWZ7P/O0oHgWaWTTd6BfJC9+RRWRSgLlR+OT5yMMTI0Yvo4ilkPaQbmFeo2ZNcmv4u8aNGyvcr9c/1FKhrNJRRfbAS+/zowFv+bdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=KfTNo4+u; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="KfTNo4+u"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b200047a6a5so463663a12.0
        for <acpica-devel@lists.linux.dev>; Tue, 13 May 2025 22:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1747202275; x=1747807075; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbiDocnvP7/vIiwuy9W9uCrvaQAnUMotSiyx0gsvykM=;
        b=KfTNo4+ukmaXxw8E3O0puQNwakp9eWKOIlMKEhy/keS3StyuLR+o5oBsBT5zNZCtag
         MPZQdENa274yBrhQbdqLQ2SUVCD4rQWkprDfEx9vHVABducUC3hAuZBz5Q8QjHwPCMwr
         Ml73qP+yMS3xf/A9NMYSFOsygWrznp4ETxUqrnSnihkCdlCFjfYLjD4seuEpAFggj8ik
         zlvSfcpOXjD1jqI8B6nQ8dpjmBRK5iho21Mfk3s0lymeqqwAluw1JfFkl+YJIgCXJsAs
         h/pxQDvTfXN92NmbmGqmeycVslY6TQ+xFgqU7h1JaNpbZnBzQhN5YRh/wpUXiHmT41T7
         bMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747202275; x=1747807075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbiDocnvP7/vIiwuy9W9uCrvaQAnUMotSiyx0gsvykM=;
        b=t6hZkxALLMy3YFlDonjiC78qaKpa6zXlUt/CEk30EkLOJ3bDD44i2anUJPyb/wPfJM
         Y/Z6a+dSWCqujdY7a25aoVr/FCf7Af07EeZdH3jAk4K6JsOJ1IeMR14VWOpjxhNKQVVA
         hloavziiHfcKwCn3/62pH/eIBPSKvduI/ymS3pnqt/QsJ9jsEz4cMtU67C7svFPlB+bH
         +DTjRMOrk42zCWJno9JdJg0yPO1mudFpirPXIcJTDxevhhXabQTtR9hty3/kG9BtUOLl
         h6hzD5o4lnKvNemugTBMFJx+Jm41+NYayAB0RXLFU0Jq1f8LC0HSOydEHMRiCYZjfz+U
         huhg==
X-Forwarded-Encrypted: i=1; AJvYcCWhGu+pnLQr1AycCmN08hDT417GnXnDB0HS+KInjQxSM+/Iu69UuCNQiFk4OYeuIrHcDIDumk9y0AHWpG8=@lists.linux.dev
X-Gm-Message-State: AOJu0YwKa8U36MesMiNN9Ua5SGJLTxtB6Bha3tZt1d9HjMYPWsP9j0Q5
	eIz9W5qFOoapYMPNTSeFX52d8Uxkc7qhBR7nnNet+CtDuhuZeOY7cU3QJayCk5g=
X-Gm-Gg: ASbGncsfhgpK5PRQwJ8g2mRfgpV9sEZgbk6dGDlcQquOb7ukiibmHh+E03WHBtnFKXn
	Z9TqsRiwuthzLYmj93SvCdX7WwQsyxIcQNJNxGGUMyg49yZDIxZKw2MK+mkY0O2vVvAFIuqTy9+
	SS5rUdLaWbZbruZ9x9ALvSli1jPKsbXh6Mzq1vzahLx87rKpmUkgHv/QuQajD3soiQJ4d+4H/hq
	2oDLycMFOzSvp1IsUUq+VuvBOm/fzPuI9m5hxYc/rUnos1izusivPYB4WYGv2gRIOHiZ3PPp/h6
	1JXVy4HXzqcoLUIJoGF5/O3/9FPNOl0oMxrBHToT6ia5E3YUrPLkZwfzGKpqSA==
X-Google-Smtp-Source: AGHT+IGgGwlhXhb97hz7G/rQ5hnEoBLy0AHEplWytso8kcAajszMRL1hQAHqjtumZAwOWQTJC9TsUw==
X-Received: by 2002:a17:903:32d1:b0:223:807f:7f92 with SMTP id d9443c01a7336-2317cb4f087mr83654885ad.20.1747202275325;
        Tue, 13 May 2025 22:57:55 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.196.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc8271c2dsm91721615ad.135.2025.05.13.22.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 22:57:54 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev,
	acpica-devel@lists.linux.dev
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 4/4] iommu/riscv: Add ACPI support
Date: Wed, 14 May 2025 11:27:23 +0530
Message-ID: <20250514055723.1328557-5-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250514055723.1328557-1-sunilvl@ventanamicro.com>
References: <20250514055723.1328557-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V IO Mapping Table (RIMT) provides the information about the IOMMU
to the OS in ACPI. Add support for ACPI in RISC-V IOMMU drivers by using
RIMT data.

The changes at high level are,

a) Register the IOMMU with RIMT data structures.
b) Enable probing of platform IOMMU in ACPI way using the ACPIID defined
   for the RISC-V IOMMU in the BRS spec [1]. Configure the MSI domain if
   the platform IOMMU uses MSIs.

[1] - https://github.com/riscv-non-isa/riscv-brs/blob/main/acpi-id.adoc

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/iommu/riscv/iommu-platform.c | 17 ++++++++++++++++-
 drivers/iommu/riscv/iommu.c          | 10 ++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/iommu-platform.c
index 725e919b97ef..83a28c83f991 100644
--- a/drivers/iommu/riscv/iommu-platform.c
+++ b/drivers/iommu/riscv/iommu-platform.c
@@ -10,6 +10,8 @@
  *	Tomasz Jeznach <tjeznach@rivosinc.com>
  */
 
+#include <linux/acpi.h>
+#include <linux/irqchip/riscv-imsic.h>
 #include <linux/kernel.h>
 #include <linux/msi.h>
 #include <linux/of_irq.h>
@@ -46,6 +48,7 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
 	enum riscv_iommu_igs_settings igs;
 	struct device *dev = &pdev->dev;
 	struct riscv_iommu_device *iommu = NULL;
+	struct irq_domain *msi_domain;
 	struct resource *res = NULL;
 	int vec, ret;
 
@@ -76,8 +79,13 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
 	switch (igs) {
 	case RISCV_IOMMU_CAPABILITIES_IGS_BOTH:
 	case RISCV_IOMMU_CAPABILITIES_IGS_MSI:
-		if (is_of_node(dev->fwnode))
+		if (is_of_node(dev_fwnode(dev))) {
 			of_msi_configure(dev, to_of_node(dev->fwnode));
+		} else {
+			msi_domain = irq_find_matching_fwnode(imsic_acpi_get_fwnode(dev),
+							      DOMAIN_BUS_PLATFORM_MSI);
+			dev_set_msi_domain(dev, msi_domain);
+		}
 
 		if (!dev_get_msi_domain(dev)) {
 			dev_warn(dev, "failed to find an MSI domain\n");
@@ -150,6 +158,12 @@ static const struct of_device_id riscv_iommu_of_match[] = {
 	{},
 };
 
+static const struct acpi_device_id riscv_iommu_acpi_match[] = {
+	{ "RSCV0004", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, riscv_iommu_acpi_match);
+
 static struct platform_driver riscv_iommu_platform_driver = {
 	.probe = riscv_iommu_platform_probe,
 	.remove = riscv_iommu_platform_remove,
@@ -158,6 +172,7 @@ static struct platform_driver riscv_iommu_platform_driver = {
 		.name = "riscv,iommu",
 		.of_match_table = riscv_iommu_of_match,
 		.suppress_bind_attrs = true,
+		.acpi_match_table = riscv_iommu_acpi_match,
 	},
 };
 
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 8f049d4a0e2c..e51af4ba54a8 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -12,6 +12,8 @@
 
 #define pr_fmt(fmt) "riscv-iommu: " fmt
 
+#include <linux/acpi.h>
+#include <linux/acpi_rimt.h>
 #include <linux/compiler.h>
 #include <linux/crash_dump.h>
 #include <linux/init.h>
@@ -1650,6 +1652,14 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 		goto err_iodir_off;
 	}
 
+	if (!acpi_disabled) {
+		rc = rimt_iommu_register(iommu->dev);
+		if (rc) {
+			dev_err_probe(iommu->dev, rc, "cannot register iommu with RIMT\n");
+			goto err_remove_sysfs;
+		}
+	}
+
 	rc = iommu_device_register(&iommu->iommu, &riscv_iommu_ops, iommu->dev);
 	if (rc) {
 		dev_err_probe(iommu->dev, rc, "cannot register iommu interface\n");
-- 
2.43.0

