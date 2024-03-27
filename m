Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB1B481AE
	for <acpica-devel@lists.linux.dev>; Wed, 27 Mar 2024 07:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711525520; cv=none; b=Djk/1XVVtXSDtcoK45mM0J6ws9H/eo0kx9KBFh/TZnFK+NXPPe/KUU/8pTUNmiVSpXx/am62OKo+zwIbP22/dBgM3zKyeHCHXcM2CmBQQ1nFc/kAAoLknWjCsFBGq3Xe8ErEus6tz0IK2W6CZt1VfOs4hr+mg66FIEKg4NEYWJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711525520; c=relaxed/simple;
	bh=PW/2fVtuT04T/hFzkPAyArLp9KqHq/nQAVkBdLFHDts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b80VykJdmyvRLBVhresQaSZ636oaB3mzldraP6Oj3DudSDXhkPF7D03L3CdUEMfVPJbc238/fVzGqeQKKMOPgPE0DxfZYqvEm9jehmGz6YSZ62hOyxH7RKhlckPXMFu96Oxs03LT8YeYQuFP1dsAdo1/Z07bxXQa3wVXkwyoap8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mwkCwGb5; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mwkCwGb5"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so107739866b.1
        for <acpica-devel@lists.linux.dev>; Wed, 27 Mar 2024 00:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711525516; x=1712130316; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4fuO0aVJ5zsguZWp2jlt4KOMyVYGLs3YtOGuM2wXyJQ=;
        b=mwkCwGb5UUItLFA2PGgBuCB0md+4W28M6OS7V+3IHdEb+C2V++PV3swmeH4rACCZtR
         9q1E4JNlOuLegtjHAyII2rviToJsIgMW17oX8HO7IRKrTnboU/OaeH13O+d1sSy4kUU8
         PTX6IdzcEVYg6NFvSJKIAowQsSeuUgaBu2ksoKMfVi/8uVobB7xvA4HWgVIDO008RXP4
         smSYDIvlXIpRPj7YT9HAOpCgmDkexhXIHddfsfj7wusxqWgui4yRbn5ea2oiV7BHBz22
         DVJ069Y1Su7VfO/oOgbhTfHbB1g0O2Gkm3saY4JMkLi4aKNa55vc+lW/S+eC4nI9V9fb
         QuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711525516; x=1712130316;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fuO0aVJ5zsguZWp2jlt4KOMyVYGLs3YtOGuM2wXyJQ=;
        b=Q9UVs8npsuMEW/Zm0MRFKhZp3KUU8AOqykbAFwk1UQQz6AZdZ2UoFMHclCuqLrNUYP
         03zwIMn34p2dlz0GCTM1FaPFq5uIUUaFEc5WDQsitTF//wQjGzf9xhypTWDJppJeCbek
         H+7Ph1dBQhpAIovfqmhMncbcXkuh+P1HaB9UnOFYcbp79ViS8cHzhvd5V0KEBz25kyKI
         E+gNSJtlQIBx93nhqtn6+zf0nImmlNNP00IIYtHjDEqV/lV9Vvd+tuAaXHY/nQkyyc3V
         Lm2C5I9WYfe2HSYgreFIhy6iWjIxpn0vI7/7el40ZwE0CWak1ujcbC/qPLDT9uO3dK6O
         183w==
X-Forwarded-Encrypted: i=1; AJvYcCVbcqAEN1KoT7gIjYwnVEYCGlyTsMSmELYy9lkyJwfUiHhVkQfXug5g8QI990XpqG9/CVGcDwMr6Cd2Yz4btuxrTDTsq2ONdodmOqOE
X-Gm-Message-State: AOJu0YxztbJWQLQ1YOET3RApu8H9xyX5ymGhyffz7/UNLr1YFUrSISK4
	tcAkwD3nGsdmrKpbAz3+DxgNjailmhhttrczTnEvarJY6X3lN1z5VV4nFnIAQgo=
X-Google-Smtp-Source: AGHT+IEf9mqRIAJRMhFzviKd4mfvQGxUdPTjyL+U+5kLTi87+cq9Snxf1rUTq49s0l+wrsTSugWUaA==
X-Received: by 2002:a17:906:fe44:b0:a4e:e4:7b66 with SMTP id wz4-20020a170906fe4400b00a4e00e47b66mr1440886ejb.19.1711525516651;
        Wed, 27 Mar 2024 00:45:16 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id am11-20020a170906568b00b00a474690a946sm4671745ejc.48.2024.03.27.00.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 00:45:15 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 08:43:55 +0100
Subject: [PATCH 08/19] platform/x86/eeepc: drop owner assignment
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-b4-module-owner-acpi-v1-8-725241a2d224@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=738;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=PW/2fVtuT04T/hFzkPAyArLp9KqHq/nQAVkBdLFHDts=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmA85R3NeP7hgTLvLTuy582cYHdnOO/ArH6qiOe
 Q/c9zsRUQ2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgPOUQAKCRDBN2bmhouD
 14knEACIdFJb+BHEHgOs09aeO+Gjp6mPKSgHliuLHdNRTp5DU/kjlgWX2ZApgzYlSkzCFyyF2VJ
 MX7jfkufvyOk4RmOVyErHMxKkzUD0ezTqI0BXK4nlE1Wv9J1qcXg9Yu4BUN1dEV+fbFXPJayzmE
 wGXaPt8FX67cIToW4yYq/dhBZ+4e8YmNzDhYoF9mAMM/u7jQbF+AQ7BEGwh+KAzoGk90tPr3Uiu
 XX23YPDfBwKSJ+in67Wt4WabrHjQUhpubtLmzmr71gAL4kOr+9OOugA/GTx53v0+lO8+bWtUHyo
 r+MDJRcb2z0dc39FpuR3/WYsObktTjcKHJE6Y5EreLKY/ZYC7oumjMsM/7fQq2ZUvTO5C9Xhmnf
 7ME3DAgyel5EPoT5C4PvIThnlqw4eMC23uQmThfg7tu4kt/ChtIk4+N4jcgUvRrmMtB0rvn1HrD
 lBkSjGgY5fENOlhR54NqfxC+KpgI8zuBbU42m9h4bwSHYbgExqOmpPmLe7wc4hKqLCjZbxVwwaH
 RXVPw6XGFdJ0XvdBLAP8CEkyLY45kWcGaHPtaon7DCHk6gJZ3VjFb5IHDfz2HGFLHkRgBRA5+Yo
 E5iApBKkt7s7lVBcJsP4MwfgaR+ZNS8aJRK4o1P6Da162e+HYeSU6vcg6a0vVHC8yyV9qkwwAjp
 QpGOmRtLGiun7dg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

ACPI bus core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/platform/x86/eeepc-laptop.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index ff1b70269ccb..447364bed249 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -1463,7 +1463,6 @@ MODULE_DEVICE_TABLE(acpi, eeepc_device_ids);
 static struct acpi_driver eeepc_acpi_driver = {
 	.name = EEEPC_LAPTOP_NAME,
 	.class = EEEPC_ACPI_CLASS,
-	.owner = THIS_MODULE,
 	.ids = eeepc_device_ids,
 	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
 	.ops = {

-- 
2.34.1

