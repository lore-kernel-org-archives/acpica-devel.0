Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3671C36
	for <acpica-devel@lists.linux.dev>; Sat, 29 Mar 2025 01:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743210451; cv=none; b=HNuNcvMdcfoojG5VK6DLg0b2SizdoxJNjZFM+y5aIBF5SM1njQlWY5DlD17AyDnT3j/+zB3zypMG9cJDwPk0uSbE8zWLFakmhDcdI+rwF1Bk9MLt2sclt/gxUF3nhSNvew0vRBunL3b8lHgx9118yA9NbTgyK6efbaHqjsWM0CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743210451; c=relaxed/simple;
	bh=9VHMgg8XVI03DXLD39IVNu73KXwzIK1KERt6YTLgiE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLM2AwquWBjzPJhJg3TYFPOsfORwvBxMe4b4KR8cjcEgqFq4xrLKvu9Re5pUmZpKk6QAFiep4KZDkj3lm4t/AQ0qbIPD872PjhPwpYoOgKzf1S/sN2RZHVZ3JO4K55PfaY8sbQ3+OcxdBTrvUHhoX9xESNe6qa2ishDnLEsQNAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=baHwbji8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F4ngpkAK; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="baHwbji8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F4ngpkAK"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3BAF125401CC;
	Fri, 28 Mar 2025 21:07:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 28 Mar 2025 21:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1743210447; x=
	1743296847; bh=wKO8nLwVZ/c6d2peXPF8XkbDrw0UaTn7gMMaej/9ejg=; b=b
	aHwbji8vf+26Z3AhA/3BOLPo/6KL/u1O6ZQ9sgVTT1ZIMQQIdC65DWB2ksyOLFuv
	e+Zyjdo+V9IZhPHd2WI3sRF3S6JefkeezDN4r2ubtSeD4H/uNzTI2h1+WQZnkN64
	MPyyoI1G0uuT5+q1HppvbjOtBCZe07Fs4tn/FYbV4zfSV4pKlqRfkYoChz199cnV
	7Uptv60tU5WxjZK/g8D2CuwZwpOp6Vv5cgPhqrG+ZGYfjHcVuq1R7n9FicOHOt+C
	Wba6lMfAb8MNEcaZP9+avFL4Wqn/L2wBGmHdrFD4Z2N5tQyDNSbT5HmbYLWjphTB
	dFQMFfJkBKyvsznRl9LAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743210447; x=1743296847; bh=wKO8nLwVZ/c6d2peXPF8XkbDrw0UaTn7gMM
	aej/9ejg=; b=F4ngpkAKSoehP3OLsF/lxLU0TZmnIpoyTC+9EeeZ2cTRWwPf8Kl
	cJRlLd5djqHUayoozyF2W8oU8EX1fyP1kGNaQLt99Id93137/AhAHbTJEyn+Nq7U
	x7h/5Lt1J3FFLZ/BuuUdnucZ0JHbZuHPZGNEb0TmrNH1mlbRKmfg/86TLdRizwBi
	9rZUjkt8Tp0ph3DoxQZnGC12hNzZJy2x+5bz7vFBs+g8Vd3DLqRPQYKOkSsE+qh/
	N6EATpXXu9h7+M2P5ZpaYNOxfFz2N2qK8AWfpJkQt3bTWhjqH2eCM0OiN/ETNbnX
	DmljxKUOf4sou+ntsh7MbWa8mg0qwTmdYfA==
X-ME-Sender: <xms:zkfnZ5cv0tN7H6h2b0G8kIC-F1SM83Tdr4kvIT266XcRHosBJSvPBw>
    <xme:zkfnZ3MJaiAkJKzPMdvFuFhVRNuscMZPGgKH89d880-yDO5xjuQbxPmcxWM-leK7H
    wBwmvizMHbxEj7EC7M>
X-ME-Received: <xmr:zkfnZyiwB3mb2sXBjbeH0Yvk1tYzndaq7o_l1ONTx1MUySF-yllp6RwoggJzPGxdc1IvM684cJ3bWLTnCGtWNLVyqrErFph94GQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedvkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhih
    esshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhephefhhfettefgkedv
    ieeuffevveeufedtlefhjeeiieetvdelfedtgfefuedukeeunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgr
    mhhotggthhhirdhjphdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtoheplhhurhhifigvnheskhihlhhinhhoshdrtghnpdhrtghpthhtoheprhgr
    fhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvghnsgeskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhr
    tghpthhtoheplhhinhhugidufeelgedquggvvhgvlheslhhishhtshdrshhouhhrtggvfh
    horhhgvgdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegrtghpihgtrgdquggvvhgvlheslhhishhtshdr
    lhhinhhugidruggvvhdprhgtphhtthhopehkvghrnhgvlhdqsghotheskhihlhhinhhosh
    drtghn
X-ME-Proxy: <xmx:zkfnZy9dTcq5_GooPo6FBhesS3-eTeFA9FJ5mnYztXhSZoT7VaLZwQ>
    <xmx:zkfnZ1urQIo1HtXOxIXOyfszpprewy-pWXPkxDHpNYkpabXocAaBiQ>
    <xmx:zkfnZxFUR1qUFUbRj_KHGKjaWLsMGdSkr4jIRd7_rc0e3cefm0YmFw>
    <xmx:zkfnZ8OiLzZxmWIFGXvxyjOt9IjSqjrlNng4W8_-dzycsaWRKNtDtg>
    <xmx:z0fnZ7InwO7RsxXU6AfioiRJ9a1GHj4X_mbER07cpjox-XHj7BV4djb1>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Mar 2025 21:07:23 -0400 (EDT)
Date: Sat, 29 Mar 2025 10:07:21 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Riwen Lu <luriwen@kylinos.cn>
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH v1] tools: Fix compile error of pfrut/firewire
Message-ID: <20250329010721.GA11319@workstation.local>
Mail-Followup-To: Riwen Lu <luriwen@kylinos.cn>, rafael@kernel.org,
	lenb@kernel.org, robert.moore@intel.com,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	k2ci <kernel-bot@kylinos.cn>
References: <20250328074750.3524280-1-luriwen@kylinos.cn>
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328074750.3524280-1-luriwen@kylinos.cn>

Hi,

On Fri, Mar 28, 2025 at 03:47:50PM +0800, Riwen Lu wrote:
> The value -rR of MAKEFLAGS implicit do not use make's built-in rules and
> variables. Previous commit d1d096312176 ("tools: fix annoying "mkdir -p
> ..." logs when building tools in parallel") removed the MAKEFLAGS=
> command for tools and caused the built-in rules for pfrut/firewire
> failed to take effect.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
> ---
>  tools/firewire/Makefile               | 7 +++++++
>  tools/power/acpi/tools/pfrut/Makefile | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)

As long as testing with v6.14 release, I can not find such failure. I
guess that some one has fixed the issue between the commit and the
release.

Would you please recheck the issue?


Thanks

Takashi Sakamoto
