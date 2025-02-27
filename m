Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562442343C6
	for <acpica-devel@lists.linux.dev>; Thu, 27 Feb 2025 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659853; cv=none; b=dEQkzbiu/HPI52FaCTB2Nh7xDu5O+nfLgAoO9B5UjN5zxpREXmVwhlAjOaeT4E0Kz2T6sfPyW03It2RFfpWjO5988A5skmUqBXn1p4tFmUP0EGbIw22LLyhXo65QH2XH3l6LdjBIAWPjRCcPwzfrCIpC7Qr9c64TsaNSl42eOOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659853; c=relaxed/simple;
	bh=VXd0R443A2CSpN6/WQb26SvFq5CeBSdmv/3wp2DtRPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UaeqSOEn8kcYAo4dRY/ldvbfJXI4Nvt5mC0snDkpGckKhYDzxushf2WNo9hyrrmqbLiPrI3Pvrw3b838E8ru/5lD8ulGUhDszXgGAjV/Kr0ux3N2OCa/SG9z6qwbiAgH5+nNjtE7/Sp5uBmlgo9WbAj8zZRC0fi4P1fodU4k20Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=kywa42oc; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="kywa42oc"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223378e2b0dso12827915ad.0
        for <acpica-devel@lists.linux.dev>; Thu, 27 Feb 2025 04:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740659850; x=1741264650; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+mNjfrfC3KQpEysy41mS2Tv5FPl9byidBfQ8gAxtKE=;
        b=kywa42ociQewr9sVfx/IRBGvZaI+kbkwtuMxNKw7NKhNcEUrlkrWh8WqOMmfumyPfj
         oGmOXoZbs2JHs1TOqi7nnThol2W8yCCuf2Nv+KkQWuIMvmtWtW51a3IsOn7MZ2YGOL6I
         XfSOiZH6WP1t9YsfsEXQpPpUA7Wc7xpoQTQ4PWDWBVcVKMlfCUABvcuw7cuCCd9Q8vt/
         p8XwZy997TztsrTyrObYSEn6rLmezldrSe5jaliJQDM+bIgOMCXoOkTu7bjwjKCc2nhT
         As7y8TXf4qMAt/+HlS4Jb7UIm+grRH8ec9avZdPQVgFWg/NwAHOuMbA1kwqU0TWPx7SD
         BCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659850; x=1741264650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+mNjfrfC3KQpEysy41mS2Tv5FPl9byidBfQ8gAxtKE=;
        b=dhV9BKHRKGaf5Uw6pEuNGW909xUiefVg8p/miT28X4YBWJ3aEdGLk1gtHqoPCktcej
         frXX1fw4oX8QtzYrW4R+HnkVNq2znLr4g8bWA0NnvKph+loeoplmWRqG4VkKoUQcTC2p
         14pLNgRREo+Bb4MfYqewqDjkKCbn28uIBGdjsZq2ge0MjQqGTlsXxJSXVbU/hfy2DRNm
         r9K0SByLWTAfcaGf0acAGx2vhik/muKtryMzWXu9SPNXKRsvrZuEwfAFKX5z035PkFsW
         U10jJ3x10NwXtoKIcTgTaQ1UVusfCblZC6UCwZHzyIsVsh1N7SD8afiW66ZG08vFCRaw
         uwQg==
X-Forwarded-Encrypted: i=1; AJvYcCVh0SfYtfrvSBhXAMlTyb05Crk2rcrEL/iR6j3k1m4d+9LPOESxHG1vnHtsZWfdhUCaAZSfV0wE0d7Q02A=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywdrt0vjDzawxeQP0+w/8bQQ1bVRQYYarwaB8mRw1P+DdfITSBy
	kEuNR9Z93Zm4wSXelyU1A6BbHkWP9drVjePZlM4dNtqV6gsHM3UfNyd1cPcbUoA=
X-Gm-Gg: ASbGncv90TmlL/GJYKcNoomyyLWl4PbIuwfvzB2BNeO0jrss/q95LxUvCeyuHBKb1jr
	aY8kJ4VadYuKYeLvGrg6cs2Pd0ftzSNrwwMyf0DDIaICOwfc77NVkZ3BiGo0d3c0FJozyzTmHOM
	+m0A/Ak3wCMMaXWG21IW7oSNBuQPAeHTrQ2TS1PscMCAkP4nnqKZFihcMhsn69dbL6VASzMWP09
	SWOsPuL0j9pX8lQpNfW/hlxtHM4lorgkC5lxiBkE+to2wnGU28Q3cJ6InP1IcO9lh+ZBxQ88vjS
	s42MReM75ToTGvBjbJ5YOf5cAEf/cFDhOyMJ
X-Google-Smtp-Source: AGHT+IE9Vof5DljJTx2QIG7oo7zj0JMnbJZ2cxvFEIVb6E+KmXCrNVvzk23nCPfXj+pXqJcPAINyhg==
X-Received: by 2002:a17:902:e847:b0:223:4b8d:32f7 with SMTP id d9443c01a7336-2234b8d349dmr54186705ad.19.1740659850577;
        Thu, 27 Feb 2025 04:37:30 -0800 (PST)
Received: from ventana-bhyve.. ([49.37.249.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bddsm13219135ad.140.2025.02.27.04.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:37:30 -0800 (PST)
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
Subject: [RFC PATCH v1 10/10] riscv: Enable APEI and NMI safe cmpxchg options required for RAS
Date: Thu, 27 Feb 2025 18:06:28 +0530
Message-ID: <20250227123628.2931490-11-hchauhan@ventanamicro.com>
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

Enable the APEI option so that APEI GHES options are visible.
Enable SAFE_CMPXCHG option required for GHES error handling.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 arch/riscv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7612c52e9b1e..baf97a4f6830 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -54,6 +54,7 @@ config RISCV
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN
 	select ARCH_HAS_VDSO_TIME_DATA
+	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_KEEP_MEMBLOCK if ACPI
 	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE	if 64BIT && MMU
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
@@ -175,6 +176,7 @@ config RISCV
 	select HAVE_MOVE_PUD
 	select HAVE_PAGE_SIZE_4KB
 	select HAVE_PCI
+	select HAVE_ACPI_APEI if ACPI
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-- 
2.43.0

