Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B961DD88B
	for <acpica-devel@lists.linux.dev>; Fri, 22 Nov 2024 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732268902; cv=none; b=OsTE/1SM1/f4bU4xoFjbyE+VKamUsmpQTDoZldjcnQyqWbCL2c7aV6w5liLI1JpADuqeDwJ2v6HBpjMQwaRs2yxdXP6DnJz6qp0pUbS5BDx19aG/VTzQOF78gjwkLv7ld6XP34T2An87ULU1W+NZGPutmEPz2k95MktvnnTL7ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732268902; c=relaxed/simple;
	bh=w9LCIWUOMl/uTKpIvXEyGapEo1u86swQRW6MRCHY3D0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gve27xEComAkbAUvDfWT+9GfVruwKCVkTVHJj/Gi3vjyZmeFKAVH/DfrUt+4ncxbVl43eMz3IsK43chsBnbwglTm1UVVRJZ57y2SPOTzfYeQyigaayD0AkxmGLyqI5BDxjPmjcYfP3Z6wuixAGXl4RShXPQWN2xFw+/12CA9Imo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OeIDjWWB; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OeIDjWWB"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-460ace055d8so12206361cf.1
        for <acpica-devel@lists.linux.dev>; Fri, 22 Nov 2024 01:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732268900; x=1732873700; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/BFNmnXBO58C7oe88M+ixtZQGuz6wm+Rt7+horX5NE=;
        b=OeIDjWWBtz0qBuM0Y0P81e8TltMlqLTRf1UVueROuYOcm3T6ib7ttBxwN+QmHNW9bS
         PFDXcVNIDgQ3w3x66+3vLGiTdDPdOMwolUXXFcR+cjrAO/+8whlO8J02vm1E0FB9afE6
         KD+qEVF7UUYm6c9A4aFvLL37AMw7w0lWxt3q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732268900; x=1732873700;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/BFNmnXBO58C7oe88M+ixtZQGuz6wm+Rt7+horX5NE=;
        b=EmC1bbPp6t6LAgi1BSNG72Ps0xWmyyH+5Czf6CAFNLUh4hNzNammLu//+8UHWi7xlj
         9tP+OVLTxBl9AOkvgKEEPThSjr7OUgHTyDvfoBm8wR398LiacvL+ucRSuAUENthWZCRa
         uyntX+hXmLEtjmYgWLxu3YclK9WiaevP8gYooUJBZIIK0R2u7SEntXplCwfQZN/xIFfK
         cLaSMkwNzbLMQYj5dqLPfHXl3KbudGzVFk3aPEg0DBMtNhuPvyCDGqcWONCfPeu3tkfz
         5GAlJXRT4Jq8u+3KwaftXtuVGg9LP6UywJOi8WNEFNbWcSAoki+//OufiTMSAoPh0LuX
         3s/g==
X-Forwarded-Encrypted: i=1; AJvYcCU9iSAMZqCl+beuSjkY/mZcK8Rz9m9ouA4Ij9XsVRdRW8slP3PnKyaRgiw4eJITFaZbZigin4txk3C8MKQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YwYoluPmqDW8HTCLRq3N1Jgth+cDDV3J3vjhVqv2sLKRnqAp4oB
	7C0CZVNJQiC7aF7hygjskY22vLtDGSQLtr3OK2HdPqOgsOAEYNhoTtxWwK1ePg==
X-Gm-Gg: ASbGncuRahK8dkuDTsNwn4nKurHD1WuGEU2j3/W6XCaU/XZIAuLXmS5XYZ5UOPJC3XY
	yOpJhquVHK0uFoHpKomQ/maHTLUb2nJpG5dx5Pn9WdCOxjzu+iq/F/kDczv3Zgzpf8NFo8qmXR3
	oj5sZ/QcpPMhtZZ3W7PX68ap3ViTvdQJNy7C79vNnyYqmqOUnBF62IHxlqiuNgKbK7oGqka+gfF
	x+n2wQJOtA4qBbn64oAXFhEdP1cW2IyTuZ0pwM57iMIJqetdGWAiStIanTniY8OhYWq/kGv05tx
	HMS/SUNMyh0VhOwjG2WsJUsL
X-Google-Smtp-Source: AGHT+IHHdb/bCzojxcLvKgiZFS7wveq70HirCmNUp9dbcD65FOXFHZVsY9GQS/ctk0cY1TQI6tOweA==
X-Received: by 2002:a05:622a:1e8e:b0:460:ab29:e6b1 with SMTP id d75a77b69052e-4653d617eb8mr30106331cf.44.1732268899812;
        Fri, 22 Nov 2024 01:48:19 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c47f124sm9282731cf.62.2024.11.22.01.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:48:19 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 22 Nov 2024 09:47:58 +0000
Subject: [PATCH v2 1/7] media: ipu-bridge: Fix warning when !ACPI
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-fix-ipu-v2-1-bba65856e9ff@chromium.org>
References: <20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org>
In-Reply-To: <20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.13.0

One of the quirks that we introduced to build with !ACPI && COMPILE_TEST
throws the following smatch warning:
drivers/media/pci/intel/ipu-bridge.c:752 ipu_bridge_ivsc_is_ready() warn: iterator 'i' not incremented

Fix it by replacing the condition.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/intel/ipu-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index a0e9a71580b5..be82bc3e27d0 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -774,7 +774,7 @@ static int ipu_bridge_ivsc_is_ready(void)
 
 		for_each_acpi_dev_match(sensor_adev, cfg->hid, NULL, -1) {
 #else
-		while (true) {
+		while (false) {
 			sensor_adev = NULL;
 #endif
 			if (!ACPI_PTR(sensor_adev->status.enabled))

-- 
2.47.0.371.ga323438b13-goog

