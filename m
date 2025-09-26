Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8244C2F9DA0
	for <acpica-devel@lists.linux.dev>; Fri, 26 Sep 2025 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892304; cv=none; b=nS/h4lO1Wm0+KMSzyx4MID7t1YGTct5pvZ1UIUS0vKdv3Msi5zUdB6/GMm4+sWyUJ+19yuVjyecs+SYdM6Zs876FsJhQFPF0HDwd8Xdb07NNwONZKcIsqIEyfHWos4/joqo/JKP/YYTN3+gCo6Acssh25PF9xt36V+WeDnMV/aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892304; c=relaxed/simple;
	bh=yNrpERf5BIoxndB/IrDgg7F9IXcRYdRqRLfZtrmT8XA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dgcTji7bGjqgRtcOq+hb3z5LKqoZ93XjO+ZDVENzRT4C7/0VI2eaVEd6llWBpwN9Nt3tEWFGYV6AISLMtnsPltGoio8K/1/2qDoUJrUcadc5hhMYjSRdAF1mQRdcfyJ+lFhI3w7/Gn6c9Onycw0+YIVs6E7Tyx9wL1QFkEEqyG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dBBR54yG; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dBBR54yG"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57992ba129eso2440149e87.3
        for <acpica-devel@lists.linux.dev>; Fri, 26 Sep 2025 06:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758892296; x=1759497096; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cjB3MTX3Joa1/7HOctJXxE5CXor1VUYeSlxA+suqIgI=;
        b=dBBR54yGuAx1rpbNofpTbD9VzzHuUjVPz6N9WnpQ0daYWB76i0MppceEQLswJapkSR
         LVxxsI6v0jwHlGR+IlU4R31ir9ym3Nf9XXO5ne5CsbFYGIiH64qNon0hzExk7Qq51xsK
         pg6zvghN6F8Vh0OwCjVuE74m0VUfymz4WP5u8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758892296; x=1759497096;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjB3MTX3Joa1/7HOctJXxE5CXor1VUYeSlxA+suqIgI=;
        b=b9m2GRsXl0sBpXZqcxf4tsaWb5yGMnwuYCPWBZLCKju1nXzalTp5EO4AGMS0JBAkUh
         22JcE31zUwo8vAASf4tbez5l6Bmjk2ZT3GQeDRO2vLLY+1A3QqTJnjAAq2b9123RL1j8
         FdXC7GB1D2tV6VdbejJ9gMaySzwcThWc/fjYfJCGgY6yghURNhDUifS7RE9KQjQs3PX4
         rfszfbB/HiHOBixqeQb2ZFnveh8oAff+Y6Dc3TnWNpmewHZ9q5S8UsAPbTy4ZoY8YqIb
         gx88hY+BFtFbZDHcIru88xQiI8Kd/113/4KzGtYsKow0A3w/+d0PV4ljnWWGTQYsUWd8
         VvuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrzAlc0sMeSytDXn8u+gcnxMwIs69DK2HXJqg3L42VKuEE40USwxCU/BfY5XlLNpBEOzMGvdKBKzRKYL0=@lists.linux.dev
X-Gm-Message-State: AOJu0YxY4q1ex7fVKA72QU6r7LjGiNAxww7bXu+G9nzKSYdbcvHlfWQL
	a+C8jHoUI4mtfxLT0QIUQfbgPmmv5fH5FxDXxzds2WkNHHM0p2mj9se8XruxVeI33GaYaGLUi3u
	iIQPVdQ==
X-Gm-Gg: ASbGnctYnd4ViM9hkzzs0b0dLjpyKrcI0We0F23ctWRXXE7tz+2bWsdBByQsYE2O3w2
	N+roFEKQAvvFRSe2qi34BqPUkpg2xawXey2dkPLVXuYLS/fa5gXKD1DyeDlVo6Zw1JsrPz6z/r1
	ysPOuYB74f/g3NOYE22ZDCvFZJ1bCbp3r+lCYbuBQS9cTCC/OxlX/NM+cLMPIyS+N+Ho5OYMCFQ
	lFO8lCrpLKvFmqjD/SW4CRPv1L0mjnhkahL/EGYsakT59Te3N1MRDxC/yEaYODOUpYeAaRn/UEH
	lTeRPaWHx5DMCK/pmM4owaNp5goOvXf+GNoiBI6eXQW7FWTCXIbYP8HkLbbwpCepMydtWl8NvxG
	pcg8F50E8MPzH+qQWk5gO7us+kKkSQBKrXkO0MGeJxmtSmTASWUarFutCMPdRo+fzFaPYk71seC
	LeOPO7Xde/Ge8w
X-Google-Smtp-Source: AGHT+IHWNSHIhM8+wxqoK25vYQcpiuX3y8F3tCAqdPjxFUiAxRPF90tmVAHpAHEn0gJRDF4m3ruBAg==
X-Received: by 2002:a05:6512:234f:b0:57b:7c83:d33b with SMTP id 2adb3069b0e04-582d34eab93mr2494739e87.47.1758892296391;
        Fri, 26 Sep 2025 06:11:36 -0700 (PDT)
Received: from ribalda.c.googlers.com (64.153.228.35.bc.googleusercontent.com. [35.228.153.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58527c6b014sm123872e87.43.2025.09.26.06.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:11:36 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 26 Sep 2025 13:11:35 +0000
Subject: [PATCH v3 11/12] media: uvcvideo: Use current_value for read-only
 controls
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-uvc-orientation-v3-11-6dc2fa5b4220@chromium.org>
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

For read-only controls that do not support GET_MIN, GET_DEF, GET_MAX or
GET_RES use the current value of the control or a constant number if the
current value is not available.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 76 +++++++++++++++++++++++++++++-----------
 1 file changed, 56 insertions(+), 20 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 017165a5c94459f1befd4c08f85a2017c58d61e6..e99fdf4bafbea662556798fe345a48b9ffd8467b 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1548,6 +1548,50 @@ static u32 uvc_get_ctrl_bitmap(struct uvc_control *ctrl,
 	return ~0;
 }
 
+static s64 uvc_queryctrl_single_boundary(struct uvc_video_chain *chain,
+					 struct uvc_control *ctrl,
+					 struct uvc_control_mapping *mapping,
+					 u8 op)
+{
+	static const u32 query_types[][3] = {
+		{UVC_CTRL_FLAG_GET_DEF, UVC_GET_DEF, UVC_CTRL_DATA_DEF},
+		{UVC_CTRL_FLAG_GET_MIN, UVC_GET_MIN, UVC_CTRL_DATA_MIN},
+		{UVC_CTRL_FLAG_GET_MAX, UVC_GET_MAX, UVC_CTRL_DATA_MAX},
+		{UVC_CTRL_FLAG_GET_RES, UVC_GET_RES, UVC_CTRL_DATA_RES},
+	};
+	int idx = -1;
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(query_types); i++) {
+		if (op == query_types[i][1]) {
+			idx = i;
+			break;
+		}
+	}
+	if (WARN_ON(idx == -1))
+		return 0;
+
+	if (ctrl->info.flags & query_types[idx][0]) {
+		return uvc_mapping_get_s32(mapping, query_types[idx][1],
+					   uvc_ctrl_data(ctrl,
+							 query_types[idx][2]));
+	}
+
+	/* Use 1 as the default step value.  */
+	if (op == UVC_GET_RES)
+		return 1;
+
+	/* Read-only controls can use GET_CUR as min, max and def. */
+	if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR) &&
+	    (ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR) &&
+	    __uvc_ctrl_load_cur(chain, ctrl) == 0) {
+		return uvc_mapping_get_s32(mapping, UVC_GET_CUR,
+				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
+	}
+
+	/* Otherwise, use 0 as last resource. */
+	return 0;
+}
+
 /*
  * Maximum retry count to avoid spurious errors with controls. Increasing this
  * value does no seem to produce better results in the tested hardware.
@@ -1573,11 +1617,9 @@ static int __uvc_queryctrl_boundaries(struct uvc_video_chain *chain,
 			return ret;
 	}
 
-	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_DEF)
-		v4l2_ctrl->default_value = uvc_mapping_get_s32(mapping,
-				UVC_GET_DEF, uvc_ctrl_data(ctrl, UVC_CTRL_DATA_DEF));
-	else
-		v4l2_ctrl->default_value = 0;
+	v4l2_ctrl->default_value =
+		uvc_queryctrl_single_boundary(chain, ctrl, mapping,
+					      UVC_GET_DEF);
 
 	switch (mapping->v4l2_type) {
 	case V4L2_CTRL_TYPE_MENU:
@@ -1608,23 +1650,17 @@ static int __uvc_queryctrl_boundaries(struct uvc_video_chain *chain,
 		break;
 	}
 
-	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN)
-		v4l2_ctrl->minimum = uvc_mapping_get_s32(mapping, UVC_GET_MIN,
-				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
-	else
-		v4l2_ctrl->minimum = 0;
+	v4l2_ctrl->minimum =
+		uvc_queryctrl_single_boundary(chain, ctrl, mapping,
+					      UVC_GET_MIN);
 
-	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX)
-		v4l2_ctrl->maximum = uvc_mapping_get_s32(mapping, UVC_GET_MAX,
-				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
-	else
-		v4l2_ctrl->maximum = 0;
+	v4l2_ctrl->maximum =
+		uvc_queryctrl_single_boundary(chain, ctrl, mapping,
+					      UVC_GET_MAX);
 
-	if (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES)
-		v4l2_ctrl->step = uvc_mapping_get_s32(mapping, UVC_GET_RES,
-				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
-	else
-		v4l2_ctrl->step = 0;
+	v4l2_ctrl->step =
+		uvc_queryctrl_single_boundary(chain, ctrl, mapping,
+					      UVC_GET_RES);
 
 	return 0;
 }

-- 
2.51.0.536.g15c5d4f767-goog

