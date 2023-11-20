Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F151C28B
	for <acpica-devel@lists.linux.dev>; Mon, 20 Nov 2023 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y83Nipqq"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-28396793876so2622551a91.3
        for <acpica-devel@lists.linux.dev>; Mon, 20 Nov 2023 07:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700493946; x=1701098746; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ST028Kw+5opFnctTC026fdT6iYVhh3htW2mHBCbv3rM=;
        b=y83NipqqQkzQY+dsqfbVYRGjSB+avdFa1S0uTdUKGxcXUkArtiMlOiLCF6DAAfgsUb
         zTr/gCPTrvOoeDUfMLJz4eD5Fwtcd69Keou8S6Sd/XIqQM6jM3mOQ1XKzzxVWRN91F1U
         mqW+kMGOvg60iAfpdN1J/NQXdhsOI3ax3eXDxRTdWsEPSUgjxSh3RZFELQCQ02nRl6GU
         pvFSJYrUkfAGdLS6fwCl5ZqsqG/aUDMQA/h2FBzXERPI+2eeW92BmrVNwt9rKA6f/aRe
         1qTQfl2H/v52s9+RO/elZArIyMa17gw0F+Bhhesbn0WWCtiRsp/x8ipPLt3FXEZ10Nym
         hPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700493946; x=1701098746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ST028Kw+5opFnctTC026fdT6iYVhh3htW2mHBCbv3rM=;
        b=gLFyWvbOUsuNUqEDJAcGH0yqEla/kvMfwR9g7ex7eSXutQT7/iXLQaCdV2o2XC3MIs
         qoGkhEuSyAQpJrZl4w7IsSFPZVg+P87CBBF7vQWWeKLU597lrZ8rhHYosGbw4SPaE8YS
         yJPWMbTl2lfg46SDozmy2csG7huiqxEaO2fafI6e0R3Bp77cFSl+AkcSqggRSaJfJn15
         x/9z0PB+hiYlBCIezlmLE/oMmFswo5KB3i1WP5POiS50Zgi9koNxLIIMeevvr1lg01mN
         9EW3AERxKv7y5ceZGNxqyoAnRJ8KXD0QR8bUByZgdYVaalC2X6KF2SQuWGElEyeiyq/5
         Tt3w==
X-Gm-Message-State: AOJu0YztApPG1repzJLcxvK3mmJmDIYqFBJG67viY1bK9FuCzz7KOchX
	geaRarWfVQTgpB9Y3p6WbNjhz1lHkJzWqx7lwIpEfg==
X-Google-Smtp-Source: AGHT+IGZ24BmTxFlV8ARS0eiBOVZL6XuY7FDIhzbJcGWCamZieGWAK8UG+n6P3hSBpS7YfkOpYF8HB8uorYNx0Elgz8=
X-Received: by 2002:a17:90b:4f81:b0:27d:d36:763b with SMTP id
 qe1-20020a17090b4f8100b0027d0d36763bmr5505892pjb.31.1700493946018; Mon, 20
 Nov 2023 07:25:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231114-arm-build-bug-v1-1-458745fe32a4@linaro.org>
 <b2354c21-3a1a-c446-fee0-db0c78d05c71@gmail.com> <CACRpkdYUzYxV+NY=mymXP59mt9msTUvSXM__f+4qRM+_xjX0Nw@mail.gmail.com>
In-Reply-To: <CACRpkdYUzYxV+NY=mymXP59mt9msTUvSXM__f+4qRM+_xjX0Nw@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 20 Nov 2023 09:25:34 -0600
Message-ID: <CAPLW+4mT5Qpo+B7fSfiG1qRVr4cSvuWhArpu-3kbFtSukSV8_w@mail.gmail.com>
Subject: Re: [PATCH] ACPI: acenv: Permit compilation from within the kernel
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Sam Edwards <cfsworks@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams <dan.j.williams@intel.com>, 
	Hanjun Guo <guohanjun@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Tue, Nov 14, 2023 at 2:20=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> On Tue, Nov 14, 2023 at 7:09=E2=80=AFPM Sam Edwards <cfsworks@gmail.com> =
wrote:
>
> > I am not an ACPI subsystem maintainer, but my understanding is that the
> > files in include/acpi/ are copied verbatim from ACPICA, so any change t=
o
> > those files will have to be sent to the ACPICA project and wouldn't be
> > accepted here.
> >
> > More likely, we'd want to do something about the circular-include
> > situation between linux/fw_table.h<->linux/acpi.h.
>
> I agree but I have no idea how to fix that really, should I just send
> a revert instead so the authors can get some time to figure it out?
>

Just want to confirm that linux-mainline and linux-next builds are
broken for my ARM64 board as well, because of the commit you
pin-pointed. I vote for reverting it and letting the author rework it
properly. On a side note: I'm surprised there are no bots or automatic
CI builds out there testing the kernel builds with baremetal
toolchains. Can't believe everyone's using Linux toolchain, the kernel
is supposed to be baremetal project.

> Yours,
> Linus Walleij
