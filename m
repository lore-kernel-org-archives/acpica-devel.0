Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825F9233153
	for <acpica-devel@lists.linux.dev>; Thu, 27 Feb 2025 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659843; cv=none; b=HrECBc5fLshhFtALOvawJ0w+6gJDR5VDTmK2FkG0Lo4YCIgrT1m8Sb/svskC+3TPtiV3W470/+1FSUgmFZzamZskjt2X1Lmt175a04hRVieKjZ9Dd9oX9kve+MM/I3Y29XWF4rwPrSevVOr5WB8JiVKqpOu1ZHYC7sZGkMmR51c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659843; c=relaxed/simple;
	bh=Q5uxxUx6KeY4zwC8bnmu7iQA3t7vZqPvLL2pQYA7C38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wznlv02Cf7BB0rVuiynD1/OWclovvT10FYhRcfy8aU33VmC+UrHUbc2MQH0BgDS5qFv5UN+cAWwCXd1oqbdSTDQ1fmEKoSDDoeCZkZBVg0ZBiBDa9MI91XEEGusDLCmtb/wwg0fqCUdxGzU3o2Z69weU8qZ40dp/OU7QAYfMwKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=nxsFTmxJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="nxsFTmxJ"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22334203781so26538705ad.0
        for <acpica-devel@lists.linux.dev>; Thu, 27 Feb 2025 04:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740659840; x=1741264640; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXVhLjcRoeCf2V/5WVQuQKEAR2qmhhl0hOLkmr0AsUA=;
        b=nxsFTmxJ0sIy2vpkbBL+Vfd3oJzNI1UXnaK64spMfEN7mD1Dtq5O3/WtSLJhjolNlv
         ZJl/+7vjExvXID7fOf+qOpJfEdyKV0Y7R0aRTXnSyzDiw/NGYWBnVPRHUrFuykopLM3m
         AwLMAqkU7mZDPW62wGT6VnuciS2OAb6eOJlYbZYMjIJJnBdOthc6JJJiuwtU2kuIKkYQ
         RdQR/DMSokDZmyjbM4J87O9EhHtGKrYce/N/EgfugrPlLxvfPvSiV4/NKh9aNOsXR7Wo
         5FMpmM/+/qnDsa+mPgmdjw0DXjK4aI7lbFMZK2tbauYm6a92732ljSJFcXegEie4hYNo
         gC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659840; x=1741264640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXVhLjcRoeCf2V/5WVQuQKEAR2qmhhl0hOLkmr0AsUA=;
        b=MSjmlx7kDZJHrCT78RLa2kAVyDm1rX7JBTs80w5/4GDdEmbxHS+Uz7AXM8pIELNMbB
         oc91BCyY9tP2414UqU6sIJB996cFTTqLwy7lgJ7e3eRz6aBcYD7cV69FDiKCPGHbqDDG
         4vliRbhO70Sv9t3tIIo2fXSBxfiBQxV9wQe69w46i/eIK46s9ATiOYt1rrvFGTHuIJm8
         E9Xa+BJVI4G2twI1vPV9wDM4JZ6N7zVv/lNeJLP4B29NPTBkelACJtKJcRmhN1wwSimJ
         S1hYxUvJvIMu5gvsjFwvwpLIAjsmG9U/NosIK9z75K8gaDauer6la+4P6IeMgBPKp1Xi
         +4rA==
X-Forwarded-Encrypted: i=1; AJvYcCVAvb0bqGmyCB2pZXfjpnXfayBZ5sJPO0hIrG+PEK2gKTXrutcyJ+7jdMzvwFF3q2hbA+bByQsSow0XPq4=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5XfR0criWGEWZBHNvOHZW3tYznaZTQBrf392sW0AYa+Npdi4o
	/omOeo/8X052+HT8seWbZvT3SJblbb77teTPuM3oGL1WwY3AcQXgqpX44Se/QYM=
X-Gm-Gg: ASbGncvoST/vDeP/bG22iRTMrK+zgr0oYvRhvofGXqe6UN/PIqSmStvExs1lkBsgPp9
	TlaYKOn3rZUzT6n13ELDaL9MRMVvc+eorfOKI+vXBB7f/1NdHrH/3aHtBXHmAOQqOc6lwKq4d/B
	yVwrVUZWBqBAT8t7DaDo/dDOTmRaw5kTXE6HU/FxepstQtVbDYsabY1v7d1VNP7jXJAMmsfRsG7
	BNU9404EhQlV89vNXMbsM9dVzLoPaNXDVVxZEmCy4NGQfD4+6R909p4aMIlZGkkheoQ6682Qv/G
	QQoARPkSOrc14QnWxgWOwdVnJAm2HAXX6WqX
X-Google-Smtp-Source: AGHT+IE/pZ3e6JonJxeQe62tq8o12LGMwm5f6Ts5InGRCEUeYVZmSfCnd9ZWVdPIH36ibrRnGp55zA==
X-Received: by 2002:a17:902:d507:b0:21f:1348:10e6 with SMTP id d9443c01a7336-2234a57fd4fmr60713595ad.13.1740659839830;
        Thu, 27 Feb 2025 04:37:19 -0800 (PST)
Received: from ventana-bhyve.. ([49.37.249.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bddsm13219135ad.140.2025.02.27.04.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:37:19 -0800 (PST)
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
Subject: [RFC PATCH v1 08/10] riscv: Introduce HEST SSE notification handlers
Date: Thu, 27 Feb 2025 18:06:26 +0530
Message-ID: <20250227123628.2931490-9-hchauhan@ventanamicro.com>
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

- Functions to register a ghes entry with SSE
- Add Handlers for low/high priority events
- Call ghes common handler to handle an error event

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 drivers/acpi/apei/ghes.c | 100 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 89 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 8a1029163799..59abb89d3547 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -17,6 +17,7 @@
  *   Author: Huang Ying <ying.huang@intel.com>
  */
 
+#include <linux/riscv_sse.h>
 #include <linux/arm_sdei.h>
 #include <linux/kernel.h>
 #include <linux/moduleparam.h>
@@ -97,6 +98,11 @@
 #define FIX_APEI_GHES_SDEI_CRITICAL	__end_of_fixed_addresses
 #endif
 
+#ifndef CONFIG_RISCV_SSE
+#define FIX_APEI_GHES_SSE_LOW_PRIORITY	__end_of_fixed_addresses
+#define FIX_APEI_GHES_SSE_HIGH_PRIORITY	__end_of_fixed_addresses
+#endif
+
 static ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
 
 static inline bool is_hest_type_generic_v2(struct ghes *ghes)
@@ -1405,6 +1411,63 @@ static int apei_sdei_unregister_ghes(struct ghes *ghes)
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
@@ -1451,6 +1514,15 @@ static int ghes_probe(struct platform_device *ghes_dev)
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
@@ -1514,6 +1586,18 @@ static int ghes_probe(struct platform_device *ghes_dev)
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
@@ -1543,7 +1627,6 @@ static int ghes_probe(struct platform_device *ghes_dev)
 
 static void ghes_remove(struct platform_device *ghes_dev)
 {
-	int rc;
 	struct ghes *ghes;
 	struct acpi_hest_generic *generic;
 
@@ -1577,16 +1660,11 @@ static void ghes_remove(struct platform_device *ghes_dev)
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

