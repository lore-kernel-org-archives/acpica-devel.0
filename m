Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3A32E975A
	for <acpica-devel@lists.linux.dev>; Thu,  9 Oct 2025 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760018276; cv=none; b=dwd+hSaWv/UVq0N0keoCyj84IPz9g70AAMKM5hLzX5WyuO0tbUXkKab1T9DVKQd9cwzrVW7fJVe1LXgf4wuPeVk+YkU/ObHS0UQlfCHaGLNy9BHQ8+jXV3a41rU2A/Oloq6T3tagVhlPLRyM/aiXXqne434ClAgmul/VJImjses=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760018276; c=relaxed/simple;
	bh=aNMJD/jvy4Eo4PisGaBxwtDDj5VIcZ742XhFZPY72NY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sqG2kXkAO4sPDgcfkGVfNRsY4hLoqzSiDq6b0/SNRkOBHJC4vnxA/1gMAhSnPwQrc3aU05xRKIDiD/jE+5LEAcw3xXPzmdXqTTSgqRui9Blb7PzJJ0O3muKwv/4td5i3xjTXVJu8+utLQa2Ry+FpEWXzjnuPxLH3cyV3bjYvw1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzXZSMVa; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzXZSMVa"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57e03279bfeso1388839e87.0
        for <acpica-devel@lists.linux.dev>; Thu, 09 Oct 2025 06:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760018273; x=1760623073; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A/MGlGn9iIYutzRbmuTIcRdh98fdrcz/bmBvtZd2PYA=;
        b=lzXZSMVaodwgVA6NhU+JM8nC4gtQaggVlmoGMK80IC2pGIFcZ5OkMGmOdNy3t7W4sX
         aoNnhNT9wsy4DE00NOjebyj4/bg9d512gXOBhJxrb/mHn7uE85MURX3An97EroAe+RCW
         bX41lGXMvAGcU6k2cFy168O0xRXtzdAxRmfEfrzf8QCZ3qVvxaO0BlO1ASqxDDx22VlZ
         lpmIJ0TyEe6PKZnwEoYUAwguDfRTU64SVT7wyro6QImnalb0FRbLdwxM31uMVNishh7b
         CXQmnxab2eu57aCcKNIMiVAgXPPsbimPCrkFYh4idMQRNxZV8c/5ru75IQ8whXlkh1mh
         iSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760018273; x=1760623073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/MGlGn9iIYutzRbmuTIcRdh98fdrcz/bmBvtZd2PYA=;
        b=TGZXde0APqt81/utZSofi1u5R6y9aJYaHZiWRRcI7QbyzYzt1sGFApVTWRV150x7/0
         ba1ukCW1reE+GNlPAFSa3BcfHnCO+6PMSlec8yX4hTdPOdYHLncv/CRiT/L/K6iDwGuu
         9opt1HfN84xBLkPC3owIm4DBCinJKOvLr/1gaphiUaoxZt3cfUGvY+vkR0/wcrGXdMZY
         7ixBsaD2N32b2xq1gzGr6Gaohv0eWWozfwNQ8e0sicco+EcaqHa+DjVmQBZmkV6jT5Ip
         4EeNeWy41Dk8J5+DK/yLsvYYCru/dlIhRKqFLaWoS9xl7gP5vzmy60UGQGAPR+KnhdNk
         Enig==
X-Forwarded-Encrypted: i=1; AJvYcCWl7Lp6XFHpDdBq0KC3Kl46Uxz2lZg1BtORF7BKXU+qNdXIzNErbX3BSBpiZEaSUqal2c1L8GYm3dRkl0o=@lists.linux.dev
X-Gm-Message-State: AOJu0YyOv7YsZNq8+uyffXET00IDtVkbiCMAebch3+bABxoJZHc+It4K
	SYqIOD/bftpTYltV7uUs/L+8m+gD4MKMd3FGcsDsoReOcw+TvOdBCJRD
X-Gm-Gg: ASbGncub9XJbPNi8WOiWeOxkjOfOZCz2mAMwKDgyWXSXW2biTnoOxeliOU3lltfdN1n
	M9Z5Rc1LDE3vCmS3IsWfqF0k1SVw1pIhLuI5PEY58IPYgSZvKU1n8ucKij+G2qa5EmtkrYFhwyg
	IT77AL3o4QV5aUOPQayivZl2DYbFx0u2Oxc9hJwh+koXinOqUInozfwo6Os19wTmFYBA3ZY6P0C
	g7JMgEbXshoz0O7cxjwwxWVMQ1qMqOpebWzwlASWvVuD2ic7qqQk2LjNfgQHg0e3N2KpVMBVK2L
	lkbLR3G+ecqJ8J3/HSQ6xSurBrIgDL2wum2cijbXeOdatN7+6LauTlPHX+yAf1wdi+Fh1wXD5Ex
	7t57rHqpabICgV0xeVxSco+yoO+8Qhpov2tiS9BAgxMqErACICzTy
X-Google-Smtp-Source: AGHT+IHA8m/U23aYo0HxP+3yhD2Pn0UWeadCQA7OeCHX4f0bCNRxiynEaIMEXCIiEdfg2ltvNFQ3lQ==
X-Received: by 2002:a05:6512:3a90:b0:58b:75:8fc6 with SMTP id 2adb3069b0e04-5905e28ba56mr3556064e87.19.1760018273097;
        Thu, 09 Oct 2025 06:57:53 -0700 (PDT)
Received: from home-server.lan ([82.208.126.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5907ad9e55esm1066082e87.78.2025.10.09.06.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 06:57:52 -0700 (PDT)
From: Alexey Simakov <bigalex934@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Alexey Simakov <bigalex934@gmail.com>,
	Robert Moore <robert.moore@intel.com>,
	Len Brown <lenb@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] ACPI: Add absent field_obj null check
Date: Thu,  9 Oct 2025 16:56:47 +0300
Message-Id: <20251009135646.8899-1-bigalex934@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The acpi_ev_address_space_dispatch function is designed
in such way that assignning field_obj to NULL is valid case.

Cover the missed execution path with this check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 0acf24ad7e10 ("ACPICA: Add support for PCC Opregion special context data")
Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
---
 drivers/acpi/acpica/evregion.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index fa3475da7ea9..fa01bcd3840d 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -163,7 +163,7 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
 			return_ACPI_STATUS(AE_NOT_EXIST);
 		}
 
-		if (region_obj->region.space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
+		if (field_obj && region_obj->region.space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
 			struct acpi_pcc_info *ctx =
 			    handler_desc->address_space.context;
 
-- 
2.34.1

Just FYI, this patch was already merged to github ACPICA repository.
Commit hash with correspond changes at ACPICA repository: f421dd9dd897dfd1e0c015afa90cd0de2464e23c
