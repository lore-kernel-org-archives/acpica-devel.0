Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980203321DF
	for <acpica-devel@lists.linux.dev>; Wed, 29 Oct 2025 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737277; cv=none; b=fHv+RzcPiYwRPErzHeFqQZavxQ7gQDWDXDQg0y5MUlp8/nGmeOdy9WOrNpmIUxdSY8podGsLMlJ7PCJly0gyw3uhhzDh4mx57dIdqnI+pkW4byE8PYBDdnkUqICB0C8aSLEt8ZdpNdyWkFccbX4NyOP5WdSA2fE4XdfMA8fXyoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737277; c=relaxed/simple;
	bh=TilcVfmqeN4S9SQk/86dbqTu5JigqINDawfpL8vf2DE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mItn/p5aGn2QP9l9BDo/VeSupLOLI5Fle+Rb+8/FzITCOsZwv7PwRXCiioBbp6s3q/WIYB+SznA3UeCPFrbGTEWlirNYAl7iE8YtbghWGTcQTL4lTHnKCm181gYvhhUERharCNQCDBBFGnb81hbv8Nh1g7F05HAayuWIT7LSmPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=khMXwLCF; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="khMXwLCF"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32ec291a325so5548869a91.1
        for <acpica-devel@lists.linux.dev>; Wed, 29 Oct 2025 04:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761737270; x=1762342070; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wd49FUCFXP7v439aOYgrBhlMaMpFr/VqGWFeAvQumyw=;
        b=khMXwLCFZjuph6ws2PjwC5qM1/0JqaIvuz6ShdqYmUMcsNtu8TEGJ3F45XZKnFmdvv
         z1FqTpSVAAxrDjFaDaM8U/Q1QGEBKdezZJqGDieiEKTKnIPf7NXFqBW45AwzJ5d+cxMK
         OELKVIJGIP6EDjROh9Qr4VUX04+eG5s/S1Gtlf5rFDqu+uCpXQWfk5f+NhtkkUy2IexD
         7IeeMeB5UPA3mDUE+8Xex4iuiAnXs+ih68TL9+TArvhabcizxTmi7oOaNsk5gY7SWo8v
         iLWdvU7EdRdgAGiKtqe+Atvet8fbB4zxf76WA7dAQts+hH5ExFRH5SkO2V50PvPKbb3f
         HCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737270; x=1762342070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wd49FUCFXP7v439aOYgrBhlMaMpFr/VqGWFeAvQumyw=;
        b=hNmOI4K54rgbSd34++kf0gNl67Dfpo9AZJT41n+3HxV7Zn7QqeibFSeS3FtyaAHGbU
         QvJ5+r3q+0BZ3x0r6Gp952+WVb7G+VCYn5zNXTntwheKCcsk/FbIPjLHTaOejw5MaFAv
         qUgphSxo1yMezzABZWKJsGHGk2fq0pgATVFK0iPgvzHS10kocm2M2vcuPPHBzd9rSpM+
         uHwdOH+JeuMXJXoUL4McND9BU6BWLo6jI2jDKdRkrh+gwEzQTgEPAEmugDbI/eRzjHlB
         lAe0ppvJuaPUJyluDTZ9LRyhWIp6JbZyB0GJTBB+R7waXoUaRJF+Gxxne7gZdame1g1z
         nZcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4iCOD7WCEtijJB6qRrNMkmYdZs8NU+INEG9kQ06k+BghIUVBvE9yOTBkjQSWt/rAkyzRXsaX4G2T8Pf8=@lists.linux.dev
X-Gm-Message-State: AOJu0YyKDv6x1zjYn7PEysYBQNNjhh4cg7KwPCSeiGVLp1owBC8QnFYx
	JHaMRW7maUBp/b5KXuyTgq4aOGvmZBJPP4zoMOtd/5Tglf8qp/2nWBN4jrEIGmM2hdE=
X-Gm-Gg: ASbGncsAQAbxLApNyJ1a7AbHj4QLh1va4GKSO8QlilbVMALNq5OUJLS98JXMjRyCleY
	m1OJPLZUBq1sk2vBhU8/em/j4Gh79wFkgsYlPyhhi7hqJCK7bEojEEYkltD92040DO41lPdGgRS
	4o/ObQjAIB3H34dRd6hgVKuRBnsNnu1vHIVf259XLNtEX2FIySmVhWoD0qlS4q3ExzL8yy4zcLo
	sHFLf0h/tt40Rz6aLH9xvZJLNCt153FMB3wMlj2RQU96zYrmcVPe4GLnOempSBpDx07BRfKNooN
	QSoAqrb1UvKg3Jbc1k8CxwSHR2V9CpInACvKzy35SBUHw1PSZpXlj64pgzxuorDg78+Xlbgobt2
	G9yv1xltA9iyetL4BV3EM1O50wMFgmaBnht4rLrlQw8PmhIcpnp423mWp6LEoE3dusrpLmk6EyE
	zcKG4aJgUT09QKMBbMwBuwdV6pbCCV
X-Google-Smtp-Source: AGHT+IEwpD5L2Hn2Oj9/1NiPPKl78u4FeofUgufEwNswN516sCORZuI1gux4yna6NQqFE96u6vitOQ==
X-Received: by 2002:a17:90b:1f8a:b0:33f:eca0:47c6 with SMTP id 98e67ed59e1d1-3403a2f179cmr2624640a91.30.1761737269909;
        Wed, 29 Oct 2025 04:27:49 -0700 (PDT)
Received: from ventana-desktop.localhost ([2405:201:d019:c0ce:f7f5:7789:48e5:c03f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm15316918a91.16.2025.10.29.04.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:27:49 -0700 (PDT)
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
Subject: [RFC PATCH v2 09/10] riscv: Select HAVE_ACPI_APEI required for RAS
Date: Wed, 29 Oct 2025 16:56:47 +0530
Message-ID: <20251029112649.3811657-10-hchauhan@ventanamicro.com>
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

Select the HAVE_ACPI_APEI option so that APEI GHES config options
are visible.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 22cda9c452d2..97aa3726e9f6 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -185,6 +185,7 @@ config RISCV
 	select HAVE_MOVE_PUD
 	select HAVE_PAGE_SIZE_4KB
 	select HAVE_PCI
+	select HAVE_ACPI_APEI if ACPI
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-- 
2.43.0

