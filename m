Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1231D5166
	for <acpica-devel@lists.linux.dev>; Mon, 16 Dec 2024 21:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383851; cv=none; b=rVvpcpySDbDad+6yu6jZvr+X17n7YRGdyVwBY3A4Nr9hEkC8iOACrDK4dpwswv9e334r0UuxPXLlOfkG7FM/vrwh3ojeEG3NsEcW+AOB/BdYoSxWFRxcJme33qeQIS3+t53+xhJcMWpoJWMmjzhR+wVBRMWQnrUkPGbm2PjaHMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383851; c=relaxed/simple;
	bh=OSI5+enbqVnK80hh3GRt2v2/xjuyertlyl2dDt3BvaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JVZMVQL4xAMTm+5D34O1LBGVvQE37uiMLbMGw0y70D+9lIkKqvUVavgyP22Y0/4FIaWIR/4zJ4J+jss7pj8+GJJl4oTnYBbT8NJZuvDJn4/BVKvmMJ7AqNAecbUDyGuQh1Ue4f71AHjx0tCHZYHfoVr/HXMuQfDe42QIwOfb69U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c/rliVtK; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c/rliVtK"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-467a63f5d1cso35181051cf.0
        for <acpica-devel@lists.linux.dev>; Mon, 16 Dec 2024 13:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734383849; x=1734988649; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94GpRvEFGP1zDl7TooYa5XXxiXoizWnVF+RBMjgEO9A=;
        b=c/rliVtKMYa4jeKxQrrJ49VBwVhI/IZ+kF1yYpQASdoI51HN+8aql1YuVwgG4ABEKz
         5uZ9mfp7EvaIMR4Ay1KL6Ryjnqe+F74WL4PMJXhQI2+t+Y90w5z5ARMBYyplLpXoCrK0
         VsF2oSFoamNpoikg+QFfB8yJyObBM/czw8F6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734383849; x=1734988649;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94GpRvEFGP1zDl7TooYa5XXxiXoizWnVF+RBMjgEO9A=;
        b=t+8w0IwpvGNq5ReLZV7QDBq2zINmwq46QS4XNlC+oUBTG971kwAXSaO0EYRY35WXFu
         9tVJCX5rFH2yLFkG51XNLkHyP9OEj1HXF1ZefnYQAIw3Ya2ojOdoVpQsJXQDf4PlqYCM
         hRmlqfJzT+7xK+YM47IbOc4tCSvtKz6scpgxYLWOjkkVDrxpL/G/kSh6F73na7aOiOIb
         TjU6+uzBl7lThp3mdLloZtBPbuNGMbAVdSt6cJt4GM0zbXmIJjZq7tVt+GUUcLYvPkeq
         16MUVBf6N2XyUVo/mnmQDHlMIhGVPJRRnjOMspW188GdcvQR5pjS89v+nf8lEfpy+9LC
         F7Tw==
X-Forwarded-Encrypted: i=1; AJvYcCX/7LsVTC9sW3j/1OCWcH351q/ujuL9agC0kLKVpV0hLZyOwdQYXHVRor7k4tb5l2j+TIjqMi1+T9Zm9as=@lists.linux.dev
X-Gm-Message-State: AOJu0YwmuoC0xeZMDgcUJZwygX1/aFtO9t43JLLweyMtEfVbMLY0FHXR
	sPFBBmdrUWzPMXTey9PBEl56RoTs2f3hxTzilh/+nxPlCSu6Sf2LcEZ8IcB3ww==
X-Gm-Gg: ASbGncsKdgPmzVtT4brTOdt8TZe3sGqPcN/Kd1R/ceaYzI1PIA0keDqC+4BzrygncNz
	uO2jDDmP1Su3vIMIkbNUm2qx6JWxoFub+9PrAWuWXD6QzikE9Gib/vgue1xtpmT6rBOwUKQNQmJ
	fnrvait1bzyBN/eq0hQxkskamj3fauAliT7T19RqLgHD5STPEABq6YIGDty79g6jP/3FmnR+skR
	OD4MgbmdaoLKWVy4hk9w1WoUt2dCyapZQPrMcLt6wNdbF9HqLK+KZwc8+sSQKybDsSe68UHfcrx
	OWTFYmZ3TmXBuTnbqLIi7f3A9Ei3/Cg=
X-Google-Smtp-Source: AGHT+IFyzGw+gglrqm8+RhNerLly3LfTpt0cYg/FTCF385N1SMb70IaANKI6otHSuU62jnflMlYR+g==
X-Received: by 2002:a05:622a:1210:b0:462:e827:c11a with SMTP id d75a77b69052e-467a575a86emr267051701cf.19.1734383849004;
        Mon, 16 Dec 2024 13:17:29 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2e85c03sm31927501cf.69.2024.12.16.13.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 13:17:28 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 16 Dec 2024 21:17:18 +0000
Subject: [PATCH v5 4/7] ACPI: header: implement acpi_device_handle when
 !ACPI
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-fix-ipu-v5-4-3d6b35ddce7b@chromium.org>
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

Provide an implementation of acpi_device_handle that can be used when
CONFIG_ACPI is not set.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/linux/acpi.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 05f39fbfa485..fb88f21bffb2 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -854,6 +854,11 @@ static inline struct fwnode_handle *acpi_fwnode_handle(struct acpi_device *adev)
 	return NULL;
 }
 
+static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
+{
+	return NULL;
+}
+
 static inline bool has_acpi_companion(struct device *dev)
 {
 	return false;

-- 
2.47.1.613.gc27f4b7a9f-goog

