Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD4447F49
	for <acpica-devel@lists.linux.dev>; Wed,  6 Dec 2023 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-58dd5193db4so12109eaf.1
        for <acpica-devel@lists.linux.dev>; Wed, 06 Dec 2023 11:49:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701892182; x=1702496982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hp7+4/skeq3z1JjM3KigvsLSXGvrXr1gskXOMgpelSY=;
        b=ioyztHC6pGoYakCt3/o4aTms3vmidR7t2laHFXOHRucjpqnvRGRIIkvbYP6LKHUVjd
         3H4l4WWNi6rdJZZP6YW/2SmUPU+iArN11IEWKJB9mhhd71mKHdHVLhw014EvTnz6cye5
         U3YIy8aMY2nBCtsrxxGEwQA+Vg04QBrnrNX3Q3YxNE9inCQRRpjWZhlk+wvVFz49Rd+Y
         nsmOBQ5xwFb82AO6k1eK7RLw2V+CDHCL0HmGyXIcL8miaCrFq7QMjGjlZXmDO8nMAJ8B
         h7lLXeKQDCwZaHT599k7rJrRvGtjQmpMzXLbo5RmFuDd4+6ukCb4rGuEIva3EYmfsXae
         Gm0A==
X-Gm-Message-State: AOJu0Yy3EgVFLB90RfbuhBxQFdq7wLwW2NyxQqs/bnTqWKl7ciX8NTjN
	L748BmA21uOqf5CvHui2U8g02sr7cSqXetRm96E=
X-Google-Smtp-Source: AGHT+IExIFz0Wd6u8xUoM+mJ2csD63ycuSkUyWPAXV3GY072wzEGAsU15EY9wikRo0era7uyehQBhU1ZBS4x7XKxo1M=
X-Received: by 2002:a05:6870:b69a:b0:1fb:9b:3d4c with SMTP id
 cy26-20020a056870b69a00b001fb009b3d4cmr2791355oab.0.1701892181729; Wed, 06
 Dec 2023 11:49:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231127055858.41004-1-ytcoode@gmail.com>
In-Reply-To: <20231127055858.41004-1-ytcoode@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Dec 2023 20:49:30 +0100
Message-ID: <CAJZ5v0h-7mhSP5BAig6fj-pax6V_m=u2ygjYU4DxMypJfqv5Cg@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Remove unused struct field and incorrect comments
To: Yuntao Wang <ytcoode@gmail.com>
Cc: Robert Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 6:59=E2=80=AFAM Yuntao Wang <ytcoode@gmail.com> wro=
te:
>
> The return_object_type field in `struct acpi_evaluate_info` is unused,
> so remove it.
>
> There are also some issues in the comments of acpi_ps_execute_method().
> First, the parameter_type field has already been removed from
> `struct acpi_evaluate_info`, so the corresponding field description in
> the comments should also be removed. Second, the return_object field
> description in the comments is duplicated. Remove these incorrect comment=
s.
>
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> ---
>  drivers/acpi/acpica/acstruct.h | 1 -
>  drivers/acpi/acpica/psxface.c  | 3 ---
>  2 files changed, 4 deletions(-)

This is ACPICA code which comes from a separate project.

The way to change it is to submit a pull request with the desired change
to the upstream ACPICA project on GitHub and add a Link tag pointing
to the upstream PR to the corresponding Linux patch.  Then, the Linux
patch can only be applied after the corresponding upstream PR has been
merged.

Thanks!

> diff --git a/drivers/acpi/acpica/acstruct.h b/drivers/acpi/acpica/acstruc=
t.h
> index f8fee94ba708..fe57c3a16e59 100644
> --- a/drivers/acpi/acpica/acstruct.h
> +++ b/drivers/acpi/acpica/acstruct.h
> @@ -169,7 +169,6 @@ struct acpi_evaluate_info {
>         u16 param_count;        /* Count of the input argument list */
>         u16 node_flags;         /* Same as Node->Flags */
>         u8 pass_number;         /* Parser pass number */
> -       u8 return_object_type;  /* Object type of the returned object */
>         u8 flags;               /* General flags */
>  };
>
> diff --git a/drivers/acpi/acpica/psxface.c b/drivers/acpi/acpica/psxface.=
c
> index 6f4eace0ba69..df5679bbc510 100644
> --- a/drivers/acpi/acpica/psxface.c
> +++ b/drivers/acpi/acpica/psxface.c
> @@ -70,9 +70,6 @@ acpi_debug_trace(const char *name, u32 debug_level, u32=
 debug_layer, u32 flags)
>   *                                    NULL if no parameters are being pa=
ssed.
>   *                  return_object   - Where to put method's return value=
 (if
>   *                                    any). If NULL, no value is returne=
d.
> - *                  parameter_type  - Type of Parameter list
> - *                  return_object   - Where to put method's return value=
 (if
> - *                                    any). If NULL, no value is returne=
d.
>   *                  pass_number     - Parse or execute pass
>   *
>   * RETURN:      Status
> --
> 2.43.0
>
>
