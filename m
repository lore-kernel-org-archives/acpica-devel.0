Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713CE1272A7
	for <acpica-devel@lists.linux.dev>; Wed,  1 May 2024 12:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714565924; cv=none; b=PyBqrsdmPo1BJRE4cjWHzlcvVMIQp0C6uqt01xSsAKlItRP703xEBHucY/+twsjN2jR0bwOGmiF58aOPHuzKfNp6RdbHVrORc6+MYrMitwiQD9mqGv92EMLTg+VYmBoPzfbY2tW1xY+Nb0uj9FcTNdqMXygYbcdKWV7XMFT0sa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714565924; c=relaxed/simple;
	bh=8Sfu8Z9vX1s+/fsrTVCUwOEPkW2bmWazbW7JyHI1Yzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iKwTZyFKqhuV/u6H2i7BLNtArYz5FwUC/ISZ5DFRhJM0okdM+AvvYv23j9wW/Wd5sEcus1F5UKARUUEDwVm8/aF4qwENuMsux4qeCjepUmewfsY/lsiI1io/7PawBdyiUa7BnpuF9Vj6y9w4XQeCgpSzW4ajIpqLjRJrlYi7jks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=YH+tnP6b; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="YH+tnP6b"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ec92e355bfso5028575ad.3
        for <acpica-devel@lists.linux.dev>; Wed, 01 May 2024 05:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714565923; x=1715170723; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNK+H7F1X6JmEpHoq/SVvyVT2dyL9n7lyqIUUwemfkM=;
        b=YH+tnP6bXw6JKFN3cdGRP0p2oUKQtbUbGmenQYeWtfiA0kPERce0HHY9xu8R+o24UY
         Zt+raewGnHE/fjJXPxE2zcnw/2TbdhzRlT78Jj71hhbIeRJwnRCjK9rD+c4UENEseYF6
         nmsAy91GpiJz7mSHQLoZ5rKHMdwCXCG/rWaytUEZyLMQ0fxoz5WJvf1JlL5uVJTnwQAn
         D2QOWr14SNm1c4dxkAOA84OUTCDwNeTOvZnCxkZjPzoDNNxGdpGh7sKu8E/KSiNTtALX
         EcQ+UKo5WZvETartZcon0tHRvcaLR+B3qpONcQJo21KoUzCnYE82e3hEQsR2jPTtJrMq
         BJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714565923; x=1715170723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNK+H7F1X6JmEpHoq/SVvyVT2dyL9n7lyqIUUwemfkM=;
        b=lHvHYDBi2Jhui7Vhp4bTJFOpnQyAi083GoXzceeKs1QuHYv0kdFvRWQxe3vikPXjhS
         /c4wNfNUdrCFJDduunajmjQyn6mVv5UJMatqgPiCwOL/ZEqS3D6GpANcgMBh8kUVxs4v
         heta8ZN9HAIvRRMzSgBrVA1OZYN1/f0oVyJOEzXzQhPh4YxjyJeXfr6zq9T7NW3uSOyy
         +h6qHap6uc1zIEjgeWiIkpTnFPM/1Vf3mJi1zu8E9ZTsfveoBzPME1hvGc15/TJH0Djm
         coJVWzPMmP/H3/GKC308vf8mNIgw0uZS2rxSRzX8t6c+shkXE0lBpRc/nM4Z4kDeCMpR
         bB8A==
X-Forwarded-Encrypted: i=1; AJvYcCVoEmT8wTJ0Tcs5GTbUBvOkMo4Za7EUBYpFedZnyeKVW893cRForU/YpmFuo3q7CDbLFth4G4IRvKfvVai0aW/VC2I8OK8gPdQVjylT
X-Gm-Message-State: AOJu0YzlUK5k9tzh6B8cynH8EXqvgZhKvkuhEFWRgCNN7cR9hiIjEQLZ
	2HS31NzPUxUHWSWavPPqyM0SFYlN5uWPfE3tKgAQH3V9uKUXP+oce0wFrQcw0Og=
X-Google-Smtp-Source: AGHT+IGI5pV9TYR10/cfbIQ9JMek+r7tBzzTGhtdRl1CfIULDyfaZRTCxXSzFPv/bTagC0SBwcv3pQ==
X-Received: by 2002:a17:902:db09:b0:1ea:cc:e123 with SMTP id m9-20020a170902db0900b001ea00cce123mr2687556plx.46.1714565922763;
        Wed, 01 May 2024 05:18:42 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.106])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001ec8888b22esm1336900plb.65.2024.05.01.05.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 05:18:42 -0700 (PDT)
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
Subject: [PATCH v5 05/17] ACPI: scan: Add RISC-V interrupt controllers to honor list
Date: Wed,  1 May 2024 17:47:30 +0530
Message-Id: <20240501121742.1215792-6-sunilvl@ventanamicro.com>
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

RISC-V PLIC and APLIC will have dependency from devices using GSI. So, add
these devices to the honor list.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/scan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 3e3320ddb3da..beded069cb0a 100644
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

