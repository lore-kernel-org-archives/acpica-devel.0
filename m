Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C315C1DC9AB
	for <acpica-devel@lists.linux.dev>; Wed, 11 Dec 2024 08:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905551; cv=none; b=HxsnLlH9Lc5QTjul3EpeW1TZxlvMSstuNW1Tcfo2WLLHZszP3L7syL6UbFM8xJEkWbEbSK7229BabtcDcnhl6pLwPqx8glpmlgQR95Edk8zMQ2p17g6mo1iciW9KqBZy15lLIU7dzFKHLBID8zmqliaDUrH3BjdpN7jMrDrRvw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905551; c=relaxed/simple;
	bh=pbxla0yTksNMB/yfJqiplYk5I6ztCJkCMOXdq941Wsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QflApyluOdDqfpIr/YThQlCP06mrrKaLlm6w6SXOmcKT//oqa6Dj9LEBbgoLor829o0qQAiElXy1mxHjgheZ0zcyuGFy22CaEzTC2foMOMBRoOEVLNKk7v/+BMqx/lfa0bDwALzaY07wztd+/CD8hn+FdQeQgSRyKOhE1CmLo/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E5he/s3u; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E5he/s3u"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-725c86bbae7so4158636b3a.3
        for <acpica-devel@lists.linux.dev>; Wed, 11 Dec 2024 00:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733905549; x=1734510349; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aMeiDMRxTxRMOSHecISft1Z76qFjuaNBQ/+kSc1K3bY=;
        b=E5he/s3uQ8NkzO+zBwXTO4LTUsEox1darIoaCC9CDBfF6Ar60N0UMNxX5qaIqAUyWN
         ePiKGBk6ViDS92e0+vSeOhPAPLunqeSiTd64aT9tkde5kXddo7ceHIn330prly8w0/Qd
         Jcu9Z9vbIT8LmpaToD7WPROMP09CpsfYT3L+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733905549; x=1734510349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMeiDMRxTxRMOSHecISft1Z76qFjuaNBQ/+kSc1K3bY=;
        b=JUreI+dm1ZqMJqpL4uolY5PAGwGO0tZaNnSbe9qu1W5du3MBF1jlIb5S2Qx7uoIVKz
         CF77wTaVXpto4XmLRoEbhQmVnmnBnNiQJnGAOXWpww5DsQwl/KUr3zKItL0QzsxRTqfi
         KPBZgGzP/KhVGhppN2eKry4YEROIi922HxRgbi6waCwSpTOArw0TsmPMT5XHgw0I9X44
         Q2Y/f8GzQ2wDyZcOw4RRMd4eko5xFR+ibjb97avQBVKuXez75zza2tCi322LIl+abG44
         J/NirxSs+UdV18xHXdUNFS2raXXd+kjOHVxtAm3d4Yu7M0/UloYpu0NGwzqjm0DPlTgY
         Drnw==
X-Forwarded-Encrypted: i=1; AJvYcCWhJgPBooMjk2VZUREPxNDKbO/ehydws1mXRKEweRhTPoKPXXLb475DM4SYbHv2mA+amnpwUEUfD0T8A2Q=@lists.linux.dev
X-Gm-Message-State: AOJu0YzN2lX244ioQU0+dDVWiHHJH/2kNquKgsfRxbUhhHQAKpuw3WnZ
	ebJkT3cbqNMbunhLogZtWf07NP1I0DeC53h19CBh+r55kqU5LbKX02v0A/yrxhspWry/P7f+XVk
	=
X-Gm-Gg: ASbGncvkEMofCjrE1bgMMvQOVgCINSkLg6mz5VeKxToCCJXLeGt6sj5yyl6W9bUYy2J
	XC3GGkPDrrv4uSJ8gbz2mDLNYbXdW/sqnIqOlpkkiUQ2JWBQhnCHYLlc4yUoHVNFDUZtVX8VfWS
	ABC4ciwpmKUkLSnsV3FGrAPpIDEEMvU+Z4C2/3dApe3bHBIOTo9cs/2eclddboI67fA11Xg0Eql
	sfo3r+Tt8uUj5f8VAxCFcN/cFLvVV6hNrJYF/I1T5rFS63yNW9tICbDntkatJPxXgCSdOoBSVpe
	ZwxXHZTiM4Y3Z2OqYZqJ
X-Google-Smtp-Source: AGHT+IE2XZo6fjJRYkCRjzF+DQuHY3YJuLUAJTsitzRJjptEI4iiHOrPXGxmoB7TtCo+rj9mdsmZ6Q==
X-Received: by 2002:a05:6a00:4fc7:b0:727:3cd0:1145 with SMTP id d2e1a72fcca58-728ed3bec87mr3584255b3a.2.1733905548947;
        Wed, 11 Dec 2024 00:25:48 -0800 (PST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com. [209.85.214.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725f14f8448sm4514296b3a.31.2024.12.11.00.25.46
        for <acpica-devel@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 00:25:46 -0800 (PST)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21680814d42so10034055ad.2
        for <acpica-devel@lists.linux.dev>; Wed, 11 Dec 2024 00:25:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXtrK0yvXJWE1dEgSBP1wp6O4WCL31EWstdfEkk4HWo7573WY+EVO2HnQgl72YmZjZya7ZcHQu90Z7hiTE=@lists.linux.dev
X-Received: by 2002:a17:90b:1650:b0:2ee:a4f2:b311 with SMTP id
 98e67ed59e1d1-2f127f55cacmr3203942a91.8.1733905545661; Wed, 11 Dec 2024
 00:25:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-7-00e409c84a6c@chromium.org> <20241211091954.42a5c778@foz.lan>
In-Reply-To: <20241211091954.42a5c778@foz.lan>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 11 Dec 2024 09:25:33 +0100
X-Gmail-Original-Message-ID: <CANiDSCsHk+QbF3BtrFU8G3UOgZZjTbQf4RhwkYCr+BeFiTYrEg@mail.gmail.com>
X-Gm-Features: AZHOrDlU23tnNgp0likxdl9TeO5EWHsYT3mOqJQICrAuiOLJ0FM89Lhe827RLJA
Message-ID: <CANiDSCsHk+QbF3BtrFU8G3UOgZZjTbQf4RhwkYCr+BeFiTYrEg@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] media: ipu-bridge: Remove unneeded conditional compilations
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

[only Mauro]

On Wed, 11 Dec 2024 at 09:20, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Em Tue, 10 Dec 2024 19:56:04 +0000
> Ricardo Ribalda <ribalda@chromium.org> escreveu:
>
> > The ACPI headers have introduced implementations for some of their
> > functions when the kernel is not configured with ACPI.
> >
> > Let's use them instead of our conditional compilation. It is easier to
> > maintain and less prone to errors.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/pci/intel/ipu-bridge.c | 28 +++++-----------------------
> >  1 file changed, 5 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
> > index be82bc3e27d0..1db994338fdf 100644
> > --- a/drivers/media/pci/intel/ipu-bridge.c
> > +++ b/drivers/media/pci/intel/ipu-bridge.c
> > @@ -2,6 +2,7 @@
> >  /* Author: Dan Scally <djrscally@gmail.com> */
> >
> >  #include <linux/acpi.h>
> > +#include <acpi/acpi_bus.h>
> >  #include <linux/cleanup.h>
> >  #include <linux/device.h>
> >  #include <linux/i2c.h>
> > @@ -107,7 +108,6 @@ static const char * const ipu_vcm_types[] = {
> >       "lc898212axb",
> >  };
> >
> > -#if IS_ENABLED(CONFIG_ACPI)
> >  /*
> >   * Used to figure out IVSC acpi device by ipu_bridge_get_ivsc_acpi_dev()
> >   * instead of device and driver match to probe IVSC device.
> > @@ -127,11 +127,11 @@ static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev
> >               const struct acpi_device_id *acpi_id = &ivsc_acpi_ids[i];
> >               struct acpi_device *consumer, *ivsc_adev;
> >
> > -             acpi_handle handle = acpi_device_handle(adev);
> > +             acpi_handle handle = acpi_device_handle(ACPI_PTR(adev));
> >               for_each_acpi_dev_match(ivsc_adev, acpi_id->id, NULL, -1)
> >                       /* camera sensor depends on IVSC in DSDT if exist */
> >                       for_each_acpi_consumer_dev(ivsc_adev, consumer)
> > -                             if (consumer->handle == handle) {
> > +                             if (ACPI_PTR(consumer->handle) == handle) {
> >                                       acpi_dev_put(consumer);
> >                                       return ivsc_adev;
> >                               }
> > @@ -139,12 +139,6 @@ static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev
> >
> >       return NULL;
> >  }
> > -#else
> > -static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev)
> > -{
> > -     return NULL;
> > -}
> > -#endif
> >
> >  static int ipu_bridge_match_ivsc_dev(struct device *dev, const void *adev)
> >  {
> > @@ -261,9 +255,8 @@ static enum v4l2_fwnode_orientation ipu_bridge_parse_orientation(struct acpi_dev
> >       struct acpi_pld_info *pld = NULL;
> >       acpi_status status = AE_ERROR;
> >
> > -#if IS_ENABLED(CONFIG_ACPI)
> > -     status = acpi_get_physical_device_location(adev->handle, &pld);
> > -#endif
> > +     status = acpi_get_physical_device_location(ACPI_PTR(adev->handle),
> > +                                                &pld);
> >       if (ACPI_FAILURE(status)) {
> >               dev_warn(ADEV_DEV(adev), "_PLD call failed, using default orientation\n");
> >               return V4L2_FWNODE_ORIENTATION_EXTERNAL;
> > @@ -498,9 +491,7 @@ static void ipu_bridge_create_connection_swnodes(struct ipu_bridge *bridge,
> >       if (sensor->csi_dev) {
> >               const char *device_hid = "";
> >
> > -#if IS_ENABLED(CONFIG_ACPI)
> >               device_hid = acpi_device_hid(sensor->ivsc_adev);
> > -#endif
> >
> >               snprintf(sensor->ivsc_name, sizeof(sensor->ivsc_name), "%s-%u",
> >                        device_hid, sensor->link);
> > @@ -671,11 +662,7 @@ static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
> >       struct acpi_device *adev = NULL;
> >       int ret;
> >
> > -#if IS_ENABLED(CONFIG_ACPI)
> >       for_each_acpi_dev_match(adev, cfg->hid, NULL, -1) {
> > -#else
> > -     while (true) {
> > -#endif
> >               if (!ACPI_PTR(adev->status.enabled))
> >                       continue;
>
> Heh, that's what I pointed on patch 1: you don't need it there, as this
> will be handled on patch 2.
>
> >
> > @@ -768,15 +755,10 @@ static int ipu_bridge_ivsc_is_ready(void)
> >       unsigned int i;
> >
> >       for (i = 0; i < ARRAY_SIZE(ipu_supported_sensors); i++) {
> > -#if IS_ENABLED(CONFIG_ACPI)
> >               const struct ipu_sensor_config *cfg =
> >                       &ipu_supported_sensors[i];
> >
> >               for_each_acpi_dev_match(sensor_adev, cfg->hid, NULL, -1) {
> > -#else
> > -             while (false) {
> > -                     sensor_adev = NULL;
> > -#endif
> >                       if (!ACPI_PTR(sensor_adev->status.enabled))
> >                               continue;
> >
> >
>
> Considering that you drop patch 1, and keep the ACPI dependencies
> at the header, as proposed by patches 2-6:
>
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kerenel.org>
I will fix the typo in your email


>
> Thanks,
> Mauro



-- 
Ricardo Ribalda
