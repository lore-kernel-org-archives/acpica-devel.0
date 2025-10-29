Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422213321C6
	for <acpica-devel@lists.linux.dev>; Wed, 29 Oct 2025 11:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737277; cv=none; b=rY4EnAvBCQA564Gy6EvpiCpTJex2a/Q4ADRD/rOV/S9wkZ/OWZWXKoNBAjDrob5EHsVQ6QHH0IhTIgiFn4YqLzyrTUTkXdu+5uiojm3jC+dsDXQUFaiw31nabxA1OsFo80gdlTR2PXyPx9oF7bhlRjP/arIiDcd/+mohrFHEEQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737277; c=relaxed/simple;
	bh=iaxzzzfbF/Bf+RL8UjVT7dkfdCOWfh0hkHaopBJWsmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqffCtGu0C0NFN55hWW7OoVUorDkU2V58nunir4q3kCjmxluhpdT3Ji/FPo2W/POqddCx8Ocy2Sx8aHFH/7CnF6CGw/LPEZmVZ5I37fTKe/lealDkwv2GK3pyisD8RSUTVAaipc7SpLqULxhSduLXPslSJF5DdUW+o5VcRVmaUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=kRekIC7o; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="kRekIC7o"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33ff5149ae8so3340981a91.3
        for <acpica-devel@lists.linux.dev>; Wed, 29 Oct 2025 04:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761737264; x=1762342064; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kp1nIH/UcUWGrGQTMqAlrnMpZhTNysKVdYoaQCQ6E6E=;
        b=kRekIC7oYJyP3XJtI5Y+tl35FseXnQr9UkTswnAdkdikITOOjzNLkqu1EPEQxf+mkT
         xq46wKMMBFUH05g5zEyzL2qZv7CZMYOdllTVBORbwWZx+KqGzFI3suJCVt9C6njIQW1p
         2ayUeLLD8dr1aruQBTgIvJejFcgN0MW71jQuIfGek8sqmN/ErMak8mG+Z5HjbLq5YAjf
         HqH9PY9QTD77aL1g0I/klp2HaLaoqwjCTiFvo71fbMY8dg7yDrhTM9EPo4ihgfvE/2lT
         5nLkxXsta4rrIX8vDhT4h1fqEUnbtiEZZjCaqIDOwuvELuwIss1BBJdiI4dwyJnDkfbo
         iBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737264; x=1762342064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kp1nIH/UcUWGrGQTMqAlrnMpZhTNysKVdYoaQCQ6E6E=;
        b=B7hB4Zy0fiAvH9xmW3R3f5tcZrwtM2aIePBZ8Qoj47xJ94d3f1Bq0XAzmD5iJKTbEb
         zmc3ARJBsGZS6mr1I9J7wt1/C6AUN+MqK9UhUG0Q6qSTr5ZyaBFL5t7lmHe++AArz5r3
         fyan1YoSY4WU+dH4ZeChx38G8O5FrxmHZt22YxY/VUBFYvz30pMdoh20ceSStAVZVt1R
         /nEo4FZNyejWxaRbXyP1LmofHTP8f5P/H8yreLAHX/mCs7eEipYco9paZ4Ow6kyYoCHn
         +lQmEgyCzuANmP5/LEYNUs5pkMIVWtJ9nbNgRGUeI7vIUkE1iZdZazz/YPnU6jbAcrBD
         d85A==
X-Forwarded-Encrypted: i=1; AJvYcCVsX1rs10Mh4FkaFxG3u+0jHt2OovDlxEr03/IBMWWUlZzZ1ZIkwEXwkzKPkbVCFUdVlbXAsuRwlsnw+uc=@lists.linux.dev
X-Gm-Message-State: AOJu0YxS45WmsOTZ/Y7S/r1fEEsH5BL1XdvG0+c4qmdhEMtHSnzwG9Fg
	lLwmI0l8nS9BvHUxylQ6dvmBlrai6SIlqYM5PCgEaeK01FChmWsgqBbE6o55ydrce0k=
X-Gm-Gg: ASbGncuOWXmAoqeXvvHg94N1EW7/NF9YDhUAQ6sHL0jFH+HMkZKELDghdy2+bQgzgLH
	R3+3FUupRm3yX2hVxG2VnAtjp/NbWVYkteXQ6WV4sOXifTDPHdyCzUo5yzWL+HWqpBs2RSek0Et
	7DuDegU4PB3s6RZrbOGnSukpYALfS8kvDZRZwMKsLPiyd57AIWT+r8/oMw7DNCYyYuYFy/82rBu
	1VEpbPDovt6zPw9qd/Sk9E99hS7pdRlSXUaxSBOQe39GbUkfNHdsL7PcUAMZUpV9KPV1yO1GfJC
	WJduItmn6/ghNgQmBw4Y3bQw7vRT3WQTrqawfYimHvx5ggt3tYTb+WEos0zNpKPZlTwbWllFLTD
	OOLzjvU6yNAMdAf0SuHSS/rRITdaFs5Upp8iWaMCNIxvORq3byb7m2nLu8GuIMGLQr1zaMUgUHL
	01ZHN7EK+dv4U0ANdMlhTTiEo8qh78
X-Google-Smtp-Source: AGHT+IFARlQT4wxU5rIAA9JBJXOgqU4ng9/zvGb3HdF6wqemjXQ0P2gKhLivhx1oGEPscd3xyn6Eow==
X-Received: by 2002:a17:90b:5188:b0:32b:9774:d340 with SMTP id 98e67ed59e1d1-3403a2fece5mr2816754a91.33.1761737264495;
        Wed, 29 Oct 2025 04:27:44 -0700 (PDT)
Received: from ventana-desktop.localhost ([2405:201:d019:c0ce:f7f5:7789:48e5:c03f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm15316918a91.16.2025.10.29.04.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:27:44 -0700 (PDT)
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
Subject: [RFC PATCH v2 08/10] riscv: Introduce HEST SSE notification handlers
Date: Wed, 29 Oct 2025 16:56:46 +0530
Message-ID: <20251029112649.3811657-9-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
References: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add config option to enable SSE in APEI. When it is enabled, functions
to register/unregister a ghes entry with SSE are avilable along with
low and high priority event handers. If a SSE notification type is
determined, a ghes common handler to handle an error event is registered.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 drivers/acpi/apei/Kconfig |   5 ++
 drivers/acpi/apei/ghes.c  | 101 +++++++++++++++++++++++++++++++++-----
 2 files changed, 95 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 070c07d68dfb..ada95a50805f 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -46,6 +46,11 @@ config ACPI_APEI_SEA
 	depends on ARM64 && ACPI_APEI_GHES
 	default y
 
+config ACPI_APEI_SSE
+	bool
+	depends on RISCV && RISCV_SBI_SSE && ACPI_APEI_GHES
+	default y
+
 config ACPI_APEI_MEMORY_FAILURE
 	bool "APEI memory error recovering support"
 	depends on ACPI_APEI && MEMORY_FAILURE
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index f2cbd7414faf..3c47249245d1 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -17,6 +17,8 @@
  *   Author: Huang Ying <ying.huang@intel.com>
  */
 
+#include <linux/err.h>
+#include <linux/riscv_sbi_sse.h>
 #include <linux/arm_sdei.h>
 #include <linux/kernel.h>
 #include <linux/moduleparam.h>
@@ -97,6 +99,11 @@
 #define FIX_APEI_GHES_SDEI_CRITICAL	__end_of_fixed_addresses
 #endif
 
+#ifndef CONFIG_RISCV_SBI_SSE
+#define FIX_APEI_GHES_SSE_LOW_PRIORITY	__end_of_fixed_addresses
+#define FIX_APEI_GHES_SSE_HIGH_PRIORITY	__end_of_fixed_addresses
+#endif
+
 static ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
 
 static inline bool is_hest_type_generic_v2(struct ghes *ghes)
@@ -1530,6 +1537,63 @@ static int apei_sdei_unregister_ghes(struct ghes *ghes)
 	return sdei_unregister_ghes(ghes);
 }
 
+#if defined(CONFIG_ACPI_APEI_SSE)
+/* SSE Handlers */
+static int __ghes_sse_callback(struct ghes *ghes,
+			       enum fixed_addresses fixmap_idx)
+{
+	if (!ghes_in_nmi_queue_one_entry(ghes, fixmap_idx)) {
+		irq_work_queue(&ghes_proc_irq_work);
+
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
+/* Low priority */
+static int ghes_sse_lo_callback(u32 event_num, void *arg, struct pt_regs *regs)
+{
+	static DEFINE_RAW_SPINLOCK(ghes_notify_lock_sse_lo);
+	struct ghes *ghes = arg;
+	int err;
+
+	raw_spin_lock(&ghes_notify_lock_sse_lo);
+	err = __ghes_sse_callback(ghes, FIX_APEI_GHES_SSE_LOW_PRIORITY);
+	raw_spin_unlock(&ghes_notify_lock_sse_lo);
+
+	return err;
+}
+
+/* High priority */
+static int ghes_sse_hi_callback(u32 event_num, void *arg, struct pt_regs *regs)
+{
+	static DEFINE_RAW_SPINLOCK(ghes_notify_lock_sse_hi);
+	struct ghes *ghes = arg;
+	int err;
+
+	raw_spin_lock(&ghes_notify_lock_sse_hi);
+	err = __ghes_sse_callback(ghes, FIX_APEI_GHES_SSE_HIGH_PRIORITY);
+	raw_spin_unlock(&ghes_notify_lock_sse_hi);
+
+	return err;
+}
+
+static int apei_sse_register_ghes(struct ghes *ghes)
+{
+	return sse_register_ghes(ghes, ghes_sse_lo_callback,
+				 ghes_sse_hi_callback);
+}
+
+static int apei_sse_unregister_ghes(struct ghes *ghes)
+{
+	return sse_unregister_ghes(ghes);
+}
+#else /* CONFIG_ACPI_APEI_SSE */
+static int apei_sse_register_ghes(struct ghes *ghes) { return -ENOTSUPP; }
+static int apei_sse_unregister_ghes(struct ghes *ghes) { return -ENOTSUPP; }
+#endif
+
 static int ghes_probe(struct platform_device *ghes_dev)
 {
 	struct acpi_hest_generic *generic;
@@ -1576,6 +1640,15 @@ static int ghes_probe(struct platform_device *ghes_dev)
 		pr_warn(GHES_PFX "Generic hardware error source: %d notified via local interrupt is not supported!\n",
 			generic->header.source_id);
 		goto err;
+	case ACPI_HEST_NOTIFY_SSE:
+		if (!IS_ENABLED(CONFIG_ACPI_APEI_SSE)) {
+			pr_warn(GHES_PFX "Generic hardware error source: %d "
+				"notified via SSE is not supported\n",
+				generic->header.source_id);
+			rc = -ENOTSUPP;
+			goto err;
+		}
+		break;
 	default:
 		pr_warn(FW_WARN GHES_PFX "Unknown notification type: %u for generic hardware error source: %d\n",
 			generic->notify.type, generic->header.source_id);
@@ -1639,6 +1712,18 @@ static int ghes_probe(struct platform_device *ghes_dev)
 		if (rc)
 			goto err;
 		break;
+
+	case ACPI_HEST_NOTIFY_SSE:
+		rc = apei_sse_register_ghes(ghes);
+		if (rc) {
+			pr_err(GHES_PFX "Failed to register for SSE notification"
+			       " on vector %d\n",
+			       generic->notify.vector);
+			goto err;
+		}
+		pr_err(GHES_PFX "Registered SSE notification on vector %d\n",
+		       generic->notify.vector);
+		break;
 	default:
 		BUG();
 	}
@@ -1668,7 +1753,6 @@ static int ghes_probe(struct platform_device *ghes_dev)
 
 static void ghes_remove(struct platform_device *ghes_dev)
 {
-	int rc;
 	struct ghes *ghes;
 	struct acpi_hest_generic *generic;
 
@@ -1702,16 +1786,11 @@ static void ghes_remove(struct platform_device *ghes_dev)
 		ghes_nmi_remove(ghes);
 		break;
 	case ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED:
-		rc = apei_sdei_unregister_ghes(ghes);
-		if (rc) {
-			/*
-			 * Returning early results in a resource leak, but we're
-			 * only here if stopping the hardware failed.
-			 */
-			dev_err(&ghes_dev->dev, "Failed to unregister ghes (%pe)\n",
-				ERR_PTR(rc));
-			return;
-		}
+		apei_sdei_unregister_ghes(ghes);
+		break;
+
+	case ACPI_HEST_NOTIFY_SSE:
+		apei_sse_unregister_ghes(ghes);
 		break;
 	default:
 		BUG();
-- 
2.43.0

