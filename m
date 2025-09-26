Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630352F7ABB
	for <acpica-devel@lists.linux.dev>; Fri, 26 Sep 2025 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892301; cv=none; b=fDz2P039sjeeA6Iz+iB8wGrCk6SYjKOrKAceVNksPk6Q0zPMS7bsazg4mzZF3vsZJbRdpHnO0ElmpsF4HDl4jofeefTIdP2zQwrKfKakvNLos1CzKCWm5Gnnxa1W05Z+cmP0QguFnpaywEQfUgYiA837di/A4Zq8HZPgVyffSVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892301; c=relaxed/simple;
	bh=7+uj94r/7LeT/xAkBfTGJ8aSRCSPNzAL0fCA+D8DD2o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K6CobseOcy5GRUoCRWjM5nlyNmB40aVLNLoiVNdUtkzISI7PuvIuVNMfZvzLyPjBCSa9+4le0Tl1nMjqAaChhdShovGwOB/CweJVrmkDY+lXvfx8p+zBXMa3bqZ2PPAv3rZU7hPZZUwALLhBtxDqAZ9SH7ZXpduVUy5kWSihQqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bkbZ6QCX; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bkbZ6QCX"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-57bf912cbf6so2406238e87.3
        for <acpica-devel@lists.linux.dev>; Fri, 26 Sep 2025 06:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758892294; x=1759497094; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aCy6Bk8e0KycgUL3e8TXrZ2btc+fiyl+rPdd78IS8Is=;
        b=bkbZ6QCXmzTwCqgFWYBjQTF6m89W4deC3SZzGYP3jT9QiAgxETOttcauuK2+pqLe8a
         rqW8ZPVM0f7FYJQlUWcNVCU7+4UvuJ5tUfO9iDTZZxyll38bLpeECAoR6wJEktaVSQZ5
         t2zDwaVPLU/1wNm8gP9+d4X9ls3uXb1Nq1Z4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758892294; x=1759497094;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCy6Bk8e0KycgUL3e8TXrZ2btc+fiyl+rPdd78IS8Is=;
        b=Q4BuNq3ueEl5I1HFXwRY2ACc6lsNwLj4arJa1YOR7I7qktg+rhfOvNgUTH7WFra7py
         UmXizAe9djrLj5Q39Wm1MOU/tj78L0V6wFZQ81EnCrjr4/Gqle0LVsmMQjvQ7r6HF9h6
         aQV28HhPMRo4E3UZoCadqFYe8y49jZ4sAsdJkJqphE3RspSok+/Of681RNW9SllKjK02
         +FnDsco2Kv8KHEEPU3wln9GG71zo657eZIo1g6c1l+R6Hi3VtZn17qoaq/W1pWWdJsUX
         yel32ngrGJGfsn65v3ZbH3xWsYMhzEyOE85I+SUjlOSuvT0ka8k1cHYeiZlFOPLdOtB8
         tLZw==
X-Forwarded-Encrypted: i=1; AJvYcCUDakfLUi3phXaUlPtXV+6T+XP6/FqZWpkekGRA2YizlfpjoHbpOsb9aU0hOSIsoYPW4TPdiItkvnnZTWE=@lists.linux.dev
X-Gm-Message-State: AOJu0YxSUuKsJC7bwBh1Mr5X1lJf1Nv4PlCsdERP2/OrTMl1YuM6pGqx
	ekyz2I2JNX/rlH+mOcljgUJ++I0B0Vve+6a0/bV7Ac7FpkYv9J9U23Wga7BjTEfopg==
X-Gm-Gg: ASbGnctVKEAJc4WZFcz9MRmgdhhxeTX17A5apohvkzC4DbeWLFCKPXtiYEM/aBWd5UE
	sbGxf90sNEu2rWZCFZpnE8hhnqSNXYP11HR+Du8T/chOBOxwMDje8qVv40vaxdI02R6sL6zzMOM
	vMqO//EGfnN8F1CQR+ZUA7mk0t1vVk6zksWKDlYo0zbIsjNmiNeHo21kqrDCQib/gceiT9BuhOY
	HyXzi/SDUOO3e/yLVsUh22W++/qZ8XyNCg9lHBvLZ3HExHHkHf5zWO8n33Nyt0SKeBgCHyVGNnI
	KSlCKyVQITyfDwdScVEpK7nqnR5t6V+gxVaiW/HC5h1G4ETvehfYGThPk/m9NSRYjJ9rD6jx+im
	ntTkSXIWrRL9chntQRtzzSF8HKdUWoVv0lO6CFTj//PUauz795HqxjXSbplwyNWjqQLMuNdRwAV
	VdiA==
X-Google-Smtp-Source: AGHT+IFSULi7NpOrywI1NGNOQUbBJbkaKZRrtRNyEnHKO4o1kB5FT5TGBNkhNPYRfI8ePxwjL+x0fg==
X-Received: by 2002:a05:6512:15a9:b0:57a:2be1:d773 with SMTP id 2adb3069b0e04-582d406b8a4mr1982976e87.53.1758892293940;
        Fri, 26 Sep 2025 06:11:33 -0700 (PDT)
Received: from ribalda.c.googlers.com (64.153.228.35.bc.googleusercontent.com. [35.228.153.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58527c6b014sm123872e87.43.2025.09.26.06.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:11:33 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 26 Sep 2025 13:11:31 +0000
Subject: [PATCH v3 07/12] dt-bindings: media: Add usb-camera-module
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-uvc-orientation-v3-7-6dc2fa5b4220@chromium.org>
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

For fixed cameras modules the OS needs to know where they are mounted.
This information is used to determine if images need to be rotated or
not.

ACPI has a property for this purpose, which is parsed by
acpi_get_physical_device_location():
https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html#pld-physical-location-of-device

In DT we have similar properties for video-interface-devices called
orientation and rotation:
Documentation/devicetree/bindings/media/video-interface-devices.yaml

Add a new schema that combines usb/usb-device.yaml and
media/video-interface-devices.yaml

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 .../bindings/media/usb-camera-module.yaml          | 46 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/usb-camera-module.yaml b/Documentation/devicetree/bindings/media/usb-camera-module.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..e4ad6f557b9151751522e49b72ae6584deb0c7ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/usb-camera-module.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/usb-camera-module.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: USB Camera Module
+
+maintainers:
+  - Ricardo Ribalda <ribalda@chromium.org>
+
+description: |
+  This schema allows for annotating auxiliary information for fixed camera
+  modules. This information enables the system to determine if incoming frames
+  require rotation, mirroring, or other transformations. It also describes the
+  module's relationship with other hardware elements, such as flash LEDs or
+  Voice Coil Motors (VCMs).
+
+allOf:
+  - $ref: /schemas/usb/usb-device.yaml#
+  - $ref: /schemas/media/video-interface-devices.yaml#
+
+properties:
+  reg:
+    maxItems: 1
+
+required:
+  - reg
+
+additionalProperties: true
+
+examples:
+  - |
+    usb@11270000 {
+        reg = <0x11270000 0x1000>;
+        interrupts = <0x0 0x4e 0x0>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        device@1 {
+            compatible = "usb123,4567";
+            reg = <2>;
+            orientation = <0>;
+            rotation = <90>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index ee8cb2db483f6a5e96b62b6f2edd05b1427b69f5..1503502a3aed2625e8ff488456ccd7305cc74ba7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26258,6 +26258,7 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 W:	http://www.ideasonboard.org/uvc/
 T:	git git://linuxtv.org/media.git
+F:	Documentation/devicetree/bindings/media/usb-camera-module.yaml
 F:	Documentation/userspace-api/media/drivers/uvcvideo.rst
 F:	Documentation/userspace-api/media/v4l/metafmt-uvc-msxu-1-5.rst
 F:	Documentation/userspace-api/media/v4l/metafmt-uvc.rst

-- 
2.51.0.536.g15c5d4f767-goog

