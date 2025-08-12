Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82CA25949A
	for <acpica-devel@lists.linux.dev>; Tue, 12 Aug 2025 13:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755004365; cv=none; b=P5UpCXOi+3vtS/B99a2mXdGop5okfaMPvLikzmxJafKcNZOofBaKilf1xnLRUHb1duhi7HFt/yv+WTm7koSw9eTqhU7Pp0cVIyNJOjufK9E7/UDeKjpFWPiVmL0X4zF8RZf3euG7fYJJ7WvoGF+CHQkamxJzU2opB8iXvUmwzyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755004365; c=relaxed/simple;
	bh=u1y83lzylh/onoHVhjG9k4+Kl2BBhLWMnEb7+R0ZrFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bdmlyHQf5hmtrMtw9foJ69AtjyaN/7dk5n3HPozsqdCEytr/eJ5GnB5woVh213zj5P4g6GXQ748Li+Dir1XJCH+sIfpIOBHRtUAT1bhnXj7syiV4ZxDogVhX4YTpyutFEBtdOjjYA36hyIQbOokWq9gntzloOmW9Hu2Nmo+wt/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFD6wlqr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFD6wlqr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94186C4CEF5
	for <acpica-devel@lists.linux.dev>; Tue, 12 Aug 2025 13:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755004364;
	bh=u1y83lzylh/onoHVhjG9k4+Kl2BBhLWMnEb7+R0ZrFg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aFD6wlqrzCS9QMpRbUoeQM6LQYA3uK2MTpTCZaYMfAxzKErdaYFV73GoViFQ19/QN
	 fRmlwXG9IQc5F17b7GdK7te+/8Uz6amRnr2aEKjBlXL63yn49nag7vqlhnp6jvk0p5
	 Xnjnrj9urTI/B2WGyYXOvH28wnF6xlPF84nw2uh0mBzFuh1PePkCOAA3uM3hDaBXm9
	 AeYfwA+oNI8bHHY6bU8KLa0qc/vFBDpK68jFzImsvT67hfn74YX2bqPPLBtmHEbkKN
	 O9zRK7Nw/lZBIWEW6FT2A0+vvr734Y1uncOlYNC5bZ3yQ4Eb+8xsQTRWLY1HKhMQrj
	 h61Cb7Mz7NoaQ==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-61990d3392cso2774084eaf.1
        for <acpica-devel@lists.linux.dev>; Tue, 12 Aug 2025 06:12:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWo5+SKomo/C8M5lWyOf0g+/G0zZFT4HtHWbYkpmMYyQRWDxj5tTfv0c4oRFN1telFiNQPiM3nd2S3XW6Y=@lists.linux.dev
X-Gm-Message-State: AOJu0YxlK+cliN08p38BIVIZMAG91iqgVnkjA49V4UYeLbegig2rjXO2
	mPbMsdi9rkPdpOvh8S+MWB03TZXuIqDfNh4HK+POgGpnuSwP2GwRJQM3unRYXX+cc3QDwcFh3cK
	Z0IMScPLnCeXms5z3lpnC5PLzpBcQ/6U=
X-Google-Smtp-Source: AGHT+IFnx2cMQ/xfCiNnv3WMRxLUHvCguIfYsfLVwwQNY/p63PZKGTDj5RgzE9c/IH7rX+sjYt79+8mN8y6JXDjf35c=
X-Received: by 2002:a05:6820:811:b0:61b:756e:b0ae with SMTP id
 006d021491bc7-61b7c305455mr8077339eaf.2.1755004363905; Tue, 12 Aug 2025
 06:12:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250806123821.381002-1-liaoyuanhong@vivo.com>
In-Reply-To: <20250806123821.381002-1-liaoyuanhong@vivo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Aug 2025 15:12:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hhVBEvFq6ggxbV421J_+w+d7bhbaJ=15W9oLvEDiXpsg@mail.gmail.com>
X-Gm-Features: Ac12FXwYz_QsR6m1wAtUCdQPhKAGi5wZ7oPxRe-4LTaiY-5MO1XTuOuDrIwNwfA
Message-ID: <CAJZ5v0hhVBEvFq6ggxbV421J_+w+d7bhbaJ=15W9oLvEDiXpsg@mail.gmail.com>
Subject: Re: [PATCH] acpi: Use swap() to simplify code
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	Len Brown <lenb@kernel.org>, 
	"open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <linux-acpi@vger.kernel.org>, 
	"open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <acpica-devel@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 2:38=E2=80=AFPM Liao Yuanhong <liaoyuanhong@vivo.com=
> wrote:
>
> Replace the original swapping logic with swap() to improve readability an=
d
> remove temporary variables
>
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  drivers/acpi/acpica/nsrepair2.c | 8 ++------

ACPICA changes need to be submitted as pull requests to the upstream
ACPICA project on GitHub.  Corresponding Linux patches can only be
applied after those changes have been accepted upstream (and those
patches need to point to the corresponding upstream ACPICA commits via
Link: tags).

Thanks!

>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepa=
ir2.c
> index 8dbb870f40d2..e3df5968165b 100644
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
> @@ -891,11 +890,8 @@ acpi_ns_sort_list(union acpi_operand_object **elemen=
ts,
>                               obj_desc2->integer.value))
>                             || ((sort_direction =3D=3D ACPI_SORT_DESCENDI=
NG)
>                                 && (obj_desc1->integer.value <
> -                                   obj_desc2->integer.value))) {
> -                               temp_obj =3D elements[j - 1];
> -                               elements[j - 1] =3D elements[j];
> -                               elements[j] =3D temp_obj;
> -                       }
> +                                   obj_desc2->integer.value)))
> +                               swap(elements[j], elements[j - 1]);
>                 }
>         }
>  }
> --
> 2.34.1
>
>
