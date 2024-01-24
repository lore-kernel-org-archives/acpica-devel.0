Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D7117BA3
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 24 Jan 2024 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706085934; cv=none; b=KOFB9SpNsKp9dxdzgnyT+M3+yHmlR6BNHiETzQ8gfqx3XVCaqA3NCqEWEJLEge8DGACn1OlUJ683T/XSPmH390A0qrR/zfAnKbJu1Wtxx39ISSYHLqM7iw6JcWlVDmpCJmhBdY9hzArwpYsAtvSng5F1GgkSwmvJeFTAh+OPi08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706085934; c=relaxed/simple;
	bh=/nsD3d+E0lLEEpr6zHa2aA4SWpngDZwV5I8Z0fUog+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WD+vLDdNbs7dAxZoW5dQ6RANiSuycw4GAwYPhMgEj39KFESDKYYZuCHaUS1T2Bzj1mQYFtxW0H/EedwApfOLhI0s2gU1h/rXHoFVl1PHtMM3P0VH6UZW7p7mNbdbQ9ewHeStTsWkLI54sMK0fVh7NRHjnHg/8/T6ozOQrtisVUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Nzo1kG4/; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Nzo1kG4/"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2EA2040148
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 24 Jan 2024 08:45:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2EA2040148
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.a=rsa-sha256 header.s=pandora-2019 header.b=Nzo1kG4/
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sFsGz7mLF_uN
	for <acpica-devel@lists.linuxfoundation.org>;
	Wed, 24 Jan 2024 08:45:32 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E3558400E4
	for <acpica-devel@lists.linuxfoundation.org>; Wed, 24 Jan 2024 08:45:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E3558400E4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5lEen0G4yFCsLlAF+wT6cjA+TZeTYFwLA6f1OlJb35c=; b=Nzo1kG4/6uJi4JkVCN2GnsVPSP
	MSCm4FbOrhPHehb1KUJVrH1BJ3z9cxxbnwCC0zxjG3bD8+skV/uIfdTD6Xjbum3MAfAlH46N/Wp+6
	L7YV4CDoxK1vWQMcHAQgVJyJHoNDrjkuxOIry+Y5WoNfp7WvmbHn0uuneIMiaw3MbPLQllmBXaukX
	TYMxIFTn6SoI9/QX7eY4T0qhBicf+VgU4zXx/IN3Fy2G80u7atBOa9GDJ5r57T/AsDstwl/th3j5P
	hRfBkIRpb/e4q3+Na04s1TcgWKeqoYLVLCnejFkjHgtXQ41c1OGcmGHfEku7EHHcuxCj7+We0ZUXO
	+zL7lf9w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41124)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rSYsi-0003f3-2f;
	Wed, 24 Jan 2024 08:45:13 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rSYse-0002ld-Qu; Wed, 24 Jan 2024 08:45:08 +0000
Date: Wed, 24 Jan 2024 08:45:08 +0000
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
Subject: Re: [PATCH RFC v3 05/21] ACPI: Rename ACPI_HOTPLUG_CPU to include
 'present'
Message-ID: <ZbDOFJeRjdaXtVJu@shell.armlinux.org.uk>
References: <CAJZ5v0gwe02uzAQoX0QDHo35OTEozpbnqC6vukjM3aE6HMq9WQ@mail.gmail.com>
 <ZbADTBLDEFtdglho@shell.armlinux.org.uk>
 <CAJZ5v0jh-EdrnjkJep++UDo+Uv4hmR7VV4KYVdF4CK2K+5XLtg@mail.gmail.com>
 <ZbAMjZoybVfiAGcT@shell.armlinux.org.uk>
 <CAJZ5v0gt=MR1JGsPZnZG_AqudA-KMmb4BOa_A6H9B6+Rhe_+JQ@mail.gmail.com>
 <ZbAdAdqqfXRuY3Xj@shell.armlinux.org.uk>
 <CAJZ5v0gsqbeJc4qX-AefOqu53=rDme2XzFXacWz_0zbVBoaXjw@mail.gmail.com>
 <ZbAoJO8f66Dg0lGF@shell.armlinux.org.uk>
 <ZbArzbC19L1YxLHi@shell.armlinux.org.uk>
 <CAJZ5v0jvek=W-FNhiY_0DQha2wDCUv7YW_4jaHUeX0DbYJOX6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jvek=W-FNhiY_0DQha2wDCUv7YW_4jaHUeX0DbYJOX6Q@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 23, 2024 at 11:05:43PM +0100, Rafael J. Wysocki wrote:
> > So why not state that you personally don't want it in the first
> > place? Why this game of cat and mouse and the constantly changing
> > arguments. I guess it's to waste developers time.
> >
> > Well, I'm calling you out for this, because I'm that pissed off
> > at the amount of time you're causing to be wasted.
> 
> And I don't have to suffer this kind of abuse.  Sorry.

And I've had enough of this crap, so I'm not walking away. Good
riddance.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
