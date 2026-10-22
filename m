Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792692796;
	b=liLieJao9z05+nAVQZwTiGZAPkIBQU2SH22+uFdLyeAovso0Vjm/xRsKKmG+ukwHzeka
	 OHxT9nmhxS/QFOUlDNNnBc8CmUiTPgVnr3ZtYP1whSpkzn05xyy/UB5vd0zKyBh+YULFP
	 kxhWn0qnEYpnCyMPUgu3dEVrJ/pi91c9hanal6ORcCyQgsBVQMb4re2BR45oMAo8hy1tT
	 ZOCv3fCFc19R/OQWwimMyqmiZnNCPneCUmWuSrdtWghZ4Cjx4PD3lUgG6Ge6W5BnbOWlD
	 dYlfoHN9U8EJI/iFhDwx89p5X/7v0XU9YkIxuY2ttdzsHOxTi39LKpEq/zlxZL/pzkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792692796;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=WoKfb/2yGGVSnXt6CYH/Pbj+IvavfA6u3d8Xn/n1Rd0=;
	b=stdM4kpAzcsSO1KjTfvLKQ39A02MDYXeVQd6+Q4RZETa5nCD9QG/z7sGboqn9HFkNBN5
	 soFCUKwvqavAWxRsNe+C7iZ0m8llxG/WVuvj1uQ2I7UvZQdQsuns7tkkXi3to5T23ZznO
	 SYI/flL5XSgGVb0KVRavBelSvI2rBnAoyg4wGxLSegDphlWaX04+2FR10lPLQgLM2NTp9
	 VOEb7O+7sY2dNfdBiutSkHJxSlFsomeESraKvi0ma8bf0827PBktm1QC4OZ+mZFtCbilb
	 ZYr4weUENxCSM6Hs8A+oDk1JpgFcAhuns1VK5FiOzlcpFc3TIYDt9lwQN1fAoceocnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HGT0N5Ne;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD401606A319
	for <acpica-devel@lists.linux.dev>; Thu, 22 Oct 2026 18:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HGT0N5Ne
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B3B1F031E1
	for <acpica-devel@lists.linux.dev>; Thu, 22 Oct 2026 18:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792692795;
	bh=WoKfb/2yGGVSnXt6CYH/Pbj+IvavfA6u3d8Xn/n1Rd0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HGT0N5NekN0KEUSsObqhZrI0IV6Jy0/nsLWp5XhIGufZMljEMcfM81bQMi+uQ9gwf
	 CrYb4CFqawsRdcoxpa3pfccQ2SVip8zroqYY0HM//eETThHjGtBSjB0V19vcWgfaLH
	 guThOcgte4ydi4eTG52G7kKUEtPHZh4RKQ00zlmsx+GZdpg7WTnRF9mlomNGZ/Sn7N
	 AgkyZk+A2UWvdexa8X7raknOxt2rd5Dfrj8Fqao+EKo3dvFO6ch+d+CzFKOtG9U3bs
	 v5hcBHRSG1hjA8IPySHccloEpBljpj/+Zm3Vl0pD+lMOvppU3lFDHJUGqugn4KY9ad
	 U8tueRB35WcvQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5bc18f54abbso1763951e87.1
        for <acpica-devel@lists.linux.dev>; Thu, 22 Oct 2026 11:13:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwlUjfnrpelHECgcnoF8eCukLKJV2TqgNInb6/W3NInZ+3vzusJYBdux0EAaoTOjFLwQ+V/ACvxRWFjjgo=@lists.linux.dev
X-Gm-Message-State: AFq9FYKQnMruAQvjvDUOT70bwHntECbW3x5mDR6PGI94j10pVhii7xqe
	dhinmYxIzdYkzUg/j/jNd6ogguB9BajNHQlcqZdc3CPKcYpRyyI8aHdMNTMs22npEHXCR48kxAI
	No40X7xkiv8m0ZLOWij/OIjw0sUP6Hi0=
X-Received: by 2002:a05:6512:238f:b0:5bc:b23c:f7dc with SMTP id
 2adb3069b0e04-5bfa1c6ad0fmr2527167e87.9.1792692793746; Thu, 22 Oct 2026
 11:13:13 -0700 (PDT)
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Post: <mailto:acpica-devel@lists.linux.dev>
List-Help: <mailto:acpica-devel+help@lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:acpica-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261019145421.47181-1-leonard@lausen.nl> <20261019145421.47181-2-leonard@lausen.nl>
In-Reply-To: <20261019145421.47181-2-leonard@lausen.nl>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 22 Oct 2026 20:10:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ihGqbpJQiic7DkPw19LG-XXL4BmDht-0Mdx8PFNMh+Kg@mail.gmail.com>
X-Gm-Features: AclHuK8OnYNaemA-MReRJfiarOYd7azLSGRGGQtr9eN1fRbWuuXKTTqItN58h4A
Message-ID: <CAJZ5v0ihGqbpJQiic7DkPw19LG-XXL4BmDht-0Mdx8PFNMh+Kg@mail.gmail.com>
Subject: Re: [PATCH 1/3] ACPICA: Initialize ParserState.AmlEnd in AcpiInstallMethod
To: Leonard Lausen <leonard@lausen.nl>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, 
	Pawel Chmielewski <pawel.chmielewski@intel.com>, acpica-devel@lists.linux.dev, 
	Len Brown <lenb@kernel.org>, Armin Wolf <W_Armin@gmx.de>, Ivan Hu <ivan.hu@canonical.com>, 
	Joshua Grisham <josh@joshuagrisham.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 4:54=E2=80=AFPM Leonard Lausen <leonard@lausen.nl> =
wrote:
>
> From: Ivan Hu <ivan.hu@canonical.com>
>
> In AcpiInstallMethod(), the local ParserState is stack-allocated and
> only ParserState.Aml was initialized. Parser helpers called by this path
> read ParserState.AmlEnd for bounds checking: AcpiPsPeekOpcode() reads it
> before validating the first AML opcode, and AcpiPsGetNextPackageEnd()
> reads it indirectly via AcpiPsGetNextPackageLength(). The subsequent
> package-limit check also compares against ParserState.AmlEnd. Because
> AmlEnd was never set, these checks operated on an uninitialized value,
> which Coverity flagged as an uninitialized read (CID 1684785) and which
> could lead to incorrect parser bounds decisions.
>
> Coverity report:
>
> *** CID 1684785:         Memory - illegal accesses  (UNINIT)
> /src/acpica/source/components/namespace/nsxfname.c: 712             in Ac=
piInstallMethod()
>         ParserState.Aml +=3D AcpiPsGetOpcodeSize (Opcode);
> >>>     CID 1684785:         Memory - illegal accesses  (UNINIT)
> >>>     Using uninitialized value "ParserState.AmlEnd" when calling
>         "AcpiPsGetNextPackageEnd".
>         ParserState.PkgEnd =3D AcpiPsGetNextPackageEnd (&ParserState);
>
> Initialize ParserState.AmlEnd to the end of the table
> (Buffer + Table->Length) so the parser bounds checks operate on a valid
> limit.
>
> Link: https://github.com/open-acpica/acpica/commit/19429ef91ebfb2144c9180=
38dce13e297b4ef051
> Fixes: bdc357540129 ("ACPICA: add boundary checks in two places")
> Signed-off-by: Ivan Hu <ivan.hu@canonical.com>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> Signed-off-by: Leonard Lausen <leonard@lausen.nl>
> ---
>  drivers/acpi/acpica/nsxfname.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfnam=
e.c
> index b6534187cd43..fcd94947fedb 100644
> --- a/drivers/acpi/acpica/nsxfname.c
> +++ b/drivers/acpi/acpica/nsxfname.c
> @@ -503,6 +503,7 @@ acpi_status acpi_install_method(u8 *buffer)
>         /* First AML opcode in the table must be a control method */
>
>         parser_state.aml =3D buffer + sizeof(struct acpi_table_header);
> +       parser_state.aml_end =3D buffer + table->length;
>         opcode =3D acpi_ps_peek_opcode(&parser_state);
>         if (opcode !=3D AML_METHOD_OP) {
>                 return (AE_BAD_PARAMETER);
> --

Applied as 7.4-rc material, thanks!
