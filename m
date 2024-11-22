Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBFA1DED5C
	for <acpica-devel@lists.linux.dev>; Fri, 22 Nov 2024 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732268910; cv=none; b=DpAdOwZsduN6xjMxO+noCa/7+k7BFcbkL0CCDG+6idIAbF00ABRje4q7fkOLoJf0DemOwubinGex4PhANGtoOFzympIH/G/wXesxWlyoddIQsDiD+ZPJaR9daU1YnUQbsos4xtpEhiJXlcOyrIvbAK8fXqZ6VCEuvv8vxuYFd6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732268910; c=relaxed/simple;
	bh=BYuLHzueav0sdSprQfzk88q4Y6f26g51RU20Q1WXi6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XcDWF6/Zrj+rfoDNMCQK+zNgjvrFuY4zCy5GasJccJplBz8yoVzjlxjWdakuFfwrkx5+F590QXro/YjhDo9x6qhKnREtxMqMbxj3EbB18O0fnp5hbeMLQbMKa5pTGbAmxJZzsCeUYKf2IBUZBS+xFFMHZCLojXWd2RKbYSKDVe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iiqcv6cW; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iiqcv6cW"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-46375ac25fbso12685231cf.0
        for <acpica-devel@lists.linux.dev>; Fri, 22 Nov 2024 01:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732268905; x=1732873705; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Acc8f5vjpjnUsttSTKqKG5ha9p9/8KASrkXH0sEj3iU=;
        b=iiqcv6cWiPHzok2tAOgl0SSegkjQG1BZ//unvv1nua5ptl5BBdGjGxYQr1U24oI6aM
         qow2RvFcIsB5lo2Ght1vzMLRqUWe40l3h5zbp9MXl/5pUQgNSXYn1665Z9rMTRy9xCzk
         R0D7k+OtnHg/N31q/WVWTGpFYOvEbcX9dU6EI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732268905; x=1732873705;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Acc8f5vjpjnUsttSTKqKG5ha9p9/8KASrkXH0sEj3iU=;
        b=vqRU6ugp488/MOxMD48SMmFbEhZkDk4vnQEiXBI5g9JbTVarDLu/oYbuaAchDV0+4C
         OpjqQ6+86kzXft0nEb/LfOg66Nj5bkvpi5Jfeo1BPt7nUXUHsv31WbAFJdRv3dzr14AM
         DKtPq9MGMcANTcCTGMQCx7skZQU3XkiLUU/I9qRfxLoUPx2kBc0vaadSzL4DsKhmVyDN
         mSDCIstgGpTbBqUUOvz3xU1wrbxtwZ0vlHuhNpAVxXASBW+8nRGneSRp6b8FTCqd2LBW
         CWwSQJWMA/LXtu2MFw8+0s0sFNLsbWPO0K8KRM1JL6nJDlJ0tkGocVIe7Rn3VxJT894X
         dObw==
X-Forwarded-Encrypted: i=1; AJvYcCUdA6hZseI4I0tt5Vg6Z4KepdOoSu5KKLVRe//EQiOU56tgoUtUCBNzl66TV7nTqPavVJE80auRMKNS2vk=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3giE9q+UFXtCjgF4Mgaor0ZMg/qZG4qTu+uCP6zFbN+Kspkus
	CZ7ZcI0CnW8dg/BOzwt7hqMDGz8IZyN91eEyzOdSSXUYit22uVykGFjLoXP3mw==
X-Gm-Gg: ASbGnctCZfbjawAXbKOtA5IMf3IXm0BO9wz+8hOxG4kZdMYt5Myh61KChRmwOb13aOB
	Ypt3yZYw+hL4U0mbx33QI1xc+ZJsypKM+nCXL6sc/qknk6pfNHfTTizbTvzKYRnSIlQhJ8hVE95
	APOBb2L7nTi6ouTN8Xlhicq4rWFHFkf9/NTppgSjeGXfhpEdbdO7q5U8GF8xyGgn3ZNWgwkt6J/
	wo2NDujqS4uS4h2GejT3+57BOLCBGHBcZ09V9OcABl5wu0ZKmuXDAmQ/cdscvbDOemCvORAg9i5
	X4izuVeAjPp+EvrZbudPzslf
X-Google-Smtp-Source: AGHT+IECFL9WoKiDiu1xKptVQF2T2gvsl28cr0HW2a0s9qqj6Aj7Q+ZZVLocd/R1cde01FoPlwJaWg==
X-Received: by 2002:a05:622a:1ba9:b0:464:889f:a413 with SMTP id d75a77b69052e-4653d5344f9mr24237121cf.6.1732268904929;
        Fri, 22 Nov 2024 01:48:24 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c47f124sm9282731cf.62.2024.11.22.01.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:48:23 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 22 Nov 2024 09:48:01 +0000
Subject: [PATCH v2 4/7] ACPI: header: implement acpi_device_handle when
 !ACPI
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-fix-ipu-v2-4-bba65856e9ff@chromium.org>
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

Provide an implementation of acpi_device_handle that can be used when
CONFIG_ACPI is not set.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/linux/acpi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4d5ee84c468b..85d7649ac17d 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -777,6 +777,7 @@ const char *acpi_get_subsystem_id(acpi_handle handle);
 
 #define acpi_disabled 1
 
+#define acpi_device_handle(adev)	(NULL)
 #define ACPI_COMPANION(dev)		(NULL)
 #define ACPI_COMPANION_SET(dev, adev)	do { } while (0)
 #define ACPI_HANDLE(dev)		(NULL)

-- 
2.47.0.371.ga323438b13-goog

