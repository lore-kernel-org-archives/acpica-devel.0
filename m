Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9023F158855
	for <acpica-devel@lists.linux.dev>; Mon,  6 May 2024 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715017519; cv=none; b=H6+QSChSFT/JU98hjnjVLiUP4wT9ZHM/F8p+A9QLbUxWeA4cdMqIIgLceIn/jQzsqnAmzjmY1U/Po6j/qKoietZX2Ic3jCT4LBXCw5pCv2KNlq2GgdYObTcdQB4FKSzNgQfjcadMOhROp7sPXVjm+taVEtqGgMYBpxDTCWhKakw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715017519; c=relaxed/simple;
	bh=LPcCtbeAnsLOce7SfLflgIRodnJTarAfZQXME5YiTAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kY5Kjqps0e2SR2fRXvW+tafTebfTvH7q2ic1tW6GQ8egeBt7cLDaDTFVjr8k3+M4eYF6nwU7TqBgNjnK4hMPr0Emijfh9H5YFv+4wZUYyJY2qFp0xMLaI156DoQ6HIHbE0PClmyo5QbJUTCtiCHPyp41Lj8rd6Si/hsv473BYwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nzuw48B3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nzuw48B3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34446C116B1
	for <acpica-devel@lists.linux.dev>; Mon,  6 May 2024 17:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715017519;
	bh=LPcCtbeAnsLOce7SfLflgIRodnJTarAfZQXME5YiTAs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Nzuw48B3+Ov7P3zgNJ1xoeAHHhkuOIMIzLYT/YZFM2Ly4TCRRPrreIjgX++9X9cgQ
	 dONjBVWu3nLhNg7Q3AEbDG702ERH0viSW3+GWHGacFp5k//Ql9LDbYKJFhKZyjhB1t
	 dTroINkkOS29eJP1ZiSmntoKUlSe5pXUlUC4pwy5yLDwy+S9cSrQoV8brZ84HgFMXn
	 jtrgKHa1aqJXI030tYjFbjV2SJuyIJR+oEARBgJK3oIL3Fnc3nQYgplcG9ADMmwspt
	 Vfv6J6DQe2tG7ewvihYqYGkjkPt2UMmexx1K4FJQUgRzfl9V+tN38Inow6gwmAfiUI
	 p6e7mGmh3W3xQ==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5b209a2c390so254690eaf.1
        for <acpica-devel@lists.linux.dev>; Mon, 06 May 2024 10:45:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUh/m300ObeMq1bhMxoOEKSebau1nz4CLc0MJSihmdoyAgoxUhY1G4M1KSHFOHTc1BShqU74D8qyVhLJRrBGUCftKcAeJS8DSS/MXI4
X-Gm-Message-State: AOJu0Yy8AJ+k6ftenI2LFjmavU5Uyk9ohYGPBMQA8U0CmKP5n7nFj8Mb
	7++vlYc1rXLcKCVEsU9lX2DnprrpWamIRPORLIfdpze+QL0IB1VOX/Z43GkAS0+KkOlydvTLM3j
	BFWTyfgz6hgV2/arg+Om30IcL/9A=
X-Google-Smtp-Source: AGHT+IHYxcQAPMwxIPGVeIPuycwWU3imOMOSR1h1lHNwGaojIQ6HmxdIYOS+hyQpxHTmfRbPl5z/GR0OoTZFiSMHd4Q=
X-Received: by 2002:a4a:601:0:b0:5aa:241a:7f4b with SMTP id
 1-20020a4a0601000000b005aa241a7f4bmr11037084ooj.1.1715017518502; Mon, 06 May
 2024 10:45:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <Zi+0whTvDbAdveHq@kuha.fi.intel.com>
In-Reply-To: <Zi+0whTvDbAdveHq@kuha.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 6 May 2024 19:45:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iAMG251n6yg-h6KCUywK2vSg4sX3FTnOuxcLaEvUwFPQ@mail.gmail.com>
Message-ID: <CAJZ5v0iAMG251n6yg-h6KCUywK2vSg4sX3FTnOuxcLaEvUwFPQ@mail.gmail.com>
Subject: Re: Missing default handler for the EmbeddedControl OpRegion
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 29, 2024 at 4:55=E2=80=AFPM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi,
>
> There's a bug that is caused by an EmbeddedControl OpRegion which is
> declared inside the scope of a specific USB Type-C device (PNP0CA0):
> https://bugzilla.kernel.org/show_bug.cgi?id=3D218789

And in this bug you are essentially proposing to install the EC
OpRegion handler at the namespace root instead of the EC device.

This sounds reasonable, although AFAICS this is a matter of modifying
the EC driver (before the EC OpRegion handler is installed by the EC
drvier, ACPICA has no way to handle EC address space accesses anyway).

> It looks like that's not the only case where that OpRegion ID is used
> outside of the EC device scope. There is at least one driver in Linux
> Kernel (drivers/platform/x86/wmi.c) that already has a custom handler
> for the EmbeddedControl OpRegion, and based on a quick search, the
> problem "Region EmbeddedControl (ID=3D3) has no handler" has happened
> with some other devices too.

AFAICS, installing the EC address space handler at the EC device
object itself is not based on any sound technical arguments, it's just
been always done this way in Linux.  It's quite possible that the EC
address space handler should have been installed at the namespace root
from the outset.

Thanks!
