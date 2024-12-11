Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2292451C5
	for <acpica-devel@lists.linux.dev>; Wed, 11 Dec 2024 08:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905163; cv=none; b=AmGupHp4S1Q+3AFM1pFwL9ZngU9mICLgZXdpZD1nCHVb9Q2hCbmJiuM+iVuio5jI7klNeIYHGa57SQKRnWAdUOaWtEnnoz3AjQCieAK8w7JCF0I1YLxePgOv5AVO6J5xnzjZLeZVRUy0swmF/txPQda6Lkikgp/cZ44TUXoxdjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905163; c=relaxed/simple;
	bh=Lsm8C3031w9xBCb23/cgZ3DoZ2ls3z/NYBjnTBCzjJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTYi9tcqENjOGrhLWVCXRx1YfpF0bWz/glmeorcSnxMUP3mXrkwjox53NP51djvfFpYYNW/fNVhAJPxzaq20Rpuh5YzGHMUJ8prXhk6X56cCYNV6bTfC7x/RPYc0Ol2UD3EEl/bBlAA9gysFlNe/QqXIE+YWe9ohZfMjFx0mNH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G2T15aQi; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G2T15aQi"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-728f337a921so175370b3a.3
        for <acpica-devel@lists.linux.dev>; Wed, 11 Dec 2024 00:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733905160; x=1734509960; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S37tUa9+4E/BElh55Abu22jNluchZXe2JCq2BZHuzPc=;
        b=G2T15aQi81NVm0aqTh2nR+qdGgWXVUL2wZ/tNZxok6GB1NsVQMC4pLZ9eApkHHB9uE
         VI0mQ/7455md9GLjoxAzck7blN1dkmnhhNHPBrn3ecAI1bbISegpSWqomPHRD1zP+vKE
         QLmK3RsC3NzWSplygHeFgBHS0Cs4qxOsgQ6xE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733905160; x=1734509960;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S37tUa9+4E/BElh55Abu22jNluchZXe2JCq2BZHuzPc=;
        b=RNC6ns6iRin6O7qYOKAND3rPvBvAvOf1tl+eorxyBRdRAIBN+qSImaJxgPsGOpLTc5
         mJd6dF05KNI8rcfKjyL8qcN4zn5PSViG56CTqUhLq9RmLdUG0HeMdDCaVwEI3L6jYNQU
         GUchpLtzuLg8s9JQMIrFKfDUWZ6G68eF6k+2p06uyWCjjw9SLmNkW7ZlYMTrLlkFHz5H
         xYuGcm+EtXvbOT1Uy7hrzzLCHe9l+6q7pRqfg2mil9E3gpU5z/M3wp8tK4CUoUyEK7yv
         ZOhoHmG8VX3zQAkUFLZHcrQ2GuroiYRFdcluysRIuBQyiis2G0hWEIImkdKxZe+HALZo
         wj6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWh+8UUmHFUY38J5sKawTUwD9gAd5g1CATpggjALOIfJ1zotv6NQ8VnNSXdnW91BAIlEp9Dknf1gwLmEqM=@lists.linux.dev
X-Gm-Message-State: AOJu0YzdGkQHIB2lkZXPDx0SM176xaNk70wuPocfjDtYp8g2ZFYRVWlc
	NV4NhcRWeN/jqiq/vTCOocu27b5vokTqoUTd160BC0+iLreks1x/b5Ch+sODP+ebv2BGqqGBFNw
	=
X-Gm-Gg: ASbGncumgpfDduweNr/ZFTCzCXFOu408CxAA8Ee2QW1cakMC6qvY301uRtyMn6bsUkk
	dM+cu4uQSIH+FOWyD3NmwnmjwhpeHzbtVjdzM5m19HdvYIHQc9e5nf1Fg+QujXfMxifq3PVHJR5
	RMzTO0M4lH1L4cnhlPHuRO5hC/9D7+jZ/LWXGwZ1uvnn0jyxMXmv5Nym/DSeSfzBaoi7BNzU2GF
	tHm/9GYV+YlgqcnxkHN0uq0w4n1/+VhgSCjpJF/YiLk4TpIhm5kxe6t444stoPds517qdNlOCnQ
	Sje5ork+2FEOyeOV
X-Google-Smtp-Source: AGHT+IENPtoNUtW+WYTerO6DVqCxcPSsO2p4KNmFijl7zxQj+/YcHQnbygtxvna7eigafXNuKEjvag==
X-Received: by 2002:a05:6a00:c8a:b0:727:3b77:4174 with SMTP id d2e1a72fcca58-728ed4b9fa7mr3645331b3a.23.1733905160321;
        Wed, 11 Dec 2024 00:19:20 -0800 (PST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com. [209.85.216.53])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29c5af9sm10603239b3a.19.2024.12.11.00.19.19
        for <acpica-devel@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 00:19:19 -0800 (PST)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2eeb4d643a5so5715126a91.3
        for <acpica-devel@lists.linux.dev>; Wed, 11 Dec 2024 00:19:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWjTMmF7aaUpbdvSQMJqj5M0GoVL97h2AGAzu+9KxMLxidrvFn081clYrT3Z/omxjan1Iea40CtPcdpFJE=@lists.linux.dev
X-Received: by 2002:a17:90b:1d91:b0:2ee:f687:6acb with SMTP id
 98e67ed59e1d1-2f127fc7278mr3021275a91.13.1733905159097; Wed, 11 Dec 2024
 00:19:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-1-00e409c84a6c@chromium.org> <20241211091147.717e53a4@foz.lan>
In-Reply-To: <20241211091147.717e53a4@foz.lan>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 11 Dec 2024 09:19:07 +0100
X-Gmail-Original-Message-ID: <CANiDSCvkBvdstVn4GwtdNiJhs67TO6rXVBcsdfRJNgNMXkjvKA@mail.gmail.com>
X-Gm-Features: AZHOrDm09Y0n30eCWNJ7YxalIcoq21V7pnpLmE36rjaksDFouTGIwgN4Tsc_yGk
Message-ID: <CANiDSCvkBvdstVn4GwtdNiJhs67TO6rXVBcsdfRJNgNMXkjvKA@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] media: ipu-bridge: Fix warning when !ACPI
To: Mauro Carvalho Chehab <maurochehab@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi Mauro

On Wed, 11 Dec 2024 at 09:15, Mauro Carvalho Chehab
<maurochehab@gmail.com> wrote:
>
> Em Tue, 10 Dec 2024 19:55:58 +0000
> Ricardo Ribalda <ribalda@chromium.org> escreveu:
>
> > One of the quirks that we introduced to build with !ACPI && COMPILE_TEST
> > throws the following smatch warning:
> > drivers/media/pci/intel/ipu-bridge.c:752 ipu_bridge_ivsc_is_ready() warn: iterator 'i' not incremented
> >
> > Fix it by replacing the condition.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/pci/intel/ipu-bridge.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
> > index a0e9a71580b5..be82bc3e27d0 100644
> > --- a/drivers/media/pci/intel/ipu-bridge.c
> > +++ b/drivers/media/pci/intel/ipu-bridge.c
> > @@ -774,7 +774,7 @@ static int ipu_bridge_ivsc_is_ready(void)
> >
> >               for_each_acpi_dev_match(sensor_adev, cfg->hid, NULL, -1) {
> >  #else
> > -             while (true) {
> > +             while (false) {
> >                       sensor_adev = NULL;
> >  #endif
>
> The better would be to just remove all #if and handle ACPI compatibility
> with COMPILE_TEST inside acpi headers.
>
> Besides that, t sounds that patch 2 makes this hack unneeded, as you added
> a false check at the for macro:
>
>         #define for_each_acpi_dev_match(adev, hid, uid, hrv)                    \
>         for (adev = NULL; false && (hid) && (uid) && (hrv);)
>
> Please place only one set of subsystem maintainers at the To: line,
> directing to the one(s) you expect to merge this series.
>
> In this particular case, the one to be added should be the ACPI
> maintainers.

The plan was to land 1/7 via the media tree with a PR from Sakari soonish.

I believe he has already picked it on his tree. I will remove you from
Cc in the next version

thanks :)

>
> Regards,
> Mauro



-- 
Ricardo Ribalda
