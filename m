Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8401534EC
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 29 Jan 2024 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706540757; cv=none; b=UqM+6YQe4X51HOPnVzJC3tg+phjegiPt3Qa82PAyg5E1orJ8NMR+Z8Q3J7++YXGZ9J3ox4+BnCuVzy+XKDBNvsyiv9k/OGcsLES1W1LCP7gstoEPdEfCJooe3i2pC8Nf6ACCi4xuZicR21jzviJo3bqzslew6gGtMREa/XUHqso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706540757; c=relaxed/simple;
	bh=q6I0vmpSP+EMAN7W7TMgr8TqOcKWKp2AWgbxZCoyOoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kq6kWs56ya72AQEib5eFo1ScGmdWWE6nyvAb59QOZkrZZqX6llvAncwGSLaO0pQ1488gm5cJROZGcj5Op+c9+FhY7oiGq17T+1htMTVVDzPepLaQRh4YgMw4s4UyLxLVp227zV457PW2o4b294W3hj6RUywBSbQRQCepBV0cNvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F3E1540159
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 29 Jan 2024 15:05:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F3E1540159
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.398
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g6OaKMfao2Ur
	for <acpica-devel@lists.linuxfoundation.org>;
	Mon, 29 Jan 2024 15:05:55 +0000 (UTC)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 176DF40125
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 29 Jan 2024 15:05:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 176DF40125
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-59a134e29d2so205434eaf.0
        for <acpica-devel@lists.linuxfoundation.org>; Mon, 29 Jan 2024 07:05:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706540754; x=1707145554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkpAjVvacpcOYBIZJzTULHFzBo21BcPnaUhokGVxGPM=;
        b=cIkH4HIdkZ7V1P6wSS6QRcsawxg6VwkxlY7IYvYrY4ew//Xr6DwUgTKy5ZtO0bC0iN
         53Qp34iUfADH69lw1vXhHwjsaPkemLGBu81hRn8yY6164TTAiQKGP71bCItjWwgCa8UI
         0jtvAkDpljo0ZZaUdipxyHT8AbIpvlVPofovyuoa6bD5n76wKx1/HbOyNR7fCm0jOjhl
         kyVWcVF8CeTMacvdbOIplc4T4xJnX2DmjC6yvOvtoeNuWE1IwraWFOm9wXRFLcrhZpC8
         ID9ultMCBF3VckH1B4aOB8JuI7boz4/M8aJn/HHvGWBk6k0ticsJNiLsm1WxuzT918DZ
         QAcw==
X-Gm-Message-State: AOJu0YwfFxzcCkfgA1lRwvhix6u49mMPp+mgYbDZQ5newU6SJ8FuSCTf
	AvJplQ9HKl9NT689X6LpEH38MLYC/0+bwmADSz6KMixvJ9ix1pKzqwR3iCzvCZzuIWL6Ka1zwv6
	udaJcIdRbyy89o4Vum+jZL/6Ggb8=
X-Google-Smtp-Source: AGHT+IEoV4wd4p7kTQOJWXxXpqTUH+qihI2/dlN0Po7tPQqbaCmtMIoU00Uv7+V2Gh58aCyndi1c4Fekk9NhHFrJKEg=
X-Received: by 2002:a4a:c48a:0:b0:599:fbcc:1c75 with SMTP id
 f10-20020a4ac48a000000b00599fbcc1c75mr6541388ooq.0.1706540754026; Mon, 29 Jan
 2024 07:05:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk> <ZXxxa+XZjPZtNfJ+@shell.armlinux.org.uk>
 <20231215161539.00000940@Huawei.com> <5760569.DvuYhMxLoT@kreacher>
 <20240102143925.00004361@Huawei.com> <20240111101949.000075dc@Huawei.com>
 <ZZ/CR/6Voec066DR@shell.armlinux.org.uk> <20240112115205.000043b0@Huawei.com> <Zbe8WQRASx6D6RaG@shell.armlinux.org.uk>
In-Reply-To: <Zbe8WQRASx6D6RaG@shell.armlinux.org.uk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 29 Jan 2024 16:05:42 +0100
Message-ID: <CAJZ5v0iba93EhQB2k3LMdb2YczndbRmF5WGRYHhnqCHq6TQJ0A@mail.gmail.com>
Subject: Re: [PATCH RFC v3 01/21] ACPI: Only enumerate enabled (or functional) devices
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, loongarch@lists.linux.dev, 
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

On Mon, Jan 29, 2024 at 3:55=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> Hi Jonathan,
>
> On Fri, Jan 12, 2024 at 11:52:05AM +0000, Jonathan Cameron wrote:
> > On Thu, 11 Jan 2024 10:26:15 +0000
> > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > > @@ -2381,16 +2388,38 @@ EXPORT_SYMBOL_GPL(acpi_dev_clear_dependencies=
);
> > >   * acpi_dev_ready_for_enumeration - Check if the ACPI device is read=
y for enumeration
> > >   * @device: Pointer to the &struct acpi_device to check
> > >   *
> > > - * Check if the device is present and has no unmet dependencies.
> > > + * Check if the device is functional or enabled and has no unmet dep=
endencies.
> > >   *
> > > - * Return true if the device is ready for enumeratino. Otherwise, re=
turn false.
> > > + * Return true if the device is ready for enumeration. Otherwise, re=
turn false.
> > >   */
> > >  bool acpi_dev_ready_for_enumeration(const struct acpi_device *device=
)
> > >  {
> > >     if (device->flags.honor_deps && device->dep_unmet)
> > >             return false;
> > >
> > > -   return acpi_device_is_present(device);
> > > +   /*
> > > +    * ACPI 6.5's 6.3.7 "_STA (Device Status)" allows firmware to ret=
urn
> > > +    * (!present && functional) for certain types of devices that sho=
uld be
> > > +    * enumerated. Note that the enabled bit should not be set unless=
 the
> > > +    * present bit is set.
> > > +    *
> > > +    * However, limit this only to processor devices to reduce possib=
le
> > > +    * regressions with firmware.
> > > +    */
> > > +   if (device->status.functional)
> > > +           return true;
>
> I have a report from within Oracle that this causes testing failures
> with QEMU using -smp cpus=3D2,maxcpus=3D4. I think it needs to be:
>
>         if (!device->status.present)
>                 return device->status.functional;
>
>         if (device->status.enabled)
>                 return true;
>
>         return !acpi_device_is_processor(device);

The above is fine by me.

> So we can better understand the history here, let's list it as a
> truth table. P=3Dpresent, F=3Dfunctional, E=3Denabled, Orig=3Dhow the cod=
e
> is in mainline, James=3DJames' original proposal, Rafael=3Dthe proposed
> replacement but seems to be buggy, Rmk=3Dthe fixed version that passes
> tests:
>
> P F E   Orig    James   Rafael          Rmk
> 0 0 0   0       0       0               0
> 0 0 1   0       0       0               0
> 0 1 0   1       1       1               1
> 0 1 1   1       0       1               1
> 1 0 0   1       0       !processor      !processor
> 1 0 1   1       1       1               1
> 1 1 0   1       0       1               !processor
> 1 1 1   1       1       1               1
>
> Any objections to this?

So AFAIAC it can return false if not enabled, but present and
functional.  [Side note: I'm wondering what "functional" means then,
but whatever.]
