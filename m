Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2281D9320
	for <acpica-devel@lists.linux.dev>; Wed, 11 Dec 2024 16:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933244; cv=none; b=uWV4F5ckJ9IqI2CygaKE+Aq8RBgMSjYbpo/+dmCy4qtAaumq/hVjg/Z0Q7wSr9QbbPepUymu86nla/ZQSLyyyyYpG2LN6mE24csZqk1Iby6T4jjCDMiLvEHPkTregFHowwO1gx018WXfFJoG/IrBDgDTpoLrvpDK7gw7QS6yot0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933244; c=relaxed/simple;
	bh=TqounAX+K+Jxvi8T1JjQIXGiJfX2iNkecKUSnEv++60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z2l3N80JECG1fnNPfztvM3dRLClPh/tEYq71yKpwDv8NqJcG+DkPmUDQ9MJzVhcymFlCK41HiCsNJFng4A5WF/Bz4guwsYg6N+JnDCatz2PMm+0DjlV1NOT3dgTo+pbIAYJppJN/f6x+zCGxcrv9lV77k/JiNkacqHthF0BgQao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nnq/yThA; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nnq/yThA"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d933736380so14268546d6.1
        for <acpica-devel@lists.linux.dev>; Wed, 11 Dec 2024 08:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733933242; x=1734538042; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNCYhbk8lfVWYHW/bT6mgb7P6pux9ucX6tRFgaMr2JY=;
        b=nnq/yThAhnjljZFD5a2q9XUi4IP3nKVVLsEhCu94ui16elSYf7slJfUDfcGpdujrec
         6QaDWbtQsTIK/0vm2yABHIrlvf0N4syqITxi2CpSVXPUBW7qdzR6OQcJdI2QA426waT1
         urwRrl8MuqvwF6q7r+Amn7b8ZA9ywZBdKUGAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933242; x=1734538042;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNCYhbk8lfVWYHW/bT6mgb7P6pux9ucX6tRFgaMr2JY=;
        b=HseHafTKgsqG/NsPa5nLRfTaWcVki8tj5XeLCXUZEL+JuYnOuEbEJREsdk8LzKxwf+
         KJrGw3MDm/RiBAdgNnqy/nvss/puiHmEgRzs0XgsVRZxQTP/po+Zy+GhLkL/9RKiElqa
         PqMReiyqK3MSpQgklFiKkorlrUWx8QbM4RISvytWq6Vbnjm8d/+pwtwUK9CRPZjPIVMr
         yXB5BmWvtazydhHJO+LlqOa+Ccas+g4WtwvKzRth39D7wujHW8jzv3+/NBEyx2gDaord
         d6RLgVGhBV0Fl6Zi4BEqxwzndJ2AD4eBZcOKgu7p2oTyUSxajFu6FvrtWN+U8RHW124k
         vTPg==
X-Forwarded-Encrypted: i=1; AJvYcCU6qDGzAxSX1CftCfD6KuzMXz/PLgLmAq2Mih5e+CcQp7/4cyD+Lb0A9yzStu44SiWMTzHCA2Sf6wOHh8k=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+QiG37t56HRV+pYhXuqRnDX80PqkNOUdG13gViNxaBnZi0DSN
	LvQSUME3escwEA7vvNQTbxzsA7DLhhShmMBvQ7z63PGJwny/GamqFBb5eYyNPg==
X-Gm-Gg: ASbGncu9S3ViNJrH0ea1ErkYbXvR0bS7bRQsa9vgbRs7VoOQWTR509dJPv1i2MmKurq
	9iG3MfGuqhFV4ULai3G0KCHvZFSfIfO9ojlRCklAq96dT0JSwd3akvlV2ur9oA9LkgXv6hdSk7/
	94wxFDMrpiGLfhgfNA6EvE0N/FJoXWwxtJug4lhD7HKk5HbV7QbztaScMm6AarF/UqYMB7G53LZ
	J2nQI5V0C/9GMDgQvehIidq5i4lRXQ3ueY1l/bXjtB6OLsNkEEZySgfmpAx89i9kJhdcKdGvP2m
	K8kWQZAGlN7H28m8UtYwwz/M/3D6
X-Google-Smtp-Source: AGHT+IGcc3JlLT/wu+C4rWFjGmYrf64CYVGHb0Do566/dBbbYn4TQZbAD2UV6tNA4A7JWCGBQjJOYA==
X-Received: by 2002:ad4:5f8f:0:b0:6d3:b636:eccc with SMTP id 6a1803df08f44-6d934b1cbc1mr64900806d6.21.1733933241771;
        Wed, 11 Dec 2024 08:07:21 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8daa00671sm71484946d6.88.2024.12.11.08.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:07:21 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 11 Dec 2024 16:07:17 +0000
Subject: [PATCH v4 1/6] ACPI: bus: implement for_each_acpi_dev_match when
 !ACPI
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-fix-ipu-v4-1-4102e97aceb6@chromium.org>
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

Provide an implementation of for_each_acpi_dev_match that can be used
when CONFIG_ACPI is not set.

The condition `false && hid && uid && hrv` is used to avoid "variable
not used" warnings.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index b2e377b7f337..2b09e513ecf3 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -1003,6 +1003,9 @@ static inline int unregister_acpi_bus_type(void *bus) { return 0; }
 
 static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
 
+#define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
+	for (adev = NULL; false && (hid) && (uid) && (hrv); )
+
 #endif				/* CONFIG_ACPI */
 
 #endif /*__ACPI_BUS_H__*/

-- 
2.47.0.338.g60cca15819-goog

