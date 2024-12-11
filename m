Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750FA1DDC2C
	for <acpica-devel@lists.linux.dev>; Wed, 11 Dec 2024 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933249; cv=none; b=kZk6WcSSGDV4Z69vE5vjRYDdCUN6bb6yM0awaDerw5q11gyB1nVTuHRtAB2ZNJ8AlubfpLobKkhh6/E8qtJzWI6hz1i42BjoVufI/qx14Bb3e1Jx0JV6vaeIT0V4MiWKHiJOBaU0TEvI9QNd3JBxLTxmYexcj8b9qd679BWpffM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933249; c=relaxed/simple;
	bh=9zHOmlSE2lBt2Rpl8UOox++hLCi27/TryYwCxVSnPew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n4vSJlO8I0A+4B2sE4/HfWEK2L+ZGrGRcklLi6msyPGEpK20+KL3U0Ntl+z6lxONE8bLFdFHvnSAEKVapGb43tM9Z/vaaEJtkgNEflQWXDcJ2zqz7YHlr8PG4nVP+z/C8K8efZoFNS2/y3/D/DjwDwzQUlL3UoNeMpy5uUBIKkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jhOjoeuH; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jhOjoeuH"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d8f916b40bso59096986d6.3
        for <acpica-devel@lists.linux.dev>; Wed, 11 Dec 2024 08:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733933245; x=1734538045; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MMK9uUImiu6io0KCKsugDZpWMzJZHLlDJZIO+NA/9Ro=;
        b=jhOjoeuHEOfQDhZHCpR4BP0fol5EZa0MOV8Ev6Dlk9NLX0q5NvjNx5/Bq8Ty0LN5DP
         UINZq1I82v3bh/2dddpbebdY6P4vg2X//czHIGLq102abwAQeqME3P+77YjjM7zZ7iwO
         tTZI6JkLO7KR0CTEAqD7jEBbUS6vFujY87OUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933245; x=1734538045;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMK9uUImiu6io0KCKsugDZpWMzJZHLlDJZIO+NA/9Ro=;
        b=TtwaeM6FqorZ9L6phXNi/yN8VQ4pWD3daYUFWmrf0r802DzSbJvLnr4CDIiHNW54Ws
         /dihW9E/uTVAtTgM6hEeqnALjxFUnzHCmfyOxsm5lDc8xKcBEvhzQuk8EsoPwuCQtHBs
         oiPcJ7nc8+ENNnqIT0ghAHSsCB4C/JYBSU5dQh4FI4oEljZ+osDIL8zu14cyt1nVLn6c
         fSQgGm0owoshvDpvyU3+e/eI+ws9BvpjFR/shMusdxlXUxrJ4eCI7uVbgRKQhvKZq55M
         MSh7Re7S7XZlEcQ/jjsOw8+3M/dfKr2PXkqb0T8JyVUtvCQWJOTCjSVhVHkeHoHC278i
         StHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWtL6SC9bLtnz1HXsaTf81IYOfnyFxAmv4coEqLNfsmBuDDafx7OWiAtd3avkxO/iamku7Hx5mzj2dzlU=@lists.linux.dev
X-Gm-Message-State: AOJu0YzSoJclEWbRXEn9ECpjby4sthVizrH7TAcebIR9txY42H85Rsoo
	4mVYj/87BWEMBr6RStranfzYJU4VRDy8iMaPo7keC6i65jKB0uBxSDgnDWUorw==
X-Gm-Gg: ASbGncsWu+QWiDXFcoSn9/77r+hfCHvZiA+E149j1m0UXq5Mmbvn/n6LyOQonApBIJ8
	Tg0jbyFHxfOBdx3Km3NdKJJTODVZztuBR4mLM97TPMZG0/aGhpvTnaNfdssEx14z+aOPbYYbLE0
	9tyZsuyNzhtsV2gWEqYovmJ8gVn3HVDenKNsMh6GODMOcwn1ScNqclkQPiZfxTWOG95oVG7/y7M
	aP3xU8Go18qnZykpYz6eoFesjWFdFfDIbrftmB2rAiMIf4p+g6ltF6ZaOodhJc/v0mS9vOGL6IZ
	EeYoDJU/VlSHQ1hnFV+Yn1bzuisk
X-Google-Smtp-Source: AGHT+IHPKXKsI2zaWBcy93AAaoxDDsJF4jn7MhbcckWqatjm8Z8ybpD/fk9DT9vAC4RVxmtKnQPx9A==
X-Received: by 2002:a05:6214:4106:b0:6d4:dae:6250 with SMTP id 6a1803df08f44-6d934be3d2bmr58201826d6.34.1733933243809;
        Wed, 11 Dec 2024 08:07:23 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8daa00671sm71484946d6.88.2024.12.11.08.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:07:23 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 11 Dec 2024 16:07:20 +0000
Subject: [PATCH v4 4/6] ACPI: bus: implement for_each_acpi_consumer_dev
 when !ACPI
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-fix-ipu-v4-4-4102e97aceb6@chromium.org>
References: <20241211-fix-ipu-v4-0-4102e97aceb6@chromium.org>
In-Reply-To: <20241211-fix-ipu-v4-0-4102e97aceb6@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
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
index b312a72f48ad..80ddd76b3a6a 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -1009,6 +1009,9 @@ acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld
 	return AE_ERROR;
 }
 
+#define for_each_acpi_consumer_dev(supplier, consumer)			\
+	for (consumer = NULL; false && (supplier);)
+
 #define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
 	for (adev = NULL; false && (hid) && (uid) && (hrv); )
 

-- 
2.47.0.338.g60cca15819-goog

