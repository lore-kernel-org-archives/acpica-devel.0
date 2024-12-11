Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007C31D4610
	for <acpica-devel@lists.linux.dev>; Wed, 11 Dec 2024 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904901; cv=none; b=hel8b/lziGVFZzYbfLmRloLvOMN4Wlz5bT2H949fP/xOlTp5xG87B5Ej/fz74Ie1nF8RXGiOavCkUDQd5HXSVf4oQCZx9nl12rDqq4FtYkYMoUghb2X78rIxHSdOV8+TvpQtSE6hmGlj67heWq8uNP6hLNB0eHMrAfrh/nlKAhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904901; c=relaxed/simple;
	bh=OZKCHU/pdesGjb7/BWoBPfGjp7Xwwe+OZIygNrVP4z4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a8TaH+vVOYzkDI9uvWQpWNziMsJ8ZvIcFQVGveOjGuLLVhRlE6Mg2+lPA9uZb7vc3CRl76rXmeDlRuyz7uSLgd4iHbcVd+2ttkT0Ew4/rzodOhkzlskk4eSCf80BxF2Tt2FbPiNrRhYR58OzbogKFGLYV+0WKdPJQekiAasD/xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJStlO1J; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJStlO1J"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d2726c0d45so10062889a12.2
        for <acpica-devel@lists.linux.dev>; Wed, 11 Dec 2024 00:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733904898; x=1734509698; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05XXHLAL1GWs9/FdDgMkTRmUvgatN3ljXIIVcYbLoys=;
        b=gJStlO1JkcicuNvLHX0So+Bs4sW2bdZgB9E/ivfMv67YBzlNCfoD10tGnxyCQtw/yg
         UASJ8daPl5wVirQs2DUC+VV16qh9TNU+BIRwRSeo9PnsJQNJBYaOcWQS1IJSbMxBRvm3
         pE3HEa5ISa3WqMz5C6WZFyYlqJHKr1MbKIqK09q+Ro9Eki8OCMxCKzbQkjDaEBtTDEby
         UkIOL6wpFlejVALdqQkLC+IIF4k91GL5vbB6GzNRT3lKUBBM2N2KUKgJiFwy9UGtCOIF
         NrEzFl+sOk2oFUu7gY4ik4dZ3Mh05PF44pWS/vV5I6Sl4Atjjz4XCX9l1es5jUuXat6D
         6asQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733904898; x=1734509698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05XXHLAL1GWs9/FdDgMkTRmUvgatN3ljXIIVcYbLoys=;
        b=oaThOt74/AJDNsfCYTI9rAJhDsD4hpp4x01N5W+ebiKUwJk2c/Ify3xIZyTVbhskgl
         8nDV3hZzWkSocABvDUdXhBPHLuWe/2K5uzauF0rbDUmjBUuujsro7x1M7R3OQ+uzQr96
         /V8h21iQM2gpSwInIf+V56fPzvm4tFmYIitZD9InM6P+LyUEGJy6OvJtHxwpetfJgwFl
         AqpHEqSuf81kaMob73e5yRXPqj7h1FYMjdC249SvpVTpi5yLD4MMVwJw1bHi413duYkI
         YZEWqfuaYgBGXaOLlJ59v7we0lVxpADYmprr6FoAfk1+2Tl7aOpVYJsbeijhhFvr+5EN
         yQrA==
X-Forwarded-Encrypted: i=1; AJvYcCVmaR5ffUHkp34gotuum4v2ZXREX8d1sHTSYYNR6/KMmozYBCXMYGh4NWSDqDGqJDF0QAj3ujALCkGDa1U=@lists.linux.dev
X-Gm-Message-State: AOJu0YzVGbVE82wsVio6uuqYgsY/aTsbPGHKQgWRmLqO6IMzvEWqlNyH
	EEgAeXBdWhpGWGxOsEhuioyh+ok1z1bGUzh67QhU3kdx/vo6YCW5
X-Gm-Gg: ASbGncsG1FiDCB8uS0oDDbiDvaEupd6+kvoIm7gVB1ehohwDXpy/Gh+MZ9IPT7q51ah
	huoyPmvg3msPRUSQUtf8Z6cm5I/spMcWOQySVnjkZ/YHAMpBrgAxMD0hDSYc7MsCZ0Fl+L3V6H5
	JbqLcBGFJEyaucbHuu1ri0jApK1AxORbnVDWpV3DqSi+L3DASePdP+vgUYeCXqFqoipgsEoiK5W
	5gQTbPS431U77iT6k0VAKqbcOGgIjEHWwvqXILAePtgSt4ooQ==
X-Google-Smtp-Source: AGHT+IFsenM32FRUt0A9qhL2Wv9XuhKKZYu9aGb2En7SV5Vb6M5lSX0nBPskTbG1y2SOMxIxowZ7ZA==
X-Received: by 2002:a17:906:3089:b0:aa6:92de:ddae with SMTP id a640c23a62f3a-aa6b115bd48mr177853166b.16.1733904897999;
        Wed, 11 Dec 2024 00:14:57 -0800 (PST)
Received: from foz.lan ([95.90.158.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa675581337sm546245266b.120.2024.12.11.00.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 00:14:57 -0800 (PST)
Date: Wed, 11 Dec 2024 09:14:53 +0100
From: Mauro Carvalho Chehab <maurochehab@gmail.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Robert Moore
 <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 1/7] media: ipu-bridge: Fix warning when !ACPI
Message-ID: <20241211091147.717e53a4@foz.lan>
In-Reply-To: <20241210-fix-ipu-v3-1-00e409c84a6c@chromium.org>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
	<20241210-fix-ipu-v3-1-00e409c84a6c@chromium.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 10 Dec 2024 19:55:58 +0000
Ricardo Ribalda <ribalda@chromium.org> escreveu:

> One of the quirks that we introduced to build with !ACPI && COMPILE_TEST
> throws the following smatch warning:
> drivers/media/pci/intel/ipu-bridge.c:752 ipu_bridge_ivsc_is_ready() warn: iterator 'i' not incremented
> 
> Fix it by replacing the condition.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/pci/intel/ipu-bridge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
> index a0e9a71580b5..be82bc3e27d0 100644
> --- a/drivers/media/pci/intel/ipu-bridge.c
> +++ b/drivers/media/pci/intel/ipu-bridge.c
> @@ -774,7 +774,7 @@ static int ipu_bridge_ivsc_is_ready(void)
>  
>  		for_each_acpi_dev_match(sensor_adev, cfg->hid, NULL, -1) {
>  #else
> -		while (true) {
> +		while (false) {
>  			sensor_adev = NULL;
>  #endif

The better would be to just remove all #if and handle ACPI compatibility
with COMPILE_TEST inside acpi headers.

Besides that, t sounds that patch 2 makes this hack unneeded, as you added
a false check at the for macro:

	#define for_each_acpi_dev_match(adev, hid, uid, hrv)			\
	for (adev = NULL; false && (hid) && (uid) && (hrv);)

Please place only one set of subsystem maintainers at the To: line,
directing to the one(s) you expect to merge this series.

In this particular case, the one to be added should be the ACPI
maintainers.

Regards,
Mauro
