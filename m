Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86193152536
	for <acpica-devel@lists.linux.dev>; Sat,  1 Jun 2024 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717254291; cv=none; b=hzD6eEUVE3lT+C+0rbpbVL5H/FPFmugfk7QmGve2zoEhjOAnO8H1XWQr3Z4c6ftkLgKPpv3KvWO7D+g/U66DrSq0or2keCPYhDdBIQ1ucBnJwyBKi8+EXQat47dOOSJoMpvQa32+lcrGizrXrH6gv3YInIAOd61bwcWtDVAELsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717254291; c=relaxed/simple;
	bh=w8tlK1a9yLZeLFHvsoySlErb7PynOFkH2SuqLxkF9HM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YDEf1kmwcF+DZf0KfF3TpDT9B1onE2zvFCbwzDinpsUqwoJ8B/qY8j8SbexYI0l29KdsIRmdgJr9Gn9g2bRMK8KG9CYH3XwUI9SyCylCePOD+OqRgCe9ORT1iKcSmnJInfWgxoJjAX0kxEVEUavEqf0xRQnq1itAfPJt/FDHG74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ECTEYblR; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ECTEYblR"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-656d8b346d2so2118734a12.2
        for <acpica-devel@lists.linux.dev>; Sat, 01 Jun 2024 08:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717254290; x=1717859090; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Jv6JEZTD9c0qG8hE1F4MREKLvC6gRJSU0R0wzEFNGA=;
        b=ECTEYblRzWpfLTu9lbssa20T5I9CoxIPEawd/C9vmWWh9fa68MvCy99cuFYTZQ+eY4
         qBPjysYnn0CVypoWIMRTStW3TGvYfVMeghInB0ATG/yFmgRdYWf/tieB2KmVfppUD4KZ
         LkYLL3YofTwo+ftm+Iz/k6pTzxyExWlcrSebxozpaA2DPkE5gEUhtni93bKuVKQtUx1i
         Kkiji/ybR2n5ASxEzkLmZANPoeB/Z3PQrf20ObnBN3XG2cm1o6y56kFWoRQSTObwjC+V
         O1Q/BNAOFRSEaerABZYESc01tChpSAv/ElDgQh10B6lAslRBjdQaGZRV8ISW87g5kfxb
         0wlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717254290; x=1717859090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Jv6JEZTD9c0qG8hE1F4MREKLvC6gRJSU0R0wzEFNGA=;
        b=PWUCd+dnp1JZqrBTlOwii9RL8nhAasGDuWOchizkAFZlb3yKsTODUACC6H3iyrp47d
         kP2Xvtbvf6zE8cavWJV/peMuJmc03f1y69DFui512phhY2rMjn9PZR9wah16l6Se17In
         Zmzzp0ZkqUL/VIcwBWKgyLvq7oJKcidqq0e8X8sSTUEUNjI88JZlEExHTrRK+TNgROkc
         5dmh14ooq5xy5Mrrm4BFFaGt5JUWfly8bmTDW9PSehQPC2QGDRZ/wfJ089ZPE4oR9M5x
         zfx0/lKtmqFcgLAFVbvSY7YlrkG5WWtlSn9adGMBYw9LzQu2rQFFlQ5OZsJgSOHvIjms
         u9ug==
X-Forwarded-Encrypted: i=1; AJvYcCXqasoGhl2UhUj0MCEWAIc1dTMnYtGttMbq9PKq6R2vDvZzYuMl0kxsikL8XwnedDv6A7l/HpJuk8y0t+4asI0E+0ZUxeon4x9GRvfG
X-Gm-Message-State: AOJu0Yyqo6IjCtppATvNGO2Hg+9pE0maOMOBf5x9rzwBRoAyAqAyNIW/
	lDErBYZU1IDMyDVDrU2HRP/Yts7vCo+lxlbuD6cqR11Ok6nKHhzDMhSdDA5UjuM=
X-Google-Smtp-Source: AGHT+IGJ5D/8YHeQidHdEpKROK/FOw4K97CAfABtSV0CK04hYyLyYdtbkd2DgCCxUap3/7WmNzvvWg==
X-Received: by 2002:a17:90a:9a96:b0:2b1:817d:982b with SMTP id 98e67ed59e1d1-2c1dc5701fbmr4453498a91.14.1717254289850;
        Sat, 01 Jun 2024 08:04:49 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35a4ba741sm2559410a12.85.2024.06.01.08.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 08:04:49 -0700 (PDT)
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
Subject: [PATCH v6 04/17] ACPI: scan: Refactor dependency creation
Date: Sat,  1 Jun 2024 20:33:58 +0530
Message-Id: <20240601150411.1929783-5-sunilvl@ventanamicro.com>
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

Some architectures like RISC-V will use implicit dependencies like GSI
map to create dependencies between interrupt controller and devices. To
support doing that, the function which creates the dependency, is
refactored bit and made public so that dependency can be added from
outside of scan.c as well.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/scan.c     | 86 ++++++++++++++++++++++-------------------
 include/acpi/acpi_bus.h |  1 +
 2 files changed, 48 insertions(+), 39 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index b325b297bf77..66038fc731fb 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2004,6 +2004,49 @@ void acpi_scan_hotplug_enabled(struct acpi_hotplug_profile *hotplug, bool val)
 	mutex_unlock(&acpi_scan_lock);
 }
 
+int acpi_scan_add_dep(acpi_handle handle, struct acpi_handle_list *dep_devices)
+{
+	u32 count;
+	int i;
+
+	for (count = 0, i = 0; i < dep_devices->count; i++) {
+		struct acpi_device_info *info;
+		struct acpi_dep_data *dep;
+		bool skip, honor_dep;
+		acpi_status status;
+
+		status = acpi_get_object_info(dep_devices->handles[i], &info);
+		if (ACPI_FAILURE(status)) {
+			acpi_handle_debug(handle, "Error reading _DEP device info\n");
+			continue;
+		}
+
+		skip = acpi_info_matches_ids(info, acpi_ignore_dep_ids);
+		honor_dep = acpi_info_matches_ids(info, acpi_honor_dep_ids);
+		kfree(info);
+
+		if (skip)
+			continue;
+
+		dep = kzalloc(sizeof(*dep), GFP_KERNEL);
+		if (!dep)
+			continue;
+
+		count++;
+
+		dep->supplier = dep_devices->handles[i];
+		dep->consumer = handle;
+		dep->honor_dep = honor_dep;
+
+		mutex_lock(&acpi_dep_list_lock);
+		list_add_tail(&dep->node, &acpi_dep_list);
+		mutex_unlock(&acpi_dep_list_lock);
+	}
+
+	acpi_handle_list_free(dep_devices);
+	return count;
+}
+
 static void acpi_scan_init_hotplug(struct acpi_device *adev)
 {
 	struct acpi_hardware_id *hwid;
@@ -2026,8 +2069,7 @@ static void acpi_scan_init_hotplug(struct acpi_device *adev)
 static u32 acpi_scan_check_dep(acpi_handle handle)
 {
 	struct acpi_handle_list dep_devices;
-	u32 count;
-	int i;
+	u32 count = 0;
 
 	/*
 	 * Check for _HID here to avoid deferring the enumeration of:
@@ -2036,48 +2078,14 @@ static u32 acpi_scan_check_dep(acpi_handle handle)
 	 * Still, checking for _HID catches more then just these cases ...
 	 */
 	if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID"))
-		return 0;
+		return count;
 
 	if (!acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices)) {
 		acpi_handle_debug(handle, "Failed to evaluate _DEP.\n");
-		return 0;
+		return count;
 	}
 
-	for (count = 0, i = 0; i < dep_devices.count; i++) {
-		struct acpi_device_info *info;
-		struct acpi_dep_data *dep;
-		bool skip, honor_dep;
-		acpi_status status;
-
-		status = acpi_get_object_info(dep_devices.handles[i], &info);
-		if (ACPI_FAILURE(status)) {
-			acpi_handle_debug(handle, "Error reading _DEP device info\n");
-			continue;
-		}
-
-		skip = acpi_info_matches_ids(info, acpi_ignore_dep_ids);
-		honor_dep = acpi_info_matches_ids(info, acpi_honor_dep_ids);
-		kfree(info);
-
-		if (skip)
-			continue;
-
-		dep = kzalloc(sizeof(*dep), GFP_KERNEL);
-		if (!dep)
-			continue;
-
-		count++;
-
-		dep->supplier = dep_devices.handles[i];
-		dep->consumer = handle;
-		dep->honor_dep = honor_dep;
-
-		mutex_lock(&acpi_dep_list_lock);
-		list_add_tail(&dep->node , &acpi_dep_list);
-		mutex_unlock(&acpi_dep_list_lock);
-	}
-
-	acpi_handle_list_free(&dep_devices);
+	count += acpi_scan_add_dep(handle, &dep_devices);
 	return count;
 }
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 1a4dfd7a1c4a..28a9b87c23fa 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -993,6 +993,7 @@ static inline void acpi_put_acpi_dev(struct acpi_device *adev)
 
 int acpi_wait_for_acpi_ipmi(void);
 
+int acpi_scan_add_dep(acpi_handle handle, struct acpi_handle_list *dep_devices);
 #else	/* CONFIG_ACPI */
 
 static inline int register_acpi_bus_type(void *bus) { return 0; }
-- 
2.40.1

