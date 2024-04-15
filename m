Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64CD86657
	for <acpica-devel@lists.linux.dev>; Mon, 15 Apr 2024 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200539; cv=none; b=ucYvRuG3MJyNksTp+nrpI+4MXKKIJPSip1A9XnGZF2qVxwe/FGSHI58FSpMeVzHYCOW2jwVC0VcjWcZNFVQKDezcgQlbAhlDj9CkY2ZfANhl76YiKKIDHqn4WQL9LUAztmBj+Ppt7nU5+8UTB9LhCG4IQe6o1XEqCsP84IuzGUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200539; c=relaxed/simple;
	bh=2Gz5QkDmnr7hC62yIyTV6F1j/bp+6gUwdzqqwho4EiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i1/oaSGvHDJOeWLzkZSJtMTxZpddc4C5SKUQP1kzIGzkSsYShStxbWoCmTBD9/xW/TT1XzvsG1jiw0oM1hDzFwtXlyzYchjCfSdjKCKyP6ZuxfK1virWEs/JCt4jHKE3+1PcbRs3f9gTDJASyl6PUzFSutTbTR7f7Av0YKKBtjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ANTCjPON; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ANTCjPON"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6effe9c852eso927697b3a.3
        for <acpica-devel@lists.linux.dev>; Mon, 15 Apr 2024 10:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713200537; x=1713805337; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQjMcgzCCX1zvyyhnfJhjMc7UuQWOWfTm7mVOWGolO4=;
        b=ANTCjPONov84nFjrv72S660K+9HAVtrpN8Hc4VGe7e7lec7/LSucaOBf+P2Opitt9e
         VODdnhmoolmoAzD8haiPQu5rFRw3oYPbO4vqG0yp72sbXVN6uxFgbSjHTymaVe+yE+5H
         9/z0f8SILLeH5TmKdMOqpRgxDSJPRnGGzyWp+IYlX+vN1SXd2qmRZhqJ6gN/O9BxkFRI
         Ww1IjUxF/VdzEmm78TDoQLrdtafzUlDMF8ozh4AKTXZSHcKbE8s+8wehjTzafxEcJ2Db
         MbYDk74xDhj/NwgKTISkiEXYpgBpdGBz6q0In5SSoI4epv56nY1fN0vmdb8VpOCYwi8j
         hmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200537; x=1713805337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQjMcgzCCX1zvyyhnfJhjMc7UuQWOWfTm7mVOWGolO4=;
        b=YYHB80EbM1H9lFxjSya/+xb9hh+ql9lbVBN6JDQrhWsYgxvwL4ag8P8KdOUfiThHRH
         5evUw+tDagmX6fTctcwyUr5QPVVfAr2DzfZsGDsbagtZz9avoU6xztGjse0NeyphFynb
         1C1pkZmXqu01d4kWFkxxaCVGeDd0JCia1HYGxGFweGxQsMX8prmN3uNzh7D7V46gElgY
         qZ7myohuw1YRTQ8CAV3Hnd3XyXfb8wR7a40kdbcVZ0SLpTUQ/gjdyn/mWR8Sc2Wa0oOu
         PqOg2bkpmFDBO/5Mby604TX63Sk7mwWK3oWHicKgWycv3AVtGSyftgcM2zDJeM2HUVAw
         PmTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXepZZygNB6h98wmVa9xOz5597f9L4h3t3EjhFSXd7JQQQw2hD4x+RwgZDa0A/XRCaqTUUltLh0r49oLnTPXvDbQD7UOiVr2pQc8Qn7
X-Gm-Message-State: AOJu0YzWrTQwbrkS+iOk6vNGF5mWJQeD0r1ddK6lCEWpazIzJ4Io3s5K
	bzalMznz/x33epPaZVfk8FCo4LQaeacvuM6JDt3XDsR81Fn8nDRNr4UTwsVoYf4=
X-Google-Smtp-Source: AGHT+IEOKdv2GIoPVzAfszA+Mczkslu8VP2JvMat3iDp2rWUvNRo9ufo+FIpILZ6uWBafbyo9KluZw==
X-Received: by 2002:a05:6a00:2314:b0:6ec:cec1:8fe3 with SMTP id h20-20020a056a00231400b006eccec18fe3mr10562037pfh.11.1713200536823;
        Mon, 15 Apr 2024 10:02:16 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm7433158pfm.25.2024.04.15.10.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:02:16 -0700 (PDT)
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
Subject: [RFC PATCH v4 08/20] ACPI: scan: Refactor dependency creation
Date: Mon, 15 Apr 2024 22:31:01 +0530
Message-Id: <20240415170113.662318-9-sunilvl@ventanamicro.com>
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

Some architectures like RISC-V will use implicit dependencies like GSI
map to create dependencies between interrupt controller and devices. To
support doing that, the function which creates the dependency, is
refactored bit and made public so that dependency can be added from
outside of scan.c as well.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/scan.c     | 48 ++++++++++++++++++++++++-----------------
 include/acpi/acpi_bus.h |  1 +
 2 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index de30a0af7a2f..c8f40d81b6cb 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2028,33 +2028,18 @@ static void acpi_scan_init_hotplug(struct acpi_device *adev)
 	}
 }
 
-static u32 acpi_scan_check_dep(acpi_handle handle)
+int acpi_scan_add_dep(acpi_handle handle, struct acpi_handle_list *dep_devices)
 {
-	struct acpi_handle_list dep_devices;
 	u32 count;
 	int i;
 
-	/*
-	 * Check for _HID here to avoid deferring the enumeration of:
-	 * 1. PCI devices.
-	 * 2. ACPI nodes describing USB ports.
-	 * Still, checking for _HID catches more then just these cases ...
-	 */
-	if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID"))
-		return 0;
-
-	if (!acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices)) {
-		acpi_handle_debug(handle, "Failed to evaluate _DEP.\n");
-		return 0;
-	}
-
-	for (count = 0, i = 0; i < dep_devices.count; i++) {
+	for (count = 0, i = 0; i < dep_devices->count; i++) {
 		struct acpi_device_info *info;
 		struct acpi_dep_data *dep;
 		bool skip, honor_dep;
 		acpi_status status;
 
-		status = acpi_get_object_info(dep_devices.handles[i], &info);
+		status = acpi_get_object_info(dep_devices->handles[i], &info);
 		if (ACPI_FAILURE(status)) {
 			acpi_handle_debug(handle, "Error reading _DEP device info\n");
 			continue;
@@ -2073,7 +2058,7 @@ static u32 acpi_scan_check_dep(acpi_handle handle)
 
 		count++;
 
-		dep->supplier = dep_devices.handles[i];
+		dep->supplier = dep_devices->handles[i];
 		dep->consumer = handle;
 		dep->honor_dep = honor_dep;
 
@@ -2082,7 +2067,30 @@ static u32 acpi_scan_check_dep(acpi_handle handle)
 		mutex_unlock(&acpi_dep_list_lock);
 	}
 
-	acpi_handle_list_free(&dep_devices);
+	acpi_handle_list_free(dep_devices);
+	return count;
+}
+
+static u32 acpi_scan_check_dep(acpi_handle handle)
+{
+	struct acpi_handle_list dep_devices;
+	u32 count = 0;
+
+	/*
+	 * Check for _HID here to avoid deferring the enumeration of:
+	 * 1. PCI devices.
+	 * 2. ACPI nodes describing USB ports.
+	 * Still, checking for _HID catches more then just these cases ...
+	 */
+	if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID"))
+		return count;
+
+	if (!acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices)) {
+		acpi_handle_debug(handle, "Failed to evaluate _DEP.\n");
+		return count;
+	}
+
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

