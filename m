Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F83522689A
	for <acpica-devel@lists.linux.dev>; Tue, 10 Dec 2024 19:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860591; cv=none; b=aUD0qCGu1+daekFOq887o9DeXsCfRji4wqr2DAlmRPX2mRB7V+Pf7X0PJ8Uob+EZKYuisB9Qyse4GQP0iMrs6jLVPTharH1+4+JcQwlFYIKmRfTPKWomnA4FXHkhwJppGbwtHbhLDmqEQnZpoe7PBAEVDvhnqhM8R7dAA24Gr+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860591; c=relaxed/simple;
	bh=ukuL0J/MKKzCt1mPhJR16PHXljadgzBKa2hSze0hLo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mlbVgODUTyIssSfdGML07GpiST9DGULfO9gqwE1JT0AzSYkezN8+lQzsjvy4+wzHCfurPCVDE2ZcHCMlhoLjmsXi/qr8qiYaed40VnVPVL0u3RYGtUiDh467kIlVVKtT2Jj2pQ7uJHQwfDBqsIbBLNCXQnketT/trXLuix8VVJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZBY3rM01; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZBY3rM01"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4afe7429d37so1088116137.2
        for <acpica-devel@lists.linux.dev>; Tue, 10 Dec 2024 11:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733860586; x=1734465386; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dngrOjvFkokaO//xpC5ashvyb8OkGy64lo3N8QG5GXU=;
        b=ZBY3rM01NCPIqzuaTXqf/mUFFeV5fVPi60hE4ZghXaBOpT0HGAtIgqcWdA2NbWG4td
         PEfe8UVg9Qi4sH1dQQGuZV1ER2LLPO/JxKygZ5RdOQGR/ZzYU8td4gfSlT0gELqolbkW
         2SPEPSASji/nLzNFcGUZCE03o58W82zm7vRqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733860586; x=1734465386;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dngrOjvFkokaO//xpC5ashvyb8OkGy64lo3N8QG5GXU=;
        b=Nfz4FqcbZo4adlLd3+o7FbJcjZhLQOfhh9zuC/3uEh1635Hmh4w3L1njp5JhuAFOb3
         YCyCaOtRY5lvA3Bluvz/ZmfBRUQOfJkja3zimeKqNOnEGpfeT7RXwI75dR0gGrn/nEaf
         uMuKsUvXgm9qIWjUuCVo1snNODcEVZriabob9UT7+9quEWO+yQaZdBeTWEk4PiG8y56V
         dwKmrMUccL3FXhATzzt2p3aaucmTEZADPXDu3k9Xc7A1swUIA9dsOf2tn6DmK80TM5cv
         UpDzLCTWz/Ujq1BTzZxSU0w/FZEAsswpc0f6p1ZxoYAzOYoU6cjL9fQCKz8G8sQF0AsW
         GZBg==
X-Forwarded-Encrypted: i=1; AJvYcCXT/+pI5P3b5z8ga/BGe+z+24TVtSdqkQi4oQF8DNeAgXHTSN+7V/y+XL0PdvZN1+qo3oMiySU1Zwm/AVE=@lists.linux.dev
X-Gm-Message-State: AOJu0YwbqhuBGtoWhVDAXuw7B0FoJBPtKAOk7EbARli9JdeMLq5sYo1j
	o2VT0+xM1Igr4m8iK4m+NsNl6eLGNivMzuNN84h45J2FJDs2M46mR3eVrCNlMBqcEw8Qyl7K46A
	=
X-Gm-Gg: ASbGncu/9H1c9YPyq+1qYTvq90wkD39cq/vF7khzJaVFRRPkQ7PfpdbuRZhdCdzmpTF
	6hwlOC/dWwHGJK5G3c3lZXJ7d4hcOnh5N8QIN2RKugWCFuS1RoMH3ZboavS4NT3gdR7j8+pcR0b
	WFlLvc4syCVEX+BJjkiTZo4j/wE2c4B7BxB9UdYl4WCnWcrXbBF4tpsXiPddOwXcWergF5y/+nN
	Vq9NLT5cN4u9LCtW0wA9SeEX51QDHklqgKNimU5LiiZQkTY4AOphxoQuhpenCMH1fWvXPXQr9jM
	Guky/LOcqWvV3AsDvKM5F4a2fMU/
X-Google-Smtp-Source: AGHT+IFCnfB8ydByqooGet6PwgafKh6LnL27DqPrsLgjTnlJDdhRhasDusXRsUEK8BwIHAK84lpL7Q==
X-Received: by 2002:a05:6102:3714:b0:4b0:4d6:bff1 with SMTP id ada2fe7eead31-4b1290040cdmr739077137.14.1733860586240;
        Tue, 10 Dec 2024 11:56:26 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85c2ba7dc70sm1279522241.15.2024.12.10.11.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:56:25 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 19:56:04 +0000
Subject: [PATCH v3 7/7] media: ipu-bridge: Remove unneeded conditional
 compilations
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-fix-ipu-v3-7-00e409c84a6c@chromium.org>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
In-Reply-To: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
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
 drivers/media/pci/intel/ipu-bridge.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index be82bc3e27d0..1db994338fdf 100644
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
@@ -261,9 +255,8 @@ static enum v4l2_fwnode_orientation ipu_bridge_parse_orientation(struct acpi_dev
 	struct acpi_pld_info *pld = NULL;
 	acpi_status status = AE_ERROR;
 
-#if IS_ENABLED(CONFIG_ACPI)
-	status = acpi_get_physical_device_location(adev->handle, &pld);
-#endif
+	status = acpi_get_physical_device_location(ACPI_PTR(adev->handle),
+						   &pld);
 	if (ACPI_FAILURE(status)) {
 		dev_warn(ADEV_DEV(adev), "_PLD call failed, using default orientation\n");
 		return V4L2_FWNODE_ORIENTATION_EXTERNAL;
@@ -498,9 +491,7 @@ static void ipu_bridge_create_connection_swnodes(struct ipu_bridge *bridge,
 	if (sensor->csi_dev) {
 		const char *device_hid = "";
 
-#if IS_ENABLED(CONFIG_ACPI)
 		device_hid = acpi_device_hid(sensor->ivsc_adev);
-#endif
 
 		snprintf(sensor->ivsc_name, sizeof(sensor->ivsc_name), "%s-%u",
 			 device_hid, sensor->link);
@@ -671,11 +662,7 @@ static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
 	struct acpi_device *adev = NULL;
 	int ret;
 
-#if IS_ENABLED(CONFIG_ACPI)
 	for_each_acpi_dev_match(adev, cfg->hid, NULL, -1) {
-#else
-	while (true) {
-#endif
 		if (!ACPI_PTR(adev->status.enabled))
 			continue;
 
@@ -768,15 +755,10 @@ static int ipu_bridge_ivsc_is_ready(void)
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
2.47.0.338.g60cca15819-goog

