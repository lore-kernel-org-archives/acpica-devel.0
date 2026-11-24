Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795496492;
	b=dPZrDFYZKjZyN+TOp1rKxUfWZI3rYBV2kMhhWs4gE88ZsZ0HMQNWCcwR69ZkhEyYdusJ
	 Fyzpro0NpzqUhJd7/gQUFJXcEw1UN35A3hwg2s3iJk4thhw9wEVEKhPgu8g7/M1NJ/fjL
	 3OEShbN7oVPyAKmeXquFdPHGQCvdt3cmjCQ8cWr/K6i1x87eUZwavziRstlf6sVw9vhw0
	 s32H7S86YpI101WG556n/LMBTU2lEUjQpSr5xIA1t4zbhAiVwA5Mz3TVbg2KYUZ16kIi0
	 7pfRc0SU39UlLKgNh+61xpbn4dPULUso92eKc8b6yyWQVCglEZCZ7lYIUJLEV/W0b/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795496492;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=XM+P0UUh8M7+zT3EmoQUfy6DuwH+/xR6iA2fTPRkpYo=;
	b=Nj7TLz9gPHXuHGvuhpoboshtmpifO95Z1YovkDz4HbZOER3zWKyb8QUqXc4TjYdp00qz
	 gD1TLVLN1bLRKLl8OkBqhTIaMceuapD/jo0cR5KQ1Q7Vn62Df+sYl9O2vcK3EbLbX5KTS
	 wWKmmJaflgqkPhqVaM+8yfUqqEpnx9sY+F/Fm0hdn7sewisLDvfH+52STNuEKeHuveb9o
	 1wwRsucDpXD8FypIzOLIw0rwJ1eE0CNYBRUQ/jEPPG/PlkiFfD/0Ec1d44f7j4D4MWKGN
	 O1WsCRIgJszw/7JWoyKWUqGQGiC49gupaULd3Ztibv0QNtVmkX5c3TyLGQn8ORFtLow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=XoN6dl4w;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A9A606A326
	for <acpica-devel@lists.linux.dev>; Tue, 24 Nov 2026 05:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40A9A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=XoN6dl4w
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A5CE440E02A9;
	Tue, 24 Nov 2026 05:01:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6vKUTZogjik0; Tue, 24 Nov 2026 05:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1795496485; bh=XM+P0UUh8M7+zT3EmoQUfy6DuwH+/xR6iA2fTPRkpYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XoN6dl4w0hO8vS82WF2sVspVH2Ft2yCybHFMhRmD+El3S2igLXKpsYPHgCoUVcvmb
	 Oz8oGr8HDNWwBeOzl8rrUhUvaApVM9oPECC7d/9Ju/qibMK8Vo9T2dhtQWb95atjRZ
	 MPFM0BOsEaCCUjHB/s3oXpSVfkL0TSDZNVttkSIEVv2GKzR8SzLlMQ+RW/hewfU6W5
	 4Lxi7W6xN7fGfE33HLqD7S4d8vlc086is0sSBgTYcxlqpt4HVRdDWog3K8Mzi/W1Xf
	 UlKcVU9nRdy1tP9J3ON3tF/jnhKp2rFe62GH+8QqxhjC/dt63NbTVdeMLdHCUzfE6+
	 4AW7xbzjs7BZ1/+frP7bdFDkV52jvKF89A1KzaaLrpf0KbI9gVgkmGgQFkJjYVMo44
	 DvW/KaEZpAIIQXozkEuWEeDMy4WXvEsMy75lE8aVlUbMF5MxC29dzQ5NVno2nDYq4+
	 /foqT78Nar8WxvBxBRCsqHunGBN57QcfZswYl5yajf99gaCsX76l9xMNxDemElB4Cj
	 tcBle8899/aszxRJRuMvOp/ZfdSf3iNFzLRp+u047z7oLqR3blWLgzairNs1uj+r7Y
	 fjrtn9W6rytSEvHwabaQDXRpMAVcvSbpuc7IdEoHaYy3hSX82+tUZS2V6/Pbnayk03
	 Gd+BMPN4fLEPETqdC9IO9FsE=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2EB5340E0240;
	Tue, 24 Nov 2026 05:00:48 +0000 (UTC)
Date: Mon, 23 Nov 2026 21:00:45 -0800
From: Borislav Petkov <bp@alien8.de>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@oss.qualcomm.com>,
	James Morse <james.morse@arm.com>, Mark Brown <broonie@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Avadhut Naik <avadhut.naik@amd.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>, Dan Williams <djbw@kernel.org>,
	linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 09/19] ACPI: extlog: Report errors independently of
 RAS consumers
Message-ID: <20261124050045.GOawUZ_S5imwUOyh8B@fat_crate.local>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
 <20261117111444.4185512-10-pierre.gondois@arm.com>
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
In-Reply-To: <20261117111444.4185512-10-pierre.gondois@arm.com>

On Tue, Nov 17, 2026 at 12:10:19PM +0100, Pierre Gondois wrote:
> The RAS consumer check removes:
> - trace events when no daemon is registered
> - CPER console report when one is registered
> This ties tracing, PCIe recovery and CXL protocol delivery to daemon
> registration, and can hide a fatal record when userspace cannot process
> its trace event before a reset.
> 
> Remove the RAS consumer registration condition and:
> - always emit trace events
> - print the CPER record only for CPER_SEV_FATAL
> 
> [1] additionally suggested to have a cmdline parameter to dynamically
> update the above policy. Keep a simple hard coded policy for now.
> 
> [1]
> https://lore.kernel.org/lkml/20240521183913.GGZkzqUSN1hdE-_OEY@fat_crate.local/
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  drivers/acpi/acpi_extlog.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index e09ea571c32f5..16a16b12d8ccf 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -208,10 +208,9 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
>  	if (cper_estatus_len(tmp) > ELOG_ENTRY_LEN || cper_estatus_check(tmp))
>  		return NOTIFY_DONE;
>  
> -	if (!ras_userspace_consumers()) {
> +	/* Print fatal records regardless of RAS consumer registration. */
> +	if (tmp->error_severity == CPER_SEV_FATAL)
>  		print_extlog_rcd(NULL, tmp, cpu);
> -		goto out;
> -	}

So after rereading that link, we had this conversation back then about
reorganizing and reworking RAS error reporting and Dan (may he rest in peace)
wanted to unify and dump all the old cruft - especially since
ras_userspace_consumers() is not really used anymore. Apparently.

But what else uses it?

This is something other luserspace probably relies on and we should probably
do our due diligence and slowly deprecate it with a warning splat but not just
whack it unceremoniously.

And what I'm missing in all that effort is the big picture. What are you even
trying to achieve here, what's the point of all that gymnastics?

Unify GHES and acpi_extlog? That's it?

I'm sure there's much more to it than just a plain unification. 

Probably CXL-something is going to use this too eventually?

But I should not be guessing - I should be reading about the big picture
somewhere. No?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
