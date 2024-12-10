Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6223F86355
	for <acpica-devel@lists.linux.dev>; Tue, 10 Dec 2024 22:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733870153; cv=none; b=lZhRe9lhBgmSTg58ur9BZdqENGwyvFc6ZzNgFqS5VOflyw4e3NDNcqNWBSsQKI3K4gJBMp9dmDxMjm1g9VpDZn+gBuZDc0eVePCZn0sSN9AHlM19Qh4KkCgyU7vM+nr5Yu/rcFVuBNMWujsYplBp8bjPqydOXfx/RQr9RcH9yc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733870153; c=relaxed/simple;
	bh=tvt3zv+eF6/MbzKSgaDb44zYstTrL0JwPAz1hDN8QLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W6MVzArdl1mNz6Ee339HBI9aDWYEjNiupMbd6cxbS3JdvSWkbfUHDSqfVxzuoFzCAXSM/w7DQdsnsr5R75VLWbf7R2y9IO+1uVqKett1qgwafvVeJgGBiNw03cYsxEAStAy/eSBvYpETxVzGNOPbfHLmJusDGPovHEcyWlZbK64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I0UW3CQ1; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I0UW3CQ1"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2163b0c09afso30464485ad.0
        for <acpica-devel@lists.linux.dev>; Tue, 10 Dec 2024 14:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733870151; x=1734474951; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SegVvC3hp1egRino8jTe24lodQ7Lif4l65T8hABKrm0=;
        b=I0UW3CQ1ZH2ejWlmffmnyk9yxgYFtYyYTOGMYL3C4buwo8WMadEB9Tp7PjJT00G0Lt
         NUFWCJnO50i6fW7r5mkZtOuku2Wo3i7rp1YFjW4xRtp8sM2tLqy+Ts0XTakLU7XNLNyj
         IoyR93TfDTDNepLgjWIUnOCFrcCSZ07Kx5TeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733870151; x=1734474951;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SegVvC3hp1egRino8jTe24lodQ7Lif4l65T8hABKrm0=;
        b=d0tVmGkh8c+uBEgJXcYla3GmWZ+92Q0CY3yMYgoHWKaPUCz/ywXg1QVeb/uj+vjEiO
         99R4kQfNCagsSNTQc29350Q+sr9glQWmTeMV9f9D7nBdAZaE9J07tEb9ajzvFujYYoqR
         zMxZpUUn02e7BC3gLRBxj/O2YNlj2VO7ds/OwTdS8SRPGxPdLWU/sDn9B8lJoXBK1gx2
         /zX0dUsh3ckZ00Dt0MIoagHsDZQY+UF96Gr3lnN2E6VnvHrll0T2EMX+gLvsK8tYnGu8
         0v40rVxLX+NhVG3hGog8OmcZ+Ra4ljk5R8Ox5rVcZVJcR4K9uaxcclhfl/TqMbX+RPmU
         9tFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0FeVj0sUVq57R9sC+U3LaYH0nnoZEhzvprzSyxyPAtY7uIeCYqnZ9+33nE1GRph6VcOudaobeTXouVtI=@lists.linux.dev
X-Gm-Message-State: AOJu0YwKTu6LBj3jxwbiA+CFy2R4Fltg/3X/576BLOg5iHbOEgCM8B11
	Z7AiHiOvOl72tYBTFefc7zLZX6OwjX6sQYyy7M4Ogr0EwC120k6eDjFNSR8tEsawNkFSd6n7MSw
	=
X-Gm-Gg: ASbGncs+5NMqD2R3JJOBpMDeXgjNbAWn3XgemHAbgM4mupJzuq8EcIYnyum7fZmYTrZ
	Zah4gw5mxnQkk8jUJaiZyaXkApdMNA2EwaUQ5Y/sHTbfNH+mSDBEn2gK1IGhhe9YhcKRHLMQn1y
	VpP4syI6hOr4FJe4DIMZNjV70P2rxMFWT6z92UWgHJWxLKKjiuzyQkkODtYnvTbxFFpIhf7WLdY
	o0YQzdtOzEEJFxxPmeptZ50jZ8lHj/nC9UQsL4SZ4sZbQakk4ZitAYwrFwancaO3LAh+7jmL90g
	nimFCRaQAPu/hel7ur1h
X-Google-Smtp-Source: AGHT+IFRGInrsKRd8zapbeDDTipTwVoIOVW2Uqi5OdhONkBOjpsT9tMOrVQEldMw6ef/n0dIx89W2A==
X-Received: by 2002:a17:902:dacd:b0:216:7d22:f69 with SMTP id d9443c01a7336-21778695752mr11215565ad.50.1733870151559;
        Tue, 10 Dec 2024 14:35:51 -0800 (PST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com. [209.85.215.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216489d756fsm43969275ad.276.2024.12.10.14.35.48
        for <acpica-devel@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 14:35:48 -0800 (PST)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7fd45005a09so2088739a12.2
        for <acpica-devel@lists.linux.dev>; Tue, 10 Dec 2024 14:35:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV3sMG5HDGVvhz5l4RTFRI47QA1TmHc+fmip2++qc+Oh90OVB1mKutp1exrr/aN/FfrmFrb9LLmLg+iYrM=@lists.linux.dev
X-Received: by 2002:a17:90b:1c08:b0:2ef:67c2:4030 with SMTP id
 98e67ed59e1d1-2f128032323mr929730a91.27.1733870147516; Tue, 10 Dec 2024
 14:35:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-6-00e409c84a6c@chromium.org> <Z1isHpuHqHSX-jHd@kekkonen.localdomain>
In-Reply-To: <Z1isHpuHqHSX-jHd@kekkonen.localdomain>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 23:35:35 +0100
X-Gmail-Original-Message-ID: <CANiDSCt64N5iheWgE0UhmTriLC8duraAaTaiX5fb7+NpXBRiUw@mail.gmail.com>
X-Gm-Features: AZHOrDk0jwuT4BPdDBgtbco-BoT1AXVUFGOsS3tfXUhEEPMwjjkEUWAtW-dj0G0
Message-ID: <CANiDSCt64N5iheWgE0UhmTriLC8duraAaTaiX5fb7+NpXBRiUw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] ACPI: bus: implement acpi_device_hid when !ACPI
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Dec 2024 at 22:01, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>
> Hi Ricardo,
>
> On Tue, Dec 10, 2024 at 07:56:03PM +0000, Ricardo Ribalda wrote:
> > Provide an implementation of acpi_device_hid that can be used when
> > CONFIG_ACPI is not set.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  include/acpi/acpi_bus.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index 4f1b3a6f107b..c25914a152ee 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -1003,6 +1003,11 @@ static inline int unregister_acpi_bus_type(void *bus) { return 0; }
> >
> >  static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
> >
> > +static inline const char *acpi_device_hid(struct acpi_device *device)
> > +{
> > +     return "";
> > +}
>
> I wonder if any caller might expect something of a string if provided?
> Valid _HIDs are either 7 or 8 characters whereas the proper version of the
> function returns "device" when one cannot be found (dummy_hid in
> drivers/acpi/scan.c). Unlikely to be a problem perhaps.

Good point. I changed it to return "device"

Thanks!

>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>
> > +
> >  static inline acpi_status
> >  acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld)
> >  {
> >
>
> --
> Regards,
>
> Sakari Ailus



-- 
Ricardo Ribalda
