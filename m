Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795494309;
	b=5je+nVsoquM2BYTy9pwXMHMq77WypRMe7N2o+96ZD0ysLfWTSZOUy8RQnbH9bOmtmHY7
	 zBCI5faySs4Ww0A95AruIVTrEBThyC6VHT3zsaSxvglKrmG6fDDG9jQNK0BJfmRpp46NN
	 eENvrxkwMutw8c5IaPgpeGIx9XHqkU0FQwSjpNgWcCThezxpv5SFjhefS4Uno3bcNQw7v
	 NliyUi9aeCdg8Xu9IVDFPVK6OWYfHaaHktFHalnD8x/e0CxnynVU/h7i8lGKHRlFz3onX
	 nBEbeOTiBt6i3eWr5y+MvIe/zPuFteyWinOQv9p8r3UPFss2hxLbYQ+BjK8mATPacpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795494309;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=eNWO3EpiPwmHnNO60cMIGuW+yDmktqgkx2JQzl/eU3g=;
	b=4kJI+SE0g2MkO/iK56tV5DMNesve3LupN6Q6VadBP41/pqJdfDp2FZXMT9VLPsmmytzU
	 OEZSJkyHiCJqjw1uxGLydSPRJuKXGrQ4DKdJ77OKOGFs0dGUfdOVeEunfy1aXGFky6B2V
	 6rTy//sBBEY2/pb5PcDP1k7KoukKZYCVwy54iVu8tbpTvaQ6Y/93r/hvSxMdywTlViYwu
	 1QYr60JaEpWbI6BB81WtWBdnpm+x0x5l+HOhq/Wpr3nnSC/9HcnFtBxLszUSojSmXEj2S
	 8JrL69Lh8Wjw5HQyQErBfUkXvuKrnjgulfkyKbLqZ3m6iu6JdEL7oW6vpQePXDCCbew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=hA4T4ixD;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9F8606A321
	for <acpica-devel@lists.linux.dev>; Tue, 24 Nov 2026 04:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD9F8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=hA4T4ixD
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 847A840E02CC;
	Tue, 24 Nov 2026 04:25:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xxH56HNX3bNB; Tue, 24 Nov 2026 04:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1795494302; bh=eNWO3EpiPwmHnNO60cMIGuW+yDmktqgkx2JQzl/eU3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hA4T4ixDuDgZ9yi2/PnIcEMObAR4VAR1hvQ5li4W49rSNbdwWKGkkZq89QtWRQt2p
	 OVHb5TJT+V6xkJjC7ijoXORjF5bAIHWd28wAICKTtgNJD15UzMSEtIkKcHydqSsQAF
	 6roG1vdAJC+2YILs4Q4xRMavbUMaC6BDAoVmDfg3+SWP7ZFqKLaRwv+j24CUQcmTd0
	 u7ts6nv09wWUqePKgwK9gc9JWEtcNkC6MQFc9sR6p7mi5lJJil9ukXsD1O8nrfbmR0
	 PHGyOdNTYbjwAgdSbssefbrqdaYHDqIbMPBYETtYceAl9JXPa42VAOzcvCbCzadFMU
	 2y84rcNj88IxZsjj6sR0PmoDXGDWipXcpMyfCOUn5rsmElHmxs7/rGTBDhHfW4lVR+
	 TRvP71Mu3jB7baCtSb4tpyMye/neeLq6/eOilNQuhG7s3aBhYpNhXfcWXpIOzMVVyI
	 9eqpKS7fTk+fr87Yc0t122iYwIPoTvvOjwm87E9Fk+VUBbXW3PgQ3CbzbJ4g8Dlf0b
	 eXzbZqcqZ+rX96uLpW0iN9bCN+DHSHvnsnvpCTLD7uEIn/GnMd7mbb7r6J6jwGMFz3
	 R8MM4SoTRH9KLrzmP193gwA0OEX4P35wnmURI6Iaqm1SsC6AvetKA7ogBekQ92Pd57
	 OKYC9Zur7wF3E1q9StArfqZg=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7FC8040E02B4;
	Tue, 24 Nov 2026 04:24:37 +0000 (UTC)
Date: Mon, 23 Nov 2026 20:24:34 -0800
From: Borislav Petkov <bp@alien8.de>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@oss.qualcomm.com>,
	James Morse <james.morse@arm.com>, Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Dave Jiang <dave.jiang@intel.com>, Breno Leitao <leitao@debian.org>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>, Dan Williams <djbw@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Morduan Zang <zhangdandan@uniontech.com>,
	linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v4 00/12] CPER: Add Memory Error Section 2 support
Message-ID: <20261124042434.GMawURgn0Uap26S6US@fat_crate.local>
References: <20261113132600.3355836-1-pierre.gondois@arm.com>
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261113132600.3355836-1-pierre.gondois@arm.com>

On Fri, Nov 13, 2026 at 02:24:42PM +0100, Pierre Gondois wrote:
> The support is mostly duplicated from Memory Error Section handling.
> Other than differences coming from the content of  Memory Error
> Section 1 and 2, differences in the support are:

What in the h*ll is a Memory Error Section 2 record?

Your RFC doesn't explain it either:

https://lore.kernel.org/all/20260929074659.2587216-1-pierre.gondois@arm.com/#t

so it must be something magical...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
