Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A353375DC
	for <acpica-devel@lists.linux.dev>; Wed, 29 Oct 2025 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737277; cv=none; b=PMwHG77ApEjArXhkKvKr3dOaOI4/rxXHj8io86QcITvAYKUizpQcfxUyf215g1zkvI/7tsgfDARrUI2n66aA8Sb3UvfLxcVjL5ZK349GgKGiRBAvgOaOpIivHvZIXc2lR+hjuvEnomRoAAjlSGUHxGfhfe1BAXYQeVXHexyLrfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737277; c=relaxed/simple;
	bh=8JZYDhNrsI9HtE6ZOHDXkqloHy3uMWl7WxBeulXNIIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvzgRkFafQcgNTGl2VmqluS/Bm7yMLVbUwsomFEIfkLlhoKi9sFaB0XBDTRSZJLZUaJXY7h/zU1wQlBq5IlhYoSxVweJgDRtelLFz1UpChsC3x1oJCe9KDIDTjtTrrcyM0UmWEKP+yH0kXVcKoJTHyyMn6R92DazDEmLVN3Cpys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=oY0NSECs; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="oY0NSECs"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33d896debe5so7877405a91.0
        for <acpica-devel@lists.linux.dev>; Wed, 29 Oct 2025 04:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761737275; x=1762342075; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EM17XL2D8YjMnEI2n2oDZbxwn/ekL7mieaWD4DF48lk=;
        b=oY0NSECsQLKRjTQBhoyQZG5Poaf4k7e95T8EI3NQSms2acu5xq4Xm5my+/bwH13Sf8
         PTTCAhcszXDwWzQavy4nN/n2y7kg92C3qT5Rv/15z6RAJb5CRSygzjotJSFz2yyB1jJX
         s35Z+rEYvLGoiDof3vFGKPCq6u+V9iVQLlKV5efIiaQ2vEMq3qVTm7TfUb9Pry3ttYON
         /lLdJD5KVBuinc55IWInfTKBIs2z39KXJOHQvnL4goiLKW74FQPL5TDKBLm88dUkgSm/
         mgpRh8BPptk3LNk+ZtWlK25P/NIsoM40wYeXDCg0rcDbgvyPSn3FB4pmtB54Xxr7eZ3Q
         kntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737275; x=1762342075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EM17XL2D8YjMnEI2n2oDZbxwn/ekL7mieaWD4DF48lk=;
        b=kocBnbmI6dXnNRLwXHJOA4G3pG8bKT6HDI3PdUi5dqvvl67klgKDTAxVRD23yWLq84
         8U+rxaxxiIVRV1bjAyXqQXQ8Q9kGuFXRvPEHokHU5CzLdXguu8B03TyrNP3MQYW7Xdl9
         76Ln8P0scrtoZL5J5nIroZGykXyScwwz6O2e/WStZx0UOkB37gIH2eZ7ARxDNhO+RvG2
         TQCgbZ9UQPHhJAKeGmAwlHrD306QVz3HXjjHp01xUTXYGioP1vZrjMAJ/aMyBaL37yGV
         eBFkYXtQjnYZgs1YDEmzmBwobDUHzN3adHPeJwecY1Wue1OVjkl7t0ljUVJMhHn34o7d
         6iQg==
X-Forwarded-Encrypted: i=1; AJvYcCXZoy1wrK/BGunDqvM3Ti3bvK3PkpYKFZ9og3ntMEo9IlrjNBwj/p7B9a8AkAGf3MPpJjr8VkuHNluXlIY=@lists.linux.dev
X-Gm-Message-State: AOJu0YzLW7SnuSzHdKsUk4I16dB6daiiux38S68MaQdeUfI2hn6JosIK
	01gW9u3Ofi8bslNI9n6hvZGBXrkt80nk7lfdK2J8N/7s6qg/bNVTUnbriH6yg4knex4=
X-Gm-Gg: ASbGncsOCzIQB92trPG8aAZ1a5LiTBQT3ducpNPimq/Gur0OXZhWE+EzMxJZllZWeuC
	01MeMiX+8htK/c22An2YTwaIkC3csMMuJxX7IP1n2IhOdCRCmlyypHGVVgCpfUROCOr8uKE2Q1j
	D/F6MO5/1oe5ZqmgDQcakyhZxfhLIyRroOKZBdTbwnTfLJvlrIkx+e8REIB0haQeXdxmX2K2Pux
	OIqva165V+62oOoX7ehELvSOHLGzuyvoK+qC8zQuDoYKOnbU/306KaKdspFifq4IsxH5Vb6F1mn
	exwwrE21GRIbCA8ZzK8P0CERLF6USATvrjx1KqWsKmrjFiiDwdnLSk1JpjkVZGydTZq5tSQR/Cf
	DKiP/w/h/qdmnb76Qh29ejZ4oucjC65pg9WWdDpz3wWjLkz7ZWMIgjVul8ccTMdJKTu5XIXJMur
	8JZ/9LcKdrG8hAL4PFk4bANH30S9rT
X-Google-Smtp-Source: AGHT+IF600ISkv3fQ7BjFWjXUYnsdlJjH4uC/2j9DNguZaBAOpmO8VBsTXPp9fAX6HQJwfo0kcCWuA==
X-Received: by 2002:a17:90b:4c10:b0:33b:c9b6:1cd with SMTP id 98e67ed59e1d1-3403a281deemr3120310a91.19.1761737274703;
        Wed, 29 Oct 2025 04:27:54 -0700 (PDT)
Received: from ventana-desktop.localhost ([2405:201:d019:c0ce:f7f5:7789:48e5:c03f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm15316918a91.16.2025.10.29.04.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:27:54 -0700 (PDT)
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
Subject: [RFC PATCH v2 10/10] riscv: Enable APEI GHES driver in defconfig
Date: Wed, 29 Oct 2025 16:56:48 +0530
Message-ID: <20251029112649.3811657-11-hchauhan@ventanamicro.com>
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

The APEI GHES driver is very important for error handling on ACPI
based platforms so enable it in defconfig.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 arch/riscv/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index fc2725cbca18..3e62484e148f 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -44,6 +44,9 @@ CONFIG_ACPI_CPPC_CPUFREQ=m
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM=m
 CONFIG_ACPI=y
+CONFIG_ACPI_APEI=y
+CONFIG_ACPI_APEI_GHES=y
+CONFIG_ACPI_APEI_ERST_DEBUG=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-- 
2.43.0

