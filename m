Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D041657DF
	for <acpica-devel@lists.linuxfoundation.org>; Tue, 20 Feb 2024 11:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708428468; cv=none; b=BIJZ13ILlv0igwuBB5T4V9vAd1tzuyxl/+0coRJOPMgE5FipkTXEXd/uv3RWh99KcolCiVBHitxhOpvnBDaz+myJcrrI2wbJQfF5IoLh7yeKlOFA/tBAE+CrQ2w3XZQXb6ZcbLUEi+6o4qqtePGrvU9lYgIkSJgVJ2YYrwrwGlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708428468; c=relaxed/simple;
	bh=Mipp2WNrLFK4BBvNJ8I27aEf24TMVYEu5ip2QcqVhxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/Oe59fMphj1MOTBbhlUmw49J/7OxcKL10QTFLLafUjIoO1AMi6+wLZ1Gq5wZs/9zDgf4Zp62Y+8B2J09hSTJ/wET/szOW7TqzFTAkHXsgCKXj3otYDSjwJbDyKKkXPsXUP/rxWz97GqLLThEPuck49fZ9Ec+HR087pWFsdLYRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=O6lRSVZh; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="O6lRSVZh"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A789B403EC
	for <acpica-devel@lists.linuxfoundation.org>; Tue, 20 Feb 2024 11:27:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ME0znmebxzhY
	for <acpica-devel@lists.linuxfoundation.org>;
	Tue, 20 Feb 2024 11:27:45 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:4d48:ad52:32c8:5054:ff:fe00:142; helo=pandora.armlinux.org.uk; envelope-from=linux+acpica-devel=lists.linuxfoundation.org@armlinux.org.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9A46940670
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9A46940670
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.a=rsa-sha256 header.s=pandora-2019 header.b=O6lRSVZh
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9A46940670
	for <acpica-devel@lists.linuxfoundation.org>; Tue, 20 Feb 2024 11:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YAbiUOeHNTOOtMQq3T2dYQUt8NBgKEvDfS/NrGbV6TI=; b=O6lRSVZhxbh5i6u+BH25w3f3Cm
	1Vw7wxiDSgvtyuvUnEQCtl4LHsD0HzY1J+QnwBBfWvzYrZnw4ZdEKbmD4OvhU0znyUN2QW3v3TQK6
	acFANS/gPds8L+eRUinfOfYI/5P5/HHW8+MaTKOwBEFBIXcdD2h/rAjy4+NEGoLQ4VhzrvLbGSILa
	e4bVQ4JEXiZ5ggyFjiYKM2SMFHyueGtUiByprCY7LB4A0i9T5NoqAM9yDfSyA8mANNn7sjoowzKXf
	gZg39Bgc4AYxKTEmwc/LOvXE0VrkkOYgYtUo08k1FAqXJPZDFh0Fdt9VSeb+Bh6zHM/C3MKPJvsVF
	UW/+AtXw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54660)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rcOHQ-0002Id-2W;
	Tue, 20 Feb 2024 11:27:20 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rcOHM-0000pR-05; Tue, 20 Feb 2024 11:27:16 +0000
Date: Tue, 20 Feb 2024 11:27:15 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
	x86@kernel.org, acpica-devel@lists.linuxfoundation.org,
	linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
	Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	jianyong.wu@arm.com, justin.he@arm.com,
	James Morse <james.morse@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH RFC v4 02/15] ACPI: processor: Register all CPUs from
 acpi_processor_get_info()
Message-ID: <ZdSMk93c1I6x973h@shell.armlinux.org.uk>
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk>
 <E1rVDmU-0027YP-Jz@rmk-PC.armlinux.org.uk>
 <CAJZ5v0iiJpUWq5GMSnKFWQTzn_bdwoQz9m=hDaXNg4Lj_ePF4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iiJpUWq5GMSnKFWQTzn_bdwoQz9m=hDaXNg4Lj_ePF4g@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 15, 2024 at 08:22:29PM +0100, Rafael J. Wysocki wrote:
> On Wed, Jan 31, 2024 at 5:50 PM Russell King <rmk+kernel@armlinux.org.uk> wrote:
> > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> > index cf7c1cca69dd..a68c475cdea5 100644
> > --- a/drivers/acpi/acpi_processor.c
> > +++ b/drivers/acpi/acpi_processor.c
> > @@ -314,6 +314,18 @@ static int acpi_processor_get_info(struct acpi_device *device)
> >                         cpufreq_add_device("acpi-cpufreq");
> >         }
> >
> > +       /*
> > +        * Register CPUs that are present. get_cpu_device() is used to skip
> > +        * duplicate CPU descriptions from firmware.
> > +        */
> > +       if (!invalid_logical_cpuid(pr->id) && cpu_present(pr->id) &&
> > +           !get_cpu_device(pr->id)) {
> > +               int ret = arch_register_cpu(pr->id);
> > +
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> >         /*
> >          *  Extra Processor objects may be enumerated on MP systems with
> >          *  less than the max # of CPUs. They should be ignored _iff
> 
> This is interesting, because right below there is the following code:
> 
>     if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
>         int ret = acpi_processor_hotadd_init(pr);
> 
>         if (ret)
>             return ret;
>     }
> 
> and acpi_processor_hotadd_init() essentially calls arch_register_cpu()
> with some extra things around it (more about that below).
> 
> I do realize that acpi_processor_hotadd_init() is defined under
> CONFIG_ACPI_HOTPLUG_CPU, so for the sake of the argument let's
> consider an architecture where CONFIG_ACPI_HOTPLUG_CPU is set.
> 
> So why are the two conditionals that almost contradict each other both
> needed?  It looks like the new code could be combined with
> acpi_processor_hotadd_init() to do the right thing in all cases.
> 
> Now, acpi_processor_hotadd_init() does some extra things that look
> like they should be done by the new code too.
> 
> 1. It checks invalid_phys_cpuid() which appears to be a good idea to me.
> 
> 2. It uses locking around arch_register_cpu() which doesn't seem
> unreasonable either.
> 
> 3. It calls acpi_map_cpu() and I'm not sure why this is not done by
> the new code.
> 
> The only thing that can be dropped from it is the _STA check AFAICS,
> because acpi_processor_add() won't even be called if the CPU is not
> present (and not enabled after the first patch).
> 
> So why does the code not do 1 - 3 above?

Honestly, I'm out of my depth with this and can't answer your
questions - and I really don't want to try fiddling with this code
because it's just too icky (even in its current form in mainline)
to be understandable to anyone who hasn't gained a detailed knowledge
of this code.

It's going to require a lot of analysis - how acpi_map_cpuid() behaves
in all circumstances, what this means for invalid_logical_cpuid() and
invalid_phys_cpuid(), what paths will be taken in each case. This code
is already just too hairy for someone who isn't an experienced ACPI
hacker to be able to follow and I don't see an obvious way to make it
more readable.

James' additions make it even more complex and less readable.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
