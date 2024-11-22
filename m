Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E9F1DED7F
	for <acpica-devel@lists.linux.dev>; Fri, 22 Nov 2024 09:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732268912; cv=none; b=ptfUKbv/nZbKJroi53pUCmOm9SrzUmi1IRIEbbBCzj4lFMtVAZcLtOw+YAySprGSIVaSI3a6/2GcMPpNaE88eu7P1AIqE3wqZA/0GpxE7dGS5W+9DmRnRNbgVJKcX02af/CNUdGUU07Nsfy6Vyzc/ZZlNnbpkT+npr51yv2MCvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732268912; c=relaxed/simple;
	bh=/xyrOk13WfYwXnzGF1BEMgqEZvLsICd5gWhhYG2cImQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KQnUkGdzyP5wxmsrzD6eXnOQrjSLPnSKyARPmFSS3cedYMbLbn9Oxsa4NBMJE5R2pIHn6NJbrCDx1SsU8O9a/d4m1VLn3YEmUYvGwSz+HGuxXGmNYxaOh26z8kySo1DPI4eNyr9u5KarvfOXM6c7h1Pefmhb8BgJ0aVUj0vFJZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A8O+f09+; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A8O+f09+"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-460e6d331d6so11572071cf.2
        for <acpica-devel@lists.linux.dev>; Fri, 22 Nov 2024 01:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732268909; x=1732873709; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uKV0qKpenqq8YefMBn8axPBP/1pf6x8COWK/EGNLUhk=;
        b=A8O+f09+1F2sEXlDSM1brslZ0UwKGM8t0M0QGFFnJ2lrmX9/LgdA2RURuZZXrTmLHa
         OGduQTax6b3P0q7jKII9t+juBTvr5WjZnxNiO9zJcMEQqTpFgCvoTclGuCfpS94GBR3m
         FyiplNHt6ykRoNq9xVr7VEs8u+Xu4CIDTMAXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732268909; x=1732873709;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKV0qKpenqq8YefMBn8axPBP/1pf6x8COWK/EGNLUhk=;
        b=b0n6643xrsp0QozFjWvb6qqPi9OQScWUHqIo00HAxqwWtu6LwmmMDsJiJx+3dg/Gg5
         ahP5PZBtT7aXrutdyCpSP8dZrpnY3N/IB9383hSDymq94RNsjtpReWsY6JEbcdwGvBTG
         rBzDKMTee0CkOKmVNStcwGLzC3kaN6vqUZZvoDdIwmTq9hyH5vPLjts7Uk9w1QD9l3Q/
         AVP/vLcIyYN28X+839RCfj7OsIhapYpokDHlpW7xASz0qzH1SR6Pn55q5k1MEi7H1aLb
         YtebxP9bu7oS5kkGu7eJBxbZQvG/apl/WFmqvjsqejfcLOQonV0QAuAsF7++36C+YhMY
         incA==
X-Forwarded-Encrypted: i=1; AJvYcCXWGI8ibiaXENGE7BtBcToq/Ybe++fi50LX12oCs8+sIBZYmC5uPtcllfKYdWz1JNut3A1RpeGrQFP8iu0=@lists.linux.dev
X-Gm-Message-State: AOJu0YyuvH/pC9SeaIRzt8D2jVibNANkoQVNhAda0a1a8zHIADIcxChC
	adMvSuuWexAW5R71X13hz9K3nxL3haL1A7f1sH/PJlzw1DmpS8mMrUQ7Guk+lw==
X-Gm-Gg: ASbGncv7gKr9xS5Kqs9rwmzBKdKKgZYDGGzydDKksLCqt49T+xmj+ARS8XRShDU/zYj
	8BHu3FsU9U07YZ6hS+zFEfs0+jFBGh0CacDo1trWDOPUrNvrpQvdL5A0IP+W4GiQe9nwMQijEH/
	dYwmlGFdWUtEwEMJr94ef4rDxGS8WQrOXFQwpA+C0ffUJSe2CHrUGtHDwaS13tJmPCzFj9fhL37
	E7eaMhqWvjUWON5/EOwWdsebM/kByFH1JNUdpYP0hh+47B6lQ6h0A9aCi1prXFOGLhbzk888InO
	Ldg/6GWvNTduysW3k98TORop
X-Google-Smtp-Source: AGHT+IGkqqWnODk2xignRvaov7QmeTL3jw/lsAM7Pyz5eBZ/ng+3qbMNUUQf4HXvA77w2WK8NKWLDQ==
X-Received: by 2002:ac8:5ac6:0:b0:461:1532:d769 with SMTP id d75a77b69052e-4653d63aebamr22893621cf.54.1732268909452;
        Fri, 22 Nov 2024 01:48:29 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c47f124sm9282731cf.62.2024.11.22.01.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:48:28 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 22 Nov 2024 09:48:04 +0000
Subject: [PATCH v2 7/7] media: ipu-bridge: Remove unneeded conditional
 compilations
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-fix-ipu-v2-7-bba65856e9ff@chromium.org>
References: <20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org>
In-Reply-To: <20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

The ACPI headers have introduced implementations for some of their
functions when the kernel is not configured with ACPI.

Let's use them instead of our conditional compilation. It is easier to
maintain and less prone to errors.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/intel/ipu-bridge.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index be82bc3e27d0..6bdf42f6769f 100644
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
@@ -131,7 +131,7 @@ static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev
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
@@ -261,9 +255,7 @@ static enum v4l2_fwnode_orientation ipu_bridge_parse_orientation(struct acpi_dev
 	struct acpi_pld_info *pld = NULL;
 	acpi_status status = AE_ERROR;
 
-#if IS_ENABLED(CONFIG_ACPI)
 	status = acpi_get_physical_device_location(adev->handle, &pld);
-#endif
 	if (ACPI_FAILURE(status)) {
 		dev_warn(ADEV_DEV(adev), "_PLD call failed, using default orientation\n");
 		return V4L2_FWNODE_ORIENTATION_EXTERNAL;
@@ -498,9 +490,7 @@ static void ipu_bridge_create_connection_swnodes(struct ipu_bridge *bridge,
 	if (sensor->csi_dev) {
 		const char *device_hid = "";
 
-#if IS_ENABLED(CONFIG_ACPI)
 		device_hid = acpi_device_hid(sensor->ivsc_adev);
-#endif
 
 		snprintf(sensor->ivsc_name, sizeof(sensor->ivsc_name), "%s-%u",
 			 device_hid, sensor->link);
@@ -671,11 +661,7 @@ static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
 	struct acpi_device *adev = NULL;
 	int ret;
 
-#if IS_ENABLED(CONFIG_ACPI)
 	for_each_acpi_dev_match(adev, cfg->hid, NULL, -1) {
-#else
-	while (true) {
-#endif
 		if (!ACPI_PTR(adev->status.enabled))
 			continue;
 
@@ -768,15 +754,10 @@ static int ipu_bridge_ivsc_is_ready(void)
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(ipu_supported_sensors); i++) {
-#if IS_ENABLED(CONFIG_ACPI)
 		const struct ipu_sensor_config *cfg =
 			&ipu_supported_sensors[i];
 
 		for_each_acpi_dev_match(sensor_adev, cfg->hid, NULL, -1) {
-#else
-		while (false) {
-			sensor_adev = NULL;
-#endif
 			if (!ACPI_PTR(sensor_adev->status.enabled))
 				continue;
 

-- 
2.47.0.371.ga323438b13-goog

