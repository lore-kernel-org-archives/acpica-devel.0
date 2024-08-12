Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A4863D0
	for <acpica-devel@lists.linux.dev>; Mon, 12 Aug 2024 01:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723424421; cv=none; b=WyS2/aeo0MQhLlQt4QUepM7uRJ7oQrE/E9Ux7WCNJanfBxoyUX4RE+9FWU3LHtTCZLWLFprfDTvTTdjahMPZ1VmucQIAVtln6lT/SLcPuuPgRd87HtILgvG19AbqwAe8mf9cIlt936zVM1OTiVsdm8RyLiKfme7WwBgVKUzQ54k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723424421; c=relaxed/simple;
	bh=zrv9AUs5Cq6Bk8OZWZZlXW2L//FNGQ0gb5DlOwPjduA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LcL6tEcm64zkFJHhgc8ubqZypeaw3B9fUvo7zQ4dMvfYMkTkLfj7dmnG/wQqf1gIYzC3Jqd31xfHaaT8u09zmprHtqmrirDlaYCbajV6owUUN8psZDFBXQAaYdoRBp0TDwxCFMAYD2ylEqINW6IRveLAb+Z7zMIirO22WyS8Fis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=BBneDGpl; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="BBneDGpl"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3db23a60850so2963653b6e.0
        for <acpica-devel@lists.linux.dev>; Sun, 11 Aug 2024 18:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723424419; x=1724029219; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVnO8D9tH0sab/WeUvbej3ReIYXoTsQSEaRkiw5yKWo=;
        b=BBneDGplvkq1Wtt2FCLuvTyZqYI3x2Ckc3CUvxHmVDV9Ko0LPBZy3omlgQXxf57aYQ
         9/nzL4qu6/pJE8e2tpUgnWE5Fswi0tEVK5fFd/TqdZq73xw0KiXgnb8DDqMcbjw6kNsG
         GcuCK1kLz/qaQgOWItYqc0b8d7M5VAmqpWjFdkUz5rlDJZUNUXKjrndSYJD4Ipkw0/pd
         V6lx+qfknIyY7KjDyjR4ZtxfCxKgm5hrw05WD1lYGhf9iTddqExAy2okG2chluGIO0hq
         d/MUFYKuvafT4eE7JR873Z5SZ1E8kuTZmFWWv+nn0bGRfU6+Ma1zR/Wvbo1W2TCZH7Bn
         5jGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723424419; x=1724029219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVnO8D9tH0sab/WeUvbej3ReIYXoTsQSEaRkiw5yKWo=;
        b=lVPDy/afMlXSVOgcaW0NE0pDXeWmY3HHY8t7j2Dbwc04FSpUurKpcMzqCGmSRqGOrP
         1J05V7gop4lMEwLeCGv5Uq+HvHrGR+j6NRJVtuQuIaG1tx1yZTTjf2GYHMFzn2MZVV2P
         TxllnavRqN7DShgtrKMyFOQ7TwwGlOk2DqUFSZisWn/Us90G9GqG0E/9XqmLGwiJ/Qy7
         Ff7kicHOZLy0aGaxmdHHT/GE7pjSLcqYmLyyXfr/BPpi9JREDiDaUoF2N+9aa1eGn8Kz
         MgmDe8e1vY2s5nC1tZrVnthk5sObYKe0LDAIeFkRshqiQrbBHvhh1pnacnqVIo9gKcEE
         Hr9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDtKclqPCGcmzlFfuCSmcgFIeHQA55jtb7XfVHjFfJVQsxr7uXYK7UMX7DwU5NtG9HvYLsR9ww7T7/BHNpWPVXQ3eHO88PRWlJqzT6
X-Gm-Message-State: AOJu0YwnoztBcUnzx51Ysrza8vK3njdXp4bGQeqZOlkkTvy38H5fXHjS
	SnRh4AOM+jAZW4iETd9hPTucjhO7QTLPZxeaIWJFH1+PiQhcfFI6FOw9b9Fc14DHF8/vtDeH/2U
	MvaOONw==
X-Google-Smtp-Source: AGHT+IGgnQrX14dxOj3yn291622Lxvm1iCgbP6yN6u9XpX8bxmUnRZf2Nt8a7HJ6YawHB1+ioO6EHA==
X-Received: by 2002:a05:6808:1513:b0:3dc:299d:c4fb with SMTP id 5614622812f47-3dc416ec02cmr12205900b6e.40.1723424418770;
        Sun, 11 Aug 2024 18:00:18 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe8cbdcsm3074062a12.61.2024.08.11.18.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 18:00:18 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
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
	Haibo Xu <haibo1.xu@intel.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH v8 06/17] ACPI: scan: Define weak function to populate dependencies
Date: Mon, 12 Aug 2024 06:29:18 +0530
Message-ID: <20240812005929.113499-7-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812005929.113499-1-sunilvl@ventanamicro.com>
References: <20240812005929.113499-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=cp1252
Content-Transfer-Encoding: 8bit

Some architectures like RISC-V need to add dependencies without explicit
_DEP. Define a weak function which can be implemented by the architecture.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
---
 drivers/acpi/scan.c     | 11 +++++++++++
 include/acpi/acpi_bus.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 39b3ccae9f79..28a221f956d7 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2077,11 +2077,22 @@ static void acpi_scan_init_hotplug(struct acpi_device *adev)
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
index d6a4dd58e36f..af72a5d9de99 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -994,6 +994,7 @@ static inline void acpi_put_acpi_dev(struct acpi_device *adev)
 int acpi_wait_for_acpi_ipmi(void);
 
 int acpi_scan_add_dep(acpi_handle handle, struct acpi_handle_list *dep_devices);
+u32 arch_acpi_add_auto_dep(acpi_handle handle);
 #else	/* CONFIG_ACPI */
 
 static inline int register_acpi_bus_type(void *bus) { return 0; }
-- 
2.43.0

