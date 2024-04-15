Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF4112A177
	for <acpica-devel@lists.linux.dev>; Mon, 15 Apr 2024 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200606; cv=none; b=Yj0Cgj/se+BVDat0n+rC3iN78bSbGS9482I0nbLHDG33vEP5hIimLSD7egg7yWuvs4zRqPnvW4jaXK5cCFYcWpC+MVkgF0nALlcLZRAOqEzyHT1olgHSAeNSXhKZWKLWpVvixt1fIsaqmHes3jr6mOiaF1ds9mDVTmaDnhBDfoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200606; c=relaxed/simple;
	bh=iq+zCwdn57VORSoLKgJUoBBIF3f6Y9IiyHLbSdDt+cg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rhX9Enp0ZrFCO0JT5dldRN2Xe2NUa369m3oBorQOMmWMo5bH3InJxjp8cETVPC6Rl2iPF+WrInJzeHl7IDvGZTQs/hF45Uhto3ySbjvlYfIG97s/qrwJoPbQ9+GTLLrMH3np12HSUwa3yUV4sEs0dlr0/hlWiUCnsHyGI4loOh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=QYMNaoYI; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="QYMNaoYI"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ed2dc03df6so3121591b3a.1
        for <acpica-devel@lists.linux.dev>; Mon, 15 Apr 2024 10:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713200604; x=1713805404; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgBDpDYGQ0glprRFD8yP0RdoCRZMFoPF1RZGUEi3Dy4=;
        b=QYMNaoYIiJRXMRvVOgOObuwV30JL56i6h9nxyFgYaGY2Zkstxsp5ZS7YJtE6X1bQxs
         Njzij0tkFfYAfj6lGCOkDcS4Di1vsgearAY7GE/MkxbavxmAPtrbIpvh+3HDeW6iQJ2+
         /ksH02CiYjTMr44nvY4HZ7lcuaHnmAIfeKnZGDP6Ho0fCznhiJ0HIWQqKi4Hu3EJQFL3
         2qUUrnbBz8GA6sxhnmasHx7EX1hoTKhPfLRjK8jbUYPUscyM//mnI2Mjfqckite5OGAA
         3sXCo+l89xUyfjD/7gGS6bLxUwADE36gUsFHmBhIwkdBDonJaS3QaXpech7le0Jeo3Dw
         ZR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200604; x=1713805404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgBDpDYGQ0glprRFD8yP0RdoCRZMFoPF1RZGUEi3Dy4=;
        b=uvB0UlQwFcJX1xPNFqfI0oNZdAQFTTH/+B6r9nfYRwFwmj9/HgZzuGR0SbP0u1olnX
         bl8tQLO9lNKnu4J5OWqBjGn59v1V256gPf2IicSTSQJ77MXF/NdRDXh1NcRA8FWk4bRr
         kugolfMPCq5CHuvwLdL4OAIxho4esEZNdatDl0h/C41GhPZos2TblPIhB3fi14AafoPo
         apmCtpla0rjRutSu2IsEeV+4zJRnipayNf1P2zxRUFWJlz3Mml3k6XPO7Tm5IVZOIWIy
         b6Slktcq3SLpnI4Np49Bl5y4RfcBElVCde0LwnKitjdW7mzWu1twyKncFBElZHGbDjS9
         vwwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1t4ANK/Nd021poEUkuQCl3LifcJ12jAPcvCIwz31HDwB+A1UUDtnIEe/79tP1SF+xmw+TOA41/kM1cL8WJnhvIxtgcT5bb1ZZe4nE
X-Gm-Message-State: AOJu0YzRHL79r1hX6IHMPIDOUr9bfDHW0bTjeVNOU2a9iN0Yyb5MLH2N
	pD0eXcH2csHo80NK7uqp9yL1kMLfz92l/AuM//CNqRvXXpQcQ9r0uZGz6d5B/XU=
X-Google-Smtp-Source: AGHT+IGfV3g4HnB1SEs58HPZghQyLF4oCdd9NUua8vNYxrzLQb9woMp8qFN8pqykKJDwEhBAY0XH6Q==
X-Received: by 2002:a05:6a00:23cc:b0:6e7:29dd:84db with SMTP id g12-20020a056a0023cc00b006e729dd84dbmr14671886pfc.31.1713200604137;
        Mon, 15 Apr 2024 10:03:24 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm7433158pfm.25.2024.04.15.10.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:03:23 -0700 (PDT)
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
Subject: [RFC PATCH v4 18/20] ACPI: bus: Add RINTC IRQ model for RISC-V
Date: Mon, 15 Apr 2024 22:31:11 +0530
Message-Id: <20240415170113.662318-19-sunilvl@ventanamicro.com>
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
index f8f92aaf97ad..c4b6d5c3aaed 100644
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

