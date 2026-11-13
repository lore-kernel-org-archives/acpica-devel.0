Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.35.192.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794566559;
	b=tgLrS8zb9De5dugvykrkT1OmWHAaKbIFCpn9IcltWH6YoKIkp8D9FFWTRf0uG34Fqy8B
	 paFuqwbWRyheY3P4lfs5/ScWvTT1MQBRju19kbb1irlAKL37r/7/aP52Xxx5Af4PHSZ0z
	 xfIN6RnCGWpu8tf0WbkimHUfFjnyxtOL8Dtc5Bf+V0z1PQvUnX9wyP6cfQ4S6cY577s0C
	 W6SeGd8Y9xE0T0Ppkw576I3Al3IachJK0xxrvmRQnGAxisOaeOGLEYjPNkvTqBNym2Qfb
	 UkX9J15Js3/t/NXNphqjA7WD6fM4rL8mY25Y4vmAyk0HedH95l2USB9UZM0J/1T1Olg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566559;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=Fy8Qok9YnW2onYT7Nxo1YyfGe4C6vS7j+DJBn3pNCyo=;
	b=NvmC8s8r8HZJxbsUj+Rj5WVdK24Bl+6NfviobtDPhttbX6Ji7PpgzKgeWpIcdIAIdrVk
	 ekRn1G4nqbBaQkv/0iWmXdwBRtWcT60k1CILir3k/iX06TGPWnPwL9823JQglyydkIlpx
	 bEjRwhvmLmZia1q1hpN3RkEzd/k8vE1VhSepHKUZ+FfTACksVeaafLy1mYWuWB7oAAs/y
	 N9Hp8auPswPKl42K0JrglDY/I9SYRvGEL4VPzLmL3OzgGL84AGtTAz1E90iNo2uSBf5Jg
	 Cw0Z/P9FmcDdhWGMJ3D3IQ5Dg/Pus6IzoJpfW6z/y3e6LfT5E+QlN4zgDNHmalHKCEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b="baKy8j/H";
	arc=none smtp.remote-ip=52.35.192.45
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8A4606A337
	for <acpica-devel@lists.linux.dev>; Fri, 13 Nov 2026 10:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E8A4606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=baKy8j/H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794566558; x=1826102558;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fy8Qok9YnW2onYT7Nxo1YyfGe4C6vS7j+DJBn3pNCyo=;
  b=baKy8j/HdrA2RcOOF5u5maCHGh9qAQ8fiDQ7rCAkUIOz5sFQwVfWNTy1
   8FJ3Vag+19IqwLoYZ1dsG+590A6UOm1jXmK05UFKgEDVJuDPJhB7PIlbR
   tbua6m3udt/GURsCvsaItsakwfk3JoSK1mhI3aUJt87eX11D/yighEY67
   Q9+DUwKlt1pFBXc+jFFx9LEuR4pe9aJsLV5c2dm56qmP2v9mhnOE+92ig
   XeVX7neeVNwLhgpWBW4I4sFB2y0qdcpRXoT3Ht6y2me04DFF/E0jVQfo2
   z0QZ8ZQVwJSDSwfhgjn91cuVeilzZxMvCnztb0x75FmSpT26VO7GxnpTt
   A==;
X-CSE-ConnectionGUID: POW0rEFNQcyN36EyW6gCcg==
X-CSE-MsgGUID: WF4GNPM5Rr+F7of8jXJ5aw==
X-IronPort-AV: E=Sophos;i="6.27,211,1787011200"; 
   d="scan'208";a="33648544"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 10:42:38 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:31569]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.231:2525] with esmtp (Farcaster)
 id 04cdafd4-7ad1-42d7-bea5-809c057c2d80; Fri, 13 Nov 2026 10:42:37 +0000 (UTC)
X-Farcaster-Flow-ID: 04cdafd4-7ad1-42d7-bea5-809c057c2d80
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 13 Nov 2026 10:42:37 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Fri, 13 Nov 2026
 10:42:33 +0000
From: Eliav Farber <farbere@amazon.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Armin Wolf
	<W_Armin@gmx.de>, Sebastian Reichel <sre@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>
CC: Eliav Farber <farbere@amazon.com>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>, Shuai Xue
	<xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, Maciej
 Wieczor-Retman <maciej.wieczor-retman@intel.com>, Pawel Chmielewski
	<pawel.chmielewski@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Breno Leitao
	<leitao@debian.org>, Terry Bowman <terry.bowman@amd.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, Andy Shevchenko <andy@kernel.org>, "Kai-Heng
 Feng" <kaihengf@nvidia.com>
Subject: [PATCH v6 3/7] ACPI: APEI: GHES: remove unused ghes_{,un}register_vendor_record_notifier()
Date: Fri, 13 Nov 2026 10:42:05 +0000
Message-ID: <20261113104218.32566-4-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261113104218.32566-1-farbere@amazon.com>
References: <20261113104218.32566-1-farbere@amazon.com>
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
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Remove ghes_register_vendor_record_notifier() and
ghes_unregister_vendor_record_notifier() along with their
EXPORT_SYMBOL_GPL()s and ghes.h declarations, since there are no
remaining in-tree callers - all users go through
devm_ghes_register_vendor_record_notifier() instead.

Inline the register/unregister calls directly into
devm_ghes_register_vendor_record_notifier() and its destroy callback.

Signed-off-by: Eliav Farber <farbere@amazon.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
Changes in v6:
- Rebased onto v7.4-rc1.
- Replaced an em dash in the commit message with an ASCII hyphen. No
  change to the code.
- Jonathan Cameron's Reviewed-by retained; the code is unchanged since
  v4, when it was given.

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
index 663dc2e601cf..a81ffacb16d0 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -679,29 +679,19 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 
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
index 7acf209061ea..b01b3f6d0868 100644
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

