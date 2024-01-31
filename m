Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F67112FF74
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 31 Jan 2024 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720232; cv=none; b=Es+vvksDaHJsCl9bp4O9i/4DFbayZv8p7GL++R1GUbwmUn0Tmz7w4gZf5aYOH+YI6qeKH0X9JtXQNseEo0bK9tGMEbfrVWbaSSs8vCfRZ27AfSIZ4oy7tnWEKaefpErGUaQ3Qd5KT0BqG4ogUFWVJaL/OsHw+TcBez0v4/5dFpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720232; c=relaxed/simple;
	bh=P8UMP2I/3nZNlJyCrd8eERvIK1OiBSscwtDfKF/3DxE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=tp9r8Iczj3uU/3ipey5lPtCVWgZBB25qcDNRnH2vU/tSsDoqT/YggdhzYGD4bT+1YSb66XkK1wR2LUk7AHdsHn5ZqS8hXXvoGEw/PWFySuO+lx4MJBG5m4QAGmRPV+h7AfZYOIzmaJnpSgaNH/5QZM0S1f6QH/Zniw8arR+4SBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=uqc+DCKw; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="uqc+DCKw"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 63E8C41F10
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 31 Jan 2024 16:57:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 63E8C41F10
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.a=rsa-sha256 header.s=pandora-2019 header.b=uqc+DCKw
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dRU8NClA05_Y
	for <acpica-devel@lists.linuxfoundation.org>;
	Wed, 31 Jan 2024 16:57:02 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5562A41F0D
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 31 Jan 2024 16:57:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5562A41F0D
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DnAkVWZfHdsfbPL7YZp73DdgOlGRvTL1dby6CU3CDrY=; b=uqc+DCKwG0ug+HapGtea8aoa5Y
	g5EpcUoEzakHsQIsGgONCg7oIGC58rfToOozcFpjkAtAypAyfVF6fnnKgmvWj1DD2sxBspC6E4cHX
	SSOa+qh6GVlBlisWfGKmtDac31tVsXttXF8jhZdqTIICwhAhlJbeSeb2bsTj3GlEuH4lquy25qowh
	qE5bnPbzW5WKHaXBCE7AxlRmjJ5l1MQNXQtzwAGI2Ys1ulpvisOs2/egpL8YFDP4mHKVzHjGfq1D0
	Qg7QH6oXlz1qOITAOO7AoN4aWjtI84rCd5gwtLz7YiKyArVIPBSPvrq3HXqSm/sQKSb30L71/nt+H
	+wF0Ir0g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36100 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rVDnM-0003W7-34;
	Wed, 31 Jan 2024 16:50:41 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rVDnK-0027ZN-40; Wed, 31 Jan 2024 16:50:38 +0000
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
Subject: [PATCH RFC v4 12/15] arm64: psci: Ignore DENIED CPUs
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rVDnK-0027ZN-40@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 31 Jan 2024 16:50:38 +0000

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

When a CPU is marked as disabled, but online capable in the MADT, PSCI
applies some firmware policy to control when it can be brought online.
PSCI returns DENIED to a CPU_ON request if this is not currently
permitted. The OS can learn the current policy from the _STA enabled bit.

Handle the PSCI DENIED return code gracefully instead of printing an
error.

See https://developer.arm.com/documentation/den0022/f/?lang=en page 58.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
[ morse: Rewrote commit message ]
Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Jianyong Wu <jianyong.wu@arm.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Changes since RFC v2
 * Add specification reference
 * Use EPERM rather than EPROBE_DEFER
Changes since RFC v3:
 * Use EPERM everywhere
 * Drop unnecessary changes to drivers/firmware/psci/psci.c
---
 arch/arm64/kernel/psci.c | 2 +-
 arch/arm64/kernel/smp.c  | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 29a8e444db83..fabd732d0a2d 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -40,7 +40,7 @@ static int cpu_psci_cpu_boot(unsigned int cpu)
 {
 	phys_addr_t pa_secondary_entry = __pa_symbol(secondary_entry);
 	int err = psci_ops.cpu_on(cpu_logical_map(cpu), pa_secondary_entry);
-	if (err)
+	if (err && err != -EPERM)
 		pr_err("failed to boot CPU%d (%d)\n", cpu, err);
 
 	return err;
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 4ced34f62dab..dc0e0b3ec2d4 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -132,7 +132,8 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 	/* Now bring the CPU into our world */
 	ret = boot_secondary(cpu, idle);
 	if (ret) {
-		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
+		if (ret != -EPERM)
+			pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
 		return ret;
 	}
 
-- 
2.30.2

