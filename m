Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1A1226883
	for <acpica-devel@lists.linux.dev>; Tue, 10 Dec 2024 19:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860573; cv=none; b=ttP7E8Ux44TukakMun6XJyrzntYYzx4LulKtCt+L/RUp+DUfgK7Kdlvk8/nlmaLiMhrCMpfKp8VcJ+t7s4yYXKNgYisV48MvboAB6+z1GZiA8lei8Vd3matcW456UsjNPVSgVHcCeTk3YfqH7e/7+gnfHMOQsHR/RBOT+8yXZug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860573; c=relaxed/simple;
	bh=e6N+GiKT6QGfW61aH0GmQOtN0oMTDgLGk2yx2uhx9Pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lSyO3gsCnVMWfDsJFggnga7TdHAGdEdBpKj0LYcdNx/PGbytGMIwfxMOl/a2gxQuz+RwphfKkLeH7RZC38vFJm7DYbVMotUcRma30R/J5djg8HVCKlGW13aHW3+FoPkXUYQ0UOYQ3RF16N6wCCwoTHv2y8AQmXu7FEjxMiLqPl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RdrvqO/z; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RdrvqO/z"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-72739105e02so1999358b3a.0
        for <acpica-devel@lists.linux.dev>; Tue, 10 Dec 2024 11:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733860571; x=1734465371; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhVnUUt21FbgPDOVIQ39erkKtCV93uZ7UVN8hJAABAg=;
        b=RdrvqO/zv0uFQISskeuDZp2/FTdlLM+J3uNfFrrmx/dh8wVKN4CvETVRJ0aVt4L7gy
         vQUeH/pX9uZFeei4l913Zqr3Wbc5jJKNygBKJvgPVOa4SodELZxWJB2sBdG1Meqr38be
         /WuoP89sOSEM/J3qfoaq5pnzcFHUJ0wpKkFWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733860571; x=1734465371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhVnUUt21FbgPDOVIQ39erkKtCV93uZ7UVN8hJAABAg=;
        b=vhJABJnBOHVfYQ8uQUS2Tgqr5oEZySQvxTp2VpLpn1oPTrSGR8N+ddiRfizZf4asMd
         H8VL0+78fnzKo2t2vjRzzaHTnn9PBIetNLvxqKlZbkmdYivg6LWiplVQAdGlVqwdaTXf
         xOAJdR4UevzEo0YTlR/CbcctnO0BwMfYdWAQfAZuCTmxOFtb5EnbnSZNf1PZoV2EEsAp
         /QDKIvth3ZZbxIDKMLPT5Y3tPXlz1cSS+oEymHyTvJJqTp/Hv5D25wfX8sefzBnrxG8/
         s+xrf4mxK/BgwX4b83vQFe+MZW2gBxfMeu0z1I20HtMrd0SNtIKqCJhSGbaCobC6chsQ
         G0Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWbeX51rO9cTIE5qOmej8kGOaqhUs1Z26ZhouRoZWhJdufDWOrdJN0Dp0t4RnjyATApsvOQsFj6VQLENAE=@lists.linux.dev
X-Gm-Message-State: AOJu0YwHDz+/rXZcG6hO2UVCgDSsRE9NDyFre3UZsSFV8S/1uw1toXd1
	YMB80wmPa/Dxj2beTgmHf0TuqQ8btfMcT132V6FYcL2LpqFrNqPMRgzvRGGE3hHJZ1BqGhlSYaM
	=
X-Gm-Gg: ASbGncvE+IFE2kvSBWN9cbf3i0+8paFOdg6c8pvUq8O7vpZlCzEw9JqIonBTU8Fk0lv
	FPX0SCzhG4R3Emtm0cQw+39AloSzzQ5gR6lm45vIYg4pBAT+Lo/Zh6EPLJ5glzGbqOtGxOiTU7A
	M96rjgK/TfsTxP/iQcDZC8NYDNTpSa2H4IIdXy6GVu0SgLC7iq04wj5B2pTUBham+HJMEufCWv0
	jZ/aNyFE4TcrN1PN0HSFAgpZ1L3QV5sW6wkOA8WLng1+S8j85cmyN+SY3bE9u+1Dw7STNkmvj52
	Bot+WtIFOrzOL9wT
X-Google-Smtp-Source: AGHT+IF5EaIjfKp72QrM8ybYF6sVN42Z2sLU8bTX2ye+XtQwLxK41dc09/J7rjlKC6uiPVUW7kavqQ==
X-Received: by 2002:a05:6a00:cc4:b0:725:eb85:f7f7 with SMTP id d2e1a72fcca58-728ed1bb33fmr442994b3a.5.1733860570944;
        Tue, 10 Dec 2024 11:56:10 -0800 (PST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com. [209.85.216.47])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725d911615asm6229714b3a.147.2024.12.10.11.56.07
        for <acpica-devel@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 11:56:07 -0800 (PST)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ef760a1001so3597184a91.0
        for <acpica-devel@lists.linux.dev>; Tue, 10 Dec 2024 11:56:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWQjAIIaHwIhIi1XdD41fxdmwViUiZTs9YpsKTQuZcLorKa48XOBBYKilCcnDYT1+w8iMHnHtdqqKYItbw=@lists.linux.dev
X-Received: by 2002:a17:90b:4c84:b0:2ee:ee77:2263 with SMTP id
 98e67ed59e1d1-2f127f50d18mr438841a91.7.1733860566933; Tue, 10 Dec 2024
 11:56:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org>
 <20241122-fix-ipu-v2-3-bba65856e9ff@chromium.org> <CAJZ5v0i9SresLT14aWuyodKyi2y3yyC8wLMYzrSD4ec=9WVSvg@mail.gmail.com>
In-Reply-To: <CAJZ5v0i9SresLT14aWuyodKyi2y3yyC8wLMYzrSD4ec=9WVSvg@mail.gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 20:55:55 +0100
X-Gmail-Original-Message-ID: <CANiDSCsYcQBzUzjACQdhASarR9Ad4bnD035+DZzJnrQboXVDAA@mail.gmail.com>
X-Gm-Features: AZHOrDkADV0-JEZsLMswWL8-2MF9FWIqIKoMqh9rPKxVkdv7pvHri8tCHfHVYAw
Message-ID: <CANiDSCsYcQBzUzjACQdhASarR9Ad4bnD035+DZzJnrQboXVDAA@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] ACPI: bus: implement acpi_get_physical_device_location
 when !ACPI
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Dec 2024 at 19:31, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Nov 22, 2024 at 10:48=E2=80=AFAM Ricardo Ribalda <ribalda@chromiu=
m.org> wrote:
> >
> > Provide an implementation of acpi_get_physical_device_location that can
> > be used when CONFIG_ACPI is not set.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  include/acpi/acpi_bus.h | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index eaafca41cf02..4888231422ea 100644
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
> > @@ -1003,6 +1003,8 @@ static inline int unregister_acpi_bus_type(void *=
bus) { return 0; }
> >
> >  static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
> >
> > +#define acpi_get_physical_device_location(handle, pld) (AE_ERROR)
>
> This is a function, so static inline please.
>
> Analogously in patches [4,6/7].
>
> And you can merge patches [2-6/7] together into one patch, as far as
> I'm concerned.

I was trying to avoid some extra ACPI_PTR and a forward declaration...
But overall I think it looks nicers with static inlines.

I have kept the patches separately. Feel free to squash them if your
prefer that way


Thanks!
>
> > +
> >  #define for_each_acpi_dev_match(adev, hid, uid, hrv)                  =
 \
> >         for (adev =3D NULL; false && (hid) && (uid) && (hrv);)
> >
> >
> > --



--=20
Ricardo Ribalda
