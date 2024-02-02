Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF1E146919
	for <acpica-devel@lists.linux.dev>; Fri,  2 Feb 2024 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889912; cv=none; b=SwezJ5ygpkroJ8dnGHDrrAesYwvEfxar0p5p1mFKxk8eN2WlSlVznf/MJ/RHzxb3yV9XVCnIyexR4mVMBDAPFD2Ef3ylnXSUSsjMnDamS/KdkwjiSdRRpGJq179qi7D3fNui8sroNMsV2+972DW6dNHHf2kGOIYhuRu7F3ZOE9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889912; c=relaxed/simple;
	bh=l8joaKMVVu94Gn+N3rz8Ln/DlxXxbBOGkRC5IzLqW3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AsuGjNewVJqEWLhhSDH8/1yGRaksonCEdIahdiM+Q/fCDKsN27Hf35pxLN7aTnIeXBSAXYEYEnBHPu7eLFsbxpIg4NeIOdrhaACHOxz1yV2LZDcGW6pa6i0fHjXrvg+4RySO9ZWl/QROdOscpiH7Ht9WIZ6KB6Jnr8hmI50v6Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-59584f41f1eso674792eaf.1
        for <acpica-devel@lists.linux.dev>; Fri, 02 Feb 2024 08:05:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706889905; x=1707494705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44DDp+9sdekQWew+SL+SIN16R0d8VDB+yLicT1mrJmc=;
        b=XoicSkZi9E0R9fwos0SxS9C4csIxER3+2x8T047/U6MhDUOmCv4M7WZiBze9CXfUOM
         OXOzbABnAgedszRLHn+S0NmcFbU7/TsawlPx07Il84ivD9L7cq7mlHNMGvf49xj/dVvR
         cJlRHXIifaS8RABkw8eP/TI+X24T1vOv3LM4Ltb4eoW2m/w2j4mmnCwHqxLaWa9oU5RM
         dBv5Q4O597HXmbIWLVLHrRWI8QuDA0S3Lfo+QwU002mXG7QekWyEAS3VP8Rj3+5t58KC
         DICTcbXYHcdnlQWgptfJJMKPb3wZCKmvd7HPPMHu8w0SuDyjBLAAZYq8Rh1rkSOiOZNa
         pnwg==
X-Forwarded-Encrypted: i=0; AJvYcCXjEhEjlPFHfxrKbl8Ytyb0czMiQ2UxlBWzCe/h/fRbunWRoGTeatjCp/tk6RnjcjREWauXjtlHPyQ1Bh7nbLtvXGpFJu/ZraANvGve
X-Gm-Message-State: AOJu0YzoWZGviXyijam+hcDwOTuR1rAAMpjn0a5KsIV93yQXIUq2khbk
	oaSK9sLQQzU5zYsOPgDJ9tq4JjFK/k11W8DvWbGpD3WnpIld+t0wYkhkkIUvV4MKU6utblZVz9L
	MP9YTrAIAxUV05U86Opu5nb/nScE=
X-Google-Smtp-Source: AGHT+IGCxiuaTIcNgjndNzOEbvIVYklyZFacA2m0gaZJaSfm+6/FZAPabx+BtGol3yyEnb3KUjoz+irs4Y6V7KOZE98=
X-Received: by 2002:a05:6820:1c96:b0:59a:bf5:a0da with SMTP id
 ct22-20020a0568201c9600b0059a0bf5a0damr7525643oob.0.1706889905114; Fri, 02
 Feb 2024 08:05:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240202081443.1099-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20240202081443.1099-1-jiapeng.chong@linux.alibaba.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Feb 2024 17:04:52 +0100
Message-ID: <CAJZ5v0jVq=xiZ8gY=LvRoB6RH3ud139-4BdsmkPkuaJaOS=Tkw@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Use swap() instead of open coding it
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 9:15=E2=80=AFAM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Swap is a function interface that provides exchange function. To avoid
> code duplication, we can use swap function.
>
> ./drivers/acpi/acpica/nsrepair2.c:896:33-34: WARNING opportunity for swap=
().

In order to modify the ACPICA code in the Linux kernel, you need to
submit a corresponding pull request to the upstream ACPICA project on
GitHub.  Once that pull request has been merged, please send the Linux
patch with a Link: tag pointing to the upstream ACPICA pull request
corresponding to it.

Thanks!

> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D8168
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/acpi/acpica/nsrepair2.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepa=
ir2.c
> index 1bb7b71f07f1..ccd89a82a4e6 100644
> --- a/drivers/acpi/acpica/nsrepair2.c
> +++ b/drivers/acpi/acpica/nsrepair2.c
> @@ -875,7 +875,6 @@ acpi_ns_sort_list(union acpi_operand_object **element=
s,
>  {
>         union acpi_operand_object *obj_desc1;
>         union acpi_operand_object *obj_desc2;
> -       union acpi_operand_object *temp_obj;
>         u32 i;
>         u32 j;
>
> @@ -892,9 +891,7 @@ acpi_ns_sort_list(union acpi_operand_object **element=
s,
>                             || ((sort_direction =3D=3D ACPI_SORT_DESCENDI=
NG)
>                                 && (obj_desc1->integer.value <
>                                     obj_desc2->integer.value))) {
> -                               temp_obj =3D elements[j - 1];
> -                               elements[j - 1] =3D elements[j];
> -                               elements[j] =3D temp_obj;
> +                               swap(elements[j], elements[j - 1]);
>                         }
>                 }
>         }
> --
> 2.20.1.7.g153144c
>
>
