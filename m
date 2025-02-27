Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CE623237F
	for <acpica-devel@lists.linux.dev>; Thu, 27 Feb 2025 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659836; cv=none; b=JAm/SksZElJxoZ7BnpxFGgR0eNmqqwTeUu9IWrA1JBbl7udj3Ga/Z9JGilkVI6r64VY/phIqVhH84Hvp/e7ynbpEjPR1nuFknnN6DaTHVm9RdVvVPmcqZQ5ouCRzjeifYbEl52Cw/QCQWF6tJox5d1XqDjxeSg6GRwlzvKMlEBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659836; c=relaxed/simple;
	bh=nwb9jXPHNocc0BR85JL7p0Pq9kLj9IODjbMJ59HBlc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lzFr0ozWdsDbH6r0IrgdyB1bhkiewidxx2+Nb736Fm0H/im4wTKG5t9IH3CmjwJXWY1klNfSrLwjKE5/Hs57rSgXA1abJKsbCELSU5lPQOOXkyPlbhZizHLmXeqyypdpeS0qM0k0btjAb01qmbScdD8gGBmfPTyvBOxnL7TSF2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=gkYwrliY; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="gkYwrliY"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-219f8263ae0so14270335ad.0
        for <acpica-devel@lists.linux.dev>; Thu, 27 Feb 2025 04:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740659835; x=1741264635; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNRn4grONdQPyJNJQgM7dzqjQjDGa6sfyVxFxG4j7Yo=;
        b=gkYwrliYMfIFQmGiOoxPyTSC9Ntzp3Gzt9qSX+ZjLNwNUeGRKImawZBF9LYhX2pM2f
         DJ6gUi6sKBdhaxcMzICyTVjAEXZRYwyhtaZ6KrLiNmyy3zqMJp1MRSxByDdHtURsRvKN
         O4kFnlZDGOm7BIPU4U65ibQL0CDAJJWsWK/+2nu8O9kxBvjyahdmMQAy49YbjNXYxQmd
         47OSWfNORyBWrvKW0yl4Ra0zM2x8Ct7Iep5Tj8YArMXgVq+AFqajYLiHhPqIOnetKyVh
         7UUZMan35GScf8vEIB5zZGa3BD9QXEIMxATNqPT/prGpCrelhLEs3ANUMEOI8cwvYA7e
         b3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659835; x=1741264635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNRn4grONdQPyJNJQgM7dzqjQjDGa6sfyVxFxG4j7Yo=;
        b=eJ2w8eY6Z2SYfM4Zk5CajFmDJUVeBnn/Zfxv9vTKkT7ADcuxpdKLXGX/1dCKi3tLMq
         2ix2QyGYL3AMh0YiL/apIFrnwrZeRcfvDHafEn20rcfhrDzTdd8vLysxWOPPGDNaegYT
         Y0nB0nmvRGI0VtE1EoeeRuCAvQDPYx0r26/WKLU2iq8RwYgVcWmXkeGPU8yZ26qdwINu
         Wu7GKP0JXVHeItc4jQ2zyLP4glCHDCQPmT09EfaXSZIVY0K1VLbKeMEP20IQjhfYVQUw
         K7e4u49yrU5ENo5zS/Or/ejU4KxlVmwG26U83Vwmw1o9VvKmOVKbIHdrvPMLDspZfpNR
         Gy/g==
X-Forwarded-Encrypted: i=1; AJvYcCWcc+Zcjle0O4jLyT9jPSLxcrQewxpAtyzb1JLYY6dp+PX4PEmYenOiofF89k6BPyReHx9pr5DEByLqIFI=@lists.linux.dev
X-Gm-Message-State: AOJu0YyPsgJ9m0+JLFgm9HtElwZTqHAr0Ctjupn6Q0RLulUTkgGjfNGy
	wz4KWruOovwf8EgypCVAX32dYMXzuJN3sNBZ4fO6Epqt7i3U7R1BY+mR+mj65Op9RZTAMDCpP+0
	Qzu4=
X-Gm-Gg: ASbGncsMe8lacdCLfHE6lXxFjX/Vio8snU9JWG4JyBcD0P2uyKRVfqhYl283EmyCX6q
	8G1AUJSeRaIxeV4xZoCQSKhQUf8xf/wJlKu4VuIowyy53p4UX8OmIL1Dpuz8ZTDHHqFgSNP10oN
	qC0gCL3wVHKNyNcAmJ0ytpQGUapAbQBfRuxYTOyk4+RB4vQ3HiKIuOFJ04IfQj28P+Vm8Lk5LNs
	lXzfui5CGyVKTVs4LeShUyAV1gdvzk+lMV7VscX2vbVBzwNgaKGZn29eXIs4V6poj0ZgVy8vcpB
	AQrNvU1P6pPRDgoEn3Gv/SqNyg4gRAYldHZG
X-Google-Smtp-Source: AGHT+IG53PBDiu6FVTVuBFXKbMl/pH0m+lbJmkXDl+xjPCROuVKlD+c6+Y7yRaOAw5SWzcbapXcaKA==
X-Received: by 2002:a17:902:e752:b0:223:3bf6:7e6a with SMTP id d9443c01a7336-2233bf6806bmr72051025ad.12.1740659834816;
        Thu, 27 Feb 2025 04:37:14 -0800 (PST)
Received: from ventana-bhyve.. ([49.37.249.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bddsm13219135ad.140.2025.02.27.04.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:37:14 -0800 (PST)
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
Subject: [RFC PATCH v1 07/10] riscv: Add RISC-V entries in processor type and ISA strings
Date: Thu, 27 Feb 2025 18:06:25 +0530
Message-ID: <20250227123628.2931490-8-hchauhan@ventanamicro.com>
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

- Add RISCV in processor type
- Add RISCV32/64 in ISA

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 drivers/firmware/efi/cper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index b69e68ef3f02..f2908296a48f 100644
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

