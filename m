Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F3118FA02
	for <acpica-devel@lists.linux.dev>; Wed, 10 Jul 2024 11:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720611849; cv=none; b=DMeUHWj2mznjHsn2gKlb+4j+k6hkrTNluNKT7InNLsEYTnK9+uVj6iaAyz9+YB6+jKXVCRfsU4avrWI9Lc7kMQ0J9kcgInbTARTE4Ze9HDR65plfX9Dz70PfySSo6wVNcBlS7s+uZCVTe0V8ykmq9gCgOrDvHNMUTFrYUz6cdXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720611849; c=relaxed/simple;
	bh=GInUImvgEURMx4uz6lxWpkUxGam+DojfjB0upQp954I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BmGU9UKRtQn16M6NKtMp9/uDgnbehlQ8yy1/vFsrmraANQjrAFeDpEPeEjA9qLaUxN6W5NhGnHJgX0bM/ZerFeHVJGknVvRLxSdxQszc828tP75wHlNvpyUS0PMVlirKIXPQjReQnW7MODUsqi8hUzyBvQh71bCgYxnLWdX9Tn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHeJP201; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHeJP201"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76362C4AF07
	for <acpica-devel@lists.linux.dev>; Wed, 10 Jul 2024 11:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720611849;
	bh=GInUImvgEURMx4uz6lxWpkUxGam+DojfjB0upQp954I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dHeJP20177RaNg/Osm1PsRmOQe4sLfjFTV+Q8QbjpWV8cZpFhSHgmTPGt3CmnrS/7
	 FEwQ5rgOgY0C3eKDCS5ll/NxbTPkiktT0zUDlMc0zHd7cWKbIkHILzYXF6y8Y7WM7X
	 GtcH/vZXVLBfBpkztAjACjtTqbB7WUzPO9K0QfNSyFOWKLHA0NKhZvavi0BlYnYjfi
	 pnMRHZUP5Ir/lUbQLOUk/SCjWIHp3BDkAz6bTVRpwDtJpyuW0iNVloPP4t0cEeetDg
	 63uaMu+VBT5pB8XxwM8SsgbffF2Rt3r8YLhtt4IkvBJq8H2pVYNi1qKfKEcPx+bwjH
	 GJuSCIwZMxT9A==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d9dd8bc70dso31196b6e.2
        for <acpica-devel@lists.linux.dev>; Wed, 10 Jul 2024 04:44:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUej5PJlkGYuAZL1VNzkiCyf0erA7oOsvMbVK2KdfFxIzfBzCEnF3hZj7AWnXq+zuT9tITo66o/oJ3MIv8d2UO6LFGjDjJqOoumCPAi
X-Gm-Message-State: AOJu0YxO2B45yynDL/zewrBl1mcAqaM5ugo9iYuKEpGbLDTG/uGATfkZ
	MlcPTWssfGOFiV0TUggdyNG4JddttVbeWxUwaoggQ5YyjFL5f8RlTrDrs1p/NXI3mqegO7FFjfz
	JkZADWiZasnkeuDw1rQeLjmMaojg=
X-Google-Smtp-Source: AGHT+IFONFlDGqACq5VK0QgfJgq8g2wY016Po2bpccj0rG2PJVlPpT7CNzACWLDaebZTHByYi3xDIVbGmOy+25VQLBA=
X-Received: by 2002:a05:6820:2c05:b0:5c7:b587:40a7 with SMTP id
 006d021491bc7-5c7b58743aemr1328361eaf.1.1720611848685; Wed, 10 Jul 2024
 04:44:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240709-acpi-sysfs-groups-v2-0-058ab0667fa8@weissschuh.net>
In-Reply-To: <20240709-acpi-sysfs-groups-v2-0-058ab0667fa8@weissschuh.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Jul 2024 13:43:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iR4r6BFTd5fPEdoCVBv=c=HqyoV239Bd99tbO0gFihLw@mail.gmail.com>
Message-ID: <CAJZ5v0iR4r6BFTd5fPEdoCVBv=c=HqyoV239Bd99tbO0gFihLw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] ACPI: sysfs: manage sysfs attributes through
 device core
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Lance Ortiz <lance.ortiz@hp.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 10:38=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> Simplify the lifecycle of the sysfs attributes by letting the device
> core manage them.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
> Changes in v2:
> - Add fix to validate buffer type validation (patch 1)
> - Drop usage of devm-APIs as these are unusable for unbound devices
> - Evaluate _STR on each sysfs access
> - Link to v1: https://lore.kernel.org/r/20240613-acpi-sysfs-groups-v1-0-6=
65e0deb052a@weissschuh.net
>
> ---
> Thomas Wei=C3=9Fschuh (5):
>       ACPI: sysfs: validate return type of _STR method
>       ACPI: sysfs: evaluate _STR on each sysfs access
>       ACPI: sysfs: manage attributes as attribute_group
>       ACPI: sysfs: manage sysfs attributes through device core
>       ACPI: sysfs: remove return value of acpi_device_setup_files()
>
>  drivers/acpi/device_sysfs.c | 196 +++++++++++++++++++-------------------=
------
>  drivers/acpi/internal.h     |   3 +-
>  drivers/acpi/scan.c         |   6 +-
>  include/acpi/acpi_bus.h     |   1 -
>  4 files changed, 89 insertions(+), 117 deletions(-)
> ---

If this is not urgent, and I don't think it is, I'd rather defer it to
the 6.12 cycle (that is, I'd apply it after the upcoming 6.11 merge
window).

Thanks!
