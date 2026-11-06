Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997480;
	b=HjIOVG1sPgedT3/o8QiFH3lO8HzG3VIcmTPRhcz8gTadpKk7crrwv2fYUHZ15yU2voCa
	 xvxlbtcKk7KJ24rtFTGFOlMAE4jveR64BcNiymK9+HS66/eJHK1ucUYC7xucMUGoiGfA2
	 eQKVxFlf6GsnF1J5dRwrIFQib6eVglFm+1C9iRuwRxjzLpnOkj074VAFdBrVGHER2CG4E
	 fNQ0NFwoQRkxshaier/QYMLuXroOZVPF+jAlmehwDXbiZ7ejSs+H6uSkGYxq0eYiuMB7e
	 tIKwE0FRIaADNmxkPD7plPonIrIJRWqn4X+e2QOy3W2275xZd9uReBkLrMn0GyRwG5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997480;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=CWFtzEGOjYXWWrRXdjVOFSZ25rh8/v8jlZjeE8XoHSI=;
	b=RKQ/lIxS3ifpzgIe3bO8jlJGyFGHjjVo65wr/8YIig4tqOrRPHixcdIJ2jTvUa6d1KMY
	 FLSvwI6EE2mGvOyi2HfOZOTTHEo4rREU5qpV04wLIz6P4Fqh/9ySCDxLQx41Fveo596h4
	 g8thef9udzFn5WHDHTlqxWnBzPcDhr5VqNn9ezKy3a6xfNsRSJduCWCbAp63ZRRX1RXP6
	 ABg2CUy2I6JwGWp8kl+RVAo4sttmYPiikm1vncBZzF33xHsX44gs9Hu6dYyaC99OJImNK
	 61KRRA29SdBq4H02s4P1DEFbj2rdDfGKjhpOeLlzoV75y9cRKjBv0m97+t3snR+eLJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CWIvhJ2H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94241606A329
	for <acpica-devel@lists.linux.dev>; Fri,  6 Nov 2026 20:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CWIvhJ2H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A571F008A4
	for <acpica-devel@lists.linux.dev>; Fri,  6 Nov 2026 20:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793997480;
	bh=CWFtzEGOjYXWWrRXdjVOFSZ25rh8/v8jlZjeE8XoHSI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CWIvhJ2HHH8jG9uSfhCSDdMluji48syxsypheLFVGyyvHBde2UEqpQ7PBfhRVkViR
	 tMaGtPq4x8VjhvDEoAKJvxMAQBD7Bb9wj3Y1CiUgtZPWixG5xbxne+eYvyMrafEso2
	 g1oZkPfPhld8HDgxl9vybcKhTDGBcegQH6sj4brzD+XyVS6gy5PEj4TD5EPTzqBXGv
	 62DS2k9UdIpdnGjfiQcc4DrXZ7OA36W8GXQvk0GrM8RjRA+GLXdAKMZS+MrWIMAfjw
	 cpAyf88PllwA/p4krB+dhgBx+zfll9+QK80qTYpysVv4RTEp7gP8XiG6CoZBOOdSzU
	 8Ceq3dJukGw7Q==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5be3ed646a5so1304967e87.1
        for <acpica-devel@lists.linux.dev>; Fri, 06 Nov 2026 12:38:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHhUAD3N6twr3AFsyBHe9XTjF7ZzL0nSLE8gwebCR1V/CaFKFqitu4FzwVJj4q/Q9NMZ8Rg8MGqvr4/sDY=@lists.linux.dev
X-Gm-Message-State: APuU4Z8ZdZoldjjEuI1pXEJSCNIo1HFS1gw7bif/WTsuxxCSx+wyVqBy
	iOk1eqrjwrhDBybQdJYXJAsG12/wGORJqA206o+JSZfjVnocnTz3Fm9g0eZJp3kp4KGJYrHU1gu
	5u0KmKxV8Vljnm19Ix3gbHHfqAF2TpOc=
X-Received: by 2002:ac2:5692:0:b0:5b6:1a7c:27 with SMTP id 2adb3069b0e04-5c003c0903dmr1289753e87.42.1793997478844;
 Fri, 06 Nov 2026 12:37:58 -0800 (PST)
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261005153723.2644331-1-fuad.tabba@linux.dev>
In-Reply-To: <20261005153723.2644331-1-fuad.tabba@linux.dev>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 6 Nov 2026 21:37:45 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i4wc1oeRZ+eswsLErgchfQa0Mmi8K7nBM7Mb9T7NToHQ@mail.gmail.com>
X-Gm-Features: AclHuK89uJyG-LZ30b3MHdFmqSZ2vlWQfjg36o0s-bFfSBL5BozxQuU83pcSs24
Message-ID: <CAJZ5v0i4wc1oeRZ+eswsLErgchfQa0Mmi8K7nBM7Mb9T7NToHQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] ACPI: tools: Fix stale headers in incremental builds
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, 
	Pawel Chmielewski <pawel.chmielewski@intel.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 5:37=E2=80=AFPM Fuad Tabba <fuad.tabba@linux.dev> wr=
ote:
>
> Hi folks,
>
> Two fixes for incremental builds of the ACPI tools, which compile
> against old headers after a header changes. The first replaces the
> copy of include/acpi with a link, so the tools see the current headers.
> The second adds dependency files, so objects that include a changed
> header are rebuilt.
>
> I found these while fixing the same kind of bug in the KVM selftests'
> sysreg header [1].
>
> Based on Linux 7.3-rc5 (72d3fcf802c45).
>
> Cheers,
> /fuad
>
> [1] https://lore.kernel.org/all/20260922071945.693714-1-fuad.tabba@linux.=
dev/
>
> Fuad Tabba (2):
>   ACPI: tools: Link include/acpi instead of copying it
>   ACPI: tools: Rebuild objects when a header they include changes
>
>  tools/power/acpi/Makefile.rules | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> --

Both patches applied as 7.5 material, thanks!
