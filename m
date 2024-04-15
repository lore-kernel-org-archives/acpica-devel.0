Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1475A84A4E
	for <acpica-devel@lists.linux.dev>; Mon, 15 Apr 2024 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200545; cv=none; b=QfFM6PPH5Ud7oI9pxpnQhgt9RCahKR1DXWHE0/2khxGvXTNABEoFG5P/znOygBeu6WbNif6gXLcUFJMm6vWyy2MusiM1DjjLUQxt0RhgIcXWmMhhKS5nlK8+jlopXhC9XkaEKWebMYgJnKG0njnD1tDBoy52pIZpuQIAiPAjugk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200545; c=relaxed/simple;
	bh=T/1Xcao9xH6emFSa1ilV8PdiC7xRbDw6sg4wGWt0SgA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hOQSdsjcYlawCjNYeVfNdzwBSEG4L0/DX0tjx+x+cbRpKgcybuFUsGkQS6J20sSvAqqGQQcl0/re5DTOjc50UR+yX3O1Au3N/QU+X3WRT5mkWKjz5oxEpb8FDtrPsfNpSyij/7uz/9A2C78ZTp0rYoObCMr/cjehdnnnrJT1ctU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=kcEqFMHR; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="kcEqFMHR"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ed3cafd766so2695881b3a.0
        for <acpica-devel@lists.linux.dev>; Mon, 15 Apr 2024 10:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713200543; x=1713805343; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2LHe0TiKeYFnNPgLCeAe5BF4w5DQy6QPlu5Fs7U6q4=;
        b=kcEqFMHRQmFzFqSF2ymN9qaKBm1d1JdCe5x6TWzfBgshZgYaUw463otTO3YEcPSPv/
         wH36ajuVbmrzOJznzKYU2Yordb6mPtVMmWHh6cxMp1nuW8XCWKOvw7wEeh/Km/8iIZ7l
         r21skKuP5coAwY3E7aStcXrNuchlKWDu8hVYvMfzDtbNs01jZ0EFSxYTzgvzZDBJFlOZ
         p2n7+7v+43t1azlORPibV4Kef/MG2R3dPHPQB8Nthx35SoM7f2KMz4I/OujvhHnI6qOO
         86afFeRXIsc9ilAEA3BFf6NOZvBmRjDFjTr0410FnBASvIVbY4nVm0fLrMOoJKVn/uL3
         2o+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200543; x=1713805343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2LHe0TiKeYFnNPgLCeAe5BF4w5DQy6QPlu5Fs7U6q4=;
        b=u6e/HglEipI+7zAMSSVXd0q7Y4kCOLblxD9nV3r4YGrnz8CqRzoc+1JjYNqJ2JhdZj
         plAWNKfI9zO5iy3tw+YRO5aSWjoV6f5NWUHVuCnF+WEyLRFLpPhplU7DqZHUMB1wK0Oh
         K8ETSauUqjuJUuaYrMUO+c7kh2OWkQmUunFit8cLJpk74fM0PYpUOu8ifbzlG2PfKV5r
         ZVmF8bgwJ0sxYqVwRrDLqY4PeGl0j4xcPSMV9IcKFp+LbndH6ZF0aE1jR2t+NDiidy/V
         NCWrJnq9wn+r0pBHG5IadC2Hwdto6t+AS6WjGAUkn+98CpOT4VYaDxcN+O5I0Syl5JAH
         kFsg==
X-Forwarded-Encrypted: i=1; AJvYcCWz2pOTOvg5MaV4YzU4zQaIk7JMV/OoN2H1V8NuGT/+x3GTDcF5rstSY/fLSQiHnbiKm6DLoJqckpN4XcpZR3xU2on977wIoPABrhDe
X-Gm-Message-State: AOJu0Ywa5QXpFu4iYf3z57QZcVr8OZaqKTn6va7PI7N8nMOjweUcWR04
	xgOBF5yP8+m9/EGMZEpVxxIAWnB0CP/UK0+hrRVZlsBREgkb6PGHMv8xIWeqdX0=
X-Google-Smtp-Source: AGHT+IHZPG6wbKkbl+YL/8OPMELdPpFA9RlWoys/7cQw/AgmouLy6gSngELWynfeqJUNk2wi6bZfdA==
X-Received: by 2002:a05:6a00:3d0f:b0:6ed:41f3:431d with SMTP id lo15-20020a056a003d0f00b006ed41f3431dmr11412835pfb.0.1713200543335;
        Mon, 15 Apr 2024 10:02:23 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm7433158pfm.25.2024.04.15.10.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:02:22 -0700 (PDT)
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
Subject: [RFC PATCH v4 09/20] drivers/acpi/scan.c: Update _DEP honor list
Date: Mon, 15 Apr 2024 22:31:02 +0530
Message-Id: <20240415170113.662318-10-sunilvl@ventanamicro.com>
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

RISC-V PLIC and APLIC will have _DEP from devices using GSI. So, add
these devices into the honor list.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/scan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index c8f40d81b6cb..07e91616b7d4 100644
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

