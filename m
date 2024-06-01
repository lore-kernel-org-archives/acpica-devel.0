Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3D9152E1A
	for <acpica-devel@lists.linux.dev>; Sat,  1 Jun 2024 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717254306; cv=none; b=RSWHwvovanCz0lBOWm+EL5Mih/rhqJ6JgluVSRC9VZy7Smul0DdqP64ulMDJALd8O8lrV2rQAmKThVXbIICByJ9UWZqBqsId23GhgDU+MqLw8t2qQDYlxAiwgDLAjck+bxGQIDJiz0DP839M9A27ONU42Fg5K0G3uaRdZEhuoBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717254306; c=relaxed/simple;
	bh=gUZ5nlwTeV/W2GAxqRBkwnxWUnWQmkvoylnNCHneLXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DGS6A9BVBBD+D1msMSFhXeQ43UjUA9kDxt0P6rva7r6vADIey/MgVnjhuM7juU5VghRZxY3bn3sIZ/n/Dzf73j78z6R5Lu3F9xubeCz3Yp4jqkfgwicpnYRlqWtToqKaWjWPtZPRmgNtEBb1o9h8lojGTdTMGfYAZHylYHvY5Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=plkqV33x; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="plkqV33x"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3748aa28d0fso7433835ab.3
        for <acpica-devel@lists.linux.dev>; Sat, 01 Jun 2024 08:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717254304; x=1717859104; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/CsLBy86VnyNo2isQPCT1WZPGBpvem+xh2ISHmLXVs=;
        b=plkqV33xck/xeKMeMZygJo7LWB7J0N3Vbb74bcFxf6uOojeUk2S5xAE91Riwf29Wu0
         jVU1Zq6ZZ51PTW7/VhDhbP6HeWwSc0m4KnKgSebrrYU3o1H7ujhPhOd6Mj7dHQYE9oCH
         n5//YvpjXUhNSGFpYWp4VWwRG2V8zeZpaV98PGH2De/akJ5QRuqQ0o1L3iQ6snUdNtj1
         aEZP0CrpD8Ejz8flptfWa+TgRsGPNKP634OyELI5eTZMr+PjCmtuwhRCtQdnix+JX4fr
         S0as9d0LWjmE2ueubM3ZvDVWcwRU9BLeZbSp8hHcPaMhYPg5eWrvIgZHVZ13kBzAv6gS
         JDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717254304; x=1717859104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/CsLBy86VnyNo2isQPCT1WZPGBpvem+xh2ISHmLXVs=;
        b=gU2+d8zFyvXoC/yJupg3a5D9ByhRzV/iiaLz+UU7zA+csiaYsmd9LBfGhftQSyJkCw
         L4jkuZgstonmieY8lFjo+htb6QocWiUEa9JUeKJoYa+rNMp+qWKx055DLTHHv8h6+8BD
         R8PUniKOwlMmUv9qZjElHd/iG35jMsu9A2L8Bvvf/Wji5FgnhvUbovwo1hNOAWr3gih4
         YMzB76XDRVqsH2ROjcECIIysziALFhruWHpIE1wE5mf8WnFgFbfh8ozq29MaE8ZdF3a9
         zaYPGIOm6irfoyZHv60F536EtQ0UFBhEzegdpucVyy2tKA6vbI6D9Zp4XKWrDmrNQQrg
         wCgg==
X-Forwarded-Encrypted: i=1; AJvYcCXhtNLIK9Q14TNsqQ20E2O6gpHgO/5MwRVKoew/DsxUJxSUkNbLlbQor60EboEt3S22WLQe2b0+4pWjxpCwcr5rckL//73XOuOcoQCt
X-Gm-Message-State: AOJu0YwU2vzqZAU/WjeNPRGw7KrVVb8dEB3AYEi7aEQdbeRA0ERQXCRV
	1equJl+qdW9noTaX1p3cgITXEJJ813Gzd64LTi5sNROE8rx2UxKGvbZqPRilbEQ=
X-Google-Smtp-Source: AGHT+IF3OVauvlGO1nxR3XDABScTnbIuW6VxwtguVbngDcxS9MthKKzwc9GQNZ47KhPfz+utEVmKGg==
X-Received: by 2002:a05:6e02:1a63:b0:374:5672:6791 with SMTP id e9e14a558f8ab-3748b97ee00mr54534805ab.8.1717254303897;
        Sat, 01 Jun 2024 08:05:03 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35a4ba741sm2559410a12.85.2024.06.01.08.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 08:05:03 -0700 (PDT)
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
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v6 06/17] ACPI: scan: Define weak function to populate dependencies
Date: Sat,  1 Jun 2024 20:34:00 +0530
Message-Id: <20240601150411.1929783-7-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240601150411.1929783-1-sunilvl@ventanamicro.com>
References: <20240601150411.1929783-1-sunilvl@ventanamicro.com>
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
index 6f3152170084..918e71fc54cb 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2068,11 +2068,22 @@ static void acpi_scan_init_hotplug(struct acpi_device *adev)
 	}
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

