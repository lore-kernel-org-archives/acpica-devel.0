Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.143.172.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708015;
	b=LTdVcB/C5QZOEq5JVvHr6rMvobRq/dNSAIkBueU8TvZZ53hf95ZE2jor5hjL8y3dgFa6
	 i4+PpWeYimZzZk6uhFM7x4opc0btHFq0JXJhmXbaBjwdnMDpnXMP7ZptEcx4Hx9m9/DJY
	 Cx1Rzd1313xITukIo5xDiDcJMokczr9Rv8JpxlcK87myc45CeVfZB/oaiKP4Sb4rGTQFx
	 sJ/8P1HrGJjFfsKyYv/qpRCoJ+aED8CMOs48DmTukngV7xlTBcb/E+Khmw3KbeEZN9kCX
	 +qqjm6xqw8t76XI7dKqvV9oFt+vblZ5D+TVXfU1JpLPtEWClTlca+yHFK1VuNZ+2ByQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708015;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Rspamd-Bar:X-Rspamd-Report:
	 X-Rspamd-Score:DKIM-Signature;
	bh=/I0hAkMQgEgSd/xEHJ8QwOI6UalZqq8sg18/Exn5d68=;
	b=1SOGPQ0ylPUENDF3ulyzGx3XT+4gMJ9BgTQuhmkMVnsFiERMQGgXk8pE6j+iHq7vC3ON
	 f3fFoUoYqXBhXCw6Sd15vkGckU3sJPr8NGf/kUdXNSdebcIP1HcdEWilAhICmGRUvI++e
	 53MPD6MRSxXtEPyWRnuv5kf1P2ltZDsjwAujGgYjlOVgt1h24O3h+DvzkNhLN4CVds81Y
	 bZxAX3kooNI3Pkl1c5cy05p08pYRpDh9mVXj2s9csrv9/B1TiLm/hdbo561B3udzhPVPw
	 vW/16tB4EB3Xc5LV8XMH4IZyH0yhHwVjsy5wtzXCK9fHeXrOZ5I7JY0Ev1zXRYYJ3Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lausen.nl;
	spf=pass smtp.mailfrom=lausen.nl;
	dkim=pass header.d=lausen.nl header.i=@lausen.nl header.a=rsa-sha256 header.s=uberspace header.b=oZ+ZZuKG;
	arc=none smtp.remote-ip=95.143.172.20
Received: from mailgate01.uberspace.is (mailgate01.uberspace.is [95.143.172.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55130606A326
	for <acpica-devel@lists.linux.dev>; Tue,  3 Nov 2026 12:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55130606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lausen.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lausen.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=lausen.nl header.i=@lausen.nl header.a=rsa-sha256 header.s=uberspace header.b=oZ+ZZuKG
Received: from devico.uberspace.de (devico.uberspace.de [185.26.156.185])
	by mailgate01.uberspace.is (Postfix) with ESMTPS id 2D9D361766
	for <acpica-devel@lists.linux.dev>; Tue, 03 Nov 2026 13:13:31 +0100 (CET)
Received: (qmail 32635 invoked by uid 990); 3 Nov 2026 12:13:31 -0000
Authentication-Results: devico.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unknown) (::1)
	by devico.uberspace.de (Haraka/3.1.1) with ESMTPSA; Tue, 03 Nov 2026 13:13:30 +0100
Message-ID: <88ccf8fa-be8d-46cb-b0ba-87e94b50a49c@lausen.nl>
Date: Tue, 3 Nov 2026 13:13:28 +0100
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] ACPI: fan: Ignore broken _FST on Samsung Galaxy Book
 930XDB
To: Armin Wolf <W_Armin@gmx.de>, linux-acpi@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 acpica-devel@lists.linux.dev, Len Brown <lenb@kernel.org>,
 Ivan Hu <ivan.hu@canonical.com>, Joshua Grisham <josh@joshuagrisham.com>,
 linux-kernel@vger.kernel.org
References: <20261019145421.47181-1-leonard@lausen.nl>
 <20261019145421.47181-3-leonard@lausen.nl>
 <35c80ebb-fb5c-45cd-b6e9-d6b73e305432@gmx.de>
Content-Language: en-US
From: Leonard Lausen <leonard@lausen.nl>
In-Reply-To: <35c80ebb-fb5c-45cd-b6e9-d6b73e305432@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Bar: ---
X-Rspamd-Report: BAYES_HAM(-2.996116) XM_UA_NO_VERSION(0.01) MIME_GOOD(-0.1)
X-Rspamd-Score: -3.086116
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lausen.nl; s=uberspace;
	h=from:to:cc:subject:date;
	bh=7+y8nX4RnZWTX2otTR1L4cVl1f0lsJaVlnzPUfbmz4w=;
	b=oZ+ZZuKGwFnulPzF/2nmJD3pMaG6lgDDPFFf9RaDfpEyr4fKjw6SScrsa+6S6Wkuiq7TzTIKRR
	3eZ6hqpH+yfcaIxxn+h9opICMxEteqhPxvDiQtn7cV9Tt6bGdxjaiFhOYGhVduJvKFbxspuc+ubo
	uFsGjC9BZ2RK6kvCSC2FkobIwUVK++Uwbw5xPuOdHA9ldl+MGf0Cjsl+xUAWAvCyP8DAOSTF0z6V
	kHiQXdpxWOpwQ+eZnjGbWMj0r/UEgsa7vTRdDqewF6gp1YjWYHBN1sN1IoQqYits/5An5mT50p+4
	oukF/jAtoodP1dtU0m4mmjbD0jEmx7tyAJpjrR9/HBoZARHx9gZN/wGpgglndo6L0rjXygJ41CHL
	BiBbNndR34k5HS17PwcsUOzXX4zeIjzRQ2mhmWWqPZCIhtwwodnssjF0qycgnfS9I1rNyb4KPWZo
	1InMyOYPedZC8xBOgqFGvAmvQ2DeBXr0H3Fu49BL3ZCCoZFKqyowXFGZs4Cbl4ZW+sDprjmae7TG
	6sHAggdlxmjW0mjJH8LmgT+YByrE0m+3N4Po4Dsd7sEreBjBhro0Y/+hzHhm/e2OJ8xp0peZwLpL
	SFaguyXtqkhCtfRtvWQQmm98wUBqB20HjBvRsHVGyebjwIOoXVDLYOdHL2GVagNDX0WijRE0Rxm8
	8=

> This is very likely connected to https://github.com/open-acpica/acpica/ 
> issues/908. The ACPI spec says that Increment/Decrement is "Equivalent 
> to Add (Addend, 1, Addend)", so i suspect that Add() should try to 
> automatically dereference the reference.
> 
> I would suggest that you report this issue to the ACPICA guys instead.

Thank you for the pointer, Armin. Maciej and me fixed the issue in 
ACPICA and it is now in upstream pending branch. 
https://github.com/open-acpica/acpica/commit/8854b938571e4f780c2673b3f7df440694ac4229 
I'm not sure when it will make it's way to the kernel.

Best regards
Leonard
