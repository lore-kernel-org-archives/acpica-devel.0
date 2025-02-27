Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9EC2309AA
	for <acpica-devel@lists.linux.dev>; Thu, 27 Feb 2025 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659816; cv=none; b=gpWBpTdb1jccZm4TSYWH0goKmfDOIkl6XLRHXnWhdfZmzVp1jiYtkdZ8jjzJDee/JKDXaz9FLVxBZurZXf6NFy1Ha5M2Pwsef1yQQGIL2DyBd2d6j/rYguevlY+wJYhzAyfuFWdCssaWarTUgr39rl4fDHDtw2DZ1WhqYx1OM2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659816; c=relaxed/simple;
	bh=67ls/POKUjWPQj872a0gGQ9pTH69yGPYjMpXWSU47vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fs+n8Q+ZMFweiuLUdTXaR2UespPzLh74dIr+H+V0D3gmgx6LP+wqTuEL4zXvyfG4rUILXaANeitwHKahVnl+zl1pqwMNKVX1NYKas83lB1Qe6rXLsUa249t2stQJth7ceQxE9PtnG92nAp3iaRHLZOWwSixrc4rbZGjWlVXxVic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=JVb+1i8+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="JVb+1i8+"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220f4dd756eso16014595ad.3
        for <acpica-devel@lists.linux.dev>; Thu, 27 Feb 2025 04:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740659814; x=1741264614; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9tq9UU0quHGMxFhwTeHcsfn2hmcgfg1pwu61qXDOW4=;
        b=JVb+1i8+pfc94r+gOk41zkwDz9yOHE+DGadEJn/N97SASAMtmFKmhZg9w0Dd1SZkMh
         34ODmq+R3mKlwy+/04aX3q1hU1nF1srO8EkyTcWA0UOHKJwa4sE9DL7D32SG2dPVzeAc
         6CyEvl0/JalriHmu4Qf28M8JaoD0kJ3ok7a6ziZpC+p/w8cI1uMAcgh8Doidr3f286Rv
         u9yuXhjzUPdd/zxIiAHVQLD21ahXG+NMD8YaaH00FuN0G8vPK03V6iG04SGZckjlKnlQ
         rIynSUOyUcf00PS1gx6YeZKanVM9wpwFzQruIsLeK4FPsKFt3wwqqylcnAqhNOL0otBQ
         wZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659814; x=1741264614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9tq9UU0quHGMxFhwTeHcsfn2hmcgfg1pwu61qXDOW4=;
        b=B2SIJ9G0FvLaIQVQA7ESZuGlM2aEyOEfQ8v+M8KrmqhCKotghIZPunintHHA5dkjQ0
         RUrnZkeIpzpIRg38ojPluEYb9BaL1/IQyzzbNwk86djTqpi5Wa+bynYrrtP+HIY5lFn4
         3z95nwldZCdIFoBf/I+/2KUN0CoS28gcmVdqrfMNEEI6evptXWczifPi7R8mEOPGHm6m
         arkMbLrOlaSv05uWpcyi1ZZ85CAwqBE/wWizvI/M2fvCIIfhd1OTdxe6DQDCrYLuM5uu
         z6K71peFQGms7GnlF7zCFndS83XQkjQ9gsBWRveBvgS+uY+ZB5rhOb2kDvJcpFpQ1/ph
         rrxw==
X-Forwarded-Encrypted: i=1; AJvYcCWOoMXVM4SdvVCqW8o6EYTqiFvEDZDMNOmWB02fjngH5cVcwS06bPJQzgFm3QREw0p+DVw51MeXoajWeb8=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6OmR/Cvvr6U0Yqg72NZrjTHvZ/JgKZQvs5zRRrS9U2Bsq8kKO
	gLwP9nCFCtIIyEbnKfnn8qfOGBM9oVlr2uhF52+/A1ZRX77Mb8NzNvgz711jjbbWKc58tyZkrhP
	f8W8=
X-Gm-Gg: ASbGncszNgf0g7hLWs+kiiImN7zyMAyvPr9ilXDDDpBOT1krZSZrIoBbIt0rQ1PsvCK
	jwZVnyINrlH6QJJY1o9LY383gwSYFerXsAEH41MUdPpzJxTWSRCAqYQbM2iopIn8vT1Ss5JPbTO
	w8Hquiw6Hs5wY0p2i/ep/5ib50mWcP6IU5Ry7hr06dmczhdE6QeaUmDYEz2sgT8nVx50KehVVV5
	/URmcI5e/mvbwket8bKdlLrkLFgQuLysYWpML8nVAUuybn6kzj6PzUrfiXsqjGkIYUsbdyKe9Ne
	yLq+UDd8SzPP/IU8pV08To51IKHqGaao0G1j
X-Google-Smtp-Source: AGHT+IHVfqxszUaYFM69ostPnakgkazkeqpkl6j+lHgInhnZ+gtwN2tclnkImUVqCbY1mWtl7iGV3Q==
X-Received: by 2002:a17:903:22c2:b0:21f:55e:ed71 with SMTP id d9443c01a7336-22307b45598mr186650025ad.5.1740659814323;
        Thu, 27 Feb 2025 04:36:54 -0800 (PST)
Received: from ventana-bhyve.. ([49.37.249.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bddsm13219135ad.140.2025.02.27.04.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:36:54 -0800 (PST)
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
Subject: [RFC PATCH v1 03/10] acpi: Introduce SSE in HEST notification types
Date: Thu, 27 Feb 2025 18:06:21 +0530
Message-ID: <20250227123628.2931490-4-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
References: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
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
index 387fc821703a..df577bf25423 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1515,7 +1515,8 @@ enum acpi_hest_notify_types {
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

