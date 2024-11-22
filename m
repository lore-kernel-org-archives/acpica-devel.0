Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0C91DDC24
	for <acpica-devel@lists.linux.dev>; Fri, 22 Nov 2024 09:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732268906; cv=none; b=PDi5uUodv05Q28qOQupxbhu8CJqLViA/emd3qEpbh4aYIC9NUhpA0mtFxHW1yadN+htJsOSjtV/hMB2KGAXCckr1d1ZlbsTo1I4P9KR2Bx7LipNrZVF4UCwf8enaNbzCEe4g46UxlzZJqNpQ3HiHSfzzE2cWf7O8BKYSEMCPvD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732268906; c=relaxed/simple;
	bh=s/RFQ8hC9e/8cn1SLTw55cw7d/tVQKC4RIk8exh03Y4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MXq/rmrOo4K1jLSgdKSdp2h2fQpd+0Mvmzkfaq6xPAXTkXbaF8hFSv1P4WU5yrAdJ4wRz4bHWf0SQcjxUJK3xK+10V+Po8OvUgl3V8vtasORGnM/hhRpzy6NyzXT/Wnq3ruU+cmY9/CY71ZAD3KHfsZufMBGHh/9JOVvZQYD+hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FvyIJVem; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FvyIJVem"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4609c9b39d0so10329751cf.1
        for <acpica-devel@lists.linux.dev>; Fri, 22 Nov 2024 01:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732268903; x=1732873703; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zG7I43DMEh4GfUqzQUdimZGvwsrcdmhPZLNEbgcg8ic=;
        b=FvyIJVemtfRHM96wm4YJKq3QED6W94Ky67BNwl9aasvSZ0MFgt5Vw1YACGudPvBAv0
         JFPzwf/CSDs7PRSjwj4c3VyPX6ZObTDgJM2266qLUlLIIEi/1QnUkCMb152Afb5RCe0d
         HZEvZONmDnkrxcJi+SY7HpjNrM2bWwL8L6RR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732268903; x=1732873703;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zG7I43DMEh4GfUqzQUdimZGvwsrcdmhPZLNEbgcg8ic=;
        b=nfoWLQAb83/ZpBcArV4kTDicK11IXqwERmwl2GeW61xv0bqF2nCxo9Crx88X8RJgWz
         JpqDqMqs3+sbe6vcJsT1uWsD75FqrPhj+BEqY6PSF7ES7gZnpjBRRyrL3xlNrcH7e4GY
         iMtInTxvjZAqPyODVY8L5EcdFfV30iyWi6tEinESfN2cfoN6yjZOp91YoXKyAuFW7qRJ
         a7ak0FyQ30z6FV5LUU3j8o9XNjBip9OfREhDXvRQNu4AOhhaxWk4buNQcQScWsvNQ8u1
         HJ0xemX7UYa1zk9L87xPJwD1knuKWgSLCIC9cIEGZBir8mguB2+QmU43Zp1ZjZgYFRa0
         v7Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUTSg1Y0/6GmSCuhUZ0j47+gzM3jSYNPxkV4Lk97yE5OaPxcgo4N1ZewqYF3AUFy/32kg4jllYWgoYsmg0=@lists.linux.dev
X-Gm-Message-State: AOJu0YzielRoGOQCeKqoNl+IlndCtng2O6ShaUk09IwICMtSNLppiSKn
	JAt0luZzozUOeXIarDCcwHjgXL7fjV5oIz+Uicqb/8O5rYwMFgDLl7oYiVbeuA==
X-Gm-Gg: ASbGncsjvqRcfEvE/K0dxsxF7XTWaJUUUC+01BUlVaaBKLWxowmdVrV7xVtY1fgb6QW
	tBVaFiADTI7TgyXWD9W3mgUA7wnfAugRU3Qjd+IOe3T0ryI57U7QpUrS7TQ9K4SqoZ1cA4pes2x
	B6n9VIAdwoeWN1yEK2TGhgkrZIafAfZ3W0jrBxS6jACbRzvC97hagC5B8EfCyNHtWC9HNs41t8o
	TRqEzwfDQ6FJiZ1q0Ob9DeR5ABnKmDNmZ/OPkraH2409rW1CiglmEoln8dyHdIS0dJm3F0JASZD
	tmCWnBFbCWzETPSym/Q5V4ex
X-Google-Smtp-Source: AGHT+IGMlQYEruhIl1CbTQvmldwCNjhRHjn9f7tEPvnZRJBnvQVCS4h0diiDqwqoJ+Hs/FtxPNpzMg==
X-Received: by 2002:a05:622a:5919:b0:460:c2f3:7343 with SMTP id d75a77b69052e-4653d5af2dcmr28382081cf.28.1732268903212;
        Fri, 22 Nov 2024 01:48:23 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c47f124sm9282731cf.62.2024.11.22.01.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:48:22 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 22 Nov 2024 09:48:00 +0000
Subject: [PATCH v2 3/7] ACPI: bus: implement
 acpi_get_physical_device_location when !ACPI
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-fix-ipu-v2-3-bba65856e9ff@chromium.org>
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

Provide an implementation of acpi_get_physical_device_location that can
be used when CONFIG_ACPI is not set.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index eaafca41cf02..4888231422ea 100644
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
@@ -1003,6 +1003,8 @@ static inline int unregister_acpi_bus_type(void *bus) { return 0; }
 
 static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
 
+#define acpi_get_physical_device_location(handle, pld) (AE_ERROR)
+
 #define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
 	for (adev = NULL; false && (hid) && (uid) && (hrv);)
 

-- 
2.47.0.371.ga323438b13-goog

