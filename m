Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3565228367
	for <acpica-devel@lists.linux.dev>; Tue, 10 Dec 2024 19:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860577; cv=none; b=SC/qWUTUvVulNFbAUmx+k3T/TpTBPVrzq73LhZ8xEjvntmaudPjfI2uyNwPucRdfMUjswA8wTvmz3VHbTvrutHV+ZHlYZON1fLDLjILJ6jOf6FUo+9FH+LoQW7nIj0J2bb6Vr0cAMZh7pXtA25/KHyZmADyUoUmFuU5/JMlt3Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860577; c=relaxed/simple;
	bh=JEumEao6OwtFIq3N27scJvmQPpmiw+AAjw5tpWVO+jU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GkOIFrAL+LLHzUNhBusnJPgx1tNBMD/kF9o6s8GkhDDkp4Bo0ie8t7bZSVbf3R48MlH+zl49h8njIiTr74vSkgXhdAS2GeI/4nnQNB9A6mdnIqC2vjOhhG1N5OLAySPyLFd7ehG8uHIky2pouybAGQUi0WsrnT7r1FkC3/V0uyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X/pwYkHi; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X/pwYkHi"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-85c0fb4b437so3059076241.0
        for <acpica-devel@lists.linux.dev>; Tue, 10 Dec 2024 11:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733860575; x=1734465375; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/FC4QnqJ94HTxVX1/4qkFrZziKxV3eN8ciCJ+f2BMLY=;
        b=X/pwYkHi1jRhqzjHtDwfUJWu6tuW2hQUrgReyxKZajM+yB1twvwn/5hKXmRWevswia
         pCT6jqzVYOHYj2HkkwcIJ2999hnqQJoq96UJmWqOQVLH+D/mfCMceL48fzyCFqy1opXr
         wKw/cSqh21fsmnZsKGf84KxlsnUcCjKNfhbYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733860575; x=1734465375;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FC4QnqJ94HTxVX1/4qkFrZziKxV3eN8ciCJ+f2BMLY=;
        b=De3nmbP8f03aVIhj0WjaZcqq9bIqHuU7w2z4vLv/DLOIHqhD+3U31w06VIg7XA5K1y
         Vk8B5BtbGtlTSMb6B2+xrY7sNynA2IC34g/TNMkj+n56EQGkAyR5PgDYyY9VlaEiZs6R
         jLcZIKwPN67r/a7TD9yj/cKTmdSHhoPkbGYqrW8KR6U3Qtqgf3e3lXyvkhP3nRIxB6rv
         ui0CoDz9z1Wx5InYmvp0yEf+pCb62fKz7vqorSrRtq9MpbFQYcnl8TuKrk2KUd3adA5N
         rT0RKByJ/VYVVH+RoFQbPbPtYkPVYhx303xUCs1WvrQP4eP/ZQ6n0H4MVZso9tibHu48
         F3fw==
X-Forwarded-Encrypted: i=1; AJvYcCX93p6Sovn++hwKrIWXm6XG2w74EMX4HLhKmh6Wh9j17G+6OzbQn6qjL5TvNZP+Q2D/csW5wBXQYy1dXXE=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8TAGtOrEAH8/BAxOETPx+wBo5Xhgm4XWOlEAdZtC0ayZ/CqA0
	+qVDWaN/zfVz1ANL9h6n22F2mI5kL3DCMzc5aLz/CsLN2GkytMlCkxxsAkwMuw==
X-Gm-Gg: ASbGncvBNeKfGxYAQTJjwIlHFCelikADtAnZLefXwHkBoMeFZchp/jLWwALakWcPRQp
	FpmyJZjqT7pQeJut3d1mVtQVLtI1AaBWSgwyMzio3VzFObSrFTtK5IdZbeXc/TzUtGpRxnaVogF
	RABLcFyP9QDlV1WngqgGRRtrh+VJ0Ll9vttmuM562EdU1OEII9l4jo+9nZtZMv/BOBN+TXPJf9e
	YByTW7ilqFB2ml9+8LVkHmxqv6e2ce3HxGpJzBDeubkTR1FbZg0TaHTMQd6yizkls6q28dWZzFB
	d9PtkHf2zuiG6lcxbpzBGWZe4DxX
X-Google-Smtp-Source: AGHT+IF9huJ4RGbON6vnfjO82QKXcufJ1oPqeqqPWduurqVjnR4pau4FlzjogA7CTu3zPtWKx5FO2A==
X-Received: by 2002:a05:6102:34a:b0:4af:fa96:1ff with SMTP id ada2fe7eead31-4b1ca3daba8mr12220137.6.1733860574875;
        Tue, 10 Dec 2024 11:56:14 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85c2ba7dc70sm1279522241.15.2024.12.10.11.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:56:13 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 19:55:59 +0000
Subject: [PATCH v3 2/7] ACPI: bus: implement for_each_acpi_dev_match when
 !ACPI
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-fix-ipu-v3-2-00e409c84a6c@chromium.org>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
In-Reply-To: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
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
2.47.0.338.g60cca15819-goog

