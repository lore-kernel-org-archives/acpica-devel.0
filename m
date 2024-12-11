Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637461DB933
	for <acpica-devel@lists.linux.dev>; Wed, 11 Dec 2024 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933246; cv=none; b=GoKTTJ8wvtNvAI3CMP3YgXPRfwLqdhK04xQjVPpqf1PMUy37PU4Dl6ngMJdAG/I2jVij3K8vtYS8GoWV1WAIwit8htmSQVaCB2hEge4cx3OF2XcXZSsRBii3v0JT3fKZGcgAAL0ButjNFNFIeqPr9os2KgCCk+x/OlVrOiSiFxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933246; c=relaxed/simple;
	bh=Q0tZOYhuY3Ey0IPHXjXrOvps1QIhlGU9kBOlggkrfY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nLzXGOCrL9gIbVwhJ+7alp0JVsRMIHddDJN0sntVI6g5dWTLWhZgmMS0Rga8Mgs2guJKfvT0VCQs24U8hgxfQTmWncMC7aLvwM4CO32ZD+rNHtktM+nFiOk4zk8EHfvk10upa+AlPOADpZET4X0NHAEYs2O6CTYv0KbVEMtEZ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SwY0qeg0; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SwY0qeg0"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6d888fc8300so36749726d6.3
        for <acpica-devel@lists.linux.dev>; Wed, 11 Dec 2024 08:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733933244; x=1734538044; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9aEfR/qabxahuoJOZlYtnmnLnWgQnj7Jexuo0meaq20=;
        b=SwY0qeg08Fn+EjHaPCPKZte2VSUFRmOE38TPx63rkbU77iRXy60tcLqORiV5VFZTRt
         Elqkgqe08zA5nczQ0NS6CZYPcvyhczhpjhVMR5WxE50LCkP3z8x+Dh0OdlYlfuTrS7Wl
         qFVr8mwqwSAPA62KFWuJ+6BCdXEWI5DIq4Dog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933244; x=1734538044;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9aEfR/qabxahuoJOZlYtnmnLnWgQnj7Jexuo0meaq20=;
        b=lhNTueVdlEoM94NuyQiCVrIYAUBQ2pC73F3NbryHsRc2x+gBbrgxz0skUu59kkJlzA
         8AZrQAdua4y1y3FvoH222hjPxUav0gPQh2bnxQCZj5EeY3Bg0HeiqT8GOoL02hIYanr/
         TNDEwbpx+YbY+ljWSiQt83wqv6MhITUTeQjYBen5xGgWqqazjTjFuNwEmgz35QHnSUsu
         vMFAfNC2I+2kgtiKmNB9Ha/U4wqIbLy7DaqBJ5MpHdpK9Tch/XQNmHoIC5hHLbTLYY8u
         Baia/dEWSUwjwTopBJHwvwmvgyVjyn/urUC9RyVKh0NDXtpwWveYWY3M6JQBMUgnL0L2
         nOxw==
X-Forwarded-Encrypted: i=1; AJvYcCVSMqDqjydOaXOUmHtYQuoafO13cPrUreR4rlEcYLAJEI+O7i5u+vE7XIj5h6L6WH4v/Q/6qJl7NlO2LWk=@lists.linux.dev
X-Gm-Message-State: AOJu0YxM6EvdlWV5xSUyIn5QpbHSqDQiU7r3PCVIClYMAdkv8ArKS6Q4
	RcAk6uvM32gNMlRg0IwrWHHn6gtJKAc5ChrALcqq7Yvrdacpc+ox4usm2GR9hw==
X-Gm-Gg: ASbGncvScNZGFK6KaZzb9TnKngtD0CUOfq98t5wKLYHP76JtXgyKLEZiKh68mRLU+6/
	4QzCgFcEMs96OO4cq/C9qkvj/1L5ucI1ABLyNtSb6jFzsWbCj2VqUqHcg/NiOr1BOie/MYDH5UP
	uPqPZLAEla0l1/1fIatzd9BFeubo79RWQpY6tgC3Dq63in9D/a2PXlk02+zhYba7hXGYVehuIBk
	A2w3PTLC3nLdtzsaqpuj+S0YQ8vyy2e5fNBcqoKELeL3GgC+hAtlDee6R2KPomnk3FkW0LQVdcW
	kI9C58D3aUKZc1xz9wjeBOD5favL
X-Google-Smtp-Source: AGHT+IF87GwFnPD41KxfMUhVnNyyBe54GEcWZX003dqF5ZJl5NACMpzgazmytTFC9qeLl+gKHOK6SA==
X-Received: by 2002:ad4:4809:0:b0:6da:dc79:a3c9 with SMTP id 6a1803df08f44-6dae29c181cmr3825226d6.9.1733933244430;
        Wed, 11 Dec 2024 08:07:24 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8daa00671sm71484946d6.88.2024.12.11.08.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:07:24 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 11 Dec 2024 16:07:21 +0000
Subject: [PATCH v4 5/6] ACPI: bus: implement acpi_device_hid when !ACPI
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-fix-ipu-v4-5-4102e97aceb6@chromium.org>
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

Provide an implementation of acpi_device_hid that can be used when
CONFIG_ACPI is not set.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 80ddd76b3a6a..b6b86acd1d9d 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -1003,6 +1003,11 @@ static inline int unregister_acpi_bus_type(void *bus) { return 0; }
 
 static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
 
+static inline const char *acpi_device_hid(struct acpi_device *device)
+{
+	return "";
+}
+
 static inline acpi_status
 acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld)
 {

-- 
2.47.0.338.g60cca15819-goog

