Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549E7847B
	for <acpica-devel@lists.linux.dev>; Mon, 12 Aug 2024 01:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723424409; cv=none; b=cSd2bt2QYo0lpOlUPskfnFtlPdh0rDEFi81q7/Cx9Q6XzoEzR5DQ0SIIK2L0w6l/BMffiKiuPmB16YsdgiNfWvMugc/vtsGqzaat/Pk4KFl0hkkZtECRfElchewdSsqK6XylCl0H/6JQ9UsYgTXzIxYl9B3yO5+NsrLruTjy1RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723424409; c=relaxed/simple;
	bh=K0yy2Cz0AHQ22O/DOvVoBVInCMziuYu5zVI87ewmQhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ixty/m8bEbkgZ1rtIoI+YlZYceRitC9feA5Ymv4JcbPVd0rPXHaK9wSMPfyUTF7xPOyhErbKhxAKT4LuotKaSL5buCmeTXndg+O+tLRKGLL4/IhvLhhJ65ecq1nriV9+9Cn3HwmBmRBwkjSVn5poH8XGq3JMg0lb+AAjhmPhI+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=EAEPsR29; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="EAEPsR29"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3db22c02a42so2489008b6e.3
        for <acpica-devel@lists.linux.dev>; Sun, 11 Aug 2024 18:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723424406; x=1724029206; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fg7MKJMwlR+eRmszvFqgWwl0l7xFjetJlLXQ4McHDXI=;
        b=EAEPsR29FrX0HA6OrmyLJ+aHpAcM3OyaWe2rm1DDz8jZz4ioQZku6nXK6Ha3DSrvap
         UOyjGHQI+P0dBRt7a+oVPqwjaGZLZi5/2HYA3oBtfUrU2mx+JCQ1azUQQvjDJA8AJRMs
         UKLSIZQV5N26zJrRKsvBQq7nHqT0hmkkC8i5ByWMgzdoCiJzhuFKRNd5uQltfiAxowiE
         gPmj3zZ0szd4KKJAKdhMHmwEshr2lf7WkWXtBvoPH8ghKqjKmbXlKGzPdwy6JWAh7ydC
         UxHjNtDqpW/u3btMK8oHvaZYBaE5zuz6lHKKT5zFMVoyDflAaOr+AaQflaSUZhG1lIS4
         3yrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723424406; x=1724029206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fg7MKJMwlR+eRmszvFqgWwl0l7xFjetJlLXQ4McHDXI=;
        b=uGXA/sCvlFIZOcePxu9H1anQBaCqijiXHDBQYW7rYgoc9cETTyA1aISa6x7ZAF1Mtt
         ilZ99klEMOukL8D6iC2nHfUh6UJweu/sfRFqOxfZK6Uy3iWAmeq/6Pi1RyYMAN3C3pRY
         KVHeDD2Em/48fG+A3Dqj7KqcZAUP9oHhyojHs/2LkMCffdXIIgaOogqh/MemmrMegZCQ
         xmeG/RcqGsL/1PmJUfNIzSNennedua07SBCpoJjH0DupHmu7pzXeZQ6i6tqNuzO4gVCR
         Gi6aoQaAdu4f5Uw05zSsq/H/b0fca9KNJtPFbCpFxxGHUlfTPZoAIflmdlSkXBc2D23Q
         v5tA==
X-Forwarded-Encrypted: i=1; AJvYcCVmYIFBdzMW6j0c95LazTmFNmBDXA5IQrazqbdXanTClwrMqD/0BBsPaAFLOzSNfH6ApWGlLRxKwv+Fm30xGl34JC8Pp2HxK2E56sQU
X-Gm-Message-State: AOJu0YxOXU3WhKSd2NKGc4efFOIMuVF5xDO+HXs8/L7ml1lnMuQ2vLTc
	HFF+5+9TKPH0aVedqH4Pmx0BSARnhLPp/Xc75MehHU8BoE5EITBeuiew2m5xrZY=
X-Google-Smtp-Source: AGHT+IFq/2aqIFIbaZVtORXZ4ma22Wclt9l+I9epH3oTGlfkp+sVOBf6L7LmmBy3q6/DeC+M+tbDQQ==
X-Received: by 2002:a05:6808:3a07:b0:3da:a16e:1764 with SMTP id 5614622812f47-3dc41667c8fmr8781731b6e.4.1723424406285;
        Sun, 11 Aug 2024 18:00:06 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe8cbdcsm3074062a12.61.2024.08.11.18.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 18:00:05 -0700 (PDT)
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
Subject: [PATCH v8 04/17] ACPI: scan: Refactor dependency creation
Date: Mon, 12 Aug 2024 06:29:16 +0530
Message-ID: <20240812005929.113499-5-sunilvl@ventanamicro.com>
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

Some architectures like RISC-V will use implicit dependencies like GSI
map to create dependencies between interrupt controller and devices. To
support doing that, the function which creates the dependency, is
refactored bit and made public so that dependency can be added from
outside of scan.c as well.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
---
 drivers/acpi/scan.c     | 86 ++++++++++++++++++++++-------------------
 include/acpi/acpi_bus.h |  1 +
 2 files changed, 48 insertions(+), 39 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 52a9dfc8e18c..374cae4aef78 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2013,6 +2013,49 @@ void acpi_scan_hotplug_enabled(struct acpi_hotplug_profile *hotplug, bool val)
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
@@ -2035,8 +2078,7 @@ static void acpi_scan_init_hotplug(struct acpi_device *adev)
 static u32 acpi_scan_check_dep(acpi_handle handle)
 {
 	struct acpi_handle_list dep_devices;
-	u32 count;
-	int i;
+	u32 count = 0;
 
 	/*
 	 * Check for _HID here to avoid deferring the enumeration of:
@@ -2045,48 +2087,14 @@ static u32 acpi_scan_check_dep(acpi_handle handle)
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
index 8db5bd382915..d6a4dd58e36f 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -993,6 +993,7 @@ static inline void acpi_put_acpi_dev(struct acpi_device *adev)
 
 int acpi_wait_for_acpi_ipmi(void);
 
+int acpi_scan_add_dep(acpi_handle handle, struct acpi_handle_list *dep_devices);
 #else	/* CONFIG_ACPI */
 
 static inline int register_acpi_bus_type(void *bus) { return 0; }
-- 
2.43.0

