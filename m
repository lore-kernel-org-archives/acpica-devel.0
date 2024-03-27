Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE7255E6F
	for <acpica-devel@lists.linux.dev>; Wed, 27 Mar 2024 07:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711525551; cv=none; b=ftzRyANTkx1EL93E/NTXQX2T/sbbNSrz/hUYh986mqtgtNq92SUjWFGF8yGA5EEjBUa2eC5WM0UIDqp90EVA6kqw24U5YkdwGqKOQ/cQfdU3bwoQoEACKJl+BOF7qyp14SB1T+2e8qUc/siEYmvljfvH8j+VhBv2t4WChAVoTMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711525551; c=relaxed/simple;
	bh=dbdsTocayhpBlq6Da9S/RlY6tutliET9lQL81eDjiGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TjsbkWI/UeNnsVy15nhKde5wzENjUisWI80LFRO4R9PRv+bh223nLATvKfkBtJevQzdDV9T0E/BYXiAyr6cU5A9jE3OLXq2D5E1hdmWvN/wgy7Kl56eC/vEhqJrThlGje6cxNwOfb5do8cVnFjHnja1OhGQd3YZbM5HiMHHVxEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YeGmd2Ny; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YeGmd2Ny"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56845954ffeso9010766a12.2
        for <acpica-devel@lists.linux.dev>; Wed, 27 Mar 2024 00:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711525548; x=1712130348; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFmsV/NoaMakWZHxkvOTU5Q8ryqbz3jqq/d7yKl6aAA=;
        b=YeGmd2NyHdsgehIjkyt9MislPHUDXK0xBN9uka8wzrbl65Ei4hLhDq3o9VtNe7pJs3
         hH5IdxiB6Jm0rqf0NBgFBKFq4SgBiESqupsRV+OYxfSmA1Xze2mEz2bA2YjrWBTFKJ4L
         A4x8PwjSuRCsnJE9XsofRLeU7U6YfFUkd/TRCyVHD2YwJG0teOCpYypq83Tex3fOMele
         WfqH0TuFBVD4whYvKpOa3efPZpr9A8lNnyTznHHYmM5ZwdZvQc5xQ7eN5i5RWqYiGvOy
         Sw5NBiDZU0qjpfVh2ZobMKo2Wt+YxcoqHhzO4juKVV+P6UwFLnucfgG67ORpH8sCnTb/
         1q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711525548; x=1712130348;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFmsV/NoaMakWZHxkvOTU5Q8ryqbz3jqq/d7yKl6aAA=;
        b=Ny2uWYD4ZMwZ/FR4R9V6QFKgKdM48xUFn8dd431o6KTkXz1PzJoWpExNx925uoesK6
         J0vl/glT0euTHrNFe9I92McxQZzJmljkN9RGhmJ90RfFCmbdfVZ0kNnxIaULa6cfV9iO
         +YrZIg7qtBm1SfnZ0VzXgLSTeNEO3+hddswxnqXCA88Qvh/eXU0d/YqSjHtun6e3bCV+
         FBD9+jS4F5NpwxF0o7ib6OSpbmobQ5v2TLdmS5m7FooE3eMIDKAKxn8YwJUST9RME3ec
         r8pQJNvIuAujIxExPtJLs+xkItAOya7prFP38h0hL+59ctzGRH8jk/tmalabG9ocDNE4
         Tejg==
X-Forwarded-Encrypted: i=1; AJvYcCWEhWAzK0XT6hBcrLVUHON4VS7NNNOXuWMQLALLt9TjfiiL9IhaBzskIjnDkYSGCYPXq16irE5ERPWsaUrhr4bHO0xUgTHT2x6z95X8
X-Gm-Message-State: AOJu0YwGecGRDBWc90pLZYU8rTqOwxHzsK5x8WJD4kCUIIId4bQ8aMWd
	gfoz3a/KyUcv8cX/Ds83WQcASvTAjoUxLNyV6Ede+kk/sHwmVEFHMVSk58aXuoY=
X-Google-Smtp-Source: AGHT+IHHJxnrf5kwv67bTxaWL+oqxc1u6A41hpjL8iyyqDm9/qbxskIGE6/X6lBP+g2gB+DzDCVcpA==
X-Received: by 2002:a17:906:3b07:b0:a46:af60:7c72 with SMTP id g7-20020a1709063b0700b00a46af607c72mr241692ejf.54.1711525548055;
        Wed, 27 Mar 2024 00:45:48 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id am11-20020a170906568b00b00a474690a946sm4671745ejc.48.2024.03.27.00.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 00:45:47 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 08:44:05 +0100
Subject: [PATCH 18/19] virt: vmgenid: drop owner assignment
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-b4-module-owner-acpi-v1-18-725241a2d224@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=641;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=dbdsTocayhpBlq6Da9S/RlY6tutliET9lQL81eDjiGw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmA85aKG0YKU0GrcDqlUGPLUrY9ex1+PR8Y9+3D
 4a8ZCYPJ1SJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgPOWgAKCRDBN2bmhouD
 1wGDD/9dPtpxbuSt90vV7MX3thsBHfu60oGwRwnqGXmAnHryu9NwMlClq3O3jHMxLgMdWtBzvh5
 y1Cdn4uAXMPYXboaS5tJ/iG3mn0wCAWppAo9XHFQzKRMEFtjn3BAgNer4iKeIaM2fQMCdo9mLen
 /qMGZ6B455dCEybvZO0D/OL7X3F64Jr3tBi7aeOsyt/9XWPc/1xqgY9vLoBpp17Rh/ATHh+aVww
 ftJ5dHpf/sKN+p9ahIbX3BNJExjcJV3GfghNVSVGgfs8/DeBYUzJ2tFtSugRrD3jd3scAtpJhrZ
 lFwnlTx/0F+nOOPwKiaRFYauy8otamqiqeTSIGf/C9/brFOmvL+iYlbS0399a0o9bpGDM2zbQ2Y
 KUk60BhrDS4jFkrLCQ5sP0NLT3oXuF1qOMtNqynWpyAZQrQxst3xkt3kysfFA5x4WuaXXqKL5Jg
 P98ihZUYKax2E3Kr0mxYVPz7rZEZRaNOjjlf8wp/Rh04cOMG9qLesw9TJl97aw4wIPYFZDdVEoP
 5Z4MxSlzwhvE+Lhs8UkizvB51FAx4RQ6F43HLcDL0lVFX8t9fU7GE/hcfzkXmbKxcIXQseI/EB1
 OLano4LLmDOHasasYu5hIymKeao6CzeNMWKRh8l8kHvx9YouEdQrnT6E0nvS1o38e39Z5QRa/I/
 alOoYUb8Vdvabyw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

ACPI bus core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/virt/vmgenid.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
index b67a28da4702..8f6880c3a87f 100644
--- a/drivers/virt/vmgenid.c
+++ b/drivers/virt/vmgenid.c
@@ -88,7 +88,6 @@ static const struct acpi_device_id vmgenid_ids[] = {
 static struct acpi_driver vmgenid_driver = {
 	.name = "vmgenid",
 	.ids = vmgenid_ids,
-	.owner = THIS_MODULE,
 	.ops = {
 		.add = vmgenid_add,
 		.notify = vmgenid_notify

-- 
2.34.1

