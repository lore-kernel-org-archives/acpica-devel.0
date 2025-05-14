Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CF21F78E0
	for <acpica-devel@lists.linux.dev>; Wed, 14 May 2025 05:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747202272; cv=none; b=ZQ37F8hTyMES+vuJcNszLyy7poKyw/3D3HKokZ1TpNx5QuRncjVuU8kpy7Le5yqqHiJjSSq9L4W/0FSHk1dchH11zHWgMc5jy1bqoyqM4fLoUD29g/nZwZpbW3EhydZ2Xmf4JRlgdz5XM+vRiZKNHATB+MCQrb1JY73f2coy4G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747202272; c=relaxed/simple;
	bh=j10W9ERtTCLuRtXkzV2FgTmpZyoQoyxJASYgwPYwbms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3ZOtZ9dDAtRKzWiJ9k7J8JwSJb1On4/jpSKFKTwrPtif4tc4ZfwU47WIEO89LKUgalzVRu0u/M3skH0FGJVZJ1FHSpY4+Bxsu7GreD8QeYVNGRLK3KQSiB7EZawjy96DsUEJ1bv7brT+C4a9voBnExVRw7pjesunHjgzaHlKQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Wa3E+byj; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Wa3E+byj"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b1a1930a922so4672082a12.3
        for <acpica-devel@lists.linux.dev>; Tue, 13 May 2025 22:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1747202270; x=1747807070; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnkjvbjcuENvVJ26saTSRizx+WjEaICu8Lhi+aJlcF8=;
        b=Wa3E+byjTPQWTThKH/3oSazvUr8BR61TN7JVyIW8X4cPtXb1Exfiim2tYOZo5FJBOl
         s4MTg31AHcUDmuP4U3KtZoi2ahiVF1MP6ILnEKVyb8vmfIyhEpmUA3crK6tIHJkxebdP
         DO5s1xfUPSMePs2OMyU+QF1yMDojlSaSn9zvpFJmczHNkC4oIDgAIcGIoJMQayOSagDN
         JGNf/BGhNd2mFTVuUVMXV5PDxiGr43CxbsYsPHNOBPUaWpgLmUtqNzJavoljQkcoRdIh
         ZNmJj26dQOY1BaJ7ZRfvF877VzQTY30fgrvw1AZDVZPWzN6U/yEYen1GP90D83/LVa5f
         N/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747202270; x=1747807070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AnkjvbjcuENvVJ26saTSRizx+WjEaICu8Lhi+aJlcF8=;
        b=b4DGCdd30CHakr5yr81BGJLydlziJmQn5cNgeovI4dzgX2XIyc4Kog22T20tvLIbJZ
         zNTJXvImpfLVZbectocW1anm85FZCg6w3iJ+sQYGv1nyVmwxA5EQSsx0JNsnESq1Aolu
         R5B0ncjB2IauRQfeWZk9kVntiE3NTTevtmkFQ3qcTJWe+sWw2pbJZwyxcC0YBDmSFKjC
         ooJeQ+GEJr/K92IPaATAjgdk/cDsKsJwz3r/fTe5TNSL7OkCSw3IP7Bxo6xRawMOQJN0
         iNDCTA4RL/eOuZHqFwAhhH/6fj47RFaL+hkazyC6XK4Q7Oj1xsLfcE3+iqsR32+JCg1K
         j2cg==
X-Forwarded-Encrypted: i=1; AJvYcCWPYU88P8HaUrWsqYzRjzovuV6yuHzJYcSKP2x/4wxImfKoc1p1sm/wnb0KvJJsOqIQfjaI1UN1gZ2Kyu8=@lists.linux.dev
X-Gm-Message-State: AOJu0YwZHXmaSOt0alED1jqu65TfcyrqVPbqXRlCbQSAP8wP45bgpQtC
	JnNA9PeF37xWF9owcTQ787yys6OB3ESsQLqPKMCXgKKrsuGjMw75WwFM1yyecF4=
X-Gm-Gg: ASbGnctrvLXSYhIg9NtAQIwDZ24t+XwbDtcNatFLQVNX9LUZlvPeKw1jzJoouUrwQpn
	78RhIVrIP7q0kMnjoBi5rag93+LMROG+lOtRVcvN6AfFHLInjnyayMwFH2Wg/pJJZdJZqQqRwOK
	xbu44SZnmwdvKeMhyQyHJ0WDYI9pAypbL1ic4R1i6+Qy/ipNhZziMXfEnjcrjlAJZNugT4Are4y
	RUvUBtHn7Hbr3dnzIAtx48q214WjsBuKBtwUwV3EeBw3zH12FvReBQCgDIS4YSWxgJBQFSABOD0
	ZWwSOFrKQRSfYnr/HtTJvb9qd3/K/J1R5j1TxPPe61h5FcLFwchrs/BVz0o0DQ==
X-Google-Smtp-Source: AGHT+IGOnxIH4YjGEW5GtZaYNs+W/C6hB2R8AaG0BsyNWrPx0B0lajN6mf6PqMko8vPxUuZYiIe5uA==
X-Received: by 2002:a17:903:3ba3:b0:223:3396:15e8 with SMTP id d9443c01a7336-2319810114emr33089565ad.22.1747202270073;
        Tue, 13 May 2025 22:57:50 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.196.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc8271c2dsm91721615ad.135.2025.05.13.22.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 22:57:49 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev,
	acpica-devel@lists.linux.dev
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 3/4] ACPI: scan: Add support for RISC-V in acpi_iommu_configure_id()
Date: Wed, 14 May 2025 11:27:22 +0530
Message-ID: <20250514055723.1328557-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250514055723.1328557-1-sunilvl@ventanamicro.com>
References: <20250514055723.1328557-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acpi_iommu_configure_id() currently supports only IORT (ARM) and VIOT.
Add support for RISC-V as well.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/scan.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index fb1fe9f3b1a3..70f57d58fd61 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/acpi.h>
 #include <linux/acpi_iort.h>
+#include <linux/acpi_rimt.h>
 #include <linux/acpi_viot.h>
 #include <linux/iommu.h>
 #include <linux/signal.h>
@@ -1628,8 +1629,12 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 	}
 
 	err = iort_iommu_configure_id(dev, id_in);
-	if (err && err != -EPROBE_DEFER)
-		err = viot_iommu_configure(dev);
+	if (err && err != -EPROBE_DEFER) {
+		err = rimt_iommu_configure_id(dev, id_in);
+		if (err && err != -EPROBE_DEFER)
+			err = viot_iommu_configure(dev);
+	}
+
 	mutex_unlock(&iommu_probe_device_lock);
 
 	return err;
-- 
2.43.0

