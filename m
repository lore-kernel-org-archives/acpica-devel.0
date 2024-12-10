Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCB622687F
	for <acpica-devel@lists.linux.dev>; Tue, 10 Dec 2024 19:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860581; cv=none; b=Vj3KfLIJE+eFHkEpWPOH+94Zhber6QNHpiCmfHt8scdmVmzpXq7dFEGPbDzICyPi4Rpvxeh8H6+4y2rAjUsibUS56T859+nsra0O2PofI/JzK+XViwMFfR+Zd4hKw/ksQqKlxYINupQ5Agi9zqT0yVDdkiaWRNbntESQl6zzPjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860581; c=relaxed/simple;
	bh=oQ6DOmEDhAhaC7ko0Me30Rr/Q1eMZQPunpUP2qNklrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cZi14iLKICMI6VPOVXY8kRT6cZ27S+k3NfGJH4sT4AjQAPLJ65TaP69U8rxvIVPbGCdYEwYH6R8KgNGW0qDU5JQbWooTMocTEZIJtRc7M2xacUA49pPYUt6SqsgRea+mmiLciu/hqT35Vyc2XNC5yH8N/t0lhGIsvfkMAF5w8dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ITYTTMTq; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ITYTTMTq"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5162571e761so902896e0c.2
        for <acpica-devel@lists.linux.dev>; Tue, 10 Dec 2024 11:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733860579; x=1734465379; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lezNY8dR9ljfu1iEN3ZQdA0hj9drLp6T4ntvpJiXGhM=;
        b=ITYTTMTq8tvVhbOjLS81s8Xjy25CN34trNEaHPl+BVMYHBAv3ALO82lCSX0P21hWYZ
         DZJSczag8qwNdUWrslpJ78Ee4gZlBBf5sOMKekSqCb5vOnMKL2Uoh6c5FHI20RLK3Jsw
         GlGtlIJm1WMbgn9NKhDBOLYhe5ESLMTZL54tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733860579; x=1734465379;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lezNY8dR9ljfu1iEN3ZQdA0hj9drLp6T4ntvpJiXGhM=;
        b=IZ6A6dEbfLDucOc+OsoYreP14WRbYy+7v+rYspBlfICqOoecPxv+8faYxAKxl4EvZI
         BNKc0dgtR4VQPYvfuyDeZwbykFzacWQOYKJoYL2MpYFGNFdpEm9GCqRbSEwCJ6zMTkdu
         yWzxb5pN5ZRnEZbPkm4fUbM1MkOBO1pm2cUQ67x0XXbs3p1D8DAyNkTOiiuZWXJGHzSl
         jZ5oBj3FGPjEzc8f1MVf53001Mzf3454qhKO9XpahD+csVknuDN1TABkWEmSAbQ3jYi+
         Lco5lvJYqRFBvPCcsT3NFgl1zIT5e/1+iXFS49WlHmRoWDNorr8gsRrV45FQuXv5xaTv
         xICg==
X-Forwarded-Encrypted: i=1; AJvYcCX6whEk4SKm1Fum2nLd6ysvG7pn7xTYfHAYXNiEhJmJbja1zoyul9qQemCUi3shuejGONwlTfGIHmb4CNM=@lists.linux.dev
X-Gm-Message-State: AOJu0YyWGNDP1aEwX+YGZAL+kjQgjkfZBNS+uauf7pmLUslhYlD7mDrY
	W9oE5mEERCMq9XgNFsrapw4MtEShi9wI4UJilzNV/Hsy2APxq6z6OKWp7eApxQ==
X-Gm-Gg: ASbGncu3zUzTF8jMydQ9agn/OG8v1ALC1cKiA1qLv28p1myYlWXy+6WGMMjLmXwpKNh
	vnQ5FcYWp1ApUsI1GnhKshHfO8D2MYhvJrJUn2FD4+ntokimVAbI797dVlumGJszxeuqYFu9xNd
	997MsxVxUR+YZekiU+cL3SXYMcFrwtbca+37C+9bEFk17xU7l1Ffrozl+qch6mMnSoQFUrFe/JO
	o02LaD9J87cJ0e06O250ffI1XyTiOsCD/C85fPF5ELYiu4Sr8lfNV1xJOT+c5mlfGhGmpbsINEK
	WLtSC+SbRwT/AcqnMS+c2u6wSd8z
X-Google-Smtp-Source: AGHT+IEMhYnLWvQoSWZmZsMGZeYTR3YN9TLWCv16La+76YSYWE5jDBmdmVAao50oTu5BwjDFJ7Yo7w==
X-Received: by 2002:a05:6122:1d8b:b0:515:c769:9d32 with SMTP id 71dfb90a1353d-518a3a34d65mr938780e0c.4.1733860579349;
        Tue, 10 Dec 2024 11:56:19 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85c2ba7dc70sm1279522241.15.2024.12.10.11.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:56:18 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 19:56:01 +0000
Subject: [PATCH v3 4/7] ACPI: header: implement acpi_device_handle when
 !ACPI
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-fix-ipu-v3-4-00e409c84a6c@chromium.org>
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

Provide an implementation of acpi_device_handle that can be used when
CONFIG_ACPI is not set.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/linux/acpi.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 05f39fbfa485..59a5d110ff54 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -787,6 +787,12 @@ const char *acpi_get_subsystem_id(acpi_handle handle);
 #define acpi_dev_hid_uid_match(adev, hid2, uid2)	(adev && false)
 
 struct fwnode_handle;
+struct acpi_device;
+
+static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
+{
+	return NULL;
+}
 
 static inline bool acpi_dev_found(const char *hid)
 {

-- 
2.47.0.338.g60cca15819-goog

