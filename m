Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795494685;
	b=eFY4hjVA2MJBC1aRId1aqaplQkSbxD5MeXGWCGg8eKZ3QmsrxvsXqnbS6hDcEW97Fn7Z
	 uQsoN/fyStyFhO8OZY26Lvwq32eMIzjcWhZRYMRddVlrshyg4F9RWluIj72VROVGVtHMa
	 HnolHjxIvq5rFVDHwW42JPEshaLPVMKVsAjb/pPuQ5VhrLS/OArhs/EDzu/gRRXk9rPVS
	 X9lEOdVNHwVqIY8dyQguAFTZcVb+fnZVJuFzcha3I7gpc0E5RYMJZvPQRLeslF3iYeq9A
	 KMZP1CmjPqFlHF/0nM9l/E6G2J7Wt+CjIZcBQ/7dA/53Y4tnRlt46jsLcb+VG0fZ3qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795494685;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=gz0rAgdyPmIJgCpQbcFNcSck6Zv0M1f0gbaDLMkm0SE=;
	b=EexyVrGpACC+FxHu6+Ua+OUpdvKKK8+v9HwIxBnEKvvYYst0TQYS3CtCBGVxSBHaPNT+
	 3ciLbgq/EB48fcqi+REvtwQcgs4mbcF/06BxxeEO6/yO6dnPeadmNB64LddYxQZeoK2m4
	 PaVs6HJrj9uOAOlvz/wvymApDeShgw/GcO9Po1HQseOzbJWcEufS82+Cbgtdamedrw9ir
	 biA/Tt2g/xu5YPbpnFUzHax3oBUfHFi3u0fs5scRrBDNqLLismoMPZH/wXHM26o8eyvx2
	 +65Xk3O/N02pEcyW0CPetg3i1umklkB/l42cV3oWIDU6pP07oLK1SkThvaOt8iZKQlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=QmOK6Psy;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B893606A31E
	for <acpica-devel@lists.linux.dev>; Tue, 24 Nov 2026 04:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B893606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=QmOK6Psy
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 474E640E02CC;
	Tue, 24 Nov 2026 04:31:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id l0xCWH4gF7oj; Tue, 24 Nov 2026 04:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1795494679; bh=gz0rAgdyPmIJgCpQbcFNcSck6Zv0M1f0gbaDLMkm0SE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QmOK6PsybAz8j7BThAprCIhTJEqGJK+GiiXPeVo1mq48xa6S7g1un3UtSgaQm05Oe
	 cI8cMPX6Pusw4qP8X/J87+OjTcDdxQH0xnq9ZkSJVhoMKZ7wZK9oYslyPWwskj1mHh
	 F0cKC+8HfBeFBSo0I/mc2ctlKY11Cjq3oGYzIfdL6dJH+eMUz2NEVahnFI6ElnE7uZ
	 5ufUY7wJGO8un/HSMnklXeRvwutss3O7L8RTZS0X6TrVBJNjES+yYHjPdCWTKGSNAD
	 otsfUAIFQBZzXYriTmm6Lw8hGUrWeasLm+uECgSCQHrreBahkO7OXMXnROy8kT7Uqa
	 7/UvCoQ+vRAhzib1mGSogRlMropmXv6k0lPP2EjjUAtO2JZPQMReH+PyylT8Js4/pW
	 XolyneA94X60T+DrthzIcdLVcw8drRvAghvgJiBsT8vdQYtGAl/PIBFDvqEpO3VZeD
	 lArEqJajKs+ibRR6VrJqo/R8ugIaQC5/9c+iPPLbyqlLs/PBreTuBXVbG2P5XM+ulv
	 MX1melSiZHditJfR4VedmwqTizh5qEZup3Bpe2UgRU2+UiVUs6z4oX//XhF6TyfIOS
	 a1g/hT9cVoFpLhunHKC5TtMt2f44pKXqvm5geMd6X//c+i76N3uT8jsLfv7HxhlHHq
	 ar3hY+yV7hYtgaK/SvSjDXdU=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4A44B40E02A9;
	Tue, 24 Nov 2026 04:30:54 +0000 (UTC)
Date: Mon, 23 Nov 2026 20:30:51 -0800
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
Subject: Re: [PATCH v4 11/12] EDAC/ghes: Small buffer fixes for mem
 other_detail helpers
Message-ID: <20261124043051.GNawUS-yBnVpnuUVhH@fat_crate.local>
References: <20261113132600.3355836-1-pierre.gondois@arm.com>
 <20261113132600.3355836-12-pierre.gondois@arm.com>
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
In-Reply-To: <20261113132600.3355836-12-pierre.gondois@arm.com>

On Fri, Nov 13, 2026 at 02:24:53PM +0100, Pierre Gondois wrote:
> scnprintf() already reserves space for the terminating NULL,
> leaving one byte unused and under-flowing the capacity when len=0.
> Callers also remove the last character unconditionally, which
> can discard valid text after truncation.
> 
> Update the following functions to fix the above issues.
> - print_mem_error_other_detail()
> - print_mem_error2_other_detail()
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/edac/ghes_edac.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)


Fixes go *first* in a patchset. Then you don't have to fix a function you just
added in your patchset.

Also, the patch subject should have a verb.

Also, those functions you're touching here look to me like they're duplicating
a bunch of code...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
