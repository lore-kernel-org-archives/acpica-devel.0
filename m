Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1161D9688
	for <acpica-devel@lists.linux.dev>; Wed, 11 Dec 2024 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933244; cv=none; b=Y/FsEjoZNvgB6PkZ4Dzed1xZiS8P9Zqq0N/dtOhXiiW75rrxnQ5V79LU05E1ybCa1+KUR31ghorKoaJVigbbEewK0J8HyWVkvYm9IoZOrvrJa7XGcLXaPe/gUDzzBYw8NXfljV12Aqk+YS4D1k7kH7kTiyw7jLR3F9ZRNQ9PZeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933244; c=relaxed/simple;
	bh=Kqe+G/l8nHfp8psC13t6cysIquELOSvwbRiUrehr9ww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hrm5bXPuopxPSCbpg9lyw/uXdPmV+bh76v9MXc5FBlJsPJoWHgHOkGVBCd/wP2SlUHVGDHoZDryV7Bso6qE3mQa+Wl/Rg81B3vNRmC4MGuw4aWzW7RnjKO0i7MPPwd089G0D1rAKLv7F+f2gHCoVgLiM4tItR0nygHuqRLlh2zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DKZEydyX; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DKZEydyX"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6d88cb85987so7415766d6.1
        for <acpica-devel@lists.linux.dev>; Wed, 11 Dec 2024 08:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733933242; x=1734538042; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RT3f5Gb/3D2wa9sLrS99ud+PgqVP7v8K52z7Rn+R4vA=;
        b=DKZEydyX9FvcyxJ9jKb62s8oCpB/ieMV/insSu4J0Pq0kc3jPa0rfjMZ21cbIwFywM
         dTpFRHadUg93/7gfG9OKHt+5AQlBUcBAkV+Cq0UMEYNCMy+fFv4yAdeT968zVZiAP8h2
         G3AGxl7DDTM712+3gFzJsmkHYDci2npTxYup8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933242; x=1734538042;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RT3f5Gb/3D2wa9sLrS99ud+PgqVP7v8K52z7Rn+R4vA=;
        b=E1YIQ1z2HKJZqSxaZMmGPKweA/5w5ePbCwi/nfyvVcrh/7c7UE/PMwGw18u4MBdIaj
         /eCdhUF6AWwUtxkuXP543rBZNO2UfXnXQvfn5VrFaB8b0MRXJFH17x5tEj05kvyw4uW5
         twHU6U3cEz1rwWhk92rcxazmWEQ+MOe8F9hOGL64X0Y16i1RWUG6A/ZznlPbD+5PNwcg
         N3Vt7Q+Q2qQaQZQAwmxe5VR3hgdSP26zWf2PCFMt0aqPxfQE1gVRj/YDB6wg1V9Khg0a
         rwhIbHUI2XxMIBJQtnRPZjtM9fHh7UobyAK89BxiYAgl7hxPmQ3a8qouOTX2G1JjlYj/
         8xSg==
X-Forwarded-Encrypted: i=1; AJvYcCUve5F7nQZzTDtEmFv6vxm2VqrxmINeWkrP7yG6PnF0DC6nSaVVFuyKcH78N7JH72Dn2eN5Zli0Vk5DuRQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7OslaU0DTZ7c4Povf3h3b+8ipu5crh24GTIR+dGFYKpDGPjT8
	ujCJ7S/0jJk+CqtPL+B/586MKao03mLKKG46vKluewOZBl41CSL6oOhlDSxURg==
X-Gm-Gg: ASbGnct9c+QVbMH6pacfpmfy2FUAoaFvfROMkiks/BkwGfjVSXuccbscB5umLCrgeDJ
	y8+ypIZmC6RGvPnPQUg0uxoFNLg8Ymq6nLP+1VcwfPlG85YjvhtZMI4Xk51kVyrXNw9+hdN6Y2j
	CdJA3/UQ7A7ovVHEIZckAhb0lAmnSfIkoNZuo1mnj0dIP5ZOfR5vSlWAQk8MJNJ++zrqOo1v8fx
	Jle7UCI4tluiubRtx+8cdAjQDbGjGBKbXy7TkbqtHzZSesDaHPWxDgHwwceknbAJcED+9AZNwtN
	RWN9O85vg+45t23bkFoClHsPItS6e0o=
X-Google-Smtp-Source: AGHT+IEtktKFv3qaTtZ9OL5m9Tz4Oa3HoUJP5EJ7WrirQArVIj8ul98ZYjRW1cJOo6oehSupJehWdQ==
X-Received: by 2002:a05:6214:21cc:b0:6d8:b5dd:7699 with SMTP id 6a1803df08f44-6d9352f1ce0mr58803916d6.17.1733933242384;
        Wed, 11 Dec 2024 08:07:22 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8daa00671sm71484946d6.88.2024.12.11.08.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:07:22 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 11 Dec 2024 16:07:18 +0000
Subject: [PATCH v4 2/6] ACPI: bus: implement
 acpi_get_physical_device_location when !ACPI
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-fix-ipu-v4-2-4102e97aceb6@chromium.org>
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

Provide an implementation of acpi_get_physical_device_location that can
be used when CONFIG_ACPI is not set.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 2b09e513ecf3..b312a72f48ad 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -43,9 +43,6 @@ acpi_status
 acpi_evaluate_ost(acpi_handle handle, u32 source_event, u32 status_code,
 		  struct acpi_buffer *status_buf);
 
-acpi_status
-acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld);
-
 bool acpi_has_method(acpi_handle handle, char *name);
 acpi_status acpi_execute_simple_method(acpi_handle handle, char *method,
 				       u64 arg);
@@ -60,6 +57,9 @@ bool acpi_check_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 funcs);
 union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const guid_t *guid,
 			u64 rev, u64 func, union acpi_object *argv4);
 #ifdef CONFIG_ACPI
+acpi_status
+acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld);
+
 static inline union acpi_object *
 acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 rev,
 			u64 func, union acpi_object *argv4,
@@ -1003,6 +1003,12 @@ static inline int unregister_acpi_bus_type(void *bus) { return 0; }
 
 static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
 
+static inline acpi_status
+acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld)
+{
+	return AE_ERROR;
+}
+
 #define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
 	for (adev = NULL; false && (hid) && (uid) && (hrv); )
 

-- 
2.47.0.338.g60cca15819-goog

