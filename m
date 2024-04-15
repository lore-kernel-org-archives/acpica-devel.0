Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B53683CAE
	for <acpica-devel@lists.linux.dev>; Mon, 15 Apr 2024 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200619; cv=none; b=YbZOk0buoaTbFzQLJpJX6SNJ9+6m5JyJ3o3plET/PTb35HEfTDnZn8/pNBgb/eI8Cazo4qI7Lm6t3dmH3aKXri8f5HHelhx/tzABtAdMeH+lx0NDgwNOMdV7OyUwdFVDrmv9vUgru+NzO5qHbLUOr4E2evH1Da3i0PsXGCkcP14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200619; c=relaxed/simple;
	bh=egibTauTOK5De6SrAZsOC/2NVkpwGlv29Ym3R/RrsZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q2ptgCcrQrWAVkLYWUqOgaZ06hvgf+Wo03HkjpIoYvmvmH0x+TV606WXxYBBclZaihwQLBnVGC9VeQvlU53g1IgX3Pf5WT2qTGFWbktd1T5Ci+JIr4yBvWZnaCJZTOiyD5ICbdCrNQytW6mAIwIVcHaajV5Z1gy3AAtJCjLBPFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=X2W046K0; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="X2W046K0"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ecf05fd12fso3345213b3a.2
        for <acpica-devel@lists.linux.dev>; Mon, 15 Apr 2024 10:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713200618; x=1713805418; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4XnyCkVtMil3j8A/KjvpJf48jXr01BLYuVmlXnWMII=;
        b=X2W046K0hQXztBMrOlUgB4L4dWfJc9slKoLDrp4gobDRvAXMvaHmpwxlvB2JhHN+Xs
         iVcPwLYUcJOQoC6E9lDcbpcf/tXLOojL1UHghYeKtf5kXTljJmlrqWhFnzSE4VdLf8pP
         I2ae/0QIWTgspqGoEMsArCCXQYf3faWrx5lqX7i97aWYHMMw2Y4QFT3DBfFIBlZPnMTr
         cqbrNHVlyt5+yvqe+3dEwqQtAqYAmCwmjvd1cK3zse+1mhD4m0V9NlM1WcJK4ncbIkF/
         SUhUHPHA6vc9z6fpiVi1XgWihUorobZdcl21xYP3OKpB6sYVIX4nlZYQszcWgNDuA5N+
         vFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200618; x=1713805418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4XnyCkVtMil3j8A/KjvpJf48jXr01BLYuVmlXnWMII=;
        b=Y8W5TGzumeWu2Xl/B+pgLHrWFIjuk0G3vhiXOzSpcVvqqVEjQ1J9MaN38dRtEUjcnY
         X7JiCHpOQo92HeqUVay5U0oIo9saSEPUrecEhuzxjaY8JlZ44+vFybmvvepONYx8FcE3
         mWSJodCXkfmwlVIre3D/OAw6JPSo/c6VpgQuH9rbqpZZBTYnuxGr5sGLDjOr1CZEBo/J
         tfZIduEtr9bO7wxgqJaW7dAWspU003LU7wIbxkqeI2IUpjWUx2ibmB6hJ4EuuiJJRVzV
         kpZU3VMjRVFBPvwOPqSeN4Vk8fCVGS1mh/m4OQma9lGzuWFkvhzSo0PdEnUBLAi1H7Uj
         MPzg==
X-Forwarded-Encrypted: i=1; AJvYcCXj5f28qpbxZNgy8Rat6XeV4mGivQALgUBnpeu+jF6cSftzy3LHsUHazPtUYGItRPVDySWNGP82nbTTF/snLX5DNz6h73OlODXJlrkY
X-Gm-Message-State: AOJu0YxHIymuQUXnJRREEhRlPZdMT52mwwTOGn72b68n6nidnRK/UvTG
	W/04J5ajZBBMi9rzgwsgUxkecqmpxgLKBagmvs9glJyXCg2dmbi+E+uu0rk3og4=
X-Google-Smtp-Source: AGHT+IEZ3MSxzXsGAz+ZLkxl8S7XJ3zcQ2NIg6LwPVYoJf81xxbiq6s9OomXLtGiFPJD3YOtkLtUPQ==
X-Received: by 2002:a05:6a00:acb:b0:6ed:21d5:fc2c with SMTP id c11-20020a056a000acb00b006ed21d5fc2cmr12682862pfl.26.1713200617123;
        Mon, 15 Apr 2024 10:03:37 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm7433158pfm.25.2024.04.15.10.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:03:36 -0700 (PDT)
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
Subject: [RFC PATCH v4 20/20] ACPI: pci_link: Clear the dependencies after probe
Date: Mon, 15 Apr 2024 22:31:13 +0530
Message-Id: <20240415170113.662318-21-sunilvl@ventanamicro.com>
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

RISC-V platforms need to use dependencies between PCI host bridge, Link
devices and the interrupt controllers to ensure probe order. The
dependency is like below.

Interrupt controller <-- Link Device <-- PCI Host bridge.

If there is no dependency added between Link device and PCI Host Bridge,
then the PCI end points can get probed prior to link device unable to
get mapping for INTx.

So, add the link device's HID to dependency honor list and also clear it
after its probe.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/pci_link.c | 3 +++
 drivers/acpi/scan.c     | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index aa1038b8aec4..48cdcedafad6 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -748,6 +748,9 @@ static int acpi_pci_link_add(struct acpi_device *device,
 	if (result)
 		kfree(link);
 
+	if (IS_ENABLED(CONFIG_ARCH_ACPI_DEFERRED_GSI))
+		acpi_dev_clear_dependencies(device);
+
 	return result < 0 ? result : 1;
 }
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 086ae040a5ad..32865af071ce 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -835,6 +835,7 @@ static const char * const acpi_honor_dep_ids[] = {
 	"INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c access to camera sensors */
 	"RSCV0001", /* RISC-V PLIC */
 	"RSCV0002", /* RISC-V APLIC */
+	"PNP0C0F",  /* PCI Link Device */
 	NULL
 };
 
-- 
2.40.1

