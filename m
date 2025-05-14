Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592951F875A
	for <acpica-devel@lists.linux.dev>; Wed, 14 May 2025 05:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747202262; cv=none; b=TnnjXzTtlNQWfegNh8ZwKW0X2XBZKos8qDxpZLLiLe87drYu2HZPE+n8MVq82l9pF54n2a6sDMnwEWbSoMp7FLAYYSyhlpgyuQXHjCrfk4g/5Trtijw5KkF/FPrYdo0EfmGeZVzJbGFmvPI0gvlCCDJdjjaUg0nd7IfGGnH2zaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747202262; c=relaxed/simple;
	bh=P/M7n4SDTSF4DDX2hlMecwto868uMFq8eIhCBjXO3DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gz1xPOU04hU51lEviH+I2YvDsFH4JbRAfxeOFqjRzzpk8AZLiD8h6nH2R4UMhpiGChrXaScLDCUyf9SeAWBnTRS4DaAsVJB+u+j6KKQf/Msu3ZCYoR3kEtXF5CZe1uY/JsVmdzik7ALpzTZrX5Spiat7urVSHdLVsAvd1BNr7HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=fm0wRXb8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="fm0wRXb8"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22e45088d6eso81103635ad.0
        for <acpica-devel@lists.linux.dev>; Tue, 13 May 2025 22:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1747202259; x=1747807059; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3mv/YR2xZRmrbZBh7XLVUMsC3Lat0ehLZET0BefXjE=;
        b=fm0wRXb8Bf7xvIDU7N1lUulL4sVVUZ2egrDVe26atIRuB8+IAHBZGzNHrkAawwfo4I
         sFqpzIjdV1XJzoq0gI7+OEEQE+MeNz/UogGaX2jvEX67DhN6khZD9pwSjY5vQrqWqeQk
         pFnXudGKyhffc3iOjTIOyBM5DBNNKsixnq6EiIbcGER1gsYKiK1EsGaJiS2H9d6Bmefk
         zcZIiPXNOsKE9hxalx5k6WYxmWZvdqus1vTUBPTs/I7LsBoZkFX2Ev6w3alsK9AzctfP
         r4NDuJ2XG0FM/MUu4wKReujvMDixoFFnwOapuAfJIzNDTGiHVaq10PXZiHUipHpqh/dp
         bYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747202259; x=1747807059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3mv/YR2xZRmrbZBh7XLVUMsC3Lat0ehLZET0BefXjE=;
        b=FY/uRlpvC20IWzjHIwE5vE5y5hvVcsUS8E21J2sydT+anRyCqgMOYvN9MqMSn5oN30
         p+xfEJa4sm/p5SUmM6DnH/4Zta6u/1O87hoxcXLdie04SQXNMES55o0QqfNa0t2YG7kw
         M7EODPc023ztB45SuW1/uWtUdctp81Z9nUX3V8+rNQns4YmxY1WYMB4To0l1x/BNq9KH
         Y15Px+R27yyRdmJLni7AuBMe2xsOqR4MNv9gHQu+tevzoMlV80BXbvQDvuYjI0YEQbbU
         s4xFtRB9pHp/rrtqMWJcOx6e7GxUckyd04Ex+djn+WjOzbyJRWObuY+UG6aDv5HBYU9s
         63aw==
X-Forwarded-Encrypted: i=1; AJvYcCVWeP1ocHB/ximOIPk+VcbWa6NnG0SLFyLeLlFRPx/kEiPHG0Pzf6Buh2RjL/z9aRZhQ5MSG1daqp2a8e0=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw45ZIeluHaS5rDGlpZOaT4YYZYgILdtyaJm5hxqwuhcndbxtXA
	UQTdo4aEluizqZDJvZgf/4Vbb42jLy1neICeBECGCUJQQ6Chdc30L5lHIFsMfNU=
X-Gm-Gg: ASbGncuNMUcyf7RJauh5ObtWA/9jzvsv2/RvHh+2u+2VSGyDehEWWPvosWwUTa5XwNU
	m61cZfA7wrjX36BM0o8R27PivoAKg3kjhLbzT1qGIxpLYDCTLOR13WBxK6MuES0z2NiDFC2iBBJ
	UlTe0Lwhyrk8wTJ7IkfBE8O9YY8378bT4nVR7Hqy3RsrNCQvCLoUoQFm5tf7jU4n5o3f6f0WqD/
	rAgYphtStjWbbaVlkoLrYbQfp8p5J3U5SxJqop7/humBBB4csXLgc3Ki8PiqKySj2YimcDQOj8f
	2XlfuunpmjMrktz7BLtkXkMbDHQ2DJaEGCxmhHiyWLmeF3kH+f58XcbZ+R4rlQ==
X-Google-Smtp-Source: AGHT+IHE6ExFWnu/zrAvRfvX4AYC0RkEswg44e9W2VNDqbKcdiZ15MPr+ykcmRts8B4KvtHH+QD0iA==
X-Received: by 2002:a17:903:41c5:b0:21f:1bd:efd4 with SMTP id d9443c01a7336-231980d04a3mr31983045ad.19.1747202259577;
        Tue, 13 May 2025 22:57:39 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.196.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc8271c2dsm91721615ad.135.2025.05.13.22.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 22:57:39 -0700 (PDT)
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
Subject: [PATCH 1/4] ACPICA: actbl2: Add definitions for RIMT
Date: Wed, 14 May 2025 11:27:20 +0530
Message-ID: <20250514055723.1328557-2-sunilvl@ventanamicro.com>
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

ACPICA commit 73c32bc89cad64ab19c1231a202361e917e6823c

RISC-V IO Mapping Table (RIMT) is a new static table defined for RISC-V
to communicate IOMMU information to the OS. The specification for RIMT
is available at [1]. Add structure definitions for RIMT.

[1] - https://github.com/riscv-non-isa/riscv-acpi-rimt

Link: https://github.com/acpica/acpica/commit/73c32bc8
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 include/acpi/actbl2.h | 83 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 2e917a8f8bca..99ea8bfe47de 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -50,6 +50,7 @@
 #define ACPI_SIG_RAS2           "RAS2"	/* RAS2 Feature table */
 #define ACPI_SIG_RGRT           "RGRT"	/* Regulatory Graphics Resource Table */
 #define ACPI_SIG_RHCT           "RHCT"	/* RISC-V Hart Capabilities Table */
+#define ACPI_SIG_RIMT           "RIMT"	/* RISC-V IO Mapping Table */
 #define ACPI_SIG_SBST           "SBST"	/* Smart Battery Specification Table */
 #define ACPI_SIG_SDEI           "SDEI"	/* Software Delegated Exception Interface Table */
 #define ACPI_SIG_SDEV           "SDEV"	/* Secure Devices table */
@@ -3002,6 +3003,88 @@ struct acpi_rhct_hart_info {
 	u32 uid;		/* ACPI processor UID */
 };
 
+/*******************************************************************************
+ *
+ * RIMT - RISC-V IO Remapping Table
+ *
+ * https://github.com/riscv-non-isa/riscv-acpi-rimt
+ *
+ ******************************************************************************/
+
+struct acpi_table_rimt {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u32 num_nodes;		/* Number of RIMT Nodes */
+	u32 node_offset;	/* Offset to RIMT Node Array */
+	u32 reserved;
+};
+
+struct acpi_rimt_node {
+	u8 type;
+	u8 revision;
+	u16 length;
+	u16 reserved;
+	u16 id;
+	char node_data[];
+};
+
+enum acpi_rimt_node_type {
+	ACPI_RIMT_NODE_TYPE_IOMMU = 0x0,
+	ACPI_RIMT_NODE_TYPE_PCIE_ROOT_COMPLEX = 0x1,
+	ACPI_RIMT_NODE_TYPE_PLAT_DEVICE = 0x2,
+};
+
+struct acpi_rimt_iommu {
+	u8 hardware_id[8];	/* Hardware ID */
+	u64 base_address;	/* Base Address */
+	u32 flags;		/* Flags */
+	u32 proximity_domain;	/* Proximity Domain */
+	u16 pcie_segment_number;	/* PCIe Segment number */
+	u16 pcie_bdf;		/* PCIe B/D/F */
+	u16 num_interrupt_wires;	/* Number of interrupt wires */
+	u16 interrupt_wire_offset;	/* Interrupt wire array offset */
+	u64 interrupt_wire[];	/* Interrupt wire array */
+};
+
+/* IOMMU Node Flags */
+#define ACPI_RIMT_IOMMU_FLAGS_PCIE      (1)
+#define ACPI_RIMT_IOMMU_FLAGS_PXM_VALID (1 << 1)
+
+/* Interrupt Wire Structure */
+struct acpi_rimt_iommu_wire_gsi {
+	u32 irq_num;		/* Interrupt Number */
+	u32 flags;		/* Flags */
+};
+
+/* Interrupt Wire Flags */
+#define ACPI_RIMT_GSI_LEVEL_TRIGGERRED  (1)
+#define ACPI_RIMT_GSI_ACTIVE_HIGH       (1 << 1)
+
+struct acpi_rimt_id_mapping {
+	u32 source_id_base;	/* Source ID Base */
+	u32 num_ids;		/* Number of IDs */
+	u32 dest_id_base;	/* Destination Device ID Base */
+	u32 dest_offset;	/* Destination IOMMU Offset */
+	u32 flags;		/* Flags */
+};
+
+struct acpi_rimt_pcie_rc {
+	u32 flags;		/* Flags */
+	u16 reserved;		/* Reserved */
+	u16 pcie_segment_number;	/* PCIe Segment number */
+	u16 id_mapping_offset;	/* ID mapping array offset */
+	u16 num_id_mappings;	/* Number of ID mappings */
+};
+
+/* PCIe Root Complex Node Flags */
+#define ACPI_RIMT_PCIE_ATS_SUPPORTED   (1)
+#define ACPI_RIMT_PCIE_PRI_SUPPORTED   (1 << 1)
+
+struct acpi_rimt_platform_device {
+	u16 id_mapping_offset;	/* ID Mapping array offset */
+	u16 num_id_mappings;	/* Number of ID mappings */
+	char device_name[];	/* Device Object Name */
+};
+
 /*******************************************************************************
  *
  * SBST - Smart Battery Specification Table
-- 
2.43.0

