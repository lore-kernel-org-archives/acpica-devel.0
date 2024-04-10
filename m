Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8385158DAF
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 10 Apr 2024 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712753008; cv=none; b=DUnHZa3VPPzzT4k/iSZaI+LHs4agHkOsf070+CcKNjD+1Qj+krqM4hpcVvk+aP00sqhUb8i1cmOf0o/1upDJ3wirWJSzNaL4DLPxjQNKihAon5ehihbpeJeK/LrnlfiTQzHStq1nRdCH0UTgIAs36DdGazXsZby18xmNQVoRMYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712753008; c=relaxed/simple;
	bh=oNXkmJLZw0UUlzScvUERB+oZiwnYTzIkRhGzopuv6w0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VFA6eMyWtSgt7Jso9K7tlX/i5HWUrD6eT8MsPhgxTJYbOSSy7bKOe8Rj3l+L+kCK9t9WsNq+5AvTGE7FPUHvLzyu28P8FGAZJqOimDS/cHc21QPRdxla/anSSmkfyAKX/bveOFWIjJy3zNvdkGyoLWwYFOqE9D3V4JaKwjmlng0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8452781B23
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 10 Apr 2024 12:43:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.198
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9I3rPgETecxF for <acpica-devel@lists.linuxfoundation.org>;
 Wed, 10 Apr 2024 12:43:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.176.79.56; helo=frasgout.his.huawei.com; envelope-from=jonathan.cameron@huawei.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0050B8190B
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0050B8190B
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0050B8190B
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 10 Apr 2024 12:43:23 +0000 (UTC)
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VF2Wn6z5Vz6K6Cs;
	Wed, 10 Apr 2024 20:41:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id AB478140DD4;
	Wed, 10 Apr 2024 20:43:19 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Apr
 2024 13:43:19 +0100
Date: Wed, 10 Apr 2024 13:43:18 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
Message-ID: <20240410134318.0000193c@huawei.com>
In-Reply-To: <20240322185327.00002416@Huawei.com>
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk>
	<E1rVDmU-0027YP-Jz@rmk-PC.armlinux.org.uk>
	<CAJZ5v0iiJpUWq5GMSnKFWQTzn_bdwoQz9m=hDaXNg4Lj_ePF4g@mail.gmail.com>
	<20240322185327.00002416@Huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

> >   
> > > diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> > > index 47de0f140ba6..13d052bf13f4 100644
> > > --- a/drivers/base/cpu.c
> > > +++ b/drivers/base/cpu.c
> > > @@ -553,7 +553,11 @@ static void __init cpu_dev_register_generic(void)
> > >  {
> > >         int i, ret;
> > >
> > > -       if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES))
> > > +       /*
> > > +        * When ACPI is enabled, CPUs are registered via
> > > +        * acpi_processor_get_info().
> > > +        */
> > > +       if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES) || !acpi_disabled)
> > >                 return;    
> > 
> > Honestly, this looks like a quick hack to me and it absolutely
> > requires an ACK from the x86 maintainers to go anywhere.  
> Will address this separately.
> 

So do people prefer this hack, or something along lines of the following?

static int __init cpu_dev_register_generic(void)
{
        int i, ret = 0;

        for_each_online_cpu(i) {
                if (!get_cpu_device(i)) {
                        ret = arch_register_cpu(i);
                        if (ret)
                                pr_warn("register_cpu %d failed (%d)\n", i, ret);
                }
        }
	//Probably just eat the error.
        return 0;
}
subsys_initcall_sync(cpu_dev_register_generic);

Which may look familiar at it's effectively patch 3 from v3 which was dealing
with CPUs missing from DSDT (something we think doesn't happen).

It might be possible to elide the arch_register_cpu() in
make_present() but that will mean we use different flows in this patch set
for the hotplug and initially present cases which is a bit messy.

I've tested this lightly on arm64 and x86 ACPI + DT booting and it "seems" fine.

Jonathan

> >   
> > >
> > >         for_each_present_cpu(i) {
> > > --    
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

