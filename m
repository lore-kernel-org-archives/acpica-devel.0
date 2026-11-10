Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794300389;
	b=Q4BtCWvruBNykW3htBj91meXH0MQrWjUWcAv25CTRMn0HP/1jpbAQRmnbw7CYy921l4j
	 UCBmr34Jbep2ohCbTKpkMufDhYdE4TWIae1QMOfBtThz/KjhaNaSS/6uui797m3sC79hc
	 HfehQlRevxeyDkBTt/t3j4mYWanIXxfLYa5M8Y10CGCDv8O7gof3NbR+pKC0sgPG4s773
	 O7VnUfgWj9e/IiqobQyoa/qP0XTZwTEfl8EGwAbrFX33C9k1JzbflNxy0CMd4Kgq8W0NE
	 2yZ6rRdDEiNrVtPgX83MJj9sO3u6BG4AwglzThLGKJHpRobCljjFk2mS6nCJOaizb+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794300389;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=yTxQRIKb91hGqSfuLGVfd4S0vAmf1MtK/tZCS/84+4c=;
	b=U8qankxPAbeZZnLgUnfVhBAowDGkMkXNsCkNDL4XIqILB+yW14rif1s5vNmGX9nnamsb
	 eDYdAdT/wLv5a+hexulfgcJ72uLbnuE20FY0tlx/Ukd8XtK3WdpdSKxzE/D05dKmjsba6
	 r3oPqpSX6X6F1s3BT4BJzWg4wTiTw2yJlC8YaXFdZegSooK4/Dr87vGbWICZLUp/dEU/t
	 sUQNPzwnP1JCZp6S9e/i+OXSB77SXOFqCQT0OibqLygfM67xj3cJeUAPNov9TLhQUiNAz
	 ltAMrusSGA2A9hqJtYIKjpcBL42gGlr8igYuiV3pZPdnvHsMXc/Bpb4NCUjqkKjcAvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EC2606A32A;
	Tue, 10 Nov 2026 08:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85EC2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxLtPi2fJqcx8eAA--.21029S3;
	Tue, 10 Nov 2026 16:46:26 +0800 (CST)
Received: from localhost.localdomain (unknown [127.0.0.1])
	by front1 (Coremail) with SMTP id qMiowJCxe87e2fJqWXMzAA--.22061S3;
	Tue, 10 Nov 2026 16:46:25 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Cc: Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	lixianglai@loongson.cn,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ACPI: LoongArch: Fix incorrect pointer argument in acpi_iovt_init()
Date: Tue, 10 Nov 2026 16:46:12 +0800
Message-Id: <20261110084613.2746641-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20261110084613.2746641-1-maobibo@loongson.cn>
References: <20261110084613.2746641-1-maobibo@loongson.cn>
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxe87e2fJqWXMzAA--.22061S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

In acpi_iovt_init(), hdr is of type struct acpi_table_iovt *. Passing
&hdr results in a pointer to the local variable rather than a pointer
to the IOVT table. Drop the address-of operator and pass hdr directly.

Fixes: a9b0c34507eb ("ACPI: LoongArch: Add acpi_arch_[late]_init()")
Cc: stable@vger.kernel.org
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 drivers/acpi/loongarch/iovt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/loongarch/iovt.c b/drivers/acpi/loongarch/iovt.c
index 87cee4f0fc80..6c5bcb4df7d8 100644
--- a/drivers/acpi/loongarch/iovt.c
+++ b/drivers/acpi/loongarch/iovt.c
@@ -184,7 +184,7 @@ void __init acpi_iovt_init(void)
 		return;
 	}
 
-	iovt = (struct acpi_table_iovt *)&hdr;
+	iovt = (struct acpi_table_iovt *)hdr;
 	iommu = ACPI_ADD_PTR(struct acpi_iovt_iommu, iovt, iovt->iommu_offset);
 	for (i = 0; i < iovt->iommu_count; i++) {
 		iovt_enable_acs(iommu);
-- 
2.39.3

