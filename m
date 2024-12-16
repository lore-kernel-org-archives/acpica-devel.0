Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3028C145A09
	for <acpica-devel@lists.linux.dev>; Mon, 16 Dec 2024 21:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383849; cv=none; b=BK7YJD91Q3lio+TStfhSA3z+KQIzFzGoje5byulWcLG4HKSXeZ3xobyDVAFNPO1vHimllvUGlrpv6pG64wXIwP2v9bhXJklIrOYF4Nu3KWAQhsbK2vGOBcJEtGGl1DZOe8tA5QNHoNgXxABEE2oTF0OsA/dAtWGWwd04j9/VMsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383849; c=relaxed/simple;
	bh=e7SFMwzDWsXgzO/ZNzsWTCVExP8H4avRE4Psyn2EYBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Crad5TRV5pvPmkcKzKS+Bbf0DuUUxWun7iRhNXK52IajWau85/rztZDWdgdtthlI69MsqhC4z3f0UVV4s9xfqBpScH1wQrNM1hMM8rKZyIOdAe6/oWCtqPBMicO+aYFyUKWDjkb/lnI1H6VQyd+FEj7BxF8sqxDQ9LuHk6bFF6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Voo0EvGN; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Voo0EvGN"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46792996074so54146951cf.0
        for <acpica-devel@lists.linux.dev>; Mon, 16 Dec 2024 13:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734383846; x=1734988646; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wrx/XZpVy8CcSfrt0QCmmOTT7oU2GR+FF7o9rBsUVb8=;
        b=Voo0EvGNy7k7OHYn1Z0z4f5RcxIBAOELRUkO6H2/VWXu8nE42/YhmCR+QRMcT1zxBA
         vEkVU6t0sFGey/STADhVBBPop1RytNOAqkpdaZGNNzcf2B6XB3M5I/j0ZlAHZ4r/z6Ll
         A7NYJq3SbOhHGdFsWNgg7uyGGbydHwzXSn63g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734383846; x=1734988646;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wrx/XZpVy8CcSfrt0QCmmOTT7oU2GR+FF7o9rBsUVb8=;
        b=SFtRJisZ2lOfGVQ4MCqagub/ZtQCSdWyqpJzh8nxQRI+qOd3IEKpNPDLbhNdyH6TX2
         /AFFWm9/iyvwtiHLBgm0bBZmB67KOfgpfsWGkOjUqo7kxAcUV1W5Kut/GifzRn3ejRIN
         RdUWyaBARtj8pY/MODw5xcjXkG5JY2bIFd5x+dhNv+cqBq4bZ7ed9gdd/G1Ox8GkJONz
         IEI7t3H3xn6FqHBow2Oj/AhItb3oD7BNZQLQGZcwWEWx+zvyTcDPUns6wn0kWhKzE9w3
         VRKw7JCM3GVrKBCNWRw+bZEgJNW/Rm8BKTzC+LzFd1p0FImnucgTae4psMEdplgQ2O/I
         fa3A==
X-Forwarded-Encrypted: i=1; AJvYcCUyQsHCsxHYotd7jTLvb39c6rsVO/+Dn3ype3wF+IhUchZeDShjwSPuYIjxYUKPSEgY05DHG6QViWxObsU=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+Mj9CKPy2hQOkpjiiE7l/hDYMb5SkHvfzRBpz6MHX14oU0+/5
	n9F6wkl/rvCBNxcfAuhdeMxIEMNejLIRcLkakit+tFZQntI/K7yXsUagBG5yvw==
X-Gm-Gg: ASbGnctu+lFxG8GqeKeLlNqFVRIXEGCS1oqwJjJ8XSPtEdhBgdGIAnlHsHA3SFmREr1
	YxXicbGqjCM/wWnXwPVlXR3R2U38AphJ4SA0aex6ilxu3ofaU0j+Wpea0WnFAmcKVp0bMVWhHRv
	ncj80FQqCsOPk2k8JV22uMqGryxlTl6EwbZ833ZPJA3RjvydUo4gpj+hWSN0efCBRD0b2eCfg6C
	U6Psp+CCGpT3uRLhTZyynARcQK4igqZ0kVESFcaET+6BQTg/oqinr0VXqAB82xmrh7+MIfLu6R0
	hg6Ju9VJqZR5C8tNB9gc4K+JKgDaOSw=
X-Google-Smtp-Source: AGHT+IFe0W9f2W39cOFyxGiYpi+wHrRevZyo7XAuH0Mr2XhLF/7Z6NTzZgUOvov+yVRzbUrbAYKkSw==
X-Received: by 2002:a05:622a:115:b0:466:9a61:273a with SMTP id d75a77b69052e-468f8b66f1emr17164551cf.52.1734383846255;
        Mon, 16 Dec 2024 13:17:26 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2e85c03sm31927501cf.69.2024.12.16.13.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 13:17:25 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 16 Dec 2024 21:17:16 +0000
Subject: [PATCH v5 2/7] ACPI: bus: implement for_each_acpi_dev_match when
 !ACPI
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-fix-ipu-v5-2-3d6b35ddce7b@chromium.org>
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
index 19f92852e127..a9b5a5204781 100644
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
2.47.1.613.gc27f4b7a9f-goog

