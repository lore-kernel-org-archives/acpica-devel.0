Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9451F152793
	for <acpica-devel@lists.linux.dev>; Sat,  1 Jun 2024 15:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717254298; cv=none; b=IF/0OqU6FBXD5ijVhMvVOjvsnxNVE0bc2pnBaKtVV2gxX3ykJk0rGmOhxYAKR5rMl4ZEOqXYQtS2JUkeX9124gcfheyHwUVUSJqHOGtv/3no0Zxn6x5iAZ7niDoBtHUyFHgI483Dik7HRCQtAJi9/E5894jGF8G1f7z6nwPdPUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717254298; c=relaxed/simple;
	bh=5W07LWryv9sCiUT9t9LTI1vN2XJHVgygsyGcyP6/IGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BdCXE8wmknXTBAxMvnk7gRUKJmKrO0GEZTI+AoJF3xls/FuHhaVM08ZIN6Bz7V1AGrkoKNZKblR9gG4P8HSjlsU9rj/aP3BcLGuwRk0SUv/VFq6vuI0ldQRfTHb+S6Jq5Q7hiHKmmQw14OzmwcuYX2Ws+ix1/QBh//gXlNnUo24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=jS/lEogU; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="jS/lEogU"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ff6fe215c6so2615465b3a.3
        for <acpica-devel@lists.linux.dev>; Sat, 01 Jun 2024 08:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717254297; x=1717859097; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMraijh7EdibSWZk0AZcru1m7VB53gCU3iTUEc1cnAQ=;
        b=jS/lEogUXWtRF9VJ8tbKM3ud8O3UhpGY+IARz6RhkMPi9SLEwtAH+4SxU7TZl91Er5
         IBWddrsM8EPFcrMwkWn36a6Ws+lo2osvqACddfiVI6dYArGuPIbhTbgglvne34lEJeLI
         aNYyB2HAHQrpW8dxX0Bzv8mUj5AZAx8k43IzkpBORdH8UrFekzOHJCW1KY/mUirRGkUI
         P88OsXJ4r+ivYPfWs+NG86+FI0EpOY7ChH4JDB0GIyE2VxqlhH8ssfzK3n7d9XxXPn2B
         YBYVqAt+BzxcWFVlldJeLcTY1NiE3u1KtvGrcD2YUbo+mmgSw7ni2LxHL/VHKd0sMIYJ
         tmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717254297; x=1717859097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMraijh7EdibSWZk0AZcru1m7VB53gCU3iTUEc1cnAQ=;
        b=uiOU8Z4aZtQydSlhbuLCKClXABv8ravCEwEn7dFXoyzR/MgtOyE+7zax87UyDJGaPx
         PeqYDHozQFPmD0ccMgILFw+RAtDOOrWC0qgIX73Riw5riR3kWZ2umadc5oLkaEd/YK7k
         YAybOHXxx7dvqY250F+WvEXKqaBXMRu6aHU7ef7hkyW/7qRcNPcQG+Cd7oIaOj8wtPAX
         SVLx/JtXebyDDjZp++CCjikKbaLw3id7zlQ7TmwK4y5KRvsNu4HGHKPMu6ysyegvNowk
         EiuaHnTn6SwIFe17GyHT6Qn5fx70IqCWZ/F1RFRTy54rJzuL6VGQ+c25gR6Ocfdhhz2S
         n4fg==
X-Forwarded-Encrypted: i=1; AJvYcCU/7gMh/xSNMUNd32YvfUoMKP9g+/Ewowajb7XWGNdd9ksgZvWdKnlUv7JQPOCbEWe+3ChYDBgIzr8+fZA0eO+tokfKOcouz9Q9MYmi
X-Gm-Message-State: AOJu0YzHXQo6n8a2fVQuFEqlRnRxWjGCCV5uPd93RAs5g46Z2uAdpzga
	addt7CA82hMxs6PbfhNwcdxhrjzgESdr7Oa5b9bN805bVvfq3xAs/V7eb9VevWg=
X-Google-Smtp-Source: AGHT+IEKmyacfHakdX0P9GQl4t/BNHOtB7jRjgspK3iaFW5wKEhTYgTuLeBLCF/OOGDElEGcu+f4Dw==
X-Received: by 2002:a05:6a21:32a1:b0:1af:ad46:cd4a with SMTP id adf61e73a8af0-1b26f16ea65mr5996794637.12.1717254296842;
        Sat, 01 Jun 2024 08:04:56 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35a4ba741sm2559410a12.85.2024.06.01.08.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 08:04:56 -0700 (PDT)
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
Subject: [PATCH v6 05/17] ACPI: scan: Add RISC-V interrupt controllers to honor list
Date: Sat,  1 Jun 2024 20:33:59 +0530
Message-Id: <20240601150411.1929783-6-sunilvl@ventanamicro.com>
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

RISC-V PLIC and APLIC will have dependency from devices using GSI. So, add
these devices to the honor list.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/scan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 66038fc731fb..6f3152170084 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -832,6 +832,8 @@ static const char * const acpi_honor_dep_ids[] = {
 	"INTC1095", /* IVSC (ADL) driver must be loaded to allow i2c access to camera sensors */
 	"INTC100A", /* IVSC (RPL) driver must be loaded to allow i2c access to camera sensors */
 	"INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c access to camera sensors */
+	"RSCV0001", /* RISC-V PLIC */
+	"RSCV0002", /* RISC-V APLIC */
 	NULL
 };
 
-- 
2.40.1

