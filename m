Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8461272C6
	for <acpica-devel@lists.linux.dev>; Wed,  1 May 2024 12:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714565932; cv=none; b=cXrvvr06oLryJPe6wQPBY1dJGfuDFDakZt2mHSt9fzJtV2FaZwZIyr/+RQCG9q03pcojL8Cu5eZ3vkIdkb7Qu2XmXodHUV04oshvo8gpL5NiULzrylJzZOxzUzHGZXGn9wIoJPB4zsaFL0yv6PoWa3gU8917wRQe9Qk053hnPOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714565932; c=relaxed/simple;
	bh=p3PlpHNinxzAsGkdtYqlBifL18TCbYSIHjqjLs8QrEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IzYtvxqfdwdMsZUdM3bzzMGkxvxX0pL645E/e4mG8stLYKv+6YKTXX9nGchLN9NSAP7sllpAJf10g225953iohzdSecq609WV6vJ+P7bZHtoX/LD1oAH2wxq7EoWao8Hi52KgdfEJoc2iowV5L8lSRe3xyeWpOoQP6yy7oc7C6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ZhA8TGwL; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ZhA8TGwL"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e4266673bbso60763175ad.2
        for <acpica-devel@lists.linux.dev>; Wed, 01 May 2024 05:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714565931; x=1715170731; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJK7HUkOtgooa4XBRIgNv++I9VXVR1Nc/x5AlB9DEr4=;
        b=ZhA8TGwLFjbxzGrVMnl64aQ0Tx/Ydh9xyaKn1zRprm0kZOt2OYACbBdKc+VoOuh5kV
         suV6jYTBstHCX+ZxLZPLjF/iFFclt5kJZ+wXeALaIxzs+HNLyjqYKCKJQkQ8io2TVy9D
         gTT3syykUIGkaz6O8EzeCQb6pilXVdRdA/piJ846Y6t/nymKMhs90XFCuOLXuEj8oNIV
         OBRk3602Mdi8OJZ+JOQUhrJIxPsiyYABQA70l9NhNchzOn/eDeYtIAuxObj91lPNRUcY
         +k9VhmCcD1Gkeu+OYJghdduU46eacaeRZr/C21zd9OoxZin3kdIOT2kI2Z63nhJ/rv9D
         4AgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714565931; x=1715170731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJK7HUkOtgooa4XBRIgNv++I9VXVR1Nc/x5AlB9DEr4=;
        b=QpgLiEh8kXg1lx5Mc/sIU0m8ImhudKJX/TwrkhQVo6bYnPaIQphH721RT3OBXk6zVh
         gkpWjacvsJesSK/HB5jjQQ0ieRJiIenBxnjlQxrerbraOfQDnvBTjvfSTZGiehF0hbZK
         8Klv8fXxvaBvVXoJfMKUd5mu45uqyK8MZ0xX266/ifn75PEMOhsG7VRG2fLPpRxEVsHR
         izbKWVcDcevTo8LkXN39QSCbJ5XUdjF3Nv9VEB9FiTIicPYpEsQTgbiB2+e7qqGxSuYk
         baQC3ae+KmrhdwRxLdFe1aUd91U14wEaBAlwpsYW38UA0YwD5VKWtv5zjs87yG8QaHCV
         6gKw==
X-Forwarded-Encrypted: i=1; AJvYcCWqAnNmdJ0z87in7tqc9qr+QzAOUhBQdf0F9q4ZlYCGa2KoaNBvXyvLB4mPNoCNRbjrUNeXJAlcACRhsim8f5sd+S0928rF8Lb/RElb
X-Gm-Message-State: AOJu0YymsegjGGpt1qRayEH1xx9A7M6cDEwMxKo1rTph4E3rWOpJzF4U
	CUua8XMlxdxqzTpuyrG/4QqBukm1X2XPHCulMQb1XWa5+Ei+jbOEyXEi35NKYk8=
X-Google-Smtp-Source: AGHT+IHqQHwdtyucv9ZMhP/dVbiOcapAJDdX24SUfAiXrmEd3YjBfB6sjT+VYhoitv18fuYmxMjC0Q==
X-Received: by 2002:a17:902:eb4a:b0:1e9:470:87e6 with SMTP id i10-20020a170902eb4a00b001e9047087e6mr2178199pli.23.1714565930746;
        Wed, 01 May 2024 05:18:50 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.106])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001ec8888b22esm1336900plb.65.2024.05.01.05.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 05:18:50 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v5 06/17] ACPI: scan: Define weak function to populate dependencies
Date: Wed,  1 May 2024 17:47:31 +0530
Message-Id: <20240501121742.1215792-7-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
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
index beded069cb0a..3eeb4ce39fcc 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2068,11 +2068,22 @@ int acpi_scan_add_dep(acpi_handle handle, struct acpi_handle_list *dep_devices)
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

