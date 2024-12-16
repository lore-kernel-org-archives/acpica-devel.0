Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B4E1DC04A
	for <acpica-devel@lists.linux.dev>; Mon, 16 Dec 2024 20:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381753; cv=none; b=trYl3sCMcG9jzq07E6ZTgdlGbAYkoBoyv8u9K1rJAUhoCD7lNV5CvTQ+C/zIpAR3jxmBHaTCMnhec+L6WXYktlpke4774ufNmQgKZZPGiMg3K/YCpWTCnTe+EyXhdfe83R/Q99XPguUEKVFrWXE0qtUI6Z2H0TkywuTFApl6kLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381753; c=relaxed/simple;
	bh=9QjWQ7WcKGFYlJPwxvTynGyVMoiDED/7I9tp5nVgQz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMSbRT7zzw9F/gCTXLC7Ihn4MGXyedbfwJWM2KON3B3dAAFSKTLcKRKrt41liAG9Z58SB0QBnRx0VzbwqM0Mlph+OyFJ/I4jOyjnZJslJDD26qK5aMr+Ed4EGiRJs8VTtfnLqtpbtsj2hexvPfyqXdsuJcOL49DMNSrjuwOKUrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lsXleap+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lsXleap+"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21644aca3a0so53853085ad.3
        for <acpica-devel@lists.linux.dev>; Mon, 16 Dec 2024 12:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734381749; x=1734986549; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2NwUtcfc/2jNCrLFAC1JPgfazwYnhzpPLv20A5ylj4=;
        b=lsXleap+yF5M/FPHnbOUdyrEtoYip1SXCgW+caDVeFmsrK00IBnb/HBwXVXjo+XL6y
         vmwkoE7pE5X48cXwLFiXX8T+WkVAmbnLgH/xLJ3JG6y6zAKQozrm1XdweMEZAVMTT9UO
         4qE8AH6xLR1MI8fIwNx2dXQJ1Ci/v27yGBUKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734381749; x=1734986549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2NwUtcfc/2jNCrLFAC1JPgfazwYnhzpPLv20A5ylj4=;
        b=CMCVZpNMFANnl/dvHPJLUGWa4w8fl593Rp+fmqsr7fBLpu0bcmKXVAMd9USaixQNki
         3JNXm9pL3xaPFp8Y6Pwx/kIqFTud//gw7u1bqkzTQJ1siqVTsfu8DFB3iOF0idRhRFXg
         U1De/5DYLX0xHNjwcjXodmb3Lgwop7LWka48kY9nSY2I2J0mNr+pYkdfybcpnrrJ3yYY
         hh6bELHE0+BKqthjNEksycikXz7lsXT/Z9PBPJWEzO3AxOe3c3Ikb7pGddFIKtNBSPf8
         GxVAi8ibqKsizzLTKsX/D3O9XFwHxsSnJ4VPNaY07lLOhc30OT/+W4Tw4Z21z5hCF7rr
         FWbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ/xtTicrauIPgJgBmWPIDZckyAE6M//yxYDowxdPD/Nfe6phrLY8udkddkZPRTSfqUxoIDN7W+4BPlK4=@lists.linux.dev
X-Gm-Message-State: AOJu0YxITbN6cIy8BA/AL3c/aLHown5ibCpYCh2RoBcNdHxfZhHg+ilo
	t0EvsKs5rs4QZJpmsWfm1f83g2wCLzWdSnH63n+/tEEU7AWksy8rT0VAcuVY+9d2xuW4K6RITBY
	=
X-Gm-Gg: ASbGnctoZ9N++nHuiMqC5DkIHfCDTyMf8zRz+MPR0aMHOOkx4m2XeoJ/JiH6KiUyuEq
	f3H2z2K6kDmFHilVxOLcnYn+ADuHY7mrZ9ILpv8x0YEiTmBjakzdf2at46H62x+KPxF5IZleaaF
	/J//YKnbxlGidmuQCLXGY+m+HTssSJ8vD2v48LmuwzZMx6D4oCCq/qQtFGFei34AY37PBNVIYwD
	7h+pdyVMj5+hStxEK2o73VA8ec74ep4sT2g5eKimHwpLFVUZ5+mOvNGP3WgU7whY09xKBTrrzx9
	Ma8lLMuxt/1DN3E2fmWSVDw=
X-Google-Smtp-Source: AGHT+IFKOVd3wWMqM4sWBgqsSgdKb4kgApV5j7IPx/TJdpNUXnAM6jFqIwndo57XwndbVGLZ3qIBBw==
X-Received: by 2002:a17:902:cf0a:b0:216:56c7:98a7 with SMTP id d9443c01a7336-21892a53c03mr236492365ad.53.1734381749150;
        Mon, 16 Dec 2024 12:42:29 -0800 (PST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com. [209.85.215.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e6d87asm46864345ad.264.2024.12.16.12.42.28
        for <acpica-devel@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 12:42:28 -0800 (PST)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fd4998b0dbso3649607a12.0
        for <acpica-devel@lists.linux.dev>; Mon, 16 Dec 2024 12:42:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXAK++hpETTtYVt6OHcXNYVryQHOstok3/spkikj3+TGE4Mo9S3OZhVcvMNUldyepgrMbHMBePoOcMKjlc=@lists.linux.dev
X-Received: by 2002:a17:90b:4a50:b0:2ee:bc7b:924a with SMTP id
 98e67ed59e1d1-2f2901a266bmr17302745a91.28.1734381747835; Mon, 16 Dec 2024
 12:42:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241211-fix-ipu-v4-0-4102e97aceb6@chromium.org>
 <20241211-fix-ipu-v4-2-4102e97aceb6@chromium.org> <CAJZ5v0gmN6+y2DveaBjSqWpTRWqm9zo2t0uDdvGwnVXcdQ777A@mail.gmail.com>
In-Reply-To: <CAJZ5v0gmN6+y2DveaBjSqWpTRWqm9zo2t0uDdvGwnVXcdQ777A@mail.gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 16 Dec 2024 21:42:16 +0100
X-Gmail-Original-Message-ID: <CANiDSCtF6XoAK6t0XNcT1KjGKHJMMFw8oKr1OSS0jkLuwgL8Og@mail.gmail.com>
X-Gm-Features: AbW1kvaPH50jQcGdHOPoZpEMapRhVX_TvQ-lMubFrgv6_CrphG6dWrwQxfPN8to
Message-ID: <CANiDSCtF6XoAK6t0XNcT1KjGKHJMMFw8oKr1OSS0jkLuwgL8Og@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] ACPI: bus: implement acpi_get_physical_device_location
 when !ACPI
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rafael

On Mon, 16 Dec 2024 at 21:17, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Dec 11, 2024 at 5:07=E2=80=AFPM Ricardo Ribalda <ribalda@chromium=
.org> wrote:
> >
> > Provide an implementation of acpi_get_physical_device_location that can
> > be used when CONFIG_ACPI is not set.
> >
> > Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  include/acpi/acpi_bus.h | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index 2b09e513ecf3..b312a72f48ad 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -43,9 +43,6 @@ acpi_status
> >  acpi_evaluate_ost(acpi_handle handle, u32 source_event, u32 status_cod=
e,
> >                   struct acpi_buffer *status_buf);
> >
> > -acpi_status
> > -acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_=
info **pld);
> > -
> >  bool acpi_has_method(acpi_handle handle, char *name);
> >  acpi_status acpi_execute_simple_method(acpi_handle handle, char *metho=
d,
> >                                        u64 arg);
> > @@ -60,6 +57,9 @@ bool acpi_check_dsm(acpi_handle handle, const guid_t =
*guid, u64 rev, u64 funcs);
> >  union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const guid_t =
*guid,
> >                         u64 rev, u64 func, union acpi_object *argv4);
> >  #ifdef CONFIG_ACPI
> > +acpi_status
> > +acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_=
info **pld);
> > +
> >  static inline union acpi_object *
> >  acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 re=
v,
> >                         u64 func, union acpi_object *argv4,
> > @@ -1003,6 +1003,12 @@ static inline int unregister_acpi_bus_type(void =
*bus) { return 0; }
> >
> >  static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
> >
> > +static inline acpi_status
> > +acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_=
info **pld)
> > +{
> > +       return AE_ERROR;
> > +}
>
> I overlooked this before, sorry.
>
> It generally is not OK to use acpi_status and/or AE_ error codes
> without CONFIG_ACPI and they really only should be used in
> drivers/acpi/ (and not everywhere in there for that matter).
>
> So acpi_get_physical_device_location() needs to be redefined to return
> something different from acpi_status (preferably bool) in order to be
> used in !CONFIG_ACPI code.

Shall I redefine it to
bool acpi_get_physical_device_location(acpi_handle handle, struct
acpi_pld_info **pld)/

For both the ACPI and !ACPI cases? or just for the !ACPI?

Regards!

>
> > +
> >  #define for_each_acpi_dev_match(adev, hid, uid, hrv)                  =
 \
> >         for (adev =3D NULL; false && (hid) && (uid) && (hrv); )
> >
> >
> > --



--=20
Ricardo Ribalda
