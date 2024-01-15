Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC022C68E
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 15 Jan 2024 10:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Sz3CtW8T"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E1B9823C0
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 15 Jan 2024 10:47:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6E1B9823C0
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.a=rsa-sha256 header.s=pandora-2019 header.b=Sz3CtW8T
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xl03Bl9hQo0A
	for <acpica-devel@lists.linuxfoundation.org>;
	Mon, 15 Jan 2024 10:47:37 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A8D8C82333
	for <acpica-devel@lists.linuxfoundation.org>; Mon, 15 Jan 2024 10:47:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A8D8C82333
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BZWJhywUMRRIXvtL5doMOpnSiLPQBWG9w9WPF2MUO4c=; b=Sz3CtW8TvMYVj95XL1EZCET2A+
	QamuonxIFNT3zYkRLRtfqxw7SE6Ou+c1sDlHOm3gafCTRQqOLJZCqlQDm5FD6J4qrogV6aC9NBqKU
	UvioOgQ7gVTi/liinVC4kVe/e4buW1OQKg1r4GMXP3iDla1Qt5/Ci+N1I7TqyALOM7ZH/njEyXM+O
	kqJMAfgr9yHj6be0TqV5AqRnblBaGfn2ZJHMunrt6qJ0b7/ZJ87rjdKUjRsvXgIYphw4O44+TlX5o
	PSgdX1SN3rxuaPmO/lCvJycV2gVlF4hse5S9MWc2dj0rsOcECr0O+epZD/m8Mped50SRNjDOgOXs2
	5FXDnxHg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39864)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rPKUr-0002Ja-0t;
	Mon, 15 Jan 2024 10:47:13 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rPKUm-0002tU-5o; Mon, 15 Jan 2024 10:47:08 +0000
Date: Mon, 15 Jan 2024 10:47:08 +0000
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
Subject: Re: [PATCH RFC v3 02/21] ACPI: processor: Add support for processors
 described as container packages
Message-ID: <ZaUNLMvIYChv6qai@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
 <E1rDOfx-00Dvje-MS@rmk-PC.armlinux.org.uk>
 <CAJZ5v0iB0bS6nmjQ++pV1zp5YSGuigbffK5VD3wsX+8bY9MA5w@mail.gmail.com>
 <20240111175908.00002f46@Huawei.com>
 <ZaA3l4yjgCXxSiVg@shell.armlinux.org.uk>
 <20240112092520.00001278@Huawei.com>
 <CAJZ5v0g2CFPrSfNzHKBz_Spwt304QEQtR6w57VR11i5APPrD8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g2CFPrSfNzHKBz_Spwt304QEQtR6w57VR11i5APPrD8Q@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jan 12, 2024 at 04:01:40PM +0100, Rafael J. Wysocki wrote:
> In any case, it is always better to work on top of the current
> mainline code IMO.

That's fine if one is starting to do some work now, but that is not the
case with this. The first posting was almost a year ago:

	https://lwn.net/Articles/922127/

which likely means that it's been around for at 18 months or more, and
we can also see that this patch was in that original patch set. What
the history of this patch is before the first posting... only James
would be able to answer that and I feel that we're highly unlikely to
get any kind of response.

Anyway, consider this patch dropped from the series.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
