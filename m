Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B8917C2
	for <acpica-devel@lists.linux.dev>; Sun, 30 Mar 2025 05:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743314034; cv=none; b=dp2pNv2i4wuANFZBohK6U8T5lKcM8Kv5JmCBpAJP/hVKnLyXkAWVb2BgzzE5vOJ/w/N74Z/EZ1ZhJiyPWUHywt/KlZBy/25NtTBZS1SKjMQWSxnBTVT1qUm0JD9D7JBu3lLSU3WQ2582LRKJo9tagVXrfHvSGIM846L+q0cxHOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743314034; c=relaxed/simple;
	bh=2Fhv9qnvd8RNjpQuGaYtULwR1+y1/6h6SMgBrXpH98g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F4I3PTganicWJGnBUSk4Jh6nLGYJ3O/5rOjpxhVnhhkNFsklDxcsSfyqcol+nIXCKSUkT4JmpNtZNAuGIVbgsFUHkSDJg1Zfze56E9EyskyLLjVLKUZ+pYQXvB9zMr4kEToyRPFLrG26j/szIaYeMXVeqHYYB3hnPrgv+p/48T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fa9QkCcQ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fa9QkCcQ"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2c663a3daso687597466b.2
        for <acpica-devel@lists.linux.dev>; Sat, 29 Mar 2025 22:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743314030; x=1743918830; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f7+opnZnWv2RK4udQA4OVRLQ8DCRiE3lR+tMnaFWVmg=;
        b=Fa9QkCcQaDJOeRq0hvjlB/wyrJ6G5xrhyfhwv5zns5Nycv1+jYVFCxV8+YJjpMFJ2g
         ZcrvSa/GjVNUsU3eIThpTGHsNBo918ZOBr7gA1vEjm37wTFB9W6p73hPRW51EFYuY7vr
         Ibpid4OzgFvqn1GQhZQIybGMZBdHp2WDTjwwbYxo2BeR7GaKS5WWx5YDA1OgUU0e/NzQ
         GexzTiljWbuD4k53MYe1S2woYqW++R2aIqooX+S4TNmgz1x7Sg67TjYH87tSR+iemjTO
         Ua1Y0lyNcEWOL0gerQa2lAJDfrYkYOgwTwMtmPySOddOHJe6y4P3RT0JoPjR8N6GRbkV
         b25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743314030; x=1743918830;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f7+opnZnWv2RK4udQA4OVRLQ8DCRiE3lR+tMnaFWVmg=;
        b=Ug4WnLCQHn2Lyeupg+jlwKaYBWDINKli2Gl2YT2vdbcSlYVBNyALezlyW7gwE+oYrS
         G/GJT8D0Ne3K8dB2+BiN4VL8l2swIjf66rS7mqNlkenSZMEXpG/JS3Z06EmhAk7o4zOS
         +2J9nwWZRkz7fdy+m1nvLc7Sp7L4QWr3gPCXSPPFx13NxgQkbhX9qY/C/gYk4ZQDlwTk
         LknMGDiPf0NZjgqXqlogI2KOqmfuKtPnB6kNh8otCuooiIvATQwkyehuV8mUybr/8vjX
         SXDvOOzCANs6/2QMODFxY20nPn1Tj0iaEnqOATpNOYIQqulciqZN3bbj+arVwyeoQOYG
         O/pA==
X-Forwarded-Encrypted: i=1; AJvYcCUMDUDfZEcz3+BLKrtX5qXHziz5UYyDm/SRJcwbJEvqh8tyO6HMvorL7dND7a3NCHwNkZP3RtFBfBdqaaY=@lists.linux.dev
X-Gm-Message-State: AOJu0YwG7t27T4rnRLEGP1j5qctotTLUcdt5fq/uiWQ5/zrhTGONCryt
	O8PolPSOQhP03wzyg95KgSc8eYjR1VcqDBaWsyVbjQYjWFJz9Am5
X-Gm-Gg: ASbGncvsXRAmul/5q3H/D90vQE6OM7j4IUIt7JPT1tMPOmLQkZ0BsCRgnlCSgfmvX9m
	WntFKkhmFMUFGJToiNpLzgjvfN5cqtSMK+wfGoHeJ5UvE0ZrIkj2bWMaSHZUqOSVv+CKVSdj/em
	UDXV+asJUgYuwC7ut11PxYSGt1H4IEpTD4cmhtj9CmhXidFOOo0WxEe36zBGabPi5rkpXtj1jRA
	EeRjaI/HD1Rd8wkartans95cIo7l5v8kIcPv5Dx38dKFjjt2BMOdN0Y/I5L/JcX+Sv/lXg49xbF
	SwFSsxvbHmLjEMPVJaPGm93zXtN/a0HtkDyI4xAlneG1cTeR4mr8heeZGB3ssX7SlNs=
X-Google-Smtp-Source: AGHT+IFt1IoPQ+hdWHf9zq0XxxQYclb2T0wJwu5XUmcSUTJ7OgzLLs+YQy9bosZqvphuRf4Q85XUYQ==
X-Received: by 2002:a17:907:9629:b0:ac3:c020:25e9 with SMTP id a640c23a62f3a-ac738a96fc7mr372842066b.34.1743314029858;
        Sat, 29 Mar 2025 22:53:49 -0700 (PDT)
Received: from localhost (44.tor-exit.nothingtohide.nl. [192.42.116.218])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac71927b12dsm441296566b.59.2025.03.29.22.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 22:53:49 -0700 (PDT)
Date: Sun, 30 Mar 2025 07:53:40 +0200
From: Ahmed Salem <x0rw3ll@gmail.com>
To: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc: skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] ACPI: replace deprecated strncpy()
Message-ID: <cover.1743313252.git.x0rw3ll@gmail.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

strncpy() is deprecated. This patch series is split over two patches,
the first of which annotates destinations with __nonstring, and the
second replaces strncpy() with strtomem() in the ACPI_COPY_NAMESEG
macro. Additionally, two replacements in drivers/acpi/acpica/tbfind.c:60
with memcpy().

This is an effort to avoid using deprecated interfaces, and potential
compiler warnings in the future.

Link: https://github.com/KSPP/linux/issues/90

Ahmed Salem (2):
  ACPI: mark ACPI_COPY_NAMESEG destinations with __nonstring attribute
  ACPI: replace deprecated strncpy() with strtomem()

 drivers/acpi/acpica/acdebug.h                            | 2 +-
 drivers/acpi/acpica/tbfind.c                             | 4 ++--
 drivers/acpi/prmt.c                                      | 2 +-
 drivers/acpi/sysfs.c                                     | 4 ++--
 include/acpi/actbl.h                                     | 6 +++---
 include/acpi/actypes.h                                   | 2 +-
 tools/power/acpi/os_specific/service_layers/oslinuxtbl.c | 2 +-
 tools/power/acpi/tools/acpidump/apfiles.c                | 2 +-
 8 files changed, 12 insertions(+), 12 deletions(-)


base-commit: b3c623b9a94f7f798715c87e7a75ceeecf15292f
-- 
2.47.2

