Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FF6181CFD
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 10 Apr 2024 21:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712783246; cv=none; b=a6rndPmddNrubrOaV75HoBOgp5HI/CMF55dUzY8plUjaskdADj9R2KCIblAWco8Xzt6+ycG48XcWj/9tvGRTd3u5exZ8+LXvE1RjBU50MWSZIBulMYTCAffHNvO/lN3UqcS3BO+BRnHOjsiHAFSV/hGEE2Q3zolD85AjjeRfHhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712783246; c=relaxed/simple;
	bh=WUkQx3MHNfpPK223Za2QnwYdPQf2mwT7iuWRCuTCPQM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TWM9Fo8MTjGaetYD8kwqOBAJwmsNBHM7Xcjl7TOpx8qk6LUdSA9hhvLyT5A/rh11/O3QAVZhTrVRlIpHHAeQbPMMRWWIwRf2IFGfpReLh8RKGUbhhvA/JrFKK7rPyi4snQys5Ppu8iHv8thqTgIDXC8qmpkT8TW50v5uqrCsxtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55F5D820DD
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 10 Apr 2024 21:07:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.198
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KTrCKKSszcKL for <acpica-devel@lists.linuxfoundation.org>;
 Wed, 10 Apr 2024 21:07:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.176.79.56; helo=frasgout.his.huawei.com; envelope-from=jonathan.cameron@huawei.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D648A820DB
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D648A820DB
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D648A820DB
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 10 Apr 2024 21:07:21 +0000 (UTC)
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VFFjC372rz6K6DM;
	Thu, 11 Apr 2024 05:05:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 403711402C7;
	Thu, 11 Apr 2024 05:07:14 +0800 (CST)
Received: from localhost (10.126.168.81) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Apr
 2024 22:07:13 +0100
Date: Wed, 10 Apr 2024 22:07:12 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	<linux-pm@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, <acpica-devel@lists.linuxfoundation.org>,
	<linux-csky@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-ia64@vger.kernel.org>, <linux-parisc@vger.kernel.org>, Salil Mehta
	<salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	<jianyong.wu@arm.com>, <justin.he@arm.com>, James Morse
	<james.morse@arm.com>, Miguel Luis <miguel.luis@oracle.com>
Subject: Re: [PATCH RFC v4 02/15] ACPI: processor: Register all CPUs from
 acpi_processor_get_info()
Message-ID: <20240410220712.0000726f@Huawei.com>
In-Reply-To: <CAJZ5v0gG0xLajHsWXVM+-V+fQZAudvojechUa-DzFgwCs2q8Dg@mail.gmail.com>
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk>
	<E1rVDmU-0027YP-Jz@rmk-PC.armlinux.org.uk>
	<CAJZ5v0iiJpUWq5GMSnKFWQTzn_bdwoQz9m=hDaXNg4Lj_ePF4g@mail.gmail.com>
	<20240322185327.00002416@Huawei.com>
	<20240410134318.0000193c@huawei.com>
	<CAJZ5v0ggD042sfz3jDXQVDUxQZu_AWaF2ox-Me8CvFeRB8nczw@mail.gmail.com>
	<20240410145005.00003050@Huawei.com>
	<ZhbgwBBvh6ccdO7x@shell.armlinux.org.uk>
	<CAJZ5v0gG0xLajHsWXVM+-V+fQZAudvojechUa-DzFgwCs2q8Dg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 10 Apr 2024 21:08:06 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Wed, Apr 10, 2024 at 8:56=E2=80=AFPM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Wed, Apr 10, 2024 at 02:50:05PM +0100, Jonathan Cameron wrote: =20
> > > If we get rid of this catch all, solution would be to move the
> > > !acpi_disabled check into the arm64 version of arch_cpu_register()
> > > because we would only want the delayed registration path to be
> > > used on ACPI cases where the question of CPU availability can't
> > > yet be resolved. =20
> >
> > Aren't we then needing two arch_register_cpu() implementations?
> > I'm assuming that you're suggesting that the !acpi_disabled, then
> > do nothing check is moved into arch_register_cpu() - or to put it
> > another way, arch_register_cpu() does nothing if ACPI is enabled.
> >
> > If arch_register_cpu() does nothing if ACPI is enabled, how do
> > CPUs get registered (and sysfs files get created to control them)
> > on ACPI systems? ACPI wouldn't be able to call arch_register_cpu(),
> > so I suspect you'll need an ACPI-specific version of this function. =20
>=20
> arch_register_cpu() will do what it does, but it will check (upfront)
> if ACPI is enabled and if so, if the ACPI Namespace is available.  In
> the case when ACPI is enabled and the ACPI Namespace is not ready, it
> will return -EPROBE_DEFER (say).

Exactly.  I oversimplified and wasn't clear enough.
The check is there in the arch_register_cpu() and is one of the ways
that function can decide to actually register the cpu but not the only one.

I think we may later want to consider breaking it into 2 arch calls
(check if ready to register + register) to reduce code duplication
in with the hotplug path where there is a little extra to do
inbetween.

Hopefully that can wait though.

Jonathan
