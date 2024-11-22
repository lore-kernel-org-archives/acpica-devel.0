Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC4F1DB54C
	for <acpica-devel@lists.linux.dev>; Fri, 22 Nov 2024 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732268902; cv=none; b=nSRcngmX7mLuMaN+7w7JNCM1V8FPd0iD9fshDoslOMlgey/8fKPCAG7v1oiDEt/9h3Hd9wJPekhwuneqXDS8uFTd5lEz1WV9vgvl4BCuXzxNzcbsb+Xe2V1e4fgh98Srocm8ErJ8aAwObk4hnQJuh6E+ez/g48ysTlJKeKERxg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732268902; c=relaxed/simple;
	bh=h7Fy6ID2Wea+cuB0h198OsRtS8B+sBBixK2ZtTg/Lzc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QXGvqklOe3yl8PFgGl7RuEXHAfyMW1WuyvNPSQKOdRaFWZizSO3E/uYHwMyeOtzfXdrhjM7BPk2p2FRGDKAM1PbvmPRXrt2laHZHAkIuyyIpM61uqerIWMIIlixRPhNIM4KeUAT9proYpK+kmzhskVZykk/YGIApndw3+fO5j94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T2tBSN2r; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T2tBSN2r"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4ad633f4cd9so323196137.0
        for <acpica-devel@lists.linux.dev>; Fri, 22 Nov 2024 01:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732268899; x=1732873699; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cs82EvgmY8NzBFhpFn/AfZi8XWnAsUV99htkSHmKbBI=;
        b=T2tBSN2rrJTmhjh8jORRnDApUn9Q5dkdbsI0LLL3JAdOA7NK90OX0s4DzHFdImaYeF
         NTF0v86gJ0/LFnVgqaiw8ueuSMseWU8VEkgpPBrIl1xcxhVsCBxMl26gD7kAtdBRJIDe
         wKc6EbTUxKHUzw3nfawAep9tmXSGO5gd68uzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732268899; x=1732873699;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cs82EvgmY8NzBFhpFn/AfZi8XWnAsUV99htkSHmKbBI=;
        b=LB7EKCXR0W0o7uqKs2PJmjnCLWnTj85Exn9+9LAQkD5Xc6VF6rvpI1DwaeZCB96v7u
         2Jv/hkBg04qMS3MbD5/tc90Ryuk3vISeeULOH7sPhmcRP/3Fao5JNlatOqhbZPBvgYb+
         SUQ1meDgnWBlpzpwCRixGt8pLDWS4jn2EpithymY8iVc52uCfQSDi7o2ecQ3MPiGQPMB
         M3qT3SITo/NkTBJNDEP6DNYYAXL0QJcqNjCJAPgErJr+B0jrihpbX1haP6MpPv7iO/oX
         /lEly1NTneysSe5oTAWSic7Yx1J/Rpan4ICEyZW81Tvy+xUILM7XSaO3HmIEIYKtS7wM
         3eSA==
X-Forwarded-Encrypted: i=1; AJvYcCXc/UwARUB65TULglG+TxqxrAtf79uzYSnMpvf7dZsBiPWeBZHcNmgeeIcdNIJ46yNlMKMlXVXGFRRGe9c=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyysw+d5weL408d77h2WcgvgZq/hZMdtIw1telXJb5K/I2KDXGM
	1hev9D2CNIcszdFwl66Cu3QWrSDu+bbtq4AQhQfnE8duB0ajjvmnPGCYzQ6SdA==
X-Gm-Gg: ASbGncvPaPpWVT/3geu7r+O1tjPoUukPBHT3XUhPRTnBKrgZJledk7SMcuJnzzOKgkF
	a0w4HfDDWopj34YpPpsIYYweq3vsFkTToK67LDZR8MsKm7a2Bif3/J4rac6lZ3beljCWEaL5GZj
	AavfbXqq2sZKuTOYVJXLTgBZpWEJ0qQ4WVMMcvY30KfUv83vQiwAc/W3TUT27sAgmKaVHdnrvo7
	uhf9SQyQJrv0yh4vAnFAKApQp0TEmEgvVEnvkiYhT+ZUts068hi5pSU1kRws1ahfquCLIwaO2cb
	YshPgVFzWID2zNypwbixD5nu
X-Google-Smtp-Source: AGHT+IG5fsWaqF4gOiWjJqQ6Ito5ITspaw7yFFwQpvPeXryHfu3kCm7Z8WMVNfAz6obym8tjtrdSCA==
X-Received: by 2002:a05:6102:942:b0:4ac:fe47:1bcf with SMTP id ada2fe7eead31-4addce7430cmr2745642137.24.1732268899126;
        Fri, 22 Nov 2024 01:48:19 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c47f124sm9282731cf.62.2024.11.22.01.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:48:18 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 0/7] ipu6: get rid of all the IS_ENABLED(CONFIG_ACPI)
Date: Fri, 22 Nov 2024 09:47:57 +0000
Message-Id: <20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE1TQGcC/2WMyw6CMBBFf4XM2jF0Unm48j8MC6wDzAJKptJoS
 P/dytbluffk7BBYhQNcix2UowTxSwY6FeCmfhkZ5ZkZqCRrDBEO8kZZN+xpYGrasmkrC9lelfN
 1lO5d5knCy+vnCEfzW/8b0aBBshXTxbpHXbubm9TPss1nryN0KaUvYJ5GEqEAAAA=
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

We want to be able to compile_test the ipu6 driver in situations with
!ACPI.

In order to do this we had to add some conditional #ifs, which lead to
false positives on the static analysers.

Let's implement some helpers when !ACPI in the acpi headers to make the
code more easier to maintain.

We can land the first patch of this series ASAP to fix the current
smatch warning.

To: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Rafael J. Wysocki <rafael@kernel.org>
To: Len Brown <lenb@kernel.org>
To: Robert Moore <robert.moore@intel.com>
To: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: acpica-devel@lists.linux.dev
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Changes in v2:
- Add helpers in acpi to avoid conditional compilation
- Link to v1: https://lore.kernel.org/r/20241122-fix-ipu-v1-1-246e254cb77c@chromium.org

---
Ricardo Ribalda (7):
      media: ipu-bridge: Fix warning when !ACPI
      ACPI: bus: implement for_each_acpi_dev_match when !ACPI
      ACPI: bus: implement acpi_get_physical_device_location when !ACPI
      ACPI: header: implement acpi_device_handle when !ACPI
      ACPI: bus: implement for_each_acpi_consumer_dev when !ACPI
      ACPI: bus: implement acpi_device_hid when !ACPI
      media: ipu-bridge: Remove unneeded conditional compilations

 drivers/media/pci/intel/ipu-bridge.c | 23 ++---------------------
 include/acpi/acpi_bus.h              | 16 +++++++++++++---
 include/linux/acpi.h                 |  1 +
 3 files changed, 16 insertions(+), 24 deletions(-)
---
base-commit: 72ad4ff638047bbbdf3232178fea4bec1f429319
change-id: 20241122-fix-ipu-a2fe28908964

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

