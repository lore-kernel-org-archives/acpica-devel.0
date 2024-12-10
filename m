Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134CD228388
	for <acpica-devel@lists.linux.dev>; Tue, 10 Dec 2024 19:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860580; cv=none; b=PS5L+ektBWiWP11X57CL6hYNxlNHfacNoUwqc7UNlTmcVrvHPa12mzndlaECBOpWlK53kTvbX8Wg0DuKtCrVfyLOJ80lIQICzp828d+RMnHLrL0RdCBBZ6UgFKogP4TDOp2/5fzStIlTE3XXHLwXlhMx199LFcLkdvcYiYFxVuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860580; c=relaxed/simple;
	bh=chc2biaIGBXBwkFrS62DYUV3DrLJW93SY6ROXf7O2qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E88UEsq1txRsvQ1akFjuFWiwqSstyZLCh2KyjiKK9+WN/icfRHvwHqHDopP+g2+Wqnv343zv1GEJU7yZL6TJKpb9+cCLiu2nAKK9jLLgRtCacUNdgA+6M/n7Y3WGqs4UAqy1aiqc8b1StSksJiHstIJCw9CoTXrGlTBMHKO/ZTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VxeLJ392; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VxeLJ392"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-85c4b4cf73aso997580241.2
        for <acpica-devel@lists.linux.dev>; Tue, 10 Dec 2024 11:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733860577; x=1734465377; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ipHTgEYnJA8+ZRCN0225YuFAf9jLp2OjhxHNBjpqWmI=;
        b=VxeLJ392HorP1MUj+zo8z1CW2aDs07YVxURScZm0nQxPgsJWBLtpcW4SQkVMVpBH3G
         kK4XgnyhQE0DFbaGZ/Op0Aue6kEMUFOZ22qV2wP+GRf414EbSdooN6QLYib8M8qFLQVw
         hPMnKevhXeod0Kg0nu34Yh8aeUDVmGOumktoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733860577; x=1734465377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipHTgEYnJA8+ZRCN0225YuFAf9jLp2OjhxHNBjpqWmI=;
        b=GsfcdHT4UD/RwtD0tHM5tShh1RirD9WYX6wy6GuGsBuxVdhUgvnXTXGuAxit80yprq
         lpn8/2CLiseyY7sRT9shpPHnC+6xmET/924iG/joq1fhWiObFcmdBS9t0G/Bcy90Ir5I
         js32uu2qxQ9RAwvR+5XvZNd8uNJSDhExLpjFEbhvpsY8FuaadpNtfLkPuwfd1SREgRRP
         NdHXXFyKPSK6cixk2HbxAy8QEZKap6FKmBu9hdC31wU2NY4AW0W9MJo1OHaBeKvU6Fuw
         zMVfnuvFPo88XAy0T4q0W1EwU6bmfewVoq42EJ354/cak8NtlL7WUwpDH5VSlpVGu49s
         c/TQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxEaA2QPD51P5j92eRVO4F5NCJmLhDtoxf2Fg3MzfEJ7RtomQOWQ9mYrYSjXSteTTyKjraCKu/jzae344=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxn3nI1xY1ZyMdTpJkwcp+qHFVChVCd6Ci4HiwyhwtrpbE2D0Vj
	YyeXljg9By/+walPkzQDxRTQHlGh+OdnT0GQsgiCvTfq9YpfJvi0X6A9KONEgw==
X-Gm-Gg: ASbGncs6/rBg+kUCDT95Ck0alIDQQENDYu44IHjsPZmZuikOSocVEEsTPwkrmRtvkH1
	tuwyxS9mVoUEbSs0s/lDoWPKSxBg3PRz3lO9FMoV/ChS52V4VnMpVWPAGx8sPpKd3/MKq8ioVFz
	yLfc0H4zoPkmKF7m8b3IpMKrBuzHFW5sM3r0lU+leZ+1rtX6cmVYsBlUxWETSftyjB5BuYQMVAq
	MdS4NtA93hMPbge5w2KfX1j9lQLO9ypCTpnbThM1cTUG2QCbPEnDBHX5mANHH5F7FUTa946bxgr
	VQqYP8RDXrgRCIeGjZhyDkdXJfWt
X-Google-Smtp-Source: AGHT+IH0lF25QvlNGwotiz6cjbBqZqy/AoYoxDEDz8EsANwxf772+wFf4srhmhHPIWngtFbdyB/avg==
X-Received: by 2002:a05:6102:d91:b0:4b1:24c0:4274 with SMTP id ada2fe7eead31-4b1291af18emr998015137.26.1733860577115;
        Tue, 10 Dec 2024 11:56:17 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85c2ba7dc70sm1279522241.15.2024.12.10.11.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:56:15 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 19:56:00 +0000
Subject: [PATCH v3 3/7] ACPI: bus: implement
 acpi_get_physical_device_location when !ACPI
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-fix-ipu-v3-3-00e409c84a6c@chromium.org>
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

Provide an implementation of acpi_get_physical_device_location that can
be used when CONFIG_ACPI is not set.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

dasadsd

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index eaafca41cf02..520f12155e7f 100644
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
 	for (adev = NULL; false && (hid) && (uid) && (hrv);)
 

-- 
2.47.0.338.g60cca15819-goog

