Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FE02777FC
	for <acpica-devel@lists.linux.dev>; Sun,  1 Feb 2026 22:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769986086; cv=none; b=MwDZQqMo+7thN5z+Xt4W+QOnldx81vmKpqpf0YpOV8aiRLdZcPo0OLP3mfyrxT3LQtHuokIr4kyRR9b1YzrPYlDuGuuJOULKVv/fFSNSuouQIqDX5ImyZVVCHVDd9UoMlFEKQIgkF7JBt8WqHQ5AgOPJfHdpC/eypfnP4Yom53c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769986086; c=relaxed/simple;
	bh=kPXYKw64d+jtcY3lxRoah56tsMgtUtCgn6SKRHtQhDM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bIxHFLSVM7UGVA6Jk0QOdnLt9tHgBdr5mrdySX492wkDH2o3y1kWHJdaOjD4Y7qD/zqUmHe9TCwMA5EkydhwliC5d7KmSmvRKsIQyzwqSxmhVyZFJzaDvMZ/xf74IYpxum3PY4A8/Mmpai2JppzQbHOjbBGsPQmH/EqySoN8rJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0nj0HDu; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0nj0HDu"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-482f2599980so8899095e9.0
        for <acpica-devel@lists.linux.dev>; Sun, 01 Feb 2026 14:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769986083; x=1770590883; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeIFE62uRClcxIIMvVybquzDz6/s2PS0WZIdflKEiOA=;
        b=D0nj0HDuDSpSlStrRSs9D1gfqTz/Cvc8gm+NuzcbvPQ+RWWCvKJDdYUs3Da5HHi0oQ
         /U5OkFadpDz2+Ij8BkOMohEFdC2a66ap/hNb2n0GCRmWKXKzeyJzQQY44D0qoY6PGWlQ
         N+XuIlUtARnK2aSr0U5TJcEbc2uFcWie3GmlcsEh9lDpPEpzLTDZwpQ3LQB73cJpINyY
         WOUDos/ZZxoYpvza5RfubQK4TgaQ5dZ3gYamxI71xk6vd/CKo7ckOBRxbYnRaQw2pkwY
         tqmxsQ5M0wqQA+Euk/DaPGrj9K+QaLeooFGcG6+zGT0hg/jpnXeB/ky6OJzsaNKXvFRN
         z8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769986083; x=1770590883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yeIFE62uRClcxIIMvVybquzDz6/s2PS0WZIdflKEiOA=;
        b=g0WOcv9LUmowP7IjaU4AI/zDxYheXwCo5v7HlTwhJRxFpusyvbjV0ICg3Vl0zyP62o
         47GCFcn+UH67f0SIBCfg/4JazeMm/qEUY4iKSjU1QrZKD7gEWFPrfKwRYtKZRsFrHWU8
         UB9puvnUYLzqBxFRkiGr8Zq2cD5t9ty+GXHaWoCJ577XVvL9DQhnHrctffiyGPhIHXEQ
         k+sImoeBWYXRttFTUhnnhiTXHNUVSqaJcQyPZLOUBrmr+x+gqXInb4/tEJhjsrVGRHzr
         CaQJDdreeLV6qZv/mf7ogRSHYLvVtQAcJ/rFpg+PhZ2MUSW7j/qrmNAEGJOaWPn9nDaB
         VI/A==
X-Forwarded-Encrypted: i=1; AJvYcCXPL7YROUqG/OZQr0ydMXHHTwDTD0i6Ijtip9dKfw4wu+G9aMBbE/X1LaXAwPGNqFgY51pF7JVoKKuFqCY=@lists.linux.dev
X-Gm-Message-State: AOJu0YwBke+dce/W0FMkdEQAYXYre8YKlZJ4HaUzzA4NwO5zVzSaTO/f
	cjhAafoMMKoGTA/2eoIKvuUJTsYxGPd+GDq16YBjss3NNfMHz6fxJbBC
X-Gm-Gg: AZuq6aL/vede6WwZKz5vvPMi3mFbAKygt4sGkYvVta6fZ6wt+0qC74H5AZRhX4y+a9x
	GsRrEpOyHJ78nVp1g7S+GPRI4Lea4ypLk1JPG0/cUe/fz3Df8Khp2SFEOdL4Ws/iAvniTMW9cbq
	2WgUy6xLl34ZaJQmiQefpISN+5Vw64WAlr/f4uwTdWggQped/A49m8KLMaJWphJsovpo99ZylHe
	U+arylV7Jthpv/Ada9HAd6XAWMgJEF8O5yukg7uVAckdApZoL0SrLueFrDZbR8te6rvc9HkGE3P
	sdNuUkbrVumlu1TkxgUu2ddMdceGjMO05Tg93BRDcbtNmzo7q3XZYY3GQ8jubIMHbiX9PclNJEd
	B9Ze6r93J1i2tsYdsgih39k0g9clzKFybO1DqU00vkshzqerdHaogBuLphiprxBl+m0Lqd4Epau
	B+R39JfJPz7HicmTQP7x0VHPLKUgEkXF5qWeqc5FtC6L2PZ9kI5Hxt
X-Received: by 2002:a05:600c:6214:b0:480:1c53:208b with SMTP id 5b1f17b1804b1-482db49da0bmr116715605e9.36.1769986083142;
        Sun, 01 Feb 2026 14:48:03 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c42895sm429732215e9.14.2026.02.01.14.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 14:48:02 -0800 (PST)
Date: Sun, 1 Feb 2026 22:48:01 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Nick Huang <sef1548@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Robert Moore
 <robert.moore@intel.com>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, paladin@ntub.edu.tw, kusogame68@gmail.com,
 ceyanglab@gmail.com, n1136402@ntub.edu.tw
Subject: Re: [PATCH 1/2] ACPI: nsrepair2: Replace =?UTF-8?B?TyhuwrIp?=
 bubble sort with O(n log n) sort_r()
Message-ID: <20260201224801.609e94d0@pumpkin>
In-Reply-To: <20260201130334.3107-2-sef1548@gmail.com>
References: <20260201130334.3107-1-sef1548@gmail.com>
	<20260201130334.3107-2-sef1548@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun,  1 Feb 2026 13:03:33 +0000
Nick Huang <sef1548@gmail.com> wrote:

>    Replace the O(n=C2=B2) bubble sort implementation in acpi_ns_sort_list=
()
>    with the kernel's sort_r() function which uses heapsort, providing
>    O(n log n) time complexity.
>=20
>    This improves performance for large ACPI package lists while also
>    reducing code complexity by leveraging the existing kernel sort API.

What is the break even size?
While the heapsort is O(n long n) it is also more complicated.
There is also the cost of the function call - especially with all the
mitigations that distro kernels are likely to enable.

For large datasets the d-cache locality of both sorts is particularly horri=
d.
It is almost certainly better to allocate an array of index:value pairs
and sort that.
For very big datasets you want to sort small sections (that fit in the
d-cache) and then use merge sorts (also O(n log n)) to combine them.
(Yes - this is how you sort data with 3 mag-tape drives....)

Oh, in any case, write separate functions for ascending/descending.

	David

>=20
> Signed-off-by: Nick Huang <sef1548@gmail.com>
> ---
>  drivers/acpi/acpica/nsrepair2.c | 87 +++++++++++++++++++++++----------
>  1 file changed, 62 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepa=
ir2.c
> index 8dbb870f4..a39ef59fe 100644
> --- a/drivers/acpi/acpica/nsrepair2.c
> +++ b/drivers/acpi/acpica/nsrepair2.c
> @@ -9,6 +9,7 @@
>   ***********************************************************************=
******/
> =20
>  #include <acpi/acpi.h>
> +#include <linux/sort.h>
>  #include "accommon.h"
>  #include "acnamesp.h"
> =20
> @@ -84,6 +85,14 @@ acpi_ns_check_sorted_list(struct acpi_evaluate_info *i=
nfo,
>  static void
>  acpi_ns_remove_element(union acpi_operand_object *obj_desc, u32 index);
> =20
> +/* Context structure for sort comparison function */
> +struct acpi_sort_context {
> +	u32 sort_index;
> +	u8 sort_direction;
> +};
> +
> +static int acpi_ns_sort_cmp(const void *a, const void *b, const void *pr=
iv);
> +
>  static void
>  acpi_ns_sort_list(union acpi_operand_object **elements,
>  		  u32 count, u32 index, u8 sort_direction);
> @@ -851,6 +860,52 @@ acpi_ns_check_sorted_list(struct acpi_evaluate_info =
*info,
>  	return (AE_OK);
>  }
> =20
> +/***********************************************************************=
*******
> + *
> + * FUNCTION:    acpi_ns_sort_cmp
> + *
> + * PARAMETERS:  a               - First element to compare
> + *              b               - Second element to compare
> + *              priv            - Pointer to sort context (acpi_sort_con=
text)
> + *
> + * RETURN:      -1, 0, or 1 depending on sort order
> + *
> + * DESCRIPTION: Comparison function for sort_r() API. Compares the integ=
er
> + *              values at the specified index within package elements.
> + *
> + ***********************************************************************=
******/
> +
> +static int acpi_ns_sort_cmp(const void *a, const void *b, const void *pr=
iv)
> +{
> +	union acpi_operand_object *obj_a =3D *(union acpi_operand_object **)a;
> +	union acpi_operand_object *obj_b =3D *(union acpi_operand_object **)b;
> +	const struct acpi_sort_context *ctx =3D priv;
> +	union acpi_operand_object *value_a;
> +	union acpi_operand_object *value_b;
> +	u64 a_val;
> +	u64 b_val;
> +
> +	value_a =3D obj_a->package.elements[ctx->sort_index];
> +	value_b =3D obj_b->package.elements[ctx->sort_index];
> +
> +	a_val =3D value_a->integer.value;
> +	b_val =3D value_b->integer.value;
> +
> +	if (ctx->sort_direction =3D=3D ACPI_SORT_ASCENDING) {
> +		if (a_val < b_val)
> +			return -1;
> +		if (a_val > b_val)
> +			return 1;
> +	} else {
> +		if (a_val > b_val)
> +			return -1;
> +		if (a_val < b_val)
> +			return 1;
> +	}
> +
> +	return 0;
> +}
> +
>  /***********************************************************************=
*******
>   *
>   * FUNCTION:    acpi_ns_sort_list
> @@ -873,31 +928,13 @@ static void
>  acpi_ns_sort_list(union acpi_operand_object **elements,
>  		  u32 count, u32 index, u8 sort_direction)
>  {
> -	union acpi_operand_object *obj_desc1;
> -	union acpi_operand_object *obj_desc2;
> -	union acpi_operand_object *temp_obj;
> -	u32 i;
> -	u32 j;
> -
> -	/* Simple bubble sort */
> -
> -	for (i =3D 1; i < count; i++) {
> -		for (j =3D (count - 1); j >=3D i; j--) {
> -			obj_desc1 =3D elements[j - 1]->package.elements[index];
> -			obj_desc2 =3D elements[j]->package.elements[index];
> -
> -			if (((sort_direction =3D=3D ACPI_SORT_ASCENDING) &&
> -			     (obj_desc1->integer.value >
> -			      obj_desc2->integer.value))
> -			    || ((sort_direction =3D=3D ACPI_SORT_DESCENDING)
> -				&& (obj_desc1->integer.value <
> -				    obj_desc2->integer.value))) {
> -				temp_obj =3D elements[j - 1];
> -				elements[j - 1] =3D elements[j];
> -				elements[j] =3D temp_obj;
> -			}
> -		}
> -	}
> +	struct acpi_sort_context ctx;
> +
> +	ctx.sort_index =3D index;
> +	ctx.sort_direction =3D sort_direction;
> +
> +	sort_r(elements, count, sizeof(union acpi_operand_object *),
> +	       acpi_ns_sort_cmp, NULL, &ctx);
>  }
> =20
>  /***********************************************************************=
*******

