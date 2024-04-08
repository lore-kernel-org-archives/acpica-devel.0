Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EAE12DD94;
	Mon,  8 Apr 2024 14:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585947; cv=none; b=jDKtG8N7eYJ+u5C9zNG4urjuveB2U1OmqjK4D8i9IKmTdarGognYIkQ5PCRPXEBxtFyVgN795KUjmw9hNsSkrb16+TgbX1jz6QJSpTakrr9YGZFZ31lO624n+AfJNrun/4IhIL6B6TZsNu6oiq5/ggrN9Rj6ypNnCadjayJn/gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585947; c=relaxed/simple;
	bh=fCohwsfER8OLWfZl6LReGaQxXONj5RyinO1IgQBzs1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LeIP1ZqvXdyUa/hZ7Do6hmea6oYfk45uRxEGl2DzWCH6bE2/aoBcsZMqICV4PbPOIIt/zF1EcOvsAJBKL5iiDn3J2T7HweO4YOkW9Y4A03aTB3U+84vm2KXGM/Kw9GLPk1ZF9udv/SpoBV8LYikec5YsOxV2euXrkf2WKdVXLPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUGFi/YM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUGFi/YM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8772C433A6;
	Mon,  8 Apr 2024 14:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712585946;
	bh=fCohwsfER8OLWfZl6LReGaQxXONj5RyinO1IgQBzs1s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TUGFi/YM8gQSXAdKgMg9uMImfJ9pFr4J1BwQGC94uJaWyxn5itekO7PKA0SOCkcEr
	 QA1VPSa4wvslrYn9vTSnW0EVFIanPL08HsVca7vSI9husMuO9arD8ocD6EQnzFETmf
	 ksWAANdxnCkmOLHmrI6mO1VYhzYnkCehSOhb8tgukA/HapUYG2wm9kLJdPZyWx5ziM
	 onUQBvdhF3eA9tBBfibtluCkIRkLz1dqefrOixMYQAZ8eVa7KryggECPnAlJmn4rg4
	 p85ddRL+1iLruCT+0p97PQPdoRaPAkKby25KaOT07INHT9Z6ZzRDm1QnLmv0B0OGn9
	 XEvf7acmBnFRQ==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c3db6798f6so23751b6e.0;
        Mon, 08 Apr 2024 07:19:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWUPTK2ZGvSY39xFcFKBnNDSxvWYsjAeiaDGaTEq2RHWu8XouiU+47Ri8m7KyZDTrdSTy+RWVTVVvDMl1oYPAzylmeWK5UWzSbfPgSfhKYG6SLXHffjrQ6BFnT68mywDEi0BTdh1Eqz82Cfykoj
X-Gm-Message-State: AOJu0YxURO8nMX2hKGvo0GAJW51dYz5pPpG977uQki1BNYJOEpYTvTf3
	kygTHdxwMSKkUG/j/cRVI6/V7wDs66y9J29S4hY23k1kM63UeRVRUrCa4IrphZ0r/Is3CoEGE2r
	drFL/Sv+vFWNL+dkK7ob5CRQfCrQ=
X-Google-Smtp-Source: AGHT+IE2cd5MIHpLilsMOefxnD7lqhVeZau5m81/yoSXqMyOs4mTHwzl+84AR6mEi+xDVYbCBwtZjPGYOY8LlCssj9M=
X-Received: by 2002:a05:6808:138e:b0:3c5:eab3:657 with SMTP id
 c14-20020a056808138e00b003c5eab30657mr5718403oiw.4.1712585945878; Mon, 08 Apr
 2024 07:19:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: acpica-devel@lists.linux.dev
List-Id: <acpica-devel.lists.linux.dev>
List-Subscribe: <mailto:acpica-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:acpica-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240328-b4-module-owner-acpi-v2-0-1e5552c2c69f@linaro.org>
In-Reply-To: <20240328-b4-module-owner-acpi-v2-0-1e5552c2c69f@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Apr 2024 16:18:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jd7FegkcnJyDn61uBEdGRKHWoaQ8SKJE+JX18W0QHh1Q@mail.gmail.com>
Message-ID: <CAJZ5v0jd7FegkcnJyDn61uBEdGRKHWoaQ8SKJE+JX18W0QHh1Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] ACPI: store owner from modules with acpi_bus_register_driver()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Benson Leung <bleung@chromium.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, Corentin Chary <corentin.chary@gmail.com>, 
	"Luke D. Jones" <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Matan Ziv-Av <matan@svgalib.org>, Mattia Dongili <malattia@linux.it>, 
	Azael Avalos <coproscefalo@gmail.com>, Ajay Kaher <akaher@vmware.com>, 
	Alexey Makhalov <amakhalov@vmware.com>, VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, 
	Richard Cochran <richardcochran@gmail.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-input@vger.kernel.org, 
	netdev@vger.kernel.org, chrome-platform@lists.linux.dev, 
	platform-driver-x86@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 8:49=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Changes in v2:
> - Correct input and platform/chrome subjects.
> - Add acks.
> - Link to v1: https://lore.kernel.org/r/20240327-b4-module-owner-acpi-v1-=
0-725241a2d224@linaro.org
>
> Merging
> =3D=3D=3D=3D=3D=3D=3D
> All further patches depend on the first amba patch, therefore one way is
> to ack and take it via one tree, e.g. ACPI.
>
> Description
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Modules registering driver with acpi_bus_register_driver() often forget t=
o
> set .owner field.
>
> Solve the problem by moving this task away from the drivers to the core
> amba bus code, just like we did for platform_driver in commit
> 9447057eaff8 ("platform_device: use a macro instead of
> platform_driver_register").
>
> Best regards,
> Krzysztof
>
> ---
> Krzysztof Kozlowski (19):
>       ACPI: store owner from modules with acpi_bus_register_driver()
>       Input: atlas - drop owner assignment
>       net: fjes: drop owner assignment
>       platform/chrome: wilco_ec: drop owner assignment
>       platform: asus-laptop: drop owner assignment
>       platform: classmate-laptop: drop owner assignment
>       platform/x86/dell: drop owner assignment
>       platform/x86/eeepc: drop owner assignment
>       platform/x86/intel/rst: drop owner assignment
>       platform/x86/intel/smartconnect: drop owner assignment
>       platform/x86/lg-laptop: drop owner assignment
>       platform/x86/sony-laptop: drop owner assignment
>       platform/x86/toshiba_acpi: drop owner assignment
>       platform/x86/toshiba_bluetooth: drop owner assignment
>       platform/x86/toshiba_haps: drop owner assignment
>       platform/x86/wireless-hotkey: drop owner assignment
>       ptp: vmw: drop owner assignment
>       virt: vmgenid: drop owner assignment
>       ACPI: drop redundant owner from acpi_driver
>
>  drivers/acpi/bus.c                        | 9 +++++----
>  drivers/input/misc/atlas_btns.c           | 1 -
>  drivers/net/fjes/fjes_main.c              | 1 -
>  drivers/platform/chrome/wilco_ec/event.c  | 1 -
>  drivers/platform/x86/asus-laptop.c        | 1 -
>  drivers/platform/x86/classmate-laptop.c   | 5 -----
>  drivers/platform/x86/dell/dell-rbtn.c     | 1 -
>  drivers/platform/x86/eeepc-laptop.c       | 1 -
>  drivers/platform/x86/intel/rst.c          | 1 -
>  drivers/platform/x86/intel/smartconnect.c | 1 -
>  drivers/platform/x86/lg-laptop.c          | 1 -
>  drivers/platform/x86/sony-laptop.c        | 2 --
>  drivers/platform/x86/toshiba_acpi.c       | 1 -
>  drivers/platform/x86/toshiba_bluetooth.c  | 1 -
>  drivers/platform/x86/toshiba_haps.c       | 1 -
>  drivers/platform/x86/wireless-hotkey.c    | 1 -
>  drivers/ptp/ptp_vmw.c                     | 1 -
>  drivers/virt/vmgenid.c                    | 1 -
>  include/acpi/acpi_bus.h                   | 8 ++++++--
>  19 files changed, 11 insertions(+), 28 deletions(-)
> ---

Whole series applied as 6.10 material, thanks!
