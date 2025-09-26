Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC9E2F60CF
	for <acpica-devel@lists.linux.dev>; Fri, 26 Sep 2025 13:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892302; cv=none; b=hYmo1LKEPEjLi1/4qEYLtHnQ9b3Zyh4rMWFo7jk3vDsLTwv6Oy7HXYaB8QT0DiDubCTXCXSZJViX5V4ZelUk6W6htxM0X+d2BJzB+l0Y8SiHYE7a6jY8Q1n8OvLksuWlhhdWR8mPNY6++Y5ru0YC+BOoySAV7wo953j3Hm8oTEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892302; c=relaxed/simple;
	bh=tSZ4e7bBWYDXs+64s5deuA0eU78Hb20V1QttJt4YMDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gUGNEwQOwTT1JwH6avx87tgkg70ZlgRCaPIoptbTxd+4MbbdcqOKprtrM7ERcik5yXEvqcSCx+mqNZG6GgBeMlcllyY7R8KqYxaSoGfKHdI+CPxnAomC8b3D29frs+Sm5AErQNKYYknRbmfL/zpG+4ZZNd5XP29U4xNEnA8GLas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nVi7xRu8; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nVi7xRu8"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57dfd0b6cd7so2580099e87.0
        for <acpica-devel@lists.linux.dev>; Fri, 26 Sep 2025 06:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758892296; x=1759497096; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bphRunTYPw61AUvJ/YpfJ9I70eYp7wtD0WzfXD7gDd4=;
        b=nVi7xRu8I6BUsfLU6mkCBoMTRYllMf9Xy/3fw2IPCbz309NqnDwa5eBocCz7HTN7Rg
         FU5qyAJznTmJIAOqcSWN9uFeI1Z/MUqo67gnj6QVj5SBf05LoXACVHsNW3DowR+jUTAu
         E5hYDr6HBI5LYaEsfHvfrHnENCyy7TUIVy70E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758892296; x=1759497096;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bphRunTYPw61AUvJ/YpfJ9I70eYp7wtD0WzfXD7gDd4=;
        b=JLs543Inup9wW5h40WkB6MW6SwBdPmLo5PVLG7il86QUkzs6PRLuAxye3i5+QS8EPL
         Cbp6cq68k+BiAy5KgzZpGRLINXFHiSskfKYxBR0C1Z7k9H2j/kea+22q9t1spHEoQ3tz
         5U8ebFObFgbBxCqQ+QE0D5s+i8cG0NCnRiUk0cQX8MeMO9hU8dhUPamUBTpHXU65y2K6
         ve2B82bFSApiA5Hq/IgkxGT+D1YKEmxvOpo6l5SCrS0q/hMPKsQ/dzlxTD8SURhl0R0D
         d0B8Yy75vwYEVkwzdcjBdF3xO5gnjBlRzvh9aApuZKZonEf/JZ/cRDhU5HvWr/Kr2mzP
         OfLA==
X-Forwarded-Encrypted: i=1; AJvYcCX7eAj+mnpMhvuGJvc+q3kIUp1X8RpKRY2LV+oXF0pJl9izOosfht6Lz8zLk7Hh+QDe7Q9vz229ylNqtU8=@lists.linux.dev
X-Gm-Message-State: AOJu0YwIJUpKyCg++GPg7OZojqpt0OJQgWL5CIo254lmJAHvMPK0KWEL
	K7FCVD5avy3VORrtMI86y8nvf33SpLINFFWwpz1+8kN54QnYdaWorhlSK1cstjnrbA==
X-Gm-Gg: ASbGncuCoLfC7Vfgn3kD29z1lWNWeyVO3rVVJth+VXp5jTUx1OlgkE1F/6YUfrkxbFZ
	bcTlYaiaFQ9TzeLeldDk2YT6d46MKppkU0Jiz7UmwpThklhglMvG13rovvmv8c+a43e2cKfA8V4
	M0XCDEI8tgwEzRHBkciaUe+MDWoaZ9WN4rQ8QYS85l2YpM2t4M0WbloxJhTjnkbaYQ5qIMecYCx
	gIeI+2VnsOgk4QQnn/vL4eTMrMwkD4YSvC2Mewi9RFNank7GtRAL8wDg0yhldcCzX2O6zAKYdP4
	6DOedx+gneuDogr8uXUH1u4m5cpT+1IlEDkyftihhOd84uGZcX1/3GyS/PmGbfisnvUmEBwPoMB
	ec8sG05gtTsaiN4rh0bBxyLK1Q2Wj/R8CtXxETPNlUzElEj8RbgFvpdKHMcQm1qgJSZ1iSV3cOc
	/Tt2LJ7ZZY/ppS
X-Google-Smtp-Source: AGHT+IEv9MbC6V8zP0dxYjK1OB4iFK32py7NZfWALirf9hP7Mf6Qwl9MxHAyd3yZAKgRpXN6nv2Waw==
X-Received: by 2002:a05:6512:3f1b:b0:571:86bc:423b with SMTP id 2adb3069b0e04-582d3f76d9fmr2145509e87.44.1758892295887;
        Fri, 26 Sep 2025 06:11:35 -0700 (PDT)
Received: from ribalda.c.googlers.com (64.153.228.35.bc.googleusercontent.com. [35.228.153.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58527c6b014sm123872e87.43.2025.09.26.06.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:11:35 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 26 Sep 2025 13:11:34 +0000
Subject: [PATCH v3 10/12] media: uvcvideo: Add uvc_ctrl_query_entity helper
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-uvc-orientation-v3-10-6dc2fa5b4220@chromium.org>
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

Create a helper function to query a control. The new function reduces
the number of arguments, calculates the length of the operation and
redirects the operation to the hardware or to the entity private
functions.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 83 +++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 40 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 98e454fcdeb2ee36d334068fd750e6203931699d..017165a5c94459f1befd4c08f85a2017c58d61e6 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -598,6 +598,36 @@ static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc15 = {
 				  V4L2_CID_POWER_LINE_FREQUENCY_DISABLED),
 };
 
+static int uvc_ctrl_query_entity(struct uvc_device *dev,
+				 const struct uvc_control *ctrl, u8 query,
+				 void *data)
+{
+	u16 len;
+
+	switch (query) {
+	case UVC_GET_INFO:
+		len = 1;
+		break;
+	case UVC_GET_LEN:
+		len = 2;
+		break;
+	default:
+		len = ctrl->info.size;
+		break;
+	}
+
+	if (query == UVC_GET_CUR && ctrl->entity->get_cur)
+		return ctrl->entity->get_cur(dev, ctrl->entity,
+					     ctrl->info.selector, data, len);
+	else if (query == UVC_GET_INFO && ctrl->entity->get_info)
+		return ctrl->entity->get_info(dev, ctrl->entity,
+					      ctrl->info.selector, data);
+	else
+		return uvc_query_ctrl(dev, query, ctrl->entity->id,
+				      dev->intfnum, ctrl->info.selector, data,
+				      len);
+}
+
 static const struct uvc_control_mapping *uvc_ctrl_filter_plf_mapping(
 	struct uvc_video_chain *chain, struct uvc_control *ctrl)
 {
@@ -1256,35 +1286,27 @@ static int uvc_ctrl_populate_cache(struct uvc_video_chain *chain,
 	int ret;
 
 	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_DEF) {
-		ret = uvc_query_ctrl(chain->dev, UVC_GET_DEF, ctrl->entity->id,
-				     chain->dev->intfnum, ctrl->info.selector,
-				     uvc_ctrl_data(ctrl, UVC_CTRL_DATA_DEF),
-				     ctrl->info.size);
+		ret = uvc_ctrl_query_entity(chain->dev, ctrl, UVC_GET_DEF,
+					uvc_ctrl_data(ctrl, UVC_CTRL_DATA_DEF));
 		if (ret < 0)
 			return ret;
 	}
 
 	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN) {
-		ret = uvc_query_ctrl(chain->dev, UVC_GET_MIN, ctrl->entity->id,
-				     chain->dev->intfnum, ctrl->info.selector,
-				     uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN),
-				     ctrl->info.size);
+		ret = uvc_ctrl_query_entity(chain->dev, ctrl, UVC_GET_MIN,
+					uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
 		if (ret < 0)
 			return ret;
 	}
 	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX) {
-		ret = uvc_query_ctrl(chain->dev, UVC_GET_MAX, ctrl->entity->id,
-				     chain->dev->intfnum, ctrl->info.selector,
-				     uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX),
-				     ctrl->info.size);
+		ret = uvc_ctrl_query_entity(chain->dev, ctrl, UVC_GET_MAX,
+					uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
 		if (ret < 0)
 			return ret;
 	}
 	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES) {
-		ret = uvc_query_ctrl(chain->dev, UVC_GET_RES, ctrl->entity->id,
-				     chain->dev->intfnum, ctrl->info.selector,
-				     uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES),
-				     ctrl->info.size);
+		ret = uvc_ctrl_query_entity(chain->dev, ctrl, UVC_GET_RES,
+					uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
 		if (ret < 0) {
 			if (UVC_ENTITY_TYPE(ctrl->entity) !=
 			    UVC_VC_EXTENSION_UNIT)
@@ -1325,16 +1347,7 @@ static int __uvc_ctrl_load_cur(struct uvc_video_chain *chain,
 		return 0;
 	}
 
-	if (ctrl->entity->get_cur)
-		ret = ctrl->entity->get_cur(chain->dev, ctrl->entity,
-					    ctrl->info.selector, data,
-					    ctrl->info.size);
-	else
-		ret = uvc_query_ctrl(chain->dev, UVC_GET_CUR,
-				     ctrl->entity->id, chain->dev->intfnum,
-				     ctrl->info.selector, data,
-				     ctrl->info.size);
-
+	ret = uvc_ctrl_query_entity(chain->dev, ctrl, UVC_GET_CUR, data);
 	if (ret < 0)
 		return ret;
 
@@ -2244,11 +2257,8 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 			continue;
 
 		if (!rollback)
-			ret = uvc_query_ctrl(dev, UVC_SET_CUR, ctrl->entity->id,
-				dev->intfnum, ctrl->info.selector,
-				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
-				ctrl->info.size);
-
+			ret = uvc_ctrl_query_entity(dev, ctrl, UVC_SET_CUR,
+				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
 		if (!ret)
 			processed_ctrls++;
 
@@ -2650,13 +2660,7 @@ static int uvc_ctrl_get_flags(struct uvc_device *dev,
 	if (data == NULL)
 		return -ENOMEM;
 
-	if (ctrl->entity->get_info)
-		ret = ctrl->entity->get_info(dev, ctrl->entity,
-					     ctrl->info.selector, data);
-	else
-		ret = uvc_query_ctrl(dev, UVC_GET_INFO, ctrl->entity->id,
-				     dev->intfnum, info->selector, data, 1);
-
+	ret = uvc_ctrl_query_entity(dev, ctrl, UVC_GET_INFO, data);
 	if (!ret) {
 		info->flags &= ~(UVC_CTRL_FLAG_GET_CUR |
 				 UVC_CTRL_FLAG_SET_CUR |
@@ -2738,8 +2742,7 @@ static int uvc_ctrl_fill_xu_info(struct uvc_device *dev,
 	ctrl->info.selector = info->selector;
 
 	/* Query and verify the control length (GET_LEN) */
-	ret = uvc_query_ctrl(dev, UVC_GET_LEN, ctrl->entity->id, dev->intfnum,
-			     info->selector, data, 2);
+	ret = uvc_ctrl_query_entity(dev, ctrl, UVC_GET_LEN, data);
 	if (ret < 0) {
 		uvc_dbg(dev, CONTROL,
 			"GET_LEN failed on control %pUl/%u (%d)\n",

-- 
2.51.0.536.g15c5d4f767-goog

