Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B8D21420D
	for <acpica-devel@lists.linux.dev>; Tue, 10 Dec 2024 19:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860572; cv=none; b=JgeItWrznvCWaSUDkpnBRDp7HREGiT1DcDpobNMdb2iZ35HluZA+rpQnv1w854Kt0CNykzzDr0xQw2JI2t3mTFv3B6zutcK+n+Cl7jKRljUS0upwGOxP5xtdpRjYxIJ8E0X4WpNgA9utwxAaLfVVmvNKl0jYTxISdI0acxbqkVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860572; c=relaxed/simple;
	bh=dSTADKTNJvbmRBy+1jUqiB+cNshFUI2ErxE8CtN1esU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GRNU6jsBISyABlrnrP5Ga65jR0hU9Xf1vxUJ0Opk0Fw7vESsGgA02KdLnRMRSiThfGkjHVLO0ZPvo3Li0YX482vFvMr1Y5dRcUHIkjd+mO3TZH8gzVaI1DSMKX3+fweFn+CG8+sK5RqUbdngAw/KT5YqyCL4UJqAaQ+eRWN/UaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M3SgypkR; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M3SgypkR"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4afe70b41a8so1032840137.3
        for <acpica-devel@lists.linux.dev>; Tue, 10 Dec 2024 11:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733860567; x=1734465367; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ENZnTNWODqxq5GjFCzfA3SG8RDnI3+d9xSrfoOvAAA4=;
        b=M3SgypkRYGKS36TgMe9nH4bKmnRqjIKhSJd+NLT20bxYmOpH8K+4fkmDKfMa1q4Zmx
         Cr0vsiSWUZgZ3YHhCotKEngrtuUfxz0jpa592Kd6HrbKphragUz01BsQ2Q7QKqQ8eU27
         3qMc8j8INKYOsr0+XIzWMu8DVYo23V7w0kFCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733860567; x=1734465367;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENZnTNWODqxq5GjFCzfA3SG8RDnI3+d9xSrfoOvAAA4=;
        b=G/c4EyjJd1lktnvFocb/K0/ALadWkh165efVIT37gSZxg+xw9tVvN3v9mxCG4Ex/R2
         ghNRgMr88hTacoIiTuIIYg+DoIrQAV7JCL4+GG1EeOJoFQVzdx6EmMRuruQ18bzNaZwc
         MJeN0+8V3Nft9pW0h9mizud0z6+HJjou3QURLAfcgRJGM4sZ+u6/JzkAxgh8+yGo20x0
         ibFiRYdISyOPPZK9dbsWAXrk0rxlEQW1hvMyhxbRcmPhRAi6wL98lG/ZREb/dyNwoYDK
         HAhfZOpF9TVDEo9le2Yq0I6P/XlW/aDynIA8/yeDz4Z0OjUuTX3ybeN9622kF+j+kSUS
         079g==
X-Forwarded-Encrypted: i=1; AJvYcCU3pXq9lySg6pUmOh3d/MIKZ034w+6oYHT3nL2wB407rXcJ1e43xbT/KHJkkUmNIMOVRYdtH0uQ+gS+P+A=@lists.linux.dev
X-Gm-Message-State: AOJu0YwOuFcGmjQIFU0kLXgD2TlJ054w55XjmdqUIILnEGamwIz2yC+m
	yhPCtay7pYlbPLoAUHR6MLG4LDcecyOH5HDh6Vw7yyIpAFnSAwZUln7IzP82uQ==
X-Gm-Gg: ASbGnct8kS68rXgEDcof1dWYsa0iyofcwr3vGRZDqHc3CHo3NRaEHXZuU585xFAD8L0
	7umrH3QmQXi/afYxCf+0DYsoN1+u+OAlYjFQ2wOMUDci/swAu1xxZXfwEV/emZ3whYUdiQe1kyz
	HLSIkDvCQVTC745SlaRlhPkpiVgglIFs1xyttlH846gKT2zGxPk18+hZDaosREiDWetwDIlFJIF
	R2ulycTstAOVXbMy3zsHtI0tK8o1rVsNIYwr39MLStZSr5TeTykNj6fchRQVVLgHCZUpl8f97M5
	xqW+/Kl9yyojmhgIQDBHDYnxq9N7
X-Google-Smtp-Source: AGHT+IHsmCtT0BD6IrraDycago+v0DRU/6EPtntyLjiexxdvbBR0cbJtcpyVIcAxjR5YjW2IFBWOQw==
X-Received: by 2002:a05:6102:3747:b0:4af:c31d:b4e9 with SMTP id ada2fe7eead31-4b128fedb4cmr851826137.13.1733860567449;
        Tue, 10 Dec 2024 11:56:07 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85c2ba7dc70sm1279522241.15.2024.12.10.11.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:56:06 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 0/7] ipu6: get rid of all the IS_ENABLED(CONFIG_ACPI)
Date: Tue, 10 Dec 2024 19:55:57 +0000
Message-Id: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM2cWGcC/3WMyw6CMBBFf4V07Rg6lvJY+R/GBdQpzAJKWmk0h
 H+3sNS4PPdxVhHIMwXRZKvwFDmwmxJcTpkwQzv1BPxILDBHJSUiWH4Bzwu0aAmrOq9qrURaz55
 SdZhu98QDh6fz70Mc5Z7+OqIECag0YaFMV5bmagbvRl7Gs/O92DUR/1wRcui6VhdVoam29uu6b
 dsH7g2kedwAAAA=
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

Changes in v3:
- Prefer static inlines to macros (Thanks Rafael).
- Link to v2: https://lore.kernel.org/r/20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org

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

 drivers/media/pci/intel/ipu-bridge.c | 28 +++++-----------------------
 include/acpi/acpi_bus.h              | 23 ++++++++++++++++++++---
 include/linux/acpi.h                 |  6 ++++++
 3 files changed, 31 insertions(+), 26 deletions(-)
---
base-commit: 6c10d1adae82e1c8da16e7ebd2320e69f20b9d6f
change-id: 20241122-fix-ipu-a2fe28908964

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

