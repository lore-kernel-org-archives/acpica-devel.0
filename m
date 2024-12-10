Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BD02451EE
	for <acpica-devel@lists.linux.dev>; Tue, 10 Dec 2024 22:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733869933; cv=none; b=JF8Mis3PDYm2xAAQO1vT18pyf2V/HSR3b1YP8WWsDUZHYY+fcK3KoTfLh35wbFCL4VxiMVR3ObjouRgHha4+Q0SOJ1T+ggfpCTm4ogrbeUJwmDuXpGI1lRjPWa1Zm3Wv6zyknJk2dzlYm0sIfE9Mx/2KO1a3AG5qUDdGC+s2KAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733869933; c=relaxed/simple;
	bh=5sAckLh2O+Xqp/B3w/FFV+cbSlpNec1FrjP1mHYiP74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pajbfFnmqb+I8idSKOxyL7LmQQQmpAOjuK+FD87U81FkzscfnyfgvSM46aocUS6R/fr38wnHuS/6NzniAd/pkYcIRc+CQTaD8HdkvRLJQFBHK/z96f7LlNSWZYh6GMfBa1t/Zjp+aoxEMTHsr5pC6TMp2jCNNBL0+0id5HOPaTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YSlW2Ny4; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YSlW2Ny4"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-728e3826211so909181b3a.0
        for <acpica-devel@lists.linux.dev>; Tue, 10 Dec 2024 14:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733869931; x=1734474731; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bbiia8j7j6jNdjJNl2DYQMz55vjkekkDfU83OLWkpH8=;
        b=YSlW2Ny4CeVYxH/lJ4MdjUyOOIgdmCgYpz7Jdh/pWIlr25U7ZddyYR/SBHmiGMuQC/
         Cxiy7JpEGQvhQztn3wzvN+nnjfTxqWtQx5ihYzTny6dhEptHiWi/vGXPZ7kYO/Z8T2I2
         gxc/D0JZsHI6fGhsWmDk0845akz3V3DNTJ/vk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733869931; x=1734474731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bbiia8j7j6jNdjJNl2DYQMz55vjkekkDfU83OLWkpH8=;
        b=I9ahKVWH/bXWsx2wpaSXB9EuDjjTkzGayR2w8ceUYWQ9mUjvamsbjcWYSXaWtJnHB+
         SAeGY1W/VtnXDgJUBkn9rN1V4+2IY7U0kHXRR+ipHtMbUL2p/tjipneppZg1qlNiJa/E
         C6Uyy38aXwzWcJ5QgUEvLxhnA35/aVq1WFADdYQXlbSmrxQW5UcYlRC3++tmWFng2A5J
         EVmw1yG2F5VjuH9MsMqcJUbbUcw0xAPTpVc+dpXumy0rzWXowqtsMc1I8nWimvWg0lkM
         ZZDV3C2lS+VYK2E7Udfo1DIKl2lo0y3PO3PsCUpA8nsiApZsxlfYB2qbeyi6nPNvCvz7
         Hjtg==
X-Forwarded-Encrypted: i=1; AJvYcCVebnk1KD/ra5vbX14Wlsktyx3Xcru5It31awJulxawlzYd75hmWTX1UdIrT/OVmdXK35DZ9V15dDkcNHA=@lists.linux.dev
X-Gm-Message-State: AOJu0YxK/YZ2Ac3jFbHfZpjpp/sUfTzQYzZt/8dONcOKcXfa3rmOZba7
	huqtG5cvhsiTU3FSe2U6sJr03Ljb3FCQ0DfzWOTPk4qbe6DB2jJWmE8zgovEs27QsKPYD1ot2Uo
	=
X-Gm-Gg: ASbGncsd7DuztUiQ1m9RrlOHlFegBLXHpxAot3yO1m6VwuklMJtmF4sFk4gy7gyrDpt
	Y+0AB2nx3SPeHMt6Jwd/rBUma90h4TFppPV3rD83n+fqOOZdMlV0vDNMz7lutLJLKPFjuZjDSCv
	BVbPETeh3b/uUweI/zwe6fkWis9u0LgEQ0PC+0t9Sgzeujs196kTZ5LOqrRk7lcvwLOnvFCLo61
	/3kOejU6L0OcK0m9eosEKBYdiwgSHg8HHTrj4yWWgjPiYi3xH6J2u+XQrcgqOpuAbbVQtJLpgSB
	0EdGRftPGMojf/KU2wxZ
X-Google-Smtp-Source: AGHT+IHG1fFQDil5zjOMRDeZommr3/ttfqYrEhAe3217ONiRO71sw6BeF5EdA23u11jqcfVDzYcGoQ==
X-Received: by 2002:a05:6a21:3944:b0:1e0:d32f:24e2 with SMTP id adf61e73a8af0-1e1c13cde6cmr1531951637.38.1733869931366;
        Tue, 10 Dec 2024 14:32:11 -0800 (PST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com. [209.85.215.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e62bb302sm5035953b3a.139.2024.12.10.14.32.09
        for <acpica-devel@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 14:32:09 -0800 (PST)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7e6cbf6cd1dso3431611a12.3
        for <acpica-devel@lists.linux.dev>; Tue, 10 Dec 2024 14:32:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW8uormzYVelz6I/lMq2WtZ7dmqWdFbaJNGfz/bGauxbDkeBSBCAqcqUZpEzjeLESIH+zIrHGtWbS/BX4M=@lists.linux.dev
X-Received: by 2002:a17:90b:4b12:b0:2ee:c797:e27f with SMTP id
 98e67ed59e1d1-2f12804fc63mr899384a91.36.1733869929209; Tue, 10 Dec 2024
 14:32:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-4-00e409c84a6c@chromium.org> <Z1irAT0KVwqhBSSZ@kekkonen.localdomain>
In-Reply-To: <Z1irAT0KVwqhBSSZ@kekkonen.localdomain>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 23:31:57 +0100
X-Gmail-Original-Message-ID: <CANiDSCsLOODLhGrpPwOQ1j+coSb9yHYi=wjGpZ+F7VbA7AM0og@mail.gmail.com>
X-Gm-Features: AZHOrDm5Mc-6e5PYz70Xt3CVLGWF-rWtXL2uCKjRJio5ykJKaQ08kVB9D3kD-OE
Message-ID: <CANiDSCsLOODLhGrpPwOQ1j+coSb9yHYi=wjGpZ+F7VbA7AM0og@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] ACPI: header: implement acpi_device_handle when !ACPI
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Dec 2024 at 21:56, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>
> Hi Ricardo,
>
> On Tue, Dec 10, 2024 at 07:56:01PM +0000, Ricardo Ribalda wrote:
> > Provide an implementation of acpi_device_handle that can be used when
> > CONFIG_ACPI is not set.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  include/linux/acpi.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index 05f39fbfa485..59a5d110ff54 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -787,6 +787,12 @@ const char *acpi_get_subsystem_id(acpi_handle handle);
> >  #define acpi_dev_hid_uid_match(adev, hid2, uid2)     (adev && false)
> >
> >  struct fwnode_handle;
> > +struct acpi_device;
> > +
> > +static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
> > +{
> > +     return NULL;
> > +}
> >
> >  static inline bool acpi_dev_found(const char *hid)
> >  {
> >
>
> Please remove the extra forward declaration of struct acpi_device a few
> lines below this.

Instead I have moved the function under the forward declaration. Let
me know if you disagree.

>
> With that,
>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>
> --
> Regards,
>
> Sakari Ailus



-- 
Ricardo Ribalda
