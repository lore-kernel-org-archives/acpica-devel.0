Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BF81E894
	for <acpica-devel@lists.linux.dev>; Mon, 12 Aug 2024 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723424433; cv=none; b=qJgEUpOCw1oacm1C+Lip9mSvBFGITX9wgFnS45uj/9ASFcCGXiVzJPtZpt5CEe1QXBPB9RGrFNoXOn71NhQWv4rw5LmiXiv9Nrx/34g65iA9tz7mdxD0QcfFMp9iaOOzSrBOvzxmWu8BtnrUu/TeH1YMrmcwoKBvyaCYe/WHqb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723424433; c=relaxed/simple;
	bh=ju78PKw5X3jrPkd4u5aoarH1747E7AoqhDQWmGlAe6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pOTGb6d+MRS4LiqHwQv/nL/RnalIZAHEIUrB1o6NfHGbMG5mK8QZm/4C4xMmRQVUV5/qKkex1L9e0j7NrIB3g3Wj9UUVptRJ700BKhXk/HS7090HJ5z/iZ9tJ+ntfhoQr2N3/5O/nyUXCb5WpK8Kj1iY7hmBrMVzNHw/82w+78A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=AYG3v7wM; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="AYG3v7wM"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3dd16257b7bso131479b6e.1
        for <acpica-devel@lists.linux.dev>; Sun, 11 Aug 2024 18:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723424431; x=1724029231; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZXNFNaxM8vBPLxvkIIPrWaUY6tMJ6nPhDNbuDGhUyQ=;
        b=AYG3v7wMVFQP92YJz/m7RlYPiKmW3Vpf2ERNo6QEeY/tmRUCRShBdN9T1J5c/KAHau
         P5p0I926IeLTW29JqHSdYITeig/9Tf+JD2DwSOnEr1dsBxMJTLu4dw9unsqJbBtoLwYF
         3WzRAgXkhNA5QsJVLzk7+ya1C/8y0+aTtl1pwU1QIthxrnZQFEq9OaZDIwp5JN2CcUMN
         jrjLRaYx1hgNq7UcKdHufxqXa5cowfciZ6PiAidKE6YmIgXcVw1sIyUCTrv/tSmQtjUq
         9Ws9QAkUlbBTdHLErMbIeaN5UjZg1xc3/LXQFPuSJBuGX5Wwm74f+LvtcUIGvgSr55K1
         S/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723424431; x=1724029231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZXNFNaxM8vBPLxvkIIPrWaUY6tMJ6nPhDNbuDGhUyQ=;
        b=PqHjhR+ZP8Om6F08I40kRvVOtbPkKiVrpxq36pcQyYNmQNuCanJoVtqyGSY5P6I82I
         BvdRepfCri56ebH/fK6rZtwJF2ryRzSXalLWy0h/KhVQr+Bn26QSjUBMYKPpgYqZHSbm
         ElsJM/srRtkJ3ZM4Cb6xjaAet5iUZ+dKroWG6BnOmAxMRpZuRxd/yE83zRWsbBwdUPBM
         vMDPqpl55g4ho0iSZ+CPnEOtZYy/HBN2ZrsGWMfv0xzGF2qtP9M3EIRfuFy1NnyuKSpm
         N6sP3/YjBI95TCfWyd3o4Oy8FV+P3bZ5y2BbA/7tp57Bg7mQa087Q5qXj28m9qi5VGa0
         zFbg==
X-Forwarded-Encrypted: i=1; AJvYcCXQYdhXQEoZXT85GOKZmOHOQGV7/tp378aHcx3hGp2/C0dZL6DDh1e+bm5ambgW87MI/eaI08S+6/jGwlOBFU8RTIzqR92TSrTLbjKL
X-Gm-Message-State: AOJu0YxCizePgBdjnWFB+6oPOyujXl23i79LB3BrgxkFETidFebGcVLA
	GzVtGLo42BFXdiTWBd5/O8XB5OdLwkG3dMneV5UzYpGcXWGQ100esLyOAE+7w/8=
X-Google-Smtp-Source: AGHT+IE9UN/eFl1Fb5sxAtzGTPfmVg74o1vo9nXqbGis0UuD39tez7iI9A3QbSPr+XUfKWTJWNIKOQ==
X-Received: by 2002:a05:6808:2f10:b0:3d9:40c2:eb54 with SMTP id 5614622812f47-3dc416688bdmr13217183b6e.5.1723424431425;
        Sun, 11 Aug 2024 18:00:31 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe8cbdcsm3074062a12.61.2024.08.11.18.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 18:00:30 -0700 (PDT)
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
Subject: [PATCH v8 08/17] ACPI: pci_link: Clear the dependencies after probe
Date: Mon, 12 Aug 2024 06:29:20 +0530
Message-ID: <20240812005929.113499-9-sunilvl@ventanamicro.com>
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

RISC-V platforms need to use dependencies between PCI host bridge, Link
devices and the interrupt controllers to ensure probe order. The
dependency is like below.

Interrupt controller <-- Link Device <-- PCI Host bridge.

If there is no dependency between Link device and PCI Host Bridge,
then PCI devices may be probed prior to Link devices.  If a PCI
device is probed before its Link device, we won't be able to find
its INTx mapping.

So, add the link device's HID to dependency honor list and clear the
dependency after probe is done so that the dependent devices are
unblocked to probe.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
---
 drivers/acpi/pci_link.c | 2 ++
 drivers/acpi/scan.c     | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index aa1038b8aec4..b727db968f33 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -748,6 +748,8 @@ static int acpi_pci_link_add(struct acpi_device *device,
 	if (result)
 		kfree(link);
 
+	acpi_dev_clear_dependencies(device);
+
 	return result < 0 ? result : 1;
 }
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 28a221f956d7..753539a1f26b 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -863,6 +863,7 @@ static const char * const acpi_honor_dep_ids[] = {
 	"INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c access to camera sensors */
 	"RSCV0001", /* RISC-V PLIC */
 	"RSCV0002", /* RISC-V APLIC */
+	"PNP0C0F",  /* PCI Link Device */
 	NULL
 };
 
-- 
2.43.0

