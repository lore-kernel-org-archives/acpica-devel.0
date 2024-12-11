Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAA11D63FA
	for <acpica-devel@lists.linux.dev>; Wed, 11 Dec 2024 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933243; cv=none; b=MLpJdxg3Y0jXw91mzfof/5ocZID8VpEraNArnGLWDq+DM4Zr5ix1lltg8uVsA0TqFDzZE/GNo5GR9Q2W/iPi2dLRhlsWm8vZ7Dr+MA53fhuiBJ2lectQ1VwSn3k8QI+HDmHTuP6FiqwLigzOhkXiAWPpvIs9OWhD/DWAssRu9Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933243; c=relaxed/simple;
	bh=q3MgbVb5/iRtsmwIocyzfKWa+QzfMXSv2W6hqdMRRbU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D/1HlMHVPWMlk6Ynv8VOTjCotxcKCVqXuuw1pcvhSwF7QXWfuLDKKmBiIZpqNIGFyJNdXVL1LwSgXD8twFu2Rv6Waq1jqQjKFycJ2XdtW9bP71dwW73K5tuF3HDiZfEtJ9Y7tiENWzp/HJDt1FaetYozNSTdjBTBPWqB4ySQSxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QUB/oOlE; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QUB/oOlE"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6d88282980bso63025486d6.3
        for <acpica-devel@lists.linux.dev>; Wed, 11 Dec 2024 08:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733933241; x=1734538041; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3O9J29LWzCU8drwsrvfcYJ/OGiJlSXBsqUHcuK76qfw=;
        b=QUB/oOlEWFF1H61MQvD6EYQI4t7/37fQ4xwFkBpHvyMSBngcvrezf33l/H4U9ZVxBJ
         dJyrSeaM8+pfETQbYEQk0hZJ598Z+Twh8FiykGTndPgN5HvlJsO8NAod54KDOLPMxuKG
         /3QbdVPjbJGqNcM2/NTM4Kn+VaKbOnxJg35iU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933241; x=1734538041;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3O9J29LWzCU8drwsrvfcYJ/OGiJlSXBsqUHcuK76qfw=;
        b=U8SO5No7F67Vwex9MOxyufjr4tsJsoMKc41NlHD1dveEoaP+Xhz+LKwrHvKLp8h+fa
         OWNuAilwuIQoxpXZJ9mB6XCGtaZb6wO1XXtHYyhoPAHjSGew/JYwqJ8TjATnjaFp4Q9g
         BRL4ce36umW86MJXbzGZNb19oIrb8CEp58KnRxKyhxUwzeZK55apLxrf6vjCKtsg6vDL
         bxXYL8fq7P756YmXuRn4//HpycWyqIri+5sN8Qh5ZA+GhToRZdNKjKgAHwfFcJfUof2Q
         WleeTBYTTaZoL1lbQ+/3o5WLuoHElLsccm/r/EcetpurWBNw6u3+4cJbndkuCtC83Mwt
         kvyA==
X-Forwarded-Encrypted: i=1; AJvYcCUHu4eUEuHEQfZ5/+Vw1UENxd05LVE61OngNrPQBbov7sVdfckSFOQZsKFq5fdd1hTaoGGipRI8SXUNRSg=@lists.linux.dev
X-Gm-Message-State: AOJu0YyVi37i2qTRR4A8O3HbYcbsUA7aO3YxqCg5emz6rJ2XMB0i5kCr
	McIvGTps3/edlMK/FvLxcFUF9i3p07fhCn7NMxkqA6YZL8kZIuwSpyoBMHynzg==
X-Gm-Gg: ASbGncuqREfTk8LBZUY8ZSpUWBVDOGZOy8COO9hURSpMKu1Dx3Q8nkuLW8g3eObYuYy
	SzCa8bWbtBSiaaaiqk58OmAlW356PbFvutWBD3HyFPTWwmz8f8bzlB80ILoUMPE4zx7N5ILDkkD
	8GSb/gSsAwaRQe5hUjTk2/wkWJ/dwCyfaPKNeYyR8fw05S6n1XnVnPl8ujtkbWr9Ms78DocULf8
	lBLElBgHh7dqFmJ9Ag4QGUOlaOucMNtGn+2q2eowi2F9d0SIL4jW2kZZkzWDWCb0zn4tdLJv9/J
	y8qFzUTUtS3BPhTh/rkWs5EJkq47
X-Google-Smtp-Source: AGHT+IGjXMkyooU2Nlfv5traS1PR40dqAVdz7XsfULYSTHtrwgyML8EAsh9I9AC7bVBVYJ7VALIc+g==
X-Received: by 2002:a05:6214:766:b0:6d4:1a6e:d343 with SMTP id 6a1803df08f44-6d934b2bb72mr58520676d6.23.1733933240945;
        Wed, 11 Dec 2024 08:07:20 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8daa00671sm71484946d6.88.2024.12.11.08.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:07:20 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v4 0/6] ipu6: get rid of all the IS_ENABLED(CONFIG_ACPI)
Date: Wed, 11 Dec 2024 16:07:16 +0000
Message-Id: <20241211-fix-ipu-v4-0-4102e97aceb6@chromium.org>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALW4WWcC/3WNSw6DIBBAr2JYlwZGROiq92i6QDooC6uBStoY7
 150Y9LP8s3MezOTiMFjJKdiJgGTj364ZxCHgtjO3Fuk/paZAAPBOQB1/kn9OFEDDkFpprQUJF+
 PAfNqK12umTsfH0N4beHE1+l3I3HKKQiJUAnb1LU92y4MvZ/64xBasmYS/FGBMto0Rlaqkqid+
 6GWuwqc7WqZVcZQMG2VMPLz67Isbzwv/jIXAQAA
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
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
Ricardo Ribalda (6):
      ACPI: bus: implement for_each_acpi_dev_match when !ACPI
      ACPI: bus: implement acpi_get_physical_device_location when !ACPI
      ACPI: header: implement acpi_device_handle when !ACPI
      ACPI: bus: implement for_each_acpi_consumer_dev when !ACPI
      ACPI: bus: implement acpi_device_hid when !ACPI
      media: ipu-bridge: Remove unneeded conditional compilations

 drivers/media/pci/intel/ipu-bridge.c | 28 +++++-----------------------
 include/acpi/acpi_bus.h              | 23 ++++++++++++++++++++---
 include/linux/acpi.h                 |  5 +++++
 3 files changed, 30 insertions(+), 26 deletions(-)
---
base-commit: 6c10d1adae82e1c8da16e7ebd2320e69f20b9d6f
change-id: 20241122-fix-ipu-a2fe28908964

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

