Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278F9231A42
	for <acpica-devel@lists.linux.dev>; Thu, 27 Feb 2025 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659826; cv=none; b=V866rQmnrMcYMyvn8Q9P6nHl4pDFIyrpeFvZ+1YVamu5T+zSM5vaJ8goz4qmVwon3oRkVfhQ2QrBxui43SllwmUZSYR2P8xDyMdic6iH132PvdIWbUsWwcTVscI37iVg6XDjPmJ77rOFMGpoJp4lY3WW7VMPMwaVziNbVXeV6No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659826; c=relaxed/simple;
	bh=Z//TrE4r/P2ORzzHAfm4GTTR/FxL7V8in1j3CWT877s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZbyluQ4cIUTMpoFzsmYm4Kti5nGDu8TLOgQHE9Fn9SCXpIRiVXOM2XDKO1eLYQ9YOZ/Zb4VFZneOoCoSWKDjb1OQfmPo4N7VKv7D3uktyJYKB5t7nDEi+U/blbdpcpVb1qQx4h+rMcalTvKDpBZnXB+9ENiaFeOSmztSbQuUPcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Qi64zHvn; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Qi64zHvn"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220c8f38febso14516655ad.2
        for <acpica-devel@lists.linux.dev>; Thu, 27 Feb 2025 04:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740659824; x=1741264624; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtQ05xO+EnCCpS3XXknTi9mJFSuRz+8Y7aZxhDwaUdc=;
        b=Qi64zHvn6Zm2jqIuna1iRfvtVRZPw3I1MgIagqrwMUKpKKE2Cj3dPPW1lYEwXvmSdE
         wQLhVJFk2P+sPnsWzdKQ735FVC4EuPJerQ1CbtVu0ev2VmkXQat4HdCrqCugiKLRDSol
         nFXrqmb48vgrkkQEnMG/eXhBpLMTK4CE2z6/LBpcdVxCiWZil2XhMyFr5+uVxhgA/MrL
         qiALOtPJnvQATOgaCwnnr0UB7WRrNHgHzC0TSlxxui9Wef7FJZj4O4jYqKC5qGA03Qza
         ALRNFQeFPVMhY++7smprcGhPdlA5gG5exLDcNZLolTzpWUbQ9QtfCDjFa/1euAAfysIA
         YtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659824; x=1741264624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtQ05xO+EnCCpS3XXknTi9mJFSuRz+8Y7aZxhDwaUdc=;
        b=hFpK2nXETWpwqzidv1GlZOAUZUp7Ym+4NCPmfiF55NcRMzYN0NPw/psCdIQH/ULfb/
         HmJkHdfvrrRKdYwE+LYDNUDb4qVeoEj1cvB8Ikm8OznkN6fWD/1Kra3k2JEfkW4M0Sad
         9ggVD3QwCWpxh1Ci7iZ7gIuivs3EvIJt+/faoweNflgiizv4+l9byWaIln3ecoVJ3jjd
         YYFtFc+zsmofTyIAUWbeMAp9pWJOWG1plgUABnax1GB/yQnXbK9JrnnXh5+MfWH+keJS
         YSz6qkW0aiz7dI/74pcR0Wg11pPFuXCS4Y3ySqC+1PwznYbRGKwjYnOa4dY3LyJAmH44
         z7Ew==
X-Forwarded-Encrypted: i=1; AJvYcCW0U3iue3benOzU3yqAHZ8PVO4NbqH8b21qwkPvOnAdf0n6TD75AdbOOm6K2ZcvVVjt9W72i+3jSAsKTQw=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0gw1sLqTzBHHfMpkxCcW5XCz9xCpjp/Ikzu3kVDmAJnV/whxv
	haJypkM1sdhResqQsnK2z4+H097CrecHGI7SWINWTQ1fW1dMUUrjYs45PUhwd7E=
X-Gm-Gg: ASbGnct0letx+g0+4ERYan6slx/bUalIqY+CRN5SRYqnFTDNZE+j7LQI+uDh5K+qfti
	PER1aBySW7kRl7Q0/N5Gm+gtHJoqOWohwRheuDHADE/CTNXoZCJltc+rh6z/dOOO314OhoDZc5R
	wnbFINyOOr3bZ5DXM4w0YVoZgRimPfHEpowgyXqkdYQHzvHHpU5RzpatwZH1xLFFLkwIaUAKojC
	jaQt84ryvzsxurOYgVjBN85uVgWBuJXZ+BSqVLapTni9J8cDSPGXxCYLY5PwKVT97gZYrlmqkNK
	4HNP0YRt9pmDfe7j04WGJRlPTmCr0XnZCktv
X-Google-Smtp-Source: AGHT+IFkP7CS9xqANnPn4d9Sz+3RrDXTk1H1Jji56UTUSX5o72PLQQPlMQJClQVJhKn4XxMTw6Hpiw==
X-Received: by 2002:a17:903:2288:b0:221:331:1d46 with SMTP id d9443c01a7336-2219ff8278fmr376544635ad.2.1740659824356;
        Thu, 27 Feb 2025 04:37:04 -0800 (PST)
Received: from ventana-bhyve.. ([49.37.249.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bddsm13219135ad.140.2025.02.27.04.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:37:04 -0800 (PST)
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
Subject: [RFC PATCH v1 05/10] riscv: conditionally compile GHES NMI spool function
Date: Thu, 27 Feb 2025 18:06:23 +0530
Message-ID: <20250227123628.2931490-6-hchauhan@ventanamicro.com>
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

Compile ghes_in_nmi_spool_from_list only when NMI and SEA
is enabled. Otherwise compilation fails with "defined but
not used" error.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 drivers/acpi/apei/ghes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index b72772494655..8a1029163799 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1231,6 +1231,7 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
 	return rc;
 }
 
+#if defined(CONFIG_HAVE_ACPI_APEI_NMI) || defined(CONFIG_ACPI_APEI_SEA)
 static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
 				       enum fixed_addresses fixmap_idx)
 {
@@ -1249,6 +1250,7 @@ static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
 
 	return ret;
 }
+#endif
 
 #ifdef CONFIG_ACPI_APEI_SEA
 static LIST_HEAD(ghes_sea);
-- 
2.43.0

