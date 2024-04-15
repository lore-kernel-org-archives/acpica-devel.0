Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D791272B2
	for <acpica-devel@lists.linux.dev>; Mon, 15 Apr 2024 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200560; cv=none; b=hdJ1hw7vusvybVy5wMzGBu60dA0UAPV3jKggFzy7WywoAu2h+E1I9E0mKJ2b5Qkv0AnwS8CzXOgQzixZEWBqHP71rPGU4lgj/BMAFpOMEoouYoQNulAIG7KO6+L5/I+fB8jP7c374gq29/Fjrw3FWVZGQqX387N0LwgusxF7SUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200560; c=relaxed/simple;
	bh=LYtUv6qDwrcBtr8K6aN25hN45uuc46R4wBZ+hNYpcAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QRDaPkYNS/m9OBTQVUY8j7/yt3SxP9RdE01pvaCBFyZAR9fNj29bBpkE0Msh+19CQkLXED5gXh3FCUl6xHiKZKInVSItOry8e+PY627nY2pYulCf4FHN27HQTzjG5pAGQjoLnoYMvtdV3XLmSTpQUgjnjTXNWKmnpV61Hz+DNL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=lysjOtgJ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="lysjOtgJ"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ed04c91c46so3650147b3a.0
        for <acpica-devel@lists.linux.dev>; Mon, 15 Apr 2024 10:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713200558; x=1713805358; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1X7evQ35uoewh1RNAGJwcs/iaU3rzDK4qB90vlKVhs=;
        b=lysjOtgJfKtgwcLr/p6fuhgGASzdyqfSPGQzsDnWTch6mDA/87WkOar+D67Sm56fK6
         1LqtMr/r7gmmXgj8k/JdhQ3AyNbaNOPC26njGqps6GBGyaiTlZKXrxmIVmyazWI0g8Jw
         YgGmH4SRTsONNidghnnGe7LTn97AOOIioyWkNqzDwdp54tXchkzK+Bp/4CwyBabfm2Gm
         8MyUhMWr65RXLM8eUklrC6B2ubSu5u1azkqnScsibxnaFwrgJwIQgnw9DDlk0qHc+NBq
         lILt+R366jUKI4lmPepR55ZhPYm/xr3+etpQ78fpuP6O/0dVIZ1Kpn3JIIu7rdTvdpd1
         wEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200558; x=1713805358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1X7evQ35uoewh1RNAGJwcs/iaU3rzDK4qB90vlKVhs=;
        b=FDoO/0bh41m6fyleGtUlPbmFVlaOyD8KSfhlnujH5kKQGRtL+bH/op9ewnKq/5qQ10
         wG/CMIAuEhWqza297fnsmpDAhBGoZacsV2zUFCDgteAuYmsPJ7VjGpIHP8ciDGC7EiwR
         gs8b57MDl24U52T9jB6Jr/ZNDTBh0b3Hpk9R4+6J2v8lVI+cBrOowHTA5U+Vqgbf09CD
         8rjph1N10s5VcoNnTip9OfAsHc6JZ4vCnlPDeGOTDJMpYgLKzgICa/rVBHdQDNqn55Ry
         HpoqVwqU5Ner/7qZ4sXXnWl93mS7KLsybH8P1lsBPqETtlk3KdDvYWpqMwTnoAXLOVYs
         07mw==
X-Forwarded-Encrypted: i=1; AJvYcCUsRbnLr2k/hgI48gnZrrVPFcZZDix/3j4PEahxhMFZpOPMtiXenNVTCl5FHMjPwuR9v92G/InEeo9gyrqzn7Kc24gpkefG+cLVPtcG
X-Gm-Message-State: AOJu0YwtxW4dLhbG/uuAfBbxBhprVsRIMl4sZBx5iftAOWcVWtY331Xe
	virFKv5AWQYVdPBtTPOOBY2A2VEW4GM8E0Nv60hkio9E/bDThTVjqxuwmaW6ihU=
X-Google-Smtp-Source: AGHT+IHP5Rv0C3YxWinnwyj54lMdddb7BaD0yQpP0Yg8Qswii7cMjohW9Wcp53K9v1it+Ov4jHo51g==
X-Received: by 2002:a05:6a00:181d:b0:6ec:fe26:4ec1 with SMTP id y29-20020a056a00181d00b006ecfe264ec1mr12412388pfa.22.1713200558011;
        Mon, 15 Apr 2024 10:02:38 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm7433158pfm.25.2024.04.15.10.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:02:36 -0700 (PDT)
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
Subject: [RFC PATCH v4 11/20] ACPI: scan.c: Define weak function to populate dependencies
Date: Mon, 15 Apr 2024 22:31:04 +0530
Message-Id: <20240415170113.662318-12-sunilvl@ventanamicro.com>
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

Some architectures like RISC-V need to add dependencies without explicit
_DEP. Define a weak function which can be implemented by the architecture.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/scan.c     | 11 +++++++++++
 include/acpi/acpi_bus.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 07e91616b7d4..8e23b9508716 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2073,11 +2073,22 @@ int acpi_scan_add_dep(acpi_handle handle, struct acpi_handle_list *dep_devices)
 	return count;
 }
 
+u32 __weak arch_acpi_add_auto_dep(acpi_handle handle) { return 0; }
+
 static u32 acpi_scan_check_dep(acpi_handle handle)
 {
 	struct acpi_handle_list dep_devices;
 	u32 count = 0;
 
+	/*
+	 * Some architectures like RISC-V need to add dependencies for
+	 * all devices which use GSI to the interrupt controller so that
+	 * interrupt controller is probed before any of those devices.
+	 * Instead of mandating _DEP on all the devices, detect the
+	 * dependency and add automatically.
+	 */
+	count += arch_acpi_add_auto_dep(handle);
+
 	/*
 	 * Check for _HID here to avoid deferring the enumeration of:
 	 * 1. PCI devices.
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 28a9b87c23fa..5fba4075d764 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -994,6 +994,7 @@ static inline void acpi_put_acpi_dev(struct acpi_device *adev)
 int acpi_wait_for_acpi_ipmi(void);
 
 int acpi_scan_add_dep(acpi_handle handle, struct acpi_handle_list *dep_devices);
+u32 arch_acpi_add_auto_dep(acpi_handle handle);
 #else	/* CONFIG_ACPI */
 
 static inline int register_acpi_bus_type(void *bus) { return 0; }
-- 
2.40.1

