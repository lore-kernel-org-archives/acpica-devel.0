Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A86B487A2
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 22 Jan 2024 21:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705960603; cv=none; b=bQbi2ughn7c/wIMQAIO0z1BdeoWMpRbC4oYIF4JuxtUWIm/ydrMNGol6WrWhhcv5lQLNMK1F9O8r0Ak8lbT8moidWbrimcfQo/eUqQwiQ2/LINz2Txo9LjIKfXwPu/3a2PBKQIskWrex2TAILJ3V2hM540DlLe3Wr4oYBfkfDUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705960603; c=relaxed/simple;
	bh=J8tuHVuaRf99BTjAxEXGtJuL5FiKMuM5URapCqBOWYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5mAoQWvAmV5j+5UFAp8X/KVh9U2xN71CK2s82xonARuEW4KE4hgJf5CzJkgddy2KfPMVnns5qOAr0Rpp/GNh7WDFP0YATJD4wlovx2rJu3p4Sm+t5VKrBatnQOsnouIlD62IlKoDHbUrvjUgIkxXN71JMgxadeQy52d2O/eel0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=XtyKsMO6; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XtyKsMO6"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B49A34175C
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 22 Jan 2024 21:56:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B49A34175C
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.a=rsa-sha256 header.s=pandora-2019 header.b=XtyKsMO6
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ka0-NUN2DESX
	for <acpica-devel@lists.linuxfoundation.org>;
	Mon, 22 Jan 2024 21:56:40 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6C57A41748
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 22 Jan 2024 21:56:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6C57A41748
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DlkxdPo00vFXMtifZbwmiD3pZWcfGIoDSDnanNUdXxo=; b=XtyKsMO6Yn2dYk1lNRNde3BiDP
	un+RAJyMR6k8+9e/yJl2r+Ov0qOcDIbhiz/y/7GX3fw87B0GNJ/3HmCLVJiLb2Ks1V96LgACams6f
	cX+obUMvFpeX/Pmcl6RnUH2y50c9vxvFy0DDxefuB+2qrsso/uyXuGtyvj3A9FRQHRH/QBhxa5OTm
	Zz/RSWt46rOm+BHPj4216FX8QXMjUNV0DnJe0jlcqUzpr7YBglGllncVFHK+j40azOzpeA1xvOtkS
	tXvN5txsFycplH3UgwgXX380INC6PxDJ2P3HQ+KLP+EUK49pbp89QiATkRHw/56ttdlNvv/I2Oqdt
	A0vRazAA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50158)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rS2HI-0001cI-2Q;
	Mon, 22 Jan 2024 21:56:24 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rS2HC-0001MW-T5; Mon, 22 Jan 2024 21:56:18 +0000
Date: Mon, 22 Jan 2024 21:56:18 +0000
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
	James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC v3 04/21] ACPI: processor: Register all CPUs from
 acpi_processor_get_info()
Message-ID: <Za7kglu6qO1n5ZCg@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
 <E1rDOg7-00Dvjq-VZ@rmk-PC.armlinux.org.uk>
 <CAJZ5v0je=-oVnSumZs=dzcyVuVUeVeTgO7yOnjGg1igyrS7EHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0je=-oVnSumZs=dzcyVuVUeVeTgO7yOnjGg1igyrS7EHQ@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Dec 18, 2023 at 09:30:50PM +0100, Rafael J. Wysocki wrote:
> On Wed, Dec 13, 2023 at 1:49 PM Russell King <rmk+kernel@armlinux.org.uk> wrote:
> > Systems can still be booted with 'acpi=off', or not include an
> > ACPI description at all. For these, the CPUs continue to be
> > registered by cpu_dev_register_generic().
> >
> > This moves the CPU register logic back to a subsys_initcall(),
> > while the memory nodes will have been registered earlier.
> 
> Isn't this somewhat risky?

Not really. The earlier full series moved the registration of CPUs
from subsys (by the various architecture specific code) into the
driver core - thus moving it much earlier. This patch merely
restores it back to the subsys initialisation stage.

There is a low chance that something _could_ have become reliant
on that change - and the longer it takes for this change to be
merged, the more risk there is that something could become reliant
on CPUs being registered very early.

Maybe this ought to be spelt out more explicitly that it's merely
restoring the point at which CPUs are registered.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
