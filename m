Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05ED83BBFC4;
	Wed, 17 Jun 2026 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781682526; cv=none; b=GoD3TEWTTzm6baIc2fLVV2Q0pMHatLFhhLUU4iB6Y1MCupP6/Dw6yftPMLI2O5tHHLL7sHSn1EggyTD9zMh2dLyXc+Jjuhw76/pWmvmVHstPkPOeEqM2kTZvq6yGghPsA8ZvoBTMdXrYVxWzt8YZ5I2dkNQ4NQ7Z2V9voSxbfVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781682526; c=relaxed/simple;
	bh=9Uxmgg2wE06uYzgvYK8LAQZagMuNLok1sCbpF4nurvk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rl5vKeBP81wDKDbij4qEx7wPJsWmtvVJM824M5LpW11ULfUlLJ/EZw0VdRuBOFsDYbjCVSQ6Z7bixDkP3aYeMKeeqU+Edw2a3c8qX7O0/TCkwsTn/syut3TBaCIqlL/RsFmakQO8B0pypt75x0r272IeHNlQmSHYsdfx+xfWDWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxzsBRUTJquQ4VAA--.31587S3;
	Wed, 17 Jun 2026 15:48:33 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCxvsJOUTJqnQupAA--.58263S2;
	Wed, 17 Jun 2026 15:48:30 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	lixianglai@loongson.cn,
	bibo.mao@gmail.com
Subject: [PATCH 0/8] ACPI: LoongArch: Add IOVT table support
Date: Wed, 17 Jun 2026 15:48:21 +0800
Message-Id: <20260617074829.2396638-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxvsJOUTJqnQupAA--.58263S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

I/O Virtualization Table is ACPI table for LoongArch IOMMU devices, it
is merged on ACPI Spec 6.6, and it can be located at
  https://www.loongson.cn/uploads/images/2024110517404135188.LoongArch-IO-Virtualization-Table-Specification.pdf

Here add IOVT table parsing on LoongArch system, it is for use about
LoongArch IOMMU driver in future.

Bibo Mao (8):
  ACPI: LoongArch: Add acpi_arch_init() support
  ACPI: LoongArch: Add ACPI_IOVT option
  ACPI: LoongArch: Enable pci acs function if acpi iovt tables exist
  ACPI: LoongArch: Add acpi_arch_late_init support
  ACPI: LoongArch: Scan IOMMU devices in IOVT table
  ACPI: LoongArch: Add iovt device entry table scanning
  ACPI: scan: Add support for LoongArch in acpi_iommu_configure_id()
  MAINTAINERS: Add entry for drivers/acpi/loongarch

 MAINTAINERS                     |   9 ++
 arch/loongarch/Kconfig          |   1 +
 drivers/acpi/Kconfig            |   4 +
 drivers/acpi/Makefile           |   2 +-
 drivers/acpi/bus.c              |   2 +
 drivers/acpi/loongarch/Kconfig  |   7 +
 drivers/acpi/loongarch/Makefile |   3 +
 drivers/acpi/loongarch/init.c   |  16 ++
 drivers/acpi/loongarch/init.h   |   5 +
 drivers/acpi/loongarch/iovt.c   | 274 ++++++++++++++++++++++++++++++++
 drivers/acpi/scan.c             |   3 +
 include/acpi/actbl2.h           |   3 +
 include/linux/acpi.h            |   1 +
 include/linux/acpi_iovt.h       |  13 ++
 14 files changed, 342 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/loongarch/Kconfig
 create mode 100644 drivers/acpi/loongarch/Makefile
 create mode 100644 drivers/acpi/loongarch/init.c
 create mode 100644 drivers/acpi/loongarch/init.h
 create mode 100644 drivers/acpi/loongarch/iovt.c
 create mode 100644 include/linux/acpi_iovt.h


base-commit: 6b5a2b7d9bc156e505f09e698d85d6a1547c1206
-- 
2.39.3

