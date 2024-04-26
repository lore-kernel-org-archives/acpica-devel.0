Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB64F159585
	for <acpica-devel@lists.linux.dev>; Fri, 26 Apr 2024 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152591; cv=none; b=QI2F47KISBUAU8P1BUNYemvrmCAOINHNn6TcY73SML14ApWspcPswV4RQFkQ8x7md0BXm0kimiUpRwxJ7Cj6T0FU348ioy3lsd8SnEAT4ChzYzjXF6Kq289iqPyTjyf3kABtTn+FBHpbjiyq8o79QxPj9AaYBNHmbryn8o4kZUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152591; c=relaxed/simple;
	bh=BJdT96jPIV46Cyv8V9wT3gVr7uDS8d+LlcDE6fFZ5jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hj+xRF/eLG+Pn+IelDNb+0qZ8SguLvWi5gGOF3fOzr15WH7GJ4QzUMPmDdNoHk97cl5/lg2wqnBh5q/ZEMm8cl5f3KaOXFidURb2mHrWB+SvSwxWCrWsBQvDWMBuNMKYSghMOZkegbkln2Slb/cx40QHAjhmFlydZbB+3TGk96Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9eZYhzH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9eZYhzH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C1FC116B1
	for <acpica-devel@lists.linux.dev>; Fri, 26 Apr 2024 17:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714152591;
	bh=BJdT96jPIV46Cyv8V9wT3gVr7uDS8d+LlcDE6fFZ5jc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R9eZYhzHYbpCnw6emCRuXhNy5ntEmQkWwRLKu9hOvtlqozJvxMqPqqPq/diTjElXy
	 KfXWyYfFERQ662OTH/H7Av8hdK/0hO4EjyF+tmB71c35nnnwiG9XliWCncaI0HVDmF
	 SmO0NoDzfAJF7D7eiP7o6x7l2397ESMNRvOJViOSA83cIlT5qnr5H0gIqGSRo/Kfjx
	 onOt5AHSXo/CB/KhpyC1epHpCFWPQTH4F1MLcEK7ugrtc8X3LAmNB6Z7t1nL/7BGXZ
	 HcVqy/CSWQWw3HE3dI+MnxpKYPJus2iberq132qKojJ7dO2uTWocJSW/JSBC/mXf6s
	 ncG38ur5oyuqQ==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5acf5723325so635410eaf.0
        for <acpica-devel@lists.linux.dev>; Fri, 26 Apr 2024 10:29:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW7SlkObg80r7t8J3sUfXum2z1dhbjsJanLLOYK0UKE9Mu6/ZzCzZbi7DrzDO0TgJpxMXLLj7EGYg90SufTpwXP6/lwAavHpmeBfZIf
X-Gm-Message-State: AOJu0YwmS8HtBNDZ//4MHK5hYq7jCW2fKGlYjz8wVEgUofP3wSeaa3Vg
	GqhX1G54svD9tN4D4RW6pZJzgqs7XOACBS8AM8Tv9fdIqwsiC2SsNcEm7ll+zkNc2XsEW8sOTRT
	7zFNwqX2n0KAqAIpbK7yK3cRogoM=
X-Google-Smtp-Source: AGHT+IEKbrS5Zi5PgkIPEXoqOznTo0BLcEvDy7UJ48p8ejOZzjyXJV2c3/hcdXqwf9hgqMpGLXG8v8ZUUihaib9nqLs=
X-Received: by 2002:a05:6820:e09:b0:5a7:db56:915c with SMTP id
 el9-20020a0568200e0900b005a7db56915cmr3849839oob.1.1714152590854; Fri, 26 Apr
 2024 10:29:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240426094850.757123-1-yu.c.chen@intel.com>
In-Reply-To: <20240426094850.757123-1-yu.c.chen@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Apr 2024 19:29:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i5XhOzLr+9yrjzgM+GntFHFW+pQGV6EnHfNEoatXjjOg@mail.gmail.com>
Message-ID: <CAJZ5v0i5XhOzLr+9yrjzgM+GntFHFW+pQGV6EnHfNEoatXjjOg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: tools: pfrut: Print the update_cap field during
 capability query
To: Chen Yu <yu.c.chen@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 11:50=E2=80=AFAM Chen Yu <yu.c.chen@intel.com> wrot=
e:
>
> There is request from the end user to print this field to better
> query what type of update capability is supported on this platform.
>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  tools/power/acpi/tools/pfrut/pfrut.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/power/acpi/tools/pfrut/pfrut.c b/tools/power/acpi/tool=
s/pfrut/pfrut.c
> index 388c9e3ad040..44a9ecbd91e8 100644
> --- a/tools/power/acpi/tools/pfrut/pfrut.c
> +++ b/tools/power/acpi/tools/pfrut/pfrut.c
> @@ -174,6 +174,8 @@ void print_cap(struct pfru_update_cap_info *cap)
>                 exit(1);
>         }
>
> +       printf("update capability:%d\n", cap->update_cap);
> +
>         uuid_unparse(cap->code_type, uuid);
>         printf("code injection image type:%s\n", uuid);
>         printf("fw_version:%d\n", cap->fw_version);
> --

Applied as 6.10 material, thanks!
