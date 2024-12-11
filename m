Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6073D1D90B1
	for <acpica-devel@lists.linux.dev>; Wed, 11 Dec 2024 08:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733906246; cv=none; b=BTLM+gX0bh8RhSCppMCQ60dR33vSTdY9g78W6JVT5tc0pOL2hxVB7XyAMcR7lvwcSPLD7jcGIXPOpyFs+Q9ozH0aA3AEOv0G9GVoROAxif5e3veGBgsuizmUU6WN2taAr12P12gPlflDHvV1bfdNx0rjIfEP7nXemzTlBDTaMNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733906246; c=relaxed/simple;
	bh=XBgmqrGOR+TiaTyhJ7G4EyEffKB3hn5wBPa+e60msYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3h/RzYQWcfkhSHueu54UGfngHqEEOy8v+Gg2gRtYTb6tSL2dD/VmtyyElyeGPhZCORkGz/7EvTBCO2Gx0eR6Vwx7a3jNnmIzIQwtGpgjELK+EklI+ig0U5/FkKTEzsBprgP7Ryh+PXdv47Po2BD2xLNsjQRGzOLmAm0DaEnb98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kw4taMr+; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kw4taMr+"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ee51f8c47dso4744736a91.1
        for <acpica-devel@lists.linux.dev>; Wed, 11 Dec 2024 00:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733906244; x=1734511044; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qbJ9A+m8ws44k2uM8AYTsZl/eWYOAV0rPVSUcQb9sbo=;
        b=kw4taMr+/PiSQgDIqImD87+0gXsrgPbIIF5QA4QbFWshLwD2llvD4kAtTXXMYOgSMC
         DFfyKcjXnoxo9WinhZMnz9Z8uqz7Q+djyFeEJUr3kiN9rsObajrNSfNJ9HN4kFFMnBrF
         8Aerrov9rx9qvijAZyJrz/L30m1Xvn296I5Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733906244; x=1734511044;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qbJ9A+m8ws44k2uM8AYTsZl/eWYOAV0rPVSUcQb9sbo=;
        b=TAk25Xdeutm2cyJUPjmyDGt5tbwEJPknxdsbiH4WodJLm6+/fN0LPONtOVgWdPuC/1
         5IqcYMoIg/TKMui0oIUvAb+CDw5bNMiTQaWQ4ezVJssO3Yi78L92JOFkOsBLv6bPU8eA
         bxOrKBtN/+vu9SUweXX7QDuS50QtTQynXZVGU+EWOxGvh3maisEcPhXmTwyAaMa6ics8
         goXFoY6tIFtZVg52MDG/7TbBGRDC/uT93IYeW/KMSaBOPZ6XnEk2LQayNGrbEbFqfojI
         J2NS6XiIecXofqS9Wm08zi2hQ8n1XC75imOzOesLo1Wu51Q0Sw+Hu8wZ8nmKuDEwXj52
         MtQw==
X-Forwarded-Encrypted: i=1; AJvYcCUeN4QOjjIUgDJtH9/a4NxZlIbPYwJEj604DCsvb5vqg/8MaOMyd9sl+9apccRHa8Q5l4/Bzo+21L3Ze7E=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywgv7v4x/jSVDN+XwlrkKRJoI4KrGvd2c3TmNcJgjFbk3F9e8XW
	ZC8nf+87weAqZmQGTBlmk1YqAXTaUmUQN01QPIyJnUwyFI95456UTrPBu1u5ORC4xfG90jKpYQ4
	=
X-Gm-Gg: ASbGncvW09bkUpce1tGedJH8aLSrB/cpHn5H+3Spx0lmIqzEKXhH89Nz6qcOkhCx82+
	agzHMOUspsYx34O87jxQA7ExzRJJwQvz2z5l37EfLS8OK5xu2V+heDusPyqS2fHaWIw07sZbVEv
	ZYUIm4c/EZfBrEZ8X4vUYR2ez4hxg8gYCvtX7tl7YawjGehSrliKo5kNExb50PJLvaxS2ciirOb
	HYKfnpqHtKFgcAv/JaLYOFhrn1FFFXVUkbiPdz/XggbUeSJ+qiyigsOH4ll8MXGM20asN98lp+t
	wJxpIX4Zt+o5kosC
X-Google-Smtp-Source: AGHT+IE9atl4Bg9aWCoEPhVErqEPBMPs71fhbmIrwm61esRzK2Jx84ytsbZkz+zT4BmDTvj2R/txfA==
X-Received: by 2002:a17:90b:4c48:b0:2ee:8358:385 with SMTP id 98e67ed59e1d1-2f127f550fbmr3258788a91.4.1733906244481;
        Wed, 11 Dec 2024 00:37:24 -0800 (PST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com. [209.85.216.45])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef26ff86d9sm12976583a91.1.2024.12.11.00.37.20
        for <acpica-devel@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 00:37:21 -0800 (PST)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ef28f07dbaso4738962a91.2
        for <acpica-devel@lists.linux.dev>; Wed, 11 Dec 2024 00:37:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWpSdg/WpcoqAMa2wDcXi0cQRVNwydnUmQKwxP7bNgzLztUcIwKzcUEX+rK34XEum2+HiYKhHC/tXRvl/U=@lists.linux.dev
X-Received: by 2002:a17:90b:4c84:b0:2ea:aa56:499 with SMTP id
 98e67ed59e1d1-2f127f555a9mr3269053a91.1.1733906240145; Wed, 11 Dec 2024
 00:37:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-7-00e409c84a6c@chromium.org> <20241211091954.42a5c778@foz.lan>
 <Z1lOCGJvgFcqmR3R@kekkonen.localdomain>
In-Reply-To: <Z1lOCGJvgFcqmR3R@kekkonen.localdomain>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 11 Dec 2024 09:37:07 +0100
X-Gmail-Original-Message-ID: <CANiDSCvPNf2KiEpr6Tboon6bjUxwEkD=+_AQjhiOA7RDTTpnCw@mail.gmail.com>
X-Gm-Features: AZHOrDlaYtacxTR4SrQpC121lb8rk1oSdpiMfzTs7ikEYNouO9W71c6h8nTE3PY
Message-ID: <CANiDSCvPNf2KiEpr6Tboon6bjUxwEkD=+_AQjhiOA7RDTTpnCw@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] media: ipu-bridge: Remove unneeded conditional compilations
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Dec 2024 at 09:32, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>
> Hi Mauro,
>
> On Wed, Dec 11, 2024 at 09:19:54AM +0100, Mauro Carvalho Chehab wrote:
> > > @@ -768,15 +755,10 @@ static int ipu_bridge_ivsc_is_ready(void)
> > >     unsigned int i;
> > >
> > >     for (i = 0; i < ARRAY_SIZE(ipu_supported_sensors); i++) {
> > > -#if IS_ENABLED(CONFIG_ACPI)
> > >             const struct ipu_sensor_config *cfg =
> > >                     &ipu_supported_sensors[i];
> > >
> > >             for_each_acpi_dev_match(sensor_adev, cfg->hid, NULL, -1) {
> > > -#else
> > > -           while (false) {
> > > -                   sensor_adev = NULL;
> > > -#endif
> > >                     if (!ACPI_PTR(sensor_adev->status.enabled))
> > >                             continue;
> > >
> > >
> >
> > Considering that you drop patch 1, and keep the ACPI dependencies
> > at the header, as proposed by patches 2-6:
> >
> > Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kerenel.org>
>
> The 1st patch fixes a compilation warning when CONFIG_ACPI is disabled.
> Merging that patch as a temporary solution is simply easier than making
> arragements for merging the ACPI patches to the Media tree so the last
> patch may be merged, too.
>
> Besides, the fix should also be backported.
>
> Ricardo: how about adding Cc: stable for that one?

Adding:
    Cc: stable@kernel.org
    Fixes: 8810e055b575 ("media: intel/ipu6: Fix build with !ACPI")
to v4

Regards!

>
> --
> Regards,
>
> Sakari Ailus



-- 
Ricardo Ribalda
