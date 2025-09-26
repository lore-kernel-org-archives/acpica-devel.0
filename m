Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA452F617F
	for <acpica-devel@lists.linux.dev>; Fri, 26 Sep 2025 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892297; cv=none; b=WdUA1rK/MKqc6lA0/npQjpuF3phNJwtczIQ3IxTIsjPDelMILeGgm4m6YTy+PW0/fp+YYy4Ot1xnZeURXyD3uNJHdkg51KO3MaOTu5ToRW+IfBwyaA5BXFcy1CYPpVEYKnzGZ0eSpcwg2hp6xnRDnfrTnRIoWtmiFwENxn1dKCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892297; c=relaxed/simple;
	bh=80G8sSF8+f0UAG0XdkLdvNrCi6HOOZflBRDxb6bYpC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cB/QtPixRjS1d1+tS7aBaPE9TteXmbJmWVJnpkDjXlcoOXjA/HFzv8cvVedZ1MZJdLfcgFJJk9mTq42nnTOixFxgqO3CN1lNJBGZ3vF9gM9M9MnH1N7yT8dqcoLc+12FPr0tgEQP+xUQlA7+L5jxb2HWpVD1nP/4EPhwQEz3XqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a1JCgXoH; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a1JCgXoH"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5797c8612b4so2957176e87.2
        for <acpica-devel@lists.linux.dev>; Fri, 26 Sep 2025 06:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758892292; x=1759497092; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LO+ZRHeTAK51LRbge1abR5CWq6P2opiI+XHVYGi/IpE=;
        b=a1JCgXoHNV3KW4hnAG0TLiY1Bm8cktSwTiqm+I7ZZgjY6Ut9Wj3BJnlYxugjdI0CAB
         qqwN/AHcAZCS3n8CZPEKaTqwihAN0r2SyTOtaxjsdLov1PEikyNkyiWuXuwNCuBTqbDh
         a31ypL1+jcvdLnqGXbVTMkd76ePV5ymHmB6iU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758892292; x=1759497092;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LO+ZRHeTAK51LRbge1abR5CWq6P2opiI+XHVYGi/IpE=;
        b=SprDAi6ZNpnzMDW8+3JrtFfTU2FGl3GlALIBJwVKZE/XZPreV2d8RGEG5TII+QROUD
         5BiqZr8lOUOLdoBx97RwGeV8KErXRji8s8MT3Nxe/+3+ViZFi4BamJvLUSQ7s2w9mL/E
         CXWlr7+tEM1mPx48IFZhxFyumC00lg94BeYiTFzp09+mo9GDWC3UvD2JcWD4A3cwNfFF
         xKnrqZyvz4z/DvW4XllWCV9DCA1/EcG4qaEEiJRhIb0+kzHCy3vTfxeHSGEkuki9/Igl
         uO1O+9Zi2VjX+yTbYSOB/tKLHsXhDukJ1C6HuGP3fglMyaadweNVPUqPKtJSdwe72eOs
         9qtw==
X-Forwarded-Encrypted: i=1; AJvYcCUFve+E/TKy16wqns/NodPJHVBPfDTlF2BPU58hNQy5syur1Ae8JVMYWzAmcDPMHEg+9Fb4kBSpCCyjqlo=@lists.linux.dev
X-Gm-Message-State: AOJu0YwBhuisVvchBVdfp8uDEQbvudRF0ztXmq5mMEjJgBC0gFjkr4br
	uRg/lzgpmtvHAnI4UdtPcNuIb/OKs4ooBr0UCbH990qU3b/yDePRpTSl0IN91nTlCw==
X-Gm-Gg: ASbGncvS1Dea97m0CdX6qPhdqgaOuFQnBSNQB/wx2TnhFZOsoooFfWrrnDQWE7p1Nmq
	6nyjKk2rBjsLbSWp83tbB86AhAD9hRIbXG5Wjwlyz53Iqt1380HYn7q0Ynn+i5soRa+pY/WOHIq
	0dNCnteZ3JQtSFM5zjeek/yTebQALFhwaDVMO5bBP7Gfo4k/lF5JKJ0ZDH0ah6Km7/jx+pQ4mt8
	mQKVsa2xJuU1WzJ68/DBFphqbStg4ULpDDkNRlyOp0ZH6mLyaCF1Po/iu2j27Uz8qo7tlZLS02A
	2IB/OiSf1Qf6QZ6tAV0t7mRO+tBBUZOOx0ns+p/sqNDGfiKCPErXolNqEVqyt7LY4XkuIMdBRMn
	A6iZ/c2Wgnv3RENJztUrEtUyQrCVFDCcaqH49Lav5lNW9FJLaq6R6lc2BPTLXSZ6sGUt+sZ9AlZ
	Ou+w==
X-Google-Smtp-Source: AGHT+IEKOz9hLF8FHkWrsyP0/Z6mTRW5uekYu6y0CaJ96qJRiudQJlAsNVVlhQMiizZElwgvlCzXEQ==
X-Received: by 2002:a05:6512:b12:b0:57a:310:66a8 with SMTP id 2adb3069b0e04-582d35df2d7mr2404401e87.55.1758892291516;
        Fri, 26 Sep 2025 06:11:31 -0700 (PDT)
Received: from ribalda.c.googlers.com (64.153.228.35.bc.googleusercontent.com. [35.228.153.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58527c6b014sm123872e87.43.2025.09.26.06.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:11:30 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 26 Sep 2025 13:11:27 +0000
Subject: [PATCH v3 03/12] media: v4l: fwnode: Support ACPI's _PLD for
 v4l2_fwnode_device_parse
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-uvc-orientation-v3-3-6dc2fa5b4220@chromium.org>
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

Currently v4l2_fwnode_device_parse() obtains the orientation and
rotation via fwnode properties.

Extend the function to support as well ACPI devices with _PLD info.

We give a higher priority to fwnode, because it might contain quirks
injected via swnodes.

Reviewed-by: Hans de Goede <hansg@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/v4l2-core/v4l2-fwnode.c | 84 ++++++++++++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 6 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index cb153ce42c45d69600a3ec4e59a5584d7e791a2a..4110f64d3277e652473f991fb58d191862f98eb0 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -15,6 +15,7 @@
  * Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
  */
 #include <linux/acpi.h>
+#include <acpi/acpi_bus.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -807,16 +808,69 @@ int v4l2_fwnode_connector_add_link(struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL_GPL(v4l2_fwnode_connector_add_link);
 
-int v4l2_fwnode_device_parse(struct device *dev,
-			     struct v4l2_fwnode_device_properties *props)
+static int v4l2_fwnode_device_parse_acpi(struct device *dev,
+					 struct v4l2_fwnode_device_properties *props)
+{
+	struct acpi_pld_info *pld;
+	int ret = 0;
+
+	if (!is_acpi_device_node(dev_fwnode(dev)))
+		return 0;
+
+	if (!acpi_get_physical_device_location(ACPI_HANDLE(dev), &pld)) {
+		acpi_handle_debug(ACPI_HANDLE(dev), "cannot obtain _PLD\n");
+		return 0;
+	}
+
+	if (props->orientation == V4L2_FWNODE_PROPERTY_UNSET) {
+		switch (pld->panel) {
+		case ACPI_PLD_PANEL_FRONT:
+			props->orientation = V4L2_FWNODE_ORIENTATION_FRONT;
+			break;
+		case ACPI_PLD_PANEL_BACK:
+			props->orientation = V4L2_FWNODE_ORIENTATION_BACK;
+			break;
+		case ACPI_PLD_PANEL_TOP:
+		case ACPI_PLD_PANEL_LEFT:
+		case ACPI_PLD_PANEL_RIGHT:
+		case ACPI_PLD_PANEL_UNKNOWN:
+			props->orientation = V4L2_FWNODE_ORIENTATION_EXTERNAL;
+			break;
+		default:
+			acpi_handle_warn(ACPI_HANDLE(dev),
+					 "invalid panel %u in _PLD\n",
+					 pld->panel);
+			ret = -EINVAL;
+			goto done;
+		}
+	}
+
+	if (props->rotation == V4L2_FWNODE_PROPERTY_UNSET) {
+		switch (pld->rotation) {
+		case 0 ... 7:
+			props->rotation = pld->rotation * 45;
+			break;
+		default:
+			acpi_handle_warn(ACPI_HANDLE(dev),
+					 "invalid rotation %u in _PLD\n",
+					 pld->rotation);
+			ret = -EINVAL;
+			goto done;
+		}
+	}
+
+done:
+	ACPI_FREE(pld);
+	return ret;
+}
+
+static int v4l2_fwnode_device_parse_of(struct device *dev,
+				       struct v4l2_fwnode_device_properties *props)
 {
 	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	u32 val;
 	int ret;
 
-	memset(props, 0, sizeof(*props));
-
-	props->orientation = V4L2_FWNODE_PROPERTY_UNSET;
 	ret = fwnode_property_read_u32(fwnode, "orientation", &val);
 	if (!ret) {
 		switch (val) {
@@ -833,7 +887,6 @@ int v4l2_fwnode_device_parse(struct device *dev,
 		dev_dbg(dev, "device orientation: %u\n", val);
 	}
 
-	props->rotation = V4L2_FWNODE_PROPERTY_UNSET;
 	ret = fwnode_property_read_u32(fwnode, "rotation", &val);
 	if (!ret) {
 		if (val >= 360) {
@@ -847,6 +900,25 @@ int v4l2_fwnode_device_parse(struct device *dev,
 
 	return 0;
 }
+
+int v4l2_fwnode_device_parse(struct device *dev,
+			     struct v4l2_fwnode_device_properties *props)
+{
+	int ret;
+
+	memset(props, 0, sizeof(*props));
+
+	props->orientation = V4L2_FWNODE_PROPERTY_UNSET;
+	props->rotation = V4L2_FWNODE_PROPERTY_UNSET;
+
+	/* Start by looking into swnodes and DT. */
+	ret = v4l2_fwnode_device_parse_of(dev, props);
+	if (ret)
+		return ret;
+
+	/* Let's check the ACPI table. */
+	return v4l2_fwnode_device_parse_acpi(dev, props);
+}
 EXPORT_SYMBOL_GPL(v4l2_fwnode_device_parse);
 
 /*

-- 
2.51.0.536.g15c5d4f767-goog

