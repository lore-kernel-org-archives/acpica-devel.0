Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7333B3314B8
	for <acpica-devel@lists.linux.dev>; Wed, 29 Oct 2025 11:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737231; cv=none; b=i3YqPm+MbY1oxRPXW/n85bayqDQ8vIKbafGAdNGSbEF2GYAFQbM2D7NEP4ynBdA4tUUrwYK+Q1XkVOQxqwhHRSgQpjZhEQB69prkeOG0DkVTQviq0Al1ainu+Fvh/otQyNnIMRSt1tGOe2o5lbODURvkMkReTa4aq54D4DopeKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737231; c=relaxed/simple;
	bh=xZ3ZGRZyyesAYiVSJppgbzc/6wpmKcXOnx/IFbeBZY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1qJbuqJmZuFNtQxeGd4onrPax07cZR6a2uvA/sCffQO78/p+hpk3izNdYqqAXtvUaKZGRiVWN0ytL+nneFUzd25SiMHiKuHFKM6H3949tNglceWrBKBI7DSER3rqbMEOoct6m149n9x+mVjBdhbzNucVkCtrsphZwdoZr2mWGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=d7b5+1th; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="d7b5+1th"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-33d7589774fso6886509a91.0
        for <acpica-devel@lists.linux.dev>; Wed, 29 Oct 2025 04:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761737228; x=1762342028; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fc2pmS4Yu1PyEFNeNlAsHoxFDYNywDlEMWQLdy1zt3o=;
        b=d7b5+1thRTGdXPu3bg9K3rFSZ+ox2ZMOkdYs5qv7U29EJ3ZK4nEscMI3JbJcp3x+Kj
         nYyhGj90boyq3TL5UVflb3C7L/nr/bQmr8U1OYUYBEJvAG+wLcrKeX8O5VoCcL3dEMbB
         UC/q5sy4yvcEXYKtGc7+PldKu2OJ8Lx6j2kUM6d5GsdISpgMmSTf5r6MHxsGdjdMxAoC
         KocVNMbzblO5U7lUQwF/uUJ/kjyGtsWHVNuBL7o0bqMjMrynoy8E0Iqhi8afrRw+n8q7
         nmyC2mc0crMxKAK9AuBdMh6Yz24LwVY/CK0kPiFc9zVigPKIQVENtaGg6MsWHfI3PLPT
         3VfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737228; x=1762342028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fc2pmS4Yu1PyEFNeNlAsHoxFDYNywDlEMWQLdy1zt3o=;
        b=PaBcmcI/mOLwxkrqQn2HDGa5ZCs1O0EiuJvsa9H0ue0CpmRGsQN74GitTpRAQuGEmv
         9xBhjebowM2NWuduuHhXTGjr+6b5wMzL9icCuQC4bSa+yoG/27MjLv8vm8/kyldNcqzj
         hqgY3OEPYi3r2TdcJEG/wV9GVVYsDEHHrZyR5KO7gcl157WsLDAa4CjoQlBbHQMTk1wi
         xUfEC7wBjiaBmI8Vt/IqDd5uNDC32EOfaByhzmo6OR1WWWGbdG9ngbhWTppO5e8b9Mg4
         c+vl0XSEEJNDOwZDuzRyOhFs02JHpMDJpWvQfj1eqHl7OAVVVnMO9ZJDTmVFL5oVW6+F
         arsA==
X-Forwarded-Encrypted: i=1; AJvYcCXksxlGcIGQgvcTYnaAPYS4dUtJiIQRu5NnwdsvjtpPuvpUIbnhLKLa+cFCzQabb18NOBY8QxxeYlA0YBo=@lists.linux.dev
X-Gm-Message-State: AOJu0YxU+bdMmyYiyFNuhnwrnBB+AEILxvGvmiFHXo/js073rlqeWhF8
	YPKzhXaA3SKAaRzBidhVXxTvVsQHBucxZmPkuGWq57YK7+TmJFbAnlSknPCSyGtxS8o=
X-Gm-Gg: ASbGncseDGwi4T4d94+4Ap/PqVlHMiWphM3QCSSciklHQgYJxKeJeK5BiRA7kLO5NPf
	ZKGkqp7e7+3XhSsAhHA47dX+VhT86zP8CI3nh+kp0YZ22hmUqVaWILv90ONBtyvVrsD/uLFGeg2
	fn81tA0xnaGlEGwrGqN4dddt3VLetOZy2Ypm7qlHCT2GsiWUPI1WHE98amPN47J+PmbsmVgnitv
	o0+NoMCa+JC3nVwE0vbcBzFZ/KwrpxvBGgXQU1rJj0HG+TofZuzPmrxNH5bo/3PITRQVZKVds+X
	ViL16NLIPNqipR83xn+9qt8gUmv3sBuucwv1zrm/85Tm32jF6bK0XnbYkYcCOnjFLgfTDSGcV21
	LU+XSdA++jEDnOIH4TQLtXdossuy6+M7gywkQyNL5zPJqbioSKHd/C7smmB+b2z/JXtdUhXI3j/
	vAV42LICpRhPipzXRUijt+aqebsn9W
X-Google-Smtp-Source: AGHT+IGEAqFeWf0ftjlgJx4OkwPZYhleAzhblNhIB2XsxH/EACVURZv5OiId6pITaCbKSnoGThy0lA==
X-Received: by 2002:a17:90b:2811:b0:330:6f13:53fc with SMTP id 98e67ed59e1d1-3403a290f88mr2790213a91.27.1761737228426;
        Wed, 29 Oct 2025 04:27:08 -0700 (PDT)
Received: from ventana-desktop.localhost ([2405:201:d019:c0ce:f7f5:7789:48e5:c03f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm15316918a91.16.2025.10.29.04.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:27:08 -0700 (PDT)
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
Subject: [RFC PATCH v2 01/10] riscv: Define ioremap_cache for RISC-V
Date: Wed, 29 Oct 2025 16:56:39 +0530
Message-ID: <20251029112649.3811657-2-hchauhan@ventanamicro.com>
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

bert and einj drivers use ioremap_cache for mapping entries
but ioremap_cache is not defined for RISC-V.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 arch/riscv/include/asm/io.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index 09bb5f57a9d3..5550b28f38db 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -142,6 +142,9 @@ __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw())
 #ifdef CONFIG_MMU
 #define arch_memremap_wb(addr, size, flags)	\
 	((__force void *)ioremap_prot((addr), (size), __pgprot(_PAGE_KERNEL)))
+
+#define ioremap_cache(addr, size)					\
+	((__force void *)ioremap_prot((addr), (size), PAGE_KERNEL))
 #endif
 
 #endif /* _ASM_RISCV_IO_H */
-- 
2.43.0

