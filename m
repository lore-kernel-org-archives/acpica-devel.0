Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10DE83CAF
	for <acpica-devel@lists.linux.dev>; Mon, 15 Apr 2024 17:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200532; cv=none; b=Bl+lSxnYxu8QsY+ZrWv7fd0/JOd+4doIF1DNYQ0Z4wNYpQmU98m6XSp0wdQLXVZ/w+vfaU7vQAZOaCK/dJUaF9Lx5fi6e5TX0MVVJlhPpZ1Dxlxtde/pjxcjsYfxUDplyfdIn+f9kKmFXncToqS1LXtdqUoz6qynYOex/QMaPBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200532; c=relaxed/simple;
	bh=NYDxzQHyf8gJHPAvOALBAMzhx5urWTz2dTzECHqtOGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tlnIJRhKSnmuUKDHoKHquQFhX3hCbmzpfuuo6Y7mplvxZSpC5nLbEvZNnDtKvrK7P6TRzG9U/T2Du3ePfHfRtHnbTFreg7nZSe2FM0W+i59PLT2ifDm4LJVmkZgYOq6ert1FISM7YH60VaDGCvtWtPMekB133PF/MaHHnKyIYTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Wg8hrBft; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Wg8hrBft"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ecff9df447so3553317b3a.1
        for <acpica-devel@lists.linux.dev>; Mon, 15 Apr 2024 10:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713200530; x=1713805330; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wivOzLRmXtJHidm0Hubd14abZ9qXDzBQHr2qytLzYnU=;
        b=Wg8hrBft/bf+V6D1P+Weesk33C1LbbW9meRoBIyfY1NJDchBpBn3NePfYbsTB6esBv
         4hZzox5Ab7NYgZc7Kpio2pp6VOZPLXiIiFeuP2vZRm8arck1gCAGlisgQAzoNi+K073n
         puC4P0hn6G4+yqCYitc+Xp3dbKg+C5GFCS/J6dHyi28ScX8pYSOcmH7Pi12RYfzd4s68
         tNTZow/b6c/NbKnYMHPDQVUlUy21ywEpQIsw35lhyl7jxi26Ldf7AK4HS2lwGLVhDu3S
         LHxIA4046YN6UsyNxd8tJcfsmHFvUfydN4WZv4PFa81F5OtKPHWH5Mk3o0Y8cJJBMKll
         Z4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200530; x=1713805330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wivOzLRmXtJHidm0Hubd14abZ9qXDzBQHr2qytLzYnU=;
        b=u0/hBBpn3yB9qSTayDW7Gke6qqHw4fDu9ol/eHkbQM/n5hk2vj0OUMvPQnL98EcKhT
         6sj29Umxa2pdw45fGE8PlXzhTwizBbsbtwVXF4gPVLZTlDYn3Yfvqpn8Ohkw3snR49Jy
         3FoWutAY4RYq7wivcHJMRBphf/monegJAVkyacNTt1jQZ50YxEALN19PxW4qVAYIYBom
         7+I1KZQfUbSiczwFnvulGDtlpO+ELn/n9WNoHexCDXPbAu/qnNP35o1uHK4u4XE5eq0h
         wshKWCkNc4SgYpVfmE6WE2vlPXA8PNyM9ff1kyzspJfbY7+0e2Pg0vQ0PeqvQ0XLFzTF
         zO0A==
X-Forwarded-Encrypted: i=1; AJvYcCU1Qr/bBv0DdPKrujei32NVS75Bx1F2DJn8EBfJgSyL//w3IcMEKycJG/4iEjXf4aypbntxadcupnC91+2e7KGWAk1nvfVLtQF+mASr
X-Gm-Message-State: AOJu0YxSLBL7uA+ACY54ZQTPVZUmXgsEdZNrbhO2W96I4leXcT8Jb1n5
	QPIpR5yp5SsT5n5oV2wyqRlApL5ENEAcPizxdW6RvnlOArxEyl74suLLQj8AZyY=
X-Google-Smtp-Source: AGHT+IFQgj91jSGw2lUkZcvmJ8fK2VsBYSBL2HSqDtP8zaw7fuUgNF2lymwMr71eYZkL80x3yGmBkw==
X-Received: by 2002:a05:6a00:4f94:b0:6e6:8df5:f77a with SMTP id ld20-20020a056a004f9400b006e68df5f77amr12893462pfb.31.1713200530140;
        Mon, 15 Apr 2024 10:02:10 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm7433158pfm.25.2024.04.15.10.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:02:09 -0700 (PDT)
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
Subject: [RFC PATCH v4 07/20] RISC-V: Kconfig: Select deferred GSI probe for ACPI systems
Date: Mon, 15 Apr 2024 22:31:00 +0530
Message-Id: <20240415170113.662318-8-sunilvl@ventanamicro.com>
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

On RISC-V platforms, apart from root interrupt controllers (which
provide local interrupts and IPI), other interrupt controllers in the
hierarchy are probed late. Enable this CONFIG option for RISC-V ACPI
based platforms.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/Kconfig   | 1 +
 drivers/acpi/Kconfig | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 69cc0509a19a..d8cdb3535e44 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -15,6 +15,7 @@ config RISCV
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_MCFG if (ACPI && PCI)
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
+	select ARCH_ACPI_DEFERRED_GSI if ACPI
 	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index e3a7c2aedd5f..ebec1707f662 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -587,6 +587,9 @@ config ACPI_PRMT
 	  substantially increase computational overhead related to the
 	  initialization of some server systems.
 
+config ARCH_ACPI_DEFERRED_GSI
+	bool
+
 endif	# ACPI
 
 config X86_PM_TIMER
-- 
2.40.1

