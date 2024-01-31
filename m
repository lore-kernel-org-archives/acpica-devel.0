Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355DE12F59C
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 31 Jan 2024 16:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720218; cv=none; b=Ye4JOX8sc8gMaCEzCVqZqxDFQmmkxPIVEgSsErv1sCHB6jDiXT12XwWl0J3jr5gub+tPTOHCMoriY/xWvFxZjl301XYKV0pD2ZEXVadSQEtVxa0zSw2CFzQIPrDa6qAcgHQtRwuZ0Iai7leJjd1kQC66Fa+Q9WwXrg+t4DJ6UFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720218; c=relaxed/simple;
	bh=oglPI5j4SalFovZELHhLOqqFlAFobwCTFUVvb9MFaqQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=dAym75BDsieLT+EG1BibnvpaIDILgtuKkJPxdz5MFXWI7PgSHR5dRM7RXGWXDB8wU6aW965f2FVAxLe7gEHCgcJkm7ROOEX6yF2n1NNWp8Pz/R4zUIoLSmttTuZiWmstmREeUpDsT9tcYzVlNzuxRfuB8eH0nEX1WbeOwHZNRhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=a8T9+UFZ; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="a8T9+UFZ"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CFAEE41F10
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 31 Jan 2024 16:56:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CFAEE41F10
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.a=rsa-sha256 header.s=pandora-2019 header.b=a8T9+UFZ
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zn9h9m5sI-QY
	for <acpica-devel@lists.linuxfoundation.org>;
	Wed, 31 Jan 2024 16:56:56 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 13B9241F0D
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 31 Jan 2024 16:56:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 13B9241F0D
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4FviDP8LNcs5OH9XS9Lgt79F5tF9VpTSbqPgMlkIJeQ=; b=a8T9+UFZh5Erxcl19hYu8LnPoN
	l8jkJTCH5Aga8DZg+RD7ezbHyq4OQdeKkSD6hzIRhev0EyFHx6P+dy6aq64Behg6QOGcwrXp31PcU
	6AfPX8Jas4MhwqjfgDzG/9B7RObj1s/1widKHmpuiUi0IxczEPWs+On8ceu+z7LWHVipSzrH9j+MH
	aVvsx/9nVkddyN/EWYjMHlRk9wKElTZSmbUv2SfQdepcYbj+SFzv+s4g5BVbd1CpZAAuNL4pp1eWO
	8kBc76pSd4xlVd4TjgTaVkulutmldzJsN1KRBnCwIlrQ+A3b+5ptlUeZJLMI+uVTpzpitQ9YbzG+U
	gmLrm9EQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36844 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rVDmV-0003Tf-2S;
	Wed, 31 Jan 2024 16:49:47 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rVDmU-0027YP-Jz; Wed, 31 Jan 2024 16:49:46 +0000
In-Reply-To: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk>
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk>
From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
To: linux-pm@vger.kernel.org,
	 loongarch@lists.linux.dev,
	 linux-acpi@vger.kernel.org,
	 linux-arch@vger.kernel.org,
	 linux-kernel@vger.kernel.org,
	 linux-arm-kernel@lists.infradead.org,
	 linux-riscv@lists.infradead.org,
	 kvmarm@lists.linux.dev,
	 x86@kernel.org,
	 acpica-devel@lists.linuxfoundation.org,
	 linux-csky@vger.kernel.org,
	 linux-doc@vger.kernel.org,
	 linux-ia64@vger.kernel.org,
	 linux-parisc@vger.kernel.org
Cc: Salil Mehta <salil.mehta@huawei.com>,
	 Jean-Philippe Brucker <jean-philippe@linaro.org>,
	 jianyong.wu@arm.com,
	 justin.he@arm.com,
	 James Morse <james.morse@arm.com>,
	 Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	 "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH RFC v4 02/15] ACPI: processor: Register all CPUs from
 acpi_processor_get_info()
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rVDmU-0027YP-Jz@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 31 Jan 2024 16:49:46 +0000

From: James Morse <james.morse@arm.com>

To allow ACPI to skip the call to arch_register_cpu() when the _STA
value indicates the CPU can't be brought online right now, move the
arch_register_cpu() call into acpi_processor_get_info().

Systems can still be booted with 'acpi=off', or not include an
ACPI description at all. For these, the CPUs continue to be
registered by cpu_dev_register_generic().

This moves the CPU register logic back to a subsys_initcall(),
while the memory nodes will have been registered earlier.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Jianyong Wu <jianyong.wu@arm.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Changes since RFC v2:
 * Fixup comment in acpi_processor_get_info() (Gavin Shan)
 * Add comment in cpu_dev_register_generic() (Gavin Shan)
---
 drivers/acpi/acpi_processor.c | 12 ++++++++++++
 drivers/base/cpu.c            |  6 +++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index cf7c1cca69dd..a68c475cdea5 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -314,6 +314,18 @@ static int acpi_processor_get_info(struct acpi_device *device)
 			cpufreq_add_device("acpi-cpufreq");
 	}
 
+	/*
+	 * Register CPUs that are present. get_cpu_device() is used to skip
+	 * duplicate CPU descriptions from firmware.
+	 */
+	if (!invalid_logical_cpuid(pr->id) && cpu_present(pr->id) &&
+	    !get_cpu_device(pr->id)) {
+		int ret = arch_register_cpu(pr->id);
+
+		if (ret)
+			return ret;
+	}
+
 	/*
 	 *  Extra Processor objects may be enumerated on MP systems with
 	 *  less than the max # of CPUs. They should be ignored _iff
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 47de0f140ba6..13d052bf13f4 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -553,7 +553,11 @@ static void __init cpu_dev_register_generic(void)
 {
 	int i, ret;
 
-	if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES))
+	/*
+	 * When ACPI is enabled, CPUs are registered via
+	 * acpi_processor_get_info().
+	 */
+	if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES) || !acpi_disabled)
 		return;
 
 	for_each_present_cpu(i) {
-- 
2.30.2

