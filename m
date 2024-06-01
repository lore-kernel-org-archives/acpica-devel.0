Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43F1152E19
	for <acpica-devel@lists.linux.dev>; Sat,  1 Jun 2024 15:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717254313; cv=none; b=nIXWUkGr6RxCv8OrWZl9+BFfHfzKNX0XSwVjtOVcBdGT/MRt9VnV+8jspvbuxMXFmK7K2/+GJk0685+SnwE3LBvppSjT/jF9ym7abDiZ9OGmwFqYmVQVp83y3UmNqKcz7W4yNALhN/KA5Y9uMeOd1ZHY2WwCCxswjs0gCxRAQnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717254313; c=relaxed/simple;
	bh=MS3pYncxgjtaz9tqccBN5FjLqLx8afnodSL+vXxHJSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hRukIu2xc8HuKa20YS4GjlBiFeKtxDhk+XvRuGmsyMYxCInsNW51SwxJRXZTY8hRPgyjVflFOJgoT4QKo+k8oMxXw1J4QlHQ09t51AwGeIFxLeZBd4AQGGkfG5OL6YEGwKowKqURDToGpUjXWFs1DbDtQZJ0/+ipzOkA0W96l8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=OFl3cJV9; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OFl3cJV9"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2bfdae7997aso2334841a91.2
        for <acpica-devel@lists.linux.dev>; Sat, 01 Jun 2024 08:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717254311; x=1717859111; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4M/mYQsiafz27308Ygh9HE2jpjvmPpXdwbsDZU0p4U=;
        b=OFl3cJV9MhuTObM8DT5OXLDqHGcURce8mtUNtvIpsmWKNzB85RCTj5X51vl4dX9oya
         92tOqb9QcfMPceMdrG08/DZMsJWUJh37+bFJyzIAY6qUW6mGxntJPdiF44Ts9twhxc95
         1JFtkGRaEv97kShXRBfJ5dcpWJ7OA72OYnTGKIjxUcnaU18ftcKtGDmy/aEh08TsUS6J
         qT+owvfAu+VG8XfxmtY79iB11JVbTAxMBf68hMaWo6NgdEYLRJwEpks//q/z0JW7Dd8A
         CmRlMFv5czl3qb+y1oUH3C3qKsYPrr1inXZyBtnx07lOxTGxJmf7l8I7z5anSEUSxdJh
         lzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717254311; x=1717859111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4M/mYQsiafz27308Ygh9HE2jpjvmPpXdwbsDZU0p4U=;
        b=og7bOWLhXEqyBw9u2C5Y4ioLnrykdyHFfXXBXAVlaW6t1Ln5nfuY/1rs5rFQD0aXxN
         tvsgpddzv1KezpdCuJGD9vUnfGDj8j9ih12P4h/R7az9ew/MA8EljgwIHUbFAm9PkEs0
         VIosbYWCc++Uh1J4O9h569KOroZYsE7tmjyXnafbCpYIUe0KevUfvyyry4hUbYESFwmp
         hEhDL0pb8BVth+oHAOrEEpm2QPM9Xqh1UFTmCVDZ9d/2qKZ/P5U6ym/+NSwgcnbO2yiF
         3jZGmRl2fIr0IKs/124O/C0NgUAmAL+yXInpp3DDkgkzOZ4F1mO7aT8lp5VhGbYP+KN5
         VK+A==
X-Forwarded-Encrypted: i=1; AJvYcCVNqyhU+mZpax2xtkGPtzJBf6oshfcOBNaqnUKFs7m8MehtYJAUN88JTW4q0SodDqmAdNajz+2PdcpZ0BX1shqIqcbnuSYhQD1b4SqB
X-Gm-Message-State: AOJu0YzNFFjTpTUvA3AOCDZhQZgpcTIevvaFYeOGyVLzyZxaJyMYIZU5
	kt9M5xsi2BL7bY3USvaiYWMTWVx+UHzyHrC7JurqmJp9PvAbZCEN5ifvfV9BUWs=
X-Google-Smtp-Source: AGHT+IH8CUtTilyts1LQmIwjtfiqczpJ90H7WVJzan1b3vUk1N8n0tjhHWRHLwYTOBrAh4nFvjs79Q==
X-Received: by 2002:a17:90b:1bcd:b0:2c2:a2a:6151 with SMTP id 98e67ed59e1d1-2c20a2a631emr797621a91.39.1717254310835;
        Sat, 01 Jun 2024 08:05:10 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35a4ba741sm2559410a12.85.2024.06.01.08.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 08:05:10 -0700 (PDT)
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
Subject: [PATCH v6 07/17] ACPI: bus: Add RINTC IRQ model for RISC-V
Date: Sat,  1 Jun 2024 20:34:01 +0530
Message-Id: <20240601150411.1929783-8-sunilvl@ventanamicro.com>
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

Add the IRQ model for RISC-V INTC so that acpi_set_irq_model can use this
for RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/bus.c   | 3 +++
 include/linux/acpi.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 8d0710ade8c6..d5286e39668e 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1201,6 +1201,9 @@ static int __init acpi_bus_init_irq(void)
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
index 0c6d9539f737..3dd67ee09c39 100644
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
2.40.1

