Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738A541A79A
	for <acpica-devel@lists.linux.dev>; Mon, 27 Jul 2026 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785160446; cv=pass; b=rDe0asUdsKyOeLcljvHuvtxxO0By0M9Rv7com7LElyeX2MLPtHalk7lja7pBHfCB6m2lTC+aZAkpt+feB/KwGP+umpiKQ5SSiqb3OPlBpOT6O2xgYHZElSC2LE7xRiz+PGPZQ/rIG9dyy9YZ6+Csd1d7CYAq8azOvDpQm6ccLrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785160446; c=relaxed/simple;
	bh=fQJyxDv643pqDMxn0ByaDWbHqZIiq7Rg1W4GA2fAA2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uda1la21B5SLMBQbYcSyfoR20A9Ge08cJ/RhjlhjR3/tCkdHAU90lTElDKA6U78gGHjbJ1gVXBNOVQduyEL/59pxVNkiY6PQOAsq+JzmLfoT9cnIidcvqFLx1zFOIhRDUmoDV+QKJwGGiyvACFQcba6tClO3YWdsmr55VkdsFDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=Yqb5sFBo; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="Yqb5sFBo"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493b966dd74so17264655e9.3
        for <acpica-devel@lists.linux.dev>; Mon, 27 Jul 2026 06:54:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785160443; cv=none;
        d=google.com; s=arc-20260327;
        b=Hie5y6V9LEE0MWwN4DWFI8V03Pmsfa+p9o0E5fP5PcUcpFPP8oF8BY5ztbhq1pThLk
         HRqrepczxcFEgzHWsR5SZ2gp2FTaI7TEBmmyttHAs6TdsMu7OvWAmdzArRzx7uxvG32L
         vk1LHKBkHSggO820xU22V63bsbGpnii7qNDglLjEwHSG+8wcXwaRY4B5Hx5wTmibaEAq
         EBSO7woD3uRrfcwUW/PpygIjklhQWvGDEc0o+ig4vZymxHSCF8LOwQDHTqMYjmOGVu0O
         zDqwTxD9Gpftl8RaN2OqkGs4MvgqNUDnWOYVM1W9kwyWvXzMGxbokufzQQk9SYmQqqJA
         /Dbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LkTARaNCDvTrxIcriRua7Id7ovFdqPl8CcOFZ930Vas=;
        fh=OTW8F9Gd/vKSYz7yuOZ6nhB6UGTt9E9ERC3JHqTU364=;
        b=eIugXEAuBKTePuNjc9vTZzbApU0p2YG+J/G0g+dDdQVTX6wij5Ysp0icVTl3QO/HeS
         bZoTqwIm1QU/ruzl1mrbjyCYo2h9EqQMWahr6zdDSA4eNRkSxtqx2stGBneLp2r16iq6
         ipBJYARjXj7i6qRh2FqRPE8MbuTSLpnNbbnbOU4GhaUlFlEREk9Y1ssXTGuWQ/XnLPdm
         fJRybG1Z6hfw5H/Pi9bfg5IQft4P7FvDlNAFesRPsOwEJeO25Zx4hdNO6zcGBTV0xV/K
         rSM95e/BoZ0rfVDJWPh/f3DbQzRG6oklUepsAsvyGzS2A3gzDHV19Yu2HM/sKovMgQBO
         V6Pg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1785160443; x=1785765243; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LkTARaNCDvTrxIcriRua7Id7ovFdqPl8CcOFZ930Vas=;
        b=Yqb5sFBo5iZTonjyZciO5I16vLKV2n9lT/AG0pc9aFHyyMYmBdFtQtgzd2y1J8765N
         Qu2qmcdD5dYfLIR2QhJXR6ruNzd1HQrknPRBeyNtesGLH9F80a3oe4bFxUXvyWiRukNt
         5HEUlDmIPlixLBuWPBHibbJDcxzjvOrHKgWhRnsthl4LNKj8lqmLgeRdMKd5Gg4OXZVz
         eqkv8wbFWa/dtpHtkCmefGTmuDz56Huy4VmK3mdHg15k7JVGMU8qU0Yy+xBg9fZg+uia
         ThTLracJOWkT0bzZYOyg4dTfAM9oEOGfMyoQ4TUVVzXyLWJ3LedYerwNn++HlxVbLzRk
         RR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785160443; x=1785765243;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LkTARaNCDvTrxIcriRua7Id7ovFdqPl8CcOFZ930Vas=;
        b=q8+/ZuIrdVql7TbzaPICwx1a3PwUxF9HomnxQ9KOkY7S9J3wE/WgL1vOgmyZnQK5Im
         Hwps9rR5c2nOk7U2YM0l3R7N70saK3f7+lPx9DcUXkamPu4EKsihB2D0Y6KNZYyCQPYL
         zZRQJ6mg3t80CQOZxopBwkH5RNAb2iJ2T2t25icqUnYgz5Os4ruDbcHDISOHzy9HHUgS
         1vxMfL0RK+BrVy7c5uYLgMQ8bsSqZedcYTBXREgKan1QHjWL5WxiG32FnTXTYi1752Pj
         TN5EEhOJW/4BKoKuKB7p7wpCTaEjcSA9BL6LO2IYgGWDbavtYJpOerwSytjiozPalUyK
         xQSA==
X-Forwarded-Encrypted: i=1; AHgh+RrbmiqnFtZzLlAyrLKRGUxDl93KSnb60u6OVc6VPNGJ2nGsENkmyemUe67HVnK6wlvbFZqhUwSXLNq1Org=@lists.linux.dev
X-Gm-Message-State: AOJu0YyO41VLrOm/QrAssKqu5yLDKMCBoxQ2748gy5HTLI99cQEtiM2z
	Lc3ve0Dk8dCY0b1f1YBYcWwdzg2oGsUMhT+mhlvwYE32EhgQiWb9d/gE/bVIEAyGRz8cLbaACMJ
	K6ooLO6dXJ+lRoEqf8R7g63MW+EZy+flKNrl5xzocEQ==
X-Gm-Gg: AR+sD11ysIM/Bx/JT/mhjiHovGWs2xm+ctjZ+lolfKMK3NOllgis5g5smOFKQgazJke
	gEekSJJUYF3/vJTdCpfLRrrM1qQ5I/qPv1MwiJ/0TyxnnEwJdp8pUxZRJIFXe/uhKj6+9IyvNTX
	AMJDwOlrpPKNyuPRUYMckRUYIQ7uuU52+hc4ttI0rQp71da3c+h10S+eBUZJZRrQtZHUici8Ikh
	O2IPCq1LECVIHZ8Omqko+LN+iEG+rr7NVU7L4smTY3waS7Ot/3LH4hgbGagR8n1tTLhAYIo9VIY
	k2gKfi2xRcotPdQzeAd96Y5nySAQvBitcSD9DhKeuhXYbFZJwivcoqM/n3COWRjs+TZgpjb7AZo
	Cvk6r
X-Received: by 2002:a05:600c:a12:b0:493:eccb:8cb2 with SMTP id
 5b1f17b1804b1-496b57297b8mr114877045e9.30.1785160442437; Mon, 27 Jul 2026
 06:54:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260727084003.1951324-1-anup.patel@oss.qualcomm.com> <71fd5b46-4388-4106-aee9-b4510069975f@arm.com>
In-Reply-To: <71fd5b46-4388-4106-aee9-b4510069975f@arm.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 27 Jul 2026 19:23:50 +0530
X-Gm-Features: AUfX_my4QjrER3hRFjzxXael861bKnyaiQylY-XLFhSCxIc_XNnqTG1sq5MogY4
Message-ID: <CAAhSdy2cDHO2w8VX34WV1kBxHQ6N0H0Ra_r6aDKK86250nWFSA@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: platform: Setup device MSI domain just
 before driver probe
To: Robin Murphy <robin.murphy@arm.com>
Cc: Anup Patel <anup.patel@oss.qualcomm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <pjw@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, Thomas Gleixner <tglx@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Tomasz Jeznach <tomasz.jeznach@linux.dev>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Saket Dumbre <saket.dumbre@intel.com>, Rahul Pathak <rahul@summations.net>, 
	Atish Patra <atish.patra@linux.dev>, Andrew Jones <andrew.jones@oss.qualcomm.com>, 
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	driver-core@lists.linux.dev, iommu@lists.linux.dev, 
	acpica-devel@lists.linux.dev, Sunil V L <sunilvl@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 5:46=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 27/07/2026 9:40 am, Anup Patel wrote:
> > On RISC-V, the MSI controller (aka RISC-V IMSIC) is probed as a regular
> > platform device and MSI client drivers are always probed after the MSI
> > controller driver using fw_devlink. Unfortunately, this is not sufficie=
nt
> > to ensure device MSI domain is set for MSI client devices before driver
> > probe because OF framework sets device MSI domain at the time of platfo=
rm
> > device creation whereas ACPI framework expects arch specific code to se=
t
> > the device MSI domain at the time of platform device creation.
> >
> > Currently, to address the problem of device MSI domain being not set
> > correctly, various RISC-V MSI client drivers explicitly set device
> > MSI domain in the driver probe function using below code pattern:
> >
> >       /*
> >        * The device MSI domain for platform devices on RISC-V architect=
ure
> >        * is only available after the MSI controller driver is probed so=
,
> >        * explicitly configure here.
> >        */
> >       if (!dev_get_msi_domain(dev)) {
> >               /*
> >                * The device MSI domain for OF devices is only set at th=
e
> >                * time of populating/creating OF device. If the device M=
SI
> >                * domain is discovered later after the OF device is crea=
ted
> >                * then we need to set it explicitly before using any pla=
tform
> >                * MSI functions.
> >                */
> >               if (is_of_node(fwnode)) {
> >                       of_msi_configure(dev, dev_of_node(dev));
> >               } else if (is_acpi_device_node(fwnode)) {
> >                       struct irq_domain *msi_domain;
> >                       msi_domain =3D irq_find_matching_fwnode(imsic_acp=
i_get_fwnode(dev),
> >                                                             DOMAIN_BUS_=
PLATFORM_MSI);
> >                       dev_set_msi_domain(dev, msi_domain);
> >               }
> >
> >               if (!dev_get_msi_domain(dev))
> >                       return -EPROBE_DEFER;
>
> I stand by my previous comment that relying on ACPI initcall order and
> assuming fw_devlink is enabled doesn't really seem robust enough to
> justify dropping proper handling of this case, especially if pretending
> it's a generic interface.

I think you still fail to understand the root-cause of the msi_domain not
being set correctly in the struct device. There is no issue with the probe
order (or probe deferral) rather the issue is msi_domain being set very
early by OF / ACPI framework at the time of device creation when there
is no MSI domain registered.

Let's take the case of OF based platform devices with RISC-V:

1) The OF framework set the msi_domain at the time of platform
    device creation but unfortunately the RISC-V MSI controller
    driver is also a platform device (aka RISC-V IMSIC driver) which
    is probed much latter hence the msi_domain for all OF platform
    devices is set to NULL.
    (Refer call path,  of_platform_device_create_pdata() ->
of_msi_configure() -> dev_set_msi_domain()

2) The fw_devlink based probe ordering in the Linux DD framework
    ensures that RISC-V MSI controller driver is probed before the
    MSI client drivers (such as RISC-V APLIC MSI driver, RISC-V
    system MSI driver, etc) but still when these MSI client drivers
    are probed the msi_domain remains NULL for the platform device
    of MSI client.

3) Due to #1 and #2 above, the MSI client driver have to explicitlly
    call of_msi_configure() on RISC-V because no one updates the
    msi_domain of all platform devices after RISC-V MSI controller
    registers a MSI irqdomain.

This patch eliminates the #3 above by calling of_msi_configure()
right before probing the OF platform device.

Regards,
Anup
