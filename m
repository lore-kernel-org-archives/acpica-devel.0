Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A107F4E1A0
	for <acpica-devel@lists.linux.dev>; Wed, 27 Mar 2024 07:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711525525; cv=none; b=sp+dvRogvFJ5A+lagrmq0SHq2QwbdP2FOr6+kyZ0G3p4y0d2JKLsS1bp9F31nd9zOYb8lvQNHplE/malgKHyQlpGsbKxq1ns8PgzYAsXzoilhj5F0ize6CS/FGXSmcigUkBdYkvEoRbzb6lt4ySZ2gqlOMyzXCo688m1bvRHbb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711525525; c=relaxed/simple;
	bh=Wg1X5HwAVxYfEIH1apqeIWmVG1BVbsqvEezzP9EP460=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kg7nUiveMadJ49lHwX2sTimJuzVJ+P/pwL13A2gOPFfwTKu8S5OtgS7SUaDvEjV71HOiGPel9+h8KKTdPWxPaT+imqlWZWM2VZBdc7tcrfAZfwX/hf8wuSyv3b9MT0wc4Z6K92DsqFZNbvsSLWyzYYTmuFQaLAIV+mae+qg8M7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C4ZIKD7w; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C4ZIKD7w"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a4e0b2d5b3aso6640366b.2
        for <acpica-devel@lists.linux.dev>; Wed, 27 Mar 2024 00:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711525522; x=1712130322; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F1eTVFmntz4ovjXpzKJKQby+6jO517KFxKyKAghdTvI=;
        b=C4ZIKD7wws1g2Hc5kTgMzHl5YLljOs2nl1hw/XGwFHay6gkSuH2FtGjBX0mxhd+6yn
         zewHqMrUQEPJs+9lXD4mA4vwH7aqEEmK/cnc6raz0CMR9eujXtz4zQsFPOLOyhDYoN9H
         531+bk5wVKZh3zG9RG3aD+jxsX1XAe9kq+bj/uRQkCLAsxwX+F7WIkCSR9e8YJxPtb+p
         QApb0i/5iF3B1HgYO+pN5LL2n625RQuuFpCZFH43fQC7VeGzAZHGD7YIzOqeViQywEgw
         dJmbBOs3TLi92VZr1vt1t/SYHYE6KP0EVSLSxhTaQOVHfW9O/8aDBF3NCMWfxA83qOL9
         AG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711525522; x=1712130322;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1eTVFmntz4ovjXpzKJKQby+6jO517KFxKyKAghdTvI=;
        b=AKlnarGH1tnMP8Lsa+/BdB3cHEBjdjs3dDgtCGktyrOop/IijUsYhx+cdQgHXy4KhV
         UWLZmKNAY6CqGWt+ZEAEN/HDr0e1hfVnW73IENCz3ROV1PegfQlI9dh55bpwJM58/Iqt
         QzEffi2Et1UpXjq9N9IZT2whskxNmzlsSkWdyzvkJVDs7npPFUA1Ra3bgSnFd9ONFEPY
         UvAQNeMYxa8Mk7I+WKP7nHIXaN0BCNSsdzBi2etEHm/C8fUeHUQyikcBlNaPXGxoJzcG
         T39gSFJNGpnrMJ7lSXkVjcrJ9H8ECly7RoJoU/sxlczMDH5wXAw4a6TyUy5RpPAODvMy
         BNuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqS5n8SfPfYdoh1Tguu9BPgbRClenJlXkKaiOlF4Vp0I8d+J6g0Mb3j7rlgJ5Jsaf6MhmvA0AAZ5iAGEWmmoDVaIjwR0evUO3mCd/a
X-Gm-Message-State: AOJu0Yy3KxD7zal77U2QEXSC32qflQIqIzPq161bPrUcpP97/AjvD5G0
	xE9P9rJkTK3Zkl053bh31Rno4/ADrI6M0lHPMOfVkBQaowiK4elsEVhgTtw4AJ8=
X-Google-Smtp-Source: AGHT+IHx84qbmViqvNBHIzePmxhHICLH2x1RGmMtZ7MpTJn4t+7Y+v4TlMxksaWH0I8un2QmTkwyJA==
X-Received: by 2002:a17:906:5acc:b0:a49:fa33:a413 with SMTP id x12-20020a1709065acc00b00a49fa33a413mr310739ejs.69.1711525522151;
        Wed, 27 Mar 2024 00:45:22 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id am11-20020a170906568b00b00a474690a946sm4671745ejc.48.2024.03.27.00.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 00:45:21 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 08:43:57 +0100
Subject: [PATCH 10/19] platform/x86/intel/smartconnect: drop owner
 assignment
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-b4-module-owner-acpi-v1-10-725241a2d224@linaro.org>
References: <20240327-b4-module-owner-acpi-v1-0-725241a2d224@linaro.org>
In-Reply-To: <20240327-b4-module-owner-acpi-v1-0-725241a2d224@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Corentin Chary <corentin.chary@gmail.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, 
 Daniel Oliveira Nascimento <don@syst.com.br>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Matan Ziv-Av <matan@svgalib.org>, Mattia Dongili <malattia@linux.it>, 
 Azael Avalos <coproscefalo@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, Jeff Sipek <jsipek@vmware.com>, 
 Ajay Kaher <akaher@vmware.com>, Alexey Makhalov <amakhalov@vmware.com>, 
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, 
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, linux-input@vger.kernel.org, 
 netdev@vger.kernel.org, chrome-platform@lists.linux.dev, 
 platform-driver-x86@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=783;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Wg1X5HwAVxYfEIH1apqeIWmVG1BVbsqvEezzP9EP460=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmA85TVv31sDf8bPuTon5Zx+mnZ6bUQuZeo5/Xt
 fBjclRCwtuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgPOUwAKCRDBN2bmhouD
 16DBEACTOBj2DSuJdBB70h5TLGwqWaJu432sTe6aLkW1LieQihUopEctQF2fLYrgCLQKHaUUXJ8
 QAUreyqfaWhwNtQXOOY+bdZnkfk4gyaWSJZs5Fk/bpVsEc43nl80YuNCc8ItykAFg5+TheZqy+k
 JjgDHEHzI5CQWz/5zmkBn4A+WeJznAPBsegXHsEhQQX/ho7zKiDYjHLwBTQw7bk0TmO+EN6Eygg
 YgBztSTRMiAce5/Giga5i7QfhCs+wDJw8zSCUfx2VzXaAe/DhnnyunqmXj9lV6abeYjHGCvbgIn
 3aEGmAFqT3Pn30r27ykHhk4uHGeIXh+Zic2zH8HedGT6bVsjIH5fTufZn3/Tw8sre2+d8BHl9qj
 WzTJxdG3iA1od5CzC3jQvCkCJNBvCicgWMu7pibxMcFJfgGkLedXpWMXVczrANbeSm3aWMB8sBx
 Kzxl7bUppGNDMeY1XXccf1efJygJn2IYpAzA2vk11MGYMZB6ljwiPow74m63ENnh4LSnqAbZCm0
 EwHfbJqYPPJ68WW53jZHdg6tXCeX5ykaqKn+hrOgEmv+3gV+X9l2bXF0XHKqSwOO4d8wLxe7GmZ
 22o1xa/V3ru4AMjypuWtnanLYv/MSbb9UnHCVjIDCmrhRTdICto3f9zYrm2056Mpbp0OCpxZCai
 9rUII1fUB+NLzzA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

ACPI bus core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/platform/x86/intel/smartconnect.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/intel/smartconnect.c b/drivers/platform/x86/intel/smartconnect.c
index 64c2dc93472f..cd25d0585324 100644
--- a/drivers/platform/x86/intel/smartconnect.c
+++ b/drivers/platform/x86/intel/smartconnect.c
@@ -32,7 +32,6 @@ static const struct acpi_device_id smartconnect_ids[] = {
 MODULE_DEVICE_TABLE(acpi, smartconnect_ids);
 
 static struct acpi_driver smartconnect_driver = {
-	.owner = THIS_MODULE,
 	.name = "intel_smart_connect",
 	.class = "intel_smart_connect",
 	.ids = smartconnect_ids,

-- 
2.34.1

