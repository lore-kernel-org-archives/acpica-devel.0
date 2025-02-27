Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2DA233D87
	for <acpica-devel@lists.linux.dev>; Thu, 27 Feb 2025 12:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659848; cv=none; b=Y/Yjf7GwxsiOjV1ueyAgXbYSQKrS3jBXyZf8hG9Zpo+fZjWTMzZ0/XyJrUu7lL6RLQlO/7oJQAxKZSTm4JsCKHH6JunEAZN4xtXThbNO85BM/F3r4p+pzS9AtPwk+aT67sEdFCjv3n5MtZ3yT3/D/Aa2h6FQ/vrXaeutIsCc+nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659848; c=relaxed/simple;
	bh=Of9PqcRio9hOrtrXaK3C+7d5d06uoPfQDo/STc3oCQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXvx8VChKnJqBEQ5rQkBxGJw54cbRj1hsaJV1nHGQx+1J0awkeQ1eN1Nr6iulcy1A5IJgYRUtE8jHL8yxAFqj3lI2fhTK11B5/Vo1DiV5oXthm1fNOXiIKTWDJKWWldsjenW/KSCvsNqeGYVLW2a1D1F2sSL1kKGmz+v4FrKXiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=oMfglBFr; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="oMfglBFr"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2234e4b079cso13081725ad.1
        for <acpica-devel@lists.linux.dev>; Thu, 27 Feb 2025 04:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740659845; x=1741264645; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcOi1q1j+KD4L6iG3zLb6+WxKLL1t6DJV3NbpeiJXTU=;
        b=oMfglBFrPlYXXdJaFcBdjkkDxOnq9ybnDVZY+m4TV3fLgvA90GSEKnuze6Bsk6qG0F
         kWdo3c5Lta0cAnhP31S4cw3cu7N7VonYp5UEFl40fcsee9QvqPdCXZ24eNOeW0zeKY4b
         /y5PdtzX5L0NTm5891+4oh3OaByoLxf08it0eurlFw9FZPBr6BSR4C6WEvwywFWSmKx2
         2OBHHIJf0jxFcXcqvV5ypii69Pnvn4I/h1TLW9PYSiTObZwHDOy9ciwVm+zvNGGa/eeO
         Oo508Kj56Xb5i02rNgrETZt4AA2O3eP/WviPojMvUnDUeAxHAdENlVfxWUH5DdZ7TLYw
         LlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659845; x=1741264645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcOi1q1j+KD4L6iG3zLb6+WxKLL1t6DJV3NbpeiJXTU=;
        b=TienVB8zv55Zs09kpDB/qde/Zr2/yIdW5nUc/PPzzIgLVndheZa39YLIyNi0WdLUV0
         8jcehmmIbRBKYHH/wMHOxPxkg6WU0tYVFUjv9j1cR4j7jY7uiigGxi/jkvSzEKk5Isyn
         u8pvITtJIBv0WK6AewuOmE92ItR86b4qG1u//isspInEHU26FdK7hGpF4KvoBZBmR0V1
         moqf+VPZqnK8mLBW0ZpVvh0WlmzGy0ZzmY/uwbSoWedtwI8YypUCMQZKpWQN09HW9gyX
         GRqY5zDUCxWO7sAyt1VIUzegrcZAN39zDBVPjQWmtZ58UO1dkseArU4wcSrS2Bfw/EK4
         HAqg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ6HS9JIcbhSukwJEFj4Eb83e3Pfq80eiTASxYS2qQDWM91Pb7HLmdG09MFb339zrU3pcEnHFKhbcXXpg=@lists.linux.dev
X-Gm-Message-State: AOJu0YxqhcfNxscdVsBsm+5/B+y38ef5Z1ulWd29JP0KIWF8RLjsXfoj
	+Xj4JvsDP+U9kjjMPgYp5zUlvP9M4zIVPmORVYgUvbqqA02yZozZZdQHWdOd73k=
X-Gm-Gg: ASbGnctq+H7DMxM/t2rYmhMOWrz98JQ5zcB/fhJ3Woaltpu7gaeR7ttdDfeTs5gzJeH
	4ECO6YeYjFH41PvzvxqjSinN189tzP2hDHQd0uREAFyMaV9dcbHlzgBbH7kiSkbJnEAPCNL4elb
	WCvfeOYhhnE6mwwRE0JJEZ8N12zE8P0FjFCgRVM9y4KOZ6HTKeaUzCHp+5JU+wYpzbnhe9nDnT5
	3V72ADM1SBZwD+lHIn3rgBznLJ8X/+y5YcknLjcQalNWYj2RBJnILbqP+Si+fbwovGVK3e2pQer
	OV7oTJJDi8fpVGwfi9Kn1pg10lptm0msDd1/
X-Google-Smtp-Source: AGHT+IFpHziUTuaJEINi+EgHoRKrGPAz4AsnUhhSqo24MLZ7IPH1ipJJRVjiescHNO1qawzm+Z45XQ==
X-Received: by 2002:a17:903:1c6:b0:223:4a10:311b with SMTP id d9443c01a7336-2234a1033camr48544315ad.1.1740659845617;
        Thu, 27 Feb 2025 04:37:25 -0800 (PST)
Received: from ventana-bhyve.. ([49.37.249.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bddsm13219135ad.140.2025.02.27.04.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:37:24 -0800 (PST)
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
Subject: [RFC PATCH v1 09/10] riscv: Add config option to enable APEI SSE handler
Date: Thu, 27 Feb 2025 18:06:27 +0530
Message-ID: <20250227123628.2931490-10-hchauhan@ventanamicro.com>
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

APEI SSE handlers can be enabled/disabled with this config
option. When enabled, the SSE registration is done for GHES
entries having notification type set to SSE. When disabled,
registration function return not supported error.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 drivers/acpi/apei/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 3cfe7e7475f2..be1eaba9b093 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -45,6 +45,11 @@ config ACPI_APEI_SEA
 	depends on ARM64 && ACPI_APEI_GHES
 	default y
 
+config ACPI_APEI_SSE
+	bool
+	depends on RISCV && RISCV_SSE && ACPI_APEI_GHES
+	default y
+
 config ACPI_APEI_MEMORY_FAILURE
 	bool "APEI memory error recovering support"
 	depends on ACPI_APEI && MEMORY_FAILURE
-- 
2.43.0

