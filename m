Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8CC4C627
	for <acpica-devel@lists.linux.dev>; Wed, 27 Mar 2024 07:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711525522; cv=none; b=czvv9KT8SuXbS0uWshU/Dq/VYRgkpkcjjhdRBxQZke1sTo0HqvGJA3rpFKvvgYktqO64j3MxMe8Xyb2t8jT+Bd/tCmguJ7B35qYWfWfbsAJELBi5YWt3x1sRGLSgXh6L7HclPV3oJWV8o2Sb2vCwTQeNqIxRiqVTLPlFI8NskoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711525522; c=relaxed/simple;
	bh=1PHM2e0wsxA3Uj1VkzIBPCTuFK6Jh8lVYsMYYTUFi6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OZaV0v0iWLgNL+2rPyflkz82tTrAxepGhXWUgPp7u0UjhHEv15iuGkCKQY1NkvgVz3pXeiVbUiw0mFJQL1cWb+hR/SUdqun243/FSeMpPj2NNj9RqRLfcjWXknYIBTximHJ88YOakQ+2mdEiJOAC7JvKDBoD5rfj5eYrX0s2UP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dhMzDDjC; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dhMzDDjC"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so107745766b.1
        for <acpica-devel@lists.linux.dev>; Wed, 27 Mar 2024 00:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711525519; x=1712130319; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9x5KXrMkGCI5XWmP7phpN2hPRBytXrTYldJCysrdH4M=;
        b=dhMzDDjCwFfqf2f4mwJYOSdArP5+cFLeweX5Xv85chxHmHAE0vD/rtT3XSdnFT/Upx
         xt85RBk07Z4257ZzOLvmy7f0BJprYQaN4EK9WXuIlAtxAUkp1qB+PyeiyOoF9nw0TKN3
         hXiWKU+jee3zcq9nef3tagX+khV1ZTJkOxmuOabwK7OBDeKMP3en3SbS1t7UHOmGYQv8
         8NI/LlzKYngogBBk9jyPhCA66m5uOZNPeI8TFWXF0zIiUUfJUavkicKBw3eKNj3YEgbw
         6KYwUPGtgEacxjXf8o/FmF5480GH+QXpHRAzUUh9oAYTq72QzPtADdHlySyiP1LeDuYw
         7N/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711525519; x=1712130319;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9x5KXrMkGCI5XWmP7phpN2hPRBytXrTYldJCysrdH4M=;
        b=syea0deDd4QKPww1diuLnQnfst5QJdoQygsroppMkvyzSUdQ2kA9ZQVPwYEosMUbvL
         4lXjHzJUJuwyTbuCudrwO9QFU+k6x63QKiJ4f0LpEkGOkAC8+/KG+iShFkggD3xXDyGp
         IrEYYAQVN3s/DSbSTdcXyzSFw450S6DKFv8OcRz1kZUZsK4wvK+cLauscZP/JG4+vJst
         d9jf5Y1JyAhqANVsWKt5L+OiVHE6rbhC7ZE+gbmhVPF/93F2/f72LQC6QEP9UZJwoXDn
         Yji7WRQcAoTWRM2yqsLoXnvftFDOA8NpuEOYP3LhXqgcATdmyKMx4BwoX0rVfJ6xf8z8
         hF0w==
X-Forwarded-Encrypted: i=1; AJvYcCWoXfI3X/qQ/0fl+5g3o32dPMn3paJ6LnZMnftgnf2r55klgLAx/ZzimV8MxK+k+BDsb7Tj0SdGITfC/eMja0XijIe4kNR5PjBQVKZ1
X-Gm-Message-State: AOJu0Ywlj8+whkzxGVFnhIi3GYAaOSRXj8DEY0EBrOU73CxAnsdZTgxX
	v5RXgHV16pM0/tSBqrr9HesWQLEUID/kI3EXiaNGPdB/xHHp0VWsMy2lXFHgLcc=
X-Google-Smtp-Source: AGHT+IGUZVId15l2V8zrqWjVp2OSJJdjnfqpmVblzlabr906yKn6uZlea2HCTefmgDYcMw27xN5Bnw==
X-Received: by 2002:a17:907:9716:b0:a4d:f635:b7db with SMTP id jg22-20020a170907971600b00a4df635b7dbmr3744939ejc.24.1711525519373;
        Wed, 27 Mar 2024 00:45:19 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id am11-20020a170906568b00b00a474690a946sm4671745ejc.48.2024.03.27.00.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 00:45:18 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 08:43:56 +0100
Subject: [PATCH 09/19] platform/x86/intel/rst: drop owner assignment
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-b4-module-owner-acpi-v1-9-725241a2d224@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=670;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=1PHM2e0wsxA3Uj1VkzIBPCTuFK6Jh8lVYsMYYTUFi6w=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmA85SfelodN5WDCpPu7IQ/MSd2bqFhtOMIk1dX
 Ppxe2ScpSGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgPOUgAKCRDBN2bmhouD
 1w+VD/93clNn+/kXjdiiABV4GEk35rFvm1cQ+jqPu1K55WJH6DLOZjQhRCFpus0DAbgq/VF4JGD
 D5269FIJpD3FwKPFYxgHxClK9t1tfuFI3okWjfO0z/PxhzVybHByZ1UIJGguKaVi4Sxwl/dTTWH
 gAIuW0+qYsqWSuD2gXOcAKb/ET0fITW/EYGnkV4uEvo3H55cPfH+oH4sEeF8hMOEe/WflpH1/Ar
 NbE0oFBu3JL0/VWu/kZAMAxcganCGuaHoiwS7BDj32xJDV/L7ZSehdOplVIwEOxAia4wnazTzG7
 fglnEQClU6RSPIvG/Ejvq/i/9kg3Ckq1cSUkOTE3w3sd+x+Zsy0sXk30H4IDwzLmkd33OCmoinK
 Vex0cIQDM089YXzD1uvkATAhfLwzF0A3BXtif+guBs2Uc2laTuV8mmKmHZto00y/Li/Upn/VFlA
 0gKekbP3xy2uR2uFuHBcJWR8joHYMJcW+Dck9P8KDcR889NamSJYN3iYD05V/j4y1lygog9N9wN
 C27ES+xZ2le2hI8lMBetXbyfuHe7oAXFix5traHwIwNVH8OcOFRJRB/19TtDlOU7U0kkTuu+GQv
 cdlbKEStsTOg6U9y6p5BpQ+88DLzBtqv03u5PqWdMPPoLNWZtCUtAJg9IM88DawehV6cJXezaiK
 sczoxDt0xaJO2+w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

ACPI bus core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/platform/x86/intel/rst.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/intel/rst.c b/drivers/platform/x86/intel/rst.c
index 35814a7707af..6bc9c4a603e0 100644
--- a/drivers/platform/x86/intel/rst.c
+++ b/drivers/platform/x86/intel/rst.c
@@ -125,7 +125,6 @@ static const struct acpi_device_id irst_ids[] = {
 };
 
 static struct acpi_driver irst_driver = {
-	.owner = THIS_MODULE,
 	.name = "intel_rapid_start",
 	.class = "intel_rapid_start",
 	.ids = irst_ids,

-- 
2.34.1

