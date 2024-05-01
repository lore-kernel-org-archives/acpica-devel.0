Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0919A127E0C
	for <acpica-devel@lists.linux.dev>; Wed,  1 May 2024 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714565940; cv=none; b=L5cPEvd6kmuifPE8TUbLQ9p58P2kD89aLNZP0tmLBdRiq5uv+9cQ2aPSME4hBjcfcZgx2kkGSA7VefxWlF25uRBo6d4jP9zPlRxW0mWiTc1ZAJZKKTlwVLcXYHgfGwv+IlhgDoq61vxTcKd+BdzgW0l49M+GyLabIRHXPqRlMnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714565940; c=relaxed/simple;
	bh=CPhKTM+fujR2wlemEJtEAE/LXnd3DpxMM4jZCEYDYXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G+P6cf/UliBhcIfWNqOH0Ax+LRV2Frxt7QUTP5LqeUxpd2C6vXtLQ1ILSSWn0meGSd0OPO4wwf0pF72VRhjOG/NCjoW2XxP5VsjAhHybBSIEbwpTcGlD6hTiJYaCBNtWxhniWdyApEfRIFr0YAglDqF+F59fegRwusbepbvqhd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=C3VBchKc; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="C3VBchKc"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e651a9f3ffso33944665ad.1
        for <acpica-devel@lists.linux.dev>; Wed, 01 May 2024 05:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714565938; x=1715170738; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOIqEzOMfBRaM7n+Lh1Tvfg7gL7m541laQZW313gOHY=;
        b=C3VBchKcoSZQLiycqsZcaajrAgLDxvfCvclH3HtZjYL++7+kRd4F102J4EoyRhhkdI
         h3q83Fi3Cj//SiL88TuiAstY8SdcQiNNXLQMNbAnkNL7gTKE+5neXlh0dzL5WPM1Igtl
         ivraOtVfx6yXeyZZkvpmYF2ht/+wmQvD+1CE0z9nx1x3MEoMFujNY3XBqrIB35D8uWb0
         wPssbkQYnIgdN0XOPWs/L/RViLESCJvITY0i67cB54FJr2dkUYVcNHTyy1EZE8g5Jdd7
         cVl/ACyTtIjFXNsz4XT2ba2LZNIpxYsDHYUKr2aPq+n/5TCh35DmMW5HN+J3UTidcYPy
         PRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714565938; x=1715170738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOIqEzOMfBRaM7n+Lh1Tvfg7gL7m541laQZW313gOHY=;
        b=XmEQchzw4zmDqBrcPOjUSVfb0cWyOJdPBN1l+2gNz2Tq/CFEpyPwBhtyDPUuijLK2B
         V8Cb75JpVCDAKIJuu3BgfPt/UlUnUkBIlaQQ0mLUATJjVwrG+/iIKl/i01wwnpghRZj6
         pghfh5+IxNP/kGOUl7pitgOE8Z7Gh1jCFK+KS/uU9CdfDZuCN8FmIJBrRJ9IhzLhtkV8
         Ga898PLAVlvETT73Yh7JDWowqDTGodPLAIi4uUmEtNHwG1d073qu3tt8Cb4we/pz4D1U
         R0W1+rCArdhuHK5036qTSVlZHFylBeY4nGjK1yCRrd0tzPVAPwT7lSd+3NZIK2JXWd4w
         XnrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvAY1qi+GFNO85x/7kfw6oAtcdog11vOwPokmr1PpBxlrskU5zvXix1BOzqaKBzdpoS1WMj+CpLeu7X6dQ4bueoGJOnP4uXZq3bQV/
X-Gm-Message-State: AOJu0YxWY/EuvMIQ5Ofl55cYuixIBkX8KHuuwpQp7cIwsCoKsYCRp0Si
	NU3g7vIHZypp7+VQ46M/ijYTp7qaZWnUM1gh0zG08950ay2uSqrWXIOgneuNhFc=
X-Google-Smtp-Source: AGHT+IGEfdWve8EtzQpflTL0dKP3MQxp+brvZfzYZ/NVGRzicQEMono2Ofsx4PyPFbkYzH1s9yqSdg==
X-Received: by 2002:a17:903:496:b0:1e1:a54:1fe8 with SMTP id jj22-20020a170903049600b001e10a541fe8mr1877916plb.53.1714565938389;
        Wed, 01 May 2024 05:18:58 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.106])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001ec8888b22esm1336900plb.65.2024.05.01.05.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 05:18:57 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v5 07/17] ACPI: bus: Add RINTC IRQ model for RISC-V
Date: Wed,  1 May 2024 17:47:32 +0530
Message-Id: <20240501121742.1215792-8-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
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
index 17ee483c3bf4..6739db258a95 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1190,6 +1190,9 @@ static int __init acpi_bus_init_irq(void)
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
index 846a4001b5e0..c1a01fd02873 100644
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

