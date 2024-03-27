Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9191656756
	for <acpica-devel@lists.linux.dev>; Wed, 27 Mar 2024 07:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711525554; cv=none; b=VPJkbWrPbJvZ5qozEaB6rkGLQJzwiMtdQUcQIh6g+8owD0k8xMne24mZUpIC6mmGJ/eaJpaL9Wjm6gH9FtIkb9GjzACQ8USZo2uxCLfW1OEB6EXuxVmPIOS0YKgbzd/waRgbR41FNBy3Lz/ZaV016Q+qYE+Ffdp5wxQCPeNAvhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711525554; c=relaxed/simple;
	bh=htKh4Jp4vM0zvCuX4KapTUnP1c1FqeWCRPv1BZ+Q/j8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZVqTScBxfBHFr4BzhhmKfxx4BQJuVLv8C9v/MLK0DvZszcuDuObGfYy/3SQA7ZcjYTBspHaLgJpSZ5gIJ1REVQQCjLkdW1nDzGtnvXeuJWdO5oWGgeJt/aBGNPiZTKZ/JN7TqdSzSPxAg3+bfTvzB3l+feRF+dOlMFWn3KQOpdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GZTgnA8m; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GZTgnA8m"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a4a393b699fso93593666b.0
        for <acpica-devel@lists.linux.dev>; Wed, 27 Mar 2024 00:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711525551; x=1712130351; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N7K6idk2YeGVu0lxj/Ps3L084ba7NhsvfbgHIaF82R8=;
        b=GZTgnA8m4klYkodzPNqPsT1+8ow2fZ1k7cgQ7jD1l1L3Ai++6kB+PeYf5y536BUU9n
         0YhlZUDoR14ty/TZa6KAVcAwQ3X/j0TDvT4U+6kNI+fBFgW/DWqj5yizcvC59qI/exLd
         EZrcfOy1JvX1vOWZFEVMKSi56TBMxtgpiSvu/4prTxR25y3O24BLLivJFTMvOSPQXf6i
         JwWv4HBu/PAuAdbopCixCmPylbtPteXpQIJi/IFepd+MqPY89e2x9Mt1ZQiiKphGIbDH
         bQSv1dtiAzfncoGAPcxBv8vBWn94hELoC/l9SsvHUiHzi5n35aVD+jObXZkzRrdfq3yS
         X4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711525551; x=1712130351;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7K6idk2YeGVu0lxj/Ps3L084ba7NhsvfbgHIaF82R8=;
        b=HpEfnIzCGUb/ExoD7i1fTKoHN5x3ZHQzRviza+oEBc8EoaWl5HSd2MMOPAMrDweAVe
         SKSSnWLow+w3Dhx5vwraLJ4NijiZYk+AdkQmWYOcoXzRol1xLwWICJkzVLugOM+VEjNe
         LJPShDZLsfijDEv9qk0+OX+E6dae6zU39ouZTsAbdMl3/VBa2pehD77+W/SHGRj7hm5Z
         WV8Jgc2KjGaxMufexi2rHqncuctUSuk90sjGaIC1EFfAdFhGfySGtEiJmtlQ3XtiiAQB
         FfQjXtsfSfUEmIrBjPHD9y/ClJQrP/khIRSdH8yrVdkCEQS7W4edXhiUp0Q/iSzGZjoI
         y7oA==
X-Forwarded-Encrypted: i=1; AJvYcCWaxR4E5C2TarjoAl2SsUsZJxvVy1r9r3vClWuA9h2KD5BQjWjRY21+mdiJRNvV34hWB2198iEpPgtyfG/qxyq54qps5/iOAbx8NGL7
X-Gm-Message-State: AOJu0Yw8+yiUqfXdCrr3UANtbtoLWS9Tw4ZInSEcVQnza3ocRS/Unp8j
	AX0HJ/FUgWL7nQSb5mBaxCHAYW0XoBH6GCLWT/jAWiKiLT+cnfuDrXkGqe9etRs=
X-Google-Smtp-Source: AGHT+IFo1SVbUJhfk2D5dISc82f8C01XAvtK/9Ua8RHBqCpkGF1uNtl0N5fMsZ3xQ2K6OiUoagNCQg==
X-Received: by 2002:a17:907:e8c:b0:a46:a3d1:679a with SMTP id ho12-20020a1709070e8c00b00a46a3d1679amr4106291ejc.14.1711525551050;
        Wed, 27 Mar 2024 00:45:51 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id am11-20020a170906568b00b00a474690a946sm4671745ejc.48.2024.03.27.00.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 00:45:50 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 08:44:06 +0100
Subject: [PATCH 19/19] ACPI: drop redundant owner from acpi_driver
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-b4-module-owner-acpi-v1-19-725241a2d224@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=674;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=htKh4Jp4vM0zvCuX4KapTUnP1c1FqeWCRPv1BZ+Q/j8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmA85bDmBUKGxLiw+IE8MXLih8uNdO+fOokRWlT
 TIm2uaEvyuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgPOWwAKCRDBN2bmhouD
 1z6cD/oCytA+t0QmfxlLxr4zYP8tlK64yfX5UfqshoxKOm8kP+7fJ49TPWNAJ/2WOuldx1L8JZP
 GlN8xW/4GU+WN5dsD5vqU4gbr9Fuk5sFzeGpF1Wn+LAWc7Rzm6MSPsGY32bIeJfKiv6H4mha/ps
 6iC3ilwowIllCYO/VS+7EUinaRgOc4gLWxeG5fsWst0/vaT/ppa+J0RqUaM65oxA2SVXfaGW29Z
 WfdVl9fZ4bIoKvmzM1u0QM8ugLZUVyqdYaaMqZb4oCV9JATh4I80NtpIfy6o4YaCRAmDwxiapUC
 HUHnluTQsUJdqX4wyUG5eukbNSJWoevYgQkyFge+T9YteFs9tbViIAwcMKZDN/XVEY76fDZjxCh
 V9t5i4PTRFJFOxxwQMv34S//WxQreKqDkMyo2m8nbCDEp0dHGXiYPbibrEXk286kkju9dqzQXFL
 SwWC13gJbV5ZXZoYT9ZtKUN7IgyenZ8Emo5hTx8uQQ0hP/r2vwR8uRfZZ2tbr1CEqFdpciqLfBo
 eWfMHiqnX05AtOftT8P6/W5u4JbGxibHOlzGY+SlIFixrIy9beGzWztoHO5v77lVosMNGQixCAH
 Brl8aSiMZnR5rKQUT7+dBC9lBBeAk761YLH+3wjtZoA4c8m63tKEgTknXO4Ny2XJQcxUiykSJaM
 p0b7ggN21hq0YrQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Once all .owner is removed from all acpi_driver instances, drop it from
the structure.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

This depends on all previous patches. It could go next cycle, after
things got merged.
---
 include/acpi/acpi_bus.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 7453be56f855..32aae3ee99ac 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -170,7 +170,6 @@ struct acpi_driver {
 	unsigned int flags;
 	struct acpi_device_ops ops;
 	struct device_driver drv;
-	struct module *owner;
 };
 
 /*

-- 
2.34.1

