Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311926;
	b=NG0M5ZaaoZUDqd5AnCjXnky3gtIsmIteWGuPzAy5n5GCVkV8viJNSOREwyclDunQJUu6
	 QEFg+GOIgUgbFTkXVoxc7opomgaENTNE6rRxXa9j+roggwG92Gwj+iP2dCJJRwoRnVcHd
	 MTAngtoN3yazfzo429YCnyvmHo3T1Zv8J2w3jsXveXcFUfexfru8w+zf1iSj9YJmjNogy
	 7c3hfoHufJ4U8OIw7RyvlsDB2K5jODqjHNQw7NYQxV2ND6NIGfCOdds6m0LfAKqfS3njR
	 0fwYj4O+ZrfoiNbIdYhccUWMaVexR5MC0oPnXwX/My48McBProkAfXZW1mgTTx6NyXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311926;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8xrzXhTL0WVs+COqTlijJQelSK0Qwyr/ovJyC3RLEII=;
	b=scZt7qD8UHiuDinBjgXpNH8JAnrKBZ71NXY7sW6X+1k+j5BBdDo++dCc1CPmGLGwEnQ4
	 oC6k64TLrZsCZa49SojSJyvQerIcZKbmMLxGHiefQje6KxbLh/VCqWkIGWZSQFkn/OeMv
	 SbCXXw2CIH02Jonueva0mfhgGTwTX8YMIfk21d3NcFyHlnFFd+XUxgePpkDi2eywgBe/+
	 sMABgh6aEQ6gl2uz28+MC6I6BAyAsP6s4roY/L8S8pHDEwRC043zjEToQm7bsUeGMwYXM
	 ee3y3S4HGLgcPAxchdLNB6i9+z/BYSNdE1RtVdWu+cqT8s2F/aZuwM1rAMXGvPMds3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=emMxNhtQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6BB606A32A
	for <acpica-devel@lists.linux.dev>; Tue, 10 Nov 2026 11:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=emMxNhtQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777B41F008A1
	for <acpica-devel@lists.linux.dev>; Tue, 10 Nov 2026 11:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311926;
	bh=8xrzXhTL0WVs+COqTlijJQelSK0Qwyr/ovJyC3RLEII=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=emMxNhtQXT6GeTvh+kRkYwEWLH00HiNJERy3KvUu1oP+Jo823ihfoYWMD4dWQ8b3E
	 D0PKYmvBaybuB0d57/MYtPdxyy4SiFEw5FXFGmhFYvVkK2RJtp3I1S9+mBSR/k3Dv3
	 f01ILM37j7MCQsznWJh+JlhOj+ohzsv472o4Gfozjnx2hkqfju4OIeFeP395+l3Qld
	 8p9rfS/OiakXatmNF4PYWIUBV24HVxbyvA5uW6jLZ1Z/FJv3ssc5ctzqjC9UByWLPY
	 21FQLvDjtxcBFETPHRDCV5rEnM/2XbOHpdgeqRG/ARr54N7RGDN8AILQE1zJbuSwWB
	 3Odo42VY0GyqQ==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c505186727fso73959766b.3
        for <acpica-devel@lists.linux.dev>; Tue, 10 Nov 2026 03:58:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGjiTofsJDg05UK3ztYhG1efDpN+NzsEy3QLebaOAj//zAELMXGgMFKp9BdUqrbyvgp9fHF9jVsJj3dB8k=@lists.linux.dev
X-Gm-Message-State: APuU4Z+3iZ8yBpTNsKYGrGF1NF/actDQhcn0DKo3x67RB/+E8c1gtP6X
	Rmbtlk6FSj/Y68+j9GpSPZXQsGjyeb+O0tDa5ehCac1808int3x8rhZCLsniKu4o5c9E4OOHdt/
	HOUN6EXuSzI5RIBl/0hIksU3lyU1Q5us=
X-Received: by 2002:a17:906:3f97:b0:c46:8909:963b with SMTP id
 a640c23a62f3a-c5049548348mr132813666b.9.1794311925102; Tue, 10 Nov 2026
 03:58:45 -0800 (PST)
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261110084613.2746641-1-maobibo@loongson.cn>
In-Reply-To: <20261110084613.2746641-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 10 Nov 2026 19:58:33 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6DetSReoZviN_JuJzuzs9ZvUxXg9UXqKg-nfCu-+eRWQ@mail.gmail.com>
X-Gm-Features: AclHuK84cDWlYHFN5XyFvyk3vWEarUjoMDQprQZIFAhcunkS7NK99kky2uOcYIo
Message-ID: <CAAhV-H6DetSReoZviN_JuJzuzs9ZvUxXg9UXqKg-nfCu-+eRWQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] ACPI: LoongArch: Fix IOVT table parsing and add
 checksum validation
To: Bibo Mao <maobibo@loongson.cn>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, 
	Pawel Chmielewski <pawel.chmielewski@intel.com>, Len Brown <lenb@kernel.org>, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	lixianglai@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Tue, Nov 10, 2026 at 4:46=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> In acpi_iovt_init(), hdr is already a pointer, so passing &hdr is
> incorrect. Pass hdr directly instead.
>
> Also add checksum calculation/validation for the IOVT table.
>
> Bibo Mao (2):
>   ACPI: LoongArch: Fix incorrect pointer argument in acpi_iovt_init()
>   ACPI: LoongArch: Add checksum support with IOVT table
>
>  drivers/acpi/loongarch/iovt.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
>
> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
> --
> 2.39.3
>
>
