Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DEF2F99AE
	for <acpica-devel@lists.linux.dev>; Fri, 26 Sep 2025 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892304; cv=none; b=m9rN+1YlIuGarljG85tMciD7nE8POQtEAxrBZDqxhcOBwue57WhAA4w6EdrCQaAK2kVTvZMfEHi1z9gHDgm3xt8FupvCB8KV0LQhJN+fI1gCD0BuYi6YaM2aDZLnuAtyHHWQ9TwZTFj2cLOPu0ypuHD+PG2qlLrZPExFCOfKrdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892304; c=relaxed/simple;
	bh=K3KdMz7C2S+sjjhpcJ2VrrH58ALa5ic8heuJ7M4ymXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BHrCR/asL7L7q8gHYRBvJGxA+kfAMz4ngQHIPM5sqxZW8nPAsTLnejDocy4eU6NMrLddYI+leoAq29i3s/eir6rpJMBnjTMamrwUVQAuKSWsXqxZ/yRzXD3VqMmR0KCf/vUIv5yyKxOltS3RaqUWKCUQZ0xwu8FNnnnX6mJbsO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UWLZoQXv; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UWLZoQXv"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57d8ff3944dso2221610e87.3
        for <acpica-devel@lists.linux.dev>; Fri, 26 Sep 2025 06:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758892295; x=1759497095; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yK5cgdjGWBYF8FS7tGEMMwrGVxWyiTSoe6v1uuSmXRU=;
        b=UWLZoQXvw6h9/5riMsYigAY7tZa0HJDuKPWJiud9MHxL+PcRBhG2/5WwO3kzS3tdMX
         CjzTf7fi/7MLzr6KWnuXpa/UM0fpppzKXW9hcDAh83JzBTV8YwU4qgpFPYQWwwa6G97Q
         mgO5+NjcqOZzZ0XNuLlbyBhYb6tVK5f/cDkr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758892295; x=1759497095;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yK5cgdjGWBYF8FS7tGEMMwrGVxWyiTSoe6v1uuSmXRU=;
        b=RW5YPB37HRsEjDt6Rx8Wp5cgBMoJQlAU2q2oj34MdBfc84s2Xb3yURKQnHKoF8XUo5
         cxBt9QF20UWo9+39fF6i+mxqQTWMav5EMP7tOuA9uJF2KlhjEjQCt3BQSlGVTOI8dddI
         WH/tDf4alCiOZntyQsfnPcRY3pvR0Iyq/dGnXXO3ED8AxDzk+tp6sUB2mg34IGmhGkjb
         EoSqFBC1lbZFsqmbFa2RXVKZ9UYuTiG/Aish5++/wmeXUWFSfXYs2g6Vm7Mb+bEVZQv8
         yIPpBZ9x8/QDsOWuRP9wAIBN5gVhO1n0gWp4yg+HQV5LxIGM3jQuliJDmaqjL5N7YjvI
         1B0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXY+vcEVXH1URBUC5FfmvBt467Vz6v4hLlrYvwQCBqPgkE2CFa6EiGsZ+XvFy3SLlXF3Io9UOCGynje1nc=@lists.linux.dev
X-Gm-Message-State: AOJu0YxZAQpoHb98S6Ua03CU0XpQhVmYv6vCKadk91GmS9Bp1oIhreYA
	773FlBR6OaVClzcvr8WXRGOHvC/1RZhZUi/TsTGE5iSXKB/ArYZEAaqUu5QUaQKqiA==
X-Gm-Gg: ASbGncsGGoxSTdF79Yj7aQPluEti21YnybsDg5UJBc7YHtATRPqVKfpgI6OJZCXzpYm
	H7w9DT4FK3DsSKRk38jAb2YfB1s9e58w1gJrKpcyXt0h0eiNoyr5KEYR0e7DctVv+b6HLVnlK5W
	Grq9nUiC8NEWdo9eOhFipVztgriH66axEkYOgZGYSpo9OkOpJAWGkmgoxZv/Gfr4mk2EmoaD1Vi
	a3S4psJCfBe04n/7EiK0bU0yOqbF85pvs7aKfw7X8vw10ZJ6hAfVUiVV5p1hArlzjAxRz3CJahJ
	ICotNtMjoeHQq80C+T2fzahsIHIFnK2WYa8ZvhP48GAVV3ln65JLE9X0yrid1f7zblX1/tXQPcH
	Wl2xxh2+5FIAwaq2Ty6YLSnSgQuYmpeLvK8QezZrZSq7o0D4wgmllFli2eifBGoXNMxvDRmyj7X
	nGr9PRvivZ7Eno
X-Google-Smtp-Source: AGHT+IGFsjXQDMDVCJ1rn/evMz3fd3PTtDOlV/BZM7pcfvKWARbqj04ku2ig/REcBSICwb5/1B/aQQ==
X-Received: by 2002:a05:6512:23a8:b0:57b:3600:8b4b with SMTP id 2adb3069b0e04-582d092964emr2268576e87.7.1758892295046;
        Fri, 26 Sep 2025 06:11:35 -0700 (PDT)
Received: from ribalda.c.googlers.com (64.153.228.35.bc.googleusercontent.com. [35.228.153.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58527c6b014sm123872e87.43.2025.09.26.06.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:11:34 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 26 Sep 2025 13:11:33 +0000
Subject: [PATCH v3 09/12] media: uvcvideo: Fill ctrl->info.selector earlier
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-uvc-orientation-v3-9-6dc2fa5b4220@chromium.org>
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
 acpica-devel@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

This is a preparation patch. A future helper will remove the selector
argument and use the information embedded in the uvc_control structure.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index aa9de84de9236540c46ee78fb8458873d503786e..98e454fcdeb2ee36d334068fd750e6203931699d 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -2720,7 +2720,8 @@ static void uvc_ctrl_fixup_xu_info(struct uvc_device *dev,
  * Query control information (size and flags) for XU controls.
  */
 static int uvc_ctrl_fill_xu_info(struct uvc_device *dev,
-	const struct uvc_control *ctrl, struct uvc_control_info *info)
+				 struct uvc_control *ctrl,
+				 struct uvc_control_info *info)
 {
 	u8 *data;
 	int ret;
@@ -2733,6 +2734,9 @@ static int uvc_ctrl_fill_xu_info(struct uvc_device *dev,
 	info->index = ctrl->index;
 	info->selector = ctrl->index + 1;
 
+	/* We need to fill info.selector to get the flags and the length. */
+	ctrl->info.selector = info->selector;
+
 	/* Query and verify the control length (GET_LEN) */
 	ret = uvc_query_ctrl(dev, UVC_GET_LEN, ctrl->entity->id, dev->intfnum,
 			     info->selector, data, 2);

-- 
2.51.0.536.g15c5d4f767-goog

