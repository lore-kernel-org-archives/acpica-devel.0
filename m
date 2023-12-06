Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3196D482EC
	for <acpica-devel@lists.linux.dev>; Wed,  6 Dec 2023 16:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1fb1620a00eso305fac.1
        for <acpica-devel@lists.linux.dev>; Wed, 06 Dec 2023 08:39:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701880782; x=1702485582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOpsMpN5kc6thb3d1q4d3kl9xx5Ha381XUlpiCeA7Vg=;
        b=WD+czgnNdsDyYzlVrC7ejD0QbDfYCM8Szh6Zyu2uBSSM9B6Dh6pgELsiCzUfYiHKEI
         pPxcwNHRnh4Ds6qX9BNfs+kgdvo81rxptV6GCOO+ZZDt+GW3Qi+FdjGTctCCyBkyeGAi
         0rU+nAN+uzK77jIXCwqT/UdpmYGFLp2RTp5HrXghnvyKnWaaP5Ly1vPBQPsmqNS0t42N
         vrM1Jrxp6cqxCgg7q+Fb1aix4nUElJCVfxkFji7kKxVoaUl+fCxQp/fk9hQ3To1GVDZz
         ZcpXrfXLNXJ2D2hYdgGFBP4rdP41fTCXCVE3YbP73FwYNnAh1WwyAvDJaT6XZeX8x4r/
         tv0Q==
X-Gm-Message-State: AOJu0Yz9rrJA4a70gTqkxjwl6EAaEIDTauxwHAD8HcHdvaByxcYksB+1
	8YQavt1X8SmwnaEnBSG927GrouovwzO5LWANT00=
X-Google-Smtp-Source: AGHT+IE+QBw0uGCe3QdwQFdjnKR42J/h74k4XSadE/DgYk6WWgxdbDG4+G3mwf1tieSM1OUVNXOpgCrQ+v1vLscpEso=
X-Received: by 2002:a05:6870:e2cb:b0:1fb:23ec:3318 with SMTP id
 w11-20020a056870e2cb00b001fb23ec3318mr2127789oad.0.1701880782199; Wed, 06 Dec
 2023 08:39:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <b8c5f018-4883-4c14-84ab-0514edac2770@ancud.ru>
In-Reply-To: <b8c5f018-4883-4c14-84ab-0514edac2770@ancud.ru>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Dec 2023 17:39:29 +0100
Message-ID: <CAJZ5v0i7LYzF13M0qdeYWXZ7uO6HUpAS7pE5RJnOAJtKB8o88A@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: debugger: check status of acpi_evaluate_object in acpi_db_walk_for_fields
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: Robert Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, 
	Erik Kaneda <erik.kaneda@intel.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 2:33=E2=80=AFPM Nikita Kiryushin <kiryushin@ancud.r=
u> wrote:
>
> Errors in acpi_evaluate_object can lead to incorrect state of buffer.
> This can lead to access to data in previously ACPI_FREEd buffer and
> secondary ACPI_FREE to the same buffer later.
>
> Handle errors in acpi_evaluate_object the same way it is done earlier
> with acpi_ns_handle_to_pathname.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 5fd033288a86 ("ACPICA: debugger: add command to dump all fields
> of particular subtype")
> Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
> ---
>   drivers/acpi/acpica/dbnames.c | 8 ++++++--

This is ACPICA code which comes from a separate project.

The way to change it is to submit a pull request with the desired change
to the upstream ACPICA project on GitHub and add a Link tag pointing
to the upstream PR to the corresponding Linux patch.  Then, the Linux
patch can only be applied after the corresponding upstream PR has been
merged.

Thanks!

>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/dbnames.c b/drivers/acpi/acpica/dbnames.=
c
> index b91155ea9c34..c9131259f717 100644
> --- a/drivers/acpi/acpica/dbnames.c
> +++ b/drivers/acpi/acpica/dbnames.c
> @@ -550,8 +550,12 @@ acpi_db_walk_for_fields(acpi_handle obj_handle,
>         ACPI_FREE(buffer.pointer);
>         buffer.length =3D ACPI_ALLOCATE_LOCAL_BUFFER;
> -       acpi_evaluate_object(obj_handle, NULL, NULL, &buffer);
> -
> +       status =3D acpi_evaluate_object(obj_handle, NULL, NULL, &buffer);
> +       if (ACPI_FAILURE(status)) {
> +               acpi_os_printf("Could Not evaluate object %p\n",
> +                              obj_handle);
> +               return (AE_OK);
> +       }
>         /*
>          * Since this is a field unit, surround the output in braces
>          */
> --
> 2.34.1
>
>
