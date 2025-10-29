Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773B531062C
	for <acpica-devel@lists.linux.dev>; Wed, 29 Oct 2025 11:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737241; cv=none; b=eGkhaK0E9/V0u3iTxr2PDKQ3W4xkqrtS9EfxRleYbUw+nWpbt/DhcgMD9g7Kc2vjh+h6EKw8Aub73gWR4FIM5JFaNH/9dq4tgvyn1amrYFHn0MJxI6BYanhWRL/ucCaP1pkWb3F2j5Q7c5RFu9HbQVgq79Ydr7oiPe/Z587oWtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737241; c=relaxed/simple;
	bh=3k4eu6bu2FqRegq68CTBi09f2mevDFi0nw5dHF0KKDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtlXTpTo8gqtkZN3/cufsYnfYUkOcm1d2dD84OBbGSixz7OBQMPGZ8ySjLexo7VAFYgxPpXV+aOuvN7ns1MIFMflirId+PSnpyyVBiiz+8crt+vqHK172h7ED+FjXG6kZ2pF6VPkb/7U1cjsO08H+yGPnDEw3wA8Qke/xk2iXfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=HwqMzSUJ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="HwqMzSUJ"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-33badfbbc48so9042623a91.2
        for <acpica-devel@lists.linux.dev>; Wed, 29 Oct 2025 04:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761737239; x=1762342039; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjTmNoD235Z0Q+UTnvL+T6Jk9tiw9Xtbmp+pbEirE4Q=;
        b=HwqMzSUJc10jw5dPKXb/5e16EZMdMiQx14ECMktLtpzamnHIWo2hXmAPtFrhlSJFoG
         1g90EMUHJyAKr5n3U8psJUF8FFBNfi9Dv7WUn9pgXkiGyYjSINIbBLrdvPglwvz2fyMp
         RSbUpbG6At0ykLRPxm4J/2ixf5PpUz5/wIDWfE0PUON1XIz5kvilTSW138Q7IqyPrdmZ
         MmGXWbnaMs0/cQ5qBl6kQvTBe5V8bnqTBf17fsl+/TwbSvPJ8qS9/Eec+BDfQoWwKVjC
         koCJjconXH/zA/Jt3UFaPMGocT+mo9jgygib7rPMApieY8TIp7qH5O1egIIcnyArwHhq
         ESLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737239; x=1762342039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CjTmNoD235Z0Q+UTnvL+T6Jk9tiw9Xtbmp+pbEirE4Q=;
        b=Y8MXqdDmAcyB9zvObM3Byckc6JI5XcFY8ul1KeTopBIJWvMuuIESzcvIcFw/4GtgUI
         q5bQZw90ADoexnTg7ifC8sMwOT3M39eJUBVJ8/QilmYRdKuQLpX6hzAbT3p6Yo415veT
         5TbLskw7CR+1kPt9E2Sp/Lm6wEOYLmnB0ary8PeiY4vEUOpyGhNDmAg/CY1WYlk0natQ
         dXUdHc+WUGysrbYOo1Ns0KfQ/upvwxAbB9/+yfOunKWccLRdUDaYdCVX2W21BXrXHeSC
         yNSSe/48QNgZRtYQJhbj8jDzKnZYx+mni6jXtT3A0TIpAEbKaBnJyESE4oNvuJ81MisL
         DRnw==
X-Forwarded-Encrypted: i=1; AJvYcCWlbV4V6ZPizaDzZ0J6+HxrqdI53x+M9AdzVx4TJlhKop8X2vIGvDc2RIbyCSIFZMN77bGNAvyOf25Oh08=@lists.linux.dev
X-Gm-Message-State: AOJu0YxCq1/dB5neai/h5Fo1BUuxrjhVUhPS0Mtsu4WulmdeZs/kRP0y
	tviu64dcc8c9y0l8UXMCTUQ9Re19qTUOUvtKqIQRmtCx96SS1g4K7gcuQZlxvE2sNTY=
X-Gm-Gg: ASbGncuH9lmEz9yAWbtD0B5zbMhcWmnylKmMviQQZrROx135T8BMXPucvjhZJ1u+eqj
	GjleMRM0a4d08yAIYikWjVV4NbtwcDKMTQITWlnF6h42TdPYnFWWlowQOc3wTzColNvEJ92l1b+
	OSuT/Tvj3SEI+CKdjr4mFeHeqrjUsE4h5xdrMcUuxU68y+Y99ffwDeTpJ1yHkkVSGm9rxNp7ysu
	IAqEpkGYBuslXSolfz5zyh7rEgFb1FexBYmkoPPnJkecZR3cWjy4IWWCCPvwzPpYFwMMKbf/fDz
	ixsb/bysV9stHine3/AyfUQ7Lqbjse8FklxQ/0OZhXMuxzUhz541b+iZBcuZ8vSd83OLhcA3jBJ
	sxLbjBcSsf3UoMHFafxWjAVRIIU/zKbV7j3bwg7SA8sUhh3pIrGgHJTwMDKYWlApHLexrchOgxp
	OwUiDg2yv3Uc8wa/2wn+N/49QitZnE
X-Google-Smtp-Source: AGHT+IGV9vVH8+hlZLrwbCF6EeuF04kV3fpI5UDP/oNNvPeA5hF+38GHsytRURBATavrU36r7KMQfg==
X-Received: by 2002:a17:90b:384d:b0:339:d03e:2a11 with SMTP id 98e67ed59e1d1-3403a15844cmr2891587a91.14.1761737238675;
        Wed, 29 Oct 2025 04:27:18 -0700 (PDT)
Received: from ventana-desktop.localhost ([2405:201:d019:c0ce:f7f5:7789:48e5:c03f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm15316918a91.16.2025.10.29.04.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:27:18 -0700 (PDT)
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
Subject: [RFC PATCH v2 03/10] acpi: Introduce SSE in HEST notification types
Date: Wed, 29 Oct 2025 16:56:41 +0530
Message-ID: <20251029112649.3811657-4-hchauhan@ventanamicro.com>
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

Introduce a new HEST notification type for RISC-V SSE events.
The GHES entry's notification structure contains the notification
to be used for a given error source. For error sources delivering
events over SSE, it should contain the new SSE notification type.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 include/acpi/actbl1.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 7f35eb0e8458..20b490227398 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1535,7 +1535,8 @@ enum acpi_hest_notify_types {
 	ACPI_HEST_NOTIFY_SEI = 9,	/* ACPI 6.1 */
 	ACPI_HEST_NOTIFY_GSIV = 10,	/* ACPI 6.1 */
 	ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED = 11,	/* ACPI 6.2 */
-	ACPI_HEST_NOTIFY_RESERVED = 12	/* 12 and greater are reserved */
+	ACPI_HEST_NOTIFY_SSE = 12, /* RISCV SSE */
+	ACPI_HEST_NOTIFY_RESERVED = 13	/* 13 and greater are reserved */
 };
 
 /* Values for config_write_enable bitfield above */
-- 
2.43.0

