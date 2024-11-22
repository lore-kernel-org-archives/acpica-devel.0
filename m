Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC3D1DED43
	for <acpica-devel@lists.linux.dev>; Fri, 22 Nov 2024 09:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732268908; cv=none; b=knvtkRAnz77gZB0uuMHD0IiiYMti3Uc+NdtM0ZU8tToj98Em7keGgFSzAArqe3nND+GpXaCh+jtq84u/R7JZhDS6SYsE6v0NKKvsU3LApL3Lghp3XZ6daSKI9HRNLd0RNZ38OjpltY/OoZrqZ5f3LX3DgkXbfizfpPqPdlpMXJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732268908; c=relaxed/simple;
	bh=4H1xI8rZic7uj8BVAr4deS1lVj9r+ITu7MlYRDSB8Ik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kn3AllVfFa9JwrL4vvKoAmAeDdU1iWBgxG5ZqJXHWte7HdMkUKISCc3YCyPrydXhNFCGv8Iah+UVtl3wgbIMGGsmx35OWx2lLjo3332OlF+t/6MHUwOsf/E+nBScFh10aaM3HMt4JIgMh4zLLXrHKBoBRk+dBRjZabU3XbABf1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VUC/7JKj; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VUC/7JKj"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4609c96b2e5so12689231cf.0
        for <acpica-devel@lists.linux.dev>; Fri, 22 Nov 2024 01:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732268906; x=1732873706; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VrSmAj2jkvytw0rNLCddg1aexjt2xHCHXsrUaR3oGCc=;
        b=VUC/7JKjgtGC7oW2CpJbMmQJlA+c2rWkrE9MMlVAbhPsds1Z4Mip2lpIjbtZ/A4Afq
         h8DxIEK70gxpNQlBPA/jN1BPjL5hdTVYhj5t2LEVdVBKyj0yruKuuH70UVhfnwH9939b
         oF+1UdKmmoCn2JEuUtuXyolVRchOmpUGDbAdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732268906; x=1732873706;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrSmAj2jkvytw0rNLCddg1aexjt2xHCHXsrUaR3oGCc=;
        b=H4XATaBEFyR2zvDafWTEMOL/ToUr36oQnhpHjHe+rZj5MC4ZbdFAXfJCMK8e2ditMq
         m0viaWiAVo7uwo1N/U3M7Nncdnh98WDqAfCUnxkX7adY4XppRwrxHM7F+NO7u7chZKO+
         6I6ef5wvjDYYXTrTfNOJ82PWmAR9oSRZ5KdDYTkX5OrXbHJE4tslwqzkgT4lFatKL89L
         5yRjAWDcr7XjlhLaFW7Ex/8xMFm8LDj7K3eQvxECB9xG/elK0S/+C8Flh6K3g7y28mJn
         zMeyNtAGs8tITuB7SwXVRVfeUXiljRUaFTGDN8ASWkbpIbLwipGQoAwYaZYAPfKMBZU1
         zZTw==
X-Forwarded-Encrypted: i=1; AJvYcCVVmacF8U+l1MuGKAWsEmcvvlZV2g9n6iH99Hy0Rw0G5R49tdNkjjBid69qhq9I2L3TJ0jtQtGkh7CERw4=@lists.linux.dev
X-Gm-Message-State: AOJu0YwBDnWFk4RuJdjdGvVvKJC+CVwAqvV/jH1J+nBGNfPlshNklzQs
	/RPRxYRn+wcK6A6yMR44QHvI94AB0y58A88Q1sY5zTO5LwAkXv5mfY3TjtfAtQ==
X-Gm-Gg: ASbGncvBhH5UYG1/qUwksK7ThdmCbjYaCyVg+zr08BWTZDPbzEJZ9jBAXjUNX0niWR6
	YLTPfk9sXW42NCM93LH/Nd2NJBV1uVW93k1DZkjp8HFTp5RuO7MSXo3vDawurkKhYsD6SIWXQmL
	SXqRn+sgiRYbmOWfCMX0ebxLcdmlhSwXsfNWU4T6e0rJDJ5EwJZ/3x2vf8eExpXKjRO9Z9qH5nF
	2W00w3HZHdMPlgMuyO8zHmLQpmapaReu1ilG8SLFbx1eqHWo7yB/qzdZKenj56Jk9PvL725YsVJ
	rYmADCsvJ//+5VkYVpQAZ8To
X-Google-Smtp-Source: AGHT+IFru2WAUE4DOiSVjGZ5la48og7nHQB/1X/SGFbEnNNed0D8aT6/FZPgrfye+Wt1XXhUhzTTyw==
X-Received: by 2002:a05:622a:2d2:b0:45d:9357:1cca with SMTP id d75a77b69052e-4653d57be12mr23934371cf.14.1732268906271;
        Fri, 22 Nov 2024 01:48:26 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c47f124sm9282731cf.62.2024.11.22.01.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:48:25 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 22 Nov 2024 09:48:02 +0000
Subject: [PATCH v2 5/7] ACPI: bus: implement for_each_acpi_consumer_dev
 when !ACPI
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-fix-ipu-v2-5-bba65856e9ff@chromium.org>
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

Provide an implementation of for_each_acpi_consumer_dev that can be use
used when CONFIG_ACPI is not set.

The expression `false && supplier` is used to avoid "variable not used"
warnings.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 4888231422ea..57298c7cfb5d 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -1005,6 +1005,9 @@ static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
 
 #define acpi_get_physical_device_location(handle, pld) (AE_ERROR)
 
+#define for_each_acpi_consumer_dev(supplier, consumer)			\
+	for (consumer = NULL; false && (supplier);)
+
 #define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
 	for (adev = NULL; false && (hid) && (uid) && (hrv);)
 

-- 
2.47.0.371.ga323438b13-goog

