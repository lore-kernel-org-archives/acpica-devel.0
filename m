Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2086D6DB
	for <acpica-devel@lists.linux.dev>; Thu, 21 Dec 2023 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6da09f8ce35so158305a34.0
        for <acpica-devel@lists.linux.dev>; Thu, 21 Dec 2023 06:17:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703168260; x=1703773060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBHSazj3p+MLo+y/uvsliBm5vLXGA+IDGINMZnlhLjU=;
        b=cJFUIXR6CreINy7mUewD8JSOEAMzH4N6C5GJO6zVhaWO9LCctgbeWfgJqzJWTigVL/
         81Qah/Jq15ak0yA27wZEfa9I88D9MaYBjy73lgfJ2lILo5t/MV26nPx9ubdXuHU1ng3g
         cFtMXWVnnfG57gxnFpfJ+/sX6bqLyZLsiPqoxEvziEJRgzbj3fi5dmzDpficAjV80HnZ
         icUAGygoDKcl8B2mZzB60Mtb7WqLENTsLV5g3+jpsq3MJMMg6qraglS688KE7GVWu51P
         inI1on5XKdk3kTyVWi2iciNJkiIaemvXn8adcZhBnYvcwOyyAKBFvHS/WWcqCPwLc64w
         89Qw==
X-Gm-Message-State: AOJu0YwcGAjl4cmRe9TkJgGHvqMQ8RuZVl3YKP9RerYJCbsvzQWeSaq9
	1R+5A9uqogkZhVuaHPJkG6luMXDJ2JVrFDObZjk=
X-Google-Smtp-Source: AGHT+IEj20FBnmLZ/ARdh0C0RK0hJmU/LJkWL9Ggrx3TW+UsEGgW147R1BWJygWWzB9l/UjKt/sx9R3eMBp8DiHLGNY=
X-Received: by 2002:a05:6820:258a:b0:593:e53b:2df1 with SMTP id
 cs10-20020a056820258a00b00593e53b2df1mr7893445oob.1.1703168260730; Thu, 21
 Dec 2023 06:17:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231215072405.65887-1-luoxueqin@kylinos.cn>
In-Reply-To: <20231215072405.65887-1-luoxueqin@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 21 Dec 2023 15:17:29 +0100
Message-ID: <CAJZ5v0g5PdOiRVB08zvi1gBqFU5LKm4O0FaFdH-FC=eQKyNNGA@mail.gmail.com>
Subject: Re: [PATCH -next] ACPICA: Replace strncpy() with strscpy_pad() for dest
To: xueqin Luo <luoxueqin@kylinos.cn>
Cc: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 8:24=E2=80=AFAM xueqin Luo <luoxueqin@kylinos.cn> w=
rote:
>
> While it is safe to use strncpy in this case, the advice is to move to
> strscpy_pad[1].
>
> Link: https://www.kernel.org/doc/html/latest/process/deprec:qated.html#st=
rncpy-on-nul-terminated-strings [1]
> Signed-off-by: xueqin Luo <luoxueqin@kylinos.cn>
> ---
>  drivers/acpi/acpica/utnonansi.c | 3 +--

ACPICA code comes from an external project.  The proper way of
modifying it is to submit a pull request to the upstream ACPICA
project on GitHub.  Once this pull request has been merged upstream, a
Linux patch containing a Link: tag to the corresponding upstream pull
request can be submitted.

Thanks!

>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/utnonansi.c b/drivers/acpi/acpica/utnona=
nsi.c
> index ff0802ace19b..3a7952be6545 100644
> --- a/drivers/acpi/acpica/utnonansi.c
> +++ b/drivers/acpi/acpica/utnonansi.c
> @@ -168,8 +168,7 @@ void acpi_ut_safe_strncpy(char *dest, char *source, a=
cpi_size dest_size)
>  {
>         /* Always terminate destination string */
>
> -       strncpy(dest, source, dest_size);
> -       dest[dest_size - 1] =3D 0;
> +       strscpy_pad(dest, source, dest_size);
>  }
>
>  #endif
> --
> 2.34.1
>
>
