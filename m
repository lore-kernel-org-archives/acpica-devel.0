Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5E5420897;
	Tue, 15 Sep 2026 03:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789443250; cv=none; b=FCTdLrENfwn6n2RNXEyYZoiHvRpduDJQG6+ywPGf9KgE+OsGgB7BS087bVU4lvz3t6FsZdvJ0r9mS52toW7t2MJO1b2d88FJvIXi7AsFo10UFkKxEUV5u3C9pClGZSjHYJQ1YWVpQHU9GHBTDWXvmMWSEVFe7mIcUKIAHl/Hy3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789443250; c=relaxed/simple;
	bh=BHw8oYA5cUdxj0Pv1MbAjMukmRTWHNxTlSixQVJdkmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EG2ubtxG7UflnluJWqaHdcqxcFSnSgZYgWO0Cr/6sxESTjSQfXBgvm8KcXc2FnXMI13tkhjrUpgr7+UuhINMD17dm4fZZscvY+uTSboEEp3ICoxxRoJdV7bmv8uAGRXQCK03/Vad0VZohx9PI5+JwzaXiWaDbAz8QFAw2Poz2aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Cx+9GivKhqqxEMAA--.35297S3;
	Tue, 15 Sep 2026 11:33:54 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxHs+bvKhqkd0gAA--.36959S3;
	Tue, 15 Sep 2026 11:33:53 +0800 (CST)
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
	lixianglai@loongson.cn
Subject: [PATCH v3 1/4] ACPICA: actbl2.h: Add bit constants of the Flags field in the IOVT IOMMU structure
Date: Tue, 15 Sep 2026 11:26:24 +0800
Message-Id: <20260915032627.2796747-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260915032627.2796747-1-maobibo@loongson.cn>
References: <20260915032627.2796747-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxHs+bvKhqkd0gAA--.36959S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

According to the IOVT specification, define macros for each bit of the
Flags field in the IOVT IOMMU structure.

Link: https://github.com/open-acpica/acpica/commit/352f750e4cc0
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 include/acpi/actbl2.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index baef525367b5..76e4a5bc79b4 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -919,6 +919,13 @@ struct acpi_iovt_iommu {
 	u32 device_entry_offset;
 };
 
+/* Masks for Flags field above */
+#define ACPI_IOVT_IOMMU_PCI_DEVICE		(1<<0)
+#define ACPI_IOVT_IOMMU_PXM_VALID		(1<<1)
+#define ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT	(1<<2)
+#define ACPI_IOVT_IOMMU_HW_CAP_SUPPORT		(1<<3)
+#define ACPI_IOVT_IOMMU_MSI_INT_BYPASS		(1<<4)
+
 struct acpi_iovt_device_entry {
 	u8 type;
 	u8 length;
-- 
2.39.3

