Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D7012A171
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 31 Jan 2024 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720206; cv=none; b=CgoRstoHh3XLWNEzdEsaQ9Eel5mF9yi8FRMjZa2DK826WxZx+4qKmSJ2CN49fbk0ZtDg8s+hYq9iNSrMwfKAJcOpaZJH4kfCb5ZtY18zbeoCsjghLrXqzIJ3h4AzpLo6hzlqgO8MYFgy7dXawMSwajAUE2B7yIAyu10vNWxQyHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720206; c=relaxed/simple;
	bh=5LEQoJpu6+PEGYH/lhb3k8QBDqyTbnnUbLwB01EXHtI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ji89D6xX+rZ/7F1FI46QOu5VS0he6VD2iq4fzfh6acD2la0ps83ZCS6gGTs2KKyDesvm56jTMl5QLDSYR1EI1HPYatH959yOkMolznh2q1ucyiHVkisl7ewXvrxDyJ6x3NrCcOyx0GcVKm7TRRcxQ4+tfDOdUNazUZpW+bcJDos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eRQOmPST; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eRQOmPST"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5537F83FF6
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 31 Jan 2024 16:56:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5537F83FF6
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.a=rsa-sha256 header.s=pandora-2019 header.b=eRQOmPST
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1JNjeXR7wO4n
	for <acpica-devel@lists.linuxfoundation.org>;
	Wed, 31 Jan 2024 16:56:40 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6F34683FF0
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 31 Jan 2024 16:56:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6F34683FF0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ggNpMVZKnCA4qTUdSs1tTKgcZqyqwopZRj4HYgCBhpE=; b=eRQOmPSTq1ZLIHQXa2wUnO5S2U
	YS1T+Wxe2fqb4L8VLRnsI55TcS6ALkGhMQxBHxyk0HMsfLuyvclo0EQX5eJyiWivU6SLmFPyQ4Het
	ewI3JVRJwxIn9f8fEhqHW0ReqGzOQ2V3RKpxcY3EsBfqI4XnLTOeefB8byqeb1QT0UHRQHZJauzuJ
	5fSazsiGDuM8P5D69pd0gOi+w3zD4Ypw9fLPzYlN9gZoPF1BPwd/e7PovA9TQiTNHHJGxfprYynl8
	Djeh2SCfaMEUzHYUdZlaK/7Xq3FUrL8O8mlemaLr4cvipE2nrxHEvml2Xe9VK3cyCw46c7jqBNIGs
	B/0n6bsQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36030 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rVDnD-0003VU-16;
	Wed, 31 Jan 2024 16:50:31 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rVDn9-0027ZB-QN; Wed, 31 Jan 2024 16:50:27 +0000
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
Subject: [PATCH RFC v4 10/15] irqchip/gic-v3: Don't return errors from
 gic_acpi_match_gicc()
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rVDn9-0027ZB-QN@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 31 Jan 2024 16:50:27 +0000

From: James Morse <james.morse@arm.com>

gic_acpi_match_gicc() is only called via gic_acpi_count_gicr_regions().
It should only count the number of enabled redistributors, but it
also tries to sanity check the GICC entry, currently returning an
error if the Enabled bit is set, but the gicr_base_address is zero.

Adding support for the online-capable bit to the sanity check will
complicate it, for no benefit. The existing check implicitly depends on
gic_acpi_count_gicr_regions() previous failing to find any GICR regions
(as it is valid to have gicr_base_address of zero if the redistributors
are described via a GICR entry).

Instead of complicating the check, remove it. Failures that happen at
this point cause the irqchip not to register, meaning no irqs can be
requested. The kernel grinds to a panic() pretty quickly.

Without the check, MADT tables that exhibit this problem are still
caught by gic_populate_rdist(), which helpfully also prints what went
wrong:
| CPU4: mpidr 100 has no re-distributor!

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Changes since RFC v3 (smaller series):
 * Move acpi_gicc_is_usable() change in gic_acpi_match_gicc() into
   following patch so this is only about the error return.
 * Tweak commit message
---
 drivers/irqchip/irq-gic-v3.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 98b0329b7154..8deb671c4ff7 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -2422,19 +2422,10 @@ static int __init gic_acpi_match_gicc(union acpi_subtable_headers *header,
 	 * If GICC is enabled and has valid gicr base address, then it means
 	 * GICR base is presented via GICC
 	 */
-	if (acpi_gicc_is_usable(gicc) && gicc->gicr_base_address) {
+	if (acpi_gicc_is_usable(gicc) && gicc->gicr_base_address)
 		acpi_data.enabled_rdists++;
-		return 0;
-	}
 
-	/*
-	 * It's perfectly valid firmware can pass disabled GICC entry, driver
-	 * should not treat as errors, skip the entry instead of probe fail.
-	 */
-	if (!acpi_gicc_is_usable(gicc))
-		return 0;
-
-	return -ENODEV;
+	return 0;
 }
 
 static int __init gic_acpi_count_gicr_regions(void)
-- 
2.30.2

