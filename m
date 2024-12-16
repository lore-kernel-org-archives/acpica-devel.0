Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C871D90D7
	for <acpica-devel@lists.linux.dev>; Mon, 16 Dec 2024 21:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383854; cv=none; b=Kcg+k9H1d1hoBSm+y1MiqwAsYhMydKhir/hMGnszioJ+rdRO5+28IzFKC1NIQqHMI7OEmnvyEb/4RjWJIpT9v1OqWjCDt2QLJhiCwr9lZjXweYHLEn5CWrSuFUnnPLLRm1J8QY7DMsSGsUDN+lC5MOZS/BNSrQc38NLTPNmY5r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383854; c=relaxed/simple;
	bh=95QUI19i+vnnT5+G1KHFOpDSO/pMrFLiSHBGkodQPoc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VBOYiM4HFgwHyE38qMTUUCARXHrzGA6GrPS1afzjMrrPTYwPMxcI4nZRa2KFLMi6jTBsSoNq9CXFdT0OiOvWyHmT5r7ZlWQgWxFGr4J3knlP78ZNfyGxOK83FcgWukZTYp/xDcwUEmOrVp+LYYP7mviChIm6dgYjXiScE4IU6LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DJ7Zle3g; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DJ7Zle3g"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-467a1d43821so37086691cf.1
        for <acpica-devel@lists.linux.dev>; Mon, 16 Dec 2024 13:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734383850; x=1734988650; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q9wRik7VAWXozMa2pBEsGGs4ayCPfnrgn33kguAxeWI=;
        b=DJ7Zle3gx7+0iUjC3Inhr3WudtpBfbbh7IEpD8/u1+1VTo96qveFFaVmQdsPSntpnR
         Ypsbm4BQA5BrHzsFsJ1m0mrR1iPw079jVSsS/G46jlSX5vbHrfHvSuxOueSvkw03YH8X
         Dn0vTqBNv5c4gNa7xkz4vNR9iHSoAenQLuNGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734383850; x=1734988650;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9wRik7VAWXozMa2pBEsGGs4ayCPfnrgn33kguAxeWI=;
        b=qQWKYdfjqycR3gdMKrnvP4wKHF5xUEEYEAxGjCXPgiPFHgxYfFnOBar49Te9zAuV56
         dgAGLnxQ5588gnBmAqv3zhHkjQ58BszSpGIbHlhN/j7QnYnBrYJVrqKodg1Twjpqkc5z
         9sDyapWV3uojJA6p8S9VwRfJrmJuWqz+uee+sUuFwqeA2NxEn22ZFY33R4xuU83PXgGj
         h9FBKQ328a920AQdLcZ8V2GRCUcVKv5XctSgcDZR5N8luGw1NrAbjB1IudfjjmDmx7hB
         VrbOjDy53WDS5246ZlIzcL8u9SL17S5mCXypzqZ7pOxrysG9dluPXGQohDaqpudylgcX
         4H/A==
X-Forwarded-Encrypted: i=1; AJvYcCUhsmGCxznVp4acXReZE8X5OuPtsMTqmNepMM/xPMnDJRb5HBQmm31h4tLF2fc+zqNH2GlhYYwB21WmhMI=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9nQ8wiF5Rho1Qm67xEwg6usKIV+Qd93dLbqD3ZAUaC0nDQaGN
	TENEFBRAfoHyzyPbv0gFjfLPi2gDxK2xZH6Emb1hRAN92X5v06bLHAgpv1SvcA==
X-Gm-Gg: ASbGnctjshx6wim2A3Lx3XA+OIh38HN6a0tcP3ogba5/Lg1N68GlTigdhTuSnNyhcqr
	6DhdrLGwuG5ESIh87vbKGVTzl0W0Q5WJ55QQQKWcdiJs5Uu7Awk+diicg2AF3ry7bIKqfOzWObo
	+yI2GV/GRm4nxg1y5k8Uf8VkHi+P8DIRBdQJaDzPSau3O1RtlypIpa6ZN2Uevl8UDp/w2PXzCXJ
	p3cdnL5xfI+cRLt0VviqljR0fx0orbFdlk9TWs3DqCRZOS9SK4OJrz8P4XItGXW0RFrxL4ubdJV
	YojjHh5m5l1JWkHGYt3cdA/VVg3SwJE=
X-Google-Smtp-Source: AGHT+IEWoLxfSlaf8rXHfYGdo/dNrMIk3fj9viLQXfHndjp90WcsgvICJeewTTVu5HvfhfYK4N5nnA==
X-Received: by 2002:ac8:570b:0:b0:465:2fcd:cb0b with SMTP id d75a77b69052e-468f8df3bcemr12486021cf.24.1734383849763;
        Mon, 16 Dec 2024 13:17:29 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2e85c03sm31927501cf.69.2024.12.16.13.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 13:17:29 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 16 Dec 2024 21:17:19 +0000
Subject: [PATCH v5 5/7] ACPI: bus: implement for_each_acpi_consumer_dev
 when !ACPI
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-fix-ipu-v5-5-3d6b35ddce7b@chromium.org>
References: <20241216-fix-ipu-v5-0-3d6b35ddce7b@chromium.org>
In-Reply-To: <20241216-fix-ipu-v5-0-3d6b35ddce7b@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-usb@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Mailer: b4 0.13.0

Provide an implementation of for_each_acpi_consumer_dev that can be use
used when CONFIG_ACPI is not set.

The expression `false && supplier` is used to avoid "variable not used"
warnings.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index f38e8b1c8e1f..68c0e2fb029f 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -1009,6 +1009,9 @@ acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld
 	return false;
 }
 
+#define for_each_acpi_consumer_dev(supplier, consumer)			\
+	for (consumer = NULL; false && (supplier);)
+
 #define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
 	for (adev = NULL; false && (hid) && (uid) && (hrv); )
 

-- 
2.47.1.613.gc27f4b7a9f-goog

