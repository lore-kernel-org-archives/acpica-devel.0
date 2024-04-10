Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5923A16DED5
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 10 Apr 2024 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757014; cv=none; b=cfAWBCLSA8IfmNt/cE/GxBu5AzAMZfuMZkLK5NWBeG+ODfxvQB14tb0cTiXL7Byq5vz8c4wzjp+YJBV76zocXwZsb3HoCq/pw/uUhmKzL1Z7JFI+JGyuDd5bwFz8YlWnrDCCpI6WU006v36APrP14X5jhkoOI4brsqiZ/tCaQrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757014; c=relaxed/simple;
	bh=9zjC72oMJYYHMUAUwT5oG2XaeuDan+dzKqCHcr5RWWs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aaZ5XFJfQAe/RqA/LfTOkwY34zp4c4IgTfMklwDrjE6XSVw9sUqMiYjEP1gQhFFe592BDZfZ4OSzp6SxEoCcMmF2A8P+rIVV4DyrYK6vuclK0nH4hblq8oR9SgvKnC6J13JmjUO6ElEGWYnsxtsZYG2NUeNF5aOj+M0NuKjqLw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBF4F41496
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 10 Apr 2024 13:50:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.198
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k7l65gzh3PLd for <acpica-devel@lists.linuxfoundation.org>;
 Wed, 10 Apr 2024 13:50:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.176.79.56; helo=frasgout.his.huawei.com; envelope-from=jonathan.cameron@huawei.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 08226408C8
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 08226408C8
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 08226408C8
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 10 Apr 2024 13:50:09 +0000 (UTC)
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VF3xC2BRXz6K6f2;
	Wed, 10 Apr 2024 21:45:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B565C1400CA;
	Wed, 10 Apr 2024 21:50:06 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Apr
 2024 14:50:06 +0100
Date: Wed, 10 Apr 2024 14:50:05 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Russell King <rmk+kernel@armlinux.org.uk>, <linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
	<kvmarm@lists.linux.dev>, <x86@kernel.org>,
	<acpica-devel@lists.linuxfoundation.org>, <linux-csky@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
	<linux-parisc@vger.kernel.org>, Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>, <jianyong.wu@arm.com>,
	<justin.he@arm.com>, James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC v4 02/15] ACPI: processor: Register all CPUs from
 acpi_processor_get_info()
Message-ID: <20240410145005.00003050@Huawei.com>
In-Reply-To: <CAJZ5v0ggD042sfz3jDXQVDUxQZu_AWaF2ox-Me8CvFeRB8nczw@mail.gmail.com>
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk>
	<E1rVDmU-0027YP-Jz@rmk-PC.armlinux.org.uk>
	<CAJZ5v0iiJpUWq5GMSnKFWQTzn_bdwoQz9m=hDaXNg4Lj_ePF4g@mail.gmail.com>
	<20240322185327.00002416@Huawei.com>
	<20240410134318.0000193c@huawei.com>
	<CAJZ5v0ggD042sfz3jDXQVDUxQZu_AWaF2ox-Me8CvFeRB8nczw@mail.gmail.com>
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

On Wed, 10 Apr 2024 15:28:18 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Wed, Apr 10, 2024 at 2:43=E2=80=AFPM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> > =20
> > > > =20
> > > > > diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> > > > > index 47de0f140ba6..13d052bf13f4 100644
> > > > > --- a/drivers/base/cpu.c
> > > > > +++ b/drivers/base/cpu.c
> > > > > @@ -553,7 +553,11 @@ static void __init cpu_dev_register_generic(=
void)
> > > > >  {
> > > > >         int i, ret;
> > > > >
> > > > > -       if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES))
> > > > > +       /*
> > > > > +        * When ACPI is enabled, CPUs are registered via
> > > > > +        * acpi_processor_get_info().
> > > > > +        */
> > > > > +       if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES) || !acpi_disa=
bled)
> > > > >                 return; =20
> > > >
> > > > Honestly, this looks like a quick hack to me and it absolutely
> > > > requires an ACK from the x86 maintainers to go anywhere. =20
> > > Will address this separately.
> > > =20
> >
> > So do people prefer this hack, or something along lines of the followin=
g?
> >
> > static int __init cpu_dev_register_generic(void)
> > {
> >         int i, ret =3D 0;
> >
> >         for_each_online_cpu(i) {
> >                 if (!get_cpu_device(i)) {
> >                         ret =3D arch_register_cpu(i);
> >                         if (ret)
> >                                 pr_warn("register_cpu %d failed (%d)\n"=
, i, ret);
> >                 }
> >         }
> >         //Probably just eat the error.
> >         return 0;
> > }
> > subsys_initcall_sync(cpu_dev_register_generic); =20
>=20
> I would prefer something like the above.
>=20
> I actually thought that arch_register_cpu() might return something
> like -EPROBE_DEFER when it cannot determine whether or not the CPU is
> really available.

Ok. That would end up looking much more like the original code I think.
So we wouldn't have this late registration at all, or keep it for DT
on arm64?  I'm not sure that's a clean solution though leaves
the x86 path alone.

If we get rid of this catch all, solution would be to move the
!acpi_disabled check into the arm64 version of arch_cpu_register()
because we would only want the delayed registration path to be
used on ACPI cases where the question of CPU availability can't
yet be resolved.

>=20
> Then, the ACPI processor enumeration path may take care of registering
> CPU that have not been registered so far and in the more-or-less the
> same way regardless of the architecture (modulo some arch-specific
> stuff).

If I understand correctly, in acpi_processor_get_info() we'd end up
with a similar check on whether it was already registered (the x86 path)
or had be deferred (arm64 / acpi).
=20
>=20
> In the end, it should be possible to avoid changing the behavior of
> x86 and loongarch in this series.

Possible, yes, but result if I understand correctly is we end up with
very different flows and replication of functionality between the
early registration and the late one. I'm fine with that if you prefer it!

>=20
> > Which may look familiar at it's effectively patch 3 from v3 which was d=
ealing
> > with CPUs missing from DSDT (something we think doesn't happen).
> >
> > It might be possible to elide the arch_register_cpu() in
> > make_present() but that will mean we use different flows in this patch =
set
> > for the hotplug and initially present cases which is a bit messy.
> >
> > I've tested this lightly on arm64 and x86 ACPI + DT booting and it "see=
ms" fine. =20
>=20
> Sounds promising.

Possibly not that relevant though if proposal is to drop this approach. :(
At least I now have test setups!

Jonathan
>=20
> Thanks!

