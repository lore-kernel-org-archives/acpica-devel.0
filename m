Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B9033711A
	for <acpica-devel@lists.linux.dev>; Wed, 29 Oct 2025 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737262; cv=none; b=TBrBjIq46xlkXqUNVAWA/qcm0NAfa7ysJDt4IsKAu3XvgpbUFqtkWdGWAfFZZHpGSGBnfHIrY+B2rmBdZwwKr+bWAOCdyetfusTF9BfoRbt0qkseolS5yfU9GuR3QuKu0ywWzb5Q600j6hSX3735+SinMQ4PCcKH7ppJSjtbWqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737262; c=relaxed/simple;
	bh=I4TEHisHhy81GfBk4tNwlY19gPH1ru3ik8bcWj4YLHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAOy4A0sAnZysRGD2nrKoVb2gYQk7dOB3uc15Nv73hBRescRWYY6aTSfTnjszMvV+lr6lIfhdAMgQg97VPAeCX0DyuoKNWOmQ8JHB5rkbxSqMDyAPdICRjE1KeTzBrZxoZYIBFaVD6G/3ZXUPmNqcwhwd0ObKT3Xmx7VIfkY8dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=c2QqY2VJ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="c2QqY2VJ"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b6cea7c527bso6991363a12.3
        for <acpica-devel@lists.linux.dev>; Wed, 29 Oct 2025 04:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761737259; x=1762342059; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lu9PVTm9hjUdHoFQcU8g3rsnUfjy9F8yp+wWZYUCJFc=;
        b=c2QqY2VJH/ZZ/ijeIobdknYfHH2o2rw2sznfi/ffpqUh/vxqcFSSnsYHflNVJqHZ4q
         LejQjvUZ+m1UMfw8aZ4wD3Jl5JA52OnliVNK6GFwbW6qlVuhN7diLBPFN++CZmUWB1v4
         i2S8HfWLn7W+HLMqTm6qDD2GEiFHCrsFd9ouRUKMQftWixMqnQV+ghHFfnpnqqpeHtdO
         Sp4TuIK+cL+9uUG4N1ObmqccY6TcSFp9uwfmH+J7fUId722kgLH0Mx95ti5mALvDd/Ff
         YC2bZDYTo/qi62y7Qzt3HXwoySjMogXvUADw38CnfwZge6UEbWXaVQyyubRysCT4aktu
         8Hyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737259; x=1762342059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lu9PVTm9hjUdHoFQcU8g3rsnUfjy9F8yp+wWZYUCJFc=;
        b=Qa0uaLCJAqFmARU8+h7eso7h/1bamcuB2Ayy690s8iCc76+zD3MLwIRjDLCC27eegR
         a9E8QOETomlaSjg4/ErqEBHi4sauo+DfApScAFWoVkXa0bnurZEiniER0ajdxlDXWBbm
         ocAmg3WC8sdKHP7ukUjEuv/eSHqCepQTCGHJf2jFb2aJMCf5+UI3J3aQhgXZCaI7mzcX
         Irlg0U07dWotj4WLd5MohmcNLM7jd5yNOh5U4CJf0NXel2zx79uKfzf6xlTM1eOYDi7O
         Lv+DwLVkOy8OrghEN2uNg/M3D82tvC4mAaKgi+XQ02fQT19JbSgR+UtSTuwZMIiwPsNr
         bHEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlXrVmMn54VFs2iR2fUWxvxWpFtnfzVWero4Ka7DNf1uBbANQ/OUwnlWruL7SKtZ0MfIs8fvUsF+LWdn8=@lists.linux.dev
X-Gm-Message-State: AOJu0YwnnEJVZ95i19Il2TrBSvjYcmXllm1f0TL1Qcsxgh+zP3IAR3J9
	e37wfzrEwVXBUtIWEbbUURxUFJnLpdnP0dRY1pOIbPaGSUNSwZkv2tp9oHn/IIVGtE4=
X-Gm-Gg: ASbGnculvTiLStQevqGDUYGOE3HJtgQSqCFdEKbqJ1AIfPo3GxL4d9+9VwrypAIgiWJ
	ef0Sv8g1AwJRtsj2bPwEc2dJSeb10RqnWJuzc52vo+UqAyx2X1OR7l6JDcapcM0OJg9W0jAZH38
	Me0uuTKo1abiHJnKJhGEk0DX0EQMhMwcuro1c/Fz6z01f+6b1TFm7t7+g+eapcUZ42qFHIvXVEu
	B0KY3EyHQo6j/aVpx1PbdutrEK4g2zk6/pjPWnEQfPz099LPngviASmixr8bcdRvnY+lpmwbOZh
	lNsqaEEpm2wXJM6QavxmCvj6vRZZA/4/4CYhatp4qs3N9mP5ErVpiquuhbx+JwW0RN6pvKDd9fS
	acZsBTU73umep7gzvTn3HfjAj1++X5nQQQ0JuLjfQLtPXjQRUDKVvU/BjuJDyX7Fcs9Gl5CsohH
	8zd21DroLq13ESJqTuUHUStI0n/+8fD3cyWQ+2oa8=
X-Google-Smtp-Source: AGHT+IEwNLyhot5qPJEYgE8ajY5jbwtZPlrijo+bkOA+9e521cPY2uChToY5FLnyugwQKON/wAVvRw==
X-Received: by 2002:a17:903:32c6:b0:24c:7bc6:7ac7 with SMTP id d9443c01a7336-294dee20a01mr33897975ad.18.1761737259146;
        Wed, 29 Oct 2025 04:27:39 -0700 (PDT)
Received: from ventana-desktop.localhost ([2405:201:d019:c0ce:f7f5:7789:48e5:c03f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm15316918a91.16.2025.10.29.04.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:27:38 -0700 (PDT)
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
Subject: [RFC PATCH v2 07/10] riscv: Add RISC-V entries in processor type and ISA strings
Date: Wed, 29 Oct 2025 16:56:45 +0530
Message-ID: <20251029112649.3811657-8-hchauhan@ventanamicro.com>
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

Add RISCV and RISCV32/64 strings in the in processor type and ISA strings
respectively. These are defined for cper records.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 drivers/firmware/efi/cper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 928409199a1a..ebdd92ba1e15 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -110,6 +110,7 @@ static const char * const proc_type_strs[] = {
 	"IA32/X64",
 	"IA64",
 	"ARM",
+	"RISCV",
 };
 
 static const char * const proc_isa_strs[] = {
@@ -118,6 +119,8 @@ static const char * const proc_isa_strs[] = {
 	"X64",
 	"ARM A32/T32",
 	"ARM A64",
+	"RISCV32",
+	"RISCV64",
 };
 
 const char * const cper_proc_error_type_strs[] = {
-- 
2.43.0

