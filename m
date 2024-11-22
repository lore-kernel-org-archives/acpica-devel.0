Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92771DD88B
	for <acpica-devel@lists.linux.dev>; Fri, 22 Nov 2024 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732268904; cv=none; b=PJ1fWh3gQbCv1OxKJEp09ZvAjwd3O2+xDKN3/GAC2nd3EWQ4jK/i0eUgCWJIBVMaIJVrhjcroJKbXxATNRYaS26aGOruph40pTjh/Y5Gq2toSiAY2H7YQazGxLgTFgWbOh9BObV04ZUw+MH8lXiaJEAa7zbqIYws/61SQPPYJq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732268904; c=relaxed/simple;
	bh=sHpIqPIcR2Hbo49SEnSkc9fxU6SdQ6Gky5F7X03Wuxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I/qKnHA84PbN1JOE3guR93VvvQsrEV/cagqXzrbI/AhwkkOs2UhukxbnV32BAdV5etrBrFbMr/bkZwXTiDE5RQIt8sliy3UGYGn3FqKSeW6N5r+kohFscamYivmrWqxFxpVjruRea+/eWZ1NTbOfzFj05WkegNdEr34oPQjHExQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AReql3hB; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AReql3hB"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-460ab1bc2aeso11564911cf.3
        for <acpica-devel@lists.linux.dev>; Fri, 22 Nov 2024 01:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732268902; x=1732873702; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9GJCP1X0CqpJdW1fWNKDOtb2VgDbT9PrS/YhQ90tFA=;
        b=AReql3hBnd9wT07YpZgI8XiA0aX5A6y3QmWw4z+NHdJ8CgZmzri8A61STotxP179yt
         NaddwJ672nBwOsF2t6oHKXgoK1sfnFdv4ENz2bpc+dwAkGgqlFuEtDXGLGvJa1AHYKtu
         W8ZPXZMwCjO36Bvv51Aas+TevLWWKhiX5tS1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732268902; x=1732873702;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9GJCP1X0CqpJdW1fWNKDOtb2VgDbT9PrS/YhQ90tFA=;
        b=rHtX2HVsO/LjprjHDi5EfS6ZIM6MEwkhR0/B44v3D+wnXqgTcjg88fqc+TrQ9q1bcS
         tuzq/3JdQAK/5udCz3V7tOnHfLCJw2jE3bt1/fuh9ho3w2r9/rtY2o2ZZrcPmXv1kBbz
         2y7eRTalnkVe2JQq43ImhVK+wYRX29nQhLcgGI5Tld/wmCEuvP1v+FMUeAXFhzTRMIpB
         fG83Eyr68y6ASSgOCvUPsQIlFaQzhInzMRUePZdGEBDKHzVnbl+Q3tbTQbCPgVAePrdG
         sm+Ki+yscLnWI1sk0ySCZbQfUOV4LJhi2Bmy/BQ5kqyVU/ySHo/j7/QLSPSxxlsVNQVR
         cZow==
X-Forwarded-Encrypted: i=1; AJvYcCXiYuVVcsc4SFZkA4yrGRxKW2Ugqml3lOPR49Gdgi43lAlZwJzWEZyqm974fjs7TXbpKtzcsLXpvTl0/ys=@lists.linux.dev
X-Gm-Message-State: AOJu0YxwM4AvNSNpqK8HlPKZ8GyuqPBcjUfxqVJTkpRIyL5zsJu+9wty
	LITRvpp7rPbGcAuAWLdwZUy7sfnuUgS6U46JyP5HEMqRlfkeeHaBPw/A/u7xXw==
X-Gm-Gg: ASbGncvRGxIz5LaMu+B/1TixP1j4WzPd733p0NTXARnoqZn934P6Vr0rEHie0XTJKXa
	S/yFTPB+cSXzJfpWavwNNC34Cel7U25m1QERJV0VcLcEuHvQDFZ9+g0d0ajcxUdn7zLpHeDo2Q4
	qXc8mMy+dUJuAtgnidXQZqTTuOSOdDQsntdPS6yg/H2nHZ7Y9SmLXzEr42SmKwHgA3D3R6dziKE
	ZEOz2qp+SfkrzLgT516gUY8QhrsHuPKLlql95KvQ5Bw7V+u6lutr2mQqPPijieKnKqPe2tBms0m
	j+CLrUm6pWH97bZVzqscyrog
X-Google-Smtp-Source: AGHT+IF2+E7hA5csqndp9Lp4Yhj03h88SxplMlYhJShe/LVL3nGthWIokV9jzsEcGM0TTVk5jNqFjg==
X-Received: by 2002:a05:622a:590f:b0:458:33ce:dcfc with SMTP id d75a77b69052e-4653d62c171mr29716911cf.48.1732268901824;
        Fri, 22 Nov 2024 01:48:21 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c47f124sm9282731cf.62.2024.11.22.01.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:48:20 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 22 Nov 2024 09:47:59 +0000
Subject: [PATCH v2 2/7] ACPI: bus: implement for_each_acpi_dev_match when
 !ACPI
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-fix-ipu-v2-2-bba65856e9ff@chromium.org>
References: <20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org>
In-Reply-To: <20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Provide an implementation of for_each_acpi_dev_match that can be used
when CONFIG_ACPI is not set.

The condition `false && hid && uid && hrv` is used to avoid "variable
not used" warnings.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index b2e377b7f337..eaafca41cf02 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -1003,6 +1003,9 @@ static inline int unregister_acpi_bus_type(void *bus) { return 0; }
 
 static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
 
+#define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
+	for (adev = NULL; false && (hid) && (uid) && (hrv);)
+
 #endif				/* CONFIG_ACPI */
 
 #endif /*__ACPI_BUS_H__*/

-- 
2.47.0.371.ga323438b13-goog

