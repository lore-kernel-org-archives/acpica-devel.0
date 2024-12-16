Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2693D1DB933
	for <acpica-devel@lists.linux.dev>; Mon, 16 Dec 2024 21:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383855; cv=none; b=Qdkc1c4N8TGJhTf17eA3TWOJI8HmjIqjCssBcsh/ngDPSksGP3hIoX27P9uu9COG8FoBlQIptV6+NFt7omx+0sNv+yd8hPtbNRQnuT1KOcGDpTje7nk54IJGAP0/Rsl5DrosKrjt3o1xnMGEWLS1/lwPI3igBm3ejmfN3luC0f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383855; c=relaxed/simple;
	bh=IKB58y4snq/gqAR94o4C+T0eqQtkn7ecDZk3e6CYE68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M4W9mwy76o+BG53LF+qWbJ2ezqfnBAA3YAI/AhJNFQ+SnnvBXnp1m4Px4ladfuvN1LsEKY3XzLHUf5/v2X1LBOvWKMMdsnDuIMK97ekjBDpuUjTZDNEWno9VQF2R1qIJr/it9zu3vwQHfn/HTXqTcbI/LwZ6aWJI4yrqaoJoUgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AkXPp5a8; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AkXPp5a8"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-468f6b3a439so5579311cf.1
        for <acpica-devel@lists.linux.dev>; Mon, 16 Dec 2024 13:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734383852; x=1734988652; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pSt2f8yebuqnlO+DsTFByKH2G3GRiRhWURC3O1KFqeY=;
        b=AkXPp5a80zwGIZrCLwDgO7shWGZmNeyh2RUnj45XmcwdMIoGsEQAdXqnULcYzcTIaD
         ieYDWwKqvZP/tF45lLnKeCB1+d+A/d6vMG6WZzlcZ7WVr5fu8nWZVABG6DMrjK+9P8dI
         FbZ9jwv6oCf/BT9LxhuyBl5LPuOu1uN/YIgMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734383852; x=1734988652;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSt2f8yebuqnlO+DsTFByKH2G3GRiRhWURC3O1KFqeY=;
        b=cbfPruzd7Oo0fPkq2ukU4EwIVLxJsaJXJLkZLJCHm0gGAMPnn8OH09jgBwoNZUmeFq
         ak6fcpL31ChO+ZxwkP8g9x6gGFCknT68RN76E3DN0uonG/jli6lHwm409SDaX3yV5Z7E
         pr5oBgwD6Pit7e5flC1SUlZumfd+YBdJAk+fiUEYytR9Cya4RRAzEyjoepdwFdE2eHXS
         PWRZPCiKm+8lseJM/KtkffI4IZVb4sArIGNbUZ1nDpRl8Wmutg2Ezsf+KTOY4bUgjYRt
         2MPwZNqMTA4CRaCqHRacNJT7YOn7v7AHOwE9qBQmkb9VfvAm2KzVTFwG8Pf48TXAREoi
         5VPw==
X-Forwarded-Encrypted: i=1; AJvYcCVVldb8t+GVpYUZ+9cT/pdbukZPyW0hbl4WMkOErlQrdCEgGp/E6xulcpgErAxNT8EpAIZwarMgl5zNOLw=@lists.linux.dev
X-Gm-Message-State: AOJu0YxQVuuSwfYTgEFNi4uOy9WdAa/OLAKKiNMngONP+k23B39YJ0IJ
	x9cGZ/BWejY4m7JTuUXU+X43rTrUaoz+FBD5AmWLjY/hNSEyPvR6VmwtClTqvA==
X-Gm-Gg: ASbGncv5oGOVGQhuWafE1CasJ7MqnnpCa68k68OWlZhCyxjI7vZdWRZYw+ylqAdYN4c
	/JCUT+7OOOXh4lnHWZuPloDz/SFVH2yvCweaMJLQWUSOnWBE1cnibl2NbcY52c532OnSZUowmpm
	bYOs55U/zNxYft7yAGExCTn3ylbIiXCcy7hGXG/kkKRcBpwEYG+tJpsG1t85xnx0KCMA2FZA0ZY
	pCEkvTambQLSGSXN5pGwbZWcs8tKyMOcKzmAe0/B/GeYttyiL3tZiEQgkOPp0ABErnw59aSpUb9
	aazjAaKXf0nsGlOlIxETAF64ZaPrs08=
X-Google-Smtp-Source: AGHT+IGA7OE2/+AFr8NJQp1+beNCjHTix5HDCvzlrGBd1KJenMxv6YV5fSV7uyPrfaZdLlcoEJkjrQ==
X-Received: by 2002:ac8:5a93:0:b0:466:a983:a15a with SMTP id d75a77b69052e-467a581d253mr223743851cf.42.1734383852093;
        Mon, 16 Dec 2024 13:17:32 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2e85c03sm31927501cf.69.2024.12.16.13.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 13:17:31 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 16 Dec 2024 21:17:21 +0000
Subject: [PATCH v5 7/7] media: ipu-bridge: Remove unneeded conditional
 compilations
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-fix-ipu-v5-7-3d6b35ddce7b@chromium.org>
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

The ACPI headers have introduced implementations for some of their
functions when the kernel is not configured with ACPI.

Let's use them instead of our conditional compilation. It is easier to
maintain and less prone to errors.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/intel/ipu-bridge.c | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index 6cc2614b8f86..be84c100d732 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -2,6 +2,7 @@
 /* Author: Dan Scally <djrscally@gmail.com> */
 
 #include <linux/acpi.h>
+#include <acpi/acpi_bus.h>
 #include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/i2c.h>
@@ -107,7 +108,6 @@ static const char * const ipu_vcm_types[] = {
 	"lc898212axb",
 };
 
-#if IS_ENABLED(CONFIG_ACPI)
 /*
  * Used to figure out IVSC acpi device by ipu_bridge_get_ivsc_acpi_dev()
  * instead of device and driver match to probe IVSC device.
@@ -127,11 +127,11 @@ static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev
 		const struct acpi_device_id *acpi_id = &ivsc_acpi_ids[i];
 		struct acpi_device *consumer, *ivsc_adev;
 
-		acpi_handle handle = acpi_device_handle(adev);
+		acpi_handle handle = acpi_device_handle(ACPI_PTR(adev));
 		for_each_acpi_dev_match(ivsc_adev, acpi_id->id, NULL, -1)
 			/* camera sensor depends on IVSC in DSDT if exist */
 			for_each_acpi_consumer_dev(ivsc_adev, consumer)
-				if (consumer->handle == handle) {
+				if (ACPI_PTR(consumer->handle) == handle) {
 					acpi_dev_put(consumer);
 					return ivsc_adev;
 				}
@@ -139,12 +139,6 @@ static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev
 
 	return NULL;
 }
-#else
-static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev)
-{
-	return NULL;
-}
-#endif
 
 static int ipu_bridge_match_ivsc_dev(struct device *dev, const void *adev)
 {
@@ -259,12 +253,8 @@ static enum v4l2_fwnode_orientation ipu_bridge_parse_orientation(struct acpi_dev
 {
 	enum v4l2_fwnode_orientation orientation;
 	struct acpi_pld_info *pld = NULL;
-	bool status = false;
 
-#if IS_ENABLED(CONFIG_ACPI)
-	status = acpi_get_physical_device_location(adev->handle, &pld);
-#endif
-	if (!status) {
+	if (!acpi_get_physical_device_location(ACPI_PTR(adev->handle), &pld)) {
 		dev_warn(ADEV_DEV(adev), "_PLD call failed, using default orientation\n");
 		return V4L2_FWNODE_ORIENTATION_EXTERNAL;
 	}
@@ -498,9 +488,7 @@ static void ipu_bridge_create_connection_swnodes(struct ipu_bridge *bridge,
 	if (sensor->csi_dev) {
 		const char *device_hid = "";
 
-#if IS_ENABLED(CONFIG_ACPI)
 		device_hid = acpi_device_hid(sensor->ivsc_adev);
-#endif
 
 		snprintf(sensor->ivsc_name, sizeof(sensor->ivsc_name), "%s-%u",
 			 device_hid, sensor->link);
@@ -671,11 +659,7 @@ static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
 	struct acpi_device *adev = NULL;
 	int ret;
 
-#if IS_ENABLED(CONFIG_ACPI)
 	for_each_acpi_dev_match(adev, cfg->hid, NULL, -1) {
-#else
-	while (true) {
-#endif
 		if (!ACPI_PTR(adev->status.enabled))
 			continue;
 
@@ -768,15 +752,10 @@ static int ipu_bridge_ivsc_is_ready(void)
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(ipu_supported_sensors); i++) {
-#if IS_ENABLED(CONFIG_ACPI)
 		const struct ipu_sensor_config *cfg =
 			&ipu_supported_sensors[i];
 
 		for_each_acpi_dev_match(sensor_adev, cfg->hid, NULL, -1) {
-#else
-		while (true) {
-			sensor_adev = NULL;
-#endif
 			if (!ACPI_PTR(sensor_adev->status.enabled))
 				continue;
 

-- 
2.47.1.613.gc27f4b7a9f-goog

