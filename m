Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA803482E4
	for <acpica-devel@lists.linux.dev>; Wed,  6 Dec 2023 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3b86057b5b2so792300b6e.1
        for <acpica-devel@lists.linux.dev>; Wed, 06 Dec 2023 08:31:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701880261; x=1702485061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJxffBaMiQ2oTEKkMXfgMIDNFQA4n7Ds0nLK++uGZow=;
        b=EckGBnh3/Vb6kQv+Xq16p+hATlfvk+tg/Px2H9FmM6wPdAuoG7GyI45s0MzAc6BTWj
         l7cJLwvg4Ex1aTMz39yaz9PXcLpo6v40b5cxzd4mMD3ZfwBp2pNd5xuBkbQwQdNN5uxY
         42vCcwxwqEQ4dPf64Rnlk1+NeRGG7v8wcQfd30woCKueOzoYNVKr+47BGswaO3BdQ6l6
         DyulklDzxc2ckeyckNEaD6FxQV/klShT/uHSCv3e1Mo1rLwAp8JB78bt74LUWx7vLMOW
         FieRsVsCnAd/Mg5irDlPTlScAnDJ3qUTltdnkTbyvk5rVFWLQNH/M4ukHGF1ZqK+yVaX
         xCqg==
X-Gm-Message-State: AOJu0Yw2HxEnQDXQQdDahPpaT+IiNobzNAU03IIoMBrjM+tV0ZHt7Aag
	11+0ZFG1RpWiP4X9tyOmORBP5rvX0odM0nXuxqw=
X-Google-Smtp-Source: AGHT+IFPGJlxHkYT76B5iGqfPk/xee9F9t18f0t6eHfXFL1yLeB3+9iiJYLslXfNgsbsEfecYAN5wfXvomuyZirJCL8=
X-Received: by 2002:a05:6870:8086:b0:1fb:136e:fa93 with SMTP id
 q6-20020a056870808600b001fb136efa93mr2018209oab.0.1701880260700; Wed, 06 Dec
 2023 08:31:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231111134827.174908-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231111134827.174908-1-heinrich.schuchardt@canonical.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Dec 2023 17:30:47 +0100
Message-ID: <CAJZ5v0gGKuBNBvDj2fNMyCvKTrt2SWfusxyaf7W4jvvfL0nxUg@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: XSDT: struct acpi_table_xsdt must be packed
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Robert Moore <robert.moore@intel.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 2:48=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> According to the ACPI 6.5 specification the component Entry starts at
> offset 36 in the XSDT table which is not a multiple of 8. Hence we must
> mark the structure as packed.

There is #pragma pack(1) at the beginning of actbl.h.  Is it not sufficient=
?

> We did not see an error due to the incorrect packing yet as in
> acpi_tb_parse_root_table() we use ACPI_ADD_PTR() to find the address of
> Entry.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/acpi/actbl.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
> index 451f6276da49..1a37ac378765 100644
> --- a/include/acpi/actbl.h
> +++ b/include/acpi/actbl.h
> @@ -148,7 +148,7 @@ struct acpi_table_rsdt {
>  struct acpi_table_xsdt {
>         struct acpi_table_header header;        /* Common ACPI table head=
er */
>         u64 table_offset_entry[1];      /* Array of pointers to ACPI tabl=
es */
> -};
> +} __packed;
>
>  #define ACPI_RSDT_ENTRY_SIZE        (sizeof (u32))
>  #define ACPI_XSDT_ENTRY_SIZE        (sizeof (u64))
> --
> 2.40.1
>
