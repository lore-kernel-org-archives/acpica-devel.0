Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EB71DAC95
	for <acpica-devel@lists.linux.dev>; Mon, 16 Dec 2024 21:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383854; cv=none; b=FrHOPM5mumzoqoedw39yfU0ZTmGKWkJTwcJY8gOTLrpKeow6C5N1PpXrjja3vwZ6DkOg3n0ru6yEUKBlD0IUMuFPNu7D+0Iq7/p5Qxs/8ScRmOm6QX3U1IdHlSWs4ncpUrcej5RsrIf7iNZN5cEGp+fDuQRyxgvuiouaz+hMfsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383854; c=relaxed/simple;
	bh=Juo2ve3rrjlu9oDP30UIZmhGa+flQbphR9swoQR5GS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r9PzAOjVLkjN/70i6/MW6aJCQF3k2+wvGF+rikekl8xV7qvdww4cx8CZzBM/qmeeU2lAufgwkihUzgH7Yq9SFb0AGOYMxbNsuxOtjgQRaVHHCdsXqx7EUagcyKJ+pTs9sP7MmNcuPv8BYNO4VW4Hzj55drn+w7pCZigDeV10Tr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gFWjew1x; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gFWjew1x"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-467a3f1e667so23693321cf.0
        for <acpica-devel@lists.linux.dev>; Mon, 16 Dec 2024 13:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734383851; x=1734988651; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JdfI8iMG82M8irlFSVYMbWfZvDLPeTNhiZE+t4N6pwc=;
        b=gFWjew1xiKADqPLuiQ9rNOcSCkRk3XrZfvuT4WXlvRe4c/ka9MvXJDLlmEhX2ZRm4q
         W+sjoMrNMXZfaFkfC/tNGVAZIXJO1kgN2cOEx0ftBolx8i62y6C1XmWVPLz48mDQTbXW
         E/UMfgtFOTMHldyp+pt+PoCTSbIYUocEKdCVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734383851; x=1734988651;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdfI8iMG82M8irlFSVYMbWfZvDLPeTNhiZE+t4N6pwc=;
        b=fFm0uDawdrTMEfL8a+T86MYZxEywz+6QtMPTymaigLc6doZFQhl1wzLJTn2ynKQmq0
         LUGxCdJnBTqoXKGuhVorYd2SvXMiiy/M0KAP2Bw0+zlU+IYcEnK9WZNFv9ue4i4LpgT2
         BSCoFck1RMadNYA8lQtJ0ZBdyaq5iCZjofCBfxLU6X2VcCWXKKeZwqtvHZpIc9n8XFMI
         kKQlOV+2ddaxIU0TrFwa2R1QYg4kdrDgvT1Sy6SD7ku73s1YctNX691RGtVMSqSBnXNS
         2c5Zm+leFHhERHKsZNgWFzBct+ydIoE3o4q1l+twdY0HLdwhpXomUNYJRzOaWcODMPb7
         1ubA==
X-Forwarded-Encrypted: i=1; AJvYcCUYnXpuA9lsvq5ceVl7VXsBHd1jw4LE/Jrqvw93AcnGtkhd+3GtD4zuGJKwk0uGN1gFHPM2Ip/Ys5IwV1U=@lists.linux.dev
X-Gm-Message-State: AOJu0YwASywgLfdinudNTtKuuDWEFQCiEpJvwb/E1i+GKFHfs7RDAqsA
	+RLInUVShgqA/nBzeiT2QEcq3Nv5hW1+wu34C3ZVNX3pNDcok1BQ60bkjyJ8Cw==
X-Gm-Gg: ASbGncsoz+VsBuExpnlQCJ3hcKZXx8YaAFc1ZgSYTTToF2g9Za69a/Hblnwf4NX+UKG
	Vx5VtHf3ZlEmN5mf8ykwa9869RND5QcIF2tJB2KpJNkLP/z2TzwbCbSPVfqqFRPM7FgbX5eVmpR
	h2k37BkjRw+ciObznsE7L7pTZMpTZpYe/qqm9i4eN1jWUZhQ6xzfoSMdd5meQ6y5OyoOnVagwop
	ot0c0iiG0DL36O0oMfMgnm8ZyY6CJzigjnfkU9rtZUlt070UNC7g/1lDXtPBkVkoxxzHujAxni+
	w6BEZn8kdqrzqPH5fvQ1PQse98lApEo=
X-Google-Smtp-Source: AGHT+IEl8hUUhzs8PDA9iSUQEkMmOZX53TWYQb+JuoOBexm0lrDkqiD/7RB/yiHbTUvOThs4R816YQ==
X-Received: by 2002:a05:622a:1817:b0:467:53c8:7572 with SMTP id d75a77b69052e-467a5759258mr245947171cf.13.1734383851253;
        Mon, 16 Dec 2024 13:17:31 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2e85c03sm31927501cf.69.2024.12.16.13.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 13:17:30 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 16 Dec 2024 21:17:20 +0000
Subject: [PATCH v5 6/7] ACPI: bus: implement acpi_device_hid when !ACPI
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-fix-ipu-v5-6-3d6b35ddce7b@chromium.org>
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

Provide an implementation of acpi_device_hid that can be used when
CONFIG_ACPI is not set.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/acpi/acpi_bus.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 68c0e2fb029f..aad1a95e6863 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -1003,6 +1003,11 @@ static inline int unregister_acpi_bus_type(void *bus) { return 0; }
 
 static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
 
+static inline const char *acpi_device_hid(struct acpi_device *device)
+{
+	return "";
+}
+
 static inline bool
 acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld)
 {

-- 
2.47.1.613.gc27f4b7a9f-goog

