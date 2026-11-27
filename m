Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804039;
	b=FBWzzHJyqGrQbvq8Ruw4N0pb72hqQybLKQfQIUPO7PlaNewlkTDTNH0HeEzUuethAGob
	 o0IAUxhBcnIkRzLlzu77q8cuuxFCya6+OGsCR4uiNH3lJjr9cTLWpP1g+W8RWqIkqJ5vX
	 hn4DweUrgyomt/qAhhmRmjAcyVavNRh9vzRJC/ySf7OT12OH03DWgVpSf8wsh1n2IcDZD
	 vMWHEC8FrgDwipJymc8LZs9wZ5ooIFwXbnpmub+3cG1jIIeOklxfToZUsEYpoiGulAM1U
	 U+ssZOUk6lgLfceAH1PeBdI9vgDT0fkmgCpQiMgEx0J8zBxxtMjmNax5b87YuHauqTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804039;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=waMrtApbsCCy32qAngNApj9LYKzRQy59KtMCm1H9c9Y=;
	b=SWazzT7ak1wQZRk37lCU2rCrCUOAr09+Y6fx+KNqRdgqFU1g6hLPgBfMeseih0s4Wkdb
	 F2QcJfLiVIPD3lmSgVfp64YmuXty9u0rg4Dn92Y+X8yg0pM9Zq+8b2v4RDZBFaITLs/3o
	 SfYpmX298Eh5CGALRckSrqSiOE11hOVNnBYumEE28OZLa/2CMoNMdG16zc/HQv9C1U75d
	 Qszzvwo7kLmD3wOirGgBe1c1+cXHCdDQ7/JvSgLhz78hbATJzngET7pUaP8Ro7NYygbqy
	 H4sLDzoj58V0UNhK8jahps71XXF1maRrnKcb3U7KQ2EjXbdkGGrgFZ+VB8wEc4L4AFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="XDm/VdRB";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA2E606A31E
	for <acpica-devel@lists.linux.dev>; Fri, 27 Nov 2026 18:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEA2E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=XDm/VdRB
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 312A12F;
	Fri, 27 Nov 2026 10:27:15 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E87973F86C;
	Fri, 27 Nov 2026 10:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795804038; bh=ocCdgqyFc3OGeaETJDga9WQCqMZ98ADJdKFQOYIh3uU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XDm/VdRBNwU6kB4H2HczAmipRcbLx6A9+0SKJUFqbSZBQnv0bejhh+uSefIa/oKyF
	 3hBKMcZMZYt/JiCNEOm9Udgxn3RjRsWUC+axRyFOp2NexWkoX2m/xKVyAIiq4uFJU9
	 wCUTGQwWvQrK5p2hKP76/46lVvm+gbWXkaSp4lIo=
Date: Fri, 27 Nov 2026 18:27:12 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Sami Mujawar <sami.mujawar@arm.com>, thuth@redhat.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, Len Brown <lenb@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC v3 7/8] attestation: providers: introduce CCA Guest
 attestation provider
Message-ID: <awnLgFZIhRZENiE4@e129823.arm.com>
References: <20261127-arm_cca_mr-v3-0-df3230afce8f@arm.com>
 <20261127-arm_cca_mr-v3-7-df3230afce8f@arm.com>
 <20261127170722.GT246011@ziepe.ca>
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261127170722.GT246011@ziepe.ca>

[...]
> 
> > +static enum hash_algo cca_guest_attestation_algorithms[] = {
> > +	HASH_ALGO_SHA512,
> > +};
> 
> static const

No. it's a scaling issue since the attestion algorithms could be not
only SHA512 but also SHA256 and SHA384....

[...]

-- 
Sincerely,
Yeoreum Yun
