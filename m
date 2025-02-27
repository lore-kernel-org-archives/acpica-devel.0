Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198F822E41C
	for <acpica-devel@lists.linux.dev>; Thu, 27 Feb 2025 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659822; cv=none; b=UzAW/2dTcehllv+8LEh9qziV6whGbi0f2MdBAkRdEbSnk7opJM44UT8M3whypS4ly6IzNIHUsBhGHhvSn827LLwjP62IA+bICcfXKpSf2MsIm30VlMifaarrkgPjhORriTzSWQmPsLkax5tF6c4gApbBYtZcP+f4naC6HWEmX/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659822; c=relaxed/simple;
	bh=rGWTzIIeViWhGlD8y9psao/8+qBiPCPjAKNTSslE/48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldCvyXBxIWSIk9dkCJufjOsfY/2HQNlZyWouVfEaUbuiZPBjTmxsOuRhuZyW9E8aY77V7G4V0Ba+W4/Hf18eRewF/OSYBDxKt4787sNzqZVhBmC4IV/QE8B8Y2KxtR8Hfoy50CmrBJdbu/LnR8Vbx72fxWllR6DaSPSsa2qC0lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=KmN4w81C; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="KmN4w81C"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-223480ea43aso19851235ad.1
        for <acpica-devel@lists.linux.dev>; Thu, 27 Feb 2025 04:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740659819; x=1741264619; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvAemUtNRi9tUzWy4d/eui/dPAc9laFlbuC1eHj4jHs=;
        b=KmN4w81Cn45cAnTj4Cwvo0YfkzdhO1Yr6QLFVFU8LzRRaAMPXJpMX1CizZ71YxjVrh
         AhSHsF3sc+PufLgofdTgIQeu5AT3HgHCNW5w2EGj/LzMwQb+U2bP3UimDraEqNp/TrKy
         ogiyOOd1DDnSh4uUZV/ewtxJ7tbXZrkLUH38go7zWuYk33xFwgHl6uhnys/1S7tmG5Wo
         huMXIessFOm4OmUN+3KGmNTGk87Dn0QSMX2rFHe50TSm9H5+fb8mnB7QHEG2tpb1i62S
         p/ZQs4NP3Mfbzr1Ys9XRqcGqfYBYrssKKsK9VE+5CDh0uL2eYPUDbuc5ri1hm9JsNnrM
         KkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659819; x=1741264619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvAemUtNRi9tUzWy4d/eui/dPAc9laFlbuC1eHj4jHs=;
        b=quiRPG/Bx6f3BuH6xXiwSxRmyqpmvm0/K2XM5QHpNLw6uQdiH6tAWLkFIkuThwY9YI
         ALVCnlx/tSTgQWvWRJ6TK1hY4UO/CwXhUKDGdxzpQkrknWZ8pSRf2a3unccgN4cXbggE
         rJtbT2/HC+06iTKC5nrnvK1THvMyOwpKIJQdygPt9vV9ZMuDoqlIiHDdQKzqd1iQmhwB
         p7RyVxdre4jLnBUSBdMk3Tavtr3LyfeaH91VojSX2/YNTw9Wn8ZRzlMrkfxWqp1eSLlv
         l9BxDlzBoRTFHBudVuK2gyN8QmIrfcAMaKCKdh5YMfTzBYJWwBhyDOyg2+8KRM0y0H9M
         jDWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/0Ubdp6cQEfrCncnfMwtZn/dafbl3xIzsSd1FXCyd1rI4xSD8SocZPqLNGbKmLjIumQttLHIl+3LkaM0=@lists.linux.dev
X-Gm-Message-State: AOJu0YwW7XEnRZvNP3139n0J9Bx9PrOkHfaOlux7dMog4141jdESNmdJ
	335TRjwcRNN8uPFmP3NGuI/tNgqJ5LhOInAhraaffhzoy2k9TZO96dO7NO3alfA=
X-Gm-Gg: ASbGncscblhueLx9fs3m+JSaejlZaegB5coG2snurFpwUiCIuId3gMiRdgGnV8A1UZM
	0jJIcBY+2m1gVcUaIhUEaUVmMbh0z3yvVCrzrwmHbZ/VLweKM1Ke/w6z9GyShBzW12bbNAKYbqb
	0d+cY6xr09fujix7ugobZ+osGMIc/e+lPQKwCzvGEMJSpmeOJp8bZZ2rXZpTde07bltO6oZtFVD
	YWNuqjLmV+ac27F92EnYjwdchIicwrU3ADYSRpGyq3mUb5uEyoV72+NR8NjIlHozxEAUnIQHQ02
	NNOXVAiR3/AK7EQikgvNmWe+mFQl8giNYDrT
X-Google-Smtp-Source: AGHT+IFYVtprbH9evLqNClf+RfnxGHGySs3bbzOLOoRiAZRk+G2rF8ng8rvkLS2SHiGq2QScEJQDTw==
X-Received: by 2002:a17:903:228d:b0:21f:1bd:efd4 with SMTP id d9443c01a7336-221a0ed7e4cmr423165445ad.19.1740659819428;
        Thu, 27 Feb 2025 04:36:59 -0800 (PST)
Received: from ventana-bhyve.. ([49.37.249.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bddsm13219135ad.140.2025.02.27.04.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:36:59 -0800 (PST)
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
Subject: [RFC PATCH v1 04/10] riscv: Add fixmap indices for GHES IRQ and SSE contexts
Date: Thu, 27 Feb 2025 18:06:22 +0530
Message-ID: <20250227123628.2931490-5-hchauhan@ventanamicro.com>
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

GHES error handling requires fixmap entries for IRQ notifications.
Add fixmap indices for IRQ, SSE Low and High priority notifications.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 arch/riscv/include/asm/fixmap.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
index 0a55099bb734..fa3a0ec0c55c 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -38,6 +38,14 @@ enum fixed_addresses {
 	FIX_TEXT_POKE0,
 	FIX_EARLYCON_MEM_BASE,
 
+#ifdef CONFIG_ACPI_APEI_GHES
+	/* Used for GHES mapping from assorted contexts */
+	FIX_APEI_GHES_IRQ,
+#ifdef CONFIG_RISCV_SSE
+	FIX_APEI_GHES_SSE_LOW_PRIORITY,
+	FIX_APEI_GHES_SSE_HIGH_PRIORITY,
+#endif /* CONFIG_RISCV_SSE */
+#endif /* CONFIG_ACPI_APEI_GHES */
 	__end_of_permanent_fixed_addresses,
 	/*
 	 * Temporary boot-time mappings, used by early_ioremap(),
-- 
2.43.0

