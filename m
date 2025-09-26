Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CE22F5A3D
	for <acpica-devel@lists.linux.dev>; Fri, 26 Sep 2025 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892295; cv=none; b=sDFXqKS2fi/kxhbR+vfT/5yd0ktVGYN+Ie6SvYadS/LZI7Our44B44FWpBw7YN+eAvexe/uqmF5psSF7IEI4T9Q9A6xYo1NJa8ei8/JexZ1OuAZPuFE/x+hXvAuepjPqnjxsrF9IW3roB852E4yCUINS8Dt3iwJRhYOrypvaUHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892295; c=relaxed/simple;
	bh=fN1yQSZa9dGNYApiBN9DJ0yzGqYY3io2zaEeifTv+AY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NsLt8+1qVmptgBUhQDUYKlPNjplwAvgYdui+N9Suvy4P6PI7VanYpkPkAgpcSVSKLU56M1KsAR7iaRU3ZrOUPaBzvhaJry0DcA5DR3JWCsDCd6HDSr/eKfsxq4cD+ruk/2mL/CQ9aX9GgGNx4IcrWFk9e88QQiR0KLU464/vLmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TlYN4thN; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TlYN4thN"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5821dec0408so3097989e87.1
        for <acpica-devel@lists.linux.dev>; Fri, 26 Sep 2025 06:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758892290; x=1759497090; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nuHd6eGYommvO3UskpqEqtJdP8+N3udV7UPBSp5lsjc=;
        b=TlYN4thNPv63I7XlJC5f18jGdQLZ7uBu/x1N5PM4iM6qimwiNh3c2PugLenehZ2105
         ymTc2I6PlJ2ilNgwiEPhNmnVx//FuijNEnLd4OYiadkTZhX8vUU9Af9PjmyefXShl/eO
         WyLQKT16bzR3NQWV5d7E9APJ9bKuL1+ZA6Bmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758892290; x=1759497090;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nuHd6eGYommvO3UskpqEqtJdP8+N3udV7UPBSp5lsjc=;
        b=biiNf8+neoVTKmxJtqHbqFUGFzfhAvGm2UvwrOvxdOGrSWGJTCFYi0d0Bf8HHLRYy6
         k0i2CmaZgfyhQndxdZiJ4w6/TXFiSVE+3/HbyzkobKhG9YLjyZAKLtjlVfdiGJULnH8l
         Jqy/pSVhKFbNgOFiq+pqlH9odputgSsE4inF7m6GllUkAFCNZZuvxGCOcn2/dN07C83U
         NifDDztuSgUxQ1FmQR8L5VVe2otwLlS+VzwW3DOugW3/HBjCqhLada4t5AW4u+I4eczt
         UscHswZjz1sepYcvNp29SE5lFvUaWJLIqMxcJ6XAFTY206FFwp8+YFK80w8XZ4WWWcaZ
         Fpyw==
X-Forwarded-Encrypted: i=1; AJvYcCXJimugZwrUYXyUjdqUP0XzRfhFqAAk+7oHY8Q3qWecjIKY+xScrfFo5ymDSZEPX/E2Uu3hL1VMJ8qDFxs=@lists.linux.dev
X-Gm-Message-State: AOJu0YxM8cXgZ2GzHuPqGo8K6WbzeRAMANUnoLZdf6bLnX3BftvJQjVH
	7o5N67Bi8V2ZfVvSon3U/6hYmc+SR3iVTm20E7NlRO+D2eIxaMtKvMKoIGKBAXwL+GDQzsUguXD
	ASao=
X-Gm-Gg: ASbGncseWeiWfyXCg9W/Y7LVcFsKgOjYwPstLND2rU4PteD0173ADz7OY7yF1VcVi20
	7lowy8cXzVBpZGA3vmgN0wmLDH0OAi6xgdw531vb8UAeHyPjRlaIZX/xwh+yHjop8Mmq4hCRJ3S
	TlzK7R67wzWktvdzJ89N/HVkSHnkD2HtVfFIe63o/naknN8jWBzyP5DAmN0wMUwC9Ii0iaRPfCU
	XH4OH4gYiXLcMtb8OMxUCQbM3VelulH7CvGMJjk3l87m4J7+wizzBMd4T79z4/pt5h4wq+5y1vq
	BQS4vdOCm3ncrxWct3WDA7TgFOKkhPCp1wLN2QSu1yz3febnxt0XuQF41bFas6edqIMZVPqBsNV
	26cr1racFYss8hncrWqQ6oHcMV+foMCDsqumE5pCvG+NE6Uo5TsgpF5Y88UKkbO2mwfhblGBPr8
	8z4L67MOc5CqB6biazrr2n+yQ=
X-Google-Smtp-Source: AGHT+IGBibbMbWnp4wsYYpcAZc4iOvKmHvOhd0/KxBOtu8sk83ypjF+oQ0w3P1LE9KQVYZ/8hnbPDg==
X-Received: by 2002:a05:6512:61b1:b0:57c:2474:3743 with SMTP id 2adb3069b0e04-582d2f24dbfmr2344139e87.32.1758892290146;
        Fri, 26 Sep 2025 06:11:30 -0700 (PDT)
Received: from ribalda.c.googlers.com (64.153.228.35.bc.googleusercontent.com. [35.228.153.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58527c6b014sm123872e87.43.2025.09.26.06.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:11:29 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 26 Sep 2025 13:11:25 +0000
Subject: [PATCH v3 01/12] media: uvcvideo: Always set default_value
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-uvc-orientation-v3-1-6dc2fa5b4220@chromium.org>
References: <20250926-uvc-orientation-v3-0-6dc2fa5b4220@chromium.org>
In-Reply-To: <20250926-uvc-orientation-v3-0-6dc2fa5b4220@chromium.org>
To: Hans de Goede <hansg@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

If the control does not support GET_DEF, the field default_value will be
left uninitialized during queryctrl.

Fixes: c0efd232929c ("V4L/DVB (8145a): USB Video Class driver")
Cc: stable@vger.kernel.org
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Hans de Goede <hansg@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 2905505c240c060e5034ea12d33b59d5702f2e1f..a869257e9b7c07eaa7d725d107bd1cb57d3c7377 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1542,10 +1542,11 @@ static int __uvc_queryctrl_boundaries(struct uvc_video_chain *chain,
 			return ret;
 	}
 
-	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_DEF) {
+	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_DEF)
 		v4l2_ctrl->default_value = uvc_mapping_get_s32(mapping,
 				UVC_GET_DEF, uvc_ctrl_data(ctrl, UVC_CTRL_DATA_DEF));
-	}
+	else
+		v4l2_ctrl->default_value = 0;
 
 	switch (mapping->v4l2_type) {
 	case V4L2_CTRL_TYPE_MENU:

-- 
2.51.0.536.g15c5d4f767-goog

