Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169AD22A1EA
	for <acpica-devel@lists.linux.dev>; Tue, 10 Dec 2024 19:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860586; cv=none; b=givSnVN54KoAB8xG1bc8/vzFXptg5GTWbmopawZIapMLLYQdLJQTokVZV0KioJp5xfPCL8juJ5vMpuAO8sPaaHXmdOZ7kpZil8A/lipnrMfayqdneBSakrdefSaPXVOqpyD04DqueZDuyXTYHqmLHrl57C+ORgyc/Ziag/0kCkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860586; c=relaxed/simple;
	bh=YpVt1IJK5kIz3EzNG0TljucOUwJ/2fX8gxiI1v679o0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=paKLQ9vWEReSw0lioUWpbZnYEszgDHChfLVNLYhSQ1mT08ZA1X6c8QMoID0MoRiLSw+5yjx9fKDIgNslGpdTAxQsy6Y5cuALTuD6zt1bgOb8eYfiwPvtVXJGAgvZzYyNl+Mp470XX60z4bxvysyRdglmQhaApGGtMIVoxpmMCnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l9gtf+OL; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l9gtf+OL"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4aff31b77e8so1252322137.1
        for <acpica-devel@lists.linux.dev>; Tue, 10 Dec 2024 11:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733860584; x=1734465384; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wo4Brw2DCcVsJ26CFqfG+Q/anJpN5TVrr8Upgev/TjM=;
        b=l9gtf+OLcJ/mbUQd/BIQpRzk+cb6xmjc+EEplNMHQDmrGQN3zBi7w9LWKNdA8gcxg8
         wAyi9btOpQ+npiTRKi9/QsMZ3iQd7oNDluqiCEB+nU1xubv2VsVlmaQbbDHxroaHUlld
         MDWl8mpL1jAO+WnsgwL44HZHtXMDSQb/gSaB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733860584; x=1734465384;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wo4Brw2DCcVsJ26CFqfG+Q/anJpN5TVrr8Upgev/TjM=;
        b=K2C7CwGTkzMlvN2eVAJVtjLX+2H/b2egZggS92sZ13PaFfDCZLLeRmE6XQhGNQdcMA
         7ECt2oqLkataeHVZZyJdAbazETos+nzGj6J4AoBkcFuFXtyoSKOsfu7Q0SlsHrKia6HQ
         LmGSADhF4tNaXrrP+Y0kF+LH/xZ1q8cNlyvZIV7x31AylF99V6cdnxvZxCTSQO/YNNut
         LytPTnmK4dpjQAIcs0LQhZdX7pPMkKDmGATRvvTOVWpq1HpOg8MVxBHPGqym1QYAKHEK
         HpwrC6N3gZWwi7Gjb6L+IAxZ4tn9NNhAV2c1oWcemLPqghLkYiWwvBu7uiamctgZ3bM5
         lk5w==
X-Forwarded-Encrypted: i=1; AJvYcCVBs+GG8Q/Au9w7QPBGm23LwxKO1sPe8NEpq+8RRGRBAx8Q1Bvbdo0vTR6EqXLgKeMH4erJzV/VcRTmvKw=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7O/cIIPvtXu2wMIPqnn5JDlLXQorLbiu95tyJJVpUjVaZV9C2
	kw0GZ1GxyxbrTBMYu6cX+luFASyVAcTcycCAdj7CnvL6Cp8uYrIAqaP9oGyl5w==
X-Gm-Gg: ASbGnctsmCgzxemp4g7iCzBFvZuOpKMTpHq5/VkWqUrdvCLHD1z5DdClaqXyrG7rSmf
	GC2bkTe1uUcy54uFKCYjkF2uG9NgoJjBB3KELy9EE52pHhAZ+Qe0d05FVZShlKeheXCcraafC1J
	Q50dVTQWw7DiT6tNT/5oKQdM4WxX5g15UrvpZeiP7DLCgzZscu3G3nYCQVrdoTiqJK4S/Am5Yhg
	z1ABMYOe9GZYAqua2qJtKs2VRgh8L3UnZL/6XLIamMVrj5ogJuwbRxxJb3t6hpaWyrlbMnW5aQH
	caO2GZTuT6M1pAauaq/m1K3baA6d
X-Google-Smtp-Source: AGHT+IEmzXYFoUfqOj/dIppTnK2q1X3UMKlfoOVpixdTmMHqeSiokiuDcOibXmJMwEkU4cB2noY0sQ==
X-Received: by 2002:a05:6102:5092:b0:4af:bef2:c8df with SMTP id ada2fe7eead31-4b1290d6f1fmr862642137.17.1733860584010;
        Tue, 10 Dec 2024 11:56:24 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85c2ba7dc70sm1279522241.15.2024.12.10.11.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:56:22 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 19:56:03 +0000
Subject: [PATCH v3 6/7] ACPI: bus: implement acpi_device_hid when !ACPI
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-fix-ipu-v3-6-00e409c84a6c@chromium.org>
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

Provide an implementation of acpi_device_hid that can be used when
CONFIG_ACPI is not set.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 4f1b3a6f107b..c25914a152ee 100644
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

