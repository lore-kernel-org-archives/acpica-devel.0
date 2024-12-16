Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1FE1D5CC7
	for <acpica-devel@lists.linux.dev>; Mon, 16 Dec 2024 21:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383850; cv=none; b=Zv1CEtdL6/5VkoRh0alg5KUg9alv3YRkvslTotgYWVjGCV/lQvIBtFxEermh4KUUDDcjPXwsxSvTofMX6c28IKRB78MmSqxDDIy7CWFK7jfNyUeWKRRArpAGhNv2xeYH2HnBIiaEDIwsbbIJHFYf1TFl29hCfqhfVHoGgBxBilU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383850; c=relaxed/simple;
	bh=X32i657SSLdAHHKEkAbumTOxZEIg1B0mwuSYHOFYedE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pJSXNDmksPWEI8m6f3n4qc+tP45F2N9YjCmB+YGIIYMZk1ogG1FI2nE9ZJUKywLdRQ4jbGAGIR33GOaeV0oVfQzYFn7+FaW1Q9ANTl9TeLIIytsO/1cTOBwO6F1ziCKvRvQK7ghzi9BIXpvysCYkRMOvP/459cqzC/LbnoQyyT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ACl4sfWE; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ACl4sfWE"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-467b086e0easo16651651cf.1
        for <acpica-devel@lists.linux.dev>; Mon, 16 Dec 2024 13:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734383847; x=1734988647; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WqBBzZFuR8Mx+keH2/BU5geK8A+jljM9pAiu8cpH6y0=;
        b=ACl4sfWEOg/sClGz9xBCVvffyVHXv5TeXRdOt3TMVqzg0MCh8VDUtbaX7F81Rb6DvY
         hLwXaFNtJV09xmDq/b6OGGwtm6cSpbXYZ0Hh3rbf+zYcXODV0YQKmR4xonQUkS/mIng9
         ooOo+Ovh0h6JdzVy+duRx7tN+5FeM8izMKK+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734383847; x=1734988647;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WqBBzZFuR8Mx+keH2/BU5geK8A+jljM9pAiu8cpH6y0=;
        b=bhqdlnWmZaHNf2lpl6kcpmkw/dTAVog/66kxXzWQpCaBK8TEMA0VgKdYohkL76PECE
         e+I1nfs4lRg5q1N/vm2009/MqdM/egora+53EKXPOSRdBQUlr+py0s9rZazebL1yEMRM
         +GcBRL8ScDCa7f69aKN+i68P/jTSNNbYQ1MzVHikKzL+aPJ6SEzqPKWWyD6sJ2d8e4F4
         y/CLNXn5r6n2S6ezDqgB1+GM1H/mV9HVBszh9F/Rfp/F/wrw9kTrwv9nJFhETCvvMQ8q
         8lATAGJn2alYXl8c/ib8Vf8E0z65g43+GBbKVlpzaNLvcoy7Xndg8/cik0VMgXAM120w
         XdRA==
X-Forwarded-Encrypted: i=1; AJvYcCXrTjCl2X/llAX3P7jgcMsFw4MI3IxjZ9O8hhXu9cA5IBJIv1w1NHyyX3QzIYQ/UWnah9hvAKUW6KzOU2c=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1iK2rFh7mrRzArDhbT/8tehQ8F9qyXzW+/VnhH5nYLFpWOj/S
	NJqvVhlSCVsg7xyTKG5vwIJNbT2+xeveo1Cog7cyTOFiLOyOh1ZG4jkiJbm4oA==
X-Gm-Gg: ASbGncsq2sVWgq2t5U1+1jIRaf/ytSrbNSYyN2zvv6FMEy1obc0CepoWMZ9UH7koMrn
	uLKSh2dQt6dMJL4/upmvPcwm4qHflp9VJDWEOQp5MCnbJPMgUMjShm2AKQb7VmtMH1vEgeLTmHL
	dw4UKaWo1A7wUHBAkVd+d4xks0V0i8tcEwOMCcIP2BUl3MqOlQV6v1Y77+I8DZeA6hqdloiqrA/
	V8dsLNxuMJh25jwxn1FUS7e6B7UCg6eYPoBZFUhpMezW0xkJ1C80HoWzjiFd7XWefDdL2RYI329
	/YjCpJ6tPjFdzSf06vfzD/OtsGNLt/8=
X-Google-Smtp-Source: AGHT+IFa0lE3VU6S7yMTSi6U10IiAbRleFzkYam8wiPnIWkXufZo9uMrtys/YCrx+kHmkm9mMlGHjg==
X-Received: by 2002:a05:622a:1aa1:b0:467:79eb:4a16 with SMTP id d75a77b69052e-467a5721b4dmr271093651cf.4.1734383847705;
        Mon, 16 Dec 2024 13:17:27 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2e85c03sm31927501cf.69.2024.12.16.13.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 13:17:26 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 16 Dec 2024 21:17:17 +0000
Subject: [PATCH v5 3/7] ACPI: bus: implement
 acpi_get_physical_device_location when !ACPI
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-fix-ipu-v5-3-3d6b35ddce7b@chromium.org>
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

Provide an implementation of acpi_get_physical_device_location that can
be used when CONFIG_ACPI is not set.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index a9b5a5204781..f38e8b1c8e1f 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -43,9 +43,6 @@ acpi_status
 acpi_evaluate_ost(acpi_handle handle, u32 source_event, u32 status_code,
 		  struct acpi_buffer *status_buf);
 
-bool
-acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld);
-
 bool acpi_has_method(acpi_handle handle, char *name);
 acpi_status acpi_execute_simple_method(acpi_handle handle, char *method,
 				       u64 arg);
@@ -60,6 +57,9 @@ bool acpi_check_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 funcs);
 union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const guid_t *guid,
 			u64 rev, u64 func, union acpi_object *argv4);
 #ifdef CONFIG_ACPI
+bool
+acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld);
+
 static inline union acpi_object *
 acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 rev,
 			u64 func, union acpi_object *argv4,
@@ -1003,6 +1003,12 @@ static inline int unregister_acpi_bus_type(void *bus) { return 0; }
 
 static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
 
+static inline bool
+acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld)
+{
+	return false;
+}
+
 #define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
 	for (adev = NULL; false && (hid) && (uid) && (hrv); )
 

-- 
2.47.1.613.gc27f4b7a9f-goog

