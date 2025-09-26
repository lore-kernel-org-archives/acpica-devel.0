Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCACA2F656B
	for <acpica-devel@lists.linux.dev>; Fri, 26 Sep 2025 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892301; cv=none; b=E9o7STpLk1wQtbydziVWod/dBoHNb+Q0x2WW8J5WV1HF2TRSFJaZVoP6STwabEFnh0TxF+dQs5vD0C/il2vg136dh5RIT+ujfbqAQBoz4knQZAy10IgL8j2ulRcHOzlvWz5i6UssfWzxK8hmzPony0oTRDgX8MdPUv7x3vChIsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892301; c=relaxed/simple;
	bh=8QXukFFdhrRn2peTuBfsWRiyR8y/J2hEQydiLTT8V2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TEcE50pSpSL4Ah3pSdIwYI37MGjgqfPoV63ydRDgImbc8xBwUIQkWuGhfo7Rz+8hIQk76Q5puviIC4EIdn9ukn20Y9cJMHrrwK2yrpYV2Hk7fPPT+cn3EhUsSaxRMkCGu7cgIH7xhlAvMc6DkLtT9jxgkNrFFZQyCqAW8LE8SnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XdjVqt9x; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XdjVqt9x"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-57a960fe78fso2398151e87.2
        for <acpica-devel@lists.linux.dev>; Fri, 26 Sep 2025 06:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758892292; x=1759497092; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+IULFJYV86S6ZpfwTIK6NKFvLB7brLHHTAANiqsCeGE=;
        b=XdjVqt9xRMPklaqGSv2qGsjDXpvdBYoq8C6NxyXXcb191j36FaElPe/u19ZpxcJ298
         BwTMhGY27y/nL7IA6oUSr8jemTvs3AUAsh1XtHaxwXzZ3k8tL8w/wpwitgW92LnGHFNH
         YAJ7nROjZ9AEZmafqcqUm/WviHP8/9C8kYTgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758892292; x=1759497092;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+IULFJYV86S6ZpfwTIK6NKFvLB7brLHHTAANiqsCeGE=;
        b=nwbDdONpBZulGgstAwDw3eM1XnSuZhQlmUbXMZ6wM7LQ2SGOeIQd1OFWai5wHNultM
         YBYrBWcf6HWsg6cwImbOvhPnI2W9oOdXiexul0o5QGpUgHlC6oKA+Zyh80xedfwptl1z
         VaJ1qhZnvrxJpPmBjl990x2bioFxd0VRCKUHaWLjDw1PeQiQB8BgsOTRvL6hUCnizq1b
         vHaiD1HN3joR32M0Ii6aAPaijR8qI8blujwkGamynK5oNN97IEQS1s1u+59IGdO/yq1o
         2NP3ObF+jvmxpxWbXVLFoPf9K6Xqt4SZUdAxjqtEsS8ebAsBtJ9LWnMqdjrEbMfIQMaF
         vPgA==
X-Forwarded-Encrypted: i=1; AJvYcCU8l504kTw/LeWHFZEbTlKaewNlxMvtRu6I+CbvwFQJOhd01U38sdZBiRol5Zl63kHTGtOfcaSiYFPn7g4=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzryjd2dFA5GMS7tIubJ5c/gi+qxmW9G9Jk2NxeeULctEWQV00J
	f18SD7kHjHEW0tbIQ67FO5mL1b/yrlcX77wZ/Osx5pkGxBmvKkKvuixLmD6/RQiwdw==
X-Gm-Gg: ASbGncsNoqsNrKvg0xP3hdooReCJxfv17V5BMpsImUI0UrHNVIlcNIwYK9vouqZPGNv
	vchql79RnPsAVhtJWhNGnSlNBO9aZR+7lYHh9aVj/3ayE2fa7dYvWnqvwR8Qg+xi4wac2Gc5SPC
	wcP/y7+Swk/j6+UIFmAKprZuC2LzYI0Z2UJTZIOC61XAXzP8G3LA3qr4CXS19ug8BJfEAhdHR2g
	Wkuk2+iOP5gJVb5czLOTidk0mRKJTMqhbp0qsfe54fD3qedijyHNAaOoirO8Efa3bC1dZO45ktg
	RXhCTD3usrv8fuz+Wvok0Tcqu1I78UrYqP7TCHa3BkuYJOVEoqQVr8ZFWCCeXHakll8RyO57yXO
	KoSQGg7zLyL60+JJJlSW2Qj2kjFSMe87vto47DfzbegkH0Abb3Ghqm2NLIg1SKJJ16duLjggf8l
	twc18gR+gA9/sr
X-Google-Smtp-Source: AGHT+IE/r2pIJwf7kAuauI+jC65tbRl8WC4I4+SdoNtU43PxQUMr/4vfCOnHocv1AyDV3BygK1ERFA==
X-Received: by 2002:a05:6512:2201:b0:570:e55e:47fc with SMTP id 2adb3069b0e04-582d3c9674cmr2179748e87.54.1758892292030;
        Fri, 26 Sep 2025 06:11:32 -0700 (PDT)
Received: from ribalda.c.googlers.com (64.153.228.35.bc.googleusercontent.com. [35.228.153.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58527c6b014sm123872e87.43.2025.09.26.06.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:11:31 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 26 Sep 2025 13:11:28 +0000
Subject: [PATCH v3 04/12] ACPI: mipi-disco-img: Do not duplicate rotation
 info into swnodes
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-uvc-orientation-v3-4-6dc2fa5b4220@chromium.org>
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

The function v4l2_fwnode_device_parse() is now capable of parsing the
_PLD method, there is no need to duplicate the rotation information in a
swnode.

Reviewed-by: Hans de Goede <hansg@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/acpi/mipi-disco-img.c | 15 ---------------
 include/acpi/acpi_bus.h       |  1 -
 2 files changed, 16 deletions(-)

diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-img.c
index 5b85989f96beeb726f59ac9e12e965a215fb38f6..b58b5ba22a47a4afc5212998074d322f0b7586dc 100644
--- a/drivers/acpi/mipi-disco-img.c
+++ b/drivers/acpi/mipi-disco-img.c
@@ -617,21 +617,6 @@ static void init_crs_csi2_swnodes(struct crs_csi2 *csi2)
 
 	adev_fwnode = acpi_fwnode_handle(adev);
 
-	/*
-	 * If the "rotation" property is not present, but _PLD is there,
-	 * evaluate it to get the "rotation" value.
-	 */
-	if (!fwnode_property_present(adev_fwnode, "rotation")) {
-		struct acpi_pld_info *pld;
-
-		if (acpi_get_physical_device_location(handle, &pld)) {
-			swnodes->dev_props[NEXT_PROPERTY(prop_index, DEV_ROTATION)] =
-					PROPERTY_ENTRY_U32("rotation",
-							   pld->rotation * 45U);
-			kfree(pld);
-		}
-	}
-
 	if (!fwnode_property_read_u32(adev_fwnode, "mipi-img-clock-frequency", &val))
 		swnodes->dev_props[NEXT_PROPERTY(prop_index, DEV_CLOCK_FREQUENCY)] =
 			PROPERTY_ENTRY_U32("clock-frequency", val);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index aad1a95e6863d443a45985ba7ec7be4acf8664fe..296716875a3e7977abb7b7dfa89f78664aebd61c 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -389,7 +389,6 @@ struct acpi_gpio_mapping;
 #define ACPI_DEVICE_SWNODE_PORT_NAME_LENGTH	8
 
 enum acpi_device_swnode_dev_props {
-	ACPI_DEVICE_SWNODE_DEV_ROTATION,
 	ACPI_DEVICE_SWNODE_DEV_CLOCK_FREQUENCY,
 	ACPI_DEVICE_SWNODE_DEV_LED_MAX_MICROAMP,
 	ACPI_DEVICE_SWNODE_DEV_FLASH_MAX_MICROAMP,

-- 
2.51.0.536.g15c5d4f767-goog

