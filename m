Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969BA2F7AA8
	for <acpica-devel@lists.linux.dev>; Fri, 26 Sep 2025 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892301; cv=none; b=gEk+7hk/wJ9m1Tk8P5zfOu1UMMLo85ZpGOfgFSnPvtpZKlJifLUO8fJgSWWKP+A0qJEHsQFFXb8G9TkuGmyFnAiWz+hjrr7CZi0t6qFhE1gIWIPKH5w2kAjzmYyRXzwBwM5XMVCp6ve56Zfe+TQE5kjc8655eDlcQYVuiXe5DVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892301; c=relaxed/simple;
	bh=747DSL3/0b26gMfctw9GAJQ4wcs8qWL90knTYpPv+GE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K9v2pnCZz6nvOci4V8LQajGP97MLZSUMowvE8/5mnox8BrQsJ9+2WFR8V0Q/yP82Yu5WJ4OTfXS86ZOeyLyaGHgI7SENHb5XLFVEDFiiAfBSKkdk63LrrIub/IfrgD3Me2FKxSbcyhg/m9oevT7aoCX8o2renKUOLVRKZZwk8oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SETFh7gr; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SETFh7gr"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57d5ccd73dfso2129287e87.0
        for <acpica-devel@lists.linux.dev>; Fri, 26 Sep 2025 06:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758892293; x=1759497093; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEFN0lLdAUAhxOrw8NBMU68FYdHDfoPQjtv/CBRcNWg=;
        b=SETFh7grA/TRouT7c1FJvK0V3tT0EqfhL1Npp0rabY2JypxlaHA+fsUuINOkZ0GqDE
         jlBRsnq5HnDcr8J/ZcvTCq/56QwrN6BgCVrKRrIxt7BmCOhG2YfyrEZ8zYr07lMSdw50
         FMJm47KZ9CeZ0sSXGrQzvXX62/87Twk6r01Bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758892293; x=1759497093;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PEFN0lLdAUAhxOrw8NBMU68FYdHDfoPQjtv/CBRcNWg=;
        b=OYy2qxCW2/diRmqnylbIZeyFeEonA3PLyV6bIDgepUBVOLoRZud+rU1pfeKW0ybWlf
         TIO3lC8IW+VwJh8er1nZTdCOl0hFiQL+yjsOc5X6VmXYeYGzLCcFHTiP3sGxiddvO+g7
         AXPpc+8EmNfciNb1Ko8z9q+yrIETEwEel7b/p4/UdHxcDmAg19dfxKcUFablsrEBKTww
         fJAtsu5Pf8Sq+coy1q91DN3KMl7lakNDx4hGzpjHoFoSfvcEvn4ObznhLhTL9tfrQhir
         5TaTzeUf8Kk/joU4ouytBVFUVtvf+I8528a+oRoDkw25AXYQ8Vef+7dIsQtJN8w/Yvl2
         wD/w==
X-Forwarded-Encrypted: i=1; AJvYcCVViEe4kbWDPv9PpHHAG7ofbMNzAVYIENWKnVEqs5d4ZvawVVX+CpZnHuiHHbIbJVsOhA8Yfij0C1mVmN4=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywb6TweiOP/SAjMaVP0VWGbFkTEThVssaj8MjloTvxmdjsOJdCG
	YTP0fXTKxyM2Airyz+UbIgzEvp7vf9Lh16MzEOsRxY2fEmOy90uXJgoKary/VbAuOJSnJrlwFoS
	NMjPoeg==
X-Gm-Gg: ASbGncvR6hWcB7OCT1rD8RAdqHBtpVMRNWm7ckRHFNn8Uoq9A8sQSereQOy8w/NASPa
	qKEKxNemuHEY/GvDql7OM3DxmWsvMQ1uCqm0sbwNK0yHmRsNCieWbxOEYAUZW27bBY9PKjTk4wk
	e6OyAKxHwS9UKX58kzyb4U26FQXZ9/KlXPnRjBbkE6gHX1dQhjl+OBzWA2FyBzfy8xjd5QMXhiw
	AghU6tA+sl7Uk5seLyUoDNSj82Uv61a5nbzpEqMQNEWam/enzm8EzDug2Gm4joaSvnLfb9hps+2
	QFdigqgM1125X+lV3XsA2lQCn9ws9FYFaVbug+WKmPInyPSxnly4HbQcztgtxY1CjZOYNIAAeST
	TvGfcwawZipGBUtYAVMOQpAppsK8x7CS21VQvvYMvy69kCI+6zv1cTkiIRjK0BIk9vu43QvV+ou
	xQ/g==
X-Google-Smtp-Source: AGHT+IHoXncX6KzHuffRNxD1bdNRByMLtGFUXJU+Vx+pJpeCHx/eyFalgZtv/Aq9A8oN/XwwQ6kRbA==
X-Received: by 2002:a05:6512:e9e:b0:563:d896:2d14 with SMTP id 2adb3069b0e04-582d2b4cb9amr2443275e87.36.1758892293127;
        Fri, 26 Sep 2025 06:11:33 -0700 (PDT)
Received: from ribalda.c.googlers.com (64.153.228.35.bc.googleusercontent.com. [35.228.153.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58527c6b014sm123872e87.43.2025.09.26.06.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:11:32 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 26 Sep 2025 13:11:30 +0000
Subject: [PATCH v3 06/12] media: ipu-bridge: Use v4l2_fwnode for unknown
 rotations
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-uvc-orientation-v3-6-6dc2fa5b4220@chromium.org>
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

The v4l2_fwnode_device_properties contains information about the
rotation. Use it if the ssdb data is inconclusive.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/intel/ipu-bridge.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index 441d1a5979fe94bee4738da68e185a44dbd411d4..6155046ef4fc6b5d074194d1b8113212304136bc 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -242,19 +242,23 @@ static int ipu_bridge_read_acpi_buffer(struct acpi_device *adev, char *id,
 }
 
 static u32 ipu_bridge_parse_rotation(struct acpi_device *adev,
-				     struct ipu_sensor_ssdb *ssdb)
+				     struct ipu_sensor_ssdb *ssdb,
+				     struct v4l2_fwnode_device_properties *props)
 {
+	if (props->rotation != V4L2_FWNODE_PROPERTY_UNSET)
+		return props->rotation;
+
 	switch (ssdb->degree) {
 	case IPU_SENSOR_ROTATION_NORMAL:
 		return 0;
 	case IPU_SENSOR_ROTATION_INVERTED:
 		return 180;
-	default:
-		dev_warn(ADEV_DEV(adev),
+	}
+
+	acpi_handle_warn(acpi_device_handle(adev),
 			 "Unknown rotation %d. Assume 0 degree rotation\n",
 			 ssdb->degree);
-		return 0;
-	}
+	return 0;
 }
 
 static enum v4l2_fwnode_orientation
@@ -297,7 +301,7 @@ int ipu_bridge_parse_ssdb(struct acpi_device *adev, struct ipu_sensor *sensor)
 	sensor->link = ssdb.link;
 	sensor->lanes = ssdb.lanes;
 	sensor->mclkspeed = ssdb.mclkspeed;
-	sensor->rotation = ipu_bridge_parse_rotation(adev, &ssdb);
+	sensor->rotation = ipu_bridge_parse_rotation(adev, &ssdb, &props);
 	sensor->orientation = ipu_bridge_parse_orientation(adev, &props);
 
 	if (ssdb.vcmtype)

-- 
2.51.0.536.g15c5d4f767-goog

