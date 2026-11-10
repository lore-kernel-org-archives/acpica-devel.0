Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794300387;
	b=d6gLDUjIri9CafiCCnpg/zNLtiqKswmSU7xH4Q5cM21CWOLhdUfkWu+ogq7LgvtHbjLe
	 GW1oij8vjwC/PBhlrvZL0QyRqw6uC7j+VJtxtMyUerjUiLjUPgn7Mi11NR8lAJhf8yycr
	 WNHhiz4kj5BTz+vzObkFj/F3tygukCGDEplSrnFwLKoHYY9DX8ATAKme3/HZHbOklLuhh
	 rg3KUzDQy5W1cEFyjlNfFBeGoi1hxGbvcBdISG6VQ/w1eGRwjE/r0+w4sKotbMLFw67Qr
	 lFsc2aDXx6h9w4Isqa3SeCuGlvtKpaqUmTIJoy0tJ9P/0jcyxC2PEZTm2jbeySUfDdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794300387;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=+GhJ9fs5NbjgmK1djHLrHpGVl3Bo/x6xoGUKT1hzhQM=;
	b=IVLsUW+oKjAnl/1kNitajrOyJk0a5kvuLlax/6ow3K+YOKCXTQAUQoBHqIrNcOvP1AQ2
	 ZgGOCq2duj70746i6M88h/bEd1e9B1WndNTvAJ4FYzxvzXW5TQ+6HOLC6xgB53OPD6pjJ
	 iRQOxuid/s3wnf7Q6X2jf+k8yDXZtkv1zcKq0W4yWSfmCAblWQh7MhqpnfN73CgZJn/nR
	 +W0E81yHcexyiqqZK97MhWTLX5geR0aMSLhqdV7NWdDEwL3g1DZORVs1Q+vXbI1uvzwy1
	 mcJlGgIIuC8q2FH+5JMaTqtIBN8xkJ+1zUFT5wHL6BO+eVzGDFIyNGVCSFfkgkwttsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F49D606A331;
	Tue, 10 Nov 2026 08:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F49D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8CxPtPf2fJqbR8eAA--.21288S3;
	Tue, 10 Nov 2026 16:46:23 +0800 (CST)
Received: from localhost.localdomain (unknown [127.0.0.1])
	by front1 (Coremail) with SMTP id qMiowJCxe87e2fJqWXMzAA--.22061S2;
	Tue, 10 Nov 2026 16:46:22 +0800 (CST)
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
Subject: [PATCH 0/2] ACPI: LoongArch: Fix IOVT table parsing and add checksum validation
Date: Tue, 10 Nov 2026 16:46:11 +0800
Message-Id: <20261110084613.2746641-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
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
X-CM-TRANSID:qMiowJCxe87e2fJqWXMzAA--.22061S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

In acpi_iovt_init(), hdr is already a pointer, so passing &hdr is
incorrect. Pass hdr directly instead.

Also add checksum calculation/validation for the IOVT table.

Bibo Mao (2):
  ACPI: LoongArch: Fix incorrect pointer argument in acpi_iovt_init()
  ACPI: LoongArch: Add checksum support with IOVT table

 drivers/acpi/loongarch/iovt.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.39.3

