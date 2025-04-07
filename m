Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB472561B9
	for <acpica-devel@lists.linux.dev>; Mon,  7 Apr 2025 18:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051793; cv=none; b=u+7suDNQewwm08XfM95CkSqNsl3xhbWJwSoMrUT/smXFNEgXdRzTzUQOAWspYdYnixnEdOJ/SKnKoFgLMqi9mQJj9Bihv2sP3vusD5/UwxagdE6vWEXb9MYGlXqQRDKG9asg8SA0XW8xep2ki6j7FT4Mq7gbotMCLAgAZFvO1VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051793; c=relaxed/simple;
	bh=1nlWZJJELvtnEKCyBxq6dxV3kJYAL3U0AtP2KtULP4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRmBJct6iMdBchcP/NVJABEoweC80yBYSi2Pu4M9YuM8I8+815mUV1Zy7vof3zMpHGN8OXYYFsFKYDhLTZJsGrGK1NG9i5DcBX9pguGFgwdqre5K23Wzt3Xnd9rURC5ZN9+gVYDpRdCCqN/IjRBwtnsxhgFFj6liLGK0nOm3UEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YalS/xrG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YalS/xrG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E2CC4CEE9
	for <acpica-devel@lists.linux.dev>; Mon,  7 Apr 2025 18:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744051793;
	bh=1nlWZJJELvtnEKCyBxq6dxV3kJYAL3U0AtP2KtULP4Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YalS/xrGdrpIFftvjWmV+g8lORGKUwGOQ13GIat0S1ksR1OAHjyhobYWMBiFLoiT3
	 N8Aw/dHNCUw+gPHo7ZJtKjldkQdptbdjpts0q1LJXnlbirm6mE71nxfpRMdhe9RPpq
	 JA62uT8lLEx1LfR2dte7Fe+Ck1JYi1WadqoebMjSq3cjZBfcPapEDWLiprgp8YX6GH
	 GHfJ5z1xDeEiVXB79FvRJvCuycHSKZURXF5zBJMtr2rbuowFTWc3BgvNcGafUWvKJg
	 wm/eQ59pnQckcBI9nBLCnWqXF4b9pXFIKMRqDaNTe+7u8mU95z4dr2LeWlr1m+l2yL
	 JQO0yrzRkEYQw==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-72b0626c785so3535281a34.2
        for <acpica-devel@lists.linux.dev>; Mon, 07 Apr 2025 11:49:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXTAYnlVOwVILpeDyYtPgyyndjJb+7hz4gf+XFstn4SW+SjYhAIbxMj61tbpVUYL8HKCgLleTbXHhEiq4s=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzjj4SM8rrAfYEyEO55fS8mDzYKrAmyLpAz2P5QfGaPIVEuKG3z
	HcsIKfIFbY1cZ6inX2b12QRd3XKGJpZQF4ZdbPb1yC99qxN02pj/9fJ/7gzP+m10fVWJcLT1Ctd
	jVj2I5O7n7aoX98Az+9NDCw8tZZA=
X-Google-Smtp-Source: AGHT+IE4wms3WsmyGofW0ROBOOjrpDpZ36i6hrj5fJqORanB2k9rM6SI+cIy9pv4vQhbplYwqpBkugIZOxYugHoRHJY=
X-Received: by 2002:a05:6830:6308:b0:727:4a6:5b31 with SMTP id
 46e09a7af769-72e37fb78a2mr7598069a34.22.1744051793094; Mon, 07 Apr 2025
 11:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <Z_Qd0x6bLSQjJ7Rw@smile.fi.intel.com>
In-Reply-To: <Z_Qd0x6bLSQjJ7Rw@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 7 Apr 2025 20:49:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j2Y3vPZhUGJmcWzn6esg9zv5an0KPEN4QfQuyGrd5=YQ@mail.gmail.com>
X-Gm-Features: ATxdqUExVHSCLcNOjju2X0lDn2xRsVLFwp1NeA-LeO-wsXwWu2diu26cXLbktB4
Message-ID: <CAJZ5v0j2Y3vPZhUGJmcWzn6esg9zv5an0KPEN4QfQuyGrd5=YQ@mail.gmail.com>
Subject: Re: ACPICA compilation error on x86_64_defconfig (W=1 build)
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Saket Dumbre <saket.dumbre@intel.com>
Cc: Robert Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Saket

On Mon, Apr 7, 2025 at 8:47=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> v6.15-rc1 (but seems older should also be problematic) fails to compile b=
y
> Clang 19 with `make W=3D1`.
>
>   CC      drivers/acpi/acpica/nsaccess.o
>   drivers/acpi/acpica/nsaccess.c:295:6: error: variable 'num_carats' set =
but not used [-Werror,-Wunused-but-set-variable]
>     295 |         u32 num_carats;
>         |             ^
>   1 error generated.
>
> I looked briefly in the code and I have no idea how to fix this, as proba=
bly
> __maybe_unused not an option for ACPICA. Hence this report.
>
> Note, the in-tree defconfig is in use:
>
>         git checkout v6.15-rc1
>         make x86_64_defconfig
>         make W=3D1
>
> should trigger it.
>
> --
