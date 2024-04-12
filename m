Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2AF52F9B
	for <acpica-devel@lists.linux.dev>; Fri, 12 Apr 2024 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916944; cv=none; b=H3c7NwE3mpxpSYoT7RVIps/Q+EtoGQcLvx0ZZ6Eo7q4lzHCopKLk3bXlMhofvW0BeS1qiWkt3lvMbXoDcKbBjqnEVEDzDLhymR9PdL7jPuasL769WJ3egGZ6atUekNUbxWkLkCY6wDYzV2PtW1vJDaLgDoCENq+tXGG104MCcwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916944; c=relaxed/simple;
	bh=xGhR+Pl3EV2Hdn4jQp8LQfllkFy6YeulYH8u+XV14Ew=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gH9hxnc9jb9GQlGf8EmCuro/s89AkfYJo3szFGvImuMb9qqmi/nZhJehvIk5plSo5fNZEBfghOQGQRaCiOG5IEl4x2A8dhUeX09vyVhPOFa5+Ihi0D1W8Pl9cC6ul4K9QE97SfBGysCq4ir83DbEkgF4SfwC1ABIMxB/DtYRMNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=rJw6jpM5; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="rJw6jpM5"
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id CA27F100002;
	Fri, 12 Apr 2024 13:15:19 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1712916919; bh=LuEVrWBZUXEcAvPqrYHEhF+mnbBHa/fQlhmPnm1GapM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=rJw6jpM53DLVcqYOYuYB6C0GSv253N2/u48MVCgybQeVwiGfFKzWoE5xYOMxFIl3Z
	 BOs79efSnj9ulCmuIeW6LVNdUtUQNIm63t6vPRjvZzwUS1eP4XdMDaymDWLT5Y0UZa
	 VwlEPRF/6iDDCjDTDzd9euvR88hXobKw1dqHYX59wbbLfJZWxg35ZEYoFdLBtoPkDb
	 ltc4ENMSubwtztyx8wllKDcT3F/+FcEvZ0CKhRAypZe3PimqGqBh5+Fhb1hz/oxUiG
	 pIQdKX1kTTrcOEbDDJVcN9YPQ1vpM7mpT3Ur2Q6w+W/9E370YMqGoS9PPjglcIhBhO
	 48uGQJvDv9mCA==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Fri, 12 Apr 2024 13:14:30 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 12 Apr
 2024 13:14:10 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Lv Zheng <lv.zheng@intel.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Robert Moore
	<robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] ACPICA: Handle memory allocation failure
Date: Fri, 12 Apr 2024 13:14:02 +0300
Message-ID: <20240412101402.14741-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184684 [Apr 12 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 16 0.3.16 6e64c33514fcbd07e515710c86ba61de7f56194e, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;t-argos.ru:7.1.1;mx1.t-argos.ru.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/12 08:01:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/04/12 08:56:00 #24754366
X-KSMG-AntiVirus-Status: Clean, skipped

In acpi_db_convert_to_package() ACPI_ALLOCATE_ZEROED() may return NULL
in case of memory allocation error. This will lead to NULL pointer
dereference.
Fix this bug by adding NULL return check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 995751025572 ("ACPICA: Linuxize: Export debugger files to Linux")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/acpi/acpica/dbconvert.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpica/dbconvert.c b/drivers/acpi/acpica/dbconvert.c
index 2b84ac093698..8dbab6932049 100644
--- a/drivers/acpi/acpica/dbconvert.c
+++ b/drivers/acpi/acpica/dbconvert.c
@@ -174,6 +174,8 @@ acpi_status acpi_db_convert_to_package(char *string, union acpi_object *object)
 	elements =
 	    ACPI_ALLOCATE_ZEROED(DB_DEFAULT_PKG_ELEMENTS *
 				 sizeof(union acpi_object));
+	if (!elements)
+		return (AE_NO_MEMORY);
 
 	this = string;
 	for (i = 0; i < (DB_DEFAULT_PKG_ELEMENTS - 1); i++) {
-- 
2.30.2

