Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E0B84A46
	for <acpica-devel@lists.linux.dev>; Mon, 15 Apr 2024 17:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200505; cv=none; b=OoZkQWmA8ZRFraV4+RGlQcQtBfPuowdzxdBxPjwVES9cb6UBGporkNPvSO/BiB+pORS8qrm1e062mTGwH6TUMCoeyjEmKh1a6xZpMx+WxV0EkyndzNBGqM90/BG1VfDmeYrvEKhRHt+2hznZISN+UsVxp0wwWM0Thpjvk/TNLB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200505; c=relaxed/simple;
	bh=G6d/szsfyOmNpE6H7iCYICRZyVGX7D2nTzxNR2hGcHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XyOcHz0Ysy1Cy1H3Ozp1ROArY8TDQeNDA34IJfi1EyLhM4TMk2XUs087Ri/0cQVU/78CCsoxrd/2IqAIvaWn9GmGp6SwDLQs+Iaigs1AMdNXvgFoXwFnw+5Ld3VLN6gHznlbKc3XrjBIZH9XOpybBcB6VYEQ4mkSMOO6FgEdHFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=j2PaZzlB; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="j2PaZzlB"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ed04c91c46so3648589b3a.0
        for <acpica-devel@lists.linux.dev>; Mon, 15 Apr 2024 10:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713200503; x=1713805303; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoHprznTatfd3jPIiDLel21Ov4h1fvX4qo25ti25gdk=;
        b=j2PaZzlBzqzJ25WdDXNLZRBKIUYJ7zoTX2u9Ccn7Xr89gRUwiQLA8ccd0hEL2y4aNP
         1Q8Dj/KAo/8uUVmD0wFOPLSouSc9gZO0Y/hbgSapR03T5efINULgdmu8zfW9ctU9pk//
         VOfaeHnnHLN8UdM4s14WpKdv0YmySZtxk3IiF9pf5jI64vARNZeyBsmcJtZQUWlr9Jn0
         kM8rZI5P5ZsCDYDqNR/UpeJyo0ndE72p4zLYLFpeGg1PGlHmlpDS8pdt2X38e0Cbj/1S
         G285Vr8+4TLrXEvpLd+VwNGUtOM3KMkFxYbXRjGzRq6VP/1RnepOi9Lxw7jHrIoz+coF
         yKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200503; x=1713805303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VoHprznTatfd3jPIiDLel21Ov4h1fvX4qo25ti25gdk=;
        b=LsEKQRoZo8rCsGzIuPT+ifpOleHhjfrhFMsGxTHtL110HfbH/mzpGyssT+6wVR6N59
         pTZIqyvqkNlkG1WM71F1Rqqem2EMaFB+6iV5p2/bZB8XR99rsrL+1GWDaqXZdYKXBf6+
         HZd9W76jkWw+AJ0no3O2ahxKOd+7z/UtopabZu8emlGJLcjhAS6iwzUBJdbEPK33Lpjq
         bUYNdUyWg6nVmNbghgRKi+k3pmOspaQeQc3AqtU1RwiO5DQdf64Go9HXniqrzADVblKi
         ISNe/XvutJSSAbMJct1p4E3u7M508+CHR0IaKMxzKZR9D6hs47maUrQObwmp8yYAoV7q
         9fQA==
X-Forwarded-Encrypted: i=1; AJvYcCWpP4zXQys0hFRsm67LIoshDTZDufgvcEbHGBYuxuYt+wf0U+FbrpsCF6EYxtUyqlhdWDYX2Q+5bNj4FQu9NhtQVc6hOyV2T1+5cSFA
X-Gm-Message-State: AOJu0Yy4yu1FitA6idwtosGQqncjPslQrbqUlGcWDnsdvkZFcAF48/6+
	elo5B9Jm1MpBp9LyCOYV7f3l6sEmiMizw4V24HlveDP+EUAQkea3x9u00OB8CoE=
X-Google-Smtp-Source: AGHT+IEZTBakzY6PKzMTgs/zcMBONEtbNskqJbnRsI44xNlUKHaklyMLmZlZj49QTc7g7/a+/pPcjw==
X-Received: by 2002:a05:6a21:3381:b0:1a7:58ca:cdf3 with SMTP id yy1-20020a056a21338100b001a758cacdf3mr14872194pzb.8.1713200503358;
        Mon, 15 Apr 2024 10:01:43 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm7433158pfm.25.2024.04.15.10.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:01:42 -0700 (PDT)
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
Subject: [RFC PATCH v4 03/20] PCI: Make pci_create_root_bus() declare its reliance on MSI domains
Date: Mon, 15 Apr 2024 22:30:56 +0530
Message-Id: <20240415170113.662318-4-sunilvl@ventanamicro.com>
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

Similar to commit 9ec37efb8783 ("PCI/MSI: Make
pci_host_common_probe() declare its reliance on MSI domains"), declare
this dependency for PCI probe in ACPI based flow.

This is required especially for RISC-V platforms where MSI controller
can be absent. However, setting this for all architectures seem to cause
issues on non RISC-V architectures [1]. Hence, enabled this only for
RISC-V.

[1] - https://lore.kernel.org/oe-lkp/202403041047.791cb18e-oliver.sang@intel.com

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/pci/probe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1325fbae2f28..e09915bee2ee 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3048,6 +3048,9 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 	bridge->sysdata = sysdata;
 	bridge->busnr = bus;
 	bridge->ops = ops;
+#ifdef CONFIG_RISCV
+	bridge->msi_domain = true;
+#endif
 
 	error = pci_register_host_bridge(bridge);
 	if (error < 0)
-- 
2.40.1

