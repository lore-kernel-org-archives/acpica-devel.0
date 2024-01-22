Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62DE65BC7
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 22 Jan 2024 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944622; cv=none; b=gd6pAyzocmVDWxZoQksh9JUSZDx/p5QmmRRlp0DuSkvKw4K/KtG3TMF2lDa2swZ/XfvL3aEr0M2XeoFVCKTN61DvNlFahJw1660Fgq5g86HheXj+rM403GbzPQIQnK2DSd4ouDRyPwiKw6P2pOtr1TLvAJiEt55QdsUIxbQijBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944622; c=relaxed/simple;
	bh=oisddIVCSvEu5TDLFqhbkrWXTfVLsyPwSrs8LV1BFts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J10unVakSkWg5tqONWmbtdaqZI0fKh7bQbrimAhg3l038H5JDNlBaJiNS+Mmqc/muV5yC2ywjK40pmO2j4SL3xi9NZeWG4IyIrydC8AIRHVpp0cZ0sUg7NQ4PZh/aixamKvrgjVLWS6hzlpPv95rWxlhbA0/0ft/PpgmOBudnWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=RX/YM9Pw; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RX/YM9Pw"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3CF67606EB
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 22 Jan 2024 17:30:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3CF67606EB
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.a=rsa-sha256 header.s=pandora-2019 header.b=RX/YM9Pw
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 20Qun1Zd5lmh
	for <acpica-devel@lists.linuxfoundation.org>;
	Mon, 22 Jan 2024 17:30:18 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E5D9F600B3
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 22 Jan 2024 17:30:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E5D9F600B3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tqeHdyzk9+LqVKL+Enz5ftndgdvcVseYfwgC7K5xJtc=; b=RX/YM9PwgXxnH0nCr+3iTk8zEu
	evRNa8qak5GpCSjIuF9kG8Ay111DoUzbNpfuCblFeFkBV/fTl433eI5+zAwCHTum0KS01/4Egw5yl
	CtcuTmz+CxuTQRXWXGvmhc7nGHZlb2VvQz+1yrMEKR7yDDAIdbmQaT5B4MQMK5DwYKhXFzXm9VySw
	jZW0uiJxM2NHvoRc0cunafkRBO7+IXV3Ba5DRwtXMnzKPSFxTpf0q/YJhA0/0zbu9jdfzOawjKtoM
	VbvdA1aeq1giRiAjuDGeujTIeI1BX41XMKWx1yFIWgavtQCfYdrinAa3q975nzSh5mU9bJXuzi2RC
	xS+GfMUg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34032)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rRy7a-0001Gs-09;
	Mon, 22 Jan 2024 17:30:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rRy7Z-0001C6-GD; Mon, 22 Jan 2024 17:30:05 +0000
Date: Mon, 22 Jan 2024 17:30:05 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
	x86@kernel.org, acpica-devel@lists.linuxfoundation.org,
	linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
	Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	jianyong.wu@arm.com, justin.he@arm.com,
	James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC v3 03/21] ACPI: processor: Register CPUs that are
 online, but not described in the DSDT
Message-ID: <Za6mHRJVjb6M1mun@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
 <E1rDOg2-00Dvjk-RI@rmk-PC.armlinux.org.uk>
 <CAJZ5v0ju1JHgpjuFLHZVs4NZiARG6iBZN_wza6c2e0kDhZjK0w@mail.gmail.com>
 <ZaURtUvWQyjYfiiO@shell.armlinux.org.uk>
 <20240122160227.00002d83@Huawei.com>
 <CAJZ5v0hamuXJ_w-TSmVb=5jGide=Lb7sCjbzzNb_rFuPrvkgxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hamuXJ_w-TSmVb=5jGide=Lb7sCjbzzNb_rFuPrvkgxQ@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 22, 2024 at 05:22:46PM +0100, Rafael J. Wysocki wrote:
> On Mon, Jan 22, 2024 at 5:02 PM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Mon, 15 Jan 2024 11:06:29 +0000
> > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> >
> > > On Mon, Dec 18, 2023 at 09:22:03PM +0100, Rafael J. Wysocki wrote:
> > > > On Wed, Dec 13, 2023 at 1:49 PM Russell King <rmk+kernel@armlinux.org.uk> wrote:
> > > > >
> > > > > From: James Morse <james.morse@arm.com>
> > > > >
> > > > > ACPI has two descriptions of CPUs, one in the MADT/APIC table, the other
> > > > > in the DSDT. Both are required. (ACPI 6.5's 8.4 "Declaring Processors"
> > > > > says "Each processor in the system must be declared in the ACPI
> > > > > namespace"). Having two descriptions allows firmware authors to get
> > > > > this wrong.
> > > > >
> > > > > If CPUs are described in the MADT/APIC, they will be brought online
> > > > > early during boot. Once the register_cpu() calls are moved to ACPI,
> > > > > they will be based on the DSDT description of the CPUs. When CPUs are
> > > > > missing from the DSDT description, they will end up online, but not
> > > > > registered.
> > > > >
> > > > > Add a helper that runs after acpi_init() has completed to register
> > > > > CPUs that are online, but weren't found in the DSDT. Any CPU that
> > > > > is registered by this code triggers a firmware-bug warning and kernel
> > > > > taint.
> > > > >
> > > > > Qemu TCG only describes the first CPU in the DSDT, unless cpu-hotplug
> > > > > is configured.
> > > >
> > > > So why is this a kernel problem?
> > >
> > > So what are you proposing should be the behaviour here? What this
> > > statement seems to be saying is that QEMU as it exists today only
> > > describes the first CPU in DSDT.
> >
> > This confuses me somewhat, because I'm far from sure which machines this
> > is true for in QEMU.  I'm guessing it's a legacy thing with
> > some old distro version of QEMU - so we'll have to paper over it anyway
> > but for current QEMU I'm not sure it's true.
> >
> > Helpfully there are a bunch of ACPI table tests so I've been checking
> > through all the multi CPU cases.
> >
> > CPU hotplug not enabled.
> > pc/DSDT.dimmpxm  - 4x Processor entries.  -smp 4
> > pc/DSDT.acpihmat - 2x Processor entries.  -smp 2
> > q35/DSDT.acpihmat - 2x Processor entries. -smp 2
> > virt/DSDT.acpihmatvirt - 4x ACPI0007 entries -smp 4
> > q35/DSDT.acpihmat-noinitiator - 4 x Processor () entries -smp 4
> > virt/DSDT.topology - 8x ACPI0007 entries
> >
> > I've also looked at the code and we have various types of
> > CPU hotplug on x86 but they all build appropriate numbers of
> > Processor() entries in DSDT.
> > Arm likewise seems to build the right number of ACPI0007 entries
> > (and doesn't yet have CPU HP support).
> >
> > If anyone can add a reference on why this is needed that would be very
> > helpful.
> 
> Yes, it would.
> 
> Personally, I would prefer to assume that it is not necessary until it
> turns out that (1) there is firmware with this issue actually in use
> and (2) updating the firmware in question to follow the specification
> is not practical.
> 
> Otherwise, we'd make it easier to ship non-compliant firmware for no
> good reason.

If Salil can't come up with a reason, then I'm in favour of dropping
the patch like already done for patch 2. If the code change serves no
useful purpose, there's no point in making the change.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
