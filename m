Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199F523026D
	for <acpica-devel@lists.linux.dev>; Thu, 27 Feb 2025 12:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659811; cv=none; b=sROYpU24krkNr9Y3UeIkMRkbdTcEHP85q/QW7tXSk1C2Y8UC/EjipSOI7Eu/Efm+Yo5N1aVui3xKha77AHSVfkikGHnRKAnoZTWX5Gy6sfDV1VH80iGfuyXEKdQnwkfubSz8M1aSNm8J1OOOq4QE5xaWx6ao0MM7/fpoaD1XA+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659811; c=relaxed/simple;
	bh=TlIOJZgzYRa0uSdvlZ7h4NFliLwrLJg52Wgu33BrOfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwbeIXe8ph9QwIenEW3Eet43TExLR4deHgOUHPAnqeaNGTHCWedRQwrNBj7I05F65Oze+LJ6scP/GvYRYZ79uZ9qNBMJ6jNx22FPVotHo6CZojBJUjjFRev5DbHdTGt/beg3xu1KSj+huHFw8Ec8ilnGcxqYtxDyMIIynMQRRjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=CDYrn1Sr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CDYrn1Sr"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22114b800f7so15580475ad.2
        for <acpica-devel@lists.linux.dev>; Thu, 27 Feb 2025 04:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740659809; x=1741264609; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFXZa2m3ScC7B7xgAgov/Ch2E5BoKfJoACxjrPDC6sE=;
        b=CDYrn1Sr+fctPy6RiazXvOjzrlNsqZ2my5mWVTw2nOaDylRI2qOJLKz0Fh+8jh3wkU
         Hp2uy3QopFwbtP+G5XeoLt05dbrBC/DIPc8fc7K8heKDU+tYeHzP1lU85DyJPg4ARwSi
         E+Q/7uxItsZdTEQ/pXrW8L8wZyRcvsLvo5LNgAVnWdUJyDdoWm5v45J6EDV8hSXx25a9
         A04ZZHDWDTNe3aNIaLowLbTmyviyzEoFH46LqLt61U3fuRO1mW3VFn2v+pTGCVOcZ1GX
         CksSGrvgUhp2XpBGJv79G5noOKyGULavaeaD3a7Y/igOoOTbETzMCYc1EFJ30FNCWYcV
         DMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659809; x=1741264609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFXZa2m3ScC7B7xgAgov/Ch2E5BoKfJoACxjrPDC6sE=;
        b=M6B+PwQt+GwcPL+MoyyGLC0Sttai+nrNCPRxUqFCuDjgKwA6QQutihs58eihSf0W1B
         ZeEOHE1Cx/uugzz5xNgwpfidX/kzfZpsuhwmabl5jjnJKUzm3njIZ5CjdgLw2m5wgsp2
         JFx3KjQLkz0w3DGDsTC1abV4/efbQZrIWpMYZBW2WTZz5eUQdCS8EP2GTVJobMJwJEjO
         /7JFs7/qnAurfYiXG2W2CutCiUq7Gq3Q1vNqXuV3HFXy9Vu7FUVOQrJo1zKzRavNs462
         nq6goWNyy201Tm5R/Dtz4IdCTWMcuSDyaM1+cwA+wjtFzL5ZJQOvhILAqyWII7HK3rPa
         e28A==
X-Forwarded-Encrypted: i=1; AJvYcCUoRCELDPOW7gzub3EBlRehWKzUKW0HoevBGkToKusi6a0krZHD0ql6aEjL/end+kJ+axXTxVO5/9ko/JI=@lists.linux.dev
X-Gm-Message-State: AOJu0YzWIqCKnBMRCuNT9TV/DlIL1E47TUA1NqW6tGDQofPhY8pxsmnP
	Nd/NNp+v4eFwfl9zN2lj5FmxuCiRjOXzMTQCx5EDZD8Z+2cxT7Q+Zj0Rvr4wXic=
X-Gm-Gg: ASbGncvRZf/WgPKQ45NckKGREicJdv9hBcwBGzw0pzl2uF77AzuRi8deCJ5/TLeV8dp
	Ek5oU3uMIP28lwpOoBxjAu9EtUcqA4xjCv28kX+lQaHnJURKZwA9nR3ohE3b8Eyp8333Xf70GLG
	pFqAT6kZpTj3tLRvZTlLCNgK785QD1NBtfv4Z+N5d6pC0+Hr6ILUXRVfJ5Nnc+LxBTA4i6LkhdL
	FgyQWwr+Ob6w3yh0jieiBL8n7NZ8JQIYLYnpTFUJ2N1vRNkQwnhrNOrAMCs6K8HWMtP3qbngPpe
	gRgZvPksD2s44h5R/D2QlfUqLtxdNDNTIjbY
X-Google-Smtp-Source: AGHT+IGIh9E0vXJbqDwy2DSU2gnNrcolcT0Umoa7eQqwP9lNhXHlny+mB50OGnl9ch8jNaDBTVMb8Q==
X-Received: by 2002:a17:902:f706:b0:215:b058:289c with SMTP id d9443c01a7336-22320061fd6mr98812585ad.8.1740659809295;
        Thu, 27 Feb 2025 04:36:49 -0800 (PST)
Received: from ventana-bhyve.. ([49.37.249.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bddsm13219135ad.140.2025.02.27.04.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:36:49 -0800 (PST)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-efi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	ardb@kernel.org,
	conor@kernel.org,
	cleger@rivosinc.com,
	robert.moore@intel.com,
	sunilvl@ventanamicro.com,
	apatel@ventanamicro.com,
	Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [RFC PATCH v1 02/10] riscv: Define arch_apei_get_mem_attribute for RISC-V
Date: Thu, 27 Feb 2025 18:06:20 +0530
Message-ID: <20250227123628.2931490-3-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
References: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ghes_map function uses arch_apei_get_mem_attribute to get the
protection bits for a given physical address. These protection
bits are then used to map the physical address.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 arch/riscv/include/asm/acpi.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 6e13695120bc..0c599452ef48 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -27,6 +27,26 @@ extern int acpi_disabled;
 extern int acpi_noirq;
 extern int acpi_pci_disabled;
 
+#ifdef	CONFIG_ACPI_APEI
+/*
+ * acpi_disable_cmcff is used in drivers/acpi/apei/hest.c for disabling
+ * IA-32 Architecture Corrected Machine Check (CMC) Firmware-First mode
+ * with a kernel command line parameter "acpi=nocmcoff". But we don't
+ * have this IA-32 specific feature on ARM64, this definition is only
+ * for compatibility.
+ */
+#define acpi_disable_cmcff 1
+static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
+{
+	/*
+	 * Until we have a way to look for EFI memory attributes.
+	 */
+	return PAGE_KERNEL;
+}
+#else /* CONFIG_ACPI_APEI */
+#define acpi_disable_cmcff 0
+#endif /* !CONFIG_ACPI_APEI */
+
 static inline void disable_acpi(void)
 {
 	acpi_disabled = 1;
-- 
2.43.0

