Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD38E22FE15
	for <acpica-devel@lists.linux.dev>; Thu, 27 Feb 2025 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659806; cv=none; b=FuIkj930C2C7VLUfSiZz3QU2XOGnT49S0DOkJFP/Ck60mSSt5uskRGDqckLrm5SQnjqQWCBMaiTlCqcsR6m2+xVxKqEb674ummeULNvstdFqpzpZM4BHpOVByajOzNk3WIQEn4rN3284tn8u1Zk7ykRWGTxFKebohDplHqOZ7p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659806; c=relaxed/simple;
	bh=4W8Vqpl+3IMkDiuQlRiTKkhuW1t/YZ/ZWyYWVjVjiH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aAMOAe83le5XAWfZG8bX0E1FtXoXgm83II0xAHrE3+JS3L1CYCv/a2aB9z0MFAcWG8k72CWssKUlc1mleQhYaiLmjRT7ONy3AqMqApj1Nq3xdSrpmMKPzOdOYTFU8WTQzqB7OaZtRM+snJ1fRh2nZmHg9Ep6uC/ra/RgFHRclTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=HmpS1ciX; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="HmpS1ciX"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fe77285e12so1670525a91.1
        for <acpica-devel@lists.linux.dev>; Thu, 27 Feb 2025 04:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740659804; x=1741264604; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JeQ9SvTwKEilvSawoBKDfpL5rlVs3kDSMMrIWfL/lr8=;
        b=HmpS1ciX9ryE4QE4LibJOv0bJ6kpGagInZTzZsr2kmWwqv4k0yMYSY/dtCjGViBU1N
         +b/pqPP5WwuUUvdhfzU9ZHCBEflmkAWcb797rvJ62C7vhsmHhxP86L/aj96YMPVz+Y8n
         /Vb8aLEfnOHlZTGp+dgrMxHRz3qjRoq/TNRDWCTKXmJuroH7ceB0rTrbvDH2zS4tQme1
         Wgyq1JJ1/6a5Jhx6Ba9ea8cJ5m8wLR2iLLer4NXo92vPnIXcDjoXkWjWQV4N6goIqQub
         qxgcas7gCAq1LUZLzoxfCOst3qh/ooRWVtUwcKiVVp1b16+lryP7QsbVmTq96D2MGVop
         17CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659804; x=1741264604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JeQ9SvTwKEilvSawoBKDfpL5rlVs3kDSMMrIWfL/lr8=;
        b=NsHBYq7CmxPUDyLe1HEI2zC3Tl7RGDlNHemNdWwloXXgDzVnbnuQOf8JMzhtDrfa4S
         DzA2v4hf8r6jqXVdKuifUlaN6wzeP9FhHDfYcHKIR+XnOfqmIN+VF/DEbwuwswTVh1RD
         zR1kQ7K2kCVh1SMBikj3ranuuBzwK5dasDB0xajZkdsqknu1HFN3dbCJA5ufnaoJLux5
         K3EADKG4oqabSB81fffzfIfh0u60+aUZeb/VwwVaoKhtQjUJoWssQ9HJklBaZgtHJRBF
         f+zESQDddmsCnIHyExyLAYmje+xMj3dgQJAeEEO5Ilyn4TBu4UIDl31JCyZ4dYPNVUNt
         UQMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8Ni5rOLrLwRbbAd03Gwy4B0UCr67Q9lWTBYBNujmEJJep7Yz0W5j0knSNJWunj6pgHIQWguXfK8dc7Bk=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8EdUuRnyxAsLQitGAA5QF24EoHXdLyhvSPUttApeBaKjSYNA1
	TmdaHrjl5K3w/fAiJTaX2wiaMfJgfWybfW+jK502OEzsFTmCKWkYcNJXA9vl1DE=
X-Gm-Gg: ASbGncu547YuMTPRh/boTV+V6++rNsYvMA/XhX97ihELVn8b5oTzciIQOtBYlSNhz+P
	qPCrV3zqXCaLIPRTQLX7oS+lsCj8Y/zhMv4pmFHOihNTOrIIFPlNzM/mCseNXNnIVeK7gnjnwNI
	G3YKVWRIoiTCwnftV7PkCZewMtUUGpyyuvgdMJ3MtpqUnOGCM6j20zRMtSkYMRzJoe7BqkFOOvw
	nU3X0k1mjImczOdT1n6t/p6QkciSUMY8L8sMP0MswBZ01zVGc7mksPoTkXhcW/Ilaer+CiiTBU2
	WEnZk8op2FSv6+GQLp7r5FtsrNWR+TuxsAZs
X-Google-Smtp-Source: AGHT+IEWiqnbZ4w9mnQftgIr33jcau4DSGcKb/iqQJqvpeA7JbmmClnCCIaI0W3mRc0c/5zLfcvALg==
X-Received: by 2002:a17:90b:2dc8:b0:2fa:ba3:5457 with SMTP id 98e67ed59e1d1-2fe68ae6c4fmr20594318a91.17.1740659804130;
        Thu, 27 Feb 2025 04:36:44 -0800 (PST)
Received: from ventana-bhyve.. ([49.37.249.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bddsm13219135ad.140.2025.02.27.04.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:36:43 -0800 (PST)
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
Subject: [RFC PATCH v1 01/10] riscv: Define ioremap_cache for RISC-V
Date: Thu, 27 Feb 2025 18:06:19 +0530
Message-ID: <20250227123628.2931490-2-hchauhan@ventanamicro.com>
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

bert and einj drivers use ioremap_cache for mapping entries
but ioremap_cache is not defined for RISC-V.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 arch/riscv/include/asm/io.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index 1c5c641075d2..e23a4901e928 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -30,6 +30,9 @@
 #define PCI_IOBASE		((void __iomem *)PCI_IO_START)
 #endif /* CONFIG_MMU */
 
+#define ioremap_cache(addr, size)					\
+	((__force void *)ioremap_prot((addr), (size), _PAGE_KERNEL))
+
 /*
  * Emulation routines for the port-mapped IO space used by some PCI drivers.
  * These are defined as being "fully synchronous", but also "not guaranteed to
-- 
2.43.0

