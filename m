Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EAE28BAA5
	for <acpica-devel@lists.linux.dev>; Wed,  7 May 2025 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746631568; cv=none; b=K8DNfOi6IZBWTz83vnSl3YFnwDIE22cv9eHjs09q7a5XnsJ0lWOpzuiy0ErLxFs2AppO7Ixl7RlHaj2J8HyLDQTX7mvLJXgmb3bwiJACXMimxXE5pD27M1rX2iYqNX1C6ROmSRS6cOPsygQMxBqF/ZU3VSCtCIoriUCfRw1eDv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746631568; c=relaxed/simple;
	bh=vRyKhU47b8HpR6WFd47LLGp3vmxif8gR0qLWyi7s+gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e1i9M67QXDhMm4lXLytmT0TMahAaNa8/K+/XPHE8SKzwHbnnv5ajP+yowqcpNhLPvU0eAY+ZPhmfGCncL4F1fU/WCijNdV1NhxxCgHJjsXhCHHuhR+yE0SYtt6JQ/LH76QjFLW9UcYZ8EIf7QnM35RV/wEWyUf+Bp0IVOaVTuwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFeVQA/Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFeVQA/Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF55C4CEF0
	for <acpica-devel@lists.linux.dev>; Wed,  7 May 2025 15:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746631568;
	bh=vRyKhU47b8HpR6WFd47LLGp3vmxif8gR0qLWyi7s+gg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gFeVQA/Ztxbk7b4KnED8SmQY1p+gRttRva812COjsGNzDEPWWtj72PdfJw/RvQQoW
	 idcy1z6PwrqNl7OBDgbGg3+0162rSUA6JP/uUtD4hDAvtJMW/Vl4qcpnaCsXO9hjAp
	 o2vBuBtbW2thX/qmJGRplXOlOLJy65WEjGPnpy7oI2LlR/zoULYnRlYEiyysbOqSJp
	 +k2AwwtQjYHsp9m+E3D8jsuTjrPXJ8I4J2q/bY5uQrnyJW0e+OPgcuv1S3gxqccs7V
	 FNrQg0qfcOhDM95/LvTC/zvz5YAhK2ilWC8ZgK2BKW/lQOJg7CnOWnHYj5P9fmrvtL
	 kWErnPb4y0ySg==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2d4e91512b4so31663fac.1
        for <acpica-devel@lists.linux.dev>; Wed, 07 May 2025 08:26:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQJfV1z2lcV5aJ6xTnIphKr8G0S7Ps8wDaY54x/6px0YG4BNmBKY9QZjQ2C2v1BDxWlto7XTl+Rw1JiT8=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6r/r98DoG4wd2BnAPQTX3Js9BKazZGP4p8ODCK/wMfjdH97iW
	UjfJ4q9r7tRd0WeZDz27V8j+QIwzoTY1gjkxp/SwUW3RglaZWhEn/auN4u49RSVUURjWC1zCx1s
	D7QAFOCzo66aKnsAtCTOGWzLQQHA=
X-Google-Smtp-Source: AGHT+IEcgoxgjHJX1Wb+IhDm2x3k+dD1aIlf95MRUUDyAb0rSSkxXzv0na/rJhZcOkd1Q0uKowcALjj3jfE9sqPkdrI=
X-Received: by 2002:a05:6870:e993:b0:2c1:c821:c836 with SMTP id
 586e51a60fabf-2db5bec5cf4mr1995261fac.22.1746631567621; Wed, 07 May 2025
 08:26:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250507152045.12266-1-goralbaris@gmail.com>
In-Reply-To: <20250507152045.12266-1-goralbaris@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 May 2025 17:25:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g3M3-xHU+Re-YjJvusA5-gdpmmt7MY9-u8Hr9YEGJRQw@mail.gmail.com>
X-Gm-Features: ATxdqUHImFlKAbVKzufj1nmpa1z_fmCg4IJMDNql2B50aexy0n_tlu6jFNXrYrc
Message-ID: <CAJZ5v0g3M3-xHU+Re-YjJvusA5-gdpmmt7MY9-u8Hr9YEGJRQw@mail.gmail.com>
Subject: Re: [PATCH] acpi: convert strncpy into strscpy
To: goralbaris <goralbaris@gmail.com>
Cc: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, 
	acpica-devel@lists.linux.dev, linux-acpi@vger.kernel.org, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 5:20=E2=80=AFPM goralbaris <goralbaris@gmail.com> wr=
ote:
>
> The strncpy() function is actively dangerous to use since it may not
> NULL-terminate the destination string, resulting in potential memory.

Does it do that in the code modified by this patch?

This is ACPICA code anyway, so changes to it need to be submitted to
the upstream ACPICA project on GitHub.  Only when merged into that
code base, can they be forward-ported to Linux.

> Link: https://github.com/KSPP/linux/issues/90
>
> Signed-off-by: goralbaris <goralbaris@gmail.com>
> ---
>  drivers/acpi/acpica/tbfind.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
> index 1c1b2e284bd9..5536d1755188 100644
> --- a/drivers/acpi/acpica/tbfind.c
> +++ b/drivers/acpi/acpica/tbfind.c
> @@ -57,8 +57,8 @@ acpi_tb_find_table(char *signature,
>
>         memset(&header, 0, sizeof(struct acpi_table_header));
>         ACPI_COPY_NAMESEG(header.signature, signature);
> -       strncpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
> -       strncpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE=
);
> +       strscpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
> +       strscpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE=
);
>
>         /* Search for the table */
>
> --
