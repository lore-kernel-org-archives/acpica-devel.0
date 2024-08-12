Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71021CD20
	for <acpica-devel@lists.linux.dev>; Mon, 12 Aug 2024 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723424428; cv=none; b=alBMTdmtXHihFh9zjbx7ft60Rw+NsB3ZQjpBMsunlDfyvs4/OBy7ezepUv3m/vcrmBIw6OKROTP8ZWCHvyASFcYZzfaGaOczeS663fDjt+kxXGkl/+X9dF59jskQJqU9dyAhFGH+IhYtHFXdMnXSGpQBdm5yxGhL7CZtBhsNbag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723424428; c=relaxed/simple;
	bh=8EwPwWa3yJI98774dHhpFkxvDEk2uSVsbNpCxj1n9SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O3wJXk8QCVRvlvcKIxEz7l/UGN2+h+1EdKbz8llaVW1As1CEP/TeDCCUCoSGYXHYrEfu+atCG6pjD5Y/Nmyr4c5Tx06SKTZwo8A/KIKEcbS3PEaXdG93blM6QWnlGM7QALK++6lYYVM9fL2InGcpP/wXnoUvedKyO9QK7Umczno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=SaltQwm6; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="SaltQwm6"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-396675b83afso18185615ab.0
        for <acpica-devel@lists.linux.dev>; Sun, 11 Aug 2024 18:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723424426; x=1724029226; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBzMby0USGxgSPaQIBT4AQA8EH7Ak7bVCmTWfoSfRt4=;
        b=SaltQwm6FHufRInlNGT8VxPf4rmwT38EydZtKplr5okPjIUgOkrAYh/VHXTlZl1wr8
         VkmXQ5ZjNB04mDf0cDUfFGzjpaXbuu+FsYhIWfKhriGRb/lWwSUAAoPGynuW79fQAtNX
         pezcTSZ3uhsV4qZhF0RiXr7oM6JVd9iZArUpKWN4/2ULpTEILM+ZWsB+BBZNJzx2ka5o
         7Pd8H90kL0oQqcS4IbmL4zEshy7y2hL8rrJVkNb5gkEqGT+c7oI7gM/9roJq+Fgb67RC
         Z8CoOpD5OH9+A0MK/a2y9pCLHLz4duXA1W+Nxun8A3o1k5t34FS75RD3CcMZWOlGIRb7
         tdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723424426; x=1724029226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBzMby0USGxgSPaQIBT4AQA8EH7Ak7bVCmTWfoSfRt4=;
        b=Y+VdWN4ZmCFi7U0537+bbmrr8Bc9b9KF4Hac34sA1W7DRZIWTwmrdrVICSaT255i0K
         nZct7dgz0cHoA8ajbfyEO7ufkEbqHYFsRI28f0g6dN2uMZlHN/TZDgKO1+bhL+A+gdZF
         H2Xwan6SbJP1fSCn5BPknkmrHAMcRxWQqDWz8eyX/drYK5G+3ObGExa4jOkqfV69MPH4
         yiwpFVVVLS6OpLVLw42/LRTlPf0/rrQJBAf7evzABJh4n3Do4mRhGAQO6VcgIMMdjYKf
         iLSUDbGvK4EgxsuIgdhx/2ShJeboEwkOOBZndZmmYYva+1DUQS8z2Q3pNkvZvvfm1Bci
         /gdg==
X-Forwarded-Encrypted: i=1; AJvYcCXa0TFXeIyqp1fc9gzQaO4HNoVnSrBj1wZtAX3mRVLPbSQb9Q+gn9DjXn8LHxeJ8ejQwfD7iVxCZbo2ytxdMUjQhxd6E+uPnBpGhCa4
X-Gm-Message-State: AOJu0YxsaecmqvmGCi5SfoVH8DfiwxTJL+tBwbJq5bdd3AJ2inJHrdIM
	PX9WPgfE9sG25efbjC4CG94eLvlPEJ5e5FzyqGjpH7rziq7YQErfGRGNBhZuFBg=
X-Google-Smtp-Source: AGHT+IGLgGjZy1f4lXkyD9IeGxkMxZC7bl0GKZ86dlIJhEZNBpnAOTW5ak8/coJIxlUXH7m3lfD9qw==
X-Received: by 2002:a05:6e02:20c9:b0:39a:ea4c:8c26 with SMTP id e9e14a558f8ab-39b7a475a0amr105191515ab.1.1723424424986;
        Sun, 11 Aug 2024 18:00:24 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe8cbdcsm3074062a12.61.2024.08.11.18.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 18:00:24 -0700 (PDT)
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
Subject: [PATCH v8 07/17] ACPI: bus: Add RINTC IRQ model for RISC-V
Date: Mon, 12 Aug 2024 06:29:19 +0530
Message-ID: <20240812005929.113499-8-sunilvl@ventanamicro.com>
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

Add the IRQ model for RISC-V INTC so that acpi_set_irq_model can use this
for RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
---
 drivers/acpi/bus.c   | 3 +++
 include/linux/acpi.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 48d277657203..16917dc3ad60 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1203,6 +1203,9 @@ static int __init acpi_bus_init_irq(void)
 	case ACPI_IRQ_MODEL_LPIC:
 		message = "LPIC";
 		break;
+	case ACPI_IRQ_MODEL_RINTC:
+		message = "RINTC";
+		break;
 	default:
 		pr_info("Unknown interrupt routing model\n");
 		return -ENODEV;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 892025d873f0..3a21f1cf126f 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -107,6 +107,7 @@ enum acpi_irq_model_id {
 	ACPI_IRQ_MODEL_PLATFORM,
 	ACPI_IRQ_MODEL_GIC,
 	ACPI_IRQ_MODEL_LPIC,
+	ACPI_IRQ_MODEL_RINTC,
 	ACPI_IRQ_MODEL_COUNT
 };
 
-- 
2.43.0

