Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1592F6173
	for <acpica-devel@lists.linux.dev>; Fri, 26 Sep 2025 13:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892296; cv=none; b=hvF1AhEP+5huOGOw40c0NIik5eCuHdDxXjtKO6CKB0zzwEntuepe0difUWobsUmoQbrZ/HhVEKtkADDmMfPRNvb9QG+FgSKUFzuSzNYNwOpHJrKJF6o8Le9JjWvM7QdZiJ/rImntmtu6yKjGN85RE2UXE57j9VzBQilVH58+gbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892296; c=relaxed/simple;
	bh=HOaXKeMMBeof7Hx+tzoNDTO3vGlaHvg7CjV+p573b/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kwI3//DT07wTtKTZpf9zi3TdjEh94vbmUX9FlPSEBLmPapttFpjHlgGs4sqHX9TQtljQUgWs+S8OGlPCiriGDRSTSnxyaLPhkRbRGdT1eN1SDuhYbzH1nOjeGbLpslX0t9guk9wO0OjL0dMl02PKLa55nmPd/ZYfuJkQxBwseuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Psi5Bd5n; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Psi5Bd5n"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57b8fc6097fso2744404e87.1
        for <acpica-devel@lists.linux.dev>; Fri, 26 Sep 2025 06:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758892291; x=1759497091; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zavqbvAJpl+vVyZ8ZvtBFYz19hBaBOc/P6wczkVBqDY=;
        b=Psi5Bd5n91SoWcZ2ROR0XEr4WQ3+33HizE6dC36yOdJvvxSRvcaKiMJtOK/XQArELm
         4P88HXhSuTj02kr0NQSKBVynrpygfE242sTeLmY0BrAaZ/PtIyOS1INrHI5NZJXtttDc
         VHt9pC5lQKJ41C0QvpOINd2bnrpqKDsCebJto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758892291; x=1759497091;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zavqbvAJpl+vVyZ8ZvtBFYz19hBaBOc/P6wczkVBqDY=;
        b=Ea4ty9OhcoOmBzhgEveWuvojm32QKg/k5gwNppZZN/hXYXQ9bw0pTAMcH7ZGsEXG69
         4r9nM9wf6ragArbNCevp24V0EDfVWd8bhKsSKySUEOK7thO1m6Y82YB3sDiyjpLRmQ8W
         9B8WFQ/3LEoGGUHpArOddhOm83R6Kk3k5GHVYHNrOuJ5dGrhZsDRYzOVBhWhR4cd5tJr
         Am80e7g6e5dfxrmPnWeOW++7BeGYkieljGkgi2LNU4aHQKVkHheTkkOYig2Oq9zHbfau
         CcuSO3ljh3WKiGDNSZMJCCyCuPmEJd4OHv4TLcyPUbRvCGmERzZbqN5zSWTlA70k9EPL
         Rc8w==
X-Forwarded-Encrypted: i=1; AJvYcCWvW8i/nOT5jE5x1iRTjC3jFEALM4IzVMJt3iGf8zmVXrWfeNP+/emEtrQ6wyAKQpYjIAjodw00vn4tbn8=@lists.linux.dev
X-Gm-Message-State: AOJu0YyT765pfKP5CxbdKG6BhGc9xLSkckdGdMg1NdwrG1GBS3Jq2mCg
	hUFDGn1PZd34H8MWRMPfzObx/6v/7W8+qm9u1tY6XpiiYa0ECDiu49datWf115vqDw==
X-Gm-Gg: ASbGncuTqPAoihFiv91TQRNG83pkMDToG/GmpMAkdlypZy/YMPctIFu1fTgaJ6v8rHG
	AeHbj/58mRJf1UINCgEsuH0Jb/ZTIlxLYxnUdgxu1L1PFkY4L02cBxSIp8Kkc4WvRDeL1rGlUEv
	3G/veLrVRb/UWFiyMMZrD3+fYWxCG2GN9TeY3Fc4/Um4NSc/bqvzMbByYIEMNr5EDGTrEdQ8XlM
	joGeMXJBmTpzCi4+39gcrBGLYR86YkHcUB7RJO3JwZ5EPq7Ye+ifa4U5cyxn72l7KzLJtDMsdyQ
	10R+GYz6fOSPzKCUKhOj2wz8Ondlf7hM88Oqw8vgWkiO0ss2kXHYPi6aRmf3HjlKUrCbR+Bslwf
	1Qwhyqw8SRIkV0pxIPjJP4L/lwqGmySrlvI1eiE2mQ4TiQ0o3WqueG9btFt6wQKTG2ylQcevBcF
	Ir3FMjw+S9e0b+
X-Google-Smtp-Source: AGHT+IGYNymib7YkYpDINQtE5FTKayVP9W8HaNUBBncx14Dot8LXrbwZoz7D11yG6qpiPKpfo0xmbQ==
X-Received: by 2002:a05:6512:b27:b0:55f:435e:36bd with SMTP id 2adb3069b0e04-582cd97cc3dmr2187251e87.0.1758892290687;
        Fri, 26 Sep 2025 06:11:30 -0700 (PDT)
Received: from ribalda.c.googlers.com (64.153.228.35.bc.googleusercontent.com. [35.228.153.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58527c6b014sm123872e87.43.2025.09.26.06.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:11:30 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 26 Sep 2025 13:11:26 +0000
Subject: [PATCH v3 02/12] media: uvcvideo: Set a function for
 UVC_EXT_GPIO_UNIT
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-uvc-orientation-v3-2-6dc2fa5b4220@chromium.org>
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

All media entities need a proper function. Otherwise a warning is shown
in dmesg:
uvcvideo 1-1:1.0: Entity type for entity GPIO was not initialized!

Please note that changes in virtual entities will not be considered a
uAPI change.

Cc: stable@vger.kernel.org
Fixes: 2886477ff987 ("media: uvcvideo: Implement UVC_EXT_GPIO_UNIT")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_entity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_entity.c b/drivers/media/usb/uvc/uvc_entity.c
index 3823ac9c8045b3ad8530372fd38983aaafbd775d..ee1007add243036f68b7014ca621813e461fa73d 100644
--- a/drivers/media/usb/uvc/uvc_entity.c
+++ b/drivers/media/usb/uvc/uvc_entity.c
@@ -85,6 +85,7 @@ static int uvc_mc_init_entity(struct uvc_video_chain *chain,
 			break;
 		case UVC_VC_PROCESSING_UNIT:
 		case UVC_VC_EXTENSION_UNIT:
+		case UVC_EXT_GPIO_UNIT:
 			/* For lack of a better option. */
 			function = MEDIA_ENT_F_PROC_VIDEO_PIXEL_FORMATTER;
 			break;
@@ -105,7 +106,6 @@ static int uvc_mc_init_entity(struct uvc_video_chain *chain,
 		case UVC_OTT_DISPLAY:
 		case UVC_OTT_MEDIA_TRANSPORT_OUTPUT:
 		case UVC_EXTERNAL_VENDOR_SPECIFIC:
-		case UVC_EXT_GPIO_UNIT:
 		default:
 			function = MEDIA_ENT_F_V4L2_SUBDEV_UNKNOWN;
 			break;

-- 
2.51.0.536.g15c5d4f767-goog

