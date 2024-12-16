Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C111D4352
	for <acpica-devel@lists.linux.dev>; Mon, 16 Dec 2024 21:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383848; cv=none; b=VUS7BkQ73QXcFhnfO42vEaoGE5NM4J6PiSaE7k7k9DzrBhdx+5H+69Tz5QZoF0PXC6L9mA94LFlLZp1v1dn7Rlt/L4jIZSg2v2+JHTZjx0ImxI4mzWJaIMFz0+fvK7t490JKPZnFPIv/e4wSeXMDtWVG0bDP2JtPf1ygR9X+UUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383848; c=relaxed/simple;
	bh=kKwZloJ+pxiytz9zfwyv5msK5QwJz26A7aW8bSu0I3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jsNDYFBY9dWBmc9TNxosvdxWQkv0BcxkF0G7e/PLJ05XWtxkGKCUVOQcygozwMdUzqySO3N7wLc6k3uwEDZ3fGiRbaybM2n9lcvCUAeLBJEWnRhA0NOMn7YAz9WFecaw6d84syjA6HK3YMKVYVc4hgVsDhTVjx3rjioOnegS6KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DWaR57Ok; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DWaR57Ok"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46792996074so54146751cf.0
        for <acpica-devel@lists.linux.dev>; Mon, 16 Dec 2024 13:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734383845; x=1734988645; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kM2B80UZkeR2LPczGOfVlIBqSwSauWzJe2cC0H2QDRc=;
        b=DWaR57OkWBWn8sadv3bMm8rtXrkO/5+kUKZgUjA9JDFddL15zPTKard3i1anLGN4My
         W8qOgJlkBtJEtoQb3sC4gy02JyyFowSepD896bS+ZSwnJsDryoyf2Io0Oc3LKo/bvC2G
         v1R/5F+Q7nPoQ1aUX28wpQRWJzmwFbbc9nSnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734383845; x=1734988645;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kM2B80UZkeR2LPczGOfVlIBqSwSauWzJe2cC0H2QDRc=;
        b=D9qyeCmw9FgIolVPKZSfwnJvNs7hGyIi/d3hlrlGhmNp6jRo7h8cYfL2fgIRB8cT3X
         u/Yhmm4NECSR8OFdUrwF1yBz3QumLOv81NFudXrMy8HzRooYRjASg3S/xNWpM3xWmGB8
         iwGrneWuxluWi6j69xl3YbS6KxUVOGRS2TpCR0QYErO+ZwgYkwwNOzbvz1WPOoP8+ZOD
         YF20D21Gu+Cvptk1qGWfWiOpQl68s6r7S55NgBLyVqrJPXixftFfwuqtDM/Vu8Tv8Lfl
         GD2CK0A0XcTtL2V7IBF27zcOb4YVLGLUrL+EbmZXOIzrAGyYkJHEO2YWkmfkCVATyxp3
         3OWg==
X-Forwarded-Encrypted: i=1; AJvYcCUpKFJESsNOiWxF70zMo8Ocq/oy6Xe1MCAMb+DGMksU9/HG7SpiuC8IqdeAwvagkfR3Y+e5LfhZeiSk9Ms=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6Fpy6KD7sNPG5U8iJE5atpcjDUVaJpSp8chJQLXdZDMLlxfzH
	QQFuZx5/KX2PpVR5/ifnmWbkww1EzbpZSh17YcsXATvscFYbh7pE6jN8tI6ssw==
X-Gm-Gg: ASbGnct4UI/kKnObUlP73ilvxcge5WtEL6XeFdw41iiwUcUFXg8H9D9rTrAsQahPuAG
	hacCk0UkpQ8WGCgwRJIYBBfwreqgGEjv71UlHslvGiYpGBc8H69bsrkGSBB4KpitSgpjGhbK9sH
	kxq/wDTTX2hacmCG3PWerQk6GZ9xPhVlEOIp6uLV/yVdcnEaFmFQHZs+t7CDqprH2J5Bk1J+erD
	hcOYEosPr+Kn85ke5qwIVzkKGoTSSS4xpDv/hJSvz6sa2RAVOgZpynEwc6TDIzNhvQHz0XcjkiJ
	DDf6/C0S9wJk0rDpJvu16i4dmo/vHjw=
X-Google-Smtp-Source: AGHT+IHSGnqI6FhkQaL0069bHSXiDXW28qApI4WsVyO7HAsa7gVNw+XbMJ7VfZy9PvrVRyRjuC0jMg==
X-Received: by 2002:a05:622a:1487:b0:467:45b7:c495 with SMTP id d75a77b69052e-468f8ad232emr17931231cf.15.1734383844801;
        Mon, 16 Dec 2024 13:17:24 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2e85c03sm31927501cf.69.2024.12.16.13.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 13:17:23 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 16 Dec 2024 21:17:15 +0000
Subject: [PATCH v5 1/7] ACPI: bus: change the prototype for
 acpi_get_physical_device_location
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-fix-ipu-v5-1-3d6b35ddce7b@chromium.org>
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
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

It generally is not OK to use acpi_status and/or AE_ error codes
without CONFIG_ACPI and they really only should be used in
drivers/acpi/ (and not everywhere in there for that matter).

So acpi_get_physical_device_location() needs to be redefined to return
something different from acpi_status (preferably bool) in order to be
used in !CONFIG_ACPI code.

Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/acpi/mipi-disco-img.c        | 3 +--
 drivers/acpi/scan.c                  | 4 +---
 drivers/acpi/utils.c                 | 7 +++----
 drivers/base/physical_location.c     | 4 +---
 drivers/media/pci/intel/ipu-bridge.c | 4 ++--
 drivers/usb/core/usb-acpi.c          | 3 +--
 include/acpi/acpi_bus.h              | 2 +-
 7 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-img.c
index 92b658f92dc0..5b85989f96be 100644
--- a/drivers/acpi/mipi-disco-img.c
+++ b/drivers/acpi/mipi-disco-img.c
@@ -624,8 +624,7 @@ static void init_crs_csi2_swnodes(struct crs_csi2 *csi2)
 	if (!fwnode_property_present(adev_fwnode, "rotation")) {
 		struct acpi_pld_info *pld;
 
-		status = acpi_get_physical_device_location(handle, &pld);
-		if (ACPI_SUCCESS(status)) {
+		if (acpi_get_physical_device_location(handle, &pld)) {
 			swnodes->dev_props[NEXT_PROPERTY(prop_index, DEV_ROTATION)] =
 					PROPERTY_ENTRY_U32("rotation",
 							   pld->rotation * 45U);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 74dcccdc6482..93d340027b7f 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -723,10 +723,8 @@ int acpi_tie_acpi_dev(struct acpi_device *adev)
 static void acpi_store_pld_crc(struct acpi_device *adev)
 {
 	struct acpi_pld_info *pld;
-	acpi_status status;
 
-	status = acpi_get_physical_device_location(adev->handle, &pld);
-	if (ACPI_FAILURE(status))
+	if (!acpi_get_physical_device_location(adev->handle, &pld))
 		return;
 
 	adev->pld_crc = crc32(~0, pld, sizeof(*pld));
diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 6de542d99518..526563a0d188 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -494,7 +494,7 @@ bool acpi_device_dep(acpi_handle target, acpi_handle match)
 }
 EXPORT_SYMBOL_GPL(acpi_device_dep);
 
-acpi_status
+bool
 acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld)
 {
 	acpi_status status;
@@ -502,9 +502,8 @@ acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld
 	union acpi_object *output;
 
 	status = acpi_evaluate_object(handle, "_PLD", NULL, &buffer);
-
 	if (ACPI_FAILURE(status))
-		return status;
+		return false;
 
 	output = buffer.pointer;
 
@@ -523,7 +522,7 @@ acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld
 
 out:
 	kfree(buffer.pointer);
-	return status;
+	return ACPI_SUCCESS(status);
 }
 EXPORT_SYMBOL(acpi_get_physical_device_location);
 
diff --git a/drivers/base/physical_location.c b/drivers/base/physical_location.c
index 951819e71b4a..5db06e825c94 100644
--- a/drivers/base/physical_location.c
+++ b/drivers/base/physical_location.c
@@ -13,13 +13,11 @@
 bool dev_add_physical_location(struct device *dev)
 {
 	struct acpi_pld_info *pld;
-	acpi_status status;
 
 	if (!has_acpi_companion(dev))
 		return false;
 
-	status = acpi_get_physical_device_location(ACPI_HANDLE(dev), &pld);
-	if (ACPI_FAILURE(status))
+	if (!acpi_get_physical_device_location(ACPI_HANDLE(dev), &pld))
 		return false;
 
 	dev->physical_location =
diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index a0e9a71580b5..6cc2614b8f86 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -259,12 +259,12 @@ static enum v4l2_fwnode_orientation ipu_bridge_parse_orientation(struct acpi_dev
 {
 	enum v4l2_fwnode_orientation orientation;
 	struct acpi_pld_info *pld = NULL;
-	acpi_status status = AE_ERROR;
+	bool status = false;
 
 #if IS_ENABLED(CONFIG_ACPI)
 	status = acpi_get_physical_device_location(adev->handle, &pld);
 #endif
-	if (ACPI_FAILURE(status)) {
+	if (!status) {
 		dev_warn(ADEV_DEV(adev), "_PLD call failed, using default orientation\n");
 		return V4L2_FWNODE_ORIENTATION_EXTERNAL;
 	}
diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index 03c22114214b..935c0efea0b6 100644
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -213,8 +213,7 @@ usb_acpi_get_connect_type(struct usb_port *port_dev, acpi_handle *handle)
 	 * no connectable, the port would be not used.
 	 */
 
-	status = acpi_get_physical_device_location(handle, &pld);
-	if (ACPI_SUCCESS(status) && pld)
+	if (acpi_get_physical_device_location(handle, &pld) && pld)
 		port_dev->location = USB_ACPI_LOCATION_VALID |
 			pld->group_token << 8 | pld->group_position;
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index b2e377b7f337..19f92852e127 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -43,7 +43,7 @@ acpi_status
 acpi_evaluate_ost(acpi_handle handle, u32 source_event, u32 status_code,
 		  struct acpi_buffer *status_buf);
 
-acpi_status
+bool
 acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld);
 
 bool acpi_has_method(acpi_handle handle, char *name);

-- 
2.47.1.613.gc27f4b7a9f-goog

