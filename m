Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF40145A09
	for <acpica-devel@lists.linux.dev>; Mon, 16 Dec 2024 21:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383847; cv=none; b=Ew+A5fdZzuUOQc6qRDCurMb+5Hx6dEcBA5mGkW2fTmHnYVPl9f2BzhyG9i9OgRevzWAqsn6xVTXAzRlcA7JWQVgqmbK6Kh4dr6ti4NUewMSnkaGHYBdplXuLjThGRFB4eVCR3RptFocR2QY2aTp6gSWEzfVlXEDyhGwZycutsho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383847; c=relaxed/simple;
	bh=4fQYHchrSWa5uLGjxEoj3D06//Sn7ZmscruEw3/0WQA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nvpQa9tLyQlGNNE5pqn/vwri6urKBz/GTxGi68/AKAjOROUjWXgPKOiKtuB7i/s1EhXC5QKRIv3AIBGwLZCmHsUg6TdgirEF09ATieHwLUUuyoBkQuAD3E7eTiTfXIbInDxfDAoeWlFf4VWhbGu5yUaYi0CAZBkR21BKK4qGmZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aZj2/PMK; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aZj2/PMK"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-468f6b3a439so5578071cf.1
        for <acpica-devel@lists.linux.dev>; Mon, 16 Dec 2024 13:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734383843; x=1734988643; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l8AmPG7e7RmI2AaOsk1iihtx1bcIXZSCEYdSKszNNH4=;
        b=aZj2/PMKiJFL8tJxFxBNAVwKKim5x2uLfnRLlTPZqXAzV3dZ3/kyYgb1DFPvLWollT
         w/NAUcj44mQTg3ITdqQ2UnX1anSTiloivDE9rAOVUsRgN9nC8zZQ/xKqjrREIQGwGCpD
         ZdWw+Rzk1s1id9qIFhy6iDwGfFT8uW5u8f3/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734383843; x=1734988643;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l8AmPG7e7RmI2AaOsk1iihtx1bcIXZSCEYdSKszNNH4=;
        b=f3nPBVKP61bbprrMF5v1qqW2Gr7i97eUwBJ8wwYLuc3pDf1ZBujqdXJtbMuuAxkkse
         Ni9qoWM1Glu8xVbZ1MfxyfoIubgMGE/ilw4YWt41j7goHDCKQImTUcQ1XoSWW2VP060Q
         lZcFu8Bt19zkAF4/MYU9qHXOyqgeOnMkdCp1idqGMRMeJadU5Dx+uysw2jGOnPvHkvLr
         i75IvFpC8R/7CYajgaIIPJDNYBsJsttfyLM56TvxKjeNzrFvrpuNs0VYTLr+dUUhq5KH
         Ihrvj1tpNvl1CDJumivEWZobM40+h/56vnx4coN/ZADXvBLZEs1lxGj4WCKAtIWJ5Os7
         d7wA==
X-Forwarded-Encrypted: i=1; AJvYcCXYAQDWwqoHRCIHRrArvfAHGiXiKe0dM5P7Lq9a3JjOlAxM8erK2LeKgja5tJZakkVvn9bb/fnrK/TrrQU=@lists.linux.dev
X-Gm-Message-State: AOJu0YypQSj1HtRYcP8duv+HswfEtKyNXeQOeoAMM1EuR8kjz3qJZWE+
	vz/JAbNt8Bau5CZVOk+HDMzyn30sYGSokWy8GTfNuCOQZjMTG2nGImNXyM5l6g==
X-Gm-Gg: ASbGnct7gGxt55y9CMuGQbu0JQDPr0uvuuEG985XdphZDGqsYabd2d4/YsYnKLNUDIg
	LNNM2yPo5th2wKamWT5yn27cXElvYDipCvwutrmkK0tlSzLQgUvSKLWFHJ96OftOOiHHRakINRn
	CrvtyqsQl6LtrUl2TSNbQ16+m4usDFbZBMDgc+vZaMkQd7CcovLisOXQURkyD+nS6LK7XS8x81/
	x44/wNzqRudohZ3DJNVjxyBW4aR9zvsFNJ7ugO3GAOqq1l0Qxj4otlLD0Qze1zpyAb4xSy95brU
	sdPcbbOB/ZFrp4/+Ho0UxcSBW2e6WKY=
X-Google-Smtp-Source: AGHT+IE6nGYwK5u9N5YH85CBS/7ioSAcLwKhUyLy8jZqzGt9r49k/AYODQLmEjFBHtIiJqOxDlKquQ==
X-Received: by 2002:a05:622a:48f:b0:467:8703:a740 with SMTP id d75a77b69052e-467a5755691mr274120391cf.18.1734383842824;
        Mon, 16 Dec 2024 13:17:22 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2e85c03sm31927501cf.69.2024.12.16.13.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 13:17:21 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v5 0/7] ipu6: get rid of all the IS_ENABLED(CONFIG_ACPI)
Date: Mon, 16 Dec 2024 21:17:14 +0000
Message-Id: <20241216-fix-ipu-v5-0-3d6b35ddce7b@chromium.org>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANqYYGcC/3XNwQ6CMAwG4FchOzuzlTKYJ9/DeBizwA4I2YRoC
 O/u4IJRPP5tv78TC+QdBXZKJuZpdMF19xiyQ8JsY+41cXeLmYEAlBKAV+7JXT9wAxVBoUWhFbJ
 43XuKq7Xpco25ceHR+ddaPMpl+tsxSi45oCLI0JZ5bs+28V3rhvbY+ZotNSP8ocAFL0ujsiJTp
 Ktqh6YbBSk2mkYqBKHQtkCj9r7iJ5UbxUhRCiCdG0ul+qLzPL8BI8zt+FIBAAA=
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

We want to be able to compile_test the ipu6 driver in situations with
!ACPI.

In order to do this we had to add some conditional #ifs, which lead to
false positives on the static analysers.

Let's implement some helpers when !ACPI in the acpi headers to make the
code more easier to maintain.

To: Rafael J. Wysocki <rafael@kernel.org>
To: Len Brown <lenb@kernel.org>
To: Robert Moore <robert.moore@intel.com>
To: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: acpica-devel@lists.linux.dev
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Changes in v5:
- Remove Fixes tag
- redefine acpi_get_physical_device_location() to return bool
- Link to v4: https://lore.kernel.org/r/20241211-fix-ipu-v4-0-4102e97aceb6@chromium.org

Changes in v4 (Thanks Sakari & Mauro):
- Squash the two ipu changes and merge everything via ACPI
- Space after ;
- move acpi_device_handle to avoid fwd declaration.
- Link to v3: https://lore.kernel.org/r/20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org

Changes in v3:
- Prefer static inlines to macros (Thanks Rafael).
- Link to v2: https://lore.kernel.org/r/20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org

Changes in v2:
- Add helpers in acpi to avoid conditional compilation
- Link to v1: https://lore.kernel.org/r/20241122-fix-ipu-v1-1-246e254cb77c@chromium.org

---
Ricardo Ribalda (7):
      ACPI: bus: change the prototype for acpi_get_physical_device_location
      ACPI: bus: implement for_each_acpi_dev_match when !ACPI
      ACPI: bus: implement acpi_get_physical_device_location when !ACPI
      ACPI: header: implement acpi_device_handle when !ACPI
      ACPI: bus: implement for_each_acpi_consumer_dev when !ACPI
      ACPI: bus: implement acpi_device_hid when !ACPI
      media: ipu-bridge: Remove unneeded conditional compilations

 drivers/acpi/mipi-disco-img.c        |  3 +--
 drivers/acpi/scan.c                  |  4 +---
 drivers/acpi/utils.c                 |  7 +++----
 drivers/base/physical_location.c     |  4 +---
 drivers/media/pci/intel/ipu-bridge.c | 29 ++++-------------------------
 drivers/usb/core/usb-acpi.c          |  3 +--
 include/acpi/acpi_bus.h              | 23 ++++++++++++++++++++---
 include/linux/acpi.h                 |  5 +++++
 8 files changed, 36 insertions(+), 42 deletions(-)
---
base-commit: d216d9cb4dd854ef0a2ec1701f403facb298af51
change-id: 20241122-fix-ipu-a2fe28908964

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

