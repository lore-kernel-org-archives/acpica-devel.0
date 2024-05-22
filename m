Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3F881AA7
	for <acpica-devel@lists.linux.dev>; Wed, 22 May 2024 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716372621; cv=none; b=X0kNBZbdQlwD5m9k/SGH6iXxPtIy/HxunYE6hpEMMo/E6bgNSODK7JLluWXEcK6RQXyIOUzRyzvs9q212ijfb6oFOZ16Pdcf7aDXyrCpbMzr3qoXJ1+d64tDgO/wehXV6e/Z593x9BTDTrCBTgCdFJwj1q4aPMjleIYh/zCXjRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716372621; c=relaxed/simple;
	bh=FI4zo+moBW9miEacUIAXuSGw8WkogkLoVnq2rXZ7GMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHEa3ZOwKop8BF1igI77XzQNmOY1VwdGqIAQwf+3h2WQupSdkoVTHcjQm3HrlL89Kb99zEARcOYldr90OTgOB38vqGCDMUlCGZilwofgvPmHwaUwbuwu4Pm3KOOh2X75A4PLniacymKrZdgjYeP9ULijxTsKBQyTRk06u0WrFPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhKFHrHO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhKFHrHO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143B5C4AF0E
	for <acpica-devel@lists.linux.dev>; Wed, 22 May 2024 10:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716372621;
	bh=FI4zo+moBW9miEacUIAXuSGw8WkogkLoVnq2rXZ7GMI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AhKFHrHOZV1IauO40P6sPbxOObBb9aSaKjlm+seRC0zp0aCDL0XeTrLyFcY7asaRh
	 IGZBdcZGB6gi5wNZGbucgc0pmJk1DkI4a9pCb9awEAle+M9USgJSBF7Ni9Ae+anjtN
	 De49Qj+Zo08cnjRs9KiWJihMGPq3jp9aiyYBbeJuIQxxyahLHX2tFqf2AeCVnB7Uwz
	 di/OYukFr8EGaUjjoZQ1QFo4rJi16xyz6L+TerDYHEIEmshucDBkAAPCZFtCmwxLNw
	 P1lfXJZkWrfH2X/nhToJtPDdqwGHHB9ptYmyGlxwYlafmhC2fNIhLYB6SgI+s8GOZs
	 OQ01f2CYVgYAg==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5b3356fd4f3so500808eaf.1
        for <acpica-devel@lists.linux.dev>; Wed, 22 May 2024 03:10:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2J21UBZINM5CrP/3VxKZgBbDHfHeF9TmcerNp2T/WnqfOrFDGltu/tkds8NYFo9xF2z6Gscq8HpUFrgUSsv4EAKUWmnXNks6Gt949
X-Gm-Message-State: AOJu0YxNKz/8+LQTbPS5li0MkPQ/VJkMvmsyabU7ZIXWBCXsFR/yp9f2
	vSYUXUvcRX7/JHHnx5GkN3TjK7rRD6upGFriUdiBZhwWbf/Jg18E1I5ZVS/jD09znXUy091eyrp
	V/IDskDnu9e4ZCuIY0dYYCV2iLFA=
X-Google-Smtp-Source: AGHT+IEarXMU3u+jUAtq8NVPIv6BfztF2G7OuMYlKS+slataKc51NNA8r5y9q6ryL1Ift+y5s/WLRi6XBrY1cZ3OSt4=
X-Received: by 2002:a4a:bd14:0:b0:5b2:7aa7:7b29 with SMTP id
 006d021491bc7-5b6a32e9241mr1461779eaf.1.1716372620255; Wed, 22 May 2024
 03:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240521211036.227674-1-zaidal@os.amperecomputing.com> <20240521211036.227674-2-zaidal@os.amperecomputing.com>
In-Reply-To: <20240521211036.227674-2-zaidal@os.amperecomputing.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 22 May 2024 12:10:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iEufuZugRT3ZPn=wk49E8_xACsOJX4OWPpiv0HybGKNA@mail.gmail.com>
Message-ID: <CAJZ5v0iEufuZugRT3ZPn=wk49E8_xACsOJX4OWPpiv0HybGKNA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/8] ACPICA: Update values to hex to follow ACPI specs
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com, 
	tony.luck@intel.com, bp@alien8.de, robert.moore@intel.com, 
	Jonathan.Cameron@huawei.com, Benjamin.Cheatham@amd.com, 
	dan.j.williams@intel.com, arnd@arndb.de, Avadhut.Naik@amd.com, 
	u.kleine-koenig@pengutronix.de, john.allen@amd.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 11:11=E2=80=AFPM Zaid Alali
<zaidal@os.amperecomputing.com> wrote:
>
> ACPI specs(1) define Error Injection Actions in hex values.
> This commit intends to update values from decimal to hex to be
> consistent with ACPI specs. This commit and the following one are
> not to be merged and will come form ACPICA project(2).
>
> (1) https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html
> (2) https://lore.kernel.org/acpica-devel/20240514184150.6285-1-zaidal@os.=
amperecomputing.com/
>
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>

In order to modify the ACPICA code in the Linux kernel, you need to
submit a corresponding pull request to the upstream ACPICA project on
GitHub.  Once that pull request has been merged, please send the Linux
patch with a Link: tag pointing to the upstream ACPICA pull request
corresponding to it.

Thanks!

> ---
>  include/acpi/actbl1.h | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 841ef9f22795..b321d481b09a 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -1017,18 +1017,18 @@ struct acpi_einj_entry {
>  /* Values for Action field above */
>
>  enum acpi_einj_actions {
> -       ACPI_EINJ_BEGIN_OPERATION =3D 0,
> -       ACPI_EINJ_GET_TRIGGER_TABLE =3D 1,
> -       ACPI_EINJ_SET_ERROR_TYPE =3D 2,
> -       ACPI_EINJ_GET_ERROR_TYPE =3D 3,
> -       ACPI_EINJ_END_OPERATION =3D 4,
> -       ACPI_EINJ_EXECUTE_OPERATION =3D 5,
> -       ACPI_EINJ_CHECK_BUSY_STATUS =3D 6,
> -       ACPI_EINJ_GET_COMMAND_STATUS =3D 7,
> -       ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS =3D 8,
> -       ACPI_EINJ_GET_EXECUTE_TIMINGS =3D 9,
> -       ACPI_EINJ_ACTION_RESERVED =3D 10, /* 10 and greater are reserved =
*/
> -       ACPI_EINJ_TRIGGER_ERROR =3D 0xFF  /* Except for this value */
> +       ACPI_EINJ_BEGIN_OPERATION =3D             0x0,
> +       ACPI_EINJ_GET_TRIGGER_TABLE =3D           0x1,
> +       ACPI_EINJ_SET_ERROR_TYPE =3D              0x2,
> +       ACPI_EINJ_GET_ERROR_TYPE =3D              0x3,
> +       ACPI_EINJ_END_OPERATION =3D               0x4,
> +       ACPI_EINJ_EXECUTE_OPERATION =3D           0x5,
> +       ACPI_EINJ_CHECK_BUSY_STATUS =3D           0x6,
> +       ACPI_EINJ_GET_COMMAND_STATUS =3D          0x7,
> +       ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS =3D 0x8,
> +       ACPI_EINJ_GET_EXECUTE_TIMINGS =3D         0x9,
> +       ACPI_EINJ_ACTION_RESERVED =3D             0xA,    /* 0xA and grea=
ter are reserved */
> +       ACPI_EINJ_TRIGGER_ERROR =3D               0xFF    /* Except for t=
his value */
>  };
>
>  /* Values for Instruction field above */
> --
> 2.34.1
>
