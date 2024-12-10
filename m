Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874E5227576
	for <acpica-devel@lists.linux.dev>; Tue, 10 Dec 2024 19:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860575; cv=none; b=jLPTFTT1PurwBwvv/2AkAIcSGuccyQeqZsCCGBJ9NopOr5ODZ8LU6Ucru2hebxrQATbG9f+QSghB5kkP3DpLfXYXii0ioPdkXTRpAc+LMtIhbUPg0D/n/cjrmUHuGwZHHG0rphRuOacoBzJLw39sN9dWE5hkRk6UpldtnWvJOdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860575; c=relaxed/simple;
	bh=sdF7tOeLaLfCdiDlVogKRTgQV5yx9VBAgCr2khnDCdU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fYGnfzO4pWTc1capiScKhuKCBH+3RHfU1ZHtDgSnppc7NZStji+xPl6B6tJmud57h9TbwCXyTJgSObfLjurxWuajrsJWA8gLv07CCtwM6yhbal+0+NRXmRNq10L5BMmgJjf3dlSpVqz5TOnnV9wQjilLMUPj4ln/xJt6XdVf70w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aCxURfeF; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aCxURfeF"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4afe2a1849bso1279282137.3
        for <acpica-devel@lists.linux.dev>; Tue, 10 Dec 2024 11:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733860572; x=1734465372; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CTX31YxAcEET+qmrwOGI7rmuqifx9R2Evse3TExOMoA=;
        b=aCxURfeFk2qjf9Lb8ZSRZXde/rgb7xnhyKc+o471me5G7xiXzRenUgdSXXUf8jC+0S
         ipWsjSFHAQYWJlNMV/oTMac8GmjnhNNqpZIwlHD/ysCzz9PAKGeRYVMqNemGQDp/3Az2
         OxTs6Vs+syG9O0jVZJkY77DJDzdyMkWIt2Sr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733860572; x=1734465372;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTX31YxAcEET+qmrwOGI7rmuqifx9R2Evse3TExOMoA=;
        b=oGHhaGNFnamI2zwfn3QvBCOXakZY6evzoqAoLijS2I03jqKtsoew59kt8QYw2oeAuC
         h2WlKB+uLUcQ1etRfJ3MhIrt43lviB4oagbIoD9mwUTPItWACjoG6tYWaTwVtuvjCahE
         z6YEbRWpZWjxpOypMdab9PB7HVQ+ii5v/ikwcJJbnnM8CNGC+cHtJtJV6geV4h7565Gq
         q4lA1tz0Vo3OLSuvmQVEMEprjuq5A8LyFff4bWomN5VyysB6yGVeGNWLXIfo2TPK/5Qw
         W3D2djJ7pSFHSed6loFQbu//4k4pV9RPVsUe3vvDwX1bedj+h85h82JadJWLHJsCv6iG
         rmNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwvcdZMffwqxnAK3pczxP4x1ApoU/0wu1GjcIoTFSsjD3XFKXbzN6m9kr9HDGIG1rI+t5n/wf7xreVNvA=@lists.linux.dev
X-Gm-Message-State: AOJu0YzCgzrnD395yZqhB+m+8re6U6S4CzcFoy5rHT3V4ZoyMcSuFXUJ
	O3DVRv1Gwh1eOhL+jJ3hP7cDT5gkSJAnVIDAIoXb8XjI0PoEnR/050lED71dtg==
X-Gm-Gg: ASbGncuAjORXqJhX06Xvk/g9rNJ4fuuc1ijB4J697zwl1To0tUT8z6UnEpg3r8y8WvF
	0zQ1/1mx6vJZqvMwpvebErmaErWJIdEHVlmf/8iD0K8aRrkBHz0C09WzISpmnEtH16XkB9MHs2R
	Y/1ZR1y8giEY1Rnd/Z2tOaXDBBJGrPay8XCo+ubz3JZqc7tpAa6vO+b/vK3RjyMs2nq3HigRMdV
	SUmCm7CvdsI5oUK9FOh2yHEH0VYdeFOxidsL2/S0vwqw/JFcOeTP/DAdApkfWUquoQAeyehA7j+
	k8vfi4wkFoyRtnjfuD8b8JmtQBss
X-Google-Smtp-Source: AGHT+IFOlLOc71KptU+gM+mbs7OSqZvI0F+Ca1OaQ7iYQclHhw5OIq3pXc1ymxgCi+mj9I6EK0fVEA==
X-Received: by 2002:a05:6102:418b:b0:4b1:1971:383f with SMTP id ada2fe7eead31-4b128fee492mr811079137.8.1733860572588;
        Tue, 10 Dec 2024 11:56:12 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85c2ba7dc70sm1279522241.15.2024.12.10.11.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:56:11 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 19:55:58 +0000
Subject: [PATCH v3 1/7] media: ipu-bridge: Fix warning when !ACPI
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-fix-ipu-v3-1-00e409c84a6c@chromium.org>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
In-Reply-To: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.13.0

One of the quirks that we introduced to build with !ACPI && COMPILE_TEST
throws the following smatch warning:
drivers/media/pci/intel/ipu-bridge.c:752 ipu_bridge_ivsc_is_ready() warn: iterator 'i' not incremented

Fix it by replacing the condition.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/intel/ipu-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index a0e9a71580b5..be82bc3e27d0 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -774,7 +774,7 @@ static int ipu_bridge_ivsc_is_ready(void)
 
 		for_each_acpi_dev_match(sensor_adev, cfg->hid, NULL, -1) {
 #else
-		while (true) {
+		while (false) {
 			sensor_adev = NULL;
 #endif
 			if (!ACPI_PTR(sensor_adev->status.enabled))

-- 
2.47.0.338.g60cca15819-goog

