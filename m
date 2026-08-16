Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F453CFF51
	for <acpica-devel@lists.linux.dev>; Sun, 16 Aug 2026 06:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786860499; cv=none; b=Xmf7+pkCrFN7jpnTIoZGZ0LwS851fQIF/YUtiIlGLe6nIPQd+QexRbb0pCSh69jt7xkPMKepPkhxZVMeHbSZMbaEsUOxqbYStPNoWwchra8Iv6FM/nHn90gFGcpq/7pBMQZC0dP73vmAJ8Sof+J6jJSsDkW/BFEOkfpU/854pI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786860499; c=relaxed/simple;
	bh=GR5sDpU92YulwatJevArPuB+YtgTuETpAiFrMEh5GSY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vFTOIv6fZ9I/gWmY0af3BoZmrkvga4V4Dagq0XtZ31qaoX2apqRP/HZfFqOMzvubpT+fG/SD7l1GWFbp7eD1LiPGLpSyKmxTsiOlG3VlGSIIzEgVU3XmmjV3Qo49bxpQOhKp9S9HKaqu3C9bsDKPY5jjVrjTxVOr4Ecuw4SWE9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=mVmsm+7W; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="mVmsm+7W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1786860497; x=1818396497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ydve0iM3rqWmqxrIth0r33l2kNMEYwjTtjvISqPZNv8=;
  b=mVmsm+7WlMN4g/6oMjusBLIlq+q/SyKvyT1e+k0KsH67sVtpM+zUBRsG
   bQo5DLwpUgmX7h4GMPFXUPUnjN5QgQO5t8UjqHYLh2Gdy5kQgzSyYrJUd
   dCkoNB5XMdemVEAqz7csPtWT7PiM87araVa/P6gMj/gn07js5uH0Sk6XA
   fY+/U8/lEXkNJRumNcQcYbzuIliT0kvIF7qdHMlHtOlpBONH98t2LWJtk
   q10gqgdMaQTWF+mV62wZMyzN3i3YJ00T6thgvvTUkUO18hQmNMM4dkJaR
   8owpXStN7U6+jEaKigS6hYsJB471kYeCrk1df9YvMJGOsw80prWDaRAmt
   g==;
X-CSE-ConnectionGUID: cJAmRmffTxG+qMLzcRxs5A==
X-CSE-MsgGUID: I3BXHHWsScGojHiT1x4VOA==
X-IronPort-AV: E=Sophos;i="6.25,226,1779148800"; 
   d="scan'208";a="25880994"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 06:08:17 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:19160]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.160:2525] with esmtp (Farcaster)
 id b2abe2e4-2796-4b81-b5e1-f3b2108c8db5; Sun, 16 Aug 2026 06:08:17 +0000 (UTC)
X-Farcaster-Flow-ID: b2abe2e4-2796-4b81-b5e1-f3b2108c8db5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sun, 16 Aug 2026 06:08:17 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Sun, 16 Aug 2026
 06:08:11 +0000
From: Eliav Farber <farbere@amazon.com>
To: <rafael@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<guohanjun@huawei.com>, <mchehab@kernel.org>, <xueshuai@linux.alibaba.com>,
	<lenb@kernel.org>, <laurent.pinchart@ideasonboard.com>, <linusw@kernel.org>,
	<brgl@kernel.org>, <orsonzhai@gmail.com>, <baolin.wang@linux.alibaba.com>,
	<zhang.lyra@gmail.com>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <dmitry.torokhov@gmail.com>,
	<hansg@kernel.org>, <ilpo.jarvinen@linux.intel.com>, <W_Armin@gmx.de>,
	<ukleinek@kernel.org>, <fabio.m.de.francesco@linux.intel.com>,
	<kaihengf@nvidia.com>, <ankita@nvidia.com>, <leitao@debian.org>,
	<farbere@amazon.com>, <pedro.pbg@usp.br>, <paulmck@kernel.org>,
	<frederic@kernel.org>, <kees@kernel.org>, <saket.dumbre@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-input@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>, <acpica-devel@lists.linux.dev>
CC: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v5 08/13] ACPI: APEI: GHES: remove unused ghes_{,un}register_vendor_record_notifier()
Date: Sun, 16 Aug 2026 06:06:07 +0000
Message-ID: <20260816060648.4030-9-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260816060648.4030-1-farbere@amazon.com>
References: <20260816060648.4030-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Remove ghes_register_vendor_record_notifier() and
ghes_unregister_vendor_record_notifier() along with their
EXPORT_SYMBOL_GPL()s and ghes.h declarations, since there are no
remaining in-tree callers — all users go through
devm_ghes_register_vendor_record_notifier() instead.

Inline the register/unregister calls directly into
devm_ghes_register_vendor_record_notifier() and its destroy callback.

Signed-off-by: Eliav Farber <farbere@amazon.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
Changes in v4:
- Split from the devm conversion patch into its own commit
  (Andy Shevchenko)

Changes in v2:
- New patch: remove unused ghes_register_vendor_record_notifier() and
  ghes_unregister_vendor_record_notifier() along with their
  EXPORT_SYMBOL_GPL()s and ghes.h declarations, since there are no
  in-tree callers (Jonathan Cameron)

 drivers/acpi/apei/ghes.c | 16 +++-------------
 include/acpi/ghes.h      | 16 ----------------
 2 files changed, 3 insertions(+), 29 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3236a3ce79d6..4e092f71ca84 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -677,29 +677,19 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 
 static BLOCKING_NOTIFIER_HEAD(vendor_record_notify_list);
 
-int ghes_register_vendor_record_notifier(struct notifier_block *nb)
+static void ghes_vendor_record_notifier_destroy(void *data)
 {
-	return blocking_notifier_chain_register(&vendor_record_notify_list, nb);
-}
-EXPORT_SYMBOL_GPL(ghes_register_vendor_record_notifier);
+	struct notifier_block *nb = data;
 
-void ghes_unregister_vendor_record_notifier(struct notifier_block *nb)
-{
 	blocking_notifier_chain_unregister(&vendor_record_notify_list, nb);
 }
-EXPORT_SYMBOL_GPL(ghes_unregister_vendor_record_notifier);
-
-static void ghes_vendor_record_notifier_destroy(void *nb)
-{
-	ghes_unregister_vendor_record_notifier(nb);
-}
 
 int devm_ghes_register_vendor_record_notifier(struct device *dev,
 					      struct notifier_block *nb)
 {
 	int ret;
 
-	ret = ghes_register_vendor_record_notifier(nb);
+	ret = blocking_notifier_chain_register(&vendor_record_notify_list, nb);
 	if (ret)
 		return ret;
 
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 8d7e5caef3f1..3cd13171c14f 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -55,22 +55,6 @@ enum {
 };
 
 #ifdef CONFIG_ACPI_APEI_GHES
-/**
- * ghes_register_vendor_record_notifier - register a notifier for vendor
- * records that the kernel would otherwise ignore.
- * @nb: pointer to the notifier_block structure of the event handler.
- *
- * return 0 : SUCCESS, non-zero : FAIL
- */
-int ghes_register_vendor_record_notifier(struct notifier_block *nb);
-
-/**
- * ghes_unregister_vendor_record_notifier - unregister the previously
- * registered vendor record notifier.
- * @nb: pointer to the notifier_block structure of the vendor record handler.
- */
-void ghes_unregister_vendor_record_notifier(struct notifier_block *nb);
-
 /**
  * devm_ghes_register_vendor_record_notifier - device-managed vendor
  * record notifier registration.
-- 
2.47.3

