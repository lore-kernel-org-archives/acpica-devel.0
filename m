Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF14415EFAF
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 10 Apr 2024 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755719; cv=none; b=icMAjHH0cdRS8Jsyrl4afLvg8YKzTX4INvL40EgRFU9wuRRt3HQyUQ0NYoP9HaFNBfMJzKPRMyjzTLMQPnMz+VljadoetxImq6YvnUjkhiLVp9j07X6aXr8uhiit+7VS9CYFxBZBO9U5Oko/1aK+igcKDB5/GNfARbhh1Bb6A1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755719; c=relaxed/simple;
	bh=vG/etX9uFWDRMQyM96dxgcCHcoWyYgwQIb4SGb4iHUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qZJrTVAEs4lJ7XgzkIHk5G2aJjPFvswfwOnJSMeqYcWe4f1kSkIsl2mNmSsXSzjYtAObv7XTTMPOTVQbchmvyIAZgUecz033B4qZtMuVyGWmPto3pn89WDGfXGZcD+pK0OuK0pNYI2+cE6I5Bzq/zpxx4Mt/xdVEEuMFiSZ2WAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cns9UkB5; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cns9UkB5"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6A11A4016B
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 10 Apr 2024 13:28:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -7.101
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jsIi8UMbrXVk for <acpica-devel@lists.linuxfoundation.org>;
 Wed, 10 Apr 2024 13:28:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=rafael@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7817C400BB
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7817C400BB
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cns9UkB5
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7817C400BB
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 10 Apr 2024 13:28:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EF03161CD3
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 10 Apr 2024 13:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44831C41674
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 10 Apr 2024 13:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712755712;
	bh=vG/etX9uFWDRMQyM96dxgcCHcoWyYgwQIb4SGb4iHUc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cns9UkB52Lo8QT1WIRNGmPM4c9Cy0W9tPr1cvPwEauUv12DgcyppPeDSoY/Mg/hXf
	 uCQq3QJf3lAmqaJYrHJ+ZpTvSV1tAN52dZVGMTZO2m96yTAW8orJf2UNPcawFAEk31
	 I2fR2KHimztfKDK3caBnCEnmfw9hcUfuv7ik1CRfduMP3XRE7fMQAdLe/uRlQ0+NOo
	 rSZEKKrznmd+gDFjoFlhoinevWy2PM3QIGRTvnhKTdObtKuZpBJpRm4hUSgrvtBr7F
	 Zw2jK6ZXjnxCOkkNvhH2To3y5qqzaMsxFvJLkmq6tBtHfIPoUgksGfSOMwOy+QAZ65
	 SCusDtAXio95Q==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-22ed9094168so394135fac.1
        for <acpica-devel@lists.linuxfoundation.org>; Wed, 10 Apr 2024 06:28:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWtPx7EJwcKrBCuWC57D5UwK1aIMrB1Oe9LIiaVIZBfRarfbeb8G36V6V//JlceD+7ihNI/6U5Bqhhk00tF4SrGHSgPMgQD/VF/w5zA2zQZXxlHnEwbgw==
X-Gm-Message-State: AOJu0YznjJWKV3oj4Zw6e1gn8tPyJdPm6FjmWue4kUiIQBbUH2nLOOYW
	CK5oroSOjPNRNyCv1+nRZeneiEkeSKMKxoH5txiUX4YORtD/W+UvQUsNYe5Jm6JzimQAyQNCp+W
	U43vb4RjzQjuz64kE78rVarW6F/k=
X-Google-Smtp-Source: AGHT+IFL5SftybRh1r8JWNftMLn5Ll2W8+pkIYo7YlzdluWnaIUYaO6UpMp9mGVfMWaTjUBfbyWqBLpc+8TxlkLduX4=
X-Received: by 2002:a05:6871:a00a:b0:22d:fb4b:9d11 with SMTP id
 vp10-20020a056871a00a00b0022dfb4b9d11mr2534660oab.4.1712755710509; Wed, 10
 Apr 2024 06:28:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk> <E1rVDmU-0027YP-Jz@rmk-PC.armlinux.org.uk>
 <CAJZ5v0iiJpUWq5GMSnKFWQTzn_bdwoQz9m=hDaXNg4Lj_ePF4g@mail.gmail.com>
 <20240322185327.00002416@Huawei.com> <20240410134318.0000193c@huawei.com>
In-Reply-To: <20240410134318.0000193c@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Apr 2024 15:28:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ggD042sfz3jDXQVDUxQZu_AWaF2ox-Me8CvFeRB8nczw@mail.gmail.com>
Message-ID: <CAJZ5v0ggD042sfz3jDXQVDUxQZu_AWaF2ox-Me8CvFeRB8nczw@mail.gmail.com>
Subject: Re: [PATCH RFC v4 02/15] ACPI: processor: Register all CPUs from acpi_processor_get_info()
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>, 
	linux-pm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, 
	acpica-devel@lists.linuxfoundation.org, linux-csky@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org, 
	linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com, justin.he@arm.com, 
	James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 2:43=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> > >
> > > > diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> > > > index 47de0f140ba6..13d052bf13f4 100644
> > > > --- a/drivers/base/cpu.c
> > > > +++ b/drivers/base/cpu.c
> > > > @@ -553,7 +553,11 @@ static void __init cpu_dev_register_generic(vo=
id)
> > > >  {
> > > >         int i, ret;
> > > >
> > > > -       if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES))
> > > > +       /*
> > > > +        * When ACPI is enabled, CPUs are registered via
> > > > +        * acpi_processor_get_info().
> > > > +        */
> > > > +       if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES) || !acpi_disabl=
ed)
> > > >                 return;
> > >
> > > Honestly, this looks like a quick hack to me and it absolutely
> > > requires an ACK from the x86 maintainers to go anywhere.
> > Will address this separately.
> >
>
> So do people prefer this hack, or something along lines of the following?
>
> static int __init cpu_dev_register_generic(void)
> {
>         int i, ret =3D 0;
>
>         for_each_online_cpu(i) {
>                 if (!get_cpu_device(i)) {
>                         ret =3D arch_register_cpu(i);
>                         if (ret)
>                                 pr_warn("register_cpu %d failed (%d)\n", =
i, ret);
>                 }
>         }
>         //Probably just eat the error.
>         return 0;
> }
> subsys_initcall_sync(cpu_dev_register_generic);

I would prefer something like the above.

I actually thought that arch_register_cpu() might return something
like -EPROBE_DEFER when it cannot determine whether or not the CPU is
really available.

Then, the ACPI processor enumeration path may take care of registering
CPU that have not been registered so far and in the more-or-less the
same way regardless of the architecture (modulo some arch-specific
stuff).

In the end, it should be possible to avoid changing the behavior of
x86 and loongarch in this series.

> Which may look familiar at it's effectively patch 3 from v3 which was dea=
ling
> with CPUs missing from DSDT (something we think doesn't happen).
>
> It might be possible to elide the arch_register_cpu() in
> make_present() but that will mean we use different flows in this patch se=
t
> for the hotplug and initially present cases which is a bit messy.
>
> I've tested this lightly on arm64 and x86 ACPI + DT booting and it "seems=
" fine.

Sounds promising.

Thanks!
